--Check the Data
SELECT TOP 10 * FROM TrafficData;

--Remove Duplicates
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Dates, AreaName, RoadIntersectionName, TravelTimeIndex
               ORDER BY (SELECT NULL)
           ) AS rn
    FROM TrafficData
)
DELETE FROM CTE WHERE rn > 1;

--Handle Missing / Null Values
SELECT 
    SUM(CASE WHEN TrafficVolume IS NULL THEN 1 ELSE 0 END) AS MissingVolume,
    SUM(CASE WHEN AverageSpeed IS NULL THEN 1 ELSE 0 END) AS MissingSpeed,
    SUM(CASE WHEN CongestionLevel IS NULL THEN 1 ELSE 0 END) AS MissingCongestion,
    SUM(CASE WHEN WeatherConditions IS NULL THEN 1 ELSE 0 END) AS MissingWeather
FROM TrafficData;

-- Replace missing Average Speed with overall mean
UPDATE TrafficData
SET AverageSpeed = (SELECT AVG(AverageSpeed) FROM TrafficData)
WHERE AverageSpeed IS NULL;

-- Replace missing Weather with 'Unknown'
UPDATE TrafficData
SET WeatherConditions = 'Unknown'
WHERE WeatherConditions IS NULL;

-- Add Day of Week
ALTER TABLE TrafficData ADD DayOfWeek VARCHAR(20);
UPDATE TrafficData
SET DayOfWeek = DATENAME(WEEKDAY, Dates);

-- Add Congestion Category
ALTER TABLE TrafficData ADD CongestionCategory VARCHAR(20);
UPDATE TrafficData
SET CongestionCategory = 
    CASE 
        WHEN CongestionLevel < 0.3 THEN 'Low'
        WHEN CongestionLevel BETWEEN 0.3 AND 0.7 THEN 'Medium'
        ELSE 'High'
    END;

--Sanity Checks
SELECT TOP 10 Dates, AreaName, TrafficVolume, AverageSpeed, CongestionLevel, 
       DayOfWeek, CongestionCategory, WeatherConditions
FROM TrafficData;

--Peak Hour Indicator
ALTER TABLE TrafficData ADD PeakHour BIT;
UPDATE TrafficData
SET PeakHour = CASE 
                  WHEN DATEPART(HOUR, CAST(Dates AS DATETIME)) BETWEEN 7 AND 10 
                       OR DATEPART(HOUR, CAST(Dates AS DATETIME)) BETWEEN 17 AND 20 
                  THEN 1 
                  ELSE 0 
               END;

--Congestion Score
ALTER TABLE TrafficData ADD CongestionScore FLOAT;
UPDATE TrafficData
SET CongestionScore = 
      (ISNULL(TrafficVolume, 0) * 1.0) / NULLIF(AverageSpeed, 0);

--Accident Risk Index
ALTER TABLE TrafficData ADD AccidentRisk FLOAT;
UPDATE TrafficData
SET AccidentRisk = 
      ISNULL(IncidentReports,0) * (1 + CongestionLevel);

--Weather Normalization
ALTER TABLE TrafficData ADD WeatherGroup VARCHAR(20);
UPDATE TrafficData
SET WeatherGroup = 
    CASE 
        WHEN WeatherConditions LIKE '%Rain%' THEN 'Rainy'
        WHEN WeatherConditions LIKE '%Clear%' OR WeatherConditions LIKE '%Sunny%' THEN 'Clear'
        WHEN WeatherConditions LIKE '%Cloud%' THEN 'Cloudy'
        WHEN WeatherConditions LIKE '%Fog%' OR WeatherConditions LIKE '%Mist%' THEN 'Foggy'
        ELSE 'Other'
    END;

--Road Utilization Status
ALTER TABLE TrafficData ADD UtilizationStatus VARCHAR(20);
UPDATE TrafficData
SET UtilizationStatus =
    CASE
        WHEN RoadCapacityUtilization < 0.4 THEN 'Under Utilized'
        WHEN RoadCapacityUtilization BETWEEN 0.4 AND 0.8 THEN 'Optimal'
        ELSE 'Over Utilized'
    END;

--Summary Tables for Power BI
--Daily Summary
SELECT 
    Dates,
    AVG(TrafficVolume) AS AvgTrafficVolume,
    AVG(AverageSpeed) AS AvgSpeed,
    AVG(CongestionLevel) AS AvgCongestion,
    SUM(IncidentReports) AS TotalIncidents
INTO Traffic_DailySummary
FROM TrafficData
GROUP BY Dates;

--Area-Wise Summary
SELECT 
    AreaName,
    AVG(TrafficVolume) AS AvgTrafficVolume,
    AVG(AverageSpeed) AS AvgSpeed,
    COUNT(DISTINCT RoadIntersectionName) AS NumIntersections,
    SUM(IncidentReports) AS TotalIncidents
INTO Traffic_AreaSummary
FROM TrafficData
GROUP BY AreaName;