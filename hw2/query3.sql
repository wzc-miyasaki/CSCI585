
CREATE TABLE employee (
    employee_id CHAR(4) NOT NULL,
    full_name VARCHAR2(255),
    CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);


CREATE TABLE capability (
    employee_id CHAR(4) NOT NULL,
    skill VARCHAR2(255) NOT NULL,
    CONSTRAINT capability_pk PRIMARY KEY (employee_id, skill),
    CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

INSERT INTO employee (employee_id, full_name) VALUES ('X001', 'John Doe');
INSERT INTO employee (employee_id, full_name) VALUES ('X002', 'Jane Smith');
INSERT INTO employee (employee_id, full_name) VALUES ('X003', 'Emily Davis');
INSERT INTO employee (employee_id, full_name) VALUES ('X004', 'Michael Brown');
INSERT INTO employee (employee_id, full_name) VALUES ('X005', 'Alex Johnson');
INSERT INTO employee (employee_id, full_name) VALUES ('X006', 'Chris Lee');

INSERT INTO capability (employee_id, skill) VALUES ('X001', 'File taxes');
INSERT INTO capability (employee_id, skill) VALUES ('X002', 'Meet the press');
INSERT INTO capability (employee_id, skill) VALUES ('X003', 'Organize spring cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X004', 'Do teeth cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X005', 'Reorder inventory');
INSERT INTO capability (employee_id, skill) VALUES ('X001', 'Meet the press');
INSERT INTO capability (employee_id, skill) VALUES ('X001', 'Organize spring cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X001', 'Do teeth cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X001', 'Reorder inventory');
INSERT INTO capability (employee_id, skill) VALUES ('X006', 'File taxes');
INSERT INTO capability (employee_id, skill) VALUES ('X002', 'Do teeth cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X003', 'File taxes');
INSERT INTO capability (employee_id, skill) VALUES ('X003', 'Meet the press');
INSERT INTO capability (employee_id, skill) VALUES ('X003', 'Do teeth cleaning');
INSERT INTO capability (employee_id, skill) VALUES ('X003', 'Reorder inventory');



SELECT employee_id
FROM capability
WHERE skill IN ('Do teeth cleaning', 'Meet the press')
GROUP BY employee_id
HAVING COUNT(skill) = 2;


SELECT e.full_name, superEmp.employee_id
FROM employee e
INNER JOIN
(
    SELECT employee_id
    FROM capability
    WHERE skill IN ('Do teeth cleaning', 'File taxes', 'Meet the press', 'Organize spring cleaning', 'Reorder inventory')
    GROUP BY employee_id
    HAVING COUNT(skill) = 5
) superEmp ON e.employee_id = superEmp.employee_id;