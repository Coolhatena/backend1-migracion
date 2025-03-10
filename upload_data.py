import pandas as pd
import pymysql
import time
import math

# Configuración de MySQL
HOST = "10.4.8.40"
USER = "lalo"
PASSWORD = ""
DATABASE = "lalo_inegi"
TABLE = "tablename" # Edit on every execution

csv_file = "archivo_grande.csv"
df = pd.read_csv(csv_file)

# Divide total data in chunks
num_chunks = 8
chunk_size = math.ceil(len(df) / num_chunks)

conn = pymysql.connect(host=HOST, user=USER, password=PASSWORD, database=DATABASE)
cursor = conn.cursor()

# Insert chunk in database, in smaller chunks of 1000 registers
def insert_batch(data_chunk):
    batch_size = 1000
    for i in range(0, len(data_chunk), batch_size):
        batch = data_chunk.iloc[i:i+batch_size]
        values = ",".join([f"({','.join(map(repr, row))})" for row in batch.values])
        query = f"INSERT INTO {TABLE} VALUES {values}"
        cursor.execute(query)
        conn.commit()
        print(f"Insertados {len(batch)} registros...")

# Insert chunk and wait 5 min
for i in range(num_chunks):
    start = i * chunk_size
    end = min((i + 1) * chunk_size, len(df))
    chunk = df.iloc[start:end]
    
    print(f"\nInsertando chunk {i+1}/{num_chunks} con {len(chunk)} registros...")
    insert_batch(chunk)

    if i < num_chunks - 1:
        mins = 5
        print(f"Esperando {mins} minutos antes del próximo envío...")
        time.sleep(60 * mins)  # 60 seconds * min

conn.close()
print("\nSubida de datos completada.")
