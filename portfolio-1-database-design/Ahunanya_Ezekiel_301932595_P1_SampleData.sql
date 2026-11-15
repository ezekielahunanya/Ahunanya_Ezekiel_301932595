-- Fictional sample records for Outpatient Visit Invoice Ledger.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."patient" ("patient_id", "full_name", "date_of_birth") VALUES (1001, 'Avery Morgan', '1980-04-12');
INSERT INTO portfolio."service_code" ("service_code_id", "code", "description") VALUES (4001, 'CPT-0001', 'Office visit');
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date") VALUES (2001, 1001, '2025-03-10');
INSERT INTO portfolio."visit" ("visit_id", "patient_id", "visit_date") VALUES (2002, 1001, '2025-04-15');
INSERT INTO portfolio."invoice" ("invoice_id", "visit_id", "issued_date") VALUES (3001, 2001, '2025-03-10');
INSERT INTO portfolio."invoice_line" ("invoice_line_id", "invoice_id", "service_code_id", "quantity", "unit_price") VALUES (5001, 3001, 4001, 2, 125.5);
COMMIT;
