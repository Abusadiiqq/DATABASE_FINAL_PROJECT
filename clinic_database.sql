-- Clinic Management System Database Schema
-- Created by [Abubakar Hassan] for [Database Final Project]
-- Date: [20/09/2025]

-- 1. DROP and CREATE the database (ensures a clean slate)
DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE clinic_db;
USE clinic_db; -- Switch to the new database

-- 2. Create tables in order of dependency (independent tables first)
-- Specialties table is independent
CREATE TABLE specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE COMMENT 'e.g., Cardiology, Neurology'
);

-- Patients table is independent
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL COMMENT 'Must be unique for login/contact'
);

-- Doctors table depends on specialties
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty_id INT NOT NULL,
    FOREIGN KEY (specialty_id) REFERENCES specialties(specialty_id) ON DELETE RESTRICT -- Prevent delete if doctors exist in this specialty
);

-- Appointments table depends on patients and doctors (the core junction table)
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_time DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,

    -- Define Foreign Keys with actions
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE, -- If a patient is deleted, delete their appointments.
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE, -- If a doctor is deleted, delete their appointments.

    -- BUSINESS LOGIC CONSTRAINT: A doctor cannot have two appointments at the same time.
    -- This is the most important constraint in this system.
    UNIQUE KEY unique_doctor_time (doctor_id, appointment_time),

    -- (Optional) A patient shouldn't have two appointments at the same time either.
    UNIQUE KEY unique_patient_time (patient_id, appointment_time)
) COMMENT='Junction table linking patients and doctors. Contains appointment details.';

-- 3. POPULATE with sample data (Crucial for testing and demonstration)
INSERT INTO specialties (name) VALUES
('Cardiology'),
('Dermatology'),
('Neurology'),
('Pediatrics');

INSERT INTO patients (first_name, last_name, date_of_birth, phone, email) VALUES
('John', 'Doe', '1985-07-15', '555-123-4567', 'john.doe@email.com'),
('Jane', 'Smith', '1990-11-22', '555-987-6543', 'jane.smith@email.com');

INSERT INTO doctors (first_name, last_name, specialty_id) VALUES
('Alice', 'Williams', (SELECT specialty_id FROM specialties WHERE name = 'Cardiology')),
('Bob', 'Brown', (SELECT specialty_id FROM specialties WHERE name = 'Neurology'));

INSERT INTO appointments (patient_id, doctor_id, appointment_time, status) VALUES
(1, 1, '2024-11-05 14:30:00', 'Scheduled'),
(2, 2, '2024-11-06 10:00:00', 'Scheduled');

-- 4. DEMONSTRATE FUNCTIONALITY with sample queries
-- Query 1: Show all scheduled appointments with patient and doctor info
SELECT
    a.appointment_time,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    s.name AS doctor_specialty
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE a.status = 'Scheduled'
ORDER BY a.appointment_time;

-- Query 2: Show all doctors in a specific specialty
SELECT d.first_name, d.last_name
FROM doctors d
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE s.name = 'Cardiology';
