/* =========================================================
STEP 8 : MONITORING ANALYTICS VIEWS

Purpose
The monitoring tables created earlier store raw operational
data collected from Snowflake metadata tables.

To make monitoring easier for administrators and analysts,
we create analytical views on top of these tables.

These views provide insights such as:

• Failed queries in the last 24 hours
• Top users generating failed queries
• Warehouse credit usage history
• Top warehouses consuming Snowflake credits

Using views ensures that reporting can be done easily
without directly querying raw monitoring tables.

========================================================= */



/* =========================================================
STEP 8A : VIEW FOR FAILED QUERIES IN LAST 24 HOURS
Purpose:
Quickly identify queries that failed in the last 24 hours.
========================================================= */

CREATE OR REPLACE SECURE VIEW AUTOMATE.EXP.VW_FAILED_QUERY_LOGS_24HR

AS

SELECT *
FROM AUTOMATE.EXP.FAILED_QUERY_LOGS
WHERE START_TIME >= DATEADD(HOUR,-24,CURRENT_TIMESTAMP())
ORDER BY START_TIME DESC;



/* =========================================================
STEP 8B : VIEW FOR TOP USERS CAUSING FAILED QUERIES
Purpose:
Identify users generating the most query failures.
Useful for troubleshooting bad SQL workloads.
========================================================= */

CREATE OR REPLACE SECURE VIEW AUTOMATE.EXP.VW_TOP_USERS_FAILED_QUERIES

AS

SELECT
USER_NAME,
COUNT(*) AS FAILED_QUERY_COUNT
FROM AUTOMATE.EXP.FAILED_QUERY_LOGS
GROUP BY USER_NAME
ORDER BY FAILED_QUERY_COUNT DESC;



/* =========================================================
STEP 8C : VIEW FOR WAREHOUSE CREDIT USAGE HISTORY
Purpose:
Track historical warehouse credit consumption.
========================================================= */

CREATE OR REPLACE SECURE VIEW AUTOMATE.EXP.VW_WAREHOUSE_CREDIT_USAGE

AS

SELECT *
FROM AUTOMATE.EXP.WAREHOUSE_USAGE_LOGS
ORDER BY START_TIME DESC;



/* =========================================================
STEP 8D : VIEW FOR TOP WAREHOUSES CONSUMING CREDITS
Purpose:
Identify warehouses that consume the highest credits.
Helps control Snowflake cost optimization.
========================================================= */

CREATE OR REPLACE SECURE VIEW AUTOMATE.EXP.VW_TOP_WAREHOUSE_CREDIT_USAGE

AS

SELECT
WAREHOUSE_NAME,
SUM(CREDITS_USED) AS TOTAL_CREDITS_USED
FROM AUTOMATE.EXP.WAREHOUSE_USAGE_LOGS
GROUP BY WAREHOUSE_NAME
ORDER BY TOTAL_CREDITS_USED DESC;



/* =========================================================
STEP 8E : QUICK VALIDATION OF MONITORING VIEWS
Purpose:
Verify that monitoring views are returning results.
========================================================= */

SELECT COUNT(*) FROM AUTOMATE.EXP.VW_FAILED_QUERY_LOGS_24HR;

SELECT COUNT(*) FROM AUTOMATE.EXP.VW_TOP_USERS_FAILED_QUERIES;

SELECT COUNT(*) FROM AUTOMATE.EXP.VW_WAREHOUSE_CREDIT_USAGE;

SELECT COUNT(*) FROM AUTOMATE.EXP.VW_TOP_WAREHOUSE_CREDIT_USAGE;