with rds_companies as (
    select * from {{ ref('stg_rds_companies') }}
),
hubspot_companies as (
    select * from {{ ref('stg_hubspot_companies') }}
),
merged_companies as (
    select 
    null as rds_company_id,
    company_id as hubspot_company_id,
    name
    from hubspot_companies
    union all 
    select 
    company_id as rds_company_id,
    null as hubspot_company_id,
    name
    from rds_companies
), final as (
    select 
    max(rds_company_id) as rds_company_id, max(hubspot_company_id) as hubspot_company_id, max(name) as name
    from merged_companies
    group by name
)

 select {{ dbt_utils.generate_surrogate_key(['name']) }} as contact_pk,
    hubspot_company_id, rds_company_id, name from final