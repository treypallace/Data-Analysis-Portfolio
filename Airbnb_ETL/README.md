# Project Description.
This project demonstrates how data can be extracted from various source systems (structured, semi-structured, unstructured), transformed (cleansed, integrated), and then loaded into a destination system that’s optimized for post hoc diagnostic analysis. This project combines data from a sample MongoDB database, the World Bank API, and a Kaggle dataset.

To receate the project, you will need to alter the following variable definitions in the Jupyter notebook named "etl_airbnb.ipynb" to connect to your MySQL server. 

host_name = "127.0.0.1"  

user_id = "root"  

pwd = "mysqlpwd"  

Then run the notebook. This will create and populate a database named 'airbnb'. To test the functionality of the database, run the SQL file named "date_dim.sql". 

## Language and Programs
* SQL (MySQL)
* Python
* Jupyter Notebook
