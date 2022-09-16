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

-- What was the first item from the menu purchased by each customer?

SELECT 
	customer_id,
	Min(order_date),
    product_name
FROM all_tables
GROUP BY customer_id
ORDER BY customer_id;

-- What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT 
	COUNT(product_id) AS total_sales,
    product_name
FROM all_tables
GROUP BY product_id
ORDER BY total_sales DESC;

SELECT * FROM all_tables;
    
    