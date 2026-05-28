# KPI Definitions

This document defines the key business metrics used throughout the SQL analysis and Power BI dashboard.

---

# 1. Total Revenue

## Definition

Total marketplace revenue generated from all completed order payments.

## Formula

```sql
SUM(order_payments.payment_value)
```

## Business Meaning

Measures the total monetary value processed through the marketplace.

## Interpretation

Higher values indicate marketplace growth, stronger product demand, and increased customer purchasing activity.

---

# 2. Total Orders

## Definition

Total number of unique customer orders placed in the marketplace.

## Formula

```sql
COUNT(DISTINCT orders.order_id)
```

## Business Meaning

Measures total marketplace transaction volume.

## Interpretation

Tracks marketplace scale, customer activity, and operational load.

---

# 3. Total Customers

## Definition

Total number of unique customers who placed orders.

## Formula

```sql
COUNT(DISTINCT customers.customer_unique_id)
```

## Business Meaning

Measures customer reach and active customer base size.

## Interpretation

Higher values indicate broader marketplace adoption.

---

# 4. Average Order Value (AOV)

## Definition

Average revenue generated per order.

## Formula

```sql
SUM(order_payments.payment_value)
/
COUNT(DISTINCT orders.order_id)
```

## Business Meaning

Measures average customer spending behavior.

## Interpretation

Higher AOV may indicate stronger premium-category performance or increased customer purchasing power.

---

# 5. Average Review Score

## Definition

Average customer satisfaction rating across all reviews.

## Formula

```sql
AVG(order_reviews.review_score)
```

## Business Meaning

Measures overall customer satisfaction and marketplace experience quality.

## Interpretation

Higher scores indicate healthier customer experience and operational reliability.

---

# 6. On-Time Delivery Percentage

## Definition

Percentage of orders delivered on or before the estimated delivery date.

## Formula

```sql
(
    On-Time Delivered Orders
    /
    Total Delivered Orders
) * 100
```

## SQL Logic

```sql
CASE
WHEN order_delivered_customer_date
     <= order_estimated_delivery_date
THEN 'On-Time'
ELSE 'Delayed'
END
```

## Business Meaning

Measures logistics and fulfillment efficiency.

## Interpretation

Higher percentages indicate stronger operational execution and delivery reliability.

---

# 7. Negative Reviews

## Definition

Total reviews with low customer ratings.

## Formula

```sql
COUNT(review_score <= 2)
```

## Business Meaning

Measures customer dissatisfaction volume.

## Interpretation

Helps identify operational issues affecting customer experience.

---

# 8. Negative Review Percentage

## Definition

Percentage of reviews classified as negative.

## Formula

```sql
(
    Negative Reviews
    /
    Total Reviews
) * 100
```

## Business Meaning

Measures dissatisfaction rate across the marketplace.

## Interpretation

Useful for operational quality monitoring and trend analysis.

---

# 9. Revenue Contribution Percentage

## Definition

Percentage contribution of a category or segment toward total marketplace revenue.

## Formula

```sql
(
    Category Revenue
    /
    Total Revenue
) * 100
```

## Business Meaning

Measures relative commercial importance of categories.

## Interpretation

Helps identify key revenue-driving product segments.

---

# 10. Average Delivery Delay

## Definition

Average number of delayed days beyond estimated delivery date.

## Formula

```sql
AVG(
    order_delivered_customer_date
    -
    order_estimated_delivery_date
)
```

## Business Meaning

Measures logistics inefficiency severity.

## Interpretation

Higher values indicate operational bottlenecks and increased customer dissatisfaction risk.
