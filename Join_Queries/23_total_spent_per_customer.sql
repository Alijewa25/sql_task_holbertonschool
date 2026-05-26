SELECT
    customers.first_name,
    customers.last_name,
    SUM(products.price * order_items.quantity) AS total_spent
FROM customers
JOIN orders
ON customers.id = orders.customer_id
JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id
GROUP BY customers.id