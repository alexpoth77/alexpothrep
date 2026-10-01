# 💳 Banking Database Management & Analysis System

## 📋 Project Overview
This project involves the end-to-end design and implementation of a robust database system for "Delta Bank" to manage VISA credit card operations. It covers the entire data lifecycle: from relational schema design to extracting high-level business insights and integrating with external applications.

## 🛠️ Tech Stack & Tools
* **Database:** SQL Server (T-SQL)
* **Languages:** SQL, Java (JDBC)
* **Concepts:** Entity-Relationship Modeling, Triggers, Stored Procedures, Transactions.

## 📊 Business Insights & SQL Analysis
The project includes advanced T-SQL queries to solve real-world banking problems:
1. **Database Schema:** Creation of tables for Clients, Accounts, Cards, Shops, and Transactions.
2. **Data Analysis (SQL Queries):** * Calculation of monthly turnover and statistics per region.
   * Trend Analysis: Identified customers who increased their total purchases by at least 50% Year-over-Year (YoY analysis).
   * Behavioral Filtering: Isolated high-value clients with total account balances exceeding €10,000.
3. **Automation & Safety:**
   * **Trigger:** Automatic credit limit check before every transaction.
   * **Stored Procedure:** Calculation of tiered commissions based on the day of the month.
4. **Java Applications:**
   * Application for secure card deletion using Transactions (Rollback/Commit).
   * Application for generating monthly account statements.

## 🚀 How to Run
1. Execute `SQLCreate2.sql` to create the database schema.
2. Execute `SQLInserts2.sql` to import the sample/test data.
3. Analytical queries can be found in `sqlSelects.sql`.



