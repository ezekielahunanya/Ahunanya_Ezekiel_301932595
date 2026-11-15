# Outpatient Visit Invoice Ledger — ER diagram

```mermaid
erDiagram
    direction LR
    patient {
        bigint patient_id PK
        text full_name
        date date_of_birth
    }
    visit {
        bigint visit_id PK
        bigint patient_id FK
        date visit_date
    }
    invoice {
        bigint invoice_id PK
        bigint visit_id FK,UK
        date issued_date
    }
    service_code {
        bigint service_code_id PK
        text code UK
        text description
    }
    invoice_line {
        bigint invoice_line_id PK
        bigint invoice_id FK
        bigint service_code_id FK
        integer quantity
        numeric unit_price
    }
    patient ||--o{ visit : "patient_id"
    visit ||--o| invoice : "visit_id"
    invoice ||--o{ invoice_line : "invoice_id"
    service_code ||--o{ invoice_line : "service_code_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Ahunanya_Ezekiel_301932595_ERDiagram.png)
