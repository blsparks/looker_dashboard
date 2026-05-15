# Ecommerce Customer Retention and Channel Quality Analysis

## Project Overview

This project uses TheLook Ecommerce data to analyze customer retention, repeat purchase behavior, customer value segments, acquisition source quality, and product category performance.

The goal is to move beyond basic ecommerce reporting and answer:

How can an ecommerce business improve customer value when repeat purchase retention is low?

## Tools Used

1. SQL 
2. Power BI
3. BigQuery

## Business Questions

1. Are customers returning after their first purchase?
2. Which customer segments are most valuable or worth reactivating?
3. Which acquisition sources produce stronger customer value?
4. Which product categories are associated with repeat purchasing and higher revenue per customer?

## SQL Views Created

1. `vw_customer_summary`

One row per customer with first order date, last order date, total orders, lifetime revenue, AOV, acquisition source, and repeat customer flag.

2. `vw_cohort_retention`

Monthly cohort retention view measuring how many customers return after their first purchase month.

3. `vw_channel_quality`

Acquisition source summary with revenue, customers, repeat purchase rate, revenue per customer, and average orders per customer.

4. `vw_rfm_segments`

Customer segmentation view using recency, frequency, and monetary value.

5. `vw_reactivation_targets`

Classifies customers into winback groups such as high value inactive customers, repeat buyers at risk, and high spend one time buyers.

6. `vw_category_quality`

Category level view measuring revenue, repeat customer rate, revenue per customer, and average customer AOV.

## Power BI Dashboard Pages

### Page 1: Revenue and Customer Health Overview

Shows overall revenue, customers, orders, repeat purchase rate, AOV, revenue per customer, and high value winback customers.

### Page 2: Repeat Purchase Retention

Shows cohort retention, Month 1 through Month 12 repeat purchase behavior, and new customer cohort size.

### Page 3: Customer Value and Winback Opportunities

Shows customer segments, revenue by segment, reactivation groups, and target customers for winback campaigns.

### Page 4: Category Quality and Growth Recommendations

Shows top categories by revenue, repeat customer rate, revenue per customer, and category performance.

## Key Findings

1. Repeat purchase retention is very low after the first purchase month.
2. One time buyers make up a large share of the customer base.
3. Higher value customer segments contribute disproportionately to revenue.
4. High value inactive customers and repeat buyers at risk are strong winback targets.
5. Product categories should be evaluated by repeat behavior and revenue per customer, not only total revenue.

## Recommendations

1. Prioritize second purchase activation through post purchase emails, personalized recommendations, and first to second purchase incentives.
2. Target high value inactive customers before running broad reactivation campaigns.
3. Evaluate acquisition sources by customer quality metrics such as repeat purchase rate and revenue per customer.
4. Promote categories associated with repeat purchasing and stronger customer value.

## Repository Structure

```text
ecommerce_retention_channel_quality/
│
├── README.md
├── sql/
│   ├── 01_customer_summary.sql
│   ├── 02_cohort_retention.sql
│   ├── 03_channel_quality.sql
│   ├── 04_rfm_segments.sql
│   ├── 05_reactivation_targets.sql
│   ├── 06_category_quality.sql
├── powerbi/
│   └── ecommerce_retention_dashboard.pbix
