/* =========================================================
STEP 7 : AUTOMATING WAREHOUSE CREDIT MONITORING

Purpose
The warehouse credit monitoring table stores historical
credit consumption data from Snowflake metadata.

To keep this monitoring table updated automatically,
we create a Snowflake TASK that runs every 1 hour and
loads new credit usage records from:

SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY

The MERGE logic ensures duplicate warehouse records
are not inserted again.

========================================================= */


-- =========================================================
-- STEP 7A : CREATE TASK FOR WAREHOUSE CREDIT MONITORING
-- =========================================================

CREATE OR REPLACE TASK AUTOMATE.EXP.TASK_WAREHOUSE_LOGS

WAREHOUSE = 'ADMIN_SM'

SCHEDULE = '1 HOUR'

AS

MERGE INTO AUTOMATE.EXP.WAREHOUSE_LOGS AS TARGET

USING
(
SELECT
WAREHOUSE_NAME,
CREDITS_USED_COMPUTE,
CREDITS_USED_CLOUD_SERVICES,
CREDITS_USED,
START_TIME,
END_TIME
FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
)

AS SOURCE

ON TARGET.WAREHOUSE_NAME = SOURCE.WAREHOUSE_NAME
AND TARGET.START_TIME = SOURCE.START_TIME

WHEN NOT MATCHED THEN

INSERT (
WAREHOUSE_NAME,
CREDITS_USED_COMPUTE,
CREDITS_USED_CLOUD_SERVICES,
CREDITS_USED,
START_TIME,
END_TIME
)

VALUES (
SOURCE.WAREHOUSE_NAME,
SOURCE.CREDITS_USED_COMPUTE,
SOURCE.CREDITS_USED_CLOUD_SERVICES,
SOURCE.CREDITS_USED,
SOURCE.START_TIME,
SOURCE.END_TIME
);



-- =========================================================
-- STEP 7B : RESUME THE TASK
-- Snowflake tasks are created in SUSPENDED state by default
-- =========================================================

ALTER TASK AUTOMATE.EXP.TASK_WAREHOUSE_LOGS RESUME;



-- =========================================================
-- STEP 7C : VERIFY TASK CREATION
-- =========================================================

SHOW TASKS LIKE '%TASK_WAREHOUSE_LOGS%';



-- =========================================================
-- STEP 7D : VERIFY TASK EXECUTION HISTORY
-- =========================================================

SELECT *

FROM TABLE (
AUTOMATE.INFORMATION_SCHEMA.TASK_HISTORY(
TASK_NAME => 'TASK_WAREHOUSE_LOGS'
)
)

ORDER BY SCHEDULED_TIME DESC;