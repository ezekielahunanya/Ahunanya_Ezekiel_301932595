# Outpatient Visit Invoice Ledger — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| invoice_id | invoice_line records (list) |
| --- | --- |
| 3001 | [5001] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| invoice_line.invoice_line_id | invoice_line.invoice_id | invoice_line.service_code_id | invoice.invoice_id | invoice.visit_id | visit.visit_id | visit.patient_id | patient.patient_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5001 | 3001 | 4001 | 3001 | 2001 | 2001 | 1001 | 1001 |

Key: invoice_line_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## invoice_line_example

| invoice_line.invoice_line_id | invoice_line.invoice_id | invoice_line.service_code_id | invoice.invoice_id | invoice.visit_id | visit.visit_id | visit.patient_id | patient.patient_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5001 | 3001 | 4001 | 3001 | 2001 | 2001 | 1001 | 1001 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## patient

| patient_id | full_name | date_of_birth |
| --- | --- | --- |
| 1001 | Avery Morgan | 1980-04-12 |

## visit

| visit_id | patient_id | visit_date |
| --- | --- | --- |
| 2001 | 1001 | 2025-03-10 |
| 2002 | 1001 | 2025-04-15 |

## invoice

| invoice_id | visit_id | issued_date |
| --- | --- | --- |
| 3001 | 2001 | 2025-03-10 |

## service_code

| service_code_id | code | description |
| --- | --- | --- |
| 4001 | CPT-0001 | Office visit |

## invoice_line

| invoice_line_id | invoice_id | service_code_id | quantity | unit_price |
| --- | --- | --- | --- | --- |
| 5001 | 3001 | 4001 | 2 | 125.5 |

## Dependencies

- patient: (patient_id) → full_name, date_of_birth
- visit: (visit_id) → patient_id, visit_date
- invoice: (invoice_id) → visit_id, issued_date
- service_code: (service_code_id) → code, description
- invoice_line: (invoice_line_id) → invoice_id, service_code_id, quantity, unit_price

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
