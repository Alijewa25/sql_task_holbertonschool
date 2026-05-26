INSERT INTO customers (id, first_name, last_name, email, city) VALUES
(1, 'Ali', 'Aliyev', 'ali.a@example.com', 'Baku'),
(2, 'Leyla', 'Mammadova', 'leyla.m@example.com', 'Ganja'),
(3, 'Murad', 'Hasanov', 'murad.h@example.com', 'Baku'),
(4, 'Aysel', 'Ismayilova', 'aysel.i@example.com', 'Sumqayit');

INSERT INTO products (id, name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Mouse', 'Electronics', 25.50),
(3, 'Desk Lamp', 'Home', 45.00),
(4, 'Ballpoint Pen', 'Stationery', 1.50),
(5, 'Monitor 24 inch', 'Electronics', 120.00);

INSERT INTO orders (id, customer_id, order_date) VALUES
(1, 1, '2024-05-01'),
(2, 2, '2024-05-02'),
(3, 1, '2024-05-03');

INSERT INTO order_items (id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 4, 10);