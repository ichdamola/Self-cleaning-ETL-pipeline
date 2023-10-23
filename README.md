# Self-Cleaning ETL Pipeline

![Pipeline Logo](pipeline-logo.png)

## Overview

The Self-Cleaning ETL (Extract, Transform, Load) Pipeline is designed to automate the process of ingesting CSV files into an AWS S3 data lake and making the data available for querying in Amazon Athena. The system is set up to automatically delete the file in the S3 bucket and in Athena after a 24-hour retention period, ensuring data privacy and compliance with data retention policies.

## Table of Contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Scheduled Cleanup](#scheduled-cleanup)
- [Contributing](#contributing)
- [License](#license)

## Architecture

The architecture of the data pipeline consists of the following components:

1. **CSV Source:** The source CSV file(s) that need to be ingested into the data pipeline.

2. **AWS S3 Data Lake:** The destination S3 bucket where the CSV files will be stored.

3. **AWS Glue:** Used for data transformation and schema definition, allowing efficient querying in Athena.

4. **Amazon Athena:** Query service for running SQL queries against data stored in S3.

5. **Scheduled Lambda Function:** A Lambda function is used to schedule cleanup activities for both S3 and Athena.

## Prerequisites

Before setting up and using this data pipeline, ensure that you have the following prerequisites in place:

- An AWS account with the necessary IAM permissions for S3, Glue, Athena, and Lambda.
- AWS CLI configured with the required credentials.
- Python 3.x and the AWS SDK installed on your local machine for deployment.
- The source CSV file(s) to be ingested.

## Setup

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/ichdamola/Self-cleaning-ETL-pipeline.git
   cd Self-cleaning-ETL-pipeline
