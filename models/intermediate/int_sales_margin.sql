SELECT *,
quantity * purchase_price AS purchase_cost,
ROUND(revenue - (quantity * purchase_price), 2) AS margin
FROM {{ ref('stg_raw__sales')}} AS sales
LEFT JOIN {{ ref('stg_raw__product')}} AS products
USING (products_id)