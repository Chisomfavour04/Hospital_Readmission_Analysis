SELECT *
FROM readmissions;

CREATE TABLE readmissions_chart
LIKE readmissions;

SELECT *
FROM readmissions_chart;

INSERT readmissions_chart
SELECT *
FROM readmissions;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY age, time_in_hospital, n_lab_procedures, n_procedures,n_medications,
n_outpatient, n_inpatient, n_emergency, medical_specialty, diag_1, diag_2, diag_3, glucose_test, A1Ctest, diabetes_med, readmitted) AS row_num
FROM readmissions_chart;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY age, time_in_hospital, n_lab_procedures, n_procedures,n_medications,
n_outpatient, n_inpatient, n_emergency, medical_specialty, diag_1, diag_2, diag_3,
glucose_test, A1Ctest, diabetes_med, readmitted) AS row_num
FROM readmissions_chart
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



CREATE TABLE `readmissions_chart2` (
  `age` text,
  `time_in_hospital` int DEFAULT NULL,
  `n_lab_procedures` int DEFAULT NULL,
  `n_procedures` int DEFAULT NULL,
  `n_medications` int DEFAULT NULL,
  `n_outpatient` int DEFAULT NULL,
  `n_inpatient` int DEFAULT NULL,
  `n_emergency` int DEFAULT NULL,
  `medical_specialty` text,
  `diag_1` text,
  `diag_2` text,
  `diag_3` text,
  `glucose_test` text,
  `A1Ctest` text,
  `change` text,
  `diabetes_med` text,
  `readmitted` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM readmissions_chart2
WHERE row_num > 1;

INSERT INTO readmissions_chart2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY age, time_in_hospital, n_lab_procedures, n_procedures,n_medications,
n_outpatient, n_inpatient, n_emergency, medical_specialty, diag_1, diag_2, diag_3,
glucose_test, A1Ctest, diabetes_med, readmitted) AS row_num
FROM readmissions_chart;

DELETE
FROM readmissions_chart2
WHERE row_num > 1;

SELECT *
FROM readmissions_chart2; 

SELECT medical_specialty,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY medical_specialty
ORDER BY medical_specialty;

CREATE TABLE specialty_summary AS
SELECT medical_specialty,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY medical_specialty
ORDER BY medical_specialty;

CREATE TABLE age_summary AS
SELECT age,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY age
ORDER BY readmission_rate DESC;

SELECT age,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY age
ORDER BY readmission_rate DESC;

SELECT *
FROM readmissions_chart2; 

CREATE TABLE time_in_hospital_summary AS 
SELECT time_in_hospital,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) / COUNT(*)*100, 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY time_in_hospital
ORDER BY time_in_hospital;

CREATE TABLE diagnosis_summary AS
SELECT diagnosis,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) / COUNT(*)*100, 2) AS readmission_rate
FROM(
SELECT diag_1 AS diagnosis, readmitted FROM readmissions_chart2
UNION ALL
SELECT diag_2, readmitted FROM readmissions_chart2
UNION ALL
SELECT diag_3, readmitted FROM readmissions_chart2
) AS combined
GROUP BY diagnosis
ORDER BY readmission_rate DESC
LIMIT 10;

CREATE TABLE diagnosis_specialty_summary AS
SELECT diagnosis, medical_specialty,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) / COUNT(*)*100, 2) AS readmission_rate
FROM(
SELECT diag_1 AS diagnosis, medical_specialty, readmitted FROM readmissions_chart2
UNION ALL
SELECT diag_2, medical_specialty, readmitted FROM readmissions_chart2
UNION ALL
SELECT diag_3, medical_specialty, readmitted FROM readmissions_chart2
) AS combined
GROUP BY diagnosis, medical_specialty
ORDER BY readmission_rate DESC
LIMIT 10;

CREATE TABLE A1Ctest_summary AS
SELECT A1Ctest,
COUNT(*) AS total_patient,
SUM(CASE
		WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) AS readmitted_count,
ROUND(SUM(CASE
			WHEN readmitted = 'Yes' THEN 1 ELSE 0
END) / COUNT(*)*100, 2) AS readmission_rate
FROM readmissions_chart2
GROUP BY A1Ctest
ORDER BY readmission_rate DESC;

