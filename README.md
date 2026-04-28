# SQL Analytics Portfolio

This repository contains my SQL learning progression and project-based analytics work using MySQL.

I built this portfolio to document both core SQL fundamentals and applied projects that reflect how SQL is used in real-world data cleaning, analysis, and problem solving.

The goal is to show practical analytical work rather than only tutorial exercises.

---

## What This Repository Includes

### SQL Foundations

These files cover the core concepts I worked through while building strong SQL fundamentals, including:

- SELECT
- WHERE
- GROUP BY
- HAVING
- LIMIT and Aliases
- JOINS
- UNIONS
- String Functions
- CASE Statements
- Subqueries
- Window Functions
- CTEs
- Temporary Tables
- Stored Procedures
- Triggers and Events

These are organized to show progression from basic querying to more advanced analytical workflows.

---

## Featured Projects

### Project 1: Data Cleaning in MySQL

This project focuses on cleaning and preparing a real-world layoffs dataset for analysis.

The raw dataset contained duplicate records, inconsistent formatting, missing values, text-based date fields, and improperly structured null values that would cause inaccurate analysis if left unresolved.

In this project, I worked through:

- creating staging tables to preserve the raw source data
- identifying and removing duplicate rows using `ROW_NUMBER()` and CTEs
- standardizing inconsistent values across columns such as industry and country
- trimming whitespace and fixing formatting inconsistencies
- converting text-based date values into proper SQL `DATE` format
- handling blank values and replacing incorrect NULL representations
- using self-joins to fill missing values based on matching company records
- removing rows with insufficient analytical value
- dropping temporary helper columns after cleaning was complete

This project reflects how I approach messy real-world datasets before any meaningful analysis begins.

Files included:

- Project1-DataCleaning.sql
- layoffs.json

---

### Project 2: Exploratory Data Analysis in MySQL

This project builds directly on the cleaned layoffs dataset from Project 1 and focuses on extracting business insights through SQL-based exploratory analysis.

Before analysis, I completed additional datatype corrections to ensure accurate aggregations and calculations, including converting text fields like `total_laid_off` and `percentage_laid_off` into proper numeric formats.

The analysis focused on understanding layoff trends across companies, industries, countries, funding stages, and time periods.

In this project, I worked through:

- validating and converting numeric columns for accurate aggregation
- identifying companies with 100% workforce reductions
- analyzing total layoffs by company, industry, country, and funding stage
- examining layoffs by year to understand macro-level trends
- calculating rolling monthly layoff totals using window functions
- identifying the time period where layoffs accelerated most heavily
- ranking the top companies by layoffs each year using CTEs and `DENSE_RANK()`
- building year-over-year comparisons of layoff concentration across organizations

Key findings included major layoff spikes during 2022 and early 2023, significantly higher layoff volume in the United States compared to other countries, and large post-IPO companies accounting for the highest total layoffs.

This project demonstrates how cleaned operational data can be transformed into meaningful business insights using SQL.

Files included:

- Project 2 - ExploratoryDataAnalysis.sql

---

## Tools Used

- MySQL
- SQL
- Git
- GitHub

---

## Purpose

I wanted this repository to reflect practical analytical thinking and problem solving through SQL.

The focus is on using SQL to improve data quality, support analysis, and build strong foundations for data-driven decision making.
