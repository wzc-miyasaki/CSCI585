SELECT AVG(cost) AS average_cost, AVG(duration) AS average_duration
FROM (
    SELECT b.BILLING_ID, b.MED_ID, p.PROCEDURE_NAME, m.DURATION, b.TOTAL_AMOUNT AS cost, m.RECORD_DATE AS procedure_date, b.BILL_DATE
    FROM BillingRecord b
    INNER JOIN MedicalRecord m ON b.MED_ID = m.RECORD_ID
    INNER JOIN procedures p ON m.procedure_type_id = p.procedure_id
) bill
WHERE procedure_date BETWEEN TO_DATE('2023-02-17', 'YYYY-MM-DD') AND TO_DATE('2023-02-18', 'YYYY-MM-DD');