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

