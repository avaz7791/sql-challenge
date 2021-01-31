--1) List the following details of each employee: employee number, last name, first name, sex, and salary.
select 
	 e.sk_emp_no as "employee number"
	,e.last_name
	,e.first_name
	,e.sex
	,s.salary
from employees e
inner join salaries s on e.sk_emp_no = s.sk_emp_no

--2) List first name, last name, and hire date for employees who were hired in 1986.
select 
	 e.first_name
	,e.last_name
	,e.hire_date
from employees e
where extract(year from e.hire_date) = 1986

--3) List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
select 
	 d.sk_dept_no
	,d.dept_name
	,e.sk_emp_no as "employee number"
	,e.last_name
	,e.first_name
from dept_manager dm
inner join employees e on e.sk_emp_no = dm.sk_emp_no
inner join departments d on dm.sk_dept_no = d.sk_dept_no

--4) List the department of each employee with the following information: employee number, last name, first name, and department name.
select 
	 e.sk_emp_no as "employee number"
	,e.last_name
	,e.first_name
	,d.dept_name
from employees e 
inner join dept_emp de on e.sk_emp_no = de.sk_emp_no
inner join departments d on d.sk_dept_no = de.sk_dept_no
order by d.dept_name 

--5) List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select 
	e.first_name
	,e.last_name
	,e.sex
from employees e
where e.first_name = 'Hercules' and last_name like 'B%'

--6) List all employees in the Sales department, including their employee number, last name, first name, and department name.
select 
	 e.sk_emp_no as "employee number"
	,e.last_name
	,e.first_name
	,d.dept_name
from employees e 
inner join dept_emp de on e.sk_emp_no = de.sk_emp_no
inner join departments d on d.sk_dept_no = de.sk_dept_no
where d.dept_name ='Sales'

--7) List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select 
	 e.sk_emp_no as "employee number"
	,e.last_name
	,e.first_name
	,d.dept_name
from employees e 
inner join dept_emp de on e.sk_emp_no = de.sk_emp_no
inner join departments d on d.sk_dept_no = de.sk_dept_no
where d.dept_name in ('Sales','Development')

--8) In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select 
	e.last_name
	,count(*) as "cnt_employees"
from employees e 
group by e.last_name
order by count(*) desc



--April Foolsday
select * from employees e where e.sk_emp_no = 499942