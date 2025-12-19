drop database if exists structure_org_infy;
create database structure_org_infy;
use structure_org_infy;

create table companies (
    company_id int primary key,
    company_name varchar(30) not null,
    headquarters varchar(30),
    country varchar(30)
);

create table businessunits (
    bu_id int primary key,
    bu_name varchar(30),
    company_id int,
    foreign key (company_id) references companies(company_id)
);

create table locations (
    location_id int primary key,
    city varchar(30),
    state varchar(30),
    country varchar(30)
);

create table roles (
    role_id int primary key,
    role_name varchar(30),
    level int check (level > 0)
);

create table grades (
    grade_id int primary key,
    grade_name varchar(20),
    min_salary decimal(10,2),
    max_salary decimal(10,2)
);

create table departments (
    dept_id int primary key,
    dept_name varchar(30),
    bu_id int,
    location_id int,
    foreign key (bu_id) references businessunits(bu_id),
    foreign key(location_id) references locations(location_id)
);

create table teams (
    team_id int primary key,
    team_name varchar(30),
    dept_id int,
    foreign key (dept_id) references departments(dept_id)
);

create table employees (
    emp_id int primary key,
    full_name varchar(30),
    email varchar(30) unique,
    dept_id int,
    team_id int,
    role_id int,
    grade_id int,
    manager_id int,
    date_of_joining date,
    status varchar(20) check (status in ('Active','Inactive')),
    foreign key (dept_id) references departments(dept_id),
    foreign key (team_id) references teams(team_id),
    foreign key (role_id) references roles(role_id),
    foreign key (grade_id) references grades(grade_id),
    foreign key (manager_id) references employees(emp_id)
);

create table reporting_history (
    emp_id int,
    manager_id int,
    from_date date,
    to_date date,
    primary key (emp_id, manager_id, from_date),
    foreign key (emp_id) references employees(emp_id),
    foreign key (manager_id) references employees(emp_id)
);

create table salary_history (
    emp_id int,
    grade_id int,
    salary decimal(10,2),
    from_date date,
    to_date date,
    primary key (emp_id, from_date),
    foreign key (emp_id) references employees(emp_id)
);

create table projects (
    project_id int primary key,
    project_name varchar(30),
    bu_id int,
    location_id int,
    start_date date,
    end_date date,
    foreign key (bu_id) references businessunits(bu_id),
    foreign key (location_id) references locations(location_id)
);

create table employee_projects (
    emp_id int,
    project_id int,
    role_on_project varchar(30),
    allocation_percent int check (allocation_percent <= 100),
	primary key (emp_id, project_id),
    foreign key (emp_id) references employees(emp_id),
    foreign key (project_id) references projects(project_id)
);

create table skills (
    skill_id int primary key,
    skill_name varchar(30) unique
);

create table employee_skills (
    emp_id int,
    skill_id int,
    proficiency varchar(30),
    primary key (emp_id, skill_id),
    foreign key (emp_id) references employees(emp_id),
    foreign key (skill_id) references skills(skill_id)
);

create table project_technologies (
    project_id int,
    skill_id int,
    primary key (project_id, skill_id),
    foreign key (project_id) references projects(project_id),
    foreign key (skill_id) references skills(skill_id)
);

create table performance_reviews (
    review_id int primary key,
    emp_id int,
    review_year int,
    rating int check (rating between 1 and 5),
    remarks varchar(30),
    foreign key (emp_id) references employees(emp_id)
);

create table audit_log (
    log_id int primary key,
    entity_name varchar(30),
    entity_id int,
    action varchar(30),
    action_date timestamp default current_timestamp
);

in companies VALUES (1,'Infosys Limited','Bengaluru','India');

insert into businessunits values
(10,'Infosys Consulting',1),
(20,'Infosys BPM',1),
(30,'EdgeVerve Systems',1);

insert into locations values
(100,'Bengaluru','Karnataka','India'),
(101,'Pune','Maharashtra','India'),
(102,'Hyderabad','Telangana','India');

insert into roles values
(1,'Chairman',1),
(2,'CEO',2),
(3,'BU Head',3),
(4,'Manager',4),
(5,'Senior Engineer',5),
(6,'Engineer',6);

insert into grades values
(1,'G1',300000,600000),
(2,'G2',600000,1200000),
(3,'G3',1200000,2500000);

insert into departments values
(1000,'HR',10,100),
(1001,'Delivery',10,100),
(1002,'Operations',20,101),
(1003,'Product Dev',30,102);

insert into teams values
(1,'HR Ops',1000),
(2,'Delivery Alpha',1001),
(3,'AI Core',1003);

insert into employees values
(1,'Chairman','chairman@infosys.com',1000,1,1,3,null,'2010-01-01','Active'),
(2,'CEO','ceo@infosys.com',1001,2,2,3,1,'2015-01-01','Active'),
(3,'BU Head Consulting','head.cons@infosys.com',1001,2,3,3,2,'2017-01-01','Active'),
(4,'Delivery Manager','dm@infosys.com',1001,2,4,2,3,'2019-01-01','Active'),
(5,'Senior Engineer','se@infosys.com',1001,2,5,2,4,'2021-01-01','Active');

insert into projects values
(501,'Digital Transformation',10,100,'2023-01-01',NULL);

insert into employee_projects values
(4,501,'Manager',100),
(5,501,'Developer',80);

insert into skills values
(1,'SQL'),
(2,'Java'),
(3,'Python'),
(4,'AI');

insert into employee_skills values
(4,4,'Expert'),
(5,1,'Advanced'),
(5,3,'Intermediate');

insert into project_technologies values
(501,1),
(501,4);

insert into performance_reviews values
(1,5,2023,5,'Outstanding performance');

insert into audit_log values
(1,'employees',5,'INSERT',current_timestamp);

-- Employee Hierarchy
select e.full_name as Employee, m.full_name as Manager
from employees e
left join employees m on e.manager_id = m.emp_id;

-- Skill demand per project
select p.project_name, s.skill_name
from project_technologies pt
join projects p ON pt.project_id = p.project_id
join skills s ON pt.skill_id = s.skill_id;

-- Performance summary
select e.full_name, pr.rating
from performance_reviews pr
join employees e on pr.emp_id = e.emp_id;

