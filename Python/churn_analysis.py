import pandas as pd

# Load dataset
df = pd.read_csv("Cleaned_Dataset/Telco_Customer_Churn_Cleaned.csv")

# Total customers
total_customers = len(df)

# Churned customers
churned_customers = (df["Churn Label"] == "Yes").sum()

# Retained customers
retained_customers = (df["Churn Label"] == "No").sum()

# Churn rate
churn_rate = (churned_customers / total_customers) * 100

print("Total Customers:", total_customers)
print("Churned Customers:", churned_customers)
print("Retained Customers:", retained_customers)
print("Churn Rate:", round(churn_rate, 2), "%")

# Contract-wise churn analysis

contract_churn = pd.crosstab(
    df["Contract"],
    df["Churn Label"],
    normalize="index"
) * 100

print("\nContract-wise Churn Rate:")
print(contract_churn.round(2))

# Payment method-wise churn analysis

payment_churn = pd.crosstab(
    df["Payment Method"],
    df["Churn Label"],
    normalize="index"
) * 100

print("\nPayment Method-wise Churn Rate:")
print(payment_churn.round(2))

# Create tenure groups

df["Tenure Group"] = pd.cut(
    df["Tenure Months"],
    bins=[-1, 12, 24, 48, 72],
    labels=["0-12 Months", "13-24 Months", "25-48 Months", "49-72 Months"]
)

# Tenure-wise churn analysis

tenure_churn = pd.crosstab(
    df["Tenure Group"],
    df["Churn Label"],
    normalize="index"
) * 100

print("\nTenure-wise Churn Rate:")
print(tenure_churn.round(2))

# Monthly Charges groups

df["Monthly Charges Group"] = pd.cut(
    df["Monthly Charges"],
    bins=[0, 30, 60, 90, 120],
    labels=["$0-$30", "$30-$60", "$60-$90", "$90-$120"]
)

# Monthly Charges-wise churn analysis

charges_churn = pd.crosstab(
    df["Monthly Charges Group"],
    df["Churn Label"],
    normalize="index"
) * 100

print("\nMonthly Charges-wise Churn Rate:")
print(charges_churn.round(2))

# Internet Service-wise churn analysis

internet_churn = pd.crosstab(
    df["Internet Service"],
    df["Churn Label"],
    normalize="index"
) * 100

print("\nInternet Service-wise Churn Rate:")
print(internet_churn.round(2))

# Churn reason analysis

churn_reasons = df[df["Churn Label"] == "Yes"]["Churn Reason"].value_counts()

print("\nTop Churn Reasons:")
print(churn_reasons)

churn_reason_percentage = (
    df[df["Churn Label"] == "Yes"]["Churn Reason"]
    .value_counts(normalize=True) * 100
)

print("\nChurn Reason Percentage:")
print(churn_reason_percentage.round(2))