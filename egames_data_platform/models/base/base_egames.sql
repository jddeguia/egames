{{
    config(
      materialized='table'
    )
}}

{%- set columns = adapter.get_columns_in_relation(ref('cleaned_risk_data')) -%}

WITH change_columns AS (
    SELECT
        {%- for column in columns -%}
            {%- if not loop.first %} {% endif %}
            cast("{{ column.name }}" AS VARCHAR) AS "{{ column.name | lower | replace(' ', '_') | replace('-', '_') }}"
            {%- if not loop.last %}, {% endif %}
        {%- endfor %}
    FROM {{ ref('cleaned_risk_data') }}
)

SELECT 
    month,
    domain,
    region,
    sport,
    league,
    turnover,
    profit
FROM change_columns