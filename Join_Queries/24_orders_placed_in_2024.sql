SELECT
    orders.id,
    products.name,
    order_items.quantity,
    orders.order_date
FROM orders
JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON order_items.product_id = products.id
WHERE orders.order_date LIKE '2024%'