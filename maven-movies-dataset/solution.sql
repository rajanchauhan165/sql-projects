-- 1. Please send over the managers’ names at each store, with the full address of each property (street address, district, city, and country please).
SELECT s.store_id AS Store, CONCAT(s.first_name," ", s.last_name) AS Manager, a.address AS Street, a.district AS District, c.city AS City, cc.country AS Country
FROM staff s
INNER JOIN store st ON s.store_id=st.store_id
INNER JOIN address a ON st.address_id=a.address_id
INNER JOIN city c ON a.city_id=c.city_id
INNER JOIN country cc ON c.country_id=cc.country_id
;

-- 2. Please pull together a list of each inventory item you have stocked, including the store_id number, the inventory_id, the name of the film,  the film’s rating , its rental rate and replacement cost.
SELECT i.store_id AS Store_Id, i.inventory_id AS Inventory_Id, f.title AS Film, f.rating AS Rating, f.rental_rate AS Rental_Rate, f.replacement_cost AS Replacement_Cost
FROM inventory i 
LEFT JOIN film f ON i.film_id=f.film_id
;

-- 3. We would like to know how many inventory items you have with each rating at each store. 
SELECT i.store_id AS Store_Id, f.rating AS Rating, COUNT(i.inventory_id) AS Inventory, SUM(f.rental_rate) AS Rental_Rate, SUM(f.replacement_cost) AS Replacement_Cost
FROM inventory i 
LEFT JOIN film f ON i.film_id=f.film_id
GROUP BY Rating, Store_Id;

-- 4. We would like to see   the number   of films , as well as  the average replacement cost , and total replacement cost , sliced by store  and film category.
SELECT c.name AS Category, i.store_id AS Store, COUNT(f.film_id) AS Total_Film, AVG(f.replacement_cost) AS Avg_Replacement_Cost, SUM(f.replacement_cost) AS Total_Replacement_Cost
FROM category c 
INNER JOIN film_category fc ON c.category_id=fc.category_id
INNER JOIN film f ON f.film_id=fc.film_id
INNER JOIN inventory i ON f.film_id=i.film_id
GROUP BY Category, Store
ORDER BY Total_Replacement_Cost DESC
;

-- 5. Please provide a list of all customer names, which store they go to, whether or not they are currently active, and their full addresses - street address, city, and country.
SELECT CONCAT(c.first_name, " ", c.last_name) AS Name, c.store_id as Store, c.active as Active, a.address as Street, c2.city as City, c3.country as Country
FROM customer c 
LEFT JOIN address a ON c.address_id=a.address_id
INNER JOIN city c2 ON a.city_id=c2.city_id
INNER JOIN country c3 ON c2.country_id=c3.country_id
;

-- 6. Please pull together a list of customer names, their total lifetime rentals, and the sum of all payments you have collected from them. It would be great to see this ordered on total lifetime value with the most valuable customers at the top of the list.
SELECT CONCAT(c.first_name, " ", c.last_name) AS Name, COUNT(p.rental_id) as Total_Rental, SUM(p.amount) as Total_Amount
FROM customer c LEFT JOIN payment p ON c.customer_id=p.customer_id
GROUP BY Name
ORDER BY Total_Amount DESC
;

-- 7. Could you please provide a list of advisor and investor names in one table? Could you please note whether they are an investor or an advisor, and for the investors, it would be good to include which company they work with.
SELECT "Investor" AS Type, CONCAT(first_name, " ", last_name) AS Name, company_name AS Company FROM investor
UNION
SELECT "Advisor" AS Type, CONCAT(first_name, " ", last_name) AS Name, NULL FROM advisor;

-- 8. Of all the actors with three types of awards, how many of them do we carry a film? And how about for actors with two types of awards? Same questions. Finally, how about actors with just one award?
SELECT CONCAT(a.first_name, " ", a.last_name) AS Actor_Name,
CASE
WHEN a.awards = "Emmy, Oscar, Tony " THEN "3 Awards"
WHEN a.awards IN ("Emmy, Tony","Emmy, Oscar","Oscar Tony") THEN "2 Awards"
ELSE "1 Award" END AS Number_Of_Award,
COUNT(f.film_id) AS Number_Of_Film
FROM actor_award a LEFT JOIN film_actor f ON a.actor_id=f.actor_id
GROUP BY Actor_NAme
;