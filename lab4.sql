CREATE DATABASE lab4;

CREATE TABLE Warehouses (
    code INT PRIMARY KEY,
    location VARCHAR(100),
    capacity INT
);

CREATE TABLE Boxes (
    code VARCHAR(10) PRIMARY KEY,
    contents VARCHAR(100),
    value DECIMAL(10, 2),
    warehouse_code INT,
    FOREIGN KEY (warehouse_code) REFERENCES Warehouses(code)
);

SELECT * FROM Warehouses;

SELECT * FROM Boxes WHERE value > 150;

SELECT DISTINCT contents FROM Boxes;

SELECT warehouse_code, COUNT(*) AS number_of_boxes
FROM Boxes
GROUP BY warehouse_code;

SELECT warehouse_code, COUNT(*) AS number_of_boxes
FROM Boxes
GROUP BY warehouse_code
HAVING COUNT(*) > 2;

INSERT INTO Warehouses (code, location, capacity) VALUES (6, 'New York', 3);

INSERT INTO Boxes (code, contents, value, warehouse_code) VALUES ('H5RT', 'Papers', 200, 2);

UPDATE Boxes
SET value = value * 0.85
WHERE code = (
    SELECT code FROM (
        SELECT code
        FROM Boxes
        ORDER BY value DESC
        LIMIT 3
    ) AS temp
    ORDER BY value ASC
    LIMIT 1
);

DELETE FROM Boxes WHERE value < 150;

DELETE FROM Boxes
WHERE warehouse_code IN (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;

