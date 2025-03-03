# import duckdb

# # Connect to the DuckDB database
# conn = duckdb.connect(database='./dev.duckdb', read_only=False)

# # List of tables to query
# tables = [
#     "mart_daily_order_kpi_metrics",
#     "mart_fct_order_transactions",
#     "dim_customers",
#     "dim_products"
# ]

# # Loop through each table and export its data to a CSV file
# for table in tables:
#     query = f"SELECT * FROM {table}"
#     output_file = f"{table}.csv"
#     # Execute the query and save the result to a CSV file
#     conn.execute(query).df().to_csv(output_file, index=False)
#     print(f"Data exported to {output_file}")

# # Close the connection
# conn.close()

import duckdb

# Connect to the DuckDB database
conn = duckdb.connect(database='./dev.duckdb', read_only=True)

# Define the table name
table = "base_egames"

# Query to select the first 5 rows
query = f"SELECT * FROM stg_egames LIMIT 50"

# Execute the query and fetch the results
df = conn.execute(query).fetchdf()

# Print the result
print(df)

# Close the connection
conn.close()
