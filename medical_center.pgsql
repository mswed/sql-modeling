DROP DATABASE medical;
CREATE DATABASE medical;
\c medical

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name TEXT, 
    last_name TEXT
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES doctors,
    patient_id INTEGER REFERENCES patients,
    visit_date DATE
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE diagnosis (
    id SERIAL PRIMARY KEY,
    visit_id INTEGER REFERENCES visits,
    disease_id INTEGER REFERENCES diseases
);

INSERT INTO
    doctors (first_name, last_name)
VALUES
    ('Robert', 'Robertson'),
    ('Daniella', 'Cohn'),
    ('Vladimir', 'Putin');

INSERT INTO
    patients (first_name, last_name)
VALUES
    ('Liliana', 'Rain'),
    ('John', 'Reese'),
    ('Harold', 'Finch');

INSERT INTO
    visits (doctor_id, patient_id, visit_date)
VALUES
    (1, 2, '2024-01-01'),
    (3, 3, '2023-12-25'),
    (2, 1, '2023-12-25'),
    (2, 2, '2023-06-07');

INSERT INTO 
diseases (name)
VALUES
('Flu'),
('Covid'),
('Blister'),
('Rash'),
('Migrane'),
('Ulcer');

INSERT INTO 
diagnosis (visit_id, disease_id)
VALUES
(1, 2),
(2, 1),
(2, 3),
(3, 4),
(3, 5),
(4, 6);