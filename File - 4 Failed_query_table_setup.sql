/* =========================================================
STEP 3 : FAILED QUERY MONITORING SETUP

Purpose
Snowflake stores all query execution metadata in the
SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY view.

This step creates a logging table to store failed queries
for monitoring and analysis.

========================================================= */

CREATE OR REPLACE TABLE AUTOMATE.EXP.FAILED_QUERY_LOGS (

QUERY_ID VARCHAR,
QUERY_TEXT VARCHAR,
DATABASE_NAME VARCHAR,
SCHEMA_NAME VARCHAR,
WAREHOUSE_NAME VARCHAR,
EXECUTION_STATUS VARCHAR,
ERROR_CODE VARCHAR,
ERROR_MESSAGE VARCHAR,
USER_NAME VARCHAR,
START_TIME TIMESTAMP,
END_TIME TIMESTAMP

);

-- Verify table creation

SELECT COUNT(*)
FROM AUTOMATE.EXP.FAILED_QUERY_LOGS;