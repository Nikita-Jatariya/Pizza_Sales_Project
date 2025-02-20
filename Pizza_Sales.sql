-- Retrieve the total number of orders placed.

SELECT 
    COUNT(Order_id) AS Total_orders
FROM orders;


-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.Order_quantity * pizzas.price),2) AS Total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.Pizza_id = pizzas.Pizza_id;
    
    
   --  Identify the highest-priced pizza. 
   
   SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;
   
   
  --  Identify the most common pizza size ordered.
   
   SELECT 
    pizzas.size,
    COUNT(order_details.order_quantity) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY order_count DESC
LIMIT 1;
   
   
-- Calculate the total number of pizzas ordered of each size.

 SELECT 
    pizzas.size,
    COUNT(order_details.order_quantity) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY order_count DESC;
   
   
--  List the top 5 most ordered pizza types along with their quantities. 

SELECT 
    pizza_types.name,
    SUM(order_details.Order_quantity) AS order_quantity
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY order_quantity DESC
LIMIT 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.Order_quantity) AS order_quantity
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY order_quantity DESC;


-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);
 
 
--  Join relevant tables to find the category-wise distribution of pizzas i.e. no. of pizzas in each category. 

SELECT 
    category, COUNT(name) AS Count
FROM
    pizza_types
GROUP BY category
ORDER BY COUNT(name) DESC;


-- Group the orders by date and calculate the average number of pizzas ordered per day. 

SELECT ROUND(AVG(quantity),0) AS avg_pizza_ordered_per_day
FROM
(SELECT orders.Order_date, SUM(order_details.Order_quantity) AS quantity
FROM orders 
INNER JOIN order_details
ON orders.Order_id = order_details.Order_id
GROUP BY orders.Order_date )AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, SUM(order_details.order_quantity * pizzas.price) AS revenue
FROM pizza_types
INNER JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
INNER JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
ROUND(SUM(order_details.Order_quantity * pizzas.price) / SELECT 
    ROUND(SUM(order_details.Order_quantity * pizzas.price),2) AS Total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.Pizza_id = pizzas.Pizza_id) * 100,2) AS revenue
From pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- Analyze the cumulative revenue generated over time.










