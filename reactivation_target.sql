CREATE OR REPLACE VIEW `thelook_ecommerce.vw_reactivation_targets` AS
SELECT
    user_id,
    acquisition_source,
    last_order_date,
    DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) AS days_since_last_order,
    total_orders,
    lifetime_revenue,
    avg_order_value,
    CASE
        WHEN lifetime_revenue >= 300 
             AND DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) >= 90
             THEN 'High-Value Winback Target'
        WHEN total_orders > 1 
             AND DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) >= 60
             THEN 'Repeat Buyer At Risk'
        WHEN total_orders = 1 
             AND lifetime_revenue >= 150
             THEN 'High-Spend One-Time Buyer'
        ELSE 'Lower Priority'
    END AS reactivation_segment
FROM `thelook_ecommerce.vw_customer_summary`;