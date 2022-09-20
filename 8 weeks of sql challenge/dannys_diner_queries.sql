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
	MIN(order_date) AS order_date,
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

-- Which item was the most popular for each customer?

SELECT *
FROM (SELECT 
	customer_id,
	product_name,
	COUNT(product_id) AS total_product
FROM all_tables
WHERE customer_id = 'A'
GROUP BY product_id
UNION
SELECT 
	customer_id,
	product_name,
	COUNT(product_id) AS total_product
FROM all_tables
WHERE customer_id = 'B'
GROUP BY product_id
ORDER BY total_product DESC
LIMIT 1
) AS customer_A_popular_item
UNION 
SELECT * 
FROM (SELECT 
	customer_id,
	product_name,
	COUNT(product_id) AS total_product
FROM all_tables
WHERE customer_id = 'B'
GROUP BY product_id
UNION
SELECT 
	customer_id,
	product_name,
	COUNT(product_id) AS total_product
FROM all_tables
WHERE customer_id = 'B'
GROUP BY product_id
ORDER BY total_product DESC
LIMIT 1
) AS customer_B_popular_item;


-- Which item was purchased first by the customer after they became a member?

SELECT 
	customer_id,
    product_name,
	MIN(order_date)
FROM all_tables
WHERE order_date >= join_date AND customer_id = 'A'
UNION
SELECT 
	customer_id,
    product_name,
	MIN(order_date)
FROM all_tables
WHERE order_date >= join_date AND customer_id = 'B';

-- What is the total items and amount spent for each member before they became a member?

SELECT 
	customer_id,
    COUNT(product_id) AS total_item,
    SUM(price) AS total_price
FROM all_tables
WHERE order_date < join_date
GROUP BY customer_id
ORDER BY customer_id;

-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT * FROM all_tables;
    
    