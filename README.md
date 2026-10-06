# 📊 T-SQL & Data Warehousing Portfolio

Welcome to my SQL Projects repository! This portfolio showcases end-to-end relational database querying, multidimensional data modeling, and business intelligence analytics using **T-SQL (SQL Server)**.

---

## 🛠️ Key Technical Skills

- **Data Warehousing & Dimensional Modeling:** Star Schema design, Fact & Dimension table architecture, Foreign Key/Primary Key relationships.
- **Advanced OLAP & Aggregations:** Multidimensional analytics using `CUBE`, `ROLLUP`, and `GROUPING SETS` to generate efficient subtotals and grand totals.
- **Advanced Querying & Logic:** Multi-table `JOIN` operations, conditional logic (`CASE WHEN`), complex aggregation with `HAVING`, dynamic discount modeling, and relational division.

---

## 📂 Featured Projects & SQL Snippets

### 1. 🏨 Travel & Accommodation Data Warehouse (`OLAP 06071.sql`)
* **Focus:** Dimensional Modeling & Data Warehouse Design.
* **Overview:** Designed a Star Schema database (`FACT_SEJOURS`) to analyze hotel stays, bookings, and revenue across dimensions including client demographics, destination, travel company, and dates.

```sql
-- Star Schema Fact Table Definition with Foreign Keys
CREATE TABLE FACT_SEJOURS (
    sejour_id INT PRIMARY KEY,
    client_id INT FOREIGN KEY REFERENCES DIM_CLIENT(client_id),
    destination_id INT FOREIGN KEY REFERENCES DIM_DESTINATION(destination_id),
    compagnie_id INT FOREIGN KEY REFERENCES DIM_COMPAGNIE(compagnie_id),
    date_id INT FOREIGN KEY REFERENCES DIM_DATE(date_id),
    montant DECIMAL(10,2),
    nbr_jours INT
);
```
---

### 2. 📊 Advanced Multidimensional Aggregations (`OLAP 2.sql` & `OLAP 26073.sql`)
* **Focus:** Business Intelligence Analytics & T-SQL OLAP Extensions.
* **Overview:** Utilized modern OLAP operators (`CUBE`, `ROLLUP`, `GROUPING SETS`) to perform complex multi-level summarizations across sales, products, and suppliers in a single query pass.

```sql
-- Generating all 2^N subtotals and grand totals using CUBE
SELECT 
    nocli, 
    noprod, 
    nofour, 
    SUM(montant) AS total_montant
FROM ventes
GROUP BY CUBE (nocli, noprod, nofour);

-- Custom Grouping Sets for targeted aggregation slices
SELECT 
    category, 
    year, 
    SUM(amount) AS total_sales
FROM PURCHASES p
JOIN PRODUCT pr ON p.product_id = pr.product_id
JOIN TIME t ON p.time_id = t.time_id
GROUP BY GROUPING SETS ((category, year), (category), (year), ());
---
```

### 3. 🛍️ E-Commerce & Retail Operations Analytics (`SQL project.sql`)
* **Focus:** Complex Querying, Business Rules, & Customer Behavior Analysis.
* **Overview:** Solved real-world retail analytics challenges using conditional logic, subqueries, and advanced relational filters on order, customer, and product data.

```sql
-- Dynamic Discount Allocation using CASE WHEN
SELECT 
    od.ORDER_int AS [Order Number],
    CASE 
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 0 AND 2000 THEN '0%'
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 2001 AND 10000 THEN '5%'
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 10001 AND 40000 THEN '10%'
        WHEN SUM(od.UNIT_PRICE * od.QUANTITY) BETWEEN 40001 AND 80000 THEN '15%'
        ELSE '20%'
    END AS [New Discount Rate]
FROM ORDER_DETAILS od
WHERE od.ORDER_int BETWEEN 10998 AND 11003
GROUP BY od.ORDER_int;

-- Customer Behavioral Analysis with Conditional HAVING
SELECT C.CUSTOMER_CODE
FROM CUSTOMERS C
LEFT JOIN ORDERS O ON C.CUSTOMER_CODE = O.CUSTOMER_CODE
LEFT JOIN ORDER_DETAILS OD ON O.ORDER_int = OD.ORDER_int
LEFT JOIN PRODUCTS P ON OD.PRODUCT_REF = P.PRODUCT_REF
LEFT JOIN CATEGORIES CAT ON P.CATEGORY_CODE = CAT.CATEGORY_CODE
WHERE C.CITY = 'Berlin'
GROUP BY C.CUSTOMER_CODE
HAVING COUNT(CASE WHEN CAT.CATEGORY_NAME = 'Desserts' THEN 1 END) <= 1;
```
### 3.⚡ How to Use
Clone the repository:
```sql
git clone [https://github.com/NourElHoudaDerbel/SQL-Projects.git](https://github.com/NourElHoudaDerbel/SQL-Projects.git)
```
