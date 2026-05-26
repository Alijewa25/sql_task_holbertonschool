# 📊 SQL Project: Store Management & Analytical Reporting
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

This project is a comprehensive SQL-based database management system developed as part of the Holberton School curriculum. It covers everything from initial schema design to complex relational data analysis.

## 🏗 Database Architecture
The database is built on a normalized relational model, ensuring data integrity through Primary and Foreign Key constraints.



### Data Entities:
* **`customers`**: Manages unique user profiles and demographics (e.g., location, email).
* **`products`**: A categorized inventory with unit pricing.
* **`orders`**: Transactional headers linking specific customers to purchase events.
* **`order_items`**: A junction table that resolves the **Many-to-Many** relationship between orders and products, handling itemized quantities.

---

## 🛠 Project Modules & Query Logic

The project consists of **26 SQL scripts**, organized into 4 logical phases:

### 1. Simple Queries
* **Focus:** Core data extraction.
* **Implementation:** Using `SELECT`, `DISTINCT`, and `ORDER BY` to audit inventory and customer lists.

### 2. Conditional Queries
* **Focus:** Data segmentation and pattern matching.
* **Implementation:** Using `WHERE` clauses with `LIKE` (for email/domain filtering) and `BETWEEN` operators to isolate specific business data points.

### 3. Aggregate Functions
* **Focus:** Business Intelligence (BI) reporting.
* **Implementation:** Using `GROUP BY` and `HAVING` to calculate KPIs such as:
    * Average product pricing per category.
    * Total units sold across the store.
    * Frequency of orders per unique customer.

### 4. Join Queries (Deep Relational Analysis)
* **Focus:** Multi-table connectivity and revenue calculation.
* **Implementation:** * **Complex Joins:** Linking 4 tables to calculate **Total Spent per Customer** (Price × Quantity).
    * **Advanced Logic:** Utilizing `LEFT JOIN` to identify "Churn" or inactive customers who have never placed an order.
    * **Top-N Analysis:** Identifying the top 5 customers based on purchase volume.

---

## 🚀 Execution & Verification
The integrity of all queries has been verified within the `sqlite3` environment. Each script was tested against the `store.db` to ensure zero syntax errors and accurate output.

**Automated verification run:**
```bash
for file in */*.sql; do echo "Testing: $file"; sqlite3 store.db < "$file"; done