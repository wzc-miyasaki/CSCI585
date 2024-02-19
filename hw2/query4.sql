CREATE TABLE employee (
    employee_id CHAR(4) NOT NULL,
    full_name VARCHAR2(255),
    CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);

CREATE TABLE procedures (
    procedure_id INT NOT NULL,
    procedure_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (procedure_id)
);

CREATE TABLE procedureAppointment (
    app_id CHAR(6) NOT NULL,
    patient_id NUMBER NOT NULL,
    doctor_id CHAR(4) NOT NULL,
    app_date DATE,
    CONSTRAINT app_pk PRIMARY KEY (app_id),
    CONSTRAINT fk_doctor_id FOREIGN KEY (doctor_id)
        REFERENCES employee(employee_id)
);

CREATE TABLE medicalRecord (
    record_id NUMBER NOT NULL,
    patientID NUMBER NOT NULL,
    procedure_type_id NUMBER NOT NULL,
    duration NUMBER NOT NULL,
    appointment_id CHAR(6),
    record_date DATE,
    CONSTRAINT record_pk PRIMARY KEY (record_id),
    CONSTRAINT fk_procedure_type_id FOREIGN KEY (procedure_type_id)
        REFERENCES procedures(procedure_id),
    CONSTRAINT fk_app_id FOREIGN KEY (appointment_id)
        REFERENCES procedureAppointment(app_id)
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


INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('1', 'Dental Examinations');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('2', 'Teeth Cleaning');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('3', 'Fillings');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('4', 'Crowns');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('5', 'Teeth Whitening');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('6', 'Veneers');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('7', 'Braces');
INSERT INTO procedures (PROCEDURE_ID, PROCEDURE_NAME) VALUES ('8', 'Clear Aligners');

INSERT INTO employee (employee_id, full_name) VALUES ('X001', 'John Doe');
INSERT INTO employee (employee_id, full_name) VALUES ('X002', 'Jane Smith');
INSERT INTO employee (employee_id, full_name) VALUES ('X003', 'Emily Davis');
INSERT INTO employee (employee_id, full_name) VALUES ('X004', 'Michael Brown');
INSERT INTO employee (employee_id, full_name) VALUES ('X005', 'Alex Johnson');
INSERT INTO employee (employee_id, full_name) VALUES ('X006', 'Chris Lee');


INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC001', '2', 'X001', '18-FEB-23');
INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC002', '3', 'X001', '18-FEB-23');
INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC003', '4', 'X003', '18-FEB-23');
INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC004', '5', 'X003', '18-FEB-23');
INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC005', '6', 'X003', '18-FEB-23');
INSERT INTO procedureAppointment (APP_ID, PATIENT_ID, DOCTOR_ID, APP_DATE) VALUES ('ZEC006', '7', 'X003', '18-FEB-23');


INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('4', '2', '1', '14', 'ZEC001', '18-FEB-23');
INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('5', '3', '1', '14', 'ZEC002', '18-FEB-23');
INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('6', '4', '1', '14', 'ZEC003', '18-FEB-23');
INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('7', '5', '1', '17', 'ZEC004', '18-FEB-23');
INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('8', '6', '4', '25', 'ZEC005', '18-FEB-23');
INSERT INTO medicalRecord (RECORD_ID, PATIENTID, PROCEDURE_TYPE_ID, DURATION, APPOINTMENT_ID, RECORD_DATE) VALUES ('9', '7', '3', '40', 'ZEC006', '18-FEB-23');

INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('4', '4', '55', '18-Feb-23');
INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('5', '5', '55', '18-Feb-23');
INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('6', '6', '55', '18-Feb-23');
INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('7', '7', '55', '18-Feb-23');
INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('8', '8', '120', '18-Feb-23');
INSERT INTO BillingRecord (BILLING_ID, MED_ID, TOTAL_AMOUNT, BILL_DATE) VALUES ('9', '9', '100', '18-Feb-23');


SELECT m.record_id, p.procedure_name, m.duration, m.patientID, m.record_date, e.full_name AS doctor_Name, b.total_amount AS income
FROM medicalRecord m
INNER JOIN procedureAppointment a ON m.APPOINTMENT_ID = a.app_id
INNER JOIN employee e ON a.DOCTOR_ID = e.employee_id
INNER JOIN procedures p ON m.PROCEDURE_TYPE_ID = p.procedure_id
INNER JOIN BillingRecord b ON m.RECORD_ID = b.med_id;


SELECT tmp.DOCTOR_NAME, tmp.PROCEDURE_NAME, SUM(tmp.INCOME) AS total_income
FROM (
    SELECT m.record_id, p.procedure_name, m.duration, m.patientID, m.record_date, e.full_name AS doctor_Name, b.total_amount AS income
    FROM medicalRecord m
    INNER JOIN procedureAppointment a ON m.APPOINTMENT_ID = a.app_id
    INNER JOIN employee e ON a.DOCTOR_ID = e.employee_id
    INNER JOIN procedures p ON m.PROCEDURE_TYPE_ID = p.procedure_id
    INNER JOIN BillingRecord b ON m.RECORD_ID = b.med_id
) tmp 
WHERE tmp.RECORD_DATE IN ('18-FEB-23')
GROUP BY doctor_name, procedure_name;

