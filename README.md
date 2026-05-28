# Olist E-Commerce Analytics & Executive Intelligence Platform

## Project Overview

This project is an end-to-end business intelligence and analytics solution built on the Brazilian Olist e-commerce marketplace dataset. The objective was to analyze operational performance, customer behavior, product trends, delivery efficiency, seller performance, and customer satisfaction to generate actionable business insights.

The project combines SQL-based analytical exploration, Python-based validation and analysis, and Power BI dashboarding to simulate a real-world analytics workflow used in business intelligence and data analytics teams.

---

## Business Objectives

The project aimed to answer key business questions such as:

- What drives overall marketplace revenue growth?
- Which product categories contribute the most revenue?
- How do delivery delays impact customer satisfaction?
- Which categories behave like premium segments?
- What operational bottlenecks affect reviews and retention?
- How healthy are marketplace fulfillment and logistics performance?

---

## Tech Stack

- PostgreSQL
- SQL
- Python
- Pandas
- Jupyter Notebook
- Power BI

---

## Project Architecture

```text
PostgreSQL Database
        ↓
SQL Analytical Layer
        ↓
Python Validation & Exploration
        ↓
Power BI Executive Dashboard
````

---

## Dataset Overview

The dataset contains Brazilian e-commerce marketplace transactions including:

* Orders
* Customers
* Products
* Sellers
* Payments
* Reviews
* Delivery timestamps
* Product category translations

Key business domains analyzed:

* Revenue Analytics
* Customer Analytics
* Delivery Analytics
* Review Analytics
* Product Analytics
* Seller Analytics

---

## SQL Analysis Modules

### Revenue Analysis

* Revenue trends over time
* Category-wise revenue contribution
* Order value analysis
* Marketplace growth patterns

### Customer Analysis

* Customer distribution
* Repeat behavior patterns
* Customer order contribution

### Delivery Analysis

* Delivery delays
* On-time delivery percentage
* Logistics performance
* Delay impact on customer reviews

### Review Analysis

* Review score distribution
* Complaint categorization
* Operational drivers of dissatisfaction

### Product Analysis

* Premium category identification
* Revenue concentration
* Product pricing consistency
* Category performance benchmarking

### Seller Analysis

* Seller contribution analysis
* Fulfillment efficiency
* Seller operational quality indicators

---

## Power BI Dashboard Features

### Executive KPIs

* Total Revenue
* Total Orders
* Total Customers
* Average Order Value
* Average Review Score
* On-Time Delivery Percentage

### Visual Analytics

* Revenue trends over time
* Order growth trends
* Top revenue-generating categories
* Customer review distribution

---

## Key Business Insights

* Delivery delays showed strong correlation with low customer review scores, indicating logistics as a major driver of customer dissatisfaction.
* Health & Beauty, Watches & Gifts, and Bed Bath Table categories dominated overall marketplace revenue contribution.
* Several premium categories demonstrated stable pricing behavior, while others showed outlier-driven pricing patterns.
* Customer reviews remained heavily skewed toward positive ratings despite operational bottlenecks, suggesting strong marketplace trust overall.
* Logistics consistency appeared more critical to customer satisfaction than product pricing itself.

---

## Future Improvements

* NLP-based review sentiment classification
* Advanced customer segmentation
* Seller risk scoring models
* Forecasting models for revenue and orders
* Automated dashboard refresh pipelines

---

## Repository Structure

```text
FULL_STACK/
│
├── PowerBI/
│   └── olist_dashboard.pbix
│
├── Python/
│   ├── Notebooks/
│   └── scripts/
│
├── SQL_Analysis/
│   ├── 01_revenue_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_delivery_analysis.sql
│   ├── 04_review_analysis.sql
│   ├── 05_product_analysis.sql
│   └── 06_seller_analysis.sql
│
├── Documentation/
│
├── assets/
│
├── README.md
│
└── requirements.txt
```

---

## Dashboard Preview

(Add Power BI dashboard screenshot here)

---

## Author

Vikram Raju K (Honestly I Used an LLM for this readme.md)

```


That one is critical for resume/interview storytelling.
```
