-- Drop the view first (if it exists)
DROP VIEW IF EXISTS trip_summary;

-- Drop tables in order to avoid foreign key conflicts
DROP TABLE IF EXISTS FAVORITE;
DROP TABLE IF EXISTS EXPENSE;
DROP TABLE IF EXISTS HOTEL;
DROP TABLE IF EXISTS ACTIVITY;
DROP TABLE IF EXISTS FLIGHT;
DROP TABLE IF EXISTS TRIP;

-- Optional: confirm deletion by checking tables
SHOW TABLES;
