# DBMS-Infosys-sectionA-341027-341025-341038
This project designs a relational database system for Infosys Limited to manage its organizational structure, employees, projects, skills, and reporting hierarchy. It demonstrates essential DBMS concepts such as ER modeling, relational integrity, normalization, and complex relationships using primary and foreign keys.
# Organisational Database Management System – Infosys Limited

Project Overview
This project presents an **enterprise-level relational database design** for modelling the organisational and operational structure of **Infosys Limited**, a global IT services company.  
The database captures real-world organisational complexity including hierarchy, employees, departments, projects, skills, performance management, and audit logging.

The system is designed using **advanced DBMS concepts** and implemented in **MySQL**, ensuring data integrity, scalability, and real-world applicability.

---

Objectives
- To design a **highly normalized relational database** for a real organisation
- To represent **multi-level organisational hierarchy**
- To implement **complex relationships** such as many-to-many and self-referencing entities
- To demonstrate **enterprise DBMS concepts** used in real IT companies
- To ensure **referential integrity, constraints, and temporal data tracking**

---

##  Organisation Modelled
- **Company**: Infosys Limited  
- **Industry**: Information Technology & Consulting  
- **Headquarters**: Bengaluru, India  

---

## Database Structure

### Core Entities
- Companies
- Business Units
- Locations
- Departments
- Teams
- Employees
- Roles
- Grades / Bands

### Advanced / Complexity Entities
- Projects
- Employee–Project Mapping (Many-to-Many)
- Skills
- Employee–Skill Mapping (Many-to-Many)
- Project–Technology Mapping
- Reporting History (Temporal)
- Salary History (Temporal)
- Performance Reviews
- Audit Log

---

## DBMS Concepts Demonstrated

ER Modelling  
Normalization (up to 3NF)  
Primary & Foreign Keys  
Self-Referencing Tables (Employee → Manager)  
Many-to-Many Relationships  
Composite Primary Keys  
Temporal Data (History Tables)  
CHECK & UNIQUE Constraints  
Aggregation & Grouping  
Enterprise-level Data Integrity  

This design reflects **real HR, project management, and governance systems** used in large IT organizations.

---

## Technology Stack
- **Database**: MySQL 8.x  
- **Tool**: MySQL Workbench  
- **Language**: SQL  

---

## How to Run the Project

1. Open **MySQL Workbench**
2. Create a new SQL tab
3. Copy and paste the full SQL script file: structure_org_infy.sql
4. Execute the script 
5. The database, tables, constraints, and sample data will be created automatically

To run analytical queries:
- Open `queries.sql`
- Execute queries individually to view outputs

---

## Repository Structure

---

## Sample Queries Included
- Organisational hierarchy (Employee to Manager)
- Employees per Business Unit
- Employee skill matrix
- Project technology requirements
- Performance analysis
- Audit log tracking
- Temporal reporting and salary history

---

## Academic Significance
This project goes **beyond basic DBMS requirements** and demonstrates how relational databases are used in **real enterprise environments**.  
It is suitable for **maximum marks**, viva discussions, and portfolio presentation.

---

DBMS Project – Academic Submission  

---

## License
This project is created for **educational purposes only**.
