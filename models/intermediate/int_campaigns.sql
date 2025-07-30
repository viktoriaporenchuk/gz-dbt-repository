{{ config(
    materialized='table'
) }}

WITH adwords AS (
    SELECT
        date_date AS date,
        campaign_key,
        campaing_name,
        CAST(ads_cost AS FLOAT64) AS ads_cost,
        'adwords' AS source
    FROM {{ ref('stg_raw__adwords') }}
),

bing AS (
    SELECT
        date_date AS date,
        campaign_key,
        campaing_name,
        CAST(ads_cost AS FLOAT64) AS ads_cost,
        'bing' AS source
    FROM {{ ref('stg_raw__bing') }}
),

criteo AS (
    SELECT
        date_date AS date,
        campaign_key,
        campaing_name,
        CAST(ads_cost AS FLOAT64) AS ads_cost,
        'criteo' AS source
    FROM {{ ref('stg_raw__criteo') }}
),

facebook AS (
    SELECT
        date_date AS date,
        campaign_key,
        campaing_name,
        CAST(ads_cost AS FLOAT64) AS ads_cost,
        'facebook' AS source
    FROM {{ ref('stg_raw__facebook') }}
)

SELECT * FROM adwords
UNION ALL
SELECT * FROM bing
UNION ALL
SELECT * FROM criteo
UNION ALL
SELECT * FROM facebook
