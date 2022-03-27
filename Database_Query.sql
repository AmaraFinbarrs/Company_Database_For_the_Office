--Insert values into the company database
--Corporate
INSERT INTO employee VALUES(
    100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL
);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

DELETE FROM branch
WHERE branch_id = 1;

UPDATE employee
SET branch_id = 1
WHERE emp_id = 101;

INSERT INTO employee VALUES(
    101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1
);


--Scrantom 
INSERT INTO employee VALUE (
    102, 'Micheal', 'Scott', '1964-03-15', 'M', 75000, NULL, NULL
);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

SELECT * FROM employee;

UPDATE employee
SET branch_id = 2 
WHERE emp_id = 102;

UPDATE employee
SET super_id = 102 
WHERE emp_id = 102;

INSERT INTO employee VALUES(
    103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2
);
INSERT INTO employee VALUES(
    104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2
);
INSERT INTO employee VALUES(
    105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2
);

--Stamford 
INSERT INTO employee VALUES (
    106, 'John', 'Porter', '1969-09-05', 'M', 78000, NULL, NULL
);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

UPDATE employee
SET super_id = 100
WHERE emp_id = 106;

INSERT INTO employee VALUES (
    107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3
);
INSERT INTO employee VALUES (
    108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3
);

--BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Customer Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Customer Forms');

--CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES (402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daily Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scramton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

--WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 26700);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

UPDATE works_with
SET total_sales = 267000
WHERE total_sales = 26700; 

SELECT * FROM works_with;

--Find all the employees ordered by salary
SELECT * 
FROM employee
ORDER BY salary DESC;

--Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name
LIMIT 5;

--Select first and last names of all employees
SELECT first_name, last_name
FROM employee;

--Select the first_name and last_name but reneame the columns as forename and surname
SELECT first_name AS forename, last_name AS surname
FROM employee;

--Find out all the different genders
SELECT DISTINCT sex
FROM employee;

--Find out all the different branch ids
SELECT DISTINCT branch_id
FROM employee;

----------------------------------------FUNCTIONS-----------------------------------
--find all the number of employees
SELECT COUNT(emp_id)
FROM employee;

--Find the numbers that have supervisor
SELECT COUNT(super_id)
FROM employee;

--Find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1971-01-01';

--Find the average of all the employee's salaries
SELECT AVG(salary)
FROM employee;

--Find the average of all the employees that are male
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

--Replace AVG with SUM to return the sum

--Aggregation
--Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP by sex;

--Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

--Switch the emp_id with client_id to show how much each client_id
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

--Wildcards
--Find any client's who are LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

--Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier 
WHERE supplier_name LIKE '% label%';

--Find any employee orn in october
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';


--Find all client who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';


--UNION--
--Find a list of employee and branch names
--Firstly lets grab the employee names
--Then we grab the branch names
--Finally we combine both operations using join
--Returns one list but combines the two list.
SELECT first_name
FROM employee
UNION
SELECT branch_name
FROM branch;

SELECT first_name AS Company_Names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

--Find a list of all clients & branch suppliers' names
SELECT client_name
FROM client
UNION
SELECT supplier_name
FROM branch_supplier;

SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;

--A more readable format
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

--Find the list of all money spent or earned by the company
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

--JOINS--
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

--Find all branch and names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id;

---NESTED LOOPS---
--Find names of all employees who have sold over 30,000 to a single client
--We have part information on tables but we have related columns that we could use to find the 
--information that we want.
--Select the employee ids that have sold more than 30,000 to a single client.
--Select their firstnames and lastnames
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

---Find all clients who are handled by the branch that Micheal Scott manages
--Assume you know Micheal's ID
--From the Branch table we figure out the branch id that is managed by Micheal
-- (mgr_id maps us to Miheal Scotte)
--Then from the Clients table, we figure the client that use that branch.
--(branch_id maps us to the clients)
SELECT client.client_name
FROM client
WHERE client.branch_id IN (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
);

SELECT client.client_name
FROM client
WHERE client.branch_id IN (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

