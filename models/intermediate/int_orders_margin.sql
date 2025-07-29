WITH base AS (
    SELECT *
    FROM {{ ref('int_sales_margin') }}
),
aggregated AS (
    SELECT
        orders_id,
        MAX(date_date) AS date_date,  -- or MIN(), assuming all rows have same date
        SUM(revenue) AS revenue,
        SUM(quantity) AS quantity,
        SUM(purchase_cost) AS purchase_cost,
        SUM(margin) AS margin
    FROM base
    GROUP BY orders_id
)
SELECT * FROM aggregated