
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external
    CSV files (CRM and ERP source systems).
    It performs the following actions:
      1. Truncates each bronze table before loading (full load).
      2. Uses BULK INSERT to load data from the CSV files into the bronze tables.
      3. Prints the load duration of each table and of the whole batch.
      4. Catches and prints any error raised during the load.

Parameters:
    None.
    This stored procedure does not accept parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

WARNING:
    Running this procedure deletes ALL existing data in the bronze tables
    (TRUNCATE) and reloads it from the source files. Any data not present
    in the CSV files will be permanently lost.
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; --declaring the variables
	BEGIN TRY
-- Full Load process -> Truncate + Insert
		SET @bacth_start_time = GETDATE();
		PRINT '======================================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================================================================';
		PRINT'';
		PRINT '--------------------------------------------------------------------------------------';
		PRINT ' Loading CRM Tables';
		PRINT '--------------------------------------------------------------------------------------';
		PRINT'';

		
		SET @start_time = GETDATE(); --Will show the exact time the process start
		PRINT '>> Truncating Table: bronze.crm_cust_info';
-- Quickly delete all rows from the table, resetting it to an empty state (make the table empty)
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_crm\cust_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> --------------------'
		PRINT'';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_crm\prd_info.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
		PRINT '>> --------------------'
		PRINT '';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_crm\sales_details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
		PRINT '>> --------------------'
		PRINT '';
		
		PRINT '--------------------------------------------------------------------------------------';
		PRINT ' Loading ERP Tables';
		PRINT '--------------------------------------------------------------------------------------';
		PRINT'';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_erp\cust_az12.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
		PRINT '>> --------------------'
		PRINT'';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_erp\loc_a101.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds';
		PRINT '>> --------------------'
		PRINT'';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Personal\sql-data-warehouse-powerbi\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) +' seconds'
		PRINT '>> --------------------'
		PRINT'';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================================='
		PRINT 'Loading Bronze Layer is Completed';
    PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '=========================================================='
	END TRY
	BEGIN CATCH
	PRINT '============================================================='
	PRINT 'ERROR OCURRED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message:' + ERROR_MESSAGE();
	PRINT 'Error NUmber:' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error State:' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '============================================================='
	END CATCH

END
