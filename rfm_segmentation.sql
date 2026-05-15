CREATE OR REPLACE VIEW `thelook_ecommerce.vw_rfm_segments` AS
WITH rfm_base AS (
    SELECT
        user_id,
        acquisition_source,
        first_order_date,
        last_order_date,
        DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) AS recency_days,
        total_orders AS frequency,
        lifetime_revenue AS monetary_value,
        avg_order_value,
        repeat_customer_flag
    FROM `thelook_ecommerce.vw_customer_summary`
),

rfm_scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value ASC) AS monetary_score
    FROM rfm_base
)

SELECT
    *,
    CASE
        WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'Champions'
        WHEN frequency_score >= 4 AND monetary_score >= 3 THEN 'Loyal Customers'
        WHEN recency_score <= 2 AND frequency_score >= 3 THEN 'At Risk'
        WHEN recency_score <= 2 AND monetary_score >= 4 THEN 'High-Value Inactive'
        WHEN frequency = 1 AND monetary_score >= 4 THEN 'High-Spend One-Time Buyer'
        WHEN frequency = 1 THEN 'One-Time Buyer'
        ELSE 'Other'
    END AS customer_segment
FROM rfm_scores;