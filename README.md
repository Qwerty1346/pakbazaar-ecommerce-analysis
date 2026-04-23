# PakBazaar E-Commerce Analysis

**Analyst**: Ahmad Raza
**Institution:** COMSATS University Lahore — BS Business Data Analytics
**Tools:** SQL (MySQL)
**Dataset:** 15 customers, 20 orders, 28 line items


# Executive Summary

PakBazaar's Q3–Q4 2023 data reveals that Karachi drives 63.11% of total revenue
despite representing 40% of orders. Electronics is the highest-revenue category
but Clothing delivers the strongest margins. The 36.36% repeat customer rate
signals healthy retention. Return rate analysis identifies Sports and Electronics
as the highest loss-risk segments requiring immediate quality review.


# Key Findings

# 1. Revenue by City

| City       | Revenue (PKR) | Orders | Share (%) |
|------------|---------------|--------|-----------|
| Karachi    | 95,100        | 6      | 63.11     |
| Lahore     | 20,100        | 3      | 13.34     |
| Multan     | 19,200        | 3      | 12.74     |
| Islamabad  | 11,000        | 2      | 7.30      |
| Faisalabad | 5,300         | 1      | 3.52      |

**Insight:** Karachi generates the highest revenue at 63.11% share.
Lahore ranks second at 13.34%.


# 2. Category Profitability

| Category       | Revenue (PKR) | Margin (%) | Label           |
|----------------|---------------|------------|-----------------|
| Electronics    | 81,000        | 31         | Healthy         |
| Home & Kitchen | 30,200        | 43         | Healthy         |
| Clothing       | 24,000        | 57         | Excellent       |
| Beauty         | 13,250        | 55         | Excellent       |
| Books          | 2,250         | 53         | Excellent       |

> Gross Profit = SUM( quantity × (unit_price − cost_price) )

**Insight:** Books have the lowest revenue but a high profit margin.
Clothing should receive increased inventory investment due to its 57% margin.


# 3. Customer Loyalty

| Metric            | Value  |
|-------------------|--------|
| Total customers   | 11     |
| Repeat customers  | 4      |
| Repeat rate       | 36.36% |
| Industry average  | 25–30% |

**Insight:** Repeat rate exceeds the industry average, indicating strong
customer retention. 4 registered users have placed zero orders.


# 4. Return and Cancellation Risk

| Category       | Loss Rate (%) |
|----------------|---------------|
| Sports         | 100.00        |
| Electronics    | 42.86         |
| Beauty         | 0.00          |
| Books          | 0.00          |
| Clothing       | 0.00          |
| Home & Kitchen | 0.00          |

**Insight:** Sports shows a 100% return rate based on a single transaction.
Electronics shows 42.86% based on 3 transactions. Both figures require
more data before actionable conclusions can be drawn.


# 5. Top Customers by Lifetime Value

| Customer ID | City       | Orders | LTV (PKR) | Segment    |
|-------------|------------|--------|-----------|------------|
| 1           | Karachi    | 2      | 74,900    | VIP        |
| 2           | Lahore     | 2      | 15,900    | Regular    |
| 6           | Multan     | 2      | 11,600    | Regular    |
| 10          | Karachi    | 2      | 10,000    | Regular    |
| 15          | Multan     | 1      | 7,600     | Occasional |
| 12          | Islamabad  | 1      | 6,200     | Occasional |
| 4           | Faisalabad | 1      | 5,300     | Occasional |
| 14          | Karachi    | 1      | 5,200     | Occasional |
| 7           | Karachi    | 1      | 5,000     | Occasional |
| 3           | Islamabad  | 1      | 4,800     | Occasional |
| 8           | Lahore     | 1      | 4,200     | Occasional |

---

# 6. Business Health Dashboard

| Metric          | Value      |
|-----------------|------------|
| Total Revenue   | 150,700 PKR |
| Gross Profit    | 60,150 PKR  |
| Overall Margin  | 39.91%      |
| Total Orders    | 11 delivered |
| Return Rate     | 25.00%      |

**Insight:** Out of 20 orders, only 11 were delivered. 9 were either
cancelled or returned — representing a 45% loss rate that requires
immediate operational review.



# SQL Concepts Demonstrated

- Window functions
- Common Table Expressions (CTEs)
- CASE WHEN segmentation
- Multi-table JOINs
- Aggregate functions (SUM, COUNT, AVG)


## What I Would Build Next

1. 6-month dataset to identify seasonal patterns
2. RFM segmentation model (Recency, Frequency, Monetary)
3. Power BI dashboard for live monitoring
4. Python / pandas replication with matplotlib visualizations


*This project was completed as part of an independent data analytics portfolio.
Dataset is synthetic and intended for educational use.*
