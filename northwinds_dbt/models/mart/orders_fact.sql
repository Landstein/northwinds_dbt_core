{{ config(materialized='table') }}

WITH orders as (
    select * from {{ ref('stg_orders') }}
)
select * from orders
order by order_date desc

