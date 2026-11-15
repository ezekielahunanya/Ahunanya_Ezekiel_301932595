-- Outpatient Visit Invoice Ledger: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."patient" (
  "patient_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "date_of_birth" date NOT NULL,
  CONSTRAINT "pk_patient" PRIMARY KEY ("patient_id")
);
CREATE TABLE portfolio."visit" (
  "visit_id" bigint NOT NULL,
  "patient_id" bigint NOT NULL,
  "visit_date" date NOT NULL,
  CONSTRAINT "pk_visit" PRIMARY KEY ("visit_id")
);
CREATE TABLE portfolio."invoice" (
  "invoice_id" bigint NOT NULL,
  "visit_id" bigint NOT NULL,
  "issued_date" date NOT NULL,
  CONSTRAINT "pk_invoice" PRIMARY KEY ("invoice_id"),
  CONSTRAINT "uq_invoice_0" UNIQUE ("visit_id")
);
CREATE TABLE portfolio."service_code" (
  "service_code_id" bigint NOT NULL,
  "code" text NOT NULL,
  "description" text NOT NULL,
  CONSTRAINT "pk_service_code" PRIMARY KEY ("service_code_id"),
  CONSTRAINT "uq_service_code_0" UNIQUE ("code")
);
CREATE TABLE portfolio."invoice_line" (
  "invoice_line_id" bigint NOT NULL,
  "invoice_id" bigint NOT NULL,
  "service_code_id" bigint NOT NULL,
  "quantity" bigint NOT NULL,
  "unit_price" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_invoice_line" PRIMARY KEY ("invoice_line_id")
);
ALTER TABLE portfolio."visit" ADD CONSTRAINT "fk_visit_0" FOREIGN KEY ("patient_id") REFERENCES portfolio."patient" ("patient_id");
ALTER TABLE portfolio."invoice" ADD CONSTRAINT "fk_invoice_0" FOREIGN KEY ("visit_id") REFERENCES portfolio."visit" ("visit_id");
ALTER TABLE portfolio."invoice_line" ADD CONSTRAINT "fk_invoice_line_0" FOREIGN KEY ("invoice_id") REFERENCES portfolio."invoice" ("invoice_id");
ALTER TABLE portfolio."invoice_line" ADD CONSTRAINT "fk_invoice_line_1" FOREIGN KEY ("service_code_id") REFERENCES portfolio."service_code" ("service_code_id");
ALTER TABLE portfolio."invoice_line" ADD CONSTRAINT "line_quantity_price_check" CHECK (("quantity" > 0) AND ("unit_price" >= 0));
COMMIT;
