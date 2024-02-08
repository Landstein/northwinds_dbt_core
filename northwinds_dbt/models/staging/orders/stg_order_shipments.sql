with shipments as (
    select * from {{ source('core', 'orders') }}
)

select 
    order_id,
    required_date,
    shipped_date,
    ship_via,
    ship_name,
    ship_address,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country
from shipments