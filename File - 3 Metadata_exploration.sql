/* =========================================================
STEP 2 : SNOWFLAKE METADATA EXPLORATION

Purpose
Snowflake stores operational metadata inside the
SNOWFLAKE.ACCOUNT_USAGE schema.

These tables provide information about:

• Query execution history
• Warehouse credit consumption
• User activity
• Task execution history

In this project we use two metadata tables:

1. SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
2. SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY

These tables allow us to monitor Snowflake workloads.

========================================================= */


-- Explore query execution history metadata

SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
LIMIT 10;



/* Columns of interest for failed query monitoring:

QUERY_ID
QUERY_TEXT
DATABASE_NAME
SCHEMA_NAME
WAREHOUSE_NAME
EXECUTION_STATUS
ERROR_CODE
ERROR_MESSAGE
USER_NAME
START_TIME
END_TIME

These columns allow us to track failed queries
executed in the Snowflake environment.

*/


-- Count total queries recorded

SELECT COUNT(*)
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY;



/* =========================================================
WAREHOUSE CREDIT USAGE METADATA
========================================================= */

-- Explore warehouse credit usage metadata

SELECT *
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
LIMIT 10;


/* Columns used for warehouse monitoring:

WAREHOUSE_NAME
CREDITS_USED_COMPUTE
CREDITS_USED_CLOUD_SERVICES
CREDITS_USED
START_TIME
END_TIME

These columns help identify warehouses consuming
high Snowflake credits.

*/


-- Count warehouse metering records

SELECT COUNT(*)
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY;