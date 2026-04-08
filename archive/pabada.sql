SELECT 
    k.TABLE_NAME,
    k.COLUMN_NAME,
    k.constraint_name,
    i.is_nullable,
    i.column_type
FROM 
    information_schema.columns i 
JOIN 
    key_column_usage k
    ON i.table_schema = k.constraint_schema

WHERE
    i.table_schema =  'olist'
;
USE INFORMATION_SCHEMA;

USE OLIST;

/*profits < revenue < higher average order quantity 
if the customer experience is good, they'll reorder.

check for customer retention:
customers stayed intect ? reordered? then why  */

SELECT 
    c.customer_unique_id,
    COUNT(o.order_id)
FROM 
    customers c
JOIN 
    orders o 
        ON o.customer_id = c.customer_id
GROUP BY customer_unique_id
ORDER BY 2 DESC; -- 

SELECT MIN(order_purchase_timestamp),MAX(order_purchase_timestamp) FROM orders;

SELECT COUNT(order_id) from orders;

/*How many users placed more than 1 order?*/


WITH user_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
total AS (
    SELECT COUNT(*) AS total_users FROM user_orders
)
SELECT 
    '1 order' AS category,
    COUNT(*) AS users,
    ROUND(COUNT(*) * 100.0 / (SELECT total_users FROM total), 2) AS percentage
FROM user_orders
WHERE order_count = 1

UNION ALL

SELECT 
    '2 orders',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT total_users FROM total), 2)
FROM user_orders
WHERE order_count = 2

UNION ALL

SELECT 
    '3 orders',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT total_users FROM total), 2)
FROM user_orders
WHERE order_count = 3

UNION ALL

SELECT 
    '4+ orders',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT total_users FROM total), 2)
FROM user_orders
WHERE order_count >= 4;


/*translating the product type */
CREATE VIEW product_enriched AS 
(
    P.*,

);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/program_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_category_name, product_category_name_english);

CREATE TABLE product_category_name_translation(
 product_category_name VARCHAR(200),
 product_category_name_english VARCHAR(200)
);

