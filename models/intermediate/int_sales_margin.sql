WITH sales AS (
    SELECT *
    FROM {{ ref('stg_raw__sales') }}
),
products AS (
    SELECT *
    FROM {{ ref('stg_raw__product') }}
),
joined AS (
    SELECT
        sales.date_date,
        sales.orders_id,
        sales.products_id,
        sales.revenue,
        sales.quantity,
        products.purchase_price,
        -- calculate purchase_cost
        sales.quantity * products.purchase_price AS purchase_cost,
        -- calculate margin
        sales.revenue - (sales.quantity * products.purchase_price) AS margin
    FROM sales
    LEFT JOIN products
      ON sales.products_id = products.products_id
)
SELECT * FROM joined