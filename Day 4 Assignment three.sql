--Assignment three(day 4):
--Q1 List all customers along with their total payment amount.
	--Output: customer_id, full_name, total_amount
	
select c.customer_id, c.first_name||' '||c.last_name as full_name, 
	sum(p.amount) as total_amount
from customer as c
join payment as p
on c.customer_id = p.customer_id
group by c.customer_id;

--Q2 Retrieve the top 10 customers by total amount spent.
	--Output: full_name, email, total_amount

select  c.first_name||' '||c.last_name as full_name,c.email as email,
	sum(p.amount) as total_amount
from customer as c
join payment as p
on c.customer_id = p.customer_id
group by full_name, email
order by total_amount desc
limit 10;

--Q3 Display all films and their corresponding categories.
	--Tables: film, film_category, category 
	
select a.title, b.category_id, c.name
from film as a
join film_category as b
on a.film_id = b.film_id
join category as c
on b.category_id = c.category_id;

--Q4 Find the number of rentals made by each customer.
	--Output: customer_id, full_name, total_rentals
	
select c.customer_id, c.first_name||' '||c.last_name as full_name,
	count(r.rental_id) as total_rentals
from customer as c
join rental as r
on c.customer_id = r.customer_id
group by c.customer_id, full_name;

--Q5 List customers who have never made a payment.
	--Hint: LEFT JOIN
	
select c.customer_id, c.first_name||' '||c.last_name as full_name, 
	p.payment_id
from customer as c
left join payment as p
on c.customer_id = p.customer_id
where p.payment_id is null;

--Q6 Show total revenue generated per store.
	--Tables: store, staff, payment
	
select a.store_id, sum(c.amount) as total_revenue
from store as a
join staff as b
on a.store_id = b.store_id
join payment as c
on b.staff_id = c.staff_id
group by a.store_id;

--Q7 Identify the top 5 most rented movies.
	--Output: film_title, rental_count

select a.title as film_title, count(c.rental_id) as rental_count
from film as a
join inventory as b
on a.film_id = b.film_id
join rental as c
on b.inventory_id = c.inventory_id
group by film_title
order by count(c.rental_id) desc
limit 5;

--Q8 Find customers who rented more than 30 films.
	--Output: full_name, rental_count

select  c.first_name||' '||c.last_name as full_name, 
		count(r.rental_id) as rental_count
from customer as c
join rental as r
on c.customer_id = r.customer_id
group by full_name
having count(r.rental_id) > 30;