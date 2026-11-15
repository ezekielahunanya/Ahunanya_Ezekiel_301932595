# Outpatient Visit Invoice Ledger — database design

My case study records patient, visit, invoice, service_code, invoice_line.

## Users

- Synthetic clinic billing staff
- Synthetic database students

## Main operations

- Create an invoice and its lines atomically for a visit.
- Join invoices to visits and patients; filter visits by patient and date.
- Aggregate quantity multiplied by unit price by visit and service code.
- Benchmark invoice-line lookup by invoice_id with and without a B-tree index using 50,000 synthetic rows.

## Entities

| Entity | Information stored |
| --- | --- |
| patient | A synthetic patient associated with outpatient visits. |
| visit | A dated outpatient visit for one patient. |
| invoice | The invoice header for a visit; at most one invoice is allowed per visit. |
| service_code | A billable service with a stable code and description. |
| invoice_line | A charged quantity and unit price for one service on an invoice. |

## patient

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| patient_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| date_of_birth | DATE |  | Yes |


## visit

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| visit_id | BIGINT | PK | Yes |
| patient_id | BIGINT | FK | Yes |
| visit_date | DATE |  | Yes |
- patient_id → patient.patient_id

## invoice

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| invoice_id | BIGINT | PK | Yes |
| visit_id | BIGINT | FK, Unique | Yes |
| issued_date | DATE |  | Yes |
- visit_id → visit.visit_id
- Unique key: (visit_id).

## service_code

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| service_code_id | BIGINT | PK | Yes |
| code | TEXT | Unique | Yes |
| description | TEXT |  | Yes |
- Unique key: (code).

## invoice_line

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| invoice_line_id | BIGINT | PK | Yes |
| invoice_id | BIGINT | FK | Yes |
| service_code_id | BIGINT | FK | Yes |
| quantity | INTEGER |  | Yes |
| unit_price | NUMERIC(18,2) |  | Yes |
- invoice_id → invoice.invoice_id
- service_code_id → service_code.service_code_id

## Relationships and business rules

- Every visit references an existing patient.
- Every invoice references an existing visit.
- A visit can have at most one invoice, enforced by a unique constraint on visit_id.
- Invoice-line quantity must be greater than zero and unit_price must be zero or greater.
- Every invoice line references an existing invoice.
- Every invoice line references an existing service code.

## Assumptions

- Each visit has at most one invoice; invoice.visit_id is unique. A concurrent attempt to create a second invoice for the same visit is rejected by that constraint.
- Each invoice line refers to one invoice and one service code. Repeated service codes on an invoice are allowed as separate lines.
- Worked normalization example rooted at invoice_line: decompose a draft relation containing invoice_id, visit_id, patient_id, service_code_id, service_description, quantity, and unit_price into InvoiceLine(invoice_id, service_code_id, quantity, unit_price), Invoice(invoice_id, visit_id, issued_date), Visit(visit_id, patient_id, visit_date), and ServiceCode(service_code_id, code, description). Keep visit_id only in Invoice and patient_id only in Visit; the line references its parents by foreign keys.
- Each entity uses a globally unique, single-column generated identifier as its primary key. Dates and monetary amounts are synthetic; this exercise excludes payments, taxes, and insurance.

