WITH payments as(
    SELECT 
        id as payment_id,
        orderid as order_id,
        -- amount is stored in cents, convert it to dollars
        amount / 100 as amount,
        status,
        paymentmethod as payment_method,
        created as created_at
    FROM {{ source('stripe', 'payments') }}
)

Select * from payments
