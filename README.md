# Superstore Data Warehouse & Power BI Analytics Project
## Overview

This project demonstrates the design and implementation of a data warehouse and analytical reporting solution using the [Superstore dataset.](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
The project simulates a real-world ETL pipeline with incremental data loads, implements Slowly Changing Dimensions (SCD Type 1 & Type 2), and builds a Power BI analytical report on top of a dimensional data mart.

The architecture follows a three-layer data warehouse design:

* **Stage Layer** – Raw data ingestion

* **Core Layer** – Normalized relational model (3NF)

* **Mart Layer** – Denormalized star schema optimized for analytics  

The final data model powers an interactive Power BI dashboard with advanced analytics and security features.

---
## Project Architecture

```
Source Files
     │
     ▼
Stage Layer (Raw Data)
     │
     ▼
Core Layer (3NF Normalized Model)
     │
     ▼
Mart Layer (Star Schema)
     │
     ▼
Power BI Reports
```
---
## Dataset Preparation
### Splitting the Dataset

To simulate incremental ETL loads, the original dataset was divided into two parts.

**1. Initial Load**

The Initial Load represents the first full snapshot of the dataset and includes all original records such as:

* Orders

* Customers

* Products

* Sales transactions

This dataset populates the warehouse during the initial ETL run.

**2. Secondary Load**

The Secondary Load simulates real-world data updates and contains a mix of:

- New Records

- New rows that did not exist in the initial dataset and should be inserted.

- Modified Records

Two types of changes are simulated:

SCD Type 1 (Overwrite Changes)
Example:

1. Customer name corrections

2. Minor attribute updates

SCD Type 2 (Historical Changes)
Example:

1. Customer moves to a different region

2. New record version is inserted with:


## Graphics

### A view of raw table and model
![](screenshots/table.png)  

![](screenshots/model.png)

### Report
![](screenshots/tab1.png)

![](screenshots/tab2.png)

![](screenshots/tab3.png)

### Role Level Security
#### There's two roles we have got here; region_west where only that region is visible & segment_corporate only can see corporate data.
![](screenshots/rls.png)

## Tools & Technologies

- SQL (ETL development)

- Data Warehouse Modeling

- Power BI

- DAX

- Star Schema Modeling

- Slowly Changing Dimensions (SCD)

