/* =========================================================
STEP 10 : ALERT AUTOMATION

Purpose
Automatically run alert checks every hour.

========================================================= */

CREATE TASK AUTOMATE.EXP.ALERT_MONITOR_TASK

WAREHOUSE = 'ADMIN_SM'

SCHEDULE = '1 HOUR'

AS

CALL AUTOMATE.EXP.CHECK_FAILED_QUERY_ALERT();


ALTER TASK AUTOMATE.EXP.ALERT_MONITOR_TASK RESUME;
