SELECT 'SNOMED_'|| condition_code AS code_key,
    condition_code, 
    MAX(condition_description) AS condition_description,
    'SNOMED' AS code_system
FROM {{ ref('stg_conditions') }}
GROUP BY condition_code
UNION ALL
SELECT 'LOINC_'|| observation_code AS code_key,
    observation_code, 
    MAX(observation_description), 
    'LOINC' AS code_system
FROM {{ ref('stg_observations'  ) }}
GROUP BY observation_code;