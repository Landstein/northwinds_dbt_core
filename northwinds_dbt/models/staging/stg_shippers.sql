select shipper_id, company_name from {{ source('rds', 'shippers')}}
