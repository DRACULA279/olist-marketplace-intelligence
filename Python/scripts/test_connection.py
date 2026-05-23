from sqlalchemy.exc import SQLAlchemyError

from db_connection import engine

try:

    with engine.connect() as connection:
        print("Database connection successful.")

except SQLAlchemyError as error:

    print("Database connection failed.")
    print(f"Reason: {error}")