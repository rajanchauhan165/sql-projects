-- 1
SELECT s.store_id AS Store, CONCAT(s.first_name," ", s.last_name) AS Manager, a.address AS Street, a.district AS District, c.city AS City, cc.country AS Country
FROM staff s
INNER JOIN store st ON s.store_id=st.store_id
INNER JOIN address a ON st.address_id=a.address_id
INNER JOIN city c ON a.city_id=c.city_id
INNER JOIN country cc ON c.country_id=cc.country_id
;

-- 2
SELECT i.store_id AS Store_Id, i.inventory_id AS Inventory_Id, f.title AS Film, f.rating AS Rating, f.rental_rate AS Rental_Rate, f.replacement_cost AS Replacement_Cost
FROM inventory i 
LEFT JOIN film f ON i.film_id=f.film_id
;

-- 3
SELECT i.store_id AS Store_Id, f.rating AS Rating, COUNT(i.inventory_id) AS Inventory, SUM(f.rental_rate) AS Rental_Rate, SUM(f.replacement_cost) AS Replacement_Cost
FROM inventory i 
LEFT JOIN film f ON i.film_id=f.film_id
GROUP BY Rating, Store_Id;


