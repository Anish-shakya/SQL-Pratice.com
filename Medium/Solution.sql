-----MEDIUM Problems solutions

---1.	Show unique birth YEARs FROM patients and order them by ascending.
SELECT DISTINCT(YEAR(birth_date))
FROM patients
ORDER BY birth_date

---2.	Show unique first names FROM the patients table which only occurs once in the list.
--------For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1

---3.	Show patient_id and first_name FROM patients WHERE their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id,first_name
FROM patients
WHERE first_name like 's%' and first_name like '%s' and len(first_name) >= 6

---4.	Show patient_id, first_name, last_name FROM patients whos diagnosis is 'Dementia'.
---Primary diagnosis is stored in the admissions table.
SELECT p.patient_id,p.first_name,p.last_name
FROM patients p 
join admissions a on p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia'

---5.	Display every patient's first_name.
---Order the list by the length of each name and then by alphabetically
SELECT first_name
FROM patients
ORDER BY  len(first_name) ,first_name

---6.	Show the total amount of male patients and the total amount of female patients in the patients table.
----Display the two results in the same row.
SELECT
SUM	(case when gender ='M' then 1 else 0 end	)AS male_COUNT,
SUM(case when gender ='F' then 1 else 0 end )as female_COUNT
FROM patients

---7.	Show first and last name, allergies FROM patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
SELECT first_name,last_name,allergies
FROM patients
WHERE allergies in ('Penicillin','Morphine')
ORDER BY allergies,first_name,last_name

---8.	Show patient_id, diagnosis FROM admissions. Find patients admitted multiple times for the same diagnosis.
SELECT f.patient_id,f.diagnosis
FROM(
SELECT patient_id,diagnosis
FROM admissions
GROUP BY patient_id,diagnosis
HAVING COUNT(*) > 1) f

---9.	Show the city and the total number of patients in the city.
---Order FROM most to least patients and then by city name ascending.
SELECT city,COUNT(*) as total_patient
FROM patients
GROUP BY city
ORDER BY total_patient desc , city asc

---10.	Show first name, last name and role of every person that is either patient or doctor.
---The roles are either "Patient" or "Doctor"
SELECT first_name,last_name,'Patient' AS role FROM patients
union all 
SELECT first_name,last_name,'Doctor' As role FROM doctors

---11.	Show all allergies ordered by popularity. Remove 'NKA' and NULL values FROM query.
SELECT allergies , COUNT(* ) as total_diagnosis
FROM patients
WHERE allergies is not null
GROUP BY allergies
ORDER BY total_diagnosis desc

---12.	Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting FROM the earliest birth_date.
SELECT first_name,last_name,birth_date
FROM patients
WHERE  YEAR(birth_date) between 1970 and 1979
ORDER BY birth_date

---13.	We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
---EX: SMITH,jane
SELECT concat(upper(last_name),',',lower(first_name)) AS new_name_format
FROM patients
ORDER BY first_name desc

---14.	Show the province_id(s), SUM of height; WHERE the total SUM of its patient's height is greater than or equal to 7,000.
SELECT province_id ,SUM(height)
FROM patients
GROUP BY province_id
HAVING SUM(height) >=7000

---15.	Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT (MAX(weight) - MIN(weight)) As weight_delta
FROM patients
WHERE last_name = 'Maroni'

---16.	Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT DAY(admission_date) as day_number,
COUNT(admission_date) as number_of_admission
FROM admissions
GROUP BY day_number
ORDER BY number_of_admission desc

---17.	Show the all columns for patient_id 542's most recent admission_date.
SELECT * 
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date desc
LIMIT 1

----- 18) Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
---1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
---2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT patient_id,attending_doctor_id,diagnosis
FROM admissions
WHERE (patient_id % 2 != 0  AND   attending_doctor_id IN (1,5,19))
	OR
    ( len(patient_id) = 3  AND attending_doctor_id like '%2%' )
    
---19) Show first_name, last_name, and the total number of admissions attended for each doctor.
-------Every admission has been attended by a doctor.
SELECT d.first_name,d.last_name,COUNT(a.patient_id) As TotalAdmission
FROM admissions a 
INNER JOIN doctors d ON d.doctor_id = a.attending_doctor_id
GROUP BY d.first_name,d.last_name


---20)For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT d.doctor_id,concat(d.first_name,' ',d.last_name) AS full_name,
	MIN(admission_date) As first_admission_date ,MAX(admission_date) AS last_admission_date
FROM admissions a 
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id


