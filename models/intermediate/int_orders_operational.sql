SELECT *,
ROUND (margin.margin + ship.shipping_fee - ship.logcost - ship.ship_cost, 2) AS op_margin
FROM {{ ref("int_orders_margin")}} AS margin
LEFT JOIN {{ ref("stg_raw__ship")}} AS ship
USING (orders_id)