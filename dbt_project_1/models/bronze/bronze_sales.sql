
{{config(materialized='view')}}   -- Block level config, applies to the whole model.

select * from {{source('source', 'fact_sales')}}