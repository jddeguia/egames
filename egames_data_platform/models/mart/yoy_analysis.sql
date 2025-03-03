{{
    config(
      materialized='table'
    )
}}


WITH regional_summary AS (
  SELECT 
    DATE_TRUNC('month', record_date) AS month_date,  -- ✅ Fix applied here
    region,
    SUM(turnover) AS total_turnover,
    SUM(profit) AS total_profit
  FROM your_table
  GROUP BY month_date, region
),

yoy_analysis AS (
  SELECT 
    *,
    LAG(total_turnover, 12) OVER (PARTITION BY region ORDER BY month_date) AS prev_year_turnover,
    LAG(total_profit, 12) OVER (PARTITION BY region ORDER BY month_date) AS prev_year_profit,

    ROUND(
      (total_turnover - LAG(total_turnover, 12) OVER (PARTITION BY region ORDER BY month_date)) 
      / NULLIF(LAG(total_turnover, 12) OVER (PARTITION BY region ORDER BY month_date), 0) * 100, 2
    ) AS yoy_turnover_growth,

    ROUND(
      (total_profit - LAG(total_profit, 12) OVER (PARTITION BY region ORDER BY month_date)) 
      / NULLIF(LAG(total_profit, 12) OVER (PARTITION BY region ORDER BY month_date), 0) * 100, 2
    ) AS yoy_profit_growth

  FROM regional_summary
)

SELECT * FROM yoy_analysis
ORDER BY month_date
