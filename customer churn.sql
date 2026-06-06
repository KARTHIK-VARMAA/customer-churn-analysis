create database customer_churn;
use customer_churn;
CREATE TABLE churn_data(
customerID VARCHAR(50),
gender VARCHAR(20),
SeniorCitizen INT,
Partner VARCHAR(10),
Dependents VARCHAR(10),
tenure INT,
PhoneService VARCHAR(10),
MultipleLines VARCHAR(30),
InternetService VARCHAR(30),
OnlineSecurity VARCHAR(30),
OnlineBackup VARCHAR(30),
DeviceProtection VARCHAR(30),
TechSupport VARCHAR(30),
StreamingTV VARCHAR(30),
StreamingMovies VARCHAR(30),
Contract VARCHAR(30),
PaperlessBilling VARCHAR(10),
PaymentMethod VARCHAR(50),
MonthlyCharges DECIMAL(10,2),
TotalCharges VARCHAR(50),
Churn VARCHAR(10)
);
select count(*)
from churn_data;
-- null values checking
select *
from churn_data
where customerId is null;

select *
from churn_data
where gender is null;

select *
from churn_data
where seniorCitizen is null;

-- duplicates
select customerId,count(*)
from churn_data
group by customerId
having count(*)>1;

select COUNT(*)
from churn_data
where TotalCharges = '';

-- analysis
-- Overall Churn Rate
select Churn,count(1) as customers
from churn_data
group by Churn;

-- churn by contract
SELECT
    Contract,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churn_data
GROUP BY Contract;

-- tenure analysis
SELECT
CASE
WHEN tenure <= 12 THEN '0-12 Months'
WHEN tenure <= 24 THEN '13-24 Months'
WHEN tenure <= 48 THEN '25-48 Months'
ELSE '49+ Months'
END AS tenure_group,
COUNT(*) AS customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churn_data
GROUP BY tenure_group;

-- payment analysis
SELECT
    PaymentMethod,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churn_data
GROUP BY PaymentMethod
ORDER BY churned_customers DESC;

-- internet analysis
SELECT
    InternetService,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churn_data
GROUP BY InternetService;

-- customer analysis 
SELECT
    SeniorCitizen,
    COUNT(*) AS customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM churn_data
GROUP BY SeniorCitizen;


