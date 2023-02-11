# SQLite commands <!-- omit from toc -->
[SQLite docs](https://www.tutorialspoint.com/sqlite/index.htm)  
The foundation of any typical database consists of implementing four functions:  
Create, Read, Update and Delete (aka CRUD).  

In SQL this means:  
- INSERT for Creating  
- SELECT for Reading  
- UPDATE for Updating  
- DELETE for Deleting  

&nbsp;
## Contents <!-- omit from toc -->
---
- [Basic commands](#basic-commands)
- [SQLite data types](#sqlite-data-types)
- [SQLite logical operators](#sqlite-logical-operators)
- [Some examples](#some-examples)
  - [- The `.show` command:](#--the-show-command)
  - [- Formatting table:](#--formatting-table)
  - [- Creating database:](#--creating-database)
  - [- Creating tables:](#--creating-tables)
  - [- Inserting into tables:](#--inserting-into-tables)
  - [- Selecting from tables:](#--selecting-from-tables)
  - [- Updating tables:](#--updating-tables)
  - [- Delete from table:](#--delete-from-table)
  - [- Selecting based on condition:](#--selecting-based-on-condition)
  - [- Order tables by condition:](#--order-tables-by-condition)
  - [- Limit number of rows:](#--limit-number-of-rows)
  - [- Joining tables:](#--joining-tables)

&nbsp;
## Basic commands
---
|        Syntax         | Description                                                                                               |
| :-------------------: | --------------------------------------------------------------------------------------------------------- |
|   .backup ?DB? FILE   | Backup DB (default "main") to FILE                                                                        |
|     .bail ON\|OFF     | Stop after hitting an error. Default OFF                                                                  |
|      .databases       | List names and files of attached databases                                                                |
|     .dump ?TABLE?     | Dump the database in an SQL text format. If TABLE specified, only dump tables matching LIKE pattern TABLE |
|     .echo ON\|OFF     | Turn command echo on or off                                                                               |
|         .exit         | Exit SQLite prompt                                                                                        |
|   .explain ON\|OFF    | Turn output mode suitable for EXPLAIN on or off. With no args, it turns EXPLAIN on                        |
|  .header(s) ON\|OFF   | Turn display of headers on or off                                                                         |
|         .help         | Show this message                                                                                         |
|  .import FILE TABLE   | Import data from FILE into TABLE                                                                          |
|   .indices ?TABLE?    | Show names of all indices. If TABLE specified, only show indices for tables matching LIKE pattern TABLE   |
|  .load FILE ?ENTRY?   | Load an extension library                                                                                 |
|    .log FILE\|off     | Turn logging on or off. FILE can be stderr/stdout                                                         |
|      .mode MODE       | Set output mode where MODE is one of −                                                                    |
|                       | csv − Comma-separated values                                                                              |
|                       | column − Left-aligned columns.                                                                            |
|                       | html − HTML \<table\> code                                                                                |
|                       | insert − SQL insert statements for TABLE                                                                  |
|                       | line − One value per line                                                                                 |
|                       | list − Values delimited by .separator string                                                              |
|                       | tabs − Tab-separated values                                                                               |
|                       | tcl − TCL list elements                                                                                   |
|   .nullvalue STRING   | Print STRING in place of NULL values                                                                      |
|   .output FILENAME    | Send output to FILENAME                                                                                   |
|    .output stdout     | Send output to the screen                                                                                 |
|   .print STRING...    | Print literal STRING                                                                                      |
| .prompt MAIN CONTINUE | Replace the standard prompts                                                                              |
|         .quit         | Exit SQLite prompt                                                                                        |
|    .read FILENAME     | Execute SQL in FILENAME                                                                                   |
|    .schema ?TABLE?    | Show the CREATE statements. If TABLE specified, only show tables matching LIKE pattern TABLE              |
|   .separator STRING   | Change separator used by output mode and .import                                                          |
|         .show         | Show the current values for various settings                                                              |
|    .stats ON\|OFF     | Turn stats on or off                                                                                      |
|   .tables ?PATTERN?   | List names of tables matching a LIKE pattern                                                              |
|      .timeout MS      | Try opening locked tables for MS milliseconds                                                             |
|    .width NUM NUM     | Set column widths for "column" mode                                                                       |
|    .timer ON\|OFF     | Turn the CPU timer measurement on or off                                                                  |
  
More commands:  
[SQLite commands](https://www.codecademy.com/article/sql-commands)  
[SQLite cheatsheet](https://www.sqlitetutorial.net/sqlite-cheat-sheet/)  

&nbsp;
## SQLite data types
---
| Type    | Description                                                                                   |
| ------- | --------------------------------------------------------------------------------------------- |
| NULL    | The value is a null value                                                                     |
| INTEGER | The value is a signed integer, meaning a round number that can be negative                    |
| REAL    | The value is a floating point value, meaning a number allowing fractions (like 3.14159265359) |
| TEXT    | The value is a text string, stored using the database encoding                                |
| BLOB    | he value is a blob of data, stored exactly as it was input                                    |

&nbsp;
## SQLite logical operators
---
| Operator | Description                                                                                                                                             |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AND      | The AND operator allows the existence of multiple conditions in an SQL statement's WHERE clause.                                                        |
| BETWEEN  | The BETWEEN operator is used to search for values that are within a set of values, given the minimum value and the maximum value.                       |
| EXISTS   | The EXISTS operator is used to search for the presence of a row in a specified table that meets certain criteria.                                       |
| IN       | The IN operator is used to compare a value to a list of literal values that have been specified.                                                        |
| NOT IN   | The negation of IN operator which is used to compare a value to a list of literal values that have been specified.                                      |
| LIKE     | The LIKE operator is used to compare a value to similar values using wildcard operators.                                                                |
| GLOB     | The GLOB operator is used to compare a value to similar values using wildcard operators. Also, GLOB is case sensitive, unlike LIKE.                     |
| NOT      | The NOT operator reverses the meaning of the logical operator with which it is used. Eg. NOT EXISTS, NOT BETWEEN, NOT IN, etc. This is negate operator. |
| OR       | The OR operator is used to combine multiple conditions in an SQL statement's WHERE clause.                                                              |
| IS NULL  | The NULL operator is used to compare a value with a NULL value.                                                                                         |
| IS       | The IS operator work like =                                                                                                                             |
| IS NOT   | The IS operator work like !=                                                                                                                            |
| \|\|     | Adds two different strings and make new one.                                                                                                            |
| UNIQUE   | The UNIQUE operator searches every row of a specified table for uniqueness (no duplicates).                                                             |

&nbsp;
## Some examples
---
### - The `.show` command:
```sqlite3
sqlite>.show
     echo: off
  explain: off
  headers: off
     mode: column
nullvalue: ""
   output: stdout
separator: "|"
    width:
sqlite>
```
---
### - Formatting table:
```sqlite3
sqlite>.header on
sqlite>.mode column
sqlite>.timer on
sqlite>
```
---
### - Creating database:
```sqlite3
sqlite3 favorite_movies.db
```
---
### - Creating tables:
```sqlite3
CREATE TABLE movies (title TEXT, year INTEGER, rating INTEGER);
```
---
### - Inserting into tables:
```sqlite3
INSERT INTO table_name( column1, column2, ..., columnN ) 
VALUES ( value1, value2, ..., valueN );
```
---
### - Selecting from tables:
```sqlite3
SELECT column1, column2, ..., columnN 
FROM table_name;
```
or SELECT * to select all columns  

---
### - Updating tables:
```sqlite3
UPDATE table_name
SET column1 = value1, column2 = value2, ..., columnN = valueN
WHERE [condition];
```
---
### - Delete from table:
```sqlite3
DELETE FROM table_name
WHERE [condition];
```
---
### - Selecting based on condition:
```sqlite3
SELECT column1, column2, ..., columnN
FROM table_name 
WHERE [condition];
```
---
### - Order tables by condition:
```sqlite3
SELECT column1, column2, ..., columnN
FROM table_name 
[WHERE condition]
ORDER BY column1, column2, ..., columnN [ASC | DESC];
```
---
### - Limit number of rows:  
Use `OFFSET` to set the starting point.
```sqlite3
SELECT column1, column2, ..., columnN 
FROM table_name 
LIMIT [no of rows]
[OFFSET [no of rows]];
```
---
### - Joining tables:
```sqlite3
SELECT * 
FROM <table_1> 
<type-of-join> <table_2>
ON <table-1>.<column-name> = <table-2>.<column-name>
```
---
