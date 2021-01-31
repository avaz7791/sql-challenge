-- Create Database EmployeeSQL
--DROP DATABASE IF EXISTS "EmployeeSQL";
CREATE DATABASE "EmployeeSQL"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


-- Employee SQL DDL
drop table if exists titles;
CREATE TABLE "titles" (
	"tlt_id" serial   NOT NULL,
    "sk_title_id" varchar(30) primary key  NOT NULL,
    "title" varchar(30)   NOT NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER
);

drop table if exists salaries;
CREATE TABLE "salaries" (
    "sal_id"  serial NOT NULL,
    "sk_emp_no" int primary key  NOT NULL,
	"salary" decimal   NOT NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER
);
drop table if exists departments;
CREATE TABLE departments (
    dpt_id  Serial  NOT NULL,
    sk_dept_no varchar(4) primary key   NOT NULL,
    dept_name varchar(50)   NOT NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER
	
);

drop table if exists employees;
CREATE TABLE "employees" (
    "emp_id" serial   NOT NULL,
    "sk_emp_no" int primary key  NOT NULL,
    "sk_emp_title_id" varchar(30)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "full_name" varchar(100) NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
	"term_date" date NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER,
	
	foreign key (sk_emp_no) references salaries(sk_emp_no)
);

drop table if exists dept_manager;
CREATE TABLE "dept_manager" (
    "dpt_mgr_id"  serial primary key NOT NULL,
    "sk_dept_no" varchar(10)    NOT NULL,
    "sk_emp_no" int   NOT NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER,
	foreign key (sk_dept_no) references departments(sk_dept_no),
	foreign key (sk_emp_no) references employees(sk_emp_no)
);

drop table if exists dept_emp;
CREATE TABLE "dept_emp" (
    "dept_emp_id"  serial primary key  NOT NULL,
    "sk_emp_no" int   NOT NULL,
    "sk_dept_no" varchar(4)   NOT NULL,
	"row_created" timestamp default current_timestamp,
	"row_created_by" varchar(30)  default CURRENT_USER ,
	"row_modified" timestamp default current_timestamp,
	"row_modified_by" varchar(30)  default CURRENT_USER,
	
	foreign key (sk_emp_no) references employees(sk_emp_no),
	foreign key (sk_dept_no) references departments(sk_dept_no)
	
);

CREATE FUNCTION public.update_row_modified_function_()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
IF TG_OP = 'INSERT' THEN
NEW.row_created_ = CURRENT_TIMESTAMP(0);
NEW.row_created_by_ = CURRENT_USER;
RETURN NEW;
ELSIF TG_OP = 'UPDATE' THEN
NEW.row_modified_ = CURRENT_TIMESTAMP(0);
NEW.row_modified_by_ = CURRENT_USER;
RETURN NEW;
END IF;
END;
$BODY$;

ALTER FUNCTION public.update_row_modified_function_()
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.update_emp_fullname_function_()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	AS $BODY$
	BEGIN
		IF TG_OP = 'INSERT' THEN
		NEW.full_name = NEW.first_name ||' '||NEW.last_name;
		RETURN NEW;

	ELSIF TG_OP = 'UPDATE' THEN
	NEW.full_name = NEW.first_name ||' '||NEW.last_name;
	RETURN NEW;
	END IF;
	END;
	$BODY$;

ALTER FUNCTION public.update_emp_fullname_function_()
    OWNER TO postgres;

CREATE TRIGGER row_mod_on_titles_trigger_
BEFORE UPDATE
ON titles
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_titles2_trigger_
BEFORE UPDATE
ON departments
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_titles2_trigger_
BEFORE UPDATE
ON dept_emp
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_titles2_trigger_
BEFORE UPDATE
ON dept_manager
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_titles2_trigger_
BEFORE UPDATE
ON employees
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_titles2_trigger_
BEFORE UPDATE
ON salaries
FOR EACH ROW 
EXECUTE PROCEDURE update_row_modified_function_();

CREATE TRIGGER row_mod_on_employee_trigger_
BEFORE UPDATE
ON employees
FOR EACH ROW 
EXECUTE PROCEDURE update_emp_fullname_function_();
