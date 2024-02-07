{{ config(materialized='table') }}

WITH int_companies as (
    select * from {{ ref('int_companies') }}
)
select contact_pk, name from int_companies 