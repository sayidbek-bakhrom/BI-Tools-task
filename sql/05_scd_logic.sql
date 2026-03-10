UPDATE mart.dim_customer dc
SET customer_name = s.customer_name,
	segment = s.segment
FROM stage.superstore_raw s
WHERE dc.customer_id = s.customer_id
AND dc.is_current = TRUE
AND (
	dc.customer_name <> s.customer_name
	OR dc.segment <> s.segment
);

-- Expird old record
UPDATE mart.dim_customer dc
SET valid_to = CURRENT_DATE,
	is_current = FALSE
FROM stage.superstore_raw s
WHERE dc.customer_id = s.customer_id
AND dc.region <> s.region
AND dc.is_current = TRUE

-- Insert new version
INSERT INTO mart.dim_customer (
	customer_id,
	customer_name,
	segment,
	region,
	valid_from,
	valid_to,
	is_current
)
SELECT
	s.customer_id,
	s.customer_name,
	s.segment,
	s.region,
	CURRENT_DATE,
	NULL,
	TRUE
FROM stage.superstore_raw s
JOIN mart.dim_customer dc
ON s.customer_id = dc.customer_id
WHERE dc.region <> s.region
AND dc.is_current = FALSE;