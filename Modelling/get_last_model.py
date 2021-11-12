##########################################################################################################
################# Projeto para detecção de vendedores que podem deixar da base da Olist. #################
###################################### Etapa 4/5 Operacionalização ######################################
##########################################################################################################

# Este script irá gerar o Book de variáveis através da query_book_variaveis.sql, de posse do book de variáveis
# e do arquivo Pickle contendo o algoritmo otimizado na fase anterior realizará o score dos vendedores e 
# salvará na tabela tb_no_sells_score

# Pré-requisitos para execução do Script:
# * Arquivo Pickle gerado pelo notebook da fase anterior e salvo no mesmo diretório deste arquivo
# * Banco de dados salvo no diretório Data

# Caso queira ver um overview do projeto inteiro, entrar no meu GithubPages (https://thifujikawa.github.io/clientes_olist/) lá explico melhor todas as etapas do projeto.

#%%
#Carregando as bibliotecas

import os
import argparse
import pandas as pd
from pandas.core.algorithms import mode
import sqlalchemy
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.impute import SimpleImputer
from sklearn.ensemble import ExtraTreesClassifier

import matplotlib.pyplot as plt

#%%
parser = argparse.ArgumentParser(description="Insira as safras desejadas")
parser.add_argument("--safra", "-s", help= 'Data desejada do banco')
args = parser.parse_args()

data = args.data
#%%
dir_folder = os.path.dirname(os.path.abspath(__file__))
dir_project = os.path.dirname(dir_folder)
db_file = os.path.join(dir_project, 'Data/olist.db')
pickle_file = os.path.join(dir_project, 'Modelling/modelo_otimizado.pkl')


#%%
def import_file(path, *kwargs):
    with open(path , 'r') as file_open:
        result = file_open.read()
        return result

#%%
# Gerar as safras do book de variáveis que seriam os últimos 3 meses do banco
con = sqlalchemy.create_engine('sqlite:///' + db_file)

# Formatando  a query para gerar uma tabela no banco de dados SQL 
#data = '2018-04-01' # Apagar depois 
query = import_file(os.path.join(dir_project, "Query/query_book_variaveis.sql"))
query_formatada = query.format(safra=args['safra'])

# Criando a table SQL com os dados imputados
try:
    delete_table = "DROP TABLE tb_book_sellers"
    con.execute(delete_table)
except:
    print("Criando a tabela tb_book_sellers")

create_table = f"CREATE TABLE tb_book_sellers as\n {query_formatada}"
con.execute(create_table)

#%%

# Carregando o banco de dados e o arquivo Pickle
task = "SELECT * FROM tb_book_sellers"
dataset = pd.read_sql(task, con)
model  = pd.read_pickle(pickle_file)

# %%
# Carregando o algoritmo e o dataset para fazer o predict
pipe = model['pipeline_algoritmo']

X = dataset[model["features"]]
dataset["predict"] = pipe.predict_proba(X)[:,1]
# %%
output_dataset = dataset[['seller_id','predict']]
output_dataset.to_sql('tb_no_sells_score', con,  index=False, if_exists='replace')
print(f"Criado a tabela tb_no_sells_score na db {db_file} ")
