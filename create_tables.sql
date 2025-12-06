-- Drop tables if they exist (optional but helpful during testing)
DROP TABLE IF EXISTS FLIGHT;
DROP TABLE IF EXISTS EXPENSE;
DROP TABLE IF EXISTS ACTIVITY;
DROP TABLE IF EXISTS FAVORITE;
DROP TABLE IF EXISTS HOTEL;
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
