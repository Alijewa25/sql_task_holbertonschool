SELECT
    customers.first_name,
    customers.last_name,
    customers.email
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
WHERE orders.id IS NULL