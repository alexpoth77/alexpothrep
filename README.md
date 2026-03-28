
# Banking Data Management System (Credit Card Analysis)

## Project Overview
Αυτό το project αφορά τον σχεδιασμό και την υλοποίηση ενός συστήματος διαχείρισης πιστωτικών καρτών για μια τράπεζα. Καλύπτει όλο τον κύκλο ζωής των δεδομένων: από τον σχεδιασμό του σχήματος (Schema Design) έως την εξαγωγή επιχειρηματικών συμπερασμάτων (Business Insights) μέσω SQL.

## Τεχνολογίες & Εργαλεία
* Database:SQL Server (T-SQL)
* Languages: SQL, Java (JDBC)
* Concepts: Entity-Relationship Modeling, Triggers, Stored Procedures, Transactions.

##  Τι περιλαμβάνει η εργασία
1. Database Schema: Δημιουργία πινάκων για Πελάτες, Λογαριασμούς, Κάρτες, Καταστήματα και Συναλλαγές.
2. Data Analysis (SQL Queries): Υπολογισμός μηνιαίων τζίρων και στατιστικών ανά περιοχή.
   Εντοπισμός πελατών με μεγάλη αύξηση αγορών.
  ιλτράρισμα πελατών βάσει σύνθετων κριτηρίων (π.χ. υπόλοιπα > 10.000€).
3. Automation & Safety:
   Trigger: Αυτόματος έλεγχος πιστωτικού ορίου πριν από κάθε συναλλαγή.
  Stored Procedure:Υπολογισμός κλιμακωτών προμηθειών ανάλογα με την ημέρα του μήνα.
4. Java Applications:
   Εφαρμογή για ασφαλή διαγραφή κάρτας με χρήση Transactions (Rollback/Commit).
   Εφαρμογή έκδοσης μηνιαίου Statement κινήσεων.

## Πώς να το τρέξετε
1. Εκτελέστε το `Schema_Creation.sql` για τη δημιουργία της βάσης.
2. Εκτελέστε το `Sample_Data.sql` για την εισαγωγή δεδομένων δοκιμής.
3. Τα ερωτήματα ανάλυσης βρίσκονται στο `Business_Insights.sql`.
