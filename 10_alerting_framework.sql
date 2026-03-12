/* =========================================================
STEP 9 : ALERT DETECTION FRAMEWORK

Purpose
Detect abnormal activity in Snowflake environment.

Example Alert:
If more than 100 failed queries occur within 1 hour.

========================================================= */

CREATE TABLE AUTOMATE.EXP.ALERT_LOGS (

ALERT_TYPE VARCHAR,
ALERT_MESSAGE VARCHAR,
CREATED_AT TIMESTAMP

);


CREATE OR REPLACE PROCEDURE AUTOMATE.EXP.CHECK_FAILED_QUERY_ALERT()

RETURNS STRING

LANGUAGE SQL

AS

$$

INSERT INTO AUTOMATE.EXP.ALERT_LOGS

SELECT

'FAILED_QUERY_ALERT',
'More than 100 failed queries detected within the last hour',
CURRENT_TIMESTAMP()

FROM AUTOMATE.EXP.FAILED_QUERY_LOGS

WHERE START_TIME >= DATEADD(HOUR,-1,CURRENT_TIMESTAMP())

HAVING COUNT(*) > 100;

$$;
