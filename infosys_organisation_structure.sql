DROP DATABASE IF EXISTS structure_org_infy;
CREATE DATABASE structure_org_infy;
USE structure_org_infy;

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    headquarters VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE businessunits (
    bu_id INT PRIMARY KEY,
    bu_name VARCHAR(150),
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(100),
    level INT CHECK (level > 0)
);

CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    grade_name VARCHAR(20),
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(150),
    bu_id INT,
    location_id INT,
    FOREIGN KEY (bu_id) REFERENCES businessunits(bu_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(150),
    email VARCHAR(150) UNIQUE,
    dept_id INT,
    team_id INT,
    role_id INT,
    grade_id INT,
    manager_id INT,
    date_of_joining DATE,
    status VARCHAR(20) CHECK (status IN ('Active','Inactive')),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (grade_id) REFERENCES grades(grade_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE reporting_history (
    emp_id INT,
    manager_id INT,
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (emp_id, manager_id, from_date),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE salary_history (
    emp_id INT,
    grade_id INT,
    salary DECIMAL(10,2),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (emp_id, from_date),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(150),
    bu_id INT,
    location_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (bu_id) REFERENCES businessunits(bu_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role_on_project VARCHAR(100),
    allocation_percent INT CHECK (allocation_percent <= 100),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE skills (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(100) UNIQUE
);

CREATE TABLE employee_skills (
    emp_id INT,
    skill_id INT,
    proficiency VARCHAR(50),
    PRIMARY KEY (emp_id, skill_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE project_technologies (
    project_id INT,
    skill_id INT,
    PRIMARY KEY (project_id, skill_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY,
    emp_id INT,
    review_year INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    remarks VARCHAR(200),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE audit_log (
    log_id INT PRIMARY KEY,
    entity_name VARCHAR(100),
    entity_id INT,
    action VARCHAR(50),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO companies VALUES (1,'Infosys Limited','Bengaluru','India');

INSERT INTO businessunits VALUES
(10,'Infosys Consulting',1),
(20,'Infosys BPM',1),
(30,'EdgeVerve Systems',1);

INSERT INTO locations VALUES
(100,'Bengaluru','Karnataka','India'),
(101,'Pune','Maharashtra','India'),
(102,'Hyderabad','Telangana','India');

INSERT INTO roles VALUES
(1,'Chairman',1),
(2,'CEO',2),
(3,'BU Head',3),
(4,'Manager',4),
(5,'Senior Engineer',5),
(6,'Engineer',6);

INSERT INTO grades VALUES
(1,'G1',300000,600000),
(2,'G2',600000,1200000),
(3,'G3',1200000,2500000);

INSERT INTO departments VALUES
(1000,'HR',10,100),
(1001,'Delivery',10,100),
(1002,'Operations',20,101),
(1003,'Product Dev',30,102);

INSERT INTO teams VALUES
(1,'HR Ops',1000),
(2,'Delivery Alpha',1001),
(3,'AI Core',1003);

INSERT INTO employees VALUES
(1,'Chairman','chairman@infosys.com',1000,1,1,3,NULL,'2010-01-01','Active'),
(2,'CEO','ceo@infosys.com',1001,2,2,3,1,'2015-01-01','Active'),
(3,'BU Head Consulting','head.cons@infosys.com',1001,2,3,3,2,'2017-01-01','Active'),
(4,'Delivery Manager','dm@infosys.com',1001,2,4,2,3,'2019-01-01','Active'),
(5,'Senior Engineer','se@infosys.com',1001,2,5,2,4,'2021-01-01','Active');

INSERT INTO projects VALUES
(501,'Digital Transformation',10,100,'2023-01-01',NULL);

INSERT INTO employee_projects VALUES
(4,501,'Manager',100),
(5,501,'Developer',80);

INSERT INTO skills VALUES
(1,'SQL'),
(2,'Java'),
(3,'Python'),
(4,'AI');

INSERT INTO employee_skills VALUES
(4,4,'Expert'),
(5,1,'Advanced'),
(5,3,'Intermediate');

INSERT INTO project_technologies VALUES
(501,1),
(501,4);

INSERT INTO performance_reviews VALUES
(1,5,2023,5,'Outstanding performance');

INSERT INTO audit_log VALUES
(1,'employees',5,'INSERT',CURRENT_TIMESTAMP);

-- Employee Hierarchy
SELECT e.full_name AS Employee, m.full_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- Skill demand per project
SELECT p.project_name, s.skill_name
FROM project_technologies pt
JOIN projects p ON pt.project_id = p.project_id
JOIN skills s ON pt.skill_id = s.skill_id;

-- Performance summary
SELECT e.full_name, pr.rating
FROM performance_reviews pr
JOIN employees e ON pr.emp_id = e.emp_id;

