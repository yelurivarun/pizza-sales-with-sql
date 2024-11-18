 -- 1.Retrieve the total number of orders placed.
 select count(order_id) as total_orders from order_details;
 
 -- 2.Calculate the total revenue generated from pizza sales  (Quantity×Price)
select 
	sum(p.price *
	od.quantity ) as TotalRevenue
FROM 
	Order_Details od
JOIN pizza p ON od.Pizza_id = p.Pizza_id;
 
 
 -- 3.Identify the highest-priced pizza

select 
pt.name,  
price from pizza  p join pizza_types pt on p.Pizza_type_id = pt.Pizza_type_id order by price desc limit 1;


-- 4. Identify the most common pizza size ordered
select * from order_details  as ss join pizza as dd on ss.Pizza_id=dd.pizza_id;


-- 5. List the top 5 most ordered pizza types along with their quantities
select
   count(p.Pizza_id) as numpizza,
    pt.name 
from order_details as od 
join pizza  as p on od.Pizza_id = p.Pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id group by pt.name order by numpizza desc limit 5;

-- 6. To display the unique records in each table and count
select distinct * from pizza_types;
select count(size) from pizza;


-- 7. To display the null values in each column and each table
select * from order_details where  order_details_id is null ;

-- insert into order_details (order_details_id, order_id,pizza_id, quantity ) values(null, null,'bbq_ckn_s',1)
 

-- 8. Join the necessary tables to find the total quantity of each pizza category ordered
SELECT pt.Category, SUM(od.Quantity) AS Total_Quantity
FROM Order_Details od
JOIN Pizza p ON od.Pizza_id = p.Pizza_id
JOIN Pizza_types pt ON p.Pizza_type_id = pt.Pizza_type_id
GROUP BY pt.Category;

 -- 8.Determine the distribution of orders by hour of the day
select hour(o.time), count(o.order_id) from orders2 as o group by o.time order by o.time;


-- 10. Join relevant tables to find the category-wise distribution of pizza
SELECT 
    category AS Categoryname,
    COUNT(od.Pizza_id) AS PizzaCount
FROM 
    Order_Details od
JOIN 
    Pizza p ON od.Pizza_id = p.Pizza_id
JOIN 
    Pizza_Types pt ON p.Pizza_Type_ID = pt.Pizza_Type_ID
GROUP BY 
    pt.category
ORDER BY 
    PizzaCount DESC;

-- 11. Group the orders by date and calculate the average number of daily pizzas
select o.date, count(o.order_id) from orders2 as o group by o.date;

-- 12. Determine the top 3 most ordered pizza types based on revenue
select
	sum(p.price * od.quantity ) as revenue,
    count(p.Pizza_id) as numpizza,
    pt.name 
from order_details as od 
join pizza  as p on od.Pizza_id = p.Pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id group by pt.name order by revenue desc limit 3;

-- 13. Calculate the percentage contribution of each pizza type to total revenue.
/*select 
	pt.Pizza_type_id,
	sum(p.price * od.quantity) as revenue ,
    (select sum(p.price *od.quantity ) as TotalRevenue
    -- (SUM(p.price * od.quantity) /(SELECT SUM(p2.price * od2.quantity) FROM order_details od2 JOIN pizza p2 ON od2.Pizza_id = p2.Pizza_id)) AS total_reve
FROM 
	Order_Details od
JOIN pizza p ON od.Pizza_id = p.Pizza_id) as total_reve
from
	pizza_types as pt
join pizza as p on p.pizza_type_id = pt.pizza_type_id
join order_details  as od on od.Pizza_id = p.Pizza_id
group by Pizza_type_id;
*/

SELECT 
    pt.Pizza_type_id,
    SUM(p.price * od.quantity) AS revenue,
    SUM(p.price * od.quantity) / (SELECT SUM(p2.price * od2.quantity) 
                                    FROM order_details od2
                                    JOIN pizza p2 ON od2.Pizza_id = p2.Pizza_id) AS CONTRIBUTION
FROM 
    pizza_types AS pt
JOIN 
    pizza AS p ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.Pizza_id = p.Pizza_id
GROUP BY 
    pt.Pizza_type_id;
    

-- 14. Analyze the cumulative revenue generated over time.
select o.date,
	sum(p.price *od.quantity ) as TotalRevenue 
FROM 
	Order_Details od
JOIN pizza p ON od.Pizza_id = p.Pizza_id
join orders2 as o on o.order_id = od.order_id
group by o.date;

-- 15. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select
	sum(p.price * od.quantity ) as revenue,
    pt.name 
from order_details as od 
join pizza  as p on od.Pizza_id = p.Pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id group by pt.name order by revenue desc limit 3;


    

