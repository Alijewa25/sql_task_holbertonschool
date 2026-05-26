SELECT 
    customers.first_name, 
    customers.last_name, 
    SUM(order_items.quantity) AS total_purchased
FROM orders
JOIN customers ON orders.customer_id = customers.id
JOIN order_items ON orders.id = order_items.order_id
GROUP BY customers.id
ORDER BY total_purchased DESC
LIMIT 5