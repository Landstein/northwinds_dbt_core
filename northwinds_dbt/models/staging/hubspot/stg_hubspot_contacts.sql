with customers as (
    select * from {{ source('hubspot', 'northwinds_hubspot') }}
),
renamed as (
    select 
    concat('hubspot-', hubspot_id) as id,
    REPLACE(TRANSLATE(phone, '(,),-,.', ''), ' ', '') as updated_phone,
    first_name,
    last_name, 
    business_name
    from customers
)

select * from renamed
