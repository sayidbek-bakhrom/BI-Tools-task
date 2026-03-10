-- STAGE TABLE
CREATE TABLE stage.superstore_raw (
	row_id INTEGER,
	order_id TEXT,
	order_date TEXT,
	ship_date TEXT,
	ship_mode TEXT,
	customer_id TEXT,
	customer_name TEXT,
	segment TEXT,
	country TEXT,
	city TEXT,
	state TEXT,
	postal_code TEXT,
	region TEXT,
	product_id TEXT,
	category TEXT,
	sub_category TEXT,
	product_name TEXT,
	sales NUMERIC,
	quantity INTEGER,
	discount NUMERIC,
	profit NUMERIC
);

-- since CSV data format is DD/MM/YYY
-- we take these as text for loading then convert into date
ALTER TABLE stage.superstore_raw
ALTER COLUMN order_date TYPE date
USING to_date(order_date, 'DD/MM/YYYY'),
ALTER COLUMN ship_date TYPE date
USING to_date(ship_date, 'DD/MM/YYYY');


-- CORE LAYER (3NF)
CREATE TABLE core.customers (
	customer_id TEXT PRIMARY KEY,
	customer_name TEXT,
	segment TEXT
);

CREATE TABLE core.products (
	product_id TEXT PRIMARY KEY,
	category TEXT,
	sub_category TEXT,
	product_name TEXT
);

CREATE TABLE core.orders (
	order_id TEXT PRIMARY KEY,
	order_date DATE,
	ship_date DATE,
	ship_mode TEXT,
	customer_id TEXT REFERENCES core.customers(customer_id)
);

CREATE TABLE core.order_items (
	row_id INTEGER PRIMARY KEY,
	order_id TEXT REFERENCES core.orders(order_id),
	product_id TEXT REFERENCES core.products(product_id),
	sales NUMERIC,
	quantity INTEGER,
	discount NUMERIC,
	profit NUMERIC
);


-- MART LAYER (STAR SCHEMA)
CREATE TABLE mart.dim_customer (
	customer_key SERIAL PRIMARY KEY,
	customer_id TEXT,
	customer_name TEXT,
	segment TEXT,
	region TEXT,
	valid_from DATE,
	valid_to DATE,
	is_current BOOLEAN
);

CREATE TABLE mart.dim_product (
	product_key SERIAL PRIMARY KEY,
	product_id TEXT,
	category TEXT,
	sub_category TEXT,
	product_name TEXT
);

CREATE TABLE mart.fact_sales (
	sales_key SERIAL PRIMARY KEY,
	order_id TEXT,
	customer_key INT,
	product_key INT,
	order_date DATE,
	sales NUMERIC,
	quantity INT,
	discount NUMERIC,
	profit NUMERIC
);