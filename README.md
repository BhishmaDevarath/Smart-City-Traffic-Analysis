# 🚦 Smart City Traffic Analysis

A data-driven analysis of **Bangalore traffic patterns** using **SQL Server** for data cleaning & transformation and **Power BI** for interactive dashboards.  
This project explores traffic congestion, accident risks, weather impact, and sustainable transport insights.

---

## 📌 Project Overview
Urban traffic is one of the biggest challenges in modern cities. This project demonstrates how data can be leveraged to:
- Analyze daily and area-wise traffic patterns  
- Identify peak congestion times and accident risks  
- Study the impact of weather conditions on traffic flow  
- Compare public transport & pedestrian usage with road traffic  

---

## 🛠️ Tools & Technologies
- **SQL Server** → Data import, cleaning, feature engineering  
- **VS Code** → Writing and executing SQL queries  
- **Power BI** → Dashboard creation and visualization  
- **Excel** → Preprocessing (date formatting, decimals, corrections)  

---

## 🧹 Data Preparation
Steps performed in SQL Server:
1. **Data Cleaning**  
   - Removed duplicates & null values  
   - Standardized date format (`yyyy-mm-dd`)  
   - Limited decimals for numeric fields  

2. **Feature Engineering**  
   - `DayOfWeek` → Derived from date  
   - `CongestionCategory` → Low / Medium / High  
   - `PeakHour` flag → Morning & Evening rush  
   - `CongestionScore` → Combined volume, speed, incidents  
   - `AccidentRisk` → Based on incidents & weather conditions  
   - `WeatherGroup` → Standardized weather categories  
   - `Utilization` → Road usage status  

3. **Summary Tables**  
   - `Traffic_DailySummary` → Daily aggregated stats  
   - `Traffic_AreaSummary` → Area-wise congestion and risk  

---

## 📊 Dashboard Preview

### 1️⃣ Traffic Overview
![Traffic Overview](./PowerBI%20Dashboard/Traffic%20Overview.jpeg)

### 2️⃣ Area Insights
![Area Insights](./PowerBI%20Dashboard/Area%20Insights.jpeg)

### 3️⃣ Risk & Weather
![Risk & Weather](./PowerBI%20Dashboard/Risk%20&%20Weather.jpeg)

### 4️⃣ Public Transport & Pedestrians
![Public Transport & Pedestrians](./PowerBI%20Dashboard/Public%20Transport%20&%20Pedestrians.jpeg)

---

## 📈 Dashboard Insights
- **Traffic Peaks** → Highest congestion during weekday rush hours  
- **Weather Impact** → Rainy conditions reduce speed and raise risk  
- **Area Congestion** → Certain hotspots show critical congestion  
- **Accident Risk** → Strongly linked to incidents + weather  
- **Public Transport** → Higher usage reduces road volume pressure  

---

## 🚀 How to Run
1. Import dataset into **SQL Server**  
2. Run cleaning & transformation scripts from `SQL/` folder  
3. Connect Power BI to SQL Server database  
4. Recreate visuals or use the provided dashboard image  

---

## 🤝 Contribution
Contributions, suggestions, and improvements are welcome! Fork the repo and submit pull requests.

---

## 📜 License
This project is licensed under the **MIT License**.
