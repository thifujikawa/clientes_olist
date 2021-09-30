
#%%
# Carregando as bibliotecas

import os 
import argparse
import sqlalchemy
from sqlalchemy.engine import base


# %%
# Realizando a chamada do argparse para carregar as datas desejadas

parser = argparse.ArgumentParser(description= "Input das safras e intervalo")

parser.add_argument("--safra", "-s", help= 'safra deve receber a data no formato YYYY-MM-DD', required= True)
parser.add_argument("--qtde", "-i", help= 'Quantidade de safras', type=int, required= True)

args = parser.parse_args()

safra = args.safra
qtde_safra = args.int
# %%
# Carregando o path do banco de dados
folder_file = os.path.dirname(os.path.abspath('__file__'))  #Folder file path
folder_project = os.path.dirname(folder_file) # Project path
db_address = os.path.join(folder_project,'Data/olist.db') #db_address
db_sql = os.path.join(folder_project,'Query') #folder_sql
#%%
# Conexão com o banco de dados
con = sqlalchemy.create_engine('sqlite:///'+ db_address)
#%%
def import_file(path, *kwargs):
    with open(path , 'r') as file_open:
        result = file_open.read()
        return result


def gera_safras(data, qtde):
    mes = int(data[5:7])
    ano = int(data[0:4])
    dia = int(data[8:10])
    lista_safras = [data]

    for i in range(qtde-1):
        if mes < 12:
            mes +=1
        else:
            mes = 1
            ano += 1
        lista_safras.append(f'{ano}-{mes:02}-{dia:02}')
    return lista_safras
# %%
safra = '2017-04-01' # Erase later
qtde_safra = 14 # Erase later

query = import_file(os.path.join(db_sql,"query_abt_churn.sql"))
safras_geradas = gera_safras(safra,qtde_safra)


creation_table = "CREATE TABLE IF NOT EXISTS tb_abt_churn as \n{chamada_query}"
query_formatada = query.format(safra=safras_geradas[0])
con.execute(creation_table.format(chamada_query=query_formatada))


for data in safras_geradas:
    query_formatada = query.format(safra=data)
    # Caso a safra ja estiver sido criada 
    print(f'Verifying if the date {data} already exists in the Database')
    con.execute("DELETE FROM tb_abt_churn WHERE data_lim_safra = '{safra}'".format(safra=data))
    base_query = "INSERT INTO tb_abt_churn\n {query}"
    con.execute(base_query.format(query=query_formatada))



