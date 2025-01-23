CREATE DATABASE lab_2;

CREATE TABLE employees (
   employee_id SERIAL PRIMARY KEY,
   first_name VARCHAR,
   last_name VARCHAR,
   department_id INTEGER,
   salary INTEGER
);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Madina', 'Nurmagambetova', 1, 100000);

INSERT INTO employees (employee_id, first_name, last_name)
VALUES (2, 'Diana', 'Galymzhankyzy');

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Dilyara', 'Aitbek', NULL, 50000);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES
   ('Justin', 'Bieber', 2, 50000),
   ('Justin', 'Timberlake', 1, 32000),
   ('Gulmira', 'Nurkalimova', NULL, 99000),
   ('Azamat', 'Aitaliev', 2, 55000),
   ('Joe', 'Biden', 3, 30000);

ALTER TABLE employees ALTER COLUMN first_name SET DEFAULT 'Lola';

INSERT INTO employees (last_name, department_id, salary)
VALUES ('Kumberbetch', 2, 65000);

INSERT INTO employees DEFAULT VALUES;

CREATE TABLE employees_archive (LIKE employees INCLUDING ALL);

INSERT INTO employees_archive SELECT * FROM employees;

UPDATE employees SET department_id = 1 WHERE department_id IS NULL;

SELECT first_name, last_name, salary, salary * 1.15 AS "Updated Salary" FROM employees;

DELETE FROM employees WHERE salary < 50000;

DELETE FROM employees_archive WHERE employee_id IN (SELECT employee_id FROM employees);

WITH deleted AS (
   DELETE FROM employees RETURNING *
)
SELECT * FROM deleted;

