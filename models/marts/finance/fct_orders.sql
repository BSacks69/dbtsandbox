with customers as (
    select * from {{ ref('stg_jaffle_shop__customer') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payment as (

    SELECT * FROM {{ ref('stg_stripe__payments') }}
),

customer_orders as (

    select
        orderid as order_id,

        sum(amount/100) as total_amount

    from payment
    WHERE status = 'success'

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        SUM(customer_orders.total_amount) as liftime_value
    from customers
    left join orders using (customer_id)
    left join customer_orders using (order_id)
    GROUP BY 1,2,3

)

select * from final