CREATE OR REPLACE VIEW `thelook_ecommerce.vw_channel_quality` AS
SELECT
    acquisition_source,
    COUNT(DISTINCT user_id) AS customers,
    SUM(lifetime_revenue) AS total_revenue,
    AVG(lifetime_revenue) AS revenue_per_customer,
    AVG(total_orders) AS avg_orders_per_customer,
    AVG(avg_order_value) AS avg_order_value,
    SUM(repeat_customer_flag) AS repeat_customers,
    SAFE_DIVIDE(SUM(repeat_customer_flag), COUNT(DISTINCT user_id)) AS repeat_purchase_rate
FROM `thelook_ecommerce.vw_customer_summary`
GROUP BY acquisition_source;