with source as (
    select * from {{ source('rds', 'customers') }}
),
renamed as (
    select 
    concat('rds-',replace(lower(company_name), ' ', '-')) as company_id,
    company_name name,
    max(address) address, 
    max(city) city, 
    max(postal_code) postal_code,
    max(country) country
    from source
    group by company_name
)

select * from renamed


