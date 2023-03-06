-----MEDIUM Problems solutions

---1.	Show unique birth years from patients and order them by ascending.
select distinct(Year(birth_date))
from patients
order by birth_date

---2.	Show unique first names from the patients table which only occurs once in the list.
--------For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select first_name
from patients
group by first_name
having count(first_name) = 1

---3.	Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name
from patients
where first_name like 's%' and first_name like '%s' and len(first_name) >= 6

---4.	Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
---Primary diagnosis is stored in the admissions table.
select p.patient_id,p.first_name,p.last_name
from patients p 
join admissions a on p.patient_id = a.patient_id
where a.diagnosis = 'Dementia'

---5.	Display every patient's first_name.
---Order the list by the length of each name and then by alphabetically
select first_name
from patients
order by  len(first_name) ,first_name

---6.	Show the total amount of male patients and the total amount of female patients in the patients table.
----Display the two results in the same row.
select
sum	(case when gender ='M' then 1 else 0 end	)AS male_count,
sum(case when gender ='F' then 1 else 0 end )as female_count
from patients

---7.	Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select first_name,last_name,allergies
from patients
where allergies in ('Penicillin','Morphine')
order by allergies,first_name,last_name

---8.	Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select f.patient_id,f.diagnosis
from(
select patient_id,diagnosis
from admissions
group by patient_id,diagnosis
having count(*) > 1) f

---9.	Show the city and the total number of patients in the city.
---Order from most to least patients and then by city name ascending.
select city,count(*) as total_patient
from patients
group by city
order by total_patient desc , city asc

---10.	Show first name, last name and role of every person that is either patient or doctor.
---The roles are either "Patient" or "Doctor"
select first_name,last_name,'Patient' AS role from patients
union all 
select first_name,last_name,'Doctor' As role from doctors

---11.	Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
select allergies , count(* ) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc

---12.	Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date
from patients
where  year(birth_date) between 1970 and 1979
order by birth_date

---13.	We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
---EX: SMITH,jane
select concat(upper(last_name),',',lower(first_name)) AS new_name_format
from patients
order by first_name desc

---14.	Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id ,sum(height)
from patients
group by province_id
having sum(height) >=7000

---15.	Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select (max(weight) - min(weight)) As weight_delta
from patients
where last_name = 'Maroni'

---16.	Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as day_number,
count(admission_date) as number_of_admission
from admissions
group by day_number
order by number_of_admission desc

---17.	Show the all columns for patient_id 542's most recent admission_date.
select * 
from admissions
where patient_id = 542
order by admission_date desc
limit 1

------The End----------------------------------------------------------------------
