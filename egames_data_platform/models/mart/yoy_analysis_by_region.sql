{{
    config(
      materialized='table'
    )
}}

WITH yearly_data AS (
    SELECT
        year,
        region,
        SUM(turnover) AS total_turnover,
        SUM(profit) AS total_profit
    FROM {{ ref('mart_egames') }}
    GROUP BY region, year
),

yoy_comparison AS (
    SELECT
        *,
        LAG(total_turnover) OVER (PARTITION BY region ORDER BY year) AS prev_year_turnover,
        LAG(total_profit) OVER (PARTITION BY region ORDER BY year) AS prev_year_profit
    FROM yearly_data
)

SELECT 
    year,
    region,
    total_turnover,
    total_profit,
    prev_year_turnover,
    prev_year_profit,
    ROUND((total_turnover - prev_year_turnover) / NULLIF(prev_year_turnover, 0) * 100, 2) AS yoy_turnover_pct,
    ROUND((total_profit - prev_year_profit) / NULLIF(prev_year_profit, 0) * 100, 2) AS yoy_profit_pct,
    CASE 
        WHEN ROUND((total_profit - prev_year_profit) / NULLIF(prev_year_profit, 0) * 100, 2) > 500 
          OR ROUND((total_profit - prev_year_profit) / NULLIF(prev_year_profit, 0) * 100, 2) < -500 
        THEN 'Anomaly'
        ELSE 'Normal'
    END AS profit_anomaly_flag
FROM yoy_comparison
ORDER BY year


