
With flu_shot_2022 as (
Select patient , min(date) as earliest_date_2022

from immunizations

Where code = '5302' and date between '2022-01-01 00:00' and '2022-12-31 23:59'

group by patient 

)

,
 active_patients as
(
Select distinct  patient 

from encounters as e
join patients as pat 
on e.patient =pat.id
Where start between '2020-01-01 00:00' and '2022-12-31 23:59'
and pat.deathdate is null 
and EXTRACT(MONTH FROM AGE('2022-12-31', pat.birthdate)) >= 6
)

Select
pat.birthdate ,
pat.race,
pat.county,
pat.first,
pat.last,
pat.id,
flu.patient,
flu.earliest_date_2022,
EXTRACT(Year FROM AGE('2022-12-31', pat.birthdate)) as age,

case when flu.patient is not null then 1
else 0
end as flu_shot_2022

from patients as pat 
left join flu_shot_2022 as flu on
pat.id  = flu.patient

where 1=1 and pat.id in (select patient from active_patients)









select patient 

from  immunizations

left join patients 

on immunizations.patient= patients.id



select birthdate 
from patients
