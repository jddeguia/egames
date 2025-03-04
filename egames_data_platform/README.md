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
- Looking at the bar chart, South Korea has the highest YoY turnover growh (77.77%), while Italy has the largest decline (-55.37%) 
- Looking at the scatter plot, SK had the highest turnover and profit, indicating a strong revenue and profitability
- Russia an CIS hasd turnover growth but profit declined. Russia & CIS faces profitability challenges despite revenue growth.
- Rest of the word has declined turnover but Canada showed resilience (14.88% turnover, 6.01% profit)
- Italy, Rest of Asia, and Nordic struggled, showing major drops in turnover and profit.
