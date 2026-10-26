CREATE DATABASE employee_payroll;

USE employee_payroll;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    designation VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    joining_date DATE
);

CREATE TABLE Salary (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    basic_salary DECIMAL(10,2),
    allowances DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    working_days INT,
    present_days INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Employees
(employee_name, department, designation, email, phone, joining_date)
VALUES
('Rahul', 'IT', 'Software Developer', 'rahul@gmail.com', '9876543210', '2024-06-10'),
('Priya', 'HR', 'HR Executive', 'priya@gmail.com', '9876543211', '2024-07-15'),
('Kiran', 'Finance', 'Accountant', 'kiran@gmail.com', '9876543212', '2023-08-20'),
('Sneha', 'IT', 'System Engineer', 'sneha@gmail.com', '9876543213', '2024-01-12'),
('Arjun', 'Sales', 'Sales Executive', 'arjun@gmail.com', '9876543214', '2023-11-05');

INSERT INTO Salary
(employee_id, basic_salary, allowances, deductions)
VALUES
(1, 40000, 5000, 2000),
(2, 35000, 4000, 1500),
(3, 45000, 6000, 2500),
(4, 50000, 7000, 3000),
(5, 30000, 3500, 1000);

INSERT INTO Attendance
(employee_id, working_days, present_days)
VALUES
(1, 26, 24),
(2, 26, 23),
(3, 26, 25),
(4, 26, 26),
(5, 26, 22);

SHOW TABLES;

SELECT * FROM Employees;

SELECT * FROM Salary;

SELECT * FROM Attendance;

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.designation,
    s.basic_salary,
    s.allowances,
    s.deductions,
    (s.basic_salary + s.allowances) AS gross_salary,
    (s.basic_salary + s.allowances - s.deductions) AS net_salary
FROM Employees e
JOIN Salary s
    ON e.employee_id = s.employee_id
ORDER BY e.employee_id;

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.designation,
    a.working_days,
    a.present_days,
    s.basic_salary,
    s.allowances,
    s.deductions,
    (s.basic_salary + s.allowances) AS gross_salary,
    (s.basic_salary + s.allowances - s.deductions) AS net_salary
FROM Employees e
JOIN Salary s
    ON e.employee_id = s.employee_id
JOIN Attendance a
    ON e.employee_id = a.employee_id
ORDER BY e.employee_id;

SELECT
    e.employee_id,
    e.employee_name,
    (s.basic_salary + s.allowances - s.deductions) AS net_salary
FROM Employees e
JOIN Salary s
    ON e.employee_id = s.employee_id
ORDER BY net_salary DESC
LIMIT 1;

SELECT
    e.department,
    COUNT(e.employee_id) AS total_employees,
    SUM(s.basic_salary + s.allowances - s.deductions) AS total_net_salary
FROM Employees e
JOIN Salary s
    ON e.employee_id = s.employee_id
GROUP BY e.department
ORDER BY total_net_salary DESC;