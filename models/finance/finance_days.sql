SELECT
  COUNT(*) AS nb_transactions,
  ROUND(SUM(revenue), 2) AS revenue,
  ROUND(AVG(revenue), 2) AS avg_basket,
  ROUND(SUM(op_margin), 2) AS op_margin,
  ROUND(SUM(purchase_cost), 2) AS purchase_cost,
  ROUND(SUM(shipping_fee), 2) AS shipping_fee,
  ROUND(SUM(logcost), 2) AS logcost,
  ROUND(SUM(quantity), 0) AS nb_products_sold
FROM {{ ref("int_orders_operational") }}
GROUP BY date_date