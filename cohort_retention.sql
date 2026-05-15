CREATE OR REPLACE VIEW `thelook_ecommerce.vw_cohort_retention` AS
WITH customer_orders AS (
    SELECT
        user_id,
        order_id,
        DATE_TRUNC(order_date, MONTH) AS order_month
    FROM `thelook_ecommerce.vw_completed_order_items`
    GROUP BY
        user_id,
        order_id,
        DATE_TRUNC(order_date, MONTH)
),

customer_orders_with_cohort AS (
    SELECT
        user_id,
        order_id,
        order_month,
        MIN(order_month) OVER (
            PARTITION BY user_id
        ) AS cohort_month
    FROM customer_orders
),

cohort_activity AS (
    SELECT
        cohort_month,
        order_month,
        DATE_DIFF(order_month, cohort_month, MONTH) AS month_number,
        COUNT(DISTINCT user_id) AS active_customers
    FROM customer_orders_with_cohort
    GROUP BY
        cohort_month,
        order_month,
        DATE_DIFF(order_month, cohort_month, MONTH)
),

cohort_size AS (
    SELECT
        cohort_month,
        active_customers AS cohort_size
    FROM cohort_activity
    WHERE month_number = 0
)

SELECT
    ca.cohort_month,
    ca.month_number,
    ca.active_customers,
    cs.cohort_size,
    SAFE_DIVIDE(ca.active_customers, cs.cohort_size) AS retention_rate
FROM cohort_activity ca
JOIN cohort_size cs
    ON ca.cohort_month = cs.cohort_month;