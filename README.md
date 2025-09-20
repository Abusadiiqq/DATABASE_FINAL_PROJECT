# Clinic Management System Database

## Author
[Abubakar Hassan]

## Description
This project implements a robust and normalized relational database schema for a clinic management system. It handles patients, doctors, their specialties, and appointments, enforcing critical business rules like preventing double-booking.

## Features
- **Normalized Design (3NF):** Eliminates data redundancy.
- **Data Integrity:** Enforced via Foreign Keys, Unique constraints, and ENUM types.
- **Business Logic:** Prevents a doctor from being double-booked (`UNIQUE` constraint on `(doctor_id, appointment_time)`).
- **Cascading Actions:** Automatically cleans up appointments if a patient or doctor is deleted.

## Entity-Relationship Diagram (ERD)
![ER Diagram](https://i.imgur.com/your-diagram-link.png) *(Pro Tip: Draw your diagram in draw.io, export it as a PNG, upload it to Imgur, and put the link here)*

## Schema Overview
| Table | Description |
| :--- | :--- |
| `patients` | Stores patient personal information. |
| `doctors` | Stores doctor details and links to their specialty. |
| `specialties` | Lookup table for medical specialties. |
| `appointments` | Junction table that links patients to doctors at a specific time. |

## Installation & Setup
1.  Ensure MySQL Server is installed and running.
2.  Log into the MySQL command line as root: `mysql -u root -p`
3.  Execute the SQL script: `source /path/to/your/clinic_database.sql`

## Sample Queries
The script includes sample data and demonstration queries showing:
1.  All scheduled appointments with patient and doctor details.
2.  Finding all doctors in a specific specialty.

## Files
- `clinic_database.sql` - The main SQL script to create, populate, and demonstrate the database.
