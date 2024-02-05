with source as (
    select * from {{ source('rds', 'suppliers') }}
),

renamed as (
    select supplier_id, company_name, 
    split_part(contact_name, ' ', 1) as first_name,
    split_part(contact_name, ' ', 2) as last_name,
    contact_title, address, city, region, postal_code, country, 
    replace(replace(phone, '(', ''), ')', '') as phone, fax, homepage
    from source
    where length(phone) >= 10
)

select * from renamed
