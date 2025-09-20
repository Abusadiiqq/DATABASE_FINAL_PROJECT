Clinic Management System Database
Autor [Abubakar Hassan]
📋 Project Overview
This project implements a comprehensive relational database system for managing a medical clinic's operations. The database handles patient information, doctor details, medical specialties, and appointment scheduling with robust data integrity constraints.

✨ Features
Normalized Database Design following 3rd Normal Form (3NF)

Data Integrity Enforcement through foreign keys and constraints

Business Logic Implementation preventing double-booking of doctors

Automated Data Management with cascading delete operations

Sample Data for immediate testing and demonstration

🗄️ Database Schema
Tables Structure
patients - Stores patient personal information

doctors - Contains doctor details and their specialties

specialties - Lookup table for medical specialties

appointments - Junction table managing patient-doctor appointments

Key Constraints
Unique email constraint for patients

Prevention of doctor double-booking through unique constraints

Referential integrity with foreign key relationships

Data validation through ENUM types

🚀 Installation & Setup
Prerequisites
MySQL Server (5.7 or higher)

MySQL Workbench or command-line access

Installation Steps
Clone or download the project files

Access MySQL:

bash
mysql -u root -p
Execute the SQL script:

sql
source /path/to/clinic_database.sql;
or run the entire script in MySQL Workbench

Verify installation by checking the created database:

sql
SHOW DATABASES;
USE clinic_db;
SHOW TABLES;
📊 Sample Queries
The database includes these demonstration queries:

View all scheduled appointments with details:

sql
SELECT a.appointment_time, p.first_name, p.last_name, 
       d.first_name, d.last_name, s.name 
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE a.status = 'Scheduled'
ORDER BY a.appointment_time;
Find doctors by specialty:

sql
SELECT d.first_name, d.last_name
FROM doctors d
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE s.name = 'Cardiology';
🧪 Testing the Database
Verifying Constraints
Test unique email:

sql
INSERT INTO patients (first_name, last_name, date_of_birth, email)
VALUES ('Test', 'User', '2000-01-01', 'john.doe@email.com');
-- This should fail due to duplicate email
Test double-booking prevention:

sql
INSERT INTO appointments (patient_id, doctor_id, appointment_time)
VALUES (1, 1, '2024-11-05 14:30:00');
-- This should fail as the doctor is already booked
Test foreign key integrity:

sql
INSERT INTO appointments (patient_id, doctor_id, appointment_time)
VALUES (999, 999, '2024-11-07 10:00:00');
-- This should fail due to non-existent IDs
🔄 Entity Relationship Diagram
https://via.placeholder.com/600x400/EEE/333?text=Clinic+Database+ER+Diagram
For a visual representation of the database structure, refer to the ER diagram included in the project files.

📁 File Structure
text
clinic_database/
├── clinic_database.sql  # Main database creation script
├── README.md           # This documentation file
└── er_diagram.png      # Entity Relationship Diagram
👨‍💻 Author
[Your Name]

📄 License
This project is created for educational purposes.

💡 Usage Notes
The database automatically creates sample data for immediate testing

All tables use InnoDB engine for transaction support

The appointment system uses 24-hour format for consistency

Status fields use ENUM types to ensure data validity

For any questions or issues regarding this database implementation, please refer to the SQL comments within the script or consult the MySQL documentation.

