-- Insert new data
INSERT INTO core.customers
SELECT DISTINCT
	s.customer_id,
	s.customer_name,
	s.segment
FROM stage.superstore_raw s
LEFT JOIN core.customers c
ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

INSERT INTO core.products
SELECT DISTINCT
	s.product_id,
	s.category,
	s.sub_category,
	s.product_name
FROM stage.superstore_raw s
LEFT JOIN core.products p
ON s.product_id = p.product_id
WHERE p.product_id IS NULL;

INSERT INTO core.orders
SELECT DISTINCT
	s.order_id,
	s.order_date,
	s.ship_date,
	s.ship_mode,
	s.customer_id
FROM stage.superstore_raw s
LEFT JOIN core.orders o
ON s.order_id = o.order_id
WHERE o.order_id IS NULL;

INSERT INTO core.order_items
SELECT
	s.row_id,
	s.order_id,
	s.product_id,
	s.sales,
	s.quantity,
	s.discount,
	s.profit
FROM stage.superstore_raw s
LEFT JOIN core.order_items oi
ON s.row_id = oi.row_id
WHERE oi.row_id IS NULL;