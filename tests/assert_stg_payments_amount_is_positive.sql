with payments as (
    Select * from {{ ref('stg_payments') }}
)

Select 
    order_id,
    sum(amount) as total_amount
from payments
group by order_id
having total_amount < 0 