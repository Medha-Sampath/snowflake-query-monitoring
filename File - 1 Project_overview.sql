/* =========================================================
PROJECT : Snowflake Automated Monitoring System
AUTHOR  : Medha

PURPOSE
This project builds an automated monitoring system inside
Snowflake to track:

1. Failed queries
2. Warehouse credit usage
3. Top users causing failures
4. Top warehouses consuming credits
5. Alert generation for abnormal activity

The system uses:

• Snowflake ACCOUNT_USAGE views
• Automated Tasks
• MERGE logic for incremental loading
• Monitoring Views
• Alert detection framework

This project demonstrates how Snowflake administrators
can monitor platform usage and detect operational issues.

========================================================= */

/* =========================================================
SNOWFLAKE METADATA TABLES USED

QUERY HISTORY
SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY

WAREHOUSE CREDIT USAGE
SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY

These system views provide operational insights into
Snowflake workloads and credit consumption.

========================================================= */