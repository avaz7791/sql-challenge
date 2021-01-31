-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "titles" (
    "tlt_id" serial   NOT NULL,
    "sk_title_id" varchar(30)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "sk_title_id"
     )
);

CREATE TABLE "salaries" (
    "sal_id" serial   NOT NULL,
    "sk_emp_no" int   NOT NULL,
    "salary" decimal   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "sk_emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dpt_mgr_id" serial   NOT NULL,
    "sk_dept_no" varchar(10)   NOT NULL,
    "sk_emp_no" int   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dpt_mgr_id"
     )
);

CREATE TABLE "employees" (
    "emp_id" serial   NOT NULL,
    "sk_emp_no" int   NOT NULL,
    "sk_emp_title_id" varchar(30)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "full_name" varchar(100)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    "term_date" date   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "sk_emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "dept_emp_id" serial   NOT NULL,
    "sk_emp_no" int   NOT NULL,
    "sk_dept_no" varchar(4)   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "dept_emp_id"
     )
);

CREATE TABLE "departments" (
    "dpt_id" Serial   NOT NULL,
    "sk_dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    "row_created" timestamp   NOT NULL,
    "row_created_by" varchar(30)   NOT NULL,
    "row_modified" timestamp   NOT NULL,
    "row_modified_by" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "sk_dept_no"
     )
);

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_sk_title_id" FOREIGN KEY("sk_title_id")
REFERENCES "employees" ("sk_emp_title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_sk_emp_no" FOREIGN KEY("sk_emp_no")
REFERENCES "employees" ("sk_emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_sk_emp_no" FOREIGN KEY("sk_emp_no")
REFERENCES "employees" ("sk_emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_sk_emp_no" FOREIGN KEY("sk_emp_no")
REFERENCES "employees" ("sk_emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_sk_dept_no" FOREIGN KEY("sk_dept_no")
REFERENCES "departments" ("sk_dept_no");

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_sk_dept_no" FOREIGN KEY("sk_dept_no")
REFERENCES "dept_manager" ("sk_dept_no");

