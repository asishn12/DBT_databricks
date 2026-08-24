with sales as 
(
    select 
    sales_id,
    customer_sk,
    {{multiply('unit_price', 'quantity')}} as calculated_amount,
    product_sk,
    gross_amount,
    payment_method
    from 
    {{ref('bronze_sales')}}   
),
bronze_products as 
(
    select product_sk,
    category
    from {{ref('bronze_product')}}
),
customer as (
    select customer_sk,
    gender
    from {{ref('bronze_customer')}}
),
joined_query as(
select 
s.sales_id,
s.gross_amount,
s.payment_method,
p.category,
c.gender
from sales s
join bronze_products p
on s.product_sk = p.product_sk
join customer c
on s.customer_sk = c.customer_sk
)

select 
category,
gender,
sum(gross_amount) as total_sales
from joined_query
group by category, gender
order by total_sales desc
