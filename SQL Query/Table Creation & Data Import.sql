--Table Creation
CREATE TABLE TrafficData (
    Dates DATE,
    AreaName NVARCHAR(100),
    RoadIntersectionName NVARCHAR(150),
    TrafficVolume INT,
    AverageSpeed FLOAT,
    TravelTimeIndex FLOAT,
    CongestionLevel FLOAT,
    RoadCapacityUtilization FLOAT,
    IncidentReports INT,
    EnvironmentalImpact FLOAT,
    PublicTransportUsage FLOAT,
    TrafficSignalCompliance FLOAT,
    ParkingUsage FLOAT,
    PedestrianCyclistCount INT,
    WeatherConditions NVARCHAR(50),
    RoadworkConstructionActivity NVARCHAR(50)
);

--Data Import
BULK INSERT TrafficData
FROM 'D:\Downloads\Bangalore Traffic Dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, -- Skips header row
    FIELDTERMINATOR = ',', -- CSV separator
    ROWTERMINATOR = '\n',
    TABLOCK
);

--Check the table
SELECT * FROM TrafficData;