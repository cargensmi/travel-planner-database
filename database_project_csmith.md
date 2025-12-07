# CS415 Database Project – Travel Database

## Database Summary Report

### Project Overview

The user of this database would be someone interested in taking a recreational trip. The system is helpful in managing expenses, flight itineraries, scheduled activities, and hotel stays. It is best used for keeping separate trips organized, and helping the user stay aware of money spending to prevent exceeding their self-allotted budget. The hope is that the efficiency of the database helps make traveling informative, and stress-free. For anyone who has ever taken a trip before, they know that information can often get lost in confirmation emails, digital receipts, and various apps. This database should eliminate the stress of trying to find scattered information while traveling, and instead place it all in one location so that the user can enjoy their vacation in a leisurely manner. It also gets rid of the awkward hassle of telling the receptionist at various welcome desks that they need a moment to find their travel confirmation details.

### Users View

The user will begin by creating a trip, in which they can add flights, hotel stays, and scheduled activities in their various locations. Users can also add expenses at any time throughout the trip. Once the user has decided to start a new trip, they have the ability to switch between the various categories with ease as they add to or modify their trip details. Within each category, the user will also be able to manually edit any trip-specific details. Within the database, the user will be able to view their upcoming flights, get a list of their hotel stays, view each day’s itinerary, and view expenses organized by category, as well as total trip cost. To make navigating the database more efficient, each section will have a search bar that will make finding confirmation numbers and addresses easier to find instantly. The ability to see the total trip cost will also help the user compare past trips with future trips when it comes to budgeting and long-term planning. They will also be able to star anything they find preferable throughout their trip such as restaurants, hotels, airlines, etc., which will also help in future trip-planning.

## Database ER Model

![ER Diagram](Travel_Database_ER_Diagram.png)

## Database Design Description

I chose to make the “Trip” table be the parent table as it is the broader category of every other aspect of traveling. I had five other tables: Flight, Hotel, Activity, Expense, and Favorite. Each one of these has a one-to-many relationship with the parent table, “Trip”. This is because there will always be one trip, but there can be multiple of each of the other categories. All five of the relationships shown support 3rd Normal Form. Every child table depends on its specific primary key which avoids redundancy. 
For the purpose of user-friendliness, I had added the “Favorite” table after my initial design because I figured it would be easier to navigate past trips and see which experiences were preferable over others. This allowed the database to be a tool used for ensuring each future trip is more enjoyable than the previous, rather than simply storing past data. I see the favorites trip as the summary table of all other important information in the database as a whole. If the user were to need to plan a trip in a hurry, this table allows them to have the important data condensed into one table. 

```TRIP``` The trip table is the parent table in the travel database. It ensures every trip has a unique ID for linking other tables. It contains the trip ID, name of the trip, destination, start date, end date, and any notes about the trip that the user wants to input. 

```FLIGHT``` The flight table organizes information about airlines, flight numbers, the dates that the user departs and arrives, the airports the user departs from and arrives to, and the cost of any and all flight expenses. 

```HOTEL``` The hotel table organizes information as it relates to hotel stays. It includes the names of hotels, checkin and checkout dates, the address of the hotel, and the cost per night at the hotel. This table helps the user easily access information about hotel reservations, cutting town time, and increasing efficiency. 

```ACTIVITY``` The activity table organizes information about individual experiences the user chooses to partake in during their travel. This could include restaurants, theater performances, wild-life exhibits, etc. The table includes information about the date, location, cost, and category of each activity. The category key is a useful feature as it helps break a long list of data into smaller groups that are easier to locate more quickly. 

```EXPENSE``` The expense table includes information about the category, amount, description, and date of each expense on the trip. This is a rather helpful table in the database as it helps with the logistics of what all the user and their party can partake in as it fits into their budget. 

```FAVORITE``` The favorite table includes the item type, item ID, and rating of that item. This includes the user’s numerical ratings of all individual experiences during their trip. It is a helpful feature that allows the user to quickly see which hotels, airlines, restaurants, etc. they enjoyed the most. 


### Create Tables

```sql
-- Drop tables if they exist (optional but helpful during testing)
DROP TABLE IF EXISTS FLIGHT;
DROP TABLE IF EXISTS EXPENSE;
DROP TABLE IF EXISTS ACTIVITY;
DROP TABLE IF EXISTS FAVORITE;
DROP TABLE IF EXISTS HOTEL;
-- must drop child tables before parent
DROP TABLE IF EXISTS TRIP;

-- Create TRIP table
CREATE TABLE TRIP (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_name VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    notes TEXT
) ENGINE=InnoDB;

-- Create FLIGHT table
CREATE TABLE FLIGHT (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    airline VARCHAR(100),
    flight_num VARCHAR(20),
    depart_date DATE,
    arrive_date DATE,
    depart_airport VARCHAR(50),
    arrive_airport VARCHAR(50),
    price DECIMAL(10,2),
    FOREIGN KEY (trip_id) REFERENCES TRIP(trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Create HOTEL table
CREATE TABLE HOTEL (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    hotel_name VARCHAR(100) NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    address VARCHAR(255),
    price_per_night INT,
    INDEX idx_hotel_trip (trip_id),
    FOREIGN KEY (trip_id) REFERENCES TRIP(trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Create ACTIVITY table
CREATE TABLE ACTIVITY (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    activity_date DATE NOT NULL,
    location VARCHAR(150),
    cost DECIMAL(10,2),
    category VARCHAR(100),
    INDEX idx_activity_trip (trip_id),
    FOREIGN KEY (trip_id) REFERENCES TRIP(trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Create EXPENSE table
CREATE TABLE EXPENSE (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    category VARCHAR(100),
    amount DECIMAL(10,2),
    description TEXT,
    expense_date DATE,
    INDEX idx_expense_trip (trip_id),
    INDEX idx_expense_category (category),
    FOREIGN KEY (trip_id) REFERENCES TRIP(trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Create FAVORITE table
CREATE TABLE FAVORITE (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    item_type VARCHAR(50),
    item_id INT,
    rating INT,
    INDEX idx_favorite_trip (trip_id),
    INDEX idx_favorite_item (item_id),
    FOREIGN KEY (trip_id) REFERENCES TRIP(trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB; 
```

### Insert Data

```sql
-- ================================
-- INSERT DATA FOR TRIP (20 rows -- 20 trips)
-- ================================
INSERT INTO TRIP (trip_name, destination, start_date, end_date, notes) VALUES
('Hawaii Vacation', 'Honolulu', '2025-01-10', '2025-01-20', 'Beach trip and hiking'),
('Business Conference', 'New York', '2025-02-05', '2025-02-10', 'Tech leadership summit'),
('Family Reunion', 'Chicago', '2025-03-12', '2025-03-18', 'Annual family gathering'),
('Spring Break', 'Miami', '2025-03-25', '2025-04-02', 'Relaxation and nightlife'),
('European Tour', 'London', '2025-04-10', '2025-04-25', 'Visiting multiple countries'),
('Desert Adventure', 'Phoenix', '2025-05-01', '2025-05-10', 'Exploring desert landscapes'),
('National Park Trip', 'Denver', '2025-05-15', '2025-05-25', 'Visiting Rocky Mountain NP'),
('Summer Beach Trip', 'San Diego', '2025-06-05', '2025-06-15', 'Surfing and relaxation'),
('Solo Retreat', 'Seattle', '2025-07-01', '2025-07-08', 'Mental reset and hiking'),
('Wedding Trip', 'Nashville', '2025-07-20', '2025-07-25', 'Cousin’s wedding'),
('Girls Getaway', 'Las Vegas', '2025-08-03', '2025-08-08', 'Shows and food'),
('Road Trip End', 'Portland', '2025-08-15', '2025-08-25', 'Finishing West Coast road trip'),
('Fall Colors Trip', 'Boston', '2025-09-25', '2025-10-02', 'Leaf-peeping'),
('Mountain Retreat', 'Salt Lake City', '2025-10-10', '2025-10-18', 'Cabin in the mountains'),
('Holiday Markets', 'Munich', '2025-11-20', '2025-12-05', 'German Christmas markets'),
('Tropical Winter Escape', 'San Juan', '2025-12-15', '2025-12-23', 'Warm beaches'),
('Weekend Escape', 'Atlanta', '2025-01-05', '2025-01-08', 'Quick getaway'),
('Work Trip', 'Houston', '2025-02-14', '2025-02-18', 'Meetings and training'),
('City Exploring', 'Philadelphia', '2025-03-05', '2025-03-10', 'Historic tours'),
('Cultural Immersion', 'Tokyo', '2025-04-01', '2025-04-15', 'Cherry blossom season');

-- ================================
-- INSERT DATA FOR FLIGHT (120 rows)
-- 6 flights per trip × 20 trips
-- ================================
INSERT INTO FLIGHT (trip_id, airline, flight_num, depart_date, arrive_date, depart_airport, arrive_airport, price) VALUES
-- Trip 1
(1,'Delta','DL101','2025-01-10','2025-01-10','BOS','HNL',650.00),
(1,'Delta','DL102','2025-01-20','2025-01-20','HNL','BOS',640.00),
(1,'United','UA410','2025-01-11','2025-01-11','HNL','OGG',120.00),
(1,'United','UA411','2025-01-14','2025-01-14','OGG','HNL',125.00),
(1,'Hawaiian','HA90','2025-01-15','2025-01-15','HNL','ITO',150.00),
(1,'Hawaiian','HA91','2025-01-18','2025-01-18','ITO','HNL',155.00),

-- Trip 2
(2,'American','AA220','2025-02-05','2025-02-05','BOS','JFK',180.00),
(2,'American','AA221','2025-02-10','2025-02-10','JFK','BOS',175.00),
(2,'United','UA510','2025-02-06','2025-02-06','JFK','ORD',130.00),
(2,'United','UA511','2025-02-09','2025-02-09','ORD','JFK',135.00),
(2,'JetBlue','B6100','2025-02-07','2025-02-07','JFK','BUF',90.00),
(2,'JetBlue','B6101','2025-02-08','2025-02-08','BUF','JFK',95.00),

-- Trip 3
(3,'Delta','DL300','2025-03-12','2025-03-12','BOS','ORD',200.00),
(3,'Delta','DL301','2025-03-18','2025-03-18','ORD','BOS',190.00),
(3,'United','UA330','2025-03-13','2025-03-13','ORD','MSP',110.00),
(3,'United','UA331','2025-03-17','2025-03-17','MSP','ORD',115.00),
(3,'Southwest','WN700','2025-03-14','2025-03-14','ORD','STL',85.00),
(3,'Southwest','WN701','2025-03-16','2025-03-16','STL','ORD',90.00),

-- Trip 4
(4,'United','UA440','2025-03-25','2025-03-25','BOS','MIA',220.00),
(4,'United','UA441','2025-04-02','2025-04-02','MIA','BOS',210.00),
(4,'American','AA500','2025-03-27','2025-03-27','MIA','TPA',95.00),
(4,'American','AA501','2025-03-29','2025-03-29','TPA','MIA',100.00),
(4,'Delta','DL600','2025-03-30','2025-03-30','MIA','ATL',120.00),
(4,'Delta','DL601','2025-03-31','2025-03-31','ATL','MIA',115.00),

-- Trip 5
(5,'British Airways','BA150','2025-04-10','2025-04-11','BOS','LHR',700.00),
(5,'British Airways','BA151','2025-04-25','2025-04-26','LHR','BOS',690.00),
(5,'Ryanair','FR200','2025-04-12','2025-04-12','LHR','DUB',80.00),
(5,'Ryanair','FR201','2025-04-13','2025-04-13','DUB','LHR',85.00),
(5,'EasyJet','EJ300','2025-04-14','2025-04-14','LHR','AMS',95.00),
(5,'EasyJet','EJ301','2025-04-16','2025-04-16','AMS','LHR',100.00),

-- Trip 6
(6,'American','AA600','2025-05-01','2025-05-01','BOS','PHX',340.00),
(6,'American','AA601','2025-05-10','2025-05-10','PHX','BOS',330.00),
(6,'Southwest','WN800','2025-05-03','2025-05-03','PHX','LAS',75.00),
(6,'Southwest','WN801','2025-05-05','2025-05-05','LAS','PHX',80.00),
(6,'Delta','DL750','2025-05-06','2025-05-06','PHX','SLC',120.00),
(6,'Delta','DL751','2025-05-08','2025-05-08','SLC','PHX',130.00),

-- Trip 7
(7,'United','UA200','2025-05-15','2025-05-15','BOS','DEN',260.00),
(7,'United','UA201','2025-05-25','2025-05-25','DEN','BOS',255.00),
(7,'Frontier','F900','2025-05-16','2025-05-16','DEN','COS',70.00),
(7,'Frontier','F901','2025-05-17','2025-05-17','COS','DEN',75.00),
(7,'Southwest','WN920','2025-05-18','2025-05-18','DEN','ABQ',95.00),
(7,'Southwest','WN921','2025-05-20','2025-05-20','ABQ','DEN',100.00),

-- Trip 8
(8,'Alaska','AS100','2025-06-05','2025-06-05','BOS','SAN',350.00),
(8,'Alaska','AS101','2025-06-15','2025-06-15','SAN','BOS',345.00),
(8,'Southwest','WN300','2025-06-06','2025-06-06','SAN','SFO',90.00),
(8,'Southwest','WN301','2025-06-08','2025-06-08','SFO','SAN',95.00),
(8,'Delta','DL850','2025-06-10','2025-06-10','SAN','LAX',75.00),
(8,'Delta','DL851','2025-06-12','2025-06-12','LAX','SAN',80.00),

-- Trip 9
(9,'Delta','DL900','2025-07-01','2025-07-01','BOS','SEA',320.00),
(9,'Delta','DL901','2025-07-08','2025-07-08','SEA','BOS',315.00),
(9,'Alaska','AS400','2025-07-02','2025-07-02','SEA','PDX',85.00),
(9,'Alaska','AS401','2025-07-03','2025-07-03','PDX','SEA',90.00),
(9,'United','UA770','2025-07-04','2025-07-04','SEA','DEN',150.00),
(9,'United','UA771','2025-07-06','2025-07-06','DEN','SEA',155.00),

-- Trip 10
(10,'Southwest','WN200','2025-07-20','2025-07-20','BOS','BNA',260.00),
(10,'Southwest','WN201','2025-07-25','2025-07-25','BNA','BOS',255.00),
(10,'Delta','DL110','2025-07-21','2025-07-21','BNA','ATL',90.00),
(10,'Delta','DL111','2025-07-22','2025-07-22','ATL','BNA',100.00),
(10,'United','UA230','2025-07-23','2025-07-23','BNA','ORD',140.00),
(10,'United','UA231','2025-07-24','2025-07-24','ORD','BNA',145.00),

-- Trip 11
(11,'Delta','DL430','2025-08-03','2025-08-03','BOS','LAS',305.00),
(11,'Delta','DL431','2025-08-08','2025-08-08','LAS','BOS',300.00),
(11,'Southwest','WN880','2025-08-04','2025-08-04','LAS','PHX',65.00),
(11,'Southwest','WN881','2025-08-05','2025-08-05','PHX','LAS',70.00),
(11,'United','UA540','2025-08-06','2025-08-06','LAS','LAX',95.00),
(11,'United','UA541','2025-08-07','2025-08-07','LAX','LAS',100.00),

-- Trip 12
(12,'Alaska','AS220','2025-08-15','2025-08-15','BOS','PDX',330.00),
(12,'Alaska','AS221','2025-08-25','2025-08-25','PDX','BOS',325.00),
(12,'Delta','DL280','2025-08-17','2025-08-17','PDX','SEA',95.00),
(12,'Delta','DL281','2025-08-19','2025-08-19','SEA','PDX',100.00),
(12,'United','UA650','2025-08-20','2025-08-20','PDX','SFO',120.00),
(12,'United','UA651','2025-08-23','2025-08-23','SFO','PDX',125.00),

-- Trip 13
(13,'JetBlue','B6200','2025-09-25','2025-09-25','BOS','BOS',20.00),
(13,'JetBlue','B6201','2025-10-02','2025-10-02','BOS','BOS',20.00),
(13,'American','AA700','2025-09-26','2025-09-26','BOS','PHL',130.00),
(13,'American','AA701','2025-09-27','2025-09-27','PHL','BOS',125.00),
(13,'United','UA820','2025-09-28','2025-09-28','BOS','IAD',140.00),
(13,'United','UA821','2025-09-29','2025-09-29','IAD','BOS',135.00),

-- Trip 14
(14,'Delta','DL520','2025-10-10','2025-10-10','BOS','SLC',310.00),
(14,'Delta','DL521','2025-10-18','2025-10-18','SLC','BOS',315.00),
(14,'American','AA800','2025-10-12','2025-10-12','SLC','DEN',120.00),
(14,'American','AA801','2025-10-14','2025-10-14','DEN','SLC',125.00),
(14,'United','UA910','2025-10-15','2025-10-15','SLC','LAS',95.00),
(14,'United','UA911','2025-10-16','2025-10-16','LAS','SLC',100.00),

-- Trip 15
(15,'Lufthansa','LH400','2025-11-20','2025-11-21','BOS','MUC',720.00),
(15,'Lufthansa','LH401','2025-12-05','2025-12-06','MUC','BOS',700.00),
(15,'Ryanair','FR350','2025-11-22','2025-11-22','MUC','VIE',75.00),
(15,'Ryanair','FR351','2025-11-23','2025-11-23','VIE','MUC',80.00),
(15,'Swiss','LX100','2025-11-25','2025-11-25','MUC','ZRH',90.00),
(15,'Swiss','LX101','2025-11-27','2025-11-27','ZRH','MUC',95.00),

-- Trip 16
(16,'JetBlue','B6300','2025-12-15','2025-12-15','BOS','SJU',280.00),
(16,'JetBlue','B6301','2025-12-23','2025-12-23','SJU','BOS',275.00),
(16,'American','AA900','2025-12-16','2025-12-16','SJU','STT',90.00),
(16,'American','AA901','2025-12-17','2025-12-17','STT','SJU',95.00),
(16,'Delta','DL990','2025-12-18','2025-12-18','SJU','MIA',130.00),
(16,'Delta','DL991','2025-12-20','2025-12-20','MIA','SJU',135.00),

-- Trip 17
(17,'Delta','DL1000','2025-01-05','2025-01-05','BOS','ATL',190.00),
(17,'Delta','DL1001','2025-01-08','2025-01-08','ATL','BOS',185.00),
(17,'United','UA1030','2025-01-06','2025-01-06','ATL','CLT',95.00),
(17,'United','UA1031','2025-01-07','2025-01-07','CLT','ATL',100.00),
(17,'Southwest','WN1030','2025-01-06','2025-01-06','ATL','BNA',110.00),
(17,'Southwest','WN1031','2025-01-07','2025-01-07','BNA','ATL',115.00),

-- Trip 18
(18,'United','UA1100','2025-02-14','2025-02-14','BOS','IAH',255.00),
(18,'United','UA1101','2025-02-18','2025-02-18','IAH','BOS',260.00),
(18,'American','AA1100','2025-02-15','2025-02-15','IAH','DFW',85.00),
(18,'American','AA1101','2025-02-16','2025-02-16','DFW','IAH',90.00),
(18,'Delta','DL1100','2025-02-16','2025-02-16','IAH','ATL',120.00),
(18,'Delta','DL1101','2025-02-17','2025-02-17','ATL','IAH',125.00),

-- Trip 19
(19,'American','AA1200','2025-03-05','2025-03-05','BOS','PHL',140.00),
(19,'American','AA1201','2025-03-10','2025-03-10','PHL','BOS',145.00),
(19,'United','UA1200','2025-03-07','2025-03-07','PHL','IAD',80.00),
(19,'United','UA1201','2025-03-08','2025-03-08','IAD','PHL',85.00),
(19,'Delta','DL1200','2025-03-08','2025-03-08','PHL','DTW',110.00),
(19,'Delta','DL1201','2025-03-09','2025-03-09','DTW','PHL',115.00),

-- Trip 20
(20,'ANA','NH800','2025-04-01','2025-04-02','BOS','HND',950.00),
(20,'ANA','NH801','2025-04-15','2025-04-15','HND','BOS',940.00),
(20,'JAL','JL200','2025-04-03','2025-04-03','HND','CTS',140.00),
(20,'JAL','JL201','2025-04-05','2025-04-05','CTS','HND',145.00),
(20,'Peach','MM300','2025-04-06','2025-04-06','HND','KIX',95.00),
(20,'Peach','MM301','2025-04-08','2025-04-08','KIX','HND',100.00);

/* ===========================
   HOTEL — 34 rows
   --1-2 hotels per trip--20 trips--
   =========================== */
INSERT INTO HOTEL (trip_id, hotel_name, checkin_date, checkout_date, address, price_per_night)
VALUES
-- Trip 1: Hawaii Vacation (Honolulu)
(1, 'Ocean Breeze Resort', '2025-01-10', '2025-01-15', '12 Beach Road, Honolulu', 150),
(1, 'Harbor View Hotel', '2025-01-15', '2025-01-20', '88 Dockside Way, Honolulu', 170),

-- Trip 2: Business Conference (New York)
(2, 'Midtown Conference Hotel', '2025-02-05', '2025-02-10', '123 5th Ave, New York, NY', 200),

-- Trip 3: Family Reunion (Chicago)
(3, 'Lakefront Suites', '2025-03-12', '2025-03-18', '456 Lakeside Dr, Chicago, IL', 160),

-- Trip 4: Spring Break (Miami)
(4, 'South Beach Resort', '2025-03-25', '2025-03-30', '77 Ocean Drive, Miami, FL', 180),
(4, 'Downtown Miami Hotel', '2025-03-30', '2025-04-02', '200 Brickell Ave, Miami, FL', 150),

-- Trip 5: European Tour (London)
(5, 'London Central Inn', '2025-04-10', '2025-04-18', '10 Baker Street, London, UK', 220),
(5, 'Riverside Hotel London', '2025-04-18', '2025-04-25', '25 Thames Road, London, UK', 250),

-- Trip 6: Desert Adventure (Phoenix)
(6, 'Cactus Inn', '2025-05-01', '2025-05-05', '88 Desert Rd, Phoenix, AZ', 140),
(6, 'Sunset Desert Hotel', '2025-05-05', '2025-05-10', '123 Sandstone Ave, Phoenix, AZ', 160),

-- Trip 7: National Park Trip (Denver)
(7, 'Rocky Mountain Lodge', '2025-05-15', '2025-05-20', '200 Summit Drive, Denver, CO', 180),
(7, 'Denver City Hotel', '2025-05-20', '2025-05-25', '77 Downtown St, Denver, CO', 150),

-- Trip 8: Summer Beach Trip (San Diego)
(8, 'Pacific Beach Resort', '2025-06-05', '2025-06-10', '50 Beach Ave, San Diego, CA', 170),
(8, 'Downtown San Diego Hotel', '2025-06-10', '2025-06-15', '99 Harbor Blvd, San Diego, CA', 160),

-- Trip 9: Solo Retreat (Seattle)
(9, 'Emerald City Inn', '2025-07-01', '2025-07-05', '45 Pine Street, Seattle, WA', 150),
(9, 'Lakeview Hotel', '2025-07-05', '2025-07-08', '200 Lake Ave, Seattle, WA', 140),

-- Trip 10: Wedding Trip (Nashville)
(10, 'Music City Hotel', '2025-07-20', '2025-07-23', '123 Broadway St, Nashville, TN', 180),
(10, 'Downtown Inn', '2025-07-23', '2025-07-25', '78 Main St, Nashville, TN', 160),

-- Trip 11: Girls Getaway (Las Vegas)
(11, 'The Strip Resort', '2025-08-03', '2025-08-06', '500 Las Vegas Blvd, Las Vegas, NV', 200),
(11, 'Downtown Vegas Hotel', '2025-08-06', '2025-08-08', '77 Fremont St, Las Vegas, NV', 180),

-- Trip 12: Road Trip End (Portland)
(12, 'Riverfront Hotel', '2025-08-15', '2025-08-20', '88 River Rd, Portland, OR', 160),
(12, 'Downtown Portland Inn', '2025-08-20', '2025-08-25', '123 Broadway St, Portland, OR', 150),

-- Trip 13: Fall Colors Trip (Boston)
(13, 'Beacon Hill Hotel', '2025-09-25', '2025-10-02', '77 Charles St, Boston, MA', 180),

-- Trip 14: Mountain Retreat (Salt Lake City)
(14, 'Alpine Lodge', '2025-10-10', '2025-10-14', '45 Mountain Rd, Salt Lake City, UT', 160),
(14, 'Summit Hotel', '2025-10-14', '2025-10-18', '200 Summit Ave, Salt Lake City, UT', 170),

-- Trip 15: Holiday Markets (Munich)
(15, 'Marienplatz Hotel', '2025-11-20', '2025-11-28', '10 Marienplatz, Munich, Germany', 220),
(15, 'Bavaria Inn', '2025-11-28', '2025-12-05', '25 Ludwigstrasse, Munich, Germany', 210),

-- Trip 16: Tropical Winter Escape (San Juan)
(16, 'Caribbean Breeze Resort', '2025-12-15', '2025-12-20', '88 Beachfront Rd, San Juan, PR', 230),
(16, 'Old San Juan Inn', '2025-12-20', '2025-12-23', '77 Calle Fortaleza, San Juan, PR', 200),

-- Trip 17: Weekend Escape (Atlanta)
(17, 'Peachtree Hotel', '2025-01-05', '2025-01-08', '123 Peachtree St, Atlanta, GA', 150),

-- Trip 18: Work Trip (Houston)
(18, 'Downtown Houston Hotel', '2025-02-14', '2025-02-18', '77 Main St, Houston, TX', 160),

-- Trip 19: City Exploring (Philadelphia)
(19, 'Liberty Bell Inn', '2025-03-05', '2025-03-10', '45 Market St, Philadelphia, PA', 150),

-- Trip 20: Cultural Immersion (Tokyo)
(20, 'Shinjuku Grand Hotel', '2025-04-01', '2025-04-08', '88 Shinjuku St, Tokyo, Japan', 220),
(20, 'Asakusa Inn', '2025-04-08', '2025-04-15', '12 Asakusa Rd, Tokyo, Japan', 210);

-- ================================
-- INSERT DATA FOR ACTIVITY (120 rows)
-- 6 activities per trip × 20 trips
-- ================================
INSERT INTO ACTIVITY (trip_id, activity_date, location, cost, category)
VALUES
-- Trip 1: Hawaii Vacation (Honolulu)
(1,'2025-01-10','Beach Walk',0.00,'Relaxation'),
(1,'2025-01-11','City Museum',15.00,'Culture'),
(1,'2025-01-12','Local Market',5.00,'Shopping'),
(1,'2025-01-13','Harbor Cruise',40.00,'Tour'),
(1,'2025-01-14','Mountain Trail',0.00,'Hiking'),
(1,'2025-01-15','Art Gallery',12.00,'Culture'),

-- Trip 2: Business Conference (New York)
(2,'2025-02-05','Networking Breakfast',18.00,'Food'),
(2,'2025-02-06','Tech Expo',25.00,'Attraction'),
(2,'2025-02-07','City Museum',20.00,'Culture'),
(2,'2025-02-08','Rooftop Dinner',60.00,'Food'),
(2,'2025-02-09','Broadway Show',85.00,'Entertainment'),
(2,'2025-02-10','Transit Tour',12.00,'Tour'),

-- Trip 3: Family Reunion (Chicago)
(3,'2025-03-12','Family Picnic',0.00,'Leisure'),
(3,'2025-03-13','Architecture Boat Tour',30.00,'Tour'),
(3,'2025-03-14','Local Market',10.00,'Shopping'),
(3,'2025-03-15','Museum Visit',22.00,'Culture'),
(3,'2025-03-16','Deep-dish Dinner',25.00,'Food'),
(3,'2025-03-17','Neighborhood Walk',0.00,'Relaxation'),

-- Trip 4: Spring Break (Miami)
(4,'2025-03-25','Beach Volleyball',0.00,'Relaxation'),
(4,'2025-03-26','Art Deco Walking Tour',15.00,'Tour'),
(4,'2025-03-27','Local Seafood Tasting',30.00,'Food'),
(4,'2025-03-28','Nightclub Show',45.00,'Entertainment'),
(4,'2025-03-29','Boat Rental',55.00,'Adventure'),
(4,'2025-03-30','Sunset Walk',0.00,'Sightseeing'),

-- Trip 5: European Tour (London)
(5,'2025-04-10','West End Show',75.00,'Entertainment'),
(5,'2025-04-11','Historic Museum',18.00,'Culture'),
(5,'2025-04-12','Market Stroll',12.00,'Shopping'),
(5,'2025-04-13','River Thames Cruise',30.00,'Tour'),
(5,'2025-04-14','Pub Dinner',28.00,'Food'),
(5,'2025-04-15','Royal Park Walk',0.00,'Relaxation'),

-- Trip 6: Desert Adventure (Phoenix)
(6,'2025-05-01','Desert Hike',0.00,'Hiking'),
(6,'2025-05-02','Botanical Garden',14.00,'Nature'),
(6,'2025-05-03','Off-road Tour',60.00,'Adventure'),
(6,'2025-05-04','Local Market',8.00,'Shopping'),
(6,'2025-05-05','Cactus Museum',10.00,'Culture'),
(6,'2025-05-06','Sunset Photography',0.00,'Sightseeing'),

-- Trip 7: National Park Trip (Denver)
(7,'2025-05-15','Trailhead Hike',0.00,'Hiking'),
(7,'2025-05-16','Rocky Mountain Tour',35.00,'Tour'),
(7,'2025-05-17','Wildlife Viewing',0.00,'Nature'),
(7,'2025-05-18','Picnic Lunch',12.00,'Food'),
(7,'2025-05-19','Scenic Drive',10.00,'Sightseeing'),
(7,'2025-05-20','Visitor Center',5.00,'Attraction'),

-- Trip 8: Summer Beach Trip (San Diego)
(8,'2025-06-05','Surf Lesson',50.00,'Adventure'),
(8,'2025-06-06','Seafood Market',20.00,'Food'),
(8,'2025-06-07','Harbor Kayak',45.00,'Adventure'),
(8,'2025-06-08','Boardwalk Stroll',0.00,'Relaxation'),
(8,'2025-06-09','Local Brewery Tour',25.00,'Entertainment'),
(8,'2025-06-10','Sunset Cruise',30.00,'Tour'),

-- Trip 9: Solo Retreat (Seattle)
(9,'2025-07-01','Forest Hike',0.00,'Hiking'),
(9,'2025-07-02','Coffee Tasting',12.00,'Food'),
(9,'2025-07-03','Local Gallery',10.00,'Culture'),
(9,'2025-07-04','Sound Sightseeing',0.00,'Sightseeing'),
(9,'2025-07-05','Day Spa',55.00,'Relaxation'),
(9,'2025-07-06','Bookshop Visit',5.00,'Shopping'),

-- Trip 10: Wedding Trip (Nashville)
(10,'2025-07-20','Rehearsal Dinner',40.00,'Food'),
(10,'2025-07-21','Wedding Ceremony',0.00,'Event'),
(10,'2025-07-22','Brunch with Family',22.00,'Food'),
(10,'2025-07-23','Honky Tonk Night',30.00,'Entertainment'),
(10,'2025-07-24','Music Museum',18.00,'Culture'),
(10,'2025-07-25','City Walk',0.00,'Sightseeing'),

-- Trip 11: Girls Getaway (Las Vegas)
(11,'2025-08-03','Pool Day',0.00,'Relaxation'),
(11,'2025-08-04','Show Tickets',120.00,'Entertainment'),
(11,'2025-08-05','Buffet Dinner',45.00,'Food'),
(11,'2025-08-06','Spa Treatment',80.00,'Relaxation'),
(11,'2025-08-07','Casino Night',0.00,'Entertainment'),
(11,'2025-08-08','Shopping Spree',90.00,'Shopping'),

-- Trip 12: Road Trip End (Portland)
(12,'2025-08-15','Coastal Drive',0.00,'Sightseeing'),
(12,'2025-08-16','Farmers Market',10.00,'Shopping'),
(12,'2025-08-17','Food Truck Crawl',25.00,'Food'),
(12,'2025-08-18','Bridge Walk',0.00,'Culture'),
(12,'2025-08-19','Brewery Visit',20.00,'Entertainment'),
(12,'2025-08-20','Hiking Loop',0.00,'Hiking'),

-- Trip 13: Fall Colors Trip (Boston)
(13,'2025-09-25','Leaf-peeping Walk',0.00,'Nature'),
(13,'2025-09-26','Historic Tour',18.00,'Tour'),
(13,'2025-09-27','Museum Visit',20.00,'Culture'),
(13,'2025-09-28','Local Market',10.00,'Shopping'),
(13,'2025-09-29','Harbor Cruise',28.00,'Tour'),
(13,'2025-09-30','Autumn Cafe',12.00,'Food'),

-- Trip 14: Mountain Retreat (Salt Lake City)
(14,'2025-10-10','Cabin Check-in',0.00,'Leisure'),
(14,'2025-10-11','Trail Hike',0.00,'Hiking'),
(14,'2025-10-12','Lake Paddle',15.00,'Adventure'),
(14,'2025-10-13','Local Diner',18.00,'Food'),
(14,'2025-10-14','Photography Spot',0.00,'Sightseeing'),
(14,'2025-10-15','Nature Center',8.00,'Attraction'),

-- Trip 15: Holiday Markets (Munich)
(15,'2025-11-20','Christmas Market Stroll',0.00,'Sightseeing'),
(15,'2025-11-21','Gluhwein Tasting',8.00,'Food'),
(15,'2025-11-22','Cathedral Visit',10.00,'Culture'),
(15,'2025-11-23','Artisan Shopping',35.00,'Shopping'),
(15,'2025-11-24','Bavarian Dinner',45.00,'Food'),
(15,'2025-11-25','River Walk',0.00,'Relaxation'),

-- Trip 16: Tropical Winter Escape (San Juan)
(16,'2025-12-15','Beach Time',0.00,'Relaxation'),
(16,'2025-12-16','Snorkeling',55.00,'Adventure'),
(16,'2025-12-17','Old San Juan Tour',20.00,'Culture'),
(16,'2025-12-18','Local Food Sampling',25.00,'Food'),
(16,'2025-12-19','Rum Distillery Visit',18.00,'Tour'),
(16,'2025-12-20','Sunset Sail',30.00,'Sightseeing'),

-- Trip 17: Weekend Escape (Atlanta)
(17,'2025-01-05','Coffee Meetup',8.00,'Food'),
(17,'2025-01-06','City Park Walk',0.00,'Relaxation'),
(17,'2025-01-07','Historic House Tour',12.00,'Culture'),
(17,'2025-01-08','Brunch',20.00,'Food'),
(17,'2025-01-08','Shopping Stroll',30.00,'Shopping'),
(17,'2025-01-08','Movie Night',12.00,'Entertainment'),

-- Trip 18: Work Trip (Houston)
(18,'2025-02-14','Conference Session',0.00,'Work'),
(18,'2025-02-15','Client Dinner',50.00,'Food'),
(18,'2025-02-16','Airport Transfer',30.00,'Transportation'),
(18,'2025-02-17','Local Site Visit',0.00,'Work'),
(18,'2025-02-18','Team Lunch',25.00,'Food'),
(18,'2025-02-18','Evening Walk',0.00,'Relaxation'),

-- Trip 19: City Exploring (Philadelphia)
(19,'2025-03-05','Historic Walking Tour',20.00,'Tour'),
(19,'2025-03-06','Cheesesteak Stop',12.00,'Food'),
(19,'2025-03-07','Museum of Art',22.00,'Culture'),
(19,'2025-03-08','Riverfront Walk',0.00,'Sightseeing'),
(19,'2025-03-09','Local Market',8.00,'Shopping'),
(19,'2025-03-10','Theater Show',35.00,'Entertainment'),

-- Trip 20: Cultural Immersion (Tokyo)
(20,'2025-04-01','Temple Visit',0.00,'Culture'),
(20,'2025-04-02','Tea Ceremony',30.00,'Culture'),
(20,'2025-04-03','Local Market',10.00,'Shopping'),
(20,'2025-04-04','Sakura Walk',0.00,'Nature'),
(20,'2025-04-05','Street Food Tour',22.00,'Food'),
(20,'2025-04-06','Night Market',18.00,'Entertainment');


/* ===========================
   EXPENSE — 64 rows
   --3-4 expenses per trip--20 trips--
   =========================== */
INSERT INTO EXPENSE (trip_id, category, amount, description, expense_date)
VALUES
-- Trip 1: Hawaii Vacation
(1, 'Food', 15.50, 'Lunch at beach cafe', '2025-01-10'),
(1, 'Transportation', 22.00, 'Bus to city tour', '2025-01-10'),
(1, 'Entertainment', 35.00, 'Snorkeling excursion', '2025-01-11'),
(1, 'Food', 18.25, 'Dinner at local restaurant', '2025-01-11'),

-- Trip 2: Business Conference (New York)
(2, 'Food', 25.00, 'Lunch at hotel', '2025-02-05'),
(2, 'Transportation', 15.00, 'Subway pass', '2025-02-05'),
(2, 'Entertainment', 50.00, 'Networking event ticket', '2025-02-06'),

-- Trip 3: Family Reunion (Chicago)
(3, 'Food', 60.00, 'Family dinner', '2025-03-12'),
(3, 'Transportation', 30.00, 'Uber to reunion venue', '2025-03-12'),
(3, 'Shopping', 40.00, 'Family gifts', '2025-03-13'),

-- Trip 4: Spring Break (Miami)
(4, 'Food', 20.00, 'Beachside lunch', '2025-03-25'),
(4, 'Transportation', 18.00, 'Taxi to nightlife district', '2025-03-25'),
(4, 'Entertainment', 45.00, 'Club entry', '2025-03-26'),
(4, 'Food', 22.00, 'Dinner at seafood restaurant', '2025-03-26'),

-- Trip 5: European Tour (London)
(5, 'Food', 35.00, 'Lunch in London cafe', '2025-04-10'),
(5, 'Transportation', 60.00, 'Train between cities', '2025-04-11'),
(5, 'Shopping', 120.00, 'Souvenirs', '2025-04-12'),
(5, 'Entertainment', 50.00, 'Theatre ticket', '2025-04-13'),

-- Trip 6: Desert Adventure (Phoenix)
(6, 'Food', 18.00, 'Breakfast at lodge', '2025-05-01'),
(6, 'Transportation', 25.00, 'Rental car', '2025-05-01'),
(6, 'Entertainment', 40.00, 'Desert tour', '2025-05-02'),

-- Trip 7: National Park Trip (Denver)
(7, 'Food', 15.00, 'Lunch at visitor center', '2025-05-15'),
(7, 'Transportation', 20.00, 'Shuttle to park', '2025-05-15'),
(7, 'Entertainment', 30.00, 'Park entrance fee', '2025-05-16'),

-- Trip 8: Summer Beach Trip (San Diego)
(8, 'Food', 12.00, 'Breakfast at cafe', '2025-06-05'),
(8, 'Transportation', 18.00, 'Bus pass', '2025-06-05'),
(8, 'Entertainment', 45.00, 'Surfing lesson', '2025-06-06'),
(8, 'Food', 25.00, 'Dinner at seafood restaurant', '2025-06-06'),

-- Trip 9: Solo Retreat (Seattle)
(9, 'Food', 14.00, 'Coffee and pastry', '2025-07-01'),
(9, 'Transportation', 10.00, 'Metro ride', '2025-07-01'),
(9, 'Entertainment', 35.00, 'Museum entry', '2025-07-02'),

-- Trip 10: Wedding Trip (Nashville)
(10, 'Food', 20.00, 'Lunch at hotel', '2025-07-20'),
(10, 'Transportation', 12.00, 'Taxi to wedding venue', '2025-07-20'),
(10, 'Entertainment', 50.00, 'Wedding reception', '2025-07-21'),

-- Trip 11: Girls Getaway (Las Vegas)
(11, 'Food', 30.00, 'Buffet lunch', '2025-08-03'),
(11, 'Transportation', 20.00, 'Taxi to strip', '2025-08-03'),
(11, 'Entertainment', 60.00, 'Show ticket', '2025-08-04'),

-- Trip 12: Road Trip End (Portland)
(12, 'Food', 15.00, 'Lunch on road', '2025-08-15'),
(12, 'Transportation', 50.00, 'Gas', '2025-08-15'),
(12, 'Entertainment', 25.00, 'Museum entry', '2025-08-16'),

-- Trip 13: Fall Colors Trip (Boston)
(13, 'Food', 18.00, 'Lunch at local cafe', '2025-09-25'),
(13, 'Transportation', 15.00, 'Subway pass', '2025-09-25'),
(13, 'Entertainment', 40.00, 'Historic tour', '2025-09-26'),

-- Trip 14: Mountain Retreat (Salt Lake City)
(14, 'Food', 20.00, 'Breakfast at lodge', '2025-10-10'),
(14, 'Transportation', 25.00, 'Rental car', '2025-10-10'),
(14, 'Entertainment', 50.00, 'Ski lift ticket', '2025-10-11'),

-- Trip 15: Holiday Markets (Munich)
(15, 'Food', 30.00, 'Lunch at market', '2025-11-20'),
(15, 'Shopping', 80.00, 'Christmas gifts', '2025-11-21'),
(15, 'Entertainment', 20.00, 'Market entry', '2025-11-22'),

-- Trip 16: Tropical Winter Escape (San Juan)
(16, 'Food', 25.00, 'Lunch at resort', '2025-12-15'),
(16, 'Transportation', 15.00, 'Taxi to old town', '2025-12-16'),
(16, 'Entertainment', 50.00, 'Catamaran tour', '2025-12-17'),

-- Trip 17: Weekend Escape (Atlanta)
(17, 'Food', 18.00, 'Lunch at downtown', '2025-01-05'),
(17, 'Transportation', 12.00, 'Taxi', '2025-01-05'),

-- Trip 18: Work Trip (Houston)
(18, 'Food', 22.00, 'Lunch at hotel', '2025-02-14'),
(18, 'Transportation', 15.00, 'Metro pass', '2025-02-14'),
(18, 'Entertainment', 35.00, 'Networking event', '2025-02-15'),

-- Trip 19: City Exploring (Philadelphia)
(19, 'Food', 16.00, 'Lunch at historic district', '2025-03-05'),
(19, 'Transportation', 12.00, 'Subway pass', '2025-03-05'),
(19, 'Entertainment', 20.00, 'Museum entry', '2025-03-06'),

-- Trip 20: Cultural Immersion (Tokyo)
(20, 'Food', 35.00, 'Lunch in Shinjuku', '2025-04-01'),
(20, 'Transportation', 25.00, 'Metro pass', '2025-04-01'),
(20, 'Entertainment', 45.00, 'Temple visit', '2025-04-02'),
(20, 'Shopping', 60.00, 'Local souvenirs', '2025-04-03');


/* ===========================
   FAVORITE — 81 rows
   --3-7 favorites per trip--20 trips--
   =========================== */
INSERT INTO FAVORITE (trip_id, item_type, item_id, rating)
VALUES
-- Trip 1: Hawaii Vacation
(1, 'hotel', 1, 5),
(1, 'hotel', 2, 4),
(1, 'activity', 1, 5),
(1, 'activity', 3, 4),
(1, 'expense', 1, 4),
(1, 'restaurant', NULL, 5),
(1, 'scenic_spot', NULL, 5),

-- Trip 2: Business Conference (New York)
(2, 'hotel', 12, 4),
(2, 'activity', 21, 5),
(2, 'expense', 6, 4),
(2, 'restaurant', NULL, 4),

-- Trip 3: Family Reunion (Chicago)
(3, 'hotel', 13, 5),
(3, 'activity', 31, 4),
(3, 'expense', 10, 5),
(3, 'store', NULL, 4),

-- Trip 4: Spring Break (Miami)
(4, 'hotel', 14, 4),
(4, 'activity', 41, 5),
(4, 'expense', 15, 5),
(4, 'restaurant', NULL, 4),
(4, 'scenic_spot', NULL, 5),

-- Trip 5: European Tour (London)
(5, 'hotel', 15, 5),
(5, 'activity', 51, 5),
(5, 'expense', 20, 4),
(5, 'restaurant', NULL, 5),
(5, 'scenic_spot', NULL, 4),

-- Trip 6: Desert Adventure (Phoenix)
(6, 'hotel', 16, 4),
(6, 'activity', 61, 5),
(6, 'expense', 25, 4),

-- Trip 7: National Park Trip (Denver)
(7, 'hotel', 17, 5),
(7, 'activity', 71, 5),
(7, 'expense', 30, 5),
(7, 'park', NULL, 5),

-- Trip 8: Summer Beach Trip (San Diego)
(8, 'hotel', 18, 5),
(8, 'activity', 81, 5),
(8, 'expense', 35, 4),
(8, 'scenic_spot', NULL, 5),

-- Trip 9: Solo Retreat (Seattle)
(9, 'hotel', 19, 4),
(9, 'activity', 91, 5),
(9, 'expense', 40, 5),

-- Trip 10: Wedding Trip (Nashville)
(10, 'hotel', 20, 5),
(10, 'activity', 101, 4),
(10, 'expense', 45, 5),
(10, 'restaurant', NULL, 5),

-- Trip 11: Girls Getaway (Las Vegas)
(11, 'hotel', 21, 4),
(11, 'activity', 111, 5),
(11, 'expense', 50, 5),
(11, 'store', NULL, 4),

-- Trip 12: Road Trip End (Portland)
(12, 'hotel', 22, 4),
(12, 'activity', 121, 5),
(12, 'expense', 55, 4),
(12, 'scenic_spot', NULL, 5),

-- Trip 13: Fall Colors Trip (Boston)
(13, 'hotel', 23, 5),
(13, 'activity', 131, 4),
(13, 'expense', 60, 5),
(13, 'park', NULL, 5),

-- Trip 14: Mountain Retreat (Salt Lake City)
(14, 'hotel', 24, 4),
(14, 'activity', 141, 5),
(14, 'expense', 65, 5),

-- Trip 15: Holiday Markets (Munich)
(15, 'hotel', 25, 5),
(15, 'activity', 151, 5),
(15, 'expense', 70, 4),
(15, 'store', NULL, 5),

-- Trip 16: Tropical Winter Escape (San Juan)
(16, 'hotel', 26, 5),
(16, 'activity', 161, 5),
(16, 'expense', 75, 4),
(16, 'scenic_spot', NULL, 5),

-- Trip 17: Weekend Escape (Atlanta)
(17, 'hotel', 27, 4),
(17, 'activity', 171, 5),
(17, 'expense', 80, 4),

-- Trip 18: Work Trip (Houston)
(18, 'hotel', 28, 4),
(18, 'activity', 181, 5),
(18, 'expense', 85, 4),

-- Trip 19: City Exploring (Philadelphia)
(19, 'hotel', 29, 4),
(19, 'activity', 191, 5),
(19, 'expense', 90, 4),
(19, 'restaurant', NULL, 5),

-- Trip 20: Cultural Immersion (Tokyo)
(20, 'hotel', 30, 5),
(20, 'activity', 201, 5),
(20, 'expense', 95, 4),
(20, 'store', NULL, 5),
(20, 'restaurant', NULL, 5);
```

### Queries


## Query 1
```sql
-- Query 1: SELECT using ORDER BY two or more columns
SELECT trip_id, trip_name, destination, start_date
FROM TRIP
ORDER BY start_date ASC, trip_name ASC;
```

## Query 2
```sql
-- Query 2: SELECT using a calculated field
SELECT expense_id, category, amount, amount * 1.10 AS total_with_tax
FROM EXPENSE
WHERE trip_id = 1;
```

## Query 3
```sql
-- Query 3: SELECT using a MariaDB function
SELECT trip_name, start_date, MONTH(start_date) AS month_number
FROM TRIP
WHERE destination = 'New York';
```

## Query 4
```sql
-- Query 4: Aggregation with GROUP BY and HAVING
SELECT trip_id, SUM(amount) AS total_expenses
FROM EXPENSE
GROUP BY trip_id
HAVING total_expenses > 100;
```

## Query 5
```sql
-- Query 5: Join of three tables
SELECT T.trip_name, H.hotel_name, SUM(E.amount) AS total_expenses
FROM TRIP T
INNER JOIN HOTEL H ON T.trip_id = H.trip_id
INNER JOIN EXPENSE E ON T.trip_id = E.trip_id
GROUP BY T.trip_name, H.hotel_name
LIMIT 5;
```

## Query 6
```sql
-- Query 6: LEFT JOIN
SELECT T.trip_name, F.item_type, F.rating
FROM TRIP T
LEFT JOIN FAVORITE F ON T.trip_id = F.trip_id
WHERE T.trip_id = 3;
```

## Query 7
```sql
-- Query 7: UPDATE query
UPDATE HOTEL
SET price_per_night = 180
WHERE hotel_name = 'Ocean Breeze Resort';
```
## Query 8
```sql
-- Query 8: DELETE query
DELETE FROM EXPENSE
WHERE expense_id = 60;
```

## Query 9
```sql
-- Query 9: Create a View
CREATE OR REPLACE VIEW trip_summary AS
SELECT T.trip_id, T.trip_name, H.hotel_name, AVG(E.amount) AS avg_expense
FROM TRIP T
INNER JOIN HOTEL H ON T.trip_id = H.trip_id
INNER JOIN EXPENSE E ON T.trip_id = E.trip_id
GROUP BY T.trip_id, H.hotel_name;
```

## Query 10
```sql
-- Query 10: Transaction with ROLLBACK
START TRANSACTION;
UPDATE HOTEL SET price_per_night = 200 WHERE hotel_name = 'Ocean Breeze Resort';
UPDATE HOTEL SET price_per_night = 190 WHERE hotel_name = 'Midtown Conference Hotel';
ROLLBACK;
```

### Sample Output

---insert sample output---

### Reports

---insert report---

Sample Excel Chart
---insert chart---

Sample Access Report 
---insert report---

### Delete Tables
```sql
-- Drop the view first (if it exists)
DROP VIEW IF EXISTS trip_summary;

-- Drop tables in order to avoid foreign key conflicts
-- ORDER MATTERS - MUST DROP CHILD TABleS BEFORE PARENT TABLE (parent table = trip)
DROP TABLE IF EXISTS FAVORITE;
DROP TABLE IF EXISTS EXPENSE;
DROP TABLE IF EXISTS HOTEL;
DROP TABLE IF EXISTS ACTIVITY;
DROP TABLE IF EXISTS FLIGHT;
DROP TABLE IF EXISTS TRIP;

-- Optional: confirm deletion by checking tables
SHOW TABLES;
```

### Poster and Presentation
---insert poster and presentation---
