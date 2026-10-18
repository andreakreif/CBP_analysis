with source as (
	select *
	from {{ source('synthea', 'raw_organizations') }}
),

renamed as (
	select organization as organization_id,
        name as organization_name,
        address as organization_address,
        city as organization_city,
        state as organization_state,
        county as organization_county,
        zip as organization_zip,
        lat as organization_latitude,
        lon as organization_longitude
	from source
)

select *
from renamed
