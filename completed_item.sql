CREATE OR REPLACE VIEW `thelook_ecommerce.vw_completed_order_items` AS
SELECT
    o.order_id,
    o.user_id,
    DATE(o.created_at) AS order_date,
    oi.id AS order_item_id,
    oi.product_id,
    oi.sale_price,
    p.category,
    p.department,
    p.brand,
    u.traffic_source,
    u.country,
    u.age,
    u.gender
FROM `bigquery-public-data.thelook_ecommerce.orders` o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
    ON o.order_id = oi.order_id
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
JOIN `bigquery-public-data.thelook_ecommerce.users` u
    ON o.user_id = u.id
WHERE o.status = 'Complete';