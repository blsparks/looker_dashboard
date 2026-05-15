CREATE OR REPLACE VIEW `thelook_ecommerce.vw_category_quality` AS
WITH category_customer AS (
    SELECT
        category,
        user_id,
        COUNT(DISTINCT order_id) AS category_orders,
        SUM(sale_price) AS category_revenue
    FROM `thelook_ecommerce.vw_completed_order_items`
    GROUP BY category, user_id
)

SELECT
    cc.category,
    COUNT(DISTINCT cc.user_id) AS customers,
    SUM(cc.category_orders) AS total_orders,
    SUM(cc.category_revenue) AS total_revenue,
    AVG(cc.category_revenue) AS revenue_per_customer,
    AVG(cs.repeat_customer_flag) AS repeat_customer_rate,
    AVG(cs.avg_order_value) AS avg_customer_aov
FROM category_customer cc
JOIN `thelook_ecommerce.vw_customer_summary` cs
    ON cc.user_id = cs.user_id
GROUP BY cc.category;