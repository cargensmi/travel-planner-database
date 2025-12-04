-- Drop tables if they exist (optional but helpful during testing)
DROP TABLE IF EXISTS FLIGHT;
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

