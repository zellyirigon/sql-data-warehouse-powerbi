/*=========================================================================
		QUALITY CHECK - BRONZE LAYER
  =========================================================================*/

-- Check for Nulls or Duplicates in Primary Key (A Primary Key must be unique and not null)
-- Expectation: No Result
SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result

SELECT
cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) --TRIM() Removes leading and trailing spaces from a string

SELECT
cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname) --TRIM() Removes leading and trailing spaces from a string

SELECT
cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr) --TRIM() Removes leading and trailing spaces from a string

-- DATA Standardization & Consistency
-- Check the consistency of values in low cardinality columns
-- In my data warehouse, I aim to store clear and meaningful values rather than using abbreviated terms
-- Expectation: No Result
SELECT
DISTINCT(cst_gndr)
FROM bronze.crm_cust_info

SELECT
DISTINCT(cst_marital_status)
FROM bronze.crm_cust_info

/*=================================================================================================================
		QUALITY CHECK - SILVER LAYER
	Re-run the quality check queries from the bronze layer to verify the quality of data in the silver layer.
  =================================================================================================================*/

-- Check for Nulls or Duplicates in Primary Key (A Primary Key must be unique and not null)
-- Expectation: No Result
SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result

SELECT
cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) --TRIM() Removes leading and trailing spaces from a string

SELECT
cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname) --TRIM() Removes leading and trailing spaces from a string

SELECT
cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr) --TRIM() Removes leading and trailing spaces from a string

-- DATA Standardization & Consistency
-- Check the consistency of values in low cardinality columns
-- In my data warehouse, I aim to store clear and meaningful values rather than using abbreviated terms
-- Expectation: No Result
SELECT
DISTINCT(cst_gndr)
FROM silver.crm_cust_info

SELECT
DISTINCT(cst_marital_status)
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info
