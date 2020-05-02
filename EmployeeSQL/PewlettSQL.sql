-- Data Engineering

-- Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.
CREATE TABLE dept_emp (
  	emp_no INT NOT NULL,
  	dept_no VARCHAR(10) NOT NULL,
	from_date VARCHAR(10),
	to_date VARCHAR(10)
);

CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date VARCHAR(10),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	gender VARCHAR(20),
	hire_date VARCHAR(10)
);

CREATE TABLE departments (
 	dept_no VARCHAR(10) NOT NULL,
  	dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE dept_managers (
  	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	from_date VARCHAR(10),
	to_date VARCHAR(10)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date VARCHAR(10),
	to_date VARCHAR(10)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(50),
	from_date VARCHAR(10),
	to_date VARCHAR(10)
);


-- Import each CSV file into the corresponding SQL table.

-- Data Analysis

-- Once you have a complete database, do the following:

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, 
	employees.last_name, 
	employees.first_name, 
	employees.gender,
	salaries.salary
FROM employees
INNER JOIN salaries
ON (salaries.emp_no = employees.emp_no)

-- 2. List employees who were hired in 1986.
SELECT emp_no,
	last_name,
	first_name
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31'

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_managers.dept_no,
	departments.dept_name,
	dept_managers.emp_no,
	employees.last_name,
	employees.first_name,
	dept_managers.from_date,
	dept_managers.to_date
FROM dept_managers, employees, departments
WHERE dept_managers.emp_no = employees.emp_no
	AND departments.dept_no = dept_managers.dept_no
	

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees, dept_emp, departments
WHERE employees.emp_no = dept_emp.emp_no
	AND dept_emp.dept_no = departments.dept_no


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT last_name,
	first_name
FROM employees
WHERE employees.first_name = 'Hercules'
 	AND LEFT(last_name,1) = 'B'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees, dept_emp, departments
WHERE employees.emp_no = dept_emp.emp_no
	AND dept_emp.dept_no = departments.dept_no
	AND dept_name = 'Sales'

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM employees, dept_emp, departments
WHERE employees.emp_no = dept_emp.emp_no
	AND dept_emp.dept_no = departments.dept_no
	AND (dept_name = 'Sales' 
	 OR dept_name = 'Development')

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
	COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name ASC



