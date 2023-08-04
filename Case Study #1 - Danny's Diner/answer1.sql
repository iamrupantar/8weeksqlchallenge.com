-- q1) What is the total amount each customer spent at the restaurant?
select a.customer_id, sum(b.price) 
from dannys_diner.sales a
join dannys_diner.menu b
on a.product_id=b.product_id
group by a.customer_id

-- Answer:
-- 'A','76'
-- 'B','74'
-- 'C','36'


-- q2) How many days has each customer visited the restaurant?
select customer_id, count(distinct order_date) as no_of_days
from dannys_diner.sales 
group by customer_id

-- Answer:
-- 'A','4'
-- 'B','6'
-- 'C','2'

-- q3) What was the first item from the menu purchased by each customer?
with final as 
(select a.*, b.product_name,
rank() over (partition by customer_id order by order_date) as Ranking
from dannys_diner.sales a 
join dannys_diner.menu b 
on a.product_id=b.product_id)
select * from final where ranking =1

-- Answer:
-- 'A','2021-01-01','1','sushi','1'
-- 'A','2021-01-01','2','curry','1'
-- 'B','2021-01-01','2','curry','1'
-- 'C','2021-01-01','3','ramen','1'
-- 'C','2021-01-01','3','ramen','1'

-- q4) What is the most purchased item on the menu and how many times was it purchased by all customers?
select b.product_name,count(*)
from dannys_diner.sales a 
join dannys_diner.menu b 
on a.product_id=b.product_id
group by b.product_name

-- Answer:
-- 'sushi','3'
-- 'curry','4'
-- 'ramen','8'

-- q5) Which item was the most popular for each customer?
with final as(
select a.customer_id ,b.product_name,count(*) as total
from dannys_diner.sales a 
join dannys_diner.menu b 
on a.product_id=b.product_id
group by a.customer_id ,b.product_name
)
select customer_id,product_name,
rank() over (partition by customer_id order by total desc) as ranking
from final 

-- Answer:
-- 'A','ramen','1'
-- 'A','curry','2'
-- 'A','sushi','3'
-- 'B','curry','1'
-- 'B','sushi','1'
-- 'B','ramen','1'
-- 'C','ramen','1'

-- q6) Which item was purchased first by the customer after they became a member?
-- Customer A
SELECT customer_id, order_date, product_name 
FROM sales
LEFT JOIN menu 
  ON sales.product_id = menu.product_id
WHERE customer_id = 'A' AND order_date > '2021-01-07' -- date after membership
ORDER BY order_date
LIMIT 1

-- Answer:
-- 'A','2021-01-10','ramen'

Customer B
SELECT customer_id, order_date, product_name 
FROM sales
LEFT JOIN menu 
  ON sales.product_id = menu.product_id
WHERE customer_id = 'B' AND order_date > '    2021-01-09' -- date after membership
ORDER BY order_date
LIMIT 1;

-- Answer:
-- 'B','2021-01-11','sushi'

-- q7) Which item was purchased just before the customer became a member?
-- Customer A
SELECT customer_id, order_date, product_name 
FROM sales
LEFT JOIN menu 
  ON sales.product_id = menu.product_id
WHERE customer_id = 'A' AND order_date < '2021-01-07' -- dates before membership
ORDER BY order_date DESC

-- Answer
-- 'A','2021-01-01','sushi'
-- 'A','2021-01-01','curry'

-- Customer B
SELECT customer_id, order_date, product_name 
FROM sales
LEFT JOIN menu 
  ON sales.product_id = menu.product_id
WHERE customer_id = 'B' AND order_date < '2021-01-09' -- get dates before membership
ORDER BY order_date DESC -- to capture closest date before membership
LIMIT 1;

-- Answer
-- 'B','2021-01-04','sushi'

-- q8) What is the total items and amount spent for each member before they became a member?
with final as (
select a.customer_id,a.order_date,b.join_date ,c.price, c.product_name
from dannys_diner.sales a
left join dannys_diner.members b
on a.customer_id=b.customer_id
join dannys_diner.menu c
on a.product_id=c.product_id
where a.order_date < b.join_date)
select customer_id , sum(price), count(distinct product_name)
from final
group by customer_id

-- Answer
-- 'A','25','2'
-- 'B','40','2'

-- q9) If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
with points as (
select a.customer_id,a.order_date,c.price,
case when product_name ='sushi' then 2*c.price
else c.price end as newprice
from dannys_diner.sales a
join dannys_diner.menu c
on a.product_id=c.product_id)

select customer_id , sum(newprice) as total_price, sum(newprice)*10 as Points from points 
group by customer_id

-- Answer
-- 'A','86','860'
-- 'B','94','940'
-- 'C','36','360'

-- q10) In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi 
-- 			- how many points do customer A and B have at the end of January?
with final_points as (
select a.customer_id,a.order_date,c.price,
case when product_name ='sushi' then 2*c.price
when order_date between b.join_date and (b.join_date+ interval 6 day) then 2*c.price
else c.price end as newprice
from dannys_diner.sales a
join dannys_diner.menu c
on a.product_id=c.product_id
join dannys_diner.members b
on a.customer_id=b.customer_id
where a.order_date < '2021-02-01'
)
select customer_id , sum(newprice) as total_price, sum(newprice)*10 as Points from final_points 
group by customer_id order by customer_id asc

-- Answer:
-- 'A','137','1370'
-- 'B','82','820'











