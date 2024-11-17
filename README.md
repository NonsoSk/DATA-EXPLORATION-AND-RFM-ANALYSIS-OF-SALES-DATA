# DATA-EXPLORATION-AND-RFM-ANALYSIS-OF-SALES-DATA

![RFM 3](https://github.com/user-attachments/assets/0e3fe4e0-9c2d-4ada-9a62-66e7e9f53f8e)

This is an SQL portfolio project with the primary aim of data exploration. It explores the dataset to find out the best customers and best products through making an RFM Analysis. 

# Introduction
By analyzing the sales dataset, we will answer the following questions:

1) find out the product with the highest order and its corresponding revenue generated
2)	Which year had the most sales?
3)	What deal size generates the highest revenue?
4)	What is the best moth for sales in each of the year and what month generally recorded the highest sales?
5)	Find who the best customers are.
 - Top three customers that generate the highest revenue for the company
 - Top three (3) customers with the highest orders
 - Top 3 most active / Most recent customers
6)	Find out how many customers have been lost and how many have been gained.
7)	What countries generate the least revenue?
8)	What countries generate the least revenue?

However, in the course of this analysis, I was able to ask deeper questions outside the five (5) questions above, the aim was to get detailed insights without losing sight of our primary questions. So moving further, we would see how these questions were answered and how each at specific times played its role.
My goal is that by the completion of this project, we must have had a detailed understanding of the sales dataset, the revenue generated each year and by each country, the products that are mostly in demand, the status of our customers (How many have been lost, how many are on the verge of shunning, how many have been gained and how many are active and loyal) so as to know how to optimize our products and services.


The result of our analysis could provide valuable insights for policymakers, business owners and researchers to devise strategies for business management and production of products that are in high demand.

## I demonstrated the following skills in this project
- Aggregate functions
- Conditional statements (top n)
- Critical thinking
- Group by and order by
- Joins
- Problem solving
- Select distinct, from
- String functions
- Subquery and CTE
- Window functions (over, rank,)


# Data sourcing

I obtained the data by downloading the csv file from Kaggle. The dataset “Sales_data_sample” was downloaded and imported into my database “PROJECT”, which I created using the syntax below:
```
CREATE DATABASE PROJECT_ONE;
```

The data is a sample data of a public available datasets on sales, which just one table, 25 columns and 2,823 rows.
To view this dataset use:
```
SELECT * FROM [DBO].[SALES_DATA_SAMPLE];
```
# Data Transformation and cleaning

The dataset I worked with was a clean dataset as the essence of this project was just data exploration and nothing more. I used an already cleaned dataset and so there was no need for further cleaning.
However, for a better knowledge of the data I was working with, I went further to check for unique values.
## Checking Unique Values

- To see the different Status of orders, we used:

```
SELECT DISTINCT STATUS FROM [DBO].[SALES_DATA_SAMPLE]; 
```
Which gave us the result:
|STATUS|
|------|
|Resolved|
|On Hold|
|Canceled|
|Shipped|
|Disputed|
|In Process|

That means there are 6 different statuses in the delivery service of products.

- to see the time-frame of the dataset. 


```
SELECT DISTINCT YEAR_ID FROM [DBO].[SALES_DATA_SAMPLE] ORDER BY YEAR_ID ASC;
```

|YEAR_ID|
|------|
|2003|
|2004|
|2005|

Thus, sales were made from 2003 to 2005.

- To see the products in the dataset, we used
```
SELECT DISTINCT PRODUCTLINE FROM [DBO].[SALES_DATA_SAMPLE];
```
|PRODUCTLINE|
|------|
|Trains|
|Motorcycles|
|Ships|
|Trucks and Buses|
|Vintage cars|
|Classic Cars|
|Plains|

From the above, we can see that there are 7 different products which we shall be working with.
- To see the different countries in the dataset, we used the syntax:
```
SELECT DISTINCT COUNTRY FROM [DBO].[SALES_DATA_SAMPLE];
``` 
We counted them

```
SELECT COUNT (DISTINCT COUNTRY) FROM [DBO].[SALES_DATA_SAMPLE];
```
To find out that there are 19 countries all together.

- To check the cities per country where the company`s product are sold.

```
SELECT COUNT (DISTINCT  CITY) CITY_PER_COUNTRY, COUNTRY  FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY COUNTRY ORDER BY CITY_PER_COUNTRY DESC;
```


- The query above shows that USA has the highest number of cities patronizing the company while Switzerland, Philippines, Singapore and Ireland
- have just one cities where the company`s product is sold

- Territory was another column we needed to be study well and so the know the territories our analysis would cover, we used:

```
SELECT DISTINCT TERRITORY FROM [DBO].[SALES_DATA_SAMPLE];
```
|TERRITORY|
|------|
|EMEA|
|APAC|
|Japan|
|NA|

The orders were delivered in different sizes and so it was important to know the different sizes. So, we used:
```
SELECT DISTINCT DEALSIZE FROM [DBO].[SALES_DATA_SAMPLE];
```
|DEALSIZE|
|------|
|Large|
|Medium|
|Small|

Having understood to dataset, we proceeded to analyzing it.

# Analysis and Problem Solving.

I analyzed the data step by step according to the questions and aim of my analysis. 

In the first analysis, we set out to answer the question:

** find out the product with the highest order and its corresponding revenue generated**
```
SELECT PRODUCTLINE, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY PRODUCTLINE ORDER BY REVENUE DESC;
```
The result of the above query shows that “Classic Cars” are the highest ordered products with 967 orders and generating a grand income of  3,919,615.6607666. 

We can also notice that there is so much difference in revenue and orders of the “Classic Cars” and “Vintage Cars” which came as the second most ordered product with a total order of 607 and a total revenue of 1,903,150.83557129.
This goes a long way to tell us that “Classic Cars” are in very high demands than all other products.
From our query, we also discovered that the least demanded products are Trains which has only 77 orders out of 2,823 total orders made in the company and with a revenue of 226,243.468994141 which is quite a poor addition to the company`s revenue.

We went further to answer the second question of our analysis which is:
Which year had the most sales?
To see the year that had the highest sales. We used the syntax below:
```
SELECT YEAR_ID, SUM(SALES) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY YEAR_ID ORDER BY REVENUE DESC;
```
From the above, we can see that 2004 had the highest sales and generated the highest revenue
However, the sharp fall in the number of orders placed and the revenue generated in 2005 is a thing of great concern. 
Since I wasn’t sure of the cause of such decrease in revenue for 2005, I had to check if transactions were made for the same number of months as other years.

This I did using the syntax.
```
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003;
```
```
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2004;
```
```
SELECT DISTINCT MONTH_ID FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005;
```
This showed that While for other years, the transactions were from the first month (January) to the last month,  sales for the year 2005 were only from the 1st (January) to the 5th month (May). This goes a long way to explain the sharp decrease in revenue in the year 2005.

Moving further, we attempted the next question:

What deal size generates the highest revenue?

As seen earlier, there are three different dealsizes, the small, medium and large. The syntax below will show which of the three generates the highest revenue.

```
SELECT DEALSIZE, round (SUM(SALES), 2) AS REVENUE, COUNT(ORDERNUMBER) AS FREQUENCY FROM [DBO].[SALES_DATA_SAMPLE]
GROUP BY DEALSIZE ORDER BY REVENUE DESC;
```
|DEALSIZE|REVENUE|FREQUENCY|
|------|-------------------|-------------|
|Medium|6087432.24|1384|
|Small	|2643077.35|1282|
|Large|1302119.26|157|

From what we have above, we can see that the size of deals that have the highest sales and generate the highest revenue and middle-sized deals. While the deals that generate the lowest revenue are large-sized deals.
The next question was to find the best moth for sales in each of the years and what month generally recorded the highest sales?
We had to find the best month for each of the years.
For the year 2003:

```
SELECT  MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;

```
For the year 2003, the best month for sales is the 11th month (November)

For the year 2004, we used:

```
SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2004
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;
```
The best month for sales in 2004 remained November

For year 2005, the 5th month stands as the best month of sales.

```
SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005
GROUP BY  MONTH_ID ORDER BY REVENUE DESC;
```
However, the best month for sales generally, is November with products ordered 597 times as can been seen from the query below:

```
SELECT   MONTH_ID, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE]  GROUP BY  MONTH_ID ORDER BY REVENUE DESC;
```
Since November has stood out as the month with the highest sales, it would be proper to check the product that is being greatly ordered in the month of November


```
SELECT top 2 PRODUCTLINE,  MONTH_ID,  SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2003 and MONTH_ID = 11 
GROUP BY  MONTH_ID, PRODUCTLINE ORDER BY REVENUE DESC;
```
From the above, we can see that the highest sold product is “Classic Cars”.



It would be great knowledge also to know what product sold most in May 2005 which happened to be the best month of sales for 2005

```
SELECT  TOP 2 PRODUCTLINE, SUM(SALES) AS REVENUE,COUNT(ORDERNUMBER) AS FREQUENCY
FROM [DBO].[SALES_DATA_SAMPLE] WHERE YEAR_ID= 2005 and MONTH_ID = 5 
GROUP BY  MONTH_ID, PRODUCTLINE ORDER BY REVENUE DESC;
```

Classic cars was still the most sold product in May 2005 with 41 products sold out and a total revenue of 184,385.109558105 

Having found out all about  the company`s  products and services, I went further to analyzing customer information.

The first question I answered first is:

Who is our best customer?

Here we used the RFM Analysis to determine the 

I set out to find the last order date of the different customers. The essence was to help me know the last time each customer bought a product. 

Before this, there was need to know the latest order date (max orderdate - that is the last date a product was bought). This was to help me determine the RECENCY by subtracting every customer`s last orderdate from the max date so as to know how long every customer has stayed without patronizing or buying a product. 
The query below was used to know the last orderdate:

```
SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE];
```
This means that the last order was placed on 31st May 2005.

We can now determine the Recency by subtracting the customer`s last orderdate from the max orderdate which is 31st May 2005

```
SELECT CUSTOMERNAME,MAX (ORDERDATE) AS LAST_ORDER_DATE ,
(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE, 
DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE)  FROM [DBO].[SALES_DATA_SAMPLE])) AS RECENCY
FROM [DBO].[SALES_DATA_SAMPLE]  GROUP BY CUSTOMERNAME;  
```
I went further to tabulate the customers details alongside their Frequency (How often they buy products) and their Recency (The last time they bought a product)
First, I ordered by frequency to see the most frequent customer while also trying to figure out the rank of his monetary value.
I did this with the query below:

```
SELECT 
CUSTOMERNAME, SUM(SALES) AS MONETARY_VALUE, RANK () OVER (ORDER BY SUM (SALES) DESC) AS MONETARY_VALUE_RANK,
AVG (SALES) AS AVG_MONETARY_VALUE, MAX (ORDERDATE) AS LAST_ORDER_DATE ,
(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE,
DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) AS RECENCY, COUNT (ORDERNUMBER) AS FREQUENCY 
FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME ORDER BY FREQUENCY DESC;
```	

From the above, we can see that the customer “Euro Shopping Channel” generates the highest revenue, as his  monetary_value ranks as 1st , and  has bought products 259 times from the company.
So in the order of frequency (That is the customer who has placed the most order), the customer with the highest frequency “Euro Shopping Channel” stands as the best customer.

Having ordered by frequency, I had to order by recency to see the customers level of activeness.

```
SELECT 

CUSTOMERNAME, SUM(SALES) AS MONETARY_VALUE, RANK () OVER (ORDER BY SUM (SALES) DESC) AS 

MONETARY_VALUE_RANK, AVG (SALES) AS AVG_MONETARY_VALUE, MAX (ORDERDATE) AS 

LAST_ORDER_DATE,

(SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE,  

DATEDIFF (DD, MAX (ORDERDATE), (SELECT MAX (ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) AS 

RECENCY,  COUNT (ORDERNUMBER) AS FREQUENCY

FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME ORDER BY RECENCY DESC;
```

We can see that two customers : Euro Shopping Channel and La Rochelle Gifts, are the most recent customers we have, they have the least frequency (0) which means that the last time they bought a product was the exact date the company sold out a product last. 
In order of Recency, we can say they (Euro Shopping Channel and La Rochelle Gifts) are the most recent customers

Still on the customer analysis, I went further to answer the following questions:
- Top three customers that generate the highest revenue for the company?
- Top three (3) customers with the highest orders
- Top 3 most active / Most recent customers

**Top three customers that generate the highest revenue for the company**

```
WITH RFM AS

	(SELECT CUSTOMERNAME, ROUND (SUM(SALES), 0) MONETARYVALUE,COUNT(ORDERNUMBER) FREQUENCY, 

	DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]))          
              RECENCY
	
	FROM [DBO].[SALES_DATA_SAMPLE] 
	
	GROUP BY CUSTOMERNAME)

	SELECT TOP 3 R.* FROM RFM R ORDER BY MONETARYVALUE DESC ;
```

We can see that the customers who have added more to the finance of the company are:  Euro Shopping Channel, Mini Gifts Distributors Ltd. And Australian Collectors, Co. As can be seen 


|CUSTOMERNAME|MONEYTARYVALUE|FREQUENCY|RECENCY|
|------|-------------------|-------------|-------|
|Euro Shopping Channel|912294|259|0|
|Mini Gifts Distributors Ltd|654858|180|2|
|Australian Collectors, Co|200995|55|183|

With this, we proceeded to the next question:

**Top three (3) customers with the highest orders**

```
WITH RFM AS

	(SELECT CUSTOMERNAME, ROUND (SUM(SALES), 0) MONETARYVALUE,COUNT(ORDERNUMBER) FREQUENCY, 

	DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]))          
              RECENCY
	
	FROM [DBO].[SALES_DATA_SAMPLE] 
	
	GROUP BY CUSTOMERNAME)

	SELECT TOP 3 R.* FROM RFM R ORDER BY FREQUENCY DESC ;
```

This gave us the result:


|CUSTOMERNAME|MONEYTARYVALUE|FREQUENCY|RECENCY|
|------|-------------------|-------------|-------|
|Euro Shopping Channel|912294|259|0|
|Mini Gifts Distributors Ltd.|654858|180|2|
|Australian Collectors, Co.|200995|55|183|

We can see from the above that Euro Shopping Channel has made the highest orders. 
			
My concern now was the next question:

**Top 7 most active / Most recent customers**

```
WITH RFM AS

	(SELECT CUSTOMERNAME, ROUND (SUM(SALES), 0) MONETARYVALUE,COUNT(ORDERNUMBER) FREQUENCY, 

	DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]))          
              RECENCY
	
	FROM [DBO].[SALES_DATA_SAMPLE] 
	
	GROUP BY CUSTOMERNAME)

	SELECT TOP 7 R.* FROM RFM R ORDER BY RECENCY ASC ;

```

|CUSTOMERNAME|MONEYTARYVALUE|FREQUENCY|RECENCY|
|------|-------------------|-------------|-------|
|La Rochelle Gifts|180125|53|0|
|Euro Shopping Channel|912294|259|0|
|Diecast Classics Inc.|122138|31|1|
|Petit Auto|74973|25|1|
|Mini Gifts Distributors Ltd.|654858|180|2|
|Souveniers And Things Co.|151571|46|2|
|Salzburg Collectables|149799|40|14|

From all the analysis so far, it is clear that the customer “Euro Shopping Channel” is really outstanding.
They are our most active and loyal customers.

Having found out some of our best customers, there was need to check the different status of our customers. So this would take us to the next question:

Find out how many customers have been lost and how many have been gained.

For deeper analysis, I grouped the customers into 6 categories:
- Lost (Lost customers)
- Sleeping away, cannot lose ((Big spenders who haven’t purchased lately/ slipping away)
- New Customers (Customers who have just began buying products)
- Potential churners ( customers who are not consistent in their orders and who have stayed for quite some time without purchase)
- Active (Customers who buy often & recently, but at low price points)
- loyal (Customers who buy often and recently and add generate very high revenue)


```
WITH RFM AS

	
	(SELECT CUSTOMERNAME, SUM(SALES) MONEYTARYVALUE, AVG(SALES)AVGMONEYTARYVALUE, COUNT(ORDERNUMBER) FREQUENCY,
		
		MAX(ORDERDATE) LAST_ORDER_DATE,(SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE]) AS MAX_ORDER_DATE,
		
		DATEDIFF(DD, MAX(ORDERDATE), (SELECT MAX(ORDERDATE) FROM [DBO].[SALES_DATA_SAMPLE])) RECENCY

		FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CUSTOMERNAME),


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
```
```
	SELECT * FROM #REFPROJECT;

```

```
SELECT CUSTOMERNAME , RFM_RECENCY, RFM_FREQUENCY, RFM_MONETARY,

	CAST(RFM_RECENCY AS VARCHAR) + CAST(RFM_FREQUENCY AS VARCHAR) + CAST(RFM_MONETARY  AS VARCHAR) RFM_CELL_STRING,
	
	CASE 
		WHEN RFM_CELL_STRING IN (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) THEN 'LOST CUSTOMERS' 
		
		WHEN RFM_CELL_STRING IN (133, 134, 143, 244, 334, 343, 344, 144,234) THEN  'SLIPPING AEAY, CANNOT LOSE' 
		
		WHEN RFM_CELL_STRING IN(311, 411, 331,412,421) THEN  'NEW CUSTOMERS'
		
		WHEN RFM_CELL_STRING IN(221,222, 223, 233,232, 322) THEN  'POTENTIAL CHUNERS'
		
		WHEN RFM_CELL_STRING IN (323, 333,321, 422, 332,423, 432) THEN  'ACTIVE' --
		
		WHEN RFM_CELL_STRING IN (433, 434, 443, 444)THEN  'LOYAL'

		END RFM_SEGMENT FROM #REFPROJECT;

```
Having grouped the customers into different matching categories, we went further to count them:

```
ALTER TABLE #REFPROJECT ADD CUSTOMER_STATUS VARCHAR (100);
```
```
SELECT * FROM #REFPROJECT
```

```
UPDATE #REFPROJECT SET CUSTOMER_STATUS= 
		
	       CASE 
		
		WHEN RFM_CELL_STRING IN (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) THEN 'LOST CUSTOMERS'  
		
		WHEN RFM_CELL_STRING IN (133, 134, 143, 244, 334, 343, 344, 144,234) THEN  'SLIPPING AWAY, CANNOT LOSE' 
		
		WHEN RFM_CELL_STRING IN(311, 411, 331,412,421) THEN  'NEW CUSTOMERS'
		
		WHEN RFM_CELL_STRING IN(221,222, 223, 233,232, 322) THEN  'POTENTIAL CHUNERS'
		
		WHEN RFM_CELL_STRING IN (323, 333,321, 422, 332,423, 432) THEN  'ACTIVE' 
		
		WHEN RFM_CELL_STRING IN (433, 434, 443, 444)THEN  'LOYAL'

		END;
```

After updating the table, I went further to use the aggregate function; count.
```		
		SELECT COUNT (CUSTOMER_STATUS) LOST FROM #REFPROJECT WHERE CUSTOMER_STATUS='LOST CUSTOMERS'
```
```		
		SELECT COUNT (CUSTOMER_STATUS) SLIPPING FROM #REFPROJECT WHERE CUSTOMER_STATUS='SLIPPING AWAY, CANNOT LOSE' 
```		
```
  SELECT COUNT (CUSTOMER_STATUS) NEW  FROM #REFPROJECT WHERE CUSTOMER_STATUS='NEW CUSTOMERS' 
```
```		
		SELECT COUNT (CUSTOMER_STATUS)  POTENTIAL  FROM #REFPROJECT WHERE CUSTOMER_STATUS='POTENTIAL CHUNERS'
```
```		
		SELECT COUNT (CUSTOMER_STATUS)ACTIVE FROM #REFPROJECT WHERE CUSTOMER_STATUS='ACTIVE' 
```
```		
		SELECT COUNT (CUSTOMER_STATUS) LOYAL FROM #REFPROJECT WHERE CUSTOMER_STATUS='LOYAL' 
```
The result of our query shows that:
- We lost 21 of our customers. A really large number that calls for concern
- 18 of our big customers have not been frequent like before
- We had an addition of only 8 new customers
- 17 of our customers  are slipping off, that is, they are on the verge of leaving.
- We still have 14 active customers and
- 14 loyal customers.

This means that we have only 28 reliable customers out of the 92 in our record, which is really poor.

We moved to analyzing by  country

Below is a query to show the 5 bottom countries. That is to say, the countries that generate the least revenue

```
SELECT TOP 5 COUNTRY, SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY COUNTRY ORDER BY 2 ASC;
```

|COUNTRY|REVENUE|
|-------|-------|
|Ireland|57756.4|
|Philippines|94015.7|
|Belgium|108412.6|
|Switzerland|117713.6|
|Japan|188167.8|

From the table above, we can see that Ireland has the least revenue contribution.
Moving down, it would be fine to find out the city in Ireland that has the least sales
		
what city in Ireland has the least sales?

```
SELECT TOP 5 CITY, SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]

WHERE COUNTRY= 'IRELAND' GROUP BY CITY ORDER BY 2 ASC;
```
The above query confirms that Dublin in Ireland returns the least revenue as can be seen in the table below:

|COUNTRY|REVENUE|
|------|------|
|Dublin|57756.4|


Let us then check for the cities that returns the least revenue generally

the overall cities with the least sales

```
SELECT TOP 5 CITY, SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY CITY ORDER BY 2 ASC;
```
The result of our query is:

|COUNTRY|REVENUE|
|-------|--------|
|Charleroi|33440.1|
|Munich|34993.9|
|Burbank|46084.6|
|Los Angeles|48048.5|
|Brisbane|50218.5|

From the table above, we can see that the city “Dublin” is not even among the 5 cities with the least revenue generally despite being the worst city in Ireland which happens to be the country with the least revenue.
What this means is that, if the city Dublin which generates the least revenue in a country that has the least revenue record  is not among the least cities then the implication is that not much cities in Ireland are involved in the purchase of the company`s product.

This led me to checking the number of cities in Ireland where I products are sold.

```
SELECT COUNT (DISTINCT CITY) FROM [DBO].[SALES_DATA_SAMPLE]

WHERE COUNTRY = 'IRELAND' ;
```

The result shows that Dublin is the only city in Ireland that buys from the company.

The city that has the least revenue generally is “Charleroi”.  I went further to know the country where “Charleroi” is in.

**which country is it located**

```
SELECT  COUNTRY, CITY, SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE] WHERE CITY='CHARLEROI'

GROUP BY COUNTRY, CITY ORDER BY REVENUE  ASC; 
```
Charleroi is in Belgium.


**which country has the highest number of sales**

```
SELECT  TOP 5 COUNTRY,  COUNT (DISTINCT  CITY) CITIES, 

ROUND( SUM(SALES), 1) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]

GROUP BY COUNTRY ORDER BY REVENUE  DESC;
```

|COUNTRY|CITIES|REVENUE|
|-------|------|-------|
|USA|23|3627982.8|
|Spain|3|1215686.9|
|France|9|1110916.5|
|Australia|5|630623.1|
|UK|4|478880.5|

For very obvious reasons (Involvement of more number of cities) USA has the highest sales.
However, a very interesting point to note is the fact that Spain with only 3 countries generate more revenue than France with 9 cities.

**cities with the highest sales in the US**

```
SELECT  TOP 5 CITY,  SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]
	
	WHERE COUNTRY='USA' GROUP BY CITY ORDER BY 2 DESC;
```	
The result of our query is:
|CITY|REVENUE|
|----|-------|
|San Rafael|654858.1|
|NYC|560787.8|
|San Francisco|224358.7|
|New Bedford|207874.9|
|Brickhaven|165255.2|
	


**What are the top 5 best products in the US**

```
WITH TTP AS

	(SELECT   COUNTRY,  YEAR_ID, PRODUCTLINE,  SUM(SALES) REVENUE FROM [DBO].[SALES_DATA_SAMPLE]
	
	WHERE COUNTRY='USA' GROUP BY COUNTRY, YEAR_ID, PRODUCTLINE) 
	
	SELECT TOP 5 PRODUCTLINE,REVENUE FROM TTP ORDER BY REVENUE DESC;
```

|PRODUCTLINE|REVENUE|
|------|---------|
|Classic Cars|560448.3|
|Classic Cars|558544.1|
|Vintage Cars|301982.3|
|Motorcycles|287243.1|
|Vintage Cars|266141.8|

Classic cars stands as the best product in the US.



## Recommendations and Conclusions

- From my analysis, it is clear that the involvement of cities across the countries are not distributed evenly. 
Take for example, US has 23 cities involved while Switzerland and a host of others have just one. 
This can affect the provision of service to countries with less cities as more concentration will be on the countries with greater patronizing cities. I recommend then that the company opens customer care offices in the different countries to help attend to customer needs and blossom the involvement of other cities in the country.

- Considering that the products that are in high demands are Classic cars and Vintage cars, it is clear that the product of the company is  appreciated more by people of luxury. I recommend then that increases its production of quality classic cars and minimize the production of trains which has had only 77 orders.
The company`s primary products should be cars and so durability, quality and luxury should be considered.

- I observed that the best month for sales is “November”, with classic cars being the most ordered product.
This could mean that in preparation for the festive period (December), the demand for cars increase. 
I recommend then that the company`s shipping service be optimized to serve more effectively in November ( The period of high demand). 

- The analysis so far has shown Euro Shopping Channel  Mini Gifts Distributors Ltd.  and Australian Collectors Co. as the best and most active customers. I recommend that active customers be appreciated and poor customers be encouraged

- I also observed that the company has only 28 reliable customers out of 92 recorded customers. This is a thing of great concern as the analysis have shown that the company has lost 21 customers and 17 other customers  are slipping off already  with  18 of the company`s big customers not being as frequent as they were In the past. The only positive here is the addition of 8 new customers, which is still not a good number to cover for the lost customers. This is a great call for product and service optimization.
Thus,  aside improving the quality of product delivery as well as the quality of products, I recommend that the company consider giving discounts to her customers according to their level of activeness and revenue generation. This would help encourage customers and improve customer-manager relationship. That is to say, customers should be given discount based on their  Frequency and monetary value.
While customer service agents should take up the responsibility of developing personal relationships with customers to help know and encourage customers who have not visited in recent times.

- I observed that Ireland as a country generates the least revenue. Ireland has only one city as shown in the analysis.  However, If a single city can generate such revenue, then I recommend that  the expansion of the company  to many other cities particularly in Switzerland, Philippines, Singapore and Ireland. In Belgium, the products are sold in only two cities, yet one of the cities “Charleroi” has the record of least revenue return. For a country with small number of involvement, focus should be on expanding and optimizing services since the involvement of only two cities and the poor return from there might suggest wrong market strategy and poor delivery.

- I observed that the top 5 countries with the highest sales and revenue are USA, Spain France, Australia, UK in descending order. Spain has lesser countries than France, but generates more revenue. This means that there is a great potential of Spain being the highest generator of revenue for the company . I recommend special attention and expansion of other branches in other cities in Spain. 


# Thanks for Reading......



