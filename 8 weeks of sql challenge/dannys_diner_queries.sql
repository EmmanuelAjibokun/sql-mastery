USE dannys_dinner;

-- create view of grouped tables
CREATE OR REPLACE VIEW all_tables AS
SELECT m.customer_id,
		m.join_date,
        s.product_id,
        product_name,
        price,
        order_date
FROM members m
JOIN sales s 
	USING (customer_id)
JOIN menu me 
	ON s.product_id = me.product_id;
    
    
-- What is the total amount each customer spent at the restaurant?

SELECT 
	customer_id,
	SUM(price) AS total
FROM all_tables
GROUP BY customer_id;

-- How many days has each customer visited the restaurant?
SELECT 
	customer_id,
	COUNT(DISTINCT order_date) AS days_visited
FROM all_tables
GROUP BY customer_id;


SELECT * FROM all_tables;

-- 
    