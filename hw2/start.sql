DROP TABLE patient;
DROP TABLE procedures;

CREATE TABLE patient (
    patient_id NUMBER NOT NULL,
    patient_name VARCHAR2(255),
    CONSTRAINT patient_pk PRIMARY KEY (patient_id)
);

CREATE TABLE procedures (
    procedure_id INT NOT NULL,
    procedure_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (procedure_id)
);

CREATE TABLE medicalRecord (
    record_id NUMBER NOT NULL,
    patientID NUMBER NOT NULL,
    procedure_type_id NUMBER NOT NULL,
    duration NUMBER NOT NULL,
    record_date DATE,
    CONSTRAINT record_pk PRIMARY KEY (record_id),
    CONSTRAINT fk_patientID FOREIGN KEY (patientID)
        REFERENCES patient(patient_id),
    CONSTRAINT fk_procedure_type_id FOREIGN KEY (procedure_type_id)
        REFERENCES procedures(procedure_id)
);

CREATE TABLE BillingRecord (
    billing_id NUMBER NOT NULL,
    med_id NUMBER NOT NULL,
    total_amount NUMBER NOT NULL,
    bill_date DATE,
    CONSTRAINT bill_pk PRIMARY KEY (billing_id),
    CONSTRAINT fk_medicalID FOREIGN KEY (med_id)
        REFERENCES medicalRecord(record_id)
);




-- initialize table procedures 
INSERT INTO procedures (procedure_id, procedure_name) VALUES (1, 'Dental Examinations');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (2, 'Teeth Cleaning');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (3, 'Fillings');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (4, 'Crowns');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (5, 'Teeth Whitening');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (6,  'Veneers');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (7, 'Braces');
INSERT INTO procedures (procedure_id, procedure_name) VALUES (8, 'Clear Aligners');

-- initialize table patient
INSERT INTO patient (patient_id, patient_name) VALUES (1, 'John Doe');
INSERT INTO patient (patient_id, patient_name) VALUES (2, 'Jane Smith');
INSERT INTO patient (patient_id, patient_name) VALUES (3, 'Michael Johnson');
INSERT INTO patient (patient_id, patient_name) VALUES (4, 'Emily Davis');
INSERT INTO patient (patient_id, patient_name) VALUES (5, 'William Brown');
INSERT INTO patient (patient_id, patient_name) VALUES (6, 'Emma Wilson');
INSERT INTO patient (patient_id, patient_name) VALUES (7, 'Olivia Martinez');
INSERT INTO patient (patient_id, patient_name) VALUES (8, 'Noah Miller');
INSERT INTO patient (patient_id, patient_name) VALUES (9, 'Ava Taylor');
INSERT INTO patient (patient_id, patient_name) VALUES (10, 'Isabella Anderson');
INSERT INTO patient (patient_id, patient_name) VALUES (11, 'Sophia Thomas');
INSERT INTO patient (patient_id, patient_name) VALUES (12, 'Mason Jackson');
INSERT INTO patient (patient_id, patient_name) VALUES (13, 'James White');
INSERT INTO patient (patient_id, patient_name) VALUES (14, 'Charlotte Harris');
INSERT INTO patient (patient_id, patient_name) VALUES (15, 'Liam Martin');

-- Q1 query

