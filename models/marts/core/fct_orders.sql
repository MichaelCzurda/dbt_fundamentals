with orders as (
   SELECT * FROM {{ ref('stg_orders') }}
),

payments as (
    SELECT * FROM {{ ref('stg_payments') }}
),

order_payments as (
    SELECT 
        order_id,
        SUM(case when status='success' then amount else 0 end) as amount
    FROM payments
    group by 1
),
final as(
    Select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount
        from orders 
        left join order_payments using (order_id)
)

Select * from final