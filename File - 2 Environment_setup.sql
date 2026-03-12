/* =========================================================
STEP 1 : ENVIRONMENT SETUP

Purpose
Create a dedicated environment where monitoring tables,
tasks and views will be stored.

Database Name : AUTOMATE
Schema Name   : EXP

========================================================= */

-- Use administrative role

USE ROLE ACCOUNTADMIN;

-- Create database

CREATE DATABASE IF NOT EXISTS AUTOMATE;

-- Verify database

SHOW DATABASES LIKE '%AUTOMATE%';

-- Switch database

USE DATABASE AUTOMATE;

-- Create schema

CREATE SCHEMA IF NOT EXISTS EXP;

-- Verify schema

SHOW SCHEMAS IN DATABASE AUTOMATE;