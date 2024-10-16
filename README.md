# DATA-EXPLORATION-AND-RFM-ANALYSIS-OF-SALES-DATA

![RFM 3](https://github.com/user-attachments/assets/0e3fe4e0-9c2d-4ada-9a62-66e7e9f53f8e)

This is an SQL portfolio project with the primary aim of data exploration. It explores the dataset to find out the best customers and best products through making an RFM Analysis. 

# Introduction
By analyzing sales dataset, we will answer the following questions:
By analyzing the datasets related to deforestation, income groups, and regional information of countries and areas, we will answer the following questions:

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

-- To check the cities per country where the company`s product are sold.

```
SELECT COUNT (DISTINCT  CITY) CITY_PER_COUNTRY, COUNTRY  FROM [DBO].[SALES_DATA_SAMPLE] GROUP BY COUNTRY ORDER BY CITY_PER_COUNTRY DESC;
```
