# Hospital_Readmission-_Analysis
A MySQL data analysis project examining how age, diagnosis, medical specialty and A1C tests influences hospital readmission rates.

# 🏥 Hospital Readmission Chart (MySQL Project)

## 📘 Project Overview
This project explores hospital readmission patterns among patients using MySQL.  
The goal is to identify key factors influencing readmission rates such as age, length of hospital stay, medical specialty, diagnosis, and A1C test results.  
All analyses were performed entirely in SQL.

---

## 🧾 Dataset Information
The dataset was obtained from **Kaggle** and contains patient-level information related to hospital visits and diabetes management.  

**Key Columns Include:**
- `age`
- `time_in_hospital`
- `num_lab_procedures`
- `num_procedures`
- `num_medications`
- `number_outpatient`
- `number_inpatient`
- `number_emergency`
- `medical_specialty`
- `diagnosis_1`, `diagnosis_2`, `diagnosis_3`
- `A1Cresult`
- `change`
- `diabetesMed`
- `readmitted`

---

## ⚙️ Tools Used
- **MySQL** – for data cleaning, aggregation, and analysis.

---

## 🧠 Analyses Performed

### 1️⃣ Age-Based Readmission Analysis
- Examined readmission rates across patient age groups.  
- Patients who stayed **7–10 days** had the **highest readmission rate (≈50.9%)**, while those who stayed **11–14 days** or **1–6 days** showed lower readmission rates.

### 2️⃣ Medical Specialty Analysis
- Identified which medical specialty had the highest readmission counts and rates.  
- Certain specialties recorded **higher patient volumes and readmissions**, highlighting potential areas for clinical review.

### 3️⃣ Diagnosis-Based Readmission Analysis
- Combined `diagnosis_1`, `diagnosis_2`, and `diagnosis_3` to study overall diagnosis patterns.  
- **“Others”** category recorded the **highest total patients and readmitted count**, while **respiratory-related diagnoses** showed the **highest readmission rate**.  
- The **“Missing”** group had the **lowest totals** and readmission rates.

### 4️⃣ Diagnosis + Medical Specialty Joint Analysis
- Merged diagnosis data with medical specialty to uncover overlaps.  
- **Respiratory** and **Missing** categories dominated in both **total patients** and **readmitted counts**, while **Respiratory** and **Other** showed the **highest readmission rates**.  
- **Musculoskeletal** and **Cardiology** specialties recorded the **lowest total patients and readmissions**, and **Respiratory** along with **Family/General Practice** had the **lowest readmission rates**.

### 5️⃣ A1C Test Analysis
- Analyzed the relationship between A1C testing and readmission.  
- Patients with **no A1C test (“No”)** had the **highest total patients, readmission count, and rate**.  
- Patients with **normal A1C results** had the **lowest values across all metrics**, suggesting that consistent A1C monitoring supports better disease control and lower readmissions.

---

## 📊 Key Insights
- **Length of Stay:** 7–10-day stays are most strongly associated with higher readmission rates.  
- **Medical Specialty:** Some specialties experience higher readmissions, indicating potential care or discharge planning gaps.  
- **Diagnosis:** Respiratory conditions are a major driver of readmissions.  
- **A1C Testing:** Regular A1C monitoring may significantly reduce readmission rates.  

---

## 🏁 Conclusion
This analysis highlights critical factors influencing hospital readmissions.  
By focusing on **length of stay**, **specialty-specific interventions**, and **consistent diabetes monitoring**, healthcare facilities can design targeted strategies to improve patient outcomes and reduce readmission rates.

---
