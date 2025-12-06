-- Query 1: SELECT using ORDER BY two or more columns
SELECT trip_id, trip_name, destination, start_date
FROM TRIP
ORDER BY start_date ASC, trip_name ASC;

-- Query 2: SELECT using a calculated field
SELECT expense_id, category, amount, amount * 1.10 AS total_with_tax
FROM EXPENSE
WHERE trip_id = 1;

-- Query 3: SELECT using a MariaDB function
SELECT trip_name, start_date, MONTH(start_date) AS month_number
FROM TRIP
WHERE destination = 'New York';

-- Query 4: Aggregation with GROUP BY and HAVING
SELECT trip_id, SUM(amount) AS total_expenses
FROM EXPENSE
GROUP BY trip_id
HAVING total_expenses > 100;

-- Query 5: Join of three tables
SELECT T.trip_name, H.hotel_name, SUM(E.amount) AS total_expenses
FROM TRIP T
INNER JOIN HOTEL H ON T.trip_id = H.trip_id
INNER JOIN EXPENSE E ON T.trip_id = E.trip_id
GROUP BY T.trip_name, H.hotel_name
LIMIT 5;

-- Query 6: LEFT JOIN
SELECT T.trip_name, F.item_type, F.rating
FROM TRIP T
LEFT JOIN FAVORITE F ON T.trip_id = F.trip_id
WHERE T.trip_id = 3;

-- Query 7: UPDATE query
UPDATE HOTEL
SET price_per_night = 180
WHERE hotel_name = 'Ocean Breeze Resort';

-- Query 8: DELETE query
DELETE FROM EXPENSE
WHERE expense_id = 95;

-- Query 9: Create a View
CREATE OR REPLACE VIEW trip_summary AS
SELECT T.trip_id, T.trip_name, H.hotel_name, AVG(E.amount) AS avg_expense
FROM TRIP T
INNER JOIN HOTEL H ON T.trip_id = H.trip_id
INNER JOIN EXPENSE E ON T.trip_id = E.trip_id
GROUP BY T.trip_id, H.hotel_name;

-- Query 10: Transaction with ROLLBACK
START TRANSACTION;
UPDATE HOTEL SET price_per_night = 200 WHERE hotel_name = 'Ocean Breeze Resort';
UPDATE HOTEL SET price_per_night = 190 WHERE hotel_name = 'Midtown Conference Hotel';
ROLLBACK;
