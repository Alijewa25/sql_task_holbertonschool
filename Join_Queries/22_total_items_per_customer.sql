SELECT
    customers.first_name,
    customers.last_name,
    SUM(order_items.quantity) AS total_items
FROM customers
JOIN orders
ON customers.id = orders.customer_id
JOIN order_items
ON orders.id = order_items.order_id
GROUP BY customers.id;