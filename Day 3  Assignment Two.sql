--Assignment two(day 3)
--Q1 Retrieve all unique customer first names from the customer table.
select distinct first_name
from customer;

--Q2 Find the top 5 customers who have spent the most money.
select customer_id, sum(amount) as total_amount_spent
from payment
group by customer_id
order by total_amount_spent desc
limit 5;

--Q3 List all films with a rental rate greater than 4.00.
select film_id, title, rental_rate
from film
where rental_rate > 4;

--Q4 Count the number of payments per customer and display only customers with more than 15 payments.
select customer_id, count(payment_id) as number_of_payments
from payment
group by customer_id
having count(payment_id) > 15;

--Q5 Retrieve the first 10 films alphabetically using FETCH.
select film_id, title
from film
order by title asc
fetch first 10 rows only;

--Q6 Find the total amount paid per staff member.
select staff_id, sum(amount) as total_amount_paid
from payment
group by staff_id;

--Q7 List customers whose email ends with .org.
select customer_id, first_name, last_name, email
from customer
where email like '%.org';

--Q8 Using DISTINCT ON, retrieve the latest payment record per customer.
select distinct on (payment_date) payment_date, customer_id, payment_id
from payment;

--Q9 Display the average payment amount per customer, ordered from highest to lowest.
select customer_id, avg(amount) as average_payment_amount
from payment
group by customer_id
order by avg(amount) desc;

--Q10 Retrieve all payments made between $2.99 and $5.99.
select payment_id, amount
from payment
where amount between 2.99 and 5.99;