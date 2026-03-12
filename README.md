# snowflake-query-monitoring
Snowflake automation project for monitoring failed queries and warehouse credit usage
# Snowflake Query Monitoring Automation

1. This project demonstrates an automated monitoring framework in Snowflake to track:

• Failed queries  
• Warehouse credit usage  
• Top users causing failures  
• Top warehouses consuming credits  

The solution uses Snowflake metadata tables and automated tasks.

---

## Snowflake Metadata Tables Used

SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY  
SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY  

---

## Execution Steps

2. Environment Setup  
3. Metadata Exploration  
4. Failed Query Table Creation  
5. Load Historical Failed Queries  
6. Failed Query Monitoring Automation  
7. Warehouse Credit Monitoring  
8. Warehouse Credit Task Automation  
9. Monitoring Views Creation  
10. Alerting Framework  
11. Alert Automation Task  
12. Validation Queries  

---

## Automation

• Failed query monitoring runs every **1 hour**  
• Warehouse credit monitoring runs every **1 hour**  
• Alerts trigger when abnormal activity occurs

---

## Technologies Used

• Snowflake  
• SQL  
• Snowflake Tasks  
• Snowflake Metadata Tables  
• Monitoring Views
