-- Create Database
CREATE DATABASE online_store;
USE online_store;

-- Create Tables
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  city VARCHAR(50),
  state VARCHAR(50),
  registration_date DATE
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  price DECIMAL(10, 2) NOT NULL,
  stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE,
  status VARCHAR(20),
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample Data
INSERT INTO customers (first_name, last_name, email, city, state, registration_date) VALUES
('John', 'Doe', 'john@example.com', 'New York', 'NY', '2023-01-15'),
('Jane', 'Smith', 'jane@example.com', 'LA', 'CA', '2023-02-20');

INSERT INTO products (name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 1200, 50),
('T-shirt', 'Clothing', 25, 200);

INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2023-04-05', 'Delivered', 1225.00),
(2, '2023-04-10', 'Shipped', 25.00);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 25.00),
(2, 2, 1, 25.00);

-- Indexes
CREATE INDEX idx_email ON customers(email);
CREATE INDEX idx_category ON products(category);

-- Short Queries

-- Customers from CA
SELECT * FROM customers WHERE state = 'CA';

-- Products by price (desc)
SELECT * FROM products ORDER BY price DESC;

-- Orders with customer names
SELECT o.order_id, c.first_name, c.last_name, o.total_amount
FROM orders o JOIN customers c ON o.customer_id = c.customer_id;

-- Order details with products
SELECT o.order_id, p.name, oi.quantity, oi.price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Products priced above average
SELECT name, price FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Customers who spent above average
SELECT c.first_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_spent > (SELECT AVG(total_amount) FROM orders);

-- Sales by category
SELECT p.category, SUM(oi.quantity * oi.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category;

-- Create Views
CREATE VIEW customer_summary AS
SELECT c.customer_id, c.first_name, COUNT(o.order_id) AS orders, SUM(o.total_amount) AS spent
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

CREATE VIEW product_summary AS
SELECT p.product_id, p.name, SUM(oi.quantity) AS sold, SUM(oi.price * oi.quantity) AS revenue
FROM products p LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id;

-- View queries
SELECT * FROM customer_summary ORDER BY spent DESC;
SELECT * FROM product_summary ORDER BY revenue DESC;
