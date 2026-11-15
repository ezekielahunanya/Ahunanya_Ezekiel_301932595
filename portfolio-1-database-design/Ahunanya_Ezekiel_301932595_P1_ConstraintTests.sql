-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. patient pk. Expected: pk_patient, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "full_name", "date_of_birth")
VALUES (1001, 'Jordan Lee', '1990-02-03');

-- 2. patient id not null. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "full_name", "date_of_birth")
VALUES (NULL, 'Jordan Lee', '1990-02-03');

-- 3. patient name not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "full_name", "date_of_birth")
VALUES (1002, NULL, '1990-02-03');

-- 4. patient birth not null. Expected: date_of_birth, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "full_name", "date_of_birth")
VALUES (1003, 'Jordan Lee', NULL);

-- 5. visit pk. Expected: pk_visit, SQLSTATE 23505.
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date")
VALUES (2001, 1001, '2025-05-01');

-- 6. visit patient fk. Expected: fk_visit_0, SQLSTATE 23503.
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date")
VALUES (2003, 9001, '2025-05-01');

-- 7. visit id not null. Expected: visit_id, SQLSTATE 23502.
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date")
VALUES (NULL, 1001, '2025-05-01');

-- 8. visit patient not null. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date")
VALUES (2004, NULL, '2025-05-01');

-- 9. visit date not null. Expected: visit_date, SQLSTATE 23502.
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date")
VALUES (2005, 1001, NULL);

-- 10. invoice pk. Expected: pk_invoice, SQLSTATE 23505.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (3001, 2002, '2025-04-15');

-- 11. invoice visit unique. Expected: uq_invoice_0, SQLSTATE 23505.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (3002, 2001, '2025-03-11');

-- 12. invoice visit fk. Expected: fk_invoice_0, SQLSTATE 23503.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (3003, 9002, '2025-05-01');

-- 13. invoice id not null. Expected: invoice_id, SQLSTATE 23502.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (NULL, 2002, '2025-04-15');

-- 14. invoice visit not null. Expected: visit_id, SQLSTATE 23502.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (3004, NULL, '2025-04-15');

-- 15. invoice date not null. Expected: issued_date, SQLSTATE 23502.
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date")
VALUES (3005, 2002, NULL);

-- 16. service code pk. Expected: pk_service_code, SQLSTATE 23505.
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description")
VALUES (4001, 'CPT-0002', 'Follow-up visit');

-- 17. service code unique. Expected: uq_service_code_0, SQLSTATE 23505.
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description")
VALUES (4002, 'CPT-0001', 'Follow-up visit');

-- 18. service id not null. Expected: service_code_id, SQLSTATE 23502.
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description")
VALUES (NULL, 'CPT-0003', 'Consultation');

-- 19. service code not null. Expected: code, SQLSTATE 23502.
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description")
VALUES (4003, NULL, 'Consultation');

-- 20. service description not null. Expected: description, SQLSTATE 23502.
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description")
VALUES (4004, 'CPT-0004', NULL);

-- 21. invoice line pk. Expected: pk_invoice_line, SQLSTATE 23505.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5001, 3001, 4001, 3, 80);

-- 22. line invoice fk. Expected: fk_invoice_line_0, SQLSTATE 23503.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5002, 9003, 4001, 1, 50);

-- 23. line service fk. Expected: fk_invoice_line_1, SQLSTATE 23503.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5003, 3001, 9004, 1, 50);

-- 24. line id not null. Expected: invoice_line_id, SQLSTATE 23502.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (NULL, 3001, 4001, 1, 50);

-- 25. line invoice not null. Expected: invoice_id, SQLSTATE 23502.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5004, NULL, 4001, 1, 50);

-- 26. line service not null. Expected: service_code_id, SQLSTATE 23502.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5005, 3001, NULL, 1, 50);

-- 27. line quantity not null. Expected: quantity, SQLSTATE 23502.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5006, 3001, 4001, NULL, 50);

-- 28. line price not null. Expected: unit_price, SQLSTATE 23502.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5007, 3001, 4001, 1, NULL);

-- 29. line quantity price check. Expected: line_quantity_price_check, SQLSTATE 23514.
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price")
VALUES (5008, 3001, 4001, 0, 50);
