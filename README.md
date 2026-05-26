# 📊 Store Database Management System
> **SQL Portfolio Project | Holberton School**

![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)
![SQL](https://img.shields.io/badge/sql-%2300758f.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Verified-brightgreen?style=for-the-badge)

A comprehensive backend database project focused on relational data modeling, analytical querying, and business intelligence reporting.

---

## 🏗 Database Architecture

This project utilizes a normalized relational structure to ensure data consistency and eliminate redundancy. The architecture is composed of four primary entities:



* **`customers`**: Managing user demographics and contact information.
* **`products`**: Inventory management including categorization and unit pricing.
* **`orders`**: Transactional headers linking customers to specific purchase events.
* **`order_items`**: Detailed line items for each order, managing product-order associations and quantities.

---

## 🔍 Analytical Modules

The project is structured into **26 SQL scripts**, strategically divided into logical folders to represent a real-world development workflow:

### 📁 Simple Queries
*Fundamental data retrieval and sorting.*
* Inventory overview and price-based sorting.
* Unique category extraction for marketing analysis.

### 📁 Conditional Queries
*Precision filtering for targeted data sets.*
* High-value product identification.
* Geographical customer segmentation (e.g., Baku-based clients).
* Date-range analysis for specific fiscal years.

### 📁 Aggregate Functions
*Numerical data processing and KPI reporting.*
* Calculating average market prices across categories.
* Total sales volume and stock movement analysis.
* Quantitative distribution of products per category.

### 📁 Join Queries
*Complex relational data merging and reporting.*
* **Customer Lifetime Value:** Calculating total expenditure per user.
* **Order Tracking:** Detailed itemized reports for logistics.
* **Churn Analysis:** Identifying inactive customers using `LEFT JOIN` operations.
* **Ranking:** Performance tracking of top-purchasing clients.

---

## 🎯 Technical Implementation Details

* **Relational Integrity:** Implemented through Primary and Foreign Key constraints.
* **Code Optimization:** Used Table Aliasing (`p`, `o`, `oi`) for clean, maintainable, and high-performance JOIN queries.
* **Validation:** All scripts have been cross-tested within the `sqlite3` CLI environment.
* **Structure:** Organized following the "Separation of Concerns" principle with dedicated folders for each query type.

---
**Developed by:** Tahmina Alijewa  
**Environment:** SQLite 3  
**Verified on:** May 2026