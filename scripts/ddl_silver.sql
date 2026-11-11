/*
==============================================================================
DDL Script: CREATE Silver TABLES
==============================================================================
Purpose:
    Creates the tables in the 'Silver' schema, mirroring the structure of the
    source systems (CRM and ERP) without any modifications.
    Existing tables are dropped and recreated.


WARNING:
    Running this script deletes all data currently stored in the Silver tables.
    Run it only to (re)build the Silver structure, not as part of daily loads.
===============================================================================
*/
USE DataWarehouse;
GO

IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO
--CRM source
CREATE TABLE silver.crm_cust_info(
	cst_id NVARCHAR(50),
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE() -- Metadata: date and time the row was loaded into the warehouse. Filled automatically by SQL Server when the INSERT does not provide a value.
	)

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info(
	prd_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost NVARCHAR(50),
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE() --Metadata
	)

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id NVARCHAR(50),
	sls_order_dt NVARCHAR(50),
	sls_ship_dt NVARCHAR(50),
	sls_due_dt NVARCHAR(50),
	sls_sales NVARCHAR(50),
	sls_quantity NVARCHAR(50),
	sls_price NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE() --Metadata
)
-- ERP source
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12(
	cid NVARCHAR(50),
	bdate NVARCHAR(50),
	gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE() --Metadata
)

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE() --Metadata
)

IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE() --Metadata
)

/*================================================================================
METADATA COLUMNS
================================================================================
Extra columns added by data engineers that do not originate from the source data.

create_date: The record's load timestamp, indicating when the record was inserted into the Silver table.
update_date: The record's last update timestamp, indicating when the record was last modified in the Silver table.
source_system: The source system the record originated from (e.g., CRM, ERP).
file_location: The file path of the source CSV file from which the record was loaded.

================================================================================
*/
