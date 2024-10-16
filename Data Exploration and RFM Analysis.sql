
--CREATING AND USING DATABASE
CREATE DATABASE PROJECT_ONE;
USE PROJECT_ONE;

--INSPECTING TABLE
SELECT * FROM [DBO].[SALES_DATA_SAMPLE];

   --CHECKING UNIQUE VALUES
SELECT DISTINCT STATUS FROM [DBO].[SALES_DATA_SAMPLE]; -- we did this to see the distinct status of orders. 
-- we found out that there are 6 status

SELECT DISTINCT YEAR_ID FROM [DBO].[SALES_DATA_SAMPLE]order by year_id asc;-- to see the timeframe of the dataset. we say that it was from 2003 to 2005.

SELECT DISTINCT PRODUCTLINE FROM [DBO].[SALES_DATA_SAMPLE];-- products in the dataset

SELECT DISTINCT COUNTRY FROM [DBO].[SALES_DATA_SAMPLE];--  the countries we shall be working with
SELECT COUNT (DISTINCT  COUNTRY) FROM [DBO].[SALES_DATA_SAMPLE];-- we used this function to count it ans discovered there are 19 countries.

SELECT COUNT (DISTINCT  CITY) CITY_PER_COUNTRY, COUNTRY  FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY COUNTRY ORDER BY CITY_PER_COUNTRY DESC;
--To check the cities per country where the company`s product are sold.
--the query above shows that USA has the highest number of cities patronizing the company while Switzerland, Philippines, Singapore and Ireland
--have just one cities where the company`s product is sold


SELECT DISTINCT DEALSIZE FROM [DBO].[SALES_DATA_SAMPLE];-- to see the sizes of deals we used the syntax.. there are basically three 

SELECT DISTINCT TERRITORY FROM [DBO].[SALES_DATA_SAMPLE]; --the territories, and discovered there are four.


--ANALYSIS
-- find ou the product that is oodered the mos and find its coresponding revenue
SELECT PRODUCTLINE, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY PRODUCTLINE ORDER BY REVENUE DESC;
-- we can see that classic cars and vintage cars are the most ordered products and the least  bought product is Train.

-- find out the year when the most sales were made and the revenue generated for the year.
SELECT YEAR_ID, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY  FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY YEAR_ID ORDER BY REVENUE DESC;
--2004 has the record of most orders and highest revenue generated. However, the sharp fall in the amount of orders placed and the revenue generated 
--in 2005 is a thing of great concern. since i wasnt sure of the causeof such decrease in revenue for 2005, i had to check if transactions were made for
--thesame number of months as other years.

--This i did using the syntax.
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003;
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2004;
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005;
--This showed that transactions in 2005 were only from january to the 5th month (May). This goes a long way to explain the sharp decrease in revenue in the 
--year 2005.

/*Find out the deal sizethat sells the most and generates the highest income*/
SELECT DEALSIZE,round (SUM(SALES), 2) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY  FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY DEALSIZE ORDER BY REVENUE DESC;


----What is the best month for sales in a specific year? How much was earned that month?

SELECT  MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;

SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2004
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;

SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;

--Generally, the best month for sales is November with products ordered 597 times.
SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE]  GROUP BY  MONTH_ID ORDER BY REVENUE DESC;


--November seems to be the month,what product sells most in November.

SELECT top 2 PRODUCTLINE,  MONTH_ID,  SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003 and MONTH_ID = 11 
GROUP BY  MONTH_ID, PRODUCTLINE ORDER BY REVENUE DESC;



-- It was also fine we know what product sold most in May which happened to be the best month of sales for 2005
SELECT  top 2 PRODUCTLINE, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005 and MONTH_ID = 5 
GROUP BY  MONTH_ID, PRODUCTLINE ORDER BY REVENUE DESC;

--Who is our best customer?

/* Here, we used the RFM Analysis to determine the best customer.*/

/* first, to determine the recency, There is need to know the latest order date (max orderdate). This would help us determine the time difference
between the customers last order and the most recent order date, that is the max date*/

SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE];
/*This means that the last order was placed on 31st May 2005.*/

/*We can now determine the Recency by subtracting the customer`s last orderdate from 
31st May 2005*/

SELECT CUSTOMERNAME,MAX (ORDERDATE) AS LAST_ORDER_DATE ,
(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE, 
DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE)  FROM [DBO].[SALES_DATA_SAMPLE])) AS RECENCY
FROM [DBO].[SALES_DATA_SAMPLE]  GROUP BY CUSTOMERNAME;  

/*first we ordered by frequency to see the most frequent
customer while also trying to figure out the rank of his monetary value.*/

SELECT 
CUSTOMERNAME, SUM(SALES) AS MONETARY_VALUE, RANK () OVER (ORDER BY SUM (SALES) DESC) AS MONETARY_VALUE_RANK,
AVG (SALES) AS AVG_MONETARY_VALUE, MAX (ORDERDATE) AS LAST_ORDER_DATE ,
(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE,
DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) AS RECENCY, COUNT (ORDERNUMBER) AS FREQUENCY 
FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME ORDER BY FREQUENCY DESC;
	

/*Having ordered by frequency, we had to order by recency to see the customers who had not been active for a while.*/

SELECT 
CUSTOMERNAME, SUM(SALES) AS MONETARY_VALUE, RANK () OVER (ORDER BY SUM (SALES) DESC) AS MONETARY_VALUE_RANK,
AVG (SALES) AS AVG_MONETARY_VALUE, MAX (ORDERDATE) AS LAST_ORDER_DATE,
(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE, 
DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) AS RECENCY,  COUNT (ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME ORDER BY RECENCY DESC;

--since I needed the above query for subsequent analysis, i had to make it a subquer thus*/

with rfm as 
(
	select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample])) Recency
	from [dbo].[sales_data_sample]
	group by CUSTOMERNAME
)
select r.*
from rfm r;


--There was need to rank the frequency, recency and monetary value into four groups */

with rfm as 
(
	select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample])) Recency
	from [dbo].[sales_data_sample]
	group by CUSTOMERNAME
)

	select r.*,
		NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary
	from rfm r order by 4 desc ;

	/*four was the highest ranking. That is to say, the lesser the recency, the higher the ranking, the higher 
	the frequency, the higherthe ranking and the higher the monetary value, the higher the ranking */
	
	
	----Another level
--since I needed the above query for subsequent analysis, i had to make it a subquer thus*/
	with rfm as 
(
	select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample])) Recency
	from .[dbo].[sales_data_sample]
	group by CUSTOMERNAME
),
--
 rfm_calc as
(

	select r.*,
		NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary
	from rfm r 
)
select 
	c.* from rfm_calc c;
	
	--Another Level

	--since I needed the above query for subsequent analysis, i had to make it a subquer thus*/

	
WITH RFM AS
	
	(SELECT CUSTOMERNAME, SUM(SALES) MONEYTARYVALUE, AVG(SALES)AVGMONEYTARYVALUE, COUNT(ORDERNUMBER) FREQUENCY,
		
		MAX(ORDERDATE) LAST_ORDER_DATE,(SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE,
		
		DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) RECENCY

		FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME),
--
 RFM_CALC AS

	(SELECT R.*,
		NTILE(4) OVER (ORDER BY RECENCY DESC) RFM_RECENCY,
		NTILE(4) OVER (ORDER BY FREQUENCY) RFM_FREQUENCY,
		NTILE(4) OVER (ORDER BY MONEYTARYVALUE) RFM_MONETARY
	
	FROM RFM R)

SELECT C.*, RFM_RECENCY+ RFM_FREQUENCY+ RFM_MONETARY AS RFM_CELL,
	
	CAST(RFM_RECENCY AS VARCHAR) + CAST(RFM_FREQUENCY AS VARCHAR) + CAST(RFM_MONETARY  AS VARCHAR) RFM_CELL_STRING
	
	INTO #REFPROJECT
	
	FROM RFM_CALC C;
	
	SELECT * FROM #REFPROJECT;


SELECT  CUSTOMERNAME , RFM_RECENCY, RFM_FREQUENCY, RFM_MONETARY,

	CAST(RFM_RECENCY AS VARCHAR) + CAST(RFM_FREQUENCY AS VARCHAR) + CAST(RFM_MONETARY  AS VARCHAR) RFM_CELL_STRING,
	
	CASE 
		WHEN RFM_CELL_STRING IN (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) THEN 'LOST CUSTOMERS'  --lost customers
		
		WHEN RFM_CELL_STRING IN (133, 134, 143, 244, 334, 343, 344, 144,234) THEN  'SLIPPING AWAY, CANNOT LOSE' -- (Big spenders who haven’t purchased lately) slipping away
		
		WHEN RFM_CELL_STRING IN(311, 411, 331,412,421) THEN  'NEW CUSTOMERS'
		
		WHEN RFM_CELL_STRING IN(221,222, 223, 233,232, 322) THEN  'POTENTIAL CHUNERS'
		
		WHEN RFM_CELL_STRING IN (323, 333,321, 422, 332,423, 432) THEN  'ACTIVE' --(Customers who buy often & recently, but at low price points)
		
		WHEN RFM_CELL_STRING IN (433, 434, 443, 444)THEN  'LOYAL'

		END RFM_SEGMENT FROM #REFPROJECT;


-- I needed to know the exact number of new customers,...

	ALTER TABLE #REFPROJECT ADD CUSTOMER_STATUS VARCHAR (100);
	SELECT * FROM #REFPROJECT
	UPDATE #REFPROJECT SET CUSTOMER_STATUS= 
		
		CASE 
		
		WHEN RFM_CELL_STRING IN (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) THEN 'LOST CUSTOMERS'  --lost customers
		
		WHEN RFM_CELL_STRING IN (133, 134, 143, 244, 334, 343, 344, 144,234) THEN  'SLIPPING AWAY, CANNOT LOSE' -- (Big spenders who haven’t purchased lately) slipping away
		
		WHEN RFM_CELL_STRING IN(311, 411, 331,412,421) THEN  'NEW CUSTOMERS'
		
		WHEN RFM_CELL_STRING IN(221,222, 223, 233,232, 322) THEN  'POTENTIAL CHUNERS'
		
		WHEN RFM_CELL_STRING IN (323, 333,321, 422, 332,423, 432) THEN  'ACTIVE' --(Customers who buy often & recently, but at low price points)
		
		WHEN RFM_CELL_STRING IN (433, 434, 443, 444)THEN  'LOYAL'

		END;

		
		SELECT COUNT (CUSTOMER_STATUS) LOST FROM #REFPROJECT WHERE CUSTOMER_STATUS='LOST CUSTOMERS' 
		
		SELECT COUNT (CUSTOMER_STATUS) SLIPPING FROM #REFPROJECT WHERE CUSTOMER_STATUS='SLIPPING AWAY, CANNOT LOSE' 
		
		SELECT COUNT (CUSTOMER_STATUS) NEW  FROM #REFPROJECT WHERE CUSTOMER_STATUS='NEW CUSTOMERS' 
		
		SELECT COUNT (CUSTOMER_STATUS)  POTENTIAL  FROM #REFPROJECT WHERE CUSTOMER_STATUS='POTENTIAL CHUNERS'
		
		SELECT COUNT (CUSTOMER_STATUS)ACTIVE FROM #REFPROJECT WHERE CUSTOMER_STATUS='ACTIVE' 
		
		SELECT COUNT (CUSTOMER_STATUS) LOYAL FROM #REFPROJECT WHERE CUSTOMER_STATUS='LOYAL' 



	SELECT * FROM #REFPROJECT;



--the bottom 5 countries

SELECT TOP 5 COUNTRY, ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY COUNTRY ORDER BY 2 ASC;
	

--what city in Ireland has the least sales

SELECT TOP 5 CITY, ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]

WHERE COUNTRY= 'IRELAND' GROUP BY CITY ORDER BY 2 ASC;


--the overall city with the least sales
SELECT TOP 5 CITY, ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CITY ORDER BY 2 ASC;

-- which country is it located
SELECT  COUNTRY, CITY, ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] WHERE CITY='CHARLEROI'

GROUP BY COUNTRY, CITY ORDER BY REVENUE  ASC; 


--which country has the highest number of sales
SELECT  TOP 5 COUNTRY, COUNT (DISTINCT  CITY) CITIES, ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]

GROUP BY COUNTRY ORDER BY REVENUE  DESC;

--city with the higheat sales in the US
SELECT  TOP 5 CITY,  ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]
	
	WHERE COUNTRY='USA' GROUP BY CITY ORDER BY 2 DESC;
	
	


--the top 5 best products in the US
WITH TTP AS

	(SELECT   COUNTRY,  YEAR_ID, PRODUCTLINE,  ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]
	
	WHERE COUNTRY='USA' GROUP BY COUNTRY, YEAR_ID, PRODUCTLINE) 
	
	SELECT TOP 5 PRODUCTLINE,REVENUE FROM TTP ORDER BY REVENUE DESC;






	


























