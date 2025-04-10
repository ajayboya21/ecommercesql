use ecommercedata;
# Use SELECT, WHERE, ORDER BY, GROUP BY
SELECT 
    brand_name,
    COUNT(product_name) AS total_products,
    AVG(rating) AS average_rating,
    AVG(discount_percent) AS avg_discount
FROM 
    ecommerce
WHERE 
    rating >= 4.0
GROUP BY 
    brand_name
ORDER BY 
    avg_discount DESC;
# Use Subqueries
SELECT brand_name, AVG(rating) AS avg_rating
FROM (
    SELECT brand_name, rating
    FROM ecommerce
    WHERE rating > 0
) AS rated_products
GROUP BY brand_name
HAVING COUNT(*) > 10
ORDER BY avg_rating DESC
LIMIT 5;
# Use aggregate functions (SUM, AVG)
SELECT 
    product_tag,
    COUNT(*) AS total_products,
    SUM(discount_amount) AS total_discount_amount,
    AVG(discount_amount) AS average_discount_amount,
    AVG(discount_percent) AS average_discount_percent
FROM ecommerce
WHERE discount_amount > 0
GROUP BY product_tag
ORDER BY total_discount_amount DESC;
# Create views for analysis
CREATE VIEW brand_discount_summary AS
SELECT 
    brand_name,
    COUNT(*) AS total_products,
    SUM(discount_amount) AS total_discount_amount,
    AVG(discount_amount) AS avg_discount_amount,
    AVG(discount_percent) AS avg_discount_percent
FROM ecommerce
WHERE discount_amount > 0
GROUP BY brand_name;
# Optimize queries with indexes
## Index to speed up WHERE clause
CREATE INDEX idx_discount_percent ON ecommerce(discount_percent);
## Index for filtering on rating
CREATE INDEX idx_rating ON ecommerce(rating);
## Index for grouping by brand
CREATE INDEX idx_brand_name ON ecommerce(brand_name);
#Inner Join
SELECT e.brand_name, b.brand_category, e.product_name, e.rating
FROM ecommerce e
INNER JOIN brands_info b
ON e.brand_name = b.brand_name;
#Left Join
SELECT e.brand_name, b.brand_category, e.product_name, e.rating
FROM ecommerce e
LEFT JOIN brands_info b
ON e.brand_name = b.brand_name;
#Right Join
SELECT e.brand_name, b.brand_category, e.product_name, e.rating
FROM ecommerce e
RIGHT JOIN brands_info b
ON e.brand_name = b.brand_name;

