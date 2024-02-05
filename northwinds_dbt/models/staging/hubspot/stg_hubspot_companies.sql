with customers as (
    select * from {{ source('hubspot', 'northwinds_hubspot') }}
),
companies as (
    select * from customers
),
renamed as (
    select 
    concat('hubspot-', cu.business_name) as company_id,
    cu.business_name name,
    max(cu.first_name) as first_name,
    max(cu.last_name) as last_name,
    max(REPLACE(TRANSLATE(cu.phone, '(,),-,.', ''), ' ', '')) as updated_phone
    from customers cu
    join companies on cu.business_name = companies.business_name
    group by cu.business_name
)

select * from renamed
