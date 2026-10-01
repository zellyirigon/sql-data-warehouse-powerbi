# SQL Data Warehouse + Power BI

End-to-end BI project: a SQL data warehouse built with the medallion architecture (bronze, silver, gold) and a star schema, with a Power BI semantic model, DAX measures and a report on top of the gold layer.

## Business context

A manufacturing company runs its operations on an ERP and its sales pipeline on a CRM. Reporting is spread across exports and spreadsheets. This project consolidates both sources into one warehouse so that sales, product and customer reporting comes from a single, trusted model.

## Architecture

| Layer | Purpose | Load type |
|---|---|---|
| Bronze | Raw data from source CSV files, as is | Full load, truncate and insert |
| Silver | Cleaned, standardised and validated data | Full load with transformations |
| Gold | Business ready star schema (facts and dimensions) | Views |
| Power BI | Semantic model, DAX measures, report | Import from gold views |

## Repository structure

```
datasets/          Source CSV files (ERP and CRM)
docs/              Architecture diagram, data flow, data catalogue, naming conventions
scripts/bronze/    DDL and load procedures for the bronze layer
scripts/silver/    DDL and transformation procedures for the silver layer
scripts/gold/      Views for the star schema
tests/             Data quality checks
powerbi/           Power BI project files (.pbip), measures and report screenshots
```

## Tools

SQL Server, SQL (CTEs, window functions, stored procedures), Power BI (Power Query, DAX, semantic model, RLS), Git and GitHub.

## Progress

- [ ] Environment and repository set up
- [ ] Bronze layer
- [ ] Silver layer
- [ ] Gold layer (star schema)
- [ ] Data quality tests
- [ ] Power BI semantic model and DAX measures
- [ ] Power BI report
- [ ] Documentation and final README

## Credits

Warehouse build based on the SQL Data Warehouse project by Data with Baraa. The Power BI layer and the business framing are my own extension.
