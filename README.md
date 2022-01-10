# IoT Trucking Apps from Lambda Architecture
### Course: Enterprise Architectures for Big Data

This project contains the two developed apps and a SQL query from a larger architecture comprised of Apache Nifi, Apache Kafka, and Apache Hive. The purpose of the project was to create a Lambda Architecute that would provide real-time and batch processing capabilities.

### Stream Processor App
This app consumes real-time data from two Kafka topics and then proceeds to join the two streams and filter specific fields. This app then works as a producer by sending the data to another topic in Kafka to be used by another app. This operation corresponds to the real-time processing. At the same time, this app is collecting the data received within a timeframe, and then when this timeframe expires, it performs grouping transformations and then inserts the aggregated data into Hive. This operation corresponds to the batch processing.  

### Calculation Query
This query selects all the data that was inserted in Hive by the Stream Processor App and performs some calculations, labeling, grouping, and joining, which then proceeds to insert into another Hive table. 

### Web App
This app was developed using Streamlit. On one side, it queries the Hive table that was created by the Calculation Query, does another calculation, and displays the results. On the other side, this app is consuming from the Kafka topic created by the Stream Processor App and displaying a live map and table that updates in real-time. 
