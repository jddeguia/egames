# Data Modelling using DBT

## Models

![image](https://github.com/user-attachments/assets/5b7b97fa-bc14-46d3-8b40-4940cde974af)

The models are separated into 3 layers
- base layer. This is where we expose the data source in dbt project. The name of the model is `base_egames.sql`
- staging layer. This is where we clean the column and explicitly cast the appropriate data type on each column. The name of the model is `stg_egames.sql`
- mart layer. This is where we expose the end result of the cleaned model to end users. We used 6 mart models for yoy and mom analysis (per domain, sport, and region). 

## Test the models
- We have a Python script named `run_duckdb.py` that exports the mart model as a CSV. We use CSV as a data source on our dashboard

## Insights

