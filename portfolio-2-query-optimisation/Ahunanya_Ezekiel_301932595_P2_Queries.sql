-- Show related invoice, visit, patient records (up to 20).
SELECT t0."invoice_id" AS "invoice_invoice_id",
       t0."issued_date" AS "invoice_issued_date",
       t1."visit_id" AS "visit_visit_id",
       t1."visit_date" AS "visit_visit_date",
       t2."patient_id" AS "patient_patient_id",
       t2."full_name" AS "patient_full_name"
FROM portfolio."invoice" t0
JOIN portfolio."visit" t1 ON t0."visit_id" = t1."visit_id"
JOIN portfolio."patient" t2 ON t1."patient_id" = t2."patient_id"
ORDER BY t0."invoice_id", t1."visit_id", t2."patient_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."invoice_id" AS "invoice_invoice_id",
       t0."issued_date" AS "invoice_issued_date",
       t1."visit_id" AS "visit_visit_id",
       t1."visit_date" AS "visit_visit_date",
       t2."patient_id" AS "patient_patient_id",
       t2."full_name" AS "patient_full_name"
FROM portfolio."invoice" t0
JOIN portfolio."visit" t1 ON t0."visit_id" = t1."visit_id"
JOIN portfolio."patient" t2 ON t1."patient_id" = t2."patient_id"
ORDER BY t0."invoice_id", t1."visit_id", t2."patient_id"
LIMIT 20;

-- Find visit records where patient_id matches 1001 (up to 20).
SELECT * FROM portfolio."visit"
WHERE "patient_id" IS NOT DISTINCT FROM 1001
ORDER BY "visit_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."visit"
WHERE "patient_id" IS NOT DISTINCT FROM 1001
ORDER BY "visit_id"
LIMIT 20;

-- Count invoice_line records for each invoice_id (up to 20 groups).
SELECT "invoice_id", count(*) AS record_count
FROM portfolio."invoice_line"
GROUP BY "invoice_id"
ORDER BY record_count DESC, "invoice_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "invoice_id", count(*) AS record_count
FROM portfolio."invoice_line"
GROUP BY "invoice_id"
ORDER BY record_count DESC, "invoice_id" NULLS LAST
LIMIT 20;
