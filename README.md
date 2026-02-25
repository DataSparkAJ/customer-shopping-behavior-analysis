# 🛍️ Customer Shopping Behavior Analysis

## 📌 Project Overview

This project analyzes customer shopping behavior using a transactional retail dataset containing **3,900 customer records**.  

The objective was to identify:

- Revenue drivers  
- Customer purchasing patterns  
- Subscription impact  
- Product performance  
- Customer segmentation insights  

The project demonstrates an **end-to-end analytics workflow** using Python, MySQL, and Power BI.

---

## 🛠️ Tools & Technologies Used

- **Python (Pandas)** – Data Cleaning & Feature Engineering  
- **MySQL** – Business Analysis (CTEs, Window Functions, Aggregations)  
- **Power BI** – Interactive Dashboard & KPI Visualization  

---

## 📊 Key Insights

- 💰 **Total Revenue:** $233K  
- 👥 **Total Customers:** 3,900  
- 🛒 **Average Order Value:** $59.76  
- 🏷️ Clothing is the highest revenue-generating category  
- 📦 Top products include Blouse, Shirt, and Dress  
- 📈 Top 20% of customers contribute **32.54%** of total revenue (balanced distribution, no strong 80/20 pattern)  
- 🎯 Certain products show high discount dependency (~50%)  

---

## 🧹 Data Cleaning & Feature Engineering (Python)

Key steps performed:

- Checked data structure and missing values  
- Imputed missing *Review Rating* using category-wise median  
- Standardized column names to snake_case  
- Created `age_group` using quartile-based segmentation  
- Converted purchase frequency into numerical format (`purchase_frequency_days`)  
- Removed redundant columns  

---

## 🗄️ SQL Business Analysis

Structured SQL queries were used to answer key business questions:

- Revenue distribution by gender and age group  
- Subscription vs non-subscription revenue comparison  
- Top 5 products by average rating  
- Top 3 products per category (using `ROW_NUMBER()` and `PARTITION BY`)  
- Discount-dependent products  
- Customer segmentation (New / Returning / Loyal)  
- Pareto analysis using window functions  

Advanced techniques used:
- Common Table Expressions (CTEs)  
- Window Functions (`OVER()`, `ROW_NUMBER()`)  
- Revenue contribution percentage calculations  

---

## 📊 Power BI Dashboard

An interactive dashboard was developed to visualize:

- KPI summary (Revenue, Customers, AOV)  
- Revenue by Category  
- Revenue by Subscription Status  
- Subscription Distribution  
- Top 5 Products by Revenue  

📷 *Dashboard preview included in repository.*

---

## 💡 Business Recommendations

- Strengthen subscription benefits to increase adoption  
- Prioritize high-performing categories such as Clothing  
- Promote top revenue-driving products in marketing campaigns  
- Evaluate discount-heavy products to protect margins  
- Focus on broad customer engagement due to balanced revenue distribution  

---

## 📁 Repository Contents

- `data_cleaning.ipynb` → Python data preparation  
- `business_analysis_queries.sql` → SQL queries  
- `Retail_Dashboard.pbix` → Power BI dashboard file  
- `Customer_Shopping_Behavior_Report.pdf` → Full project report  
- `Customer_Shopping_Behavior_Presentation.pdf` → Presentation slides  
- `cleaned_retail_data.csv` → Cleaned dataset  

---

## 🎯 Project Outcome

This project showcases practical data analytics skills, including:

- Data preprocessing  
- Business-focused SQL analysis  
- Revenue segmentation  
- Analytical thinking  
- Dashboard storytelling  

---

## 👤 Author

Aspiring Data Analyst  
Focused on building data-driven insights using Python, SQL, and Power BI.
