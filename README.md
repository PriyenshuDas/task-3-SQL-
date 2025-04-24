# 🛒 Online Store Database (SQL Project)

This project is a simple yet robust **relational database schema** for an online e-commerce store. It includes schema creation, sample data insertion, indexes for performance optimization, and a collection of practical SQL queries for data analysis.

## 📦 Features

- Customer, Product, Order, and Order Item tables
- Proper foreign key relationships
- Indexes for optimized query performance
- Sample data to simulate real-world transactions
- Analytical queries and views for business insights

## 🧱 Database Schema

The database consists of the following tables:

- **customers** – Customer details (name, email, location)
- **products** – Product info (name, price, category, stock)
- **orders** – Orders placed by customers
- **order_items** – Products in each order

## 🗃 Sample Data

The script includes sample entries for:
- 2 Customers
- 2 Products
- 2 Orders
- Associated Order Items

This allows for immediate testing and demonstration of queries.

## 📊 Example Queries

Some of the included SQL queries:

- Fetch customers from a specific state
- List products by price (descending)
- Join orders with customer names
- Calculate revenue by product category
- Find customers who spent above average
- Identify top-performing products
- Create views for customer and product summaries

## 🧠 Views

Two helpful views are created:
- `customer_summary` – Total orders and spending by customer
- `product_summary` – Total quantity sold and revenue by product

## 🚀 Getting Started

1. Clone the repo or download the `.sql` file.
2. Run the SQL script in your MySQL-compatible DBMS (e.g., MySQL, MariaDB).
3. Start running the queries to analyze your data.

```bash
mysql -u your_user -p < online_store.sql
