--To Create Database
DROP DATABASE IF EXISTS [plato_pizza_sales];
CREATE DATABASE [plato_pizza_sales];

-- To Create Orders Table
CREATE TABLE [orders]
	(
	[order_id] INT NOT NULL,
	[date] DATE NOT NULL,
	[time] TIME NOT NULL
	PRIMARY KEY ([order_id])
	)
;
-- To import CSV file into City Table
BULK INSERT [orders]
FROM 'D:\MSSQL Datasets\orders.csv'
WITH 
	(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 --To skip the first row (header row)
	)
;
---------------------------------------------------------------------------------------------------------

-- To Create Pizza Types Table
CREATE TABLE [pizza_types]
	(
	[pizza_type_id] VARCHAR (50) NOT NULL,
	[name] VARCHAR (250) NOT NULL,
	[category] VARCHAR (50) NOT NULL,
	[ingredients] TEXT NOT NULL
	PRIMARY KEY ([pizza_type_id])
	)
;
-- To import CSV file into City Table
BULK INSERT [pizza_types]
FROM 'D:\MSSQL Datasets\pizza_types.csv'
WITH 
	(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 --To skip the first row (header row)
	)
;
---------------------------------------------------------------------------------------------------------

-- To Create Pizzas Table
CREATE TABLE [pizzas]
	(
	[pizza_id] VARCHAR (50) NOT NULL,
	[pizza_type_id] VARCHAR (50) NOT NULL,
	[size] VARCHAR (10) NOT NULL,
	[price] DECIMAL (10,2) NOT NULL,
	PRIMARY KEY ([pizza_id]),
	FOREIGN KEY ([pizza_type_id]) REFERENCES [pizza_types] ([pizza_type_id])
	)
;
-- To import CSV file into City Table
BULK INSERT [pizzas]
FROM 'D:\MSSQL Datasets\pizzas.csv'
WITH 
	(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 --To skip the first row (header row)
	)
;
---------------------------------------------------------------------------------------------------------

-- To Create Order Details Table
CREATE TABLE [order_details]
	(
	[order_details_id] INT NOT NULL,
	[order_id] INT NOT NULL,
	[pizza_id] VARCHAR (50) NOT NULL,
	[quantity] INT NOT NULL,
	PRIMARY KEY ([order_details_id]),
	FOREIGN KEY ([order_id]) REFERENCES [orders] ([order_id]),
	FOREIGN KEY ([pizza_id]) REFERENCES [pizzas] ([pizza_id])
	)
;
-- To import CSV file into City Table
BULK INSERT [order_details]
FROM 'D:\MSSQL Datasets\order_details.csv'
WITH 
	(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 --To skip the first row (header row)
	)
;
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------



-- DATA PRE-PROCESSING

-- Checking Duplicate Records In Order Details Table
SELECT 
	[order_details_id],
	COUNT([order_details_id]) AS [count] 
FROM [order_details]
GROUP BY [order_details_id]
HAVING COUNT([order_details_id]) > 1
;

-- Checking Missing Values In Order Details Table
SELECT 
	[order_details_id],
	[order_id],
	[pizza_id],
	[quantity]
FROM [order_details]
WHERE 
	[order_details_id] IS NULL OR 
	[order_id] IS NULL OR 
	[pizza_id] IS NULL OR
	[quantity] IS NULL
;

-- Checking Duplicate Records In Orders Table
SELECT 
	[order_id],
	COUNT([order_id]) AS [count]
FROM [orders]
GROUP BY [order_id]
HAVING COUNT([order_id]) > 1
;

-- Checking Missing Values In Orders Table
SELECT 
	[order_id],
	[date],
	[time]
FROM [orders]
WHERE 
	[order_id] IS NULL OR
	[date] IS NULL OR
	[time] IS NULL
;

-- Adding Month Name Column In Orders Table,
ALTER TABLE [orders]
ADD [month_name] VARCHAR (20) NOT NULL
;

UPDATE [orders]
SET [month_name] = UPPER(FORMAT([date], 'MMM'))
;

--Adding Month Number Column In Orders Table
ALTER TABLE [orders]
ADD [month_number] INT NOT NULL
;

UPDATE [orders]
SET [month_number] = MONTH([date])
;

-- Adding Day Of The Week Column In Orders Table
ALTER TABLE [orders]
ADD [day_of_the_week] VARCHAR (20) NOT NULL
;

UPDATE [orders]
SET [day_of_the_week] = UPPER(FORMAT([date],'ddd'))
;

-- Adding Day Of The Week Number Column In Orders Table
ALTER TABLE [orders]
ADD [day_of_the_week_number] INT NOT NULL
;

UPDATE [orders]
SET [day_of_the_week_number] =CASE
								WHEN UPPER(FORMAT([date],'ddd')) = 'MON' THEN 1
								WHEN UPPER(FORMAT([date],'ddd')) = 'TUE' THEN 2
								WHEN UPPER(FORMAT([date],'ddd')) = 'WED' THEN 3
								WHEN UPPER(FORMAT([date],'ddd')) = 'THU' THEN 4
								WHEN UPPER(FORMAT([date],'ddd')) = 'FRI' THEN 5
								WHEN UPPER(FORMAT([date],'ddd')) = 'SAT' THEN 6
								ELSE 7 
							END
;

-- Adding Sale Hour Column In Orders Table
ALTER TABLE [orders]
ADD [sale_hour] VARCHAR (10) NOT NULL
;

UPDATE [orders]
SET [sale_hour] = FORMAT(DATEADD(MINUTE,DATEDIFF(MINUTE, 0, time) / 60 * 60, 0), 'hh:00 tt');
;

--Checking Duplicate Recorde In Pizza Types Table
SELECT 
	[pizza_type_id],
	COUNT([pizza_type_id]) AS [count]
FROM [pizza_types]
GROUP BY [pizza_type_id]
HAVING COUNT([pizza_type_id]) > 1
;

--Checking Missing Values In Pizza Types Table
SELECT 
	[pizza_type_id],
	[name],
	[category],
	[ingredients]
FROM [pizza_types]
WHERE 
	[pizza_type_id] IS NULL OR
	[name] IS NULL OR
	[category] IS NULL OR
	[ingredients] IS NULL
;

-- Checking Duplicate Records In Pizzas Table
SELECT 
	[pizza_id],
	COUNT([pizza_id]) AS [count]
FROM [pizzas]
GROUP BY [pizza_id]
HAVING COUNT([pizza_id]) > 1
;

--Checking Missing Values In Pizzas Table
SELECT 
	[pizza_id],
	[pizza_type_id],
	[size],
	[price]
FROM [pizzas]
WHERE 
	[pizza_id] IS NULL OR
	[pizza_type_id] IS NULL OR
	[size] IS NULL OR
	[price] IS NULL
;

-- Adding calculated column for size to transform format
ALTER TABLE [pizzas]
ADD [pizza_size] VARCHAR (50) NOT NULL
;

UPDATE [pizzas]
SET [pizza_size] = CASE 
					WHEN [size] = 'S' THEN 'Small'
					WHEN [size] = 'M' THEN 'Medium'
					WHEN [size] = 'L' THEN 'Large'
					WHEN [size] = 'XL' THEN 'Extra Large'
					ELSE 'Double Extra Large'
				END
;
-- Creating View
CREATE VIEW [plato_pizza_place_sales] AS
SELECT 
	od.[order_details_id],
	od.[order_id],
	od.[pizza_id],
	od.[quantity],
	o.[date],
	o.[time],
	o.[month_name],
	o.[month_number],
	o.[day_of_the_week],
	o.[day_of_the_week_number],
	o.[sale_hour],
	p.[pizza_type_id],
	p.[pizza_size],
	p.[price],
	pt.[name],
	pt.[category],
	pt.[ingredients]
FROM [order_details] od
LEFT JOIN [orders] o ON od.[order_id] = o.[order_id]
LEFT JOIN [pizzas] p ON od.[pizza_id] = p.[pizza_id]
LEFT JOIN [pizza_types] pt ON p.[pizza_type_id] = pt.[pizza_type_id]
;

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------



-- ANALYSIS

--1. How many customers do we have each day? Are there any peak hours?
-- Total Orders
SELECT 
	COUNT(DISTINCT([order_id]))
FROM [plato_pizza_place_sales]
;

-- Total customers for each day
SELECT 
	[date],
	COUNT(DISTINCT([order_id])) AS [total_customer]
FROM [plato_pizza_place_sales]
GROUP BY [date]
ORDER BY [date] ASC
;

--Average customers per day
SELECT 
	AVG([daily_customers].[total_customer]) AS [avg_customer_per_day]
FROM 
	(SELECT 
		[date],
		(COUNT(DISTINCT([order_id]))) AS [total_customer]
	FROM [plato_pizza_place_sales]
	GROUP BY [date]) AS [daily_customers]
;
--Peak Hour
SELECT 
	COUNT(DISTINCT([order_id])) AS [total_customers],
	[day_of_the_week],
	[sale_hour],
	[day_of_the_week_number]
FROM [plato_pizza_place_sales]
GROUP BY [day_of_the_week_number],[day_of_the_week],[sale_hour]
ORDER BY [day_of_the_week_number], [sale_hour]
;

---------------------------------------------------------------------------------------------------------

-- 2. How many pizzas are typically in an order? Do we have any bestsellers? Are there any pizzas we should take of the menu, or any promotions we could leverage?
-- Average Pizza Per Order
SELECT
	CAST(CAST(SUM([quantity]) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT([order_id])) AS decimal (10,2)) AS DECIMAL (10,2)) AS [avg_pizza_per_order]
FROM [plato_pizza_place_sales]
;

-- Best Seller Pizzas
SELECT 
	TOP 5 [name],
	SUM([quantity]) AS [total_pizza_sold]
FROM [plato_pizza_place_sales]
GROUP BY [name]
ORDER BY [total_pizza_sold] DESC
;

-- Under Performing Pizzas
SELECT 
	TOP 5 [name],
	SUM([quantity]) AS [total_pizza_sold]
FROM [plato_pizza_place_sales]
GROUP BY [name]
ORDER BY [total_pizza_sold] ASC
;
---------------------------------------------------------------------------------------------------------

-- 3. How much money did we make this year? Can we indentify any seasonality in the sales?
-- Total Revenue In 2015
SELECT 
	SUM([price]*[quantity]) AS [total_revenue]
FROM [plato_pizza_place_sales]
;

-- Total Revenue Per Day
SELECT 
	[date],
	[month_name],
	SUM([price]*[quantity]) AS [total_revenue]
FROM [plato_pizza_place_sales]
GROUP BY [date], [month_name]
ORDER BY [date] ASC
;

-- Average Revenue Per Day
SELECT
	CAST(AVG([revenue_per_day].[total_revenue]) AS DECIMAL (10,2)) AS [avg_revenue_per_day]
FROM
	(SELECT
		[date],
		[month_name],
		SUM([price]*[quantity]) AS [total_revenue]
	FROM [plato_pizza_place_sales]
	GROUP BY [date], [month_name]) AS [revenue_per_day]
;
	
-- Monthly Revenue (To identify seasonal trend in the sales)
SELECT 
	[month_name],
	SUM([price]*[quantity]) AS [total_revenue]
FROM [plato_pizza_place_sales]
GROUP BY [month_name]
ORDER BY SUM([price]*[quantity]) DESC
;