{{
    config(
      materialized='table'
    )
}}

WITH monthly_data AS (
    SELECT
        year,
        month_number,
        region,
        SUM(turnover) AS total_turnover,
        SUM(profit) AS total_profit
    FROM {{ ref('stg_egames') }}
    GROUP BY region, year, month_number
),

mom_comparison AS (
    SELECT
        *,
        LAG(total_turnover) OVER (PARTITION BY region ORDER BY year, month_number) AS prev_month_turnover,
        LAG(total_profit) OVER (PARTITION BY region ORDER BY year, month_number) AS prev_month_profit
    FROM monthly_data
)

SELECT 
    year,
    month_number,
    region,
    total_turnover,
    total_profit,
    prev_month_turnover,
    prev_month_profit,
    ROUND((total_turnover - prev_month_turnover) / NULLIF(prev_month_turnover, 0) * 100, 2) AS mom_turnover_pct,
    ROUND((total_profit - prev_month_profit) / NULLIF(prev_month_profit, 0) * 100, 2) AS mom_profit_pct,
    CASE 
        WHEN ROUND((total_profit - prev_month_profit) / NULLIF(prev_month_profit, 0) * 100, 2) > 500 
          OR ROUND((total_profit - prev_month_profit) / NULLIF(prev_month_profit, 0) * 100, 2) < -500 
        THEN 'Anomaly'
        ELSE 'Normal'
    END AS profit_anomaly_flag
FROM mom_comparison
ORDER BY year, month_number