-- creating a schema named 'dannys_diner'
CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

-- using the schema that we have created
use dannys_diner;

-- creating table sales
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

-- inserting multiple data into sales table
INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
  
  -- viewing all the data from sales table
  select * from sales;
  
  
  -- creating a new table menu
  CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);


-- inserting data into this newly created table
INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  
  -- viewing the data insered
  select * from menu;
  
  -- creating another new table 
  CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

-- inserting data into the following table
INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  -- viewing the data insered
  select * from members;













  
  