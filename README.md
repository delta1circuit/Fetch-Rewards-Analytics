# Fetch_Analytics

This comprehensive data analysis project is focused on extracting, cleaning, and analyzing datasets from Fetch Rewards. The project utilizes three main JSON datasets: users, brands, and receipts, each offering unique insights and challenges. Through meticulous data cleaning and exploratory data analysis conducted in Python, the project aims to create actionable insights and facilitate data-driven decisions. Key components of the project include identifying duplicate entries, standardizing data types, and reformatting datasets for optimal use in PostgreSQL databases. Additionally, the project features a series of SQL queries that address specific business questions, enhancing our understanding of user behavior and brand performance within the Fetch Rewards platform. The final outputs are designed to support strategic business decisions by highlighting spending patterns, brand popularity, and transaction trends.

# Data Cleaning  
This repository contains three JSON files with data related to users, receipts, and brands on Fetch Rewards. The Python notebook provides a detailed exploration and analysis (EDA), while this section offers an overview of that process.

* Users
  
The user data is relatively straightforward, comprising a unique user ID for each individual, along with other details such as location and account creation date.

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/58fce4fc-5fc6-4c76-bdbb-716e6f1bba48)

However, the data is not pristine. An initial examination revealed 283 duplicate rows, which were subsequently removed. Additionally, inconsistencies in data types required standardization to ensure compatibility with PostgreSQL. The user ID was identified as the primary key.

* Brands
  
The second JSON file pertains to the brands dataset, which is separate from the user data. It contains information about various brands and their products.

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/c0289cd7-ee3e-485c-aa7f-e6cb1ef02b0e)

Here, the brand ID serves as the primary key. Each brand ID is linked to a specific barcode, offering a potential pair of primary keys, though this was deemed unnecessary for this analysis. This dataset also contained errors and non-standard characters that were incompatible with SQL, necessitating thorough cleaning.

* Receipts

The receipts JSON is the most complex dataset, incorporating another compressed JSON.

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/e1aaa5f1-c3e9-4907-933c-8648ed61d1ac)

Cleaning this data involved not only standardizing its format but also attaching unique identifiers to the internal JSON. I expanded this internal JSON to create a new dataframe called the Item List dataframe, which details each item on the receipts, each identified by a primary key. This restructuring was aimed at simplifying queries and enhancing data readability.

# Making the relational schema

Following the data cleaning, I designed a new schema to streamline the workflow. This schema structure enhances data integrity and query efficiency, serving as a robust foundation for analyzing transactions and interactions within the Fetch Rewards ecosystem.

![Schema](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/943e25c4-6824-4823-9262-4692aabccfb1)

# Queries

While each SQL query is thoroughly commented within the SQL file, this section provides a summary of key outputs available in the outputs folder.

* What are the top 5 brands by receipts scanned for the nmost recent month?

The latest data was from January 2021. 

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/b2a06323-4220-464b-bd29-57c6c0f4d988)

* When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/9d53cf53-4687-4c18-8d8d-d3bacd3e82c0)

* When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/2f2118a0-8e85-496b-b4bc-6da705a2e6a3)

* Which brand has the most spend among users who were created within the past 6 months?

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/c0a7ad29-b2a4-4ebb-b2ca-93db08979869)

* Which brand has the most transactions among users who were created within the past 6 months?

![image](https://github.com/delta1circuit/Fetch_Analytics/assets/63530749/f1e91699-09ca-40c8-baec-662d6fbe5dfd)

An email explaining the findings to the business stakeholder has also been drafted. 

Completing the project demanded a high level of expertise across several areas. It required in-depth knowledge of data extraction techniques to accurately retrieve and clean data from complex JSON structures. The project also called for proficiency in various analytical platforms, such as Python for data processing and PostgreSQL for database management, ensuring seamless integration and manipulation of large datasets. Moreover, a strong command over data analysis and the ability to craft compelling data narratives were crucial. These skills combined allowed for the transformation of raw data into insightful, actionable information, effectively communicating the value and patterns found within the Fetch Rewards data.





