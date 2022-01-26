##########################################################################################################
################# Projeto para detecção de vendedores que podem deixar da base da Olist. #################
########### Etapa 2/5 ETL Extraction Transform Load - Geração da ABT (Analytical Base Table ) ###########
##########################################################################################################

# Nesta etapa o Script recebe a Data Final da primeira safra e em seguida quantas Safras serão geradas, 
# lembrando que 1 Safra agrupa os dados de 6 meses do vendedor e a variável resposta se baseia se após a data final da safra os 3 meses seguintes houve vendas
# Ao inserir os dados de data e a quantidade de safras o mesmo irá executar a query (query_abt.sql)
# Para mais detalhes das variáveis criadas consultar a query
# Ao executar a query todos os dados serão enviados para a tabela tb_abt_no_sells criando a ABT
# Caso queira ver um overview do projeto inteiro, entrar no meu GithubPages (https://thifujikawa.github.io/clientes_olist/) lá explico melhor todas as etapas.

#%%
# Carregando as bibliotecas

import os 
import argparse
import sqlalchemy

# %%
# Realizando a chamada do argparse para carregar as datas desejadas

parser = argparse.ArgumentParser(description= "Input das safras e intervalo")

parser.add_argument("--safra", "-s", help= 'Safra deve receber a data no formato YYYY-MM-DD', required= True)
parser.add_argument("--qtde", "-i", help= 'Quantidade de safras', type=int, required= True)

args = parser.parse_args()

safra = args.safra
qtde_safra = args.int
# %%
# Carregando o path do banco de dados
folder_file = os.path.dirname(os.path.abspath('__file__'))
folder_project = os.path.dirname(folder_file) 
db_address = os.path.join(folder_project,'Data/olist.db') 
# Carregando o path da query
db_sql = os.path.join(folder_project,'Query') 
#%%
# Conexão com o banco de dados
con = sqlalchemy.create_engine('sqlite:///'+ db_address)
#%%
def import_file(path, *kwargs):
    with open(path , 'r') as file_open:
        result = file_open.read()
        return result

# Retorna uma lista com datas incrementando um mes por vez.
def gera_safras(data, qtde):
    mes = int(data[5:7])
    ano = int(data[0:4])
    dia = int(data[8:10])
    lista_safras = [data]

    for i in range(qtde-1):
        if mes < 12:
            mes += 1
        else:
            mes = 1
            ano += 1
        lista_safras.append(f'{ano}-{mes:02}-{dia:02}')
    return lista_safras
# %%
safra = '2017-04-01' # Ao Ativar o argparse deverá ser retirado
qtde_safra = 14 # Ao Ativar o argparse deverá ser retirado

query = import_file(os.path.join(db_sql,"query_abt.sql")) # Transforma a query em string
safras_geradas = gera_safras(safra,qtde_safra) #Gera as safras


creation_table = "CREATE TABLE IF NOT EXISTS tb_abt_no_sells as \n{chamada_query}"
query_formatada = query.format(safra=safras_geradas[0])
con.execute(creation_table.format(chamada_query=query_formatada))


for data in safras_geradas:
    query_formatada = query.format(safra=data)
    # Caso a safra já estiver sido criada 
    print(f'Processando a data de {data} na tabela tb_abt_no_sells')
    con.execute("DELETE FROM tb_abt_no_sells WHERE data_lim_safra = '{safra}'".format(safra=data))
    base_query = "INSERT INTO tb_abt_no_sells\n {query}"
    con.execute(base_query.format(query=query_formatada))