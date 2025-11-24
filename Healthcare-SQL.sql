USE hospital;

select * from appointments;
select * from patients;

#Adding new records
INSERT INTO patients values('P101', "Chris Johnson",54,"Male","20-08-2024");
DELETE FROM patients where Patient_ID = "P100" and patient_name = "Chris Johnson";

SET SQL_safe_updates = 0;

# Making updates
UPDATE appointments set appointment_date = "15-09-2024" where appointment_ID = "A003";

# Retreive patient details with their alloted doctors and appointment date
select p.patient_name, a.doctor_name, a.Appointment_Date from patients as p 
INNER JOIN appointments as a on p.patient_ID = a.patient_ID;

# Retreiving appointments of patients with no registered name
select a.appointment_ID, p.patient_name from appointments as a RIGHT JOIN patients as p
on a.patient_ID = p.patient_ID where p.patient_ID IS NULL;

# Finding total number of male and female patients
select gender, count(gender) from patients group by gender;

# List of Distinct doctors and distinct patients
select DISTINCT doctor_name, 'Doctor' as Role from appointments 
UNION
select DISTINCT patient_name, 'Patient' as Role from patients;

# Details of oldest patient
select patient_name, age from patients order by age desc LIMIT 1;

select * from appointments where doctor_name = 'Matthew Russell';

# Update department of doctor Matthew Russell
UPDATE appointments set department = "Radiology" where doctor_name = "Matthew Russell"

# Doctor with most number of appointments
select doctor_name, COUNT(appointment_ID) as Appointment_count from appointments 
group by doctor_name order by Appointment_count desc LIMIT 1;

UPDATE appointments set doctor_name = "Joshua Peter" where patient_ID = "P045";

# Pateints who have appointment in more than one department
select patients.patient_name, COUNT(Appointment_ID) as Appointment_count from patients 
INNER JOIN appointments on patients.Patient_ID = appointments.patient_ID group by 
patient_name order by Appointment_count desc LIMIT 1;

# Patients with no appointments
select patients.patient_name from patients INNER JOIN appointments on 
patients.patient_ID = appointments.patient_ID where appointments.appointment_ID IS NULL;

# Average age of patient for each department
select a.department, AVG(age) as Average_age from appointments as a INNER JOIN patients as p on
a.patient_ID = p.patient_ID group by department order by Average_age desc;

#The percentage of total appointments handled by each doctor
SELECT Doctor_Name, COUNT(Appointment_ID) AS Doctor_Appointments, 
ROUND((COUNT(Appointment_ID) * 100.0 / SUM(COUNT(Appointment_ID)) OVER ()), 2) 
AS Appointment_Percentage FROM
    appointments
GROUP BY
    Doctor_Name
ORDER BY
    Appointment_Percentage DESC;