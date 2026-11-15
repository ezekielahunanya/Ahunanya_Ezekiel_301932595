# Portfolio 1 — Database Design and Modelling

I organised the data into patient, visit, invoice, service_code, invoice_line. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| patient | 1 |
| visit | 2 |
| invoice | 1 |
| service_code | 1 |
| invoice_line | 1 |

The 29 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Ahunanya_Ezekiel_301932595_P1_Design.md)
- [ER diagram](Ahunanya_Ezekiel_301932595_P1_ERDiagram.md)
- [Normalisation](Ahunanya_Ezekiel_301932595_P1_Normalisation.md)
- [Schema](Ahunanya_Ezekiel_301932595_P1_Schema.sql)
- [Sample data](Ahunanya_Ezekiel_301932595_P1_SampleData.sql)
- [Constraint tests](Ahunanya_Ezekiel_301932595_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Ahunanya_Ezekiel_301932595_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

