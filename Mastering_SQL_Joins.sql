-- Working with JOINS By Khaja Arsalaan
-- Skills used are INNER, LEFT, RIGHT Joins, Joins using where clause, join with more than 2 tables,
-- Cleaning duplicate records and Using Aggregate funtions with joins

/*INNER JOIN*/

-- Extract all managers' employees number, department number, 
-- and department name. Order by the manager's department number
Select m.emp_no, m.dept_no, d.dept_name 
from dept_manager_dup m join departments_dup d
on m.dept_no = d.dept_no  order by m.dept_no;

-- Adding m.from_date and m.to_date to the aboce query for more details
Select m.emp_no, m.dept_no, d.dept_name, m.from_date,m.to_date
from dept_manager_dup m join departments_dup d
on m.dept_no = d.dept_no  order by m.dept_no;

-- Extract a list containing information about all managers' employee number, 
-- first and last name, dept_number and hire_date
select e.emp_no, e.first_name, e.last_name,  e.hire_date ,  m.dept_no 
from  employees e JOIN dept_manager m  ON m.emp_no= e.emp_no; -- Hint: check table data first and  them use the tables 
															-- ( in this case we used employees and dept_manager tables)
-- Retrieve data from the employees and dept_manager
SELECT * FROM employees;
SELECT * FROM dept_manager;

-- Duplicate Records (retrieving data from the two 
-- tables with duplicate records using INNER JOIN)

-- Let us add some duplicate records
-- Insert records into the dept_manager_dup and departments_dup tables respectively

INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- Select all records from the dept_manager_dup table
SELECT *
FROM dept_manager_dup where dept_no is not null
ORDER BY dept_no ASC;

-- Select all records from the departments_dup table
SELECT *
FROM departments_dup where dept_no is not null
ORDER BY dept_no ASC;

-- Perform INNER JOIN as before
select m.emp_no, m.dept_no, d.dept_name from dept_manager_dup m 
Join departments_dup d ON m.dept_no= d.dept_no order by m.dept_no;

-- Add a GROUP BY clause. To make sure to include all the fields in the GROUP BY clause and to exclude duplicate values
select m.emp_no, m.dept_no, d.dept_name from dept_manager_dup m 
Join departments_dup d ON m.dept_no= d.dept_no group by m.emp_no, m.dept_no, d.dept_name order by m.dept_no; 


/* LEFT JOIN*/


-- Removing the duplicates from the two tables
DELETE FROM dept_manager_dup 
WHERE emp_no = '110228';
        
DELETE FROM departments_dup 
WHERE dept_no = 'd009';

-- Adding back the initial records
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- Select all records from dept_manager_dup
SELECT *
FROM dept_manager_dup
ORDER BY dept_no;

-- Select all records from departments_dup
SELECT *
FROM departments_dup
ORDER BY dept_no;

-- Recalling, when we had INNER JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Join the dept_manager_dup and departments_dup tables
-- Extract a subset of all managers' employee number, department number, 
-- and department name. Order by the managers' department number

-- What will happen when we d LEFT JOIN m?
-- LEFT OUTER JOIN
Select * from dept_manager_dup;
Select * from  departments_dup;

select m.emp_no, m.dept_no, d.dept_name from dept_manager_dup m 
LEFT JOIN departments_dup d ON m.dept_no=d.dept_no order by m.dept_no;


/* RIGHT JOIN*/

-- Let's use RIGHT JOIN

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY dept_no;


-- JOIN and WHERE Used Together

-- Extract the employee number, first name, last name and salary of all employees who earn above 145000 dollars per year
SELECT s.emp_no, e.first_name, e.last_name, s.salary from salaries s JOIN 
employees e ON s.emp_no=e.emp_no where salary > 145000;

-- Select the first and last name, the hire date and the salary of all employees whose first name is 'Mario' and last_name is 'Straney'
 select * from salaries;
 select * from employees;
 
 Select e.first_name, e.last_name, e.hire_date, s.salary from employees e 
 JOIN salaries s ON e.emp_no=s.emp_no where e.first_name= 'Mario' and e.last_name='Straney';

-- Joining the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose 
-- last name is 'Markovitch'. See if the output contains a manager with that name.
select * from dept_manager;
select e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date from employees e  	##This query shows us the data from employees and department manager table and give us
Left JOIN dept_manager dm on e.emp_no=dm.emp_no where e.last_name ='Markovitch' order by emp_no desc; 	## the output in which we can find who's the manager among the employees with last name "Markovitch"

-- Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees who were hired before 31st of January, 1985
Select e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date from employees e  
Left JOIN dept_manager dm on e.emp_no=dm.emp_no where e.hire_date = 1985-01-31 order by emp_no desc;


/* Using Aggregate Functions with Joins */

-- What is the average salary for the different gender?
SELECT e.gender, ROUND(avg(s.salary),2) from employees e 
JOIN salaries s ON e.emp_no=s.emp_no group by e.gender;

-- What do you think will be the output if we SELECT e.emp_no?
SELECT e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, gender; 

-- How many males and how many females managers do we have in employees database?
select * from employees;
select e.gender, Count(dm.emp_no) as 'Total Managers' from employees e
JOIN dept_manager dm ON e.emp_no=dm.emp_no group by e.gender;


-- Joining more than Two Tables in SQL

-- Extract a list of all managers' emp number, first and last name, dept_no, hire date, to_date, and department name
select e.emp_no, e.first_name, e.last_name, de.dept_no, e.hire_date, de.to_date, d.dept_name  from employees e
join dept_manager de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no;


-- Retrieve the average salary for the different departments
select d.dept_name , round(avg(s.salary),2) as Avg_Salary from salaries s
join dept_emp de ON s.emp_no=de.emp_no 		## we are using dept_emp table to connect 2 tables as salary and departments does not have any common column to connect.
join departments d on d.dept_no=de.dept_no group by d.dept_name order by avg(salary) desc;

-- Retrieve the average salary for the different departments where the average_salary is more than 60000
Select d.dept_name , round(avg(s.salary),2) as Avg_Salary from salaries s
join dept_emp de ON s.emp_no=de.emp_no 	
join departments d on d.dept_no=de.dept_no 
group by d.dept_name Having avg(salary)>60000  order by avg(salary) desc;
