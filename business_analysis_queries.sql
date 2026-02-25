create database retail_analytics;
use  retail_analytics;
select * from transactions limit 20;

-- Q1. What is the total revenue generated, and how is it distributed across key customer segments (gender, age group)?
select gender, age_group, sum(purchase_amount_usd) as revenue,
round(sum(purchase_amount_usd) * 100.0 / 
sum(sum(purchase_amount_usd)) over(),2)
as revenue_percentage
from transactions
group by gender, age_group
order by gender, revenue desc;

-- Q2. Do discounted purchases result in higher or lower average order value compared to non-discounted purchases?
select discount_applied,
count(*) as total_orders, 
round(avg(purchase_amount_usd), 2) as avg_order_value
from transactions
group by discount_applied;

-- Q3. Which are the top 5 products with the highest average review rating?
select item_purchased,
round(avg(review_rating), 2) as average_review_rating,
count(*) as total_reviews
from transactions
group by item_purchased
order by avg(review_rating) desc limit 5;

-- Q4. Compare the average purchase amounts between Standard and Express shipping.
select shipping_type,
count(*)as total_purchases,
round(avg(purchase_amount_usd),2) as avg_purchase_amount
from transactions
where shipping_type in ('Standard', 'Express')
group by shipping_type;

-- Q5. Do subscribed customers spend more? Compare average spend and total revenue between subscribers and non-subscribers.
select count(distinct customer_id) as total_customers,
subscription_status, 
round(avg(purchase_amount_usd),2) as avg_spend,
sum(purchase_amount_usd) as total_revenue,
round(sum(purchase_amount_usd)* 100.0 /
sum(sum(purchase_amount_usd)) over(), 2) as revenue_percentage
from transactions
group by subscription_status
;

-- Q6. Which 5 products have the highest percentage of purchases with discounts applied?
select item_purchased,
count(*) as total_purchases,
round(sum(case when discount_applied = 'Yes' then 1 else 0 end) * 100.0 / count(*),2)
as discount_rate
from transactions
group by item_purchased
order by discount_rate desc
limit 5;

-- Q7. Segment customers into New, Returning, and Loyal based on previous purchases, and show the count of each segment.
with customer_type as (
select customer_id,
case 
when previous_purchases = 1 then 'New'
when previous_purchases between 2 and 10 then 'Returning'
else 'Loyal'
end as customer_segment
from transactions
)
select customer_segment, count(distinct customer_id) as total_customers
from customer_type
group by customer_segment
order by total_customers desc;

-- Q8. What are the top 3 most purchased products within each category?
with item_counts as (
select item_purchased, category,
count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id) desc) as item_rank
from transactions
group by item_purchased, category
)
select item_rank, category, total_orders, item_purchased
from item_counts
where item_rank<=3;

-- Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
select subscription_status,
count(distinct customer_id) as repeated_buyers
from transactions
where previous_purchases > 5
group by subscription_status;

-- Q10. Do the top 20% of customers contribute ~80% of total revenue? (Pareto Analysis)
WITH customer_revenue AS (
    SELECT 
        customer_id,
        SUM(purchase_amount_usd) AS total_revenue
    FROM transactions
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT 
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS overall_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS rn,
        COUNT(*) OVER () AS total_customers
    FROM customer_revenue
)

SELECT 
    ROUND(
        MAX(cumulative_revenue) * 100.0 / MAX(overall_revenue),
        2
    ) AS top_20_percent_revenue_share
FROM ranked_customers
WHERE rn <= total_customers * 0.2;
