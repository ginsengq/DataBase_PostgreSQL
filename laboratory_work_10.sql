
-- Laboratory Work #10: SQL Tasks for Movie Rental System

-- Create Tables
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    price_per_day DECIMAL(5,2),
    available_copies INT
);

CREATE TABLE Rentals (
    rental_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES Movies(movie_id),
    customer_id INT,
    rental_date DATE,
    quantity INT
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Insert Sample Data
INSERT INTO Movies (movie_id, title, genre, price_per_day, available_copies) VALUES
(1, 'The Matrix', 'Sci-Fi', 5.00, 8),
(2, 'Titanic', 'Romance', 3.50, 12),
(3, 'Avengers: Endgame', 'Action', 6.00, 5);

INSERT INTO Rentals (rental_id, movie_id, customer_id, rental_date, quantity) VALUES
(1, 1, 201, '2024-11-01', 2),
(2, 2, 202, '2024-11-03', 1),
(3, 3, 201, '2024-11-05', 3);

INSERT INTO Customers (customer_id, name, email) VALUES
(201, 'Alice Johnson', 'alice.j@example.com'),
(202, 'Bob Smith', 'bob.smith@example.com');

-- Task 1: Transaction for Renting a Movie
DO $$
DECLARE
    available_copies INT;
BEGIN
    -- Check available copies for movie_id = 1
    SELECT available_copies INTO available_copies
    FROM Movies
    WHERE movie_id = 1;

    IF available_copies >= 2 THEN
        -- Insert rental record
        INSERT INTO Rentals (movie_id, customer_id, rental_date, quantity)
        VALUES (1, 201, '2024-11-23', 2);

        -- Update available copies
        UPDATE Movies
        SET available_copies = available_copies - 2
        WHERE movie_id = 1;

        COMMIT;
    ELSE
        RAISE NOTICE 'Not enough copies available.';
        RETURN;
    END IF;
END
$$ LANGUAGE plpgsql;

-- Task 2: Transaction with Rollback (Trying to rent 10 copies, but only 5 are available)
DO $$
DECLARE
    available_copies INT;
BEGIN
    -- Check available copies for movie_id = 3
    SELECT available_copies INTO available_copies
    FROM Movies
    WHERE movie_id = 3;

    IF available_copies < 10 THEN
        RAISE NOTICE 'Error: Not enough copies available for rental.';
        RETURN;
    END IF;

    -- Insert rental record
    INSERT INTO Rentals (movie_id, customer_id, rental_date, quantity)
    VALUES (3, 202, '2024-11-23', 10);

    -- Update available copies
    UPDATE Movies
    SET available_copies = available_copies - 10
    WHERE movie_id = 3;

    COMMIT;
END
$$ LANGUAGE plpgsql;

-- Task 3: Demonstration of Isolation Levels (Read Committed Example)
-- Session 1: Update movie price
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Movies SET price_per_day = 6.50 WHERE movie_id = 1;

-- Session 2: Try to read the updated value in a different session (uncommitted)
-- This would need to be run in a different session or tool

-- Task 4: Durability Check
-- Update customer email and check after restart
BEGIN;
UPDATE Customers SET email = 'alice.newemail@example.com' WHERE customer_id = 201;
COMMIT;
-- Restart database server manually and check the update.
