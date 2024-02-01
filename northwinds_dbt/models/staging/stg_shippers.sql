create view "northwinds"."dev"."stg_shippers__dbt_tmp"
  as (
    select shipper_id, company_name from shippers
  );