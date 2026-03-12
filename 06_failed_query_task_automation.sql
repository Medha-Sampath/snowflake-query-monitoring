/* =========================================================
STEP 5 : AUTOMATING FAILED QUERY MONITORING

Purpose
Until now we manually loaded failed queries from the
Snowflake metadata table.

To make the monitoring system production-ready,
we automate this process using a Snowflake TASK.

The task will run every 1 hour and automatically
capture newly failed queries from:

SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY

The MERGE logic ensures duplicate records are not inserted.

========================================================= */


-- =========================================================
-- STEP 5A : CREATE TASK FOR FAILED QUERY MONITORING
-- =========================================================

CREATE OR REPLACE TASK AUTOMATE.EXP.TASK_FAILED_QUERY_LOGS

WAREHOUSE = 'COM_US_OPS_ADMIN_SM'

SCHEDULE = '1 HOUR'

AS

MERGE INTO AUTOMATE.EXP.FAILED_QUERY_LOGS AS TARGET

USING

(
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
WHERE EXECUTION_STATUS LIKE '%FAIL%'
)

SOURCE

ON TARGET.QUERY_ID = SOURCE.QUERY_ID

WHEN NOT MATCHED THEN

INSERT (
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

VALUES (
SOURCE.QUERY_ID,
SOURCE.QUERY_TEXT,
SOURCE.DATABASE_NAME,
SOURCE.SCHEMA_NAME,
SOURCE.WAREHOUSE_NAME,
SOURCE.EXECUTION_STATUS,
SOURCE.ERROR_CODE,
SOURCE.ERROR_MESSAGE,
SOURCE.USER_NAME,
SOURCE.START_TIME,
SOURCE.END_TIME
);



-- =========================================================
-- STEP 5B : RESUME THE TASK
-- Snowflake tasks are created in SUSPENDED state by default
-- =========================================================

ALTER TASK AUTOMATE.EXP.TASK_FAILED_QUERY_LOGS RESUME;



-- =========================================================
-- STEP 5C : VERIFY TASK CREATION
-- =========================================================

SHOW TASKS LIKE '%TASK_FAILED_QUERY_LOGS%';



-- =========================================================
-- STEP 5D : VERIFY DATA EXISTS IN MONITORING TABLE
-- =========================================================

SELECT COUNT(*)
FROM AUTOMATE.EXP.FAILED_QUERY_LOGS;



-- =========================================================
-- STEP 5E : INTENTIONALLY GENERATE FAILED QUERIES
-- Purpose : test if monitoring system captures failures
-- =========================================================

-- invalid table

SELECT * FROM AUTOMATE.EXP.FAILED_QUERY_LOGS_TESTER;

-- syntax error

SELEC * FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY;

-- invalid column

SELECT INVALID_COLUMN
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY;



-- =========================================================
-- STEP 5F : VERIFY TASK EXECUTION HISTORY
-- =========================================================

SELECT *

FROM TABLE(

AUTOMATE.INFORMATION_SCHEMA.TASK_HISTORY(
TASK_NAME => 'TASK_FAILED_QUERY_LOGS'
)

)

ORDER BY SCHEDULED_TIME DESC;
