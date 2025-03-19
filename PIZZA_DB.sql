use pizza;

#total price of pizza saled
select sum(total_price) as total_revenue from pizza_sales;

#Average sales of pizza \
select sum(total_price) / count(distinct order_id) as Average_Sales from pizza_sales;

#Quantity Of Pizza Sold
select sum(quantity) as Total_Pizza_sold from pizza_sales;

#Count of Orders
select count(distinct order_id) from pizza_sales;

#avergae pizza saled per order
select cast( cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2))as decimal(10,2))
 as Avg_pizza_per_order from pizza_sales;


# Charts Requirement

DESCRIBE pizza_sales;
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE pizza_sales
MODIFY order_date DATE;

SET SQL_SAFE_UPDATES = 1;

SELECT 
    CASE 
        WHEN DAYOFWEEK(order_date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(order_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(order_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(order_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(order_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(order_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(order_date) = 7 THEN 'Saturday'
    END AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO';

#Monthly Sales
SELECT MONTHNAME(order_date) AS Month_Name,
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date) 
order by monthname(order_date) asc;

#Hourly trend
SELECT 
    HOUR(order_time) AS order_hours, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hours;


#percentage of sales of pizza category
SELECT pizza_category, 
       SUM(total_price) AS Total_Sales, 
       (SUM(total_price) * 100) / 
       (SELECT SUM(total_price) 
        FROM pizza_sales 
        WHERE MONTH(order_date) = 1) AS Sales_Percentage
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

#percentrage of sales by pizza size;
SELECT pizza_size, 
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(total_price) * 100) / 
            (SELECT SUM(total_price) 
             FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;


SELECT pizza_category, 
       SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

# Total Quantity Sold by Pizza Category in February
SELECT pizza_size, 
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(total_price) * 100) / 
            (SELECT SUM(total_price) 
             FROM pizza_sales 
             WHERE QUARTER(order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

#Top 5 Pizzas by Revenue
SELECT pizza_name, 
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

#Bottom 5 Pizzas by Revenue
SELECT pizza_name, 
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

#Top 5 Pizzas by Quantity
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

#Bottom 5 Pizzas by Quantity
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

#Top 5 Pizzas by Total Orders
SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

#Bottom 5 Pizzas by Total Orders
SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;





