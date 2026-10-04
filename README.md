# 🏗️ Data Warehouse and Analytics Project 

End-to-end BI project: a SQL Server data warehouse built in three layers (bronze, silver, gold), with the ETL written in SQL, and a Power BI semantic model, DAX measures and report on top of the gold layer.

I built this project to go deeper into the technical side of BI: designing a warehouse, writing the ETL and modelling the data so the reports on top of it are fast to build and easy to trust.

The warehouse part follows the SQL Data Warehouse project by Data with Baraa. The Power BI layer is my own extension.

## 🧱 Architecture

The warehouse uses a medallion architecture with three layers:

| Layer | What it holds | Object type | Load method |
|---|---|---|---|
|  **Bronze** | Raw data, exactly as it comes from the source files | Tables | Stored procedure, full load (truncate and insert) |
|  **Silver** | Cleaned and standardised data | Tables | Stored procedure, full load (truncate and insert) |
|  **Gold** | Business-ready star schema | Views | No load, built on top of silver |

The Power BI model connects to the gold layer only, so all the cleaning and business rules live in SQL and the report stays simple.

<!-- ![Architecture](docs/architecture.png) -->

## 📂 Data sources

Two source systems, both provided as CSV files:

- **CRM:** customer information, product information and sales transactions
- **ERP:** extra customer details (birth date, gender), customer locations and product categories

The files are in the `datasets/` folder.

## 🥉 Bronze layer

The bronze layer is a copy of the source files, with no changes. Keeping the raw data untouched means I can always trace a number back to the source, and if something goes wrong in a later layer I can rebuild it without going back to the source systems.

- One table per source file, same columns as the CSV
- Loaded by `bronze.load_bronze` with `TRUNCATE` and `BULK INSERT`
- The procedure logs the duration of each table load and catches errors with `TRY...CATCH`

## 🥈 Silver layer

The silver layer is where the data gets cleaned. Some of the work done here:

- Removing duplicate records and keeping the latest version of each customer
- Trimming extra spaces from text columns
- Standardising codes into readable values (for example, `M` and `F` into `Male` and `Female`)
- Fixing invalid or missing dates and converting them to the right data type
- Recalculating sales values when quantity, price and amount did not match
- Aligning customer and product keys between CRM and ERP so the tables can be joined
- Adding a `dwh_create_date` column to record when each row was loaded

Loaded by `silver.load_silver`, using the same full load pattern as bronze.

## 🥇 Gold layer

The gold layer is a star schema built as views on top of silver:

| Object | Type | Description |
|---|---|---|
| `gold.dim_customers` | Dimension | One row per customer, combining CRM and ERP details |
| `gold.dim_products` | Dimension | One row per current product, with category and subcategory |
| `gold.fact_sales` | Fact | One row per order line, linked to both dimensions |

Each dimension has a surrogate key (`customer_key`, `product_key`) generated in the view. The fact table joins to the dimensions through these keys and not through the source system codes, so the model does not depend on how each source system identifies a customer or product.

<!-- ![Data model](docs/data_model.png) -->

## 📊 Power BI

The Power BI file connects to the three gold views and keeps the same star schema, with a date table added for time intelligence.

**Main measures:**

- Total Sales
- Total Orders
- Total Quantity
- Average Order Value
- Sales YoY %
- Number of Customers

**Report pages:**

- **Sales overview:** headline numbers and sales trend over time
- **Products:** sales by category, subcategory and product
- **Customers:** sales by country, gender and age group

<!-- ![Report](powerbi/report_overview.png) -->

## ✅ Data quality checks

The `tests/` folder has SQL scripts I run after each load to check the data, for example:

- No duplicate or null keys in the dimensions
- No orders with a ship date earlier than the order date
- Sales amount equals quantity multiplied by price
- Every row in `fact_sales` finds a match in both dimensions

## 🏷️ Naming conventions

- `snake_case` for all objects and columns
- Bronze and silver tables keep the source system prefix, for example `crm_cust_info` or `erp_loc_a101`
- Gold objects use `dim_` and `fact_` prefixes
- Surrogate keys end in `_key`
- Technical columns start with `dwh_`

## 🗂️ Repository structure

```
sql-data-warehouse-powerbi/
├── datasets/        source CSV files (CRM and ERP)
├── docs/            architecture diagram, data flow, data model, naming conventions
├── scripts/
│   ├── init_database.sql
│   ├── bronze/      DDL and load procedure for the bronze layer
│   ├── silver/      DDL and load procedure for the silver layer
│   └── gold/        views for the star schema
├── tests/           data quality checks
└── powerbi/         .pbix file and report screenshots
```

## 🛠️ Tools

- SQL Server Express and SSMS
- Power BI Desktop
- Git and GitHub
- draw.io for the diagrams
- Notion for planning the tasks

## ▶️ How to run it

1. Clone the repository.
2. Run `scripts/init_database.sql` to create the database and the bronze, silver and gold schemas.
3. Run the DDL scripts in `scripts/bronze/` and `scripts/silver/` to create the tables.
4. Update the file paths in the bronze load procedure to point at your local `datasets/` folder.
5. Load the layers in order:

```sql
EXEC bronze.load_bronze;
EXEC silver.load_silver;
```

6. Run the scripts in `scripts/gold/` to create the views.
7. Run the checks in `tests/`.
8. Open the `.pbix` file in `powerbi/`, point it at your SQL Server instance and refresh.


## 👋 About me

I'm Zelly, a Finance & Reporting Analyst based in New Zealand, working towards a BI Developer role.

[LinkedIn](https://www.linkedin.com/in/zellyirigon)
