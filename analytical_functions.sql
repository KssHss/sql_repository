-- 1. What is the price of the least expensive product?

USE analyst;

SELECT MIN(price) FROM products;

-- 2. Which product is least expensive?

USE analyst;

SELECT brand, name, price
FROM products
WHERE price = (SELECT min (price) FROM products) ;



SELECT brand, name, price
FROM products
CROSS JOIN
  (SELECT min (price) AS m FROM products) x 
WHERE price = m ;



SELECT brand, name, price
FROM (
  SELECT brand, name, price, MIN( price) OVER() AS m FROM products ) x
WHERE price = m ;


-- 3. What is the price of the least expensive product in each brand?

USE analyst;

SELECT brand, MIN(price) AS m
FROM products
GROUP BY brand
ORDER BY m;



SELECT DISTINCT brand, m
FROM (
  SELECT brand, MIN(price) OVER(PARTITION BY brand) m
  FROM products
  ) x 
ORDER BY m;


-- 4. What is difference between a product's price and the minimum price for that brand?

USE analyst;

SELECT p.brand, name, price, m, price - m AS diff
FROM products p
JOIN (
  SELECT brand, MIN(price) as m
  FROM products
  GROUP BY brand
  ) a
ON p.brand = a.brand
ORDER BY brand, diff ;



SELECT brand, name, price,
	MIN(price) OVER(PARTITION BY brand) AS m,
	price - MIN(price) OVER(PARTITION BY brand) AS diff
FROM products
ORDER BY brand, diff ;



SELECT brand, name, price, m, price -m AS diff
FROM (
  SELECT brand, name, price, 
    MIN( price ) OVER( PARTITION BY brand ) AS m
    FROM products ) x
ORDER BY brand, diff ;


-- 6. What is the second lowest price? What is the fifth lower?

USE analyst ;

SELECT MIN( price ) FROM products
WHERE price > 
  ( SELECT MIN( price ) FROM products ) ;


SELECT DISTINCT price
FROM products
ORDER BY price
LIMIT 1
OFFSET 4 ;


SELECT DISTINCT price
FROM (
  SELECT price, DENSE_RANK() OVER( ORDER BY price ) AS rnk
  FROM products
  ) x
WHERE rnk = 5 ;
