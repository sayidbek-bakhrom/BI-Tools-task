-- Load core tables
INSERT INTO core.customers
SELECT DISTINCT
	customer_id,
	customer_name,
	segment
FROM stage.superstore_raw;


INSERT INTO core.products
SELECT DISTINCT
	product_id,
	category,
	sub_category,
	product_name
FROM stage.superstore_raw
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO core.orders
SELECT DISTINCT
	order_id,
	order_date,
	ship_date,
	ship_mode,
	customer_id
FROM stage.superstore_raw;

INSERT INTO core.order_items
SELECT
	row_id,
	order_id,
	product_id,
	sales,
	quantity,
	discount,
	profit
FROM stage.superstore_raw;



--- lodad mart tables

INSERT INTO mart.dim_customer (
	customer_id,
	customer_name,
	segment,
	region,
	valid_from,
	valid_to,
	is_current
)
SELECT DISTINCT
	customer_id,
	customer_name,
	segment,
	region,
	CURRENT_DATE,
	NULL::DATE,
	TRUE
FROM stage.superstore_raw;


INSERT INTO mart.dim_product (
	product_id,
	category,
	sub_category,
	product_name
)
SELECT DISTINCT
	product_id,
	category,
	sub_category,
	product_name
FROM stage.superstore_raw;


INSERT INTO mart.fact_sales (
	order_id,
	customer_key,
	product_key,
	order_date,
	sales,
	quantity,
	discount,
	profit
)
SELECT
	s.order_id,
	dc.customer_key,
	dp.product_key,
	s.order_date,
	s.sales,
	s.quantity,
	s.discount,
	s.profit
FROM stage.superstore_raw s
JOIN mart.dim_customer dc
ON s.customer_id = dc.customer_id
AND dc.is_current = TRUE
JOIN mart.dim_product dp
ON s.product_id = dp.product_id


