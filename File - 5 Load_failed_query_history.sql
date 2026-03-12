/* =========================================================
STEP 4 : LOAD HISTORICAL FAILED QUERIES

Purpose
Load previously executed failed queries from Snowflake
metadata tables into our monitoring table.

========================================================= */

INSERT INTO AUTOMATE.EXP.FAILED_QUERY_LOGS (
QUERY_ID,
QUERY_TEXT,
DATABASE_NAME,
SCHEMA_NAME,
WAREHOUSE_NAME,
EXECUTION_STATUS,
ERROR_CODE,
ERROR_MESSAGE,
USER_NAME,
START_TIME,
END_TIME
)

SELECT

QUERY_ID,
QUERY_TEXT,
DATABASE_NAME,
SCHEMA_NAME,
WAREHOUSE_NAME,
EXECUTION_STATUS,
ERROR_CODE,
ERROR_MESSAGE,
USER_NAME,
START_TIME,
END_TIME

FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY

WHERE EXECUTION_STATUS LIKE '%FAIL%';