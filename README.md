# 📊 SQL Portfolio: E-Commerce Store Database Management

This repository contains a comprehensive collection of SQL queries designed for a relational database of a retail store. The project demonstrates advanced data manipulation, filtering, and analytical reporting using SQLite.

---

## 🏗 Database Schema (Architecture)

The database is built on four core tables, maintaining strict data integrity through Primary and Foreign Key relationships:



* **`customers`**: Stores personal details such as names, emails, and geographical location (Baku, Ganja, etc.).
* **`products`**: A catalog containing product names, categories (Electronics, Home, etc.), and unit prices.
* **`orders`**: Tracks the header of each transaction, linking customers to specific dates.
* **`order_items`**: The junction table that bridges orders and products, storing quantities for each specific item sold.

---

## 🔍 Query Categories & Business Logic

The project is organized into 26 SQL scripts, categorized by their complexity and purpose:

### 1. Simple Data Retrieval
Basic operations to extract raw data, fetch unique categories, and sort products by price to understand the inventory.

### 2. Conditional Filtering
Advanced filtering techniques used to segment data:
* Identifying high-value products (Price > 50).
* Customer segmentation based on location or email providers.
* Date-based analysis for orders placed in specific years.

### 3. Aggregate Functions & Analytics
Statistical reporting to measure store performance:
* **Average Pricing:** Calculating the mean value of the inventory.
* **Sales Volume:** Total quantity of products sold.
* **Category Distribution:** Understanding which categories have the most variety.

### 4. Relational Analysis (JOINs)
The core of the project, where multiple tables are linked to answer complex business questions:
* **Customer Purchase History:** Linking orders to names.
* **Revenue Analysis:** Calculating total spent per customer (Price × Quantity).
* **Churn Potential:** Using `LEFT JOIN` to identify customers who have never placed an order.
* **Top Performers:** Ranking the top 5 customers by total items purchased.

---

## 🎯 Technical Highlights
* **Modular Organization:** Each query is a standalone `.sql` file for maximum readability.
* **Table Aliasing:** Use of aliases (`p`, `o`, `oi`) for optimized and clean JOIN syntax.
* **Data Accuracy:** All queries have been cross-verified with the `store.db` environment.
* **Standardized Naming:** Following naming conventions that prevent "ambiguous column" errors.

---
**Developed by:** Tahmina Alijewa  
**Academic Context:** Holberton School SQL Task  
**Status:** ✅ Fully Verified & Tested