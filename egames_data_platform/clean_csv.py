import pandas as pd

# Load the dataset (update the filename accordingly)
file_path = "risk.csv"  # Change this to your actual file path
df = pd.read_csv(file_path)

# Drop unnamed columns
df = df.loc[:, ~df.columns.str.contains('^Unnamed')]

# Standardize 'Domain' column
domain_mapping = {'.bet': 'bet', '.ca': 'ca', '.com': 'com', '888.com': '888'}
df['Domain'] = df['Domain'].map(domain_mapping)

# Clean 'Turnover' column
df['Turnover'] = df['Turnover'].replace({'\$': '', ',': '', 'USD': '', '\(': '-', '\)': ''}, regex=True).astype(float)

# Clean 'Profit' column
df['Profit'] = df['Profit'].replace({'\$': '', ',': '', '\(': '-', '\)': '', 'USD': ''}, regex=True).astype(float)

# Print preview of cleaned data
print(df.head())

# Save the cleaned data as UTF-8 encoded CSV
df.to_csv("cleaned_risk_data.csv", index=False, encoding='utf-8')
