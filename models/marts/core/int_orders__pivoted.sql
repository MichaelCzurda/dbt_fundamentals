{%- set payment_methods = ['bank_transfer','credit_card','coupon','gift_card'] -%}

with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select
        order_id
        {% for payment in payment_methods -%}
            ,sum(case when payment_method = '{{payment}}' then amount else 0 end) as {{payment}}_amount
        {% endfor -%}
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted
order by order_id