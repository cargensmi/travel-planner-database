-- query 1
SELECT trip_name, destination, start_date, end_date
FROM TRIP
ORDER BY destination ASC, start_date DESC;

--query 2
SELECT 
    flight_id,
    price,
    price * 0.07 AS tax_amount,
    price + (price * 0.07) AS total_cost
FROM FLIGHT;

-- query 3
SELECT 
    trip_name,
    MONTH(start_date) AS start_month,
    MID(destination, 1, 3) AS dest_prefix
FROM TRIP;

-- query 4
SELECT 
    destination,
    COUNT(*) AS num_trips,
    AVG(DATEDIFF(end_date, start_date)) AS avg_trip_length
FROM TRIP
GROUP BY destination
HAVING COUNT(*) >= 2;


-- query 5
SELECT 
    t.trip_name,
    f.airline,
    h.hotel_name,
    a.activity_name
FROM TRIP t
INNER JOIN FLIGHT f ON t.trip_id = f.trip_id
INNER JOIN HOTEL h ON t.trip_id = h.trip_id
INNER JOIN ACTIVITY a ON t.trip_id = a.trip_id;

-- query 6
SELECT 
    t.trip_name,
    f.flight_num,
    f.airline
FROM TRIP t
LEFT JOIN FLIGHT f ON t.trip_id = f.trip_id;

-- query 7
UPDATE FLIGHT
SET price = price + 50
WHERE airline = 'Delta';

-- query 8
DELETE FROM TRIP
WHERE destination = 'Vermont';

-- query 9 
CREATE OR REPLACE VIEW TripCosts AS
SELECT 
    t.trip_id,
    t.trip_name,
    SUM(f.price) AS total_flight_cost
FROM TRIP t
JOIN FLIGHT f ON t.trip_id = f.trip_id
GROUP BY t.trip_id, t.trip_name;

-- use view 
SELECT * FROM TripCosts ORDER BY total_flight_cost DESC;

-- query 10
START TRANSACTION;

UPDATE FLIGHT
SET price = price * 0.5
WHERE airline = 'ANA';

-- Check results (optional)
SELECT * FROM FLIGHT WHERE airline = 'ANA';

ROLLBACK;
