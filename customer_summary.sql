CREATE OR REPLACE VIEW `thelook_ecommerce.vw_customer_summary` AS
SELECT
    user_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATE_DIFF(MAX(order_date), MIN(order_date), DAY) AS customer_lifespan_days,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT order_item_id) AS total_items,
    SUM(sale_price) AS lifetime_revenue,
    AVG(sale_price) AS avg_item_price,
    SUM(sale_price) / COUNT(DISTINCT order_id) AS avg_order_value,
    MAX(traffic_source) AS acquisition_source,
    MAX(country) AS country,
    MAX(gender) AS gender,
    MAX(age) AS age,
    CASE
        WHEN COUNT(DISTINCT order_id) > 1 THEN 1
        ELSE 0
    END AS repeat_customer_flag
FROM `thelook_ecommerce.vw_completed_order_items`
GROUP BY user_id;