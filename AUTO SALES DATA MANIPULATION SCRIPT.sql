SELECT *
FROM `auto sales data`;
    
-- RENAME RELEVANT COLUMN NAMES
ALTER TABLE `auto sales data`
CHANGE `ORDERNUMBER` Order_no VARCHAR(20),
CHANGE QUANTITYORDERED Quantity_ordered INT,
CHANGE PRICEEACH `Price` DOUBLE,
CHANGE ORDERLINENUMBER Order_line_number VARCHAR(20),
CHANGE SALES Sales DOUBLE,
CHANGE DAYS_SINCE_LASTORDER Days_since_lastorder INT,
CHANGE `STATUS` `Status` VARCHAR(20),
CHANGE PRODUCTLINE Product_line VARCHAR(30),
CHANGE PRODUCTCODE `Product_code` VARCHAR(45),
CHANGE CUSTOMERNAME Customer_name VARCHAR(45),
CHANGE CITY City VARCHAR(45),
CHANGE COUNTRY Country VARCHAR(45),
CHANGE CONTACTLASTNAME `last_name` VARCHAR(50),
CHANGE CONTACTFIRSTNAME `First_name` VARCHAR(50),
CHANGE DEALSIZE Deal_size VARCHAR(50);

-- REARRANGE THE DATE FORMAT
UPDATE `auto sales data`
SET ORDERDATE = STR_TO_DATE(ORDERDATE, '%d/%m/%Y');

-- CHANGE THE DATE DATATYPE
ALTER TABLE `auto sales data`
CHANGE ORDERDATE Order_date DATE;

-- CHECK FOR DUPLICATES 
SELECT COUNT(*)
FROM `auto sales data`
WHERE (Order_no, Quantity_ordered) IN (
	SELECT Order_no, Days_since_lastorder
    FROM `auto sales data`
    GROUP BY Order_no, Days_since_lastorder
    HAVING COUNT(*) > 1
);  

-- TASKS 
-- TOP SELLING PRODUCT LINE 
SELECT Product_line, SUM(Sales) AS Revenue 
FROM `auto sales data`
GROUP BY Product_line
ORDER BY Revenue DESC;

-- TOP 8 CUSTOMERS BY REVENUE
SELECT Customer_name, SUM(Sales) AS Revenue, SUM(Quantity_ordered) AS Quantity
FROM `auto sales data`
GROUP BY Customer_name
ORDER BY Revenue DESC
LIMIT 8;

-- CUSTOMER BY DEMAND 
SELECT Customer_name, SUM(Sales) AS Revenue, SUM(Quantity_ordered) AS Quantity
FROM `auto sales data`
GROUP BY Customer_name
ORDER BY Quantity DESC
LIMIT 8;

-- retrieve data for visualization 
SELECT (Customer_name) AS Company, Order_no, (Quantity_ordered) AS Quantity, Sales, `Status`, `Product_line`, City, Country, Deal_size, Order_date 
FROM `auto sales data`;

