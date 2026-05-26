SELECT
    products.name,
    order_items.quantity,
    orders.order_date 
FROM order_items 
JOIN products
ON order_items.product_id = products.id 
JOIN orders
ON order_items.order_id = orders.id