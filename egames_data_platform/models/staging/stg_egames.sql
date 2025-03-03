{{
    config(
      materialized='table'
    )
}}

{% set column_types = {
    'league': 'string',
    'sport': 'string',
    'region': 'string',
    'domain': 'string',
    'turnover': 'float',
    'profit': 'float',
    'month': 'date'
} %}

{% set columns = ['league', 'sport', 'region', 'domain', 'turnover', 'profit', 'month'] %}

WITH egames_base AS (
    SELECT * 
    FROM {{ ref('base_egames') }}
),

cast_data_type AS (
    SELECT
        {% for column in columns %}
            {% set data_type = column_types[column] %}
            {% if loop.index > 1 %}, {% endif %}
            {% if data_type == 'string' %}
                CAST({{ column }} AS VARCHAR) AS {{ column }}
            {% elif data_type == 'integer' %}
                CAST({{ column }} AS INT) AS {{ column }}
            {% elif data_type == 'float' %}
                CAST({{ column }} AS FLOAT) AS {{ column }}
            {% elif data_type == 'date' %}
                TRY_CAST(STRPTIME({{ column }}, '%m/%d/%Y') AS DATE) AS {{ column }}
            {% else %}
                {{ column }} AS {{ column }}
            {% endif %}
        {% endfor %}
    FROM egames_base
)

SELECT 
    month as record_date,
    DATE_TRUNC('month', month) AS month_date,
    EXTRACT(MONTH FROM month) AS month_number,
    EXTRACT(DAY FROM month) AS day,
    EXTRACT(YEAR FROM month) AS year,
    EXTRACT(WEEK FROM month) AS week_number,
    league,
    sport,
    region,
    domain,
    turnover,
    profit
FROM cast_data_type