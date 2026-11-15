# Ezekiel Ahunanya — MIT 8103

Student ID: 301932595

Outpatient Visit Invoice Ledger. Entities: Patient, Visit (FK to Patient), Invoice (FK to Visit), ServiceCode, and InvoiceLine (FKs to Invoice and ServiceCode). Query billed totals per visit by service. In one transaction, create an invoice and its lines. Require one invoice per visit with UNIQUE(visit_id); MongoDB invoice events snapshot the invoice, visit, and patient.

The portfolio is being generated. Completed stages will appear in the commit history.
