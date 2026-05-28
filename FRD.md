# Functional Requirements Document (FRD)

# Project Title

Olist E-Commerce Analytics & Executive Intelligence Platform

---

# 1. Purpose

The purpose of this document is to define the functional requirements of the analytics and business intelligence solution developed for the Olist e-commerce marketplace dataset.

The solution aims to provide centralized KPI monitoring, operational visibility, and executive-level analytical reporting using SQL, Python, and Power BI.

---

# 2. System Overview

The analytical system consists of:

* PostgreSQL database layer
* SQL analytical modules
* Python validation and analytical notebooks
* Power BI executive dashboard
* Business documentation layer

The system is designed to support business intelligence and operational analysis across multiple marketplace domains.

---

# 3. Functional Modules

## 3.1 Revenue Analytics Module

### Functional Requirements

* Analyze revenue trends over time.
* Measure category-wise revenue contribution.
* Calculate average order value.
* Identify top-performing product categories.

### Outputs

* Revenue trend analysis
* Revenue contribution analysis
* Executive revenue KPIs

---

## 3.2 Customer Analytics Module

### Functional Requirements

* Analyze customer growth patterns.
* Measure unique customer contribution.
* Evaluate repeat customer behavior.
* Support customer segmentation analysis.

### Outputs

* Customer metrics
* Retention analysis
* Customer behavior insights

---

## 3.3 Delivery Analytics Module

### Functional Requirements

* Calculate delivery delays.
* Measure on-time delivery performance.
* Evaluate logistics efficiency.
* Analyze delivery impact on customer reviews.

### Outputs

* Delivery KPIs
* Delay distribution analysis
* Logistics performance insights

---

## 3.4 Review Analytics Module

### Functional Requirements

* Analyze review score distribution.
* Identify operational drivers of dissatisfaction.
* Categorize customer complaints.
* Measure negative review percentage.

### Outputs

* Review score analysis
* Complaint categorization
* Customer satisfaction insights

---

## 3.5 Product Analytics Module

### Functional Requirements

* Analyze product-category performance.
* Identify premium product segments.
* Measure pricing consistency.
* Evaluate revenue concentration across categories.

### Outputs

* Category benchmarking
* Pricing analysis
* Product performance insights

---

## 3.6 Seller Analytics Module

### Functional Requirements

* Measure seller contribution.
* Evaluate seller operational quality.
* Analyze fulfillment consistency.
* Identify high-performing sellers.

### Outputs

* Seller contribution metrics
* Operational seller insights
* Marketplace concentration analysis

---

# 4. Dashboard Functional Requirements

## Executive Overview Dashboard

### Required KPIs

* Total Revenue
* Total Orders
* Total Customers
* Average Order Value
* Average Review Score
* On-Time Delivery Percentage

### Required Visuals

* Revenue trend over time
* Order trend over time
* Top revenue-generating categories
* Review score distribution

### Interactive Features

* Year slicer
* Category slicer
* Dynamic filtering across visuals

---

# 5. Data Model Requirements

The dashboard data model should support:

* One-to-many relationships
* Centralized KPI calculations
* Consistent business logic
* Efficient filtering behavior
* Analytical scalability

The model should follow a star-schema-inspired analytical structure where possible.

---

# 6. Non-Functional Requirements

## Performance

* Dashboard visuals should load efficiently.
* SQL queries should support analytical scalability.

## Maintainability

* Measures should be centralized.
* KPI definitions should remain consistent.
* SQL modules should remain modular and readable.

## Usability

* Dashboard should remain executive-friendly.
* Visuals should support fast interpretation.
* Layout should prioritize analytical clarity over decoration.

---

# 7. Assumptions

* Marketplace transactions are operationally valid.
* Delivery timestamps are reliable.
* Reviews accurately reflect customer experience.

---

# 8. Constraints

* Real-time data refresh not implemented.
* NLP-based multilingual sentiment analysis not implemented.
* Advanced predictive forecasting models not included.

---

# 9. Expected Outcomes

The solution should enable stakeholders to:

* Monitor marketplace performance centrally.
* Identify operational inefficiencies.
* Improve customer satisfaction visibility.
* Support strategic marketplace decisions.
* Analyze business performance through integrated BI reporting.
