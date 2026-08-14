import pandas as pd

# Load dataset
df = pd.read_csv("Cleaned_Dataset/Telco_Customer_Churn_Cleaned.csv")

# First 5 rows
print("First 5 Rows:")
print(df.head())

# Dataset shape
print("\nDataset Shape:")
print(df.shape)

# Column names
print("\nColumn Names:")
print(df.columns.tolist())

# Dataset info
print("\nDataset Info:")
print(df.info())

# Missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Duplicate rows
print("\nDuplicate Rows:")
print(df.duplicated().sum())

# Basic statistics
print("\nBasic Statistics:")
print(df.describe())