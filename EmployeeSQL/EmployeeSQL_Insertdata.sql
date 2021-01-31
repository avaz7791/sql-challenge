/*
Copy data from csv files to tables
*/
COPY titles (sk_title_id, title)FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/titles.csv' DELIMITER ',' CSV HEADER;
--select * from titles

COPY departments (sk_dept_no, dept_name)FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/departments.csv' DELIMITER ',' CSV HEADER;
--select * from departments

COPY salaries (sk_emp_no, salary)FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/salaries.csv' DELIMITER ',' CSV HEADER;
--select * from salaries

COPY employees (sk_emp_no,sk_emp_title_id, birth_date, first_name, last_name, sex, hire_date) FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/employees.csv' DELIMITER ',' CSV HEADER;
--select * from employees

COPY dept_manager (sk_dept_no, sk_emp_no)FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/dept_manager.csv' DELIMITER ',' CSV HEADER;
--select * from dept_manager

COPY dept_emp (sk_emp_no, sk_dept_no)FROM 'C:\Users\sonof\UCSDProjects\sql-challenge\Resources/dept_emp.csv' DELIMITER ',' CSV HEADER;
--select * from dept_emp




