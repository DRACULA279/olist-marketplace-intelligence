import pandas as pd

from db_connection import engine

query = "SELECT * FROM orders LIMIT 5"

df = pd.read_sql(query, engine)

print(df.head())