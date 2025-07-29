WITH order_margin AS (
    SELECT *
    FROM {{ ref('int_orders_margin') }}
),
ship_costs AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(logcost AS FLOAT64) AS log_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM {{ ref('stg_raw__ship') }}
),
final AS (
    SELECT
        order_margin.orders_id,
        order_margin.date_date,
        order_margin.revenue,
        order_margin.quantity,
        order_margin.purchase_cost,
        order_margin.margin,
        ship_costs.shipping_fee,
        ship_costs.log_cost,
        ship_costs.ship_cost,
        -- operational margin
        order_margin.margin
        + ship_costs.shipping_fee
        - ship_costs.log_cost
        - ship_costs.ship_cost AS operational_margin
    FROM order_margin
    LEFT JOIN ship_costs
      ON order_margin.orders_id = ship_costs.orders_id
)
SELECT * FROM final