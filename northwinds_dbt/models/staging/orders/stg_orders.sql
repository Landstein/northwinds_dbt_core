{% set employee_prefix = 'rds-' %}

with orders as (
    select * from {{ source('core', 'orders') }}
),
details as (
    select * from {{ source('core', 'order_details') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['d.product_id', 'o.order_date', 'o.customer_id']) }} as order_pk,
    {{ "'" ~ employee_prefix ~ "' || " }}o.order_id as order_id,
    -- Correctly prepend 'rds-' to the employee_id using Jinja
    {{ "'" ~ employee_prefix ~ "' || " }}o.employee_id as employee_id,
    {{ "'" ~ employee_prefix ~ "' || " }}o.customer_id as customer_id,
    o.order_date,
    o.freight,
    {{ "'" ~ employee_prefix ~ "' || " }}d.product_id as product_id
from orders o
join details d on d.order_id = o.order_id

