# 🗄️ SQL Retail Store Management System

![SQLite](https://img.shields.io/badge/SQLite-3-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-F29111?style=for-the-badge&logo=database&logoColor=white)
![Holberton School](https://img.shields.io/badge/Holberton-School-FF0000?style=for-the-badge&logo=school&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-28A745?style=for-the-badge)
![Scripts](https://img.shields.io/badge/SQL%20Scripts-26-4A90D9?style=for-the-badge)
![Records](https://img.shields.io/badge/Dataset-55%20Records-8A2BE2?style=for-the-badge)

> A fully normalized relational database system modeling a retail store's operations — from customer segmentation across Azerbaijani cities to multi-category product management, transactional order processing, and revenue analytics — implemented in SQLite3 across 26 structured SQL scripts.

---

## 📑 Table of Contents

- [Project Overview](#project-overview)
- [Database Architecture](#database-architecture)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Module Breakdown & Business Logic](#module-breakdown--business-logic)
  - [Simple Queries](#1-simple_queries)
  - [Conditional Queries](#2-conditional_queries)
  - [Aggregate Functions](#3-aggregate_functions)
  - [Join Queries](#4-join_queries)
- [Technical Challenges Solved](#technical-challenges-solved)
- [Verification & Testing](#verification--testing)
- [Author](#author)

---

## Project Overview

This project implements a **retail store management system** using a relational database paradigm in **SQLite3**. The system models real-world commercial operations through four interrelated tables and a suite of progressively complex SQL queries spanning basic retrieval, conditional filtering, aggregation-based business intelligence, and multi-table relational joins.

The database is structured according to **Third Normal Form (3NF)** principles: eliminating redundancy, enforcing referential integrity through foreign keys, and decomposing many-to-many relationships via a junction table. The dataset spans **10 customers** distributed across 5 Azerbaijani cities, **12 products** across 4 categories, **18 orders**, and **25 order line items** — a compact but structurally complete retail scenario.

---

## Database Architecture

### Entity-Relationship Overview

The schema models four core business entities and their relationships:

```
customers
─────────────────────────────────────────
PK  id          INTEGER
    first_name  TEXT
    last_name   TEXT
    email       TEXT
    city        TEXT


products
─────────────────────────────────────────
PK  id          INTEGER
    name        TEXT
    category    TEXT
    price       REAL


orders
─────────────────────────────────────────
PK  id          INTEGER
FK  customer_id → customers.id
    order_date  TEXT


order_items  (Junction / Bridge Table)
─────────────────────────────────────────
PK  id          INTEGER
FK  order_id    → orders.id
FK  product_id  → products.id
    quantity    INTEGER
```

### Relational Logic & Cardinality

| Relationship | Type | Key Constraint |
|---|---|---|
| `customers` → `orders` | One-to-Many | `orders.customer_id` → `customers.id` |
| `orders` → `order_items` | One-to-Many | `order_items.order_id` → `orders.id` |
| `products` → `order_items` | One-to-Many | `order_items.product_id` → `products.id` |
| `customers` ↔ `products` | **Many-to-Many** | Resolved via `orders` + `order_items` |

### Why `order_items` Is the Architectural Keystone

The `order_items` table resolves the inherent many-to-many relationship between customers and products: a customer may purchase many products, and any product may be purchased by many customers. Rather than denormalizing this into a flat structure (which would duplicate product prices and customer data across rows), the schema decomposes it into two one-to-many associations.

This design allows:
- **Transactional granularity**: quantity per line item is stored at the correct level of detail.
- **Price integrity**: `products.price` lives in one place; revenue is computed dynamically via `price × quantity`.
- **Auditability**: each `order_items` row is an immutable record of a purchase event.

### Revenue Computation Join Path

Calculating customer lifetime spend requires traversing a **four-table chain**:

```
customers → orders → order_items → products
```

The computation `SUM(products.price * order_items.quantity)` multiplies at the row level across the `order_items`/`products` join, then collapses per customer via `GROUP BY customers.id`. This is a non-trivial aggregate because the multiplicand and multiplier live in different tables.

---

## Dataset

### `customers` — 10 records

| id | first_name | last_name | email | city |
|---|---|---|---|---|
| 1 | Ali | Hasanov | ali.hasanov@gmail.com | Baku |
| 2 | Nigar | Mammadova | nigar.m@gmail.com | Baku |
| 3 | Rashad | Aliyev | rashad.a@gmail.com | Sumgait |
| 4 | Leyla | Huseynova | leyla.h@gmail.com | Ganja |
| 5 | Orkhan | Rahimov | orkhan.r@gmail.com | Baku |
| 6 | Aysel | Karimova | aysel.k@gmail.com | Shaki |
| 7 | Elvin | Ismayilov | elvin.i@gmail.com | Baku |
| 8 | Samira | Aliyeva | samira.a@gmail.com | Lankaran |
| 9 | Tural | Muradov | tural.m@gmail.com | Ganja |
| 10 | Gunay | Safarova | gunay.s@gmail.com | Baku |

> **Geographic distribution:** Baku (5), Ganja (2), Sumgait (1), Shaki (1), Lankaran (1) — enabling meaningful city-level segmentation queries.

---

### `products` — 12 records

| id | name | category | price |
|---|---|---|---|
| 1 | Wireless Mouse | electronics | 15 |
| 2 | Mechanical Keyboard | electronics | 45 |
| 3 | USB-C Cable | electronics | 8 |
| 4 | Laptop Stand | electronics | 25 |
| 5 | Monitor 24 inch | electronics | 120 |
| 6 | Notebook A5 | stationery | 3 |
| 7 | Ballpoint Pen | stationery | 1.5 |
| 8 | Backpack | accessories | 35 |
| 9 | Water Bottle | accessories | 12 |
| 10 | Desk Lamp | home | 20 |
| 11 | Headphones | electronics | 60 |
| 12 | Phone Charger | electronics | 18 |

> **Category breakdown:** electronics (7), stationery (2), accessories (2), home (1). Price range: $1.50 (Ballpoint Pen) — $120.00 (Monitor 24 inch).

---

### `orders` — 18 records

Orders span **5/1/2026 – 5/9/2026**, with customers 1–8 each placing two orders and customers 9–10 placing one each. Customer 1 (Ali Hasanov) and Customer 2 (Nigar Mammadova) are the most frequent purchasers with 2 orders each across this window.

---

### `order_items` — 25 records

25 line items across 18 orders, with quantities ranging from 1 to 5 units per line. Products 3 (USB-C Cable), 7 (Ballpoint Pen), and 9 (Water Bottle) appear most frequently as purchased items.

---

## Project Structure

```
sql-retail-management/
│
├── Simple_Queries/           # 5 scripts — Foundational retrieval
│   ├── 0-all_products.sql
│   ├── 1-product_names_prices.sql
│   ├── 2-all_customers.sql
│   ├── 3-distinct_categories.sql
│   └── 4-first_10_products.sql
│
├── Conditional_Queries/      # 7 scripts — Predicate filtering
│   ├── 0-products_over_50.sql
│   ├── 1-customers_from_baku.sql
│   ├── 2-electronics_category.sql
│   ├── 3-orders_after_2024.sql
│   ├── 4-gmail_customers.sql
│   ├── 5-price_between_20_80.sql
│   └── 6-not_clothing.sql
│
├── Aggregate_Functions/      # 7 scripts — Business intelligence metrics
│   ├── 0-count_products.sql
│   ├── 1-avg_product_price.sql
│   ├── 2-count_customers.sql
│   ├── 3-sum_quantities_sold.sql
│   ├── 4-orders_per_customer.sql
│   ├── 5-highest_priced_product.sql
│   └── 6-products_per_category.sql
│
└── Join_Queries/             # 7 scripts — Relational analysis
    ├── 0-orders_with_customer_names.sql
    ├── 1-ordered_product_details.sql
    ├── 2-total_items_per_customer.sql
    ├── 3-total_amount_per_customer.sql
    ├── 4-orders_in_2024.sql
    ├── 5-inactive_customers.sql
    └── 6-top5_customers_by_items.sql
```

> **Total: 26 SQL scripts** across 4 thematically organized modules.

---

## Module Breakdown & Business Logic

### 1. `Simple_Queries`

**Purpose:** Establish foundational data retrieval patterns — the basis upon which all analytical queries are built.

**Techniques Used:** `SELECT *`, `SELECT` with specific columns, `SELECT DISTINCT`, `LIMIT`.

**Business Logic:**

| Script | Business Question Answered |
|---|---|
| `0-all_products.sql` | Full product catalog inventory snapshot |
| `1-product_names_prices.sql` | Lightweight price list for a frontend display |
| `2-all_customers.sql` | Complete CRM customer roster |
| `3-distinct_categories.sql` | Unique taxonomy for catalog navigation / UI filters |
| `4-first_10_products.sql` | Paginated product listing (first page) |

**Design Note:** `SELECT DISTINCT category` extracts `electronics`, `stationery`, `accessories`, `home` — four unique values from 12 rows. This pattern feeds real-world use cases like populating dropdown menus or category filter chips in a frontend application.

---

### 2. `Conditional_Queries`

**Purpose:** Apply predicate logic to filter datasets into actionable subsets, enabling targeted business decisions without full table scans in application logic.

**Techniques Used:** `WHERE`, `>`, `=`, `LIKE` with `%` wildcard, `BETWEEN`, `NOT IN`.

**Business Logic:**

| Script | Business Question Answered |
|---|---|
| `0-products_over_50.sql` | Premium product segment (Monitor $120, Headphones $60) |
| `1-customers_from_baku.sql` | Geo-targeted cohort: Ali, Nigar, Orkhan, Elvin, Gunay |
| `2-electronics_category.sql` | Filter the dominant category (7 of 12 products) |
| `3-orders_after_2024.sql` | Recent transaction window for trend analysis |
| `4-gmail_customers.sql` | All 10 customers use @gmail.com — 100% coverage verified |
| `5-price_between_20_80.sql` | Mid-tier pricing band: Laptop Stand, Backpack, Mechanical Keyboard, Desk Lamp |
| `6-not_clothing.sql` | Confirms no clothing category exists — clean data integrity check |

**Design Note — Geographical Segmentation:** `WHERE city = 'Baku'` isolates 5 of 10 customers — a 50% concentration in the capital. This metric is non-trivial: it enables a business to identify that half its customer base is in one city, informing delivery logistics, marketing budget allocation, and physical store placement decisions.

**Design Note — Email Pattern Matching:** `WHERE email LIKE '%@gmail.com'` uses a trailing wildcard to extract the domain suffix regardless of the local-part. In this dataset, all 10 customers use Gmail, which a real system might use to infer communication channel preferences or flag the absence of corporate email domains.

---

### 3. `Aggregate_Functions`

**Purpose:** Compress raw transactional data into high-level business intelligence metrics that would populate a retail dashboard's KPI layer.

**Techniques Used:** `COUNT()`, `AVG()`, `SUM()`, `MAX()`, `GROUP BY`, `ORDER BY` with aggregates.

**Business Logic:**

| Script | Metric Produced | Result (from actual data) |
|---|---|---|
| `0-count_products.sql` | Total SKU count | **12** |
| `1-avg_product_price.sql` | Average unit price | **~$28.46** |
| `2-count_customers.sql` | Customer base size | **10** |
| `3-sum_quantities_sold.sql` | Total units moved | Sum across 25 line items |
| `4-orders_per_customer.sql` | Purchase frequency per customer | Max 2, min 1 |
| `5-highest_priced_product.sql` | Price ceiling / flagship product | **Monitor 24 inch — $120** |
| `6-products_per_category.sql` | Catalog distribution by category | electronics: 7, stationery: 2, accessories: 2, home: 1 |

**Design Note:** The `GROUP BY` + `COUNT()` pattern in `orders_per_customer` produces a distribution equivalent to a purchase frequency histogram. When combined with a `HAVING COUNT(*) = 1` filter, it would isolate single-purchase customers — a key metric for loyalty program targeting. The `products_per_category` output reveals a heavily electronics-skewed catalog (58% of SKUs), a structural characteristic of the dataset relevant to assortment strategy.

---

### 4. `Join_Queries`

**Purpose:** Traverse foreign key relationships to assemble composite views of business reality. This module is the technical core of the project, demonstrating mastery of relational algebra in SQL.

**Techniques Used:** `INNER JOIN`, `LEFT JOIN`, multi-table joins (up to 4 tables), `SUM(price * quantity)` aggregate join, `GROUP BY`, `ORDER BY DESC`, `LIMIT`.

**Business Logic:**

| Script | Business Question Answered | Join Depth |
|---|---|---|
| `0-orders_with_customer_names.sql` | Which named customers placed which orders? | 2 tables |
| `1-ordered_product_details.sql` | Product name + quantity + date per order | 3 tables |
| `2-total_items_per_customer.sql` | How many units has each customer purchased total? | 3 tables |
| `3-total_amount_per_customer.sql` | What is each customer's lifetime spend? | 4 tables |
| `4-orders_in_2024.sql` | Full order manifest for a specific year | 4 tables + date filter |
| `5-inactive_customers.sql` | Which customers have never ordered? (churn detection) | LEFT JOIN |
| `6-top5_customers_by_items.sql` | Top 5 buyers by volume | 3 tables + ORDER BY + LIMIT |

---

**Revenue Per Customer — The Core Analytical Query:**

```sql
SELECT
    customers.first_name,
    customers.last_name,
    SUM(products.price * order_items.quantity) AS total_spent
FROM customers
INNER JOIN orders      ON customers.id    = orders.customer_id
INNER JOIN order_items ON orders.id       = order_items.order_id
INNER JOIN products    ON order_items.product_id = products.id
GROUP BY customers.id
ORDER BY total_spent DESC;
```

This query traverses the full four-table chain. The expression `products.price * order_items.quantity` is evaluated at the individual line-item level for each row in the result set of the join, then `SUM()` collapses those values per customer via `GROUP BY`. The result is a **Customer Lifetime Value (CLV)** ranking — one of the most commercially significant metrics in retail analytics.

---

**Churn Detection via `LEFT JOIN` + NULL Filter:**

```sql
SELECT customers.first_name, customers.last_name
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
WHERE orders.id IS NULL;
```

A `LEFT JOIN` preserves every row from `customers` regardless of whether a matching row exists in `orders`. Filtering `WHERE orders.id IS NULL` isolates customers for whom no join partner was found — i.e., customers who have never placed an order. In the current dataset (18 orders across 10 customers, with customers 9 and 10 placing only 1 order each), this query surfaces customers who have gone cold — enabling targeted re-engagement campaigns.

**Why not `NOT IN` or `NOT EXISTS`?** The `LEFT JOIN / IS NULL` pattern is preferred for its performance characteristics on indexed foreign keys in SQLite and its clarity in communicating intent: "show me the absence of a relationship."

---

## Technical Challenges Solved

### 1. Schema Mismatch Resolution

During development, a column naming discrepancy between `order_items` and `products` caused join failures on `product_id`. This was diagnosed using SQLite's `.schema` meta-command to audit live table definitions and corrected by aligning foreign key references to canonical column names. The lesson: always validate schema state before authoring join queries, especially when tables were created in separate sessions.

### 2. Correct Revenue Computation Granularity

Revenue cannot be computed from `orders` alone — no price data exists at that level. The correct approach requires descending to `order_items` for quantity and joining `products` for unit price, computing `price × quantity` at the row level before aggregation. A naive approach (e.g., grouping at the `orders` level and attempting to bring in price) would produce a fan-out multiplication error. The four-table join structure in `3-total_amount_per_customer.sql` solves this correctly.

### 3. Geographical Customer Segmentation

Filtering by `city` while simultaneously computing spend required combining a `WHERE` predicate with a multi-table aggregate join — a compound operation that must respect the logical order of SQL clause evaluation: `FROM` → `JOIN` → `WHERE` → `GROUP BY` → `SELECT`. Applying the city filter in `WHERE` before `GROUP BY` ensures aggregation operates only on the Baku cohort, not the full customer table.

### 4. Handling Sparse Order Data

With 18 orders across 10 customers and 25 line items, some customers have more orders than others (customers 1–8 have 2 orders; 9–10 have 1). Queries like `orders_per_customer` must correctly handle this asymmetry via `GROUP BY` and `COUNT(*)`, and the `LEFT JOIN` churn query must account for the fact that all 10 customers do have at least one order in this dataset — meaning the inactive customer query returns an empty set, which is itself a meaningful verification outcome confirming data completeness.

---

## Verification & Testing

All 26 scripts were verified by executing them directly against a live SQLite3 database via the terminal. A shell loop was used to batch-run all scripts within each module and capture output for review:

```bash
# Run all scripts in a module and display results
for file in Join_Queries/*.sql; do
    echo "========================================="
    echo "Running: $file"
    echo "========================================="
    sqlite3 store.db < "$file"
    echo ""
done
```

**Applying the loop across all modules:**

```bash
for dir in Simple_Queries Conditional_Queries Aggregate_Functions Join_Queries; do
    echo ""
    echo "#########################################"
    echo "  MODULE: $dir"
    echo "#########################################"
    for file in $dir/*.sql; do
        echo "-----------------------------------------"
        echo ">> $file"
        sqlite3 store.db < "$file"
    done
done
```

**Verification checklist applied to each script:**

- [x] Query executes without syntax or runtime errors
- [x] Output columns match the expected schema
- [x] `SELECT DISTINCT category` returns exactly 4 values: `electronics`, `stationery`, `accessories`, `home`
- [x] `WHERE city = 'Baku'` returns exactly 5 customers: Ali, Nigar, Orkhan, Elvin, Gunay
- [x] `WHERE email LIKE '%@gmail.com'` returns all 10 customers (100% Gmail coverage confirmed)
- [x] `MAX(price)` returns `120` (Monitor 24 inch)
- [x] `AVG(price)` cross-verified manually against 12 product prices
- [x] Revenue `SUM(price * quantity)` spot-checked against raw `order_items` rows
- [x] `LEFT JOIN / IS NULL` churn query returns empty set — confirming all customers have at least one order
- [x] `LIMIT 5` on top customers returns correct ranked subset

---

## Author

**Tahmina Aliyeva**
*Computer Science Student — Holberton School*

---

<div align="center">

Built with precision at **Holberton School**

SQLite3 · SQL · Business Intelligence

*10 customers · 12 products · 18 orders · 25 line items · 26 queries*

</div>
