# Plato-Pizza-Place-Sales-Analysis

## Table Of Contents

1. [Project Overview](#project-overview)
2. [Tools and Methodologies](#tools-and-methodologies)
3. [Business Questions](#business-questions)
4. [Visualization](#visualization)
5. [Insights and Recommendations](#insights-and-recommendations)


## Project Overview
This project focuses on analyzing sales data from Plato Pizza Place, a fictitious pizza restaurant, to gain insights into customer behavior, order composition, revenue trends, and menu optimization. The dataset, provided by Maven Analytics, includes records of all orders placed over a year, detailing the date and time of each order, the pizzas served, and additional information on pizza types, sizes, prices, and ingredients.

The dataset comprises four key tables:

* **Order Details:** The fact table, which provides a breakdown of each order, including the pizza ID, quantity, and order details ID, with a total of 48,260 records.
* **Orders:** A dimension table that contains details of each order, including the order ID, date, and time.
* **Pizzas:** A dimension table that lists the pizza ID, type, size, and price.
* **Pizza Types:** A sub-dimension table of the Pizzas table, which describes the pizza types, including the name, category, and ingredients.

This project aimed to provide actionable insights that could guide Plato Pizza Place's strategic decisions, from optimizing the menu to enhancing customer engagement. The analysis focused on understanding daily customer traffic, identifying peak hours, determining bestselling and underperforming pizzas, and assessing revenue patterns to uncover potential seasonality in sales.


## Tools and Methodologies
To efficiently manage and analyze the pizza place sales data, I utilized a combination of SQL Server (MSSQL) for data processing, and analysis and Power BI for visualization and reporting. The choice of tools was driven by the need for robust data handling, complex query capabilities, and interactive report generation to uncover key business insights. Below is a detailed breakdown of how each tool was employed throughout the project.

**1. SQL Server (MSSQL)** [Click Here To View SQL Queries](https://github.com/Zay-Yar-Htay/Plato-Pizza-Place-Sales-Analysis/blob/main/plato_pizza_place_sales_queries.sql)

* **Database Creation and Data Import:** Created the database and tables, and imported CSV files using SQL queries.

* **Data Profiling and Exploration:** Conducted initial data profiling to understand the dataset, including examining data distributions and identifying data quality issues.

* **Data Pre-processing:**
  * **Data Cleaning:** Checked for duplicate records and handled missing values across all tables.
  * **Data Transformation:** Created calculated columns such as month_number, day_of_the_week, day_of_the_week_number, and converted time data into a 12-hour format. Additionally, transformed pizza size abbreviations (S, M, L, XL) into full forms (Small, Medium, Large, Extra Large).
  * **Data Aggregation:** Joined multiple tables using complex queries and created a view (plato_pizza_place_sales) to consolidate the data for easier analysis.

* **Data Analysis:** Conducted in-depth analysis using SQL queries to answer business questions. Utilized aggregation functions, subqueries, and grouping techniques to derive insights. Key analyses included identifying peak hours, calculating average pizzas per order, determining bestsellers, and assessing total revenue.


**2. Power BI** [Click Here To Download Power BI Report Desktop File](https://github.com/Zay-Yar-Htay/Plato-Pizza-Place-Sales-Analysis/blob/main/plato_pizza_place_sales_analysis.pbix)

* **Data Import and Modeling:** Imported cleaned datasets from SQL Server into Power BI and established relationships between tables.

* **Interactive Report Development:**
  * Created visualizations, added slicers, and used DAX functions to build an interactive report that allowed end users to explore the data.
  * Developed dashboards that visualized key metrics such as daily customer counts, peak hours, average pizzas per order, bestsellers, and total revenue.

* **Report Publishing:** Published the final report to Power BI Service to share the results with stakeholders.


## Business Questions
1. How many customers do we have each day? Are there any peak hours?

2. How many pizzas are typically in an order? Do we have any bestsellers?

3. How much money did we make this year? Can we identify any seasonality in the sales?

4. Are there any pizzas we should take off the menu, or any promotions we could leverage?


## Visualization 
[Interactive Report Link](https://app.powerbi.com/view?r=eyJrIjoiZTRhNGJjOWUtNjkwNy00YTZhLWFhM2MtOGE2ZTFkMWYzZDUzIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)
![Plato Pizza Sales Analysis Report](https://github.com/user-attachments/assets/1230628e-9afd-475b-8700-bac78886794a)



## Insights and Recommendations
**1. How many customers do we have each day?**

**INSIGHTS**

* **Daily Customer Variation:** The data reveals a fluctuation in daily customer numbers, ranging from a low of 27 customers to a high of 115 customers. Key observations include:
   * **Average Daily Customers:** Most days see between 50 to 70 customers.
   * **High Traffic Days:** Notable dates include November 27 (115 customers), November 26 (113 customers), and October 15 (107 customers). These dates likely correspond with special events, holidays, or successful promotions. Additionally, July 4 (105 customers), and July 3 (93 customers) also stand out as additional high-traffic days, indicating potential holiday-related spikes.
   * **Monthly Performance:** Looking back at 2015, July emerged as the top-performing month in terms of customer count, followed closely by May, March, and November. Meanwhile, September and October recorded the lowest customer counts.

**RECOMMENDATIONS**
* **Leverage High-Traffic Days:** Focus on scheduling additional staff, preparing inventory, and launching targeted promotions on identified high-traffic days like November 27, November 26, and October 15, as well as July 3-4. Understanding the underlying factors (events, promotions, holidays) driving these spikes can help replicate success on other days.
* **Enhance Customer Engagement During Low Performing Months:** September and October saw the lowest customer counts. Consider running special promotions, introducing limited-time offers, or holding events during these months to increase customer traffic.


**2. Are there any peak hours?**

**INSIGHTS**

* **Busiest Hours:** Lunchtime, particularly 12:00 PM to 2:00 PM, sees the highest order volumes on weekdays, emphasizing lunch breaks as peak ordering times.
* **Weekday Patterns:** Mondays and Wednesdays mirror this trend, showing consistent midday orders that gradually decrease towards the evenings. However, slight variations might occur, with certain hours on Wednesdays seeing a marginally higher customer count compared to Mondays.
* **Weekend Behavior:** Saturdays and Sundays exhibit lower lunchtime orders compared to weekdays but show an uptick in dinner orders, particularly from 6:00 PM to 8:00 PM, suggesting that weekends are popular for social gatherings and family dinners.
* **Late-Night Orders:** Late-night orders are minimal, with only a handful of customers placing orders after 9:00 PM. This highlights pizza's strong association with daytime and evening dining, rather than late-night snacking.

**RECOMMENDATIONS**

* **Optimize Staffing During Peak Hours:** Ensure that the busiest hours, especially around lunchtime from 12:00 PM to 2:00 PM on weekdays, are well-staffed to manage the increased order volume efficiently. This could help reduce wait times and improve customer satisfaction.
* **Targeted Promotions:** Introduce targeted lunch promotions on weekdays to capitalize on the already high traffic. Consider launching new lunch combos or limited-time offers to increase the average order size during these peak hours.
* **Weekend Dinner Focus:** Since weekends show higher dinner orders, especially from 6:00 PM to 8:00 PM, consider offering weekend dinner specials or family-sized meals. This strategy could further boost sales during these hours and attract larger groups or families.
* **Evaluate Late-Night Strategy:** Given the minimal late-night orders, consider closing earlier on certain days or introducing targeted late-night deals to see if they drive more traffic. If late-night promotions prove ineffective, reallocating resources to peak hours may be more beneficial.


**3. How many pizzas are typically in an order? Do we have any bestsellers? Are there any pizzas we should take of the menu, or any promotions we could leverage?**

**INSIGHTS**

* **Average Pizza Per Order**: The average number of pizzas per order is 2.32, indicating that customers typically order more than two pizzas at a time, possibly to share with others.

* **Top 5 Bestselling Pizzas**
  * The Classic Deluxe Pizza is the most popular, with the highest number of sales, showcasing its broad appeal among customers.
  * The Barbecue Chicken Pizza, The Hawaiian Pizza, The Pepperoni Pizza, and The Thai Chicken Pizza also rank as top sellers, each showing strong customer preference.
* **Bottom 5 Least Selling Pizzas**
  * The Brie Carre Pizza has the lowest sales among the offerings, suggesting it may not resonate well with customers.
  * Other pizzas like The Soppressata Pizza, Spinach Supreme Pizza, Calabrese Pizza, and Mediterranean Pizza also have lower sales, indicating they might not be as popular.

**RECOMMENDATIONS**

* **Promote Bestsellers:** Leverage the success of the top-selling pizzas by featuring them prominently in marketing campaigns, social media posts, and in-store promotions. This can further boost their sales and strengthen their status as customer favorites.
* **Reevaluate or Innovate Under-Performing Pizzas:** Consider either removing or reimagining under-performing pizzas like The Brie Carre Pizza. Strategies could include adjusting ingredients, offering special deals, or temporarily highlighting them in promotions to gauge customer interest.


**4. How much money did we make this year? Can we identify any seasonality in the sales?**

**INSIGHTS**

* **Revenue Insights:** The pizza place generated a total revenue of $817.86k in the year, with an average daily revenue of $2.28k. The monthly revenue fluctuated, with July being the highest-grossing month at $72.56k, followed by May ($71.40k) and March ($70.40k). The lowest revenue was recorded in October at $64.03k, closely followed by September ($64.18k).

* **Seasonality Analysis:** There is evidence of seasonal trends in the sales data. The summer months, particularly July, show the highest revenue, indicating a possible increase in customer activity during this time. The fall months, especially September and October, exhibit a noticeable decline in revenue, suggesting these months are less active.

**RECOMMENDATIONS**
* **Boost Summer Sales:** To maximize revenue during the peak summer months, consider implementing special summer promotions or launching new seasonal menu items. Outdoor events or extended business hours could also attract more customers.

* **Holiday Marketing:** Use the holiday season to drive sales in November and December. Holiday-themed promotions, special offers, and targeted marketing campaigns can help increase foot traffic and boost sales during these months.

* **Low Season Strategy:** Focus on increasing customer engagement during the slower months (September and October) by introducing limited-time offers, loyalty programs, or partnerships with local events. Consider analyzing customer feedback to understand their preferences and tailor promotions to meet their needs during this period.

* **Maintain Steady Growth:** Maintain customer engagement throughout the year by regularly updating the menu and offering special deals that align with the seasons. This can help smooth out revenue fluctuations and ensure steady customer interest.






































