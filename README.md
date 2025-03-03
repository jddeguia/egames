# MoM and YoY analysis of Betting Data (Egames)


## Setup
The process involved in the project is shown in the image below
![image](https://github.com/user-attachments/assets/6111c7ab-67f7-4ae0-bc54-beda27f34e16)
- We clean the given CSV file to make it compatible in dbt environment
- We load the given CSV file and use dbt seed to load it on a dbt project
- We transform the CSV file into medallion layers (base, staging, and mart model)
- We test the transformed model using a Python script that connects to DuckDB
- We export the tables as CSV files and use those files as a data source on Looker Studio (the dashboard platform used)

## Dashboard
The output of the assessment is a dashboard. 

It can be accessed on this dashboard link

[Dashboard](https://lookerstudio.google.com/reporting/87cc1617-b2be-4219-8094-064c82b2439c)

This is a screenshot of the dashboard for order analysis


The dashboard contains the following charts
- YoY and MoM analysis of profitability in terms of domain, region, and sports
- Exploratory Data Analysis 

## Data Lineage
This is the data lineage of the models involved in the dashboard
![image](https://github.com/user-attachments/assets/5b7b97fa-bc14-46d3-8b40-4940cde974af)


So the philosophy of the data modelling is
- expose the data source in dbt project (base layer)
- clean the column and explicitly cast the appropriate data type on each column (staging layer)
- expose the end result of the cleaned model to end users (mart model)

The SQL files and Python scripts used in this project can be accessed in this link

[SQL and Python files](https://github.com/jddeguia/egames/tree/main/egames_data_platform)
