# Outpatient Visit Invoice Ledger — SQL queries

## 1. Show related invoice, visit, patient records (up to 20).

```sql
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
```

| invoice_invoice_id | invoice_issued_date | visit_visit_id | visit_visit_date | patient_patient_id | patient_full_name |
| --- | --- | --- | --- | --- | --- |
| 3001 | 2025-03-10 | 2001 | 2025-03-10 | 1001 | Avery Morgan |

## 2. Find visit records where patient_id matches 1001 (up to 20).

```sql
SELECT * FROM portfolio."visit"
WHERE "patient_id" IS NOT DISTINCT FROM 1001
ORDER BY "visit_id"
LIMIT 20;
```

| visit_id | patient_id | visit_date |
| --- | --- | --- |
| 2001 | 1001 | 2025-03-10 |
| 2002 | 1001 | 2025-04-15 |

## 3. Count invoice_line records for each invoice_id (up to 20 groups).

```sql
SELECT "invoice_id", count(*) AS record_count
FROM portfolio."invoice_line"
GROUP BY "invoice_id"
ORDER BY record_count DESC, "invoice_id" NULLS LAST
LIMIT 20;
```

| invoice_id | record_count |
| --- | --- |
| 3001 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.038 | 2.529, 2.018, 2.038 | Sort → Seq Scan | 274 |
| After index | 0.253 | 0.284, 0.253, 0.253 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.038 ms to 0.253 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.496..2.499 rows=50 loops=1)
  Seq Scan on invoice_line (actual time=0.015..2.456 rows=50 loops=1)
Planning Time: 0.312 ms
Execution Time: 2.529 ms
```

### Before index, run 2

```text
Sort (actual time=1.984..1.987 rows=50 loops=1)
  Seq Scan on invoice_line (actual time=0.016..1.943 rows=50 loops=1)
Planning Time: 0.365 ms
Execution Time: 2.018 ms
```

### Before index, run 3

```text
Sort (actual time=2.002..2.005 rows=50 loops=1)
  Seq Scan on invoice_line (actual time=0.016..1.962 rows=50 loops=1)
Planning Time: 0.318 ms
Execution Time: 2.038 ms
```

### After index, run 1

```text
Sort (actual time=0.226..0.229 rows=50 loops=1)
  Bitmap Heap Scan on invoice_line (actual time=0.03..0.172 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=50 loops=1)
Planning Time: 0.477 ms
Execution Time: 0.284 ms
```

### After index, run 2

```text
Sort (actual time=0.198..0.2 rows=50 loops=1)
  Bitmap Heap Scan on invoice_line (actual time=0.029..0.159 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=50 loops=1)
Planning Time: 0.493 ms
Execution Time: 0.253 ms
```

### After index, run 3

```text
Sort (actual time=0.197..0.2 rows=50 loops=1)
  Bitmap Heap Scan on invoice_line (actual time=0.029..0.158 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=50 loops=1)
Planning Time: 0.477 ms
Execution Time: 0.253 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Ahunanya_Ezekiel_301932595_P2_Queries.sql, then Ahunanya_Ezekiel_301932595_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Ahunanya_Ezekiel_301932595_P2_QueryResults.png) · [Index comparison](screenshots/Ahunanya_Ezekiel_301932595_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

