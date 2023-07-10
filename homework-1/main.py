"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv

conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="arseniitelesh",
    password="1408",
)

cur = conn.cursor()

# EMPLOYEES #
with open('north_data/employees_data.csv', 'r') as f:
    csv_reader = csv.reader(f)

    insert_query = f"INSERT INTO employees VALUES ({','.join(['%s'] * len(next(csv_reader)))})"

    for row in csv_reader:
        cur.execute(insert_query, row)

    conn.commit()

# CUSTOMERS #
with open('north_data/customers_data.csv', 'r') as f:
    csv_reader = csv.reader(f)

    insert_query = f"INSERT INTO customers VALUES ({','.join(['%s'] * len(next(csv_reader)))})"

    for row in csv_reader:
        cur.execute(insert_query, row)

    conn.commit()

# ORDERS #
with open('north_data/orders_data.csv', 'r') as f:
    csv_reader = csv.reader(f)

    insert_query = f"INSERT INTO orders VALUES ({','.join(['%s'] * len(next(csv_reader)))})"

    for row in csv_reader:
        cur.execute(insert_query, row)

    conn.commit()

cur.close()
conn.close()
