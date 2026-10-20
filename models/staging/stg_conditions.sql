with source as (
	select *
	from {{ source('synthea', 'raw_conditions') }}
),
renamed as (
	select 
        {{dbt_utils.generate_surrogate_key(['encounter','patient','code'])}} as condition_id,
        start_dt as start_dt,
        stop_dt as stop_dt,
        patient as patient_id,
        encounter as encounter_id,
        code as condition_code,
        description as condition_description
	from source
)

select *
from renamed
