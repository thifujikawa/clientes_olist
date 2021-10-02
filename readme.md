# Detecção de clientes que não realizarão vendas na Olist

## Descrição do Projeto

Utilizando Data Science e o Banco de dados da Olist, elaborei um projeto onde pode-se realizar uma Extração do banco de dados trata-los para em seguida realizar alguns algoritmos de machine Learning afim de encontrar clientes que tendem a não realizar vendas na plataforma da Olist. Assim determinadas ações podem ser realizadas afim de auxiliar este vendedor

## Tabela de conteúdos

* [Sobre](#sobre)
* [Tabela de Conteúdo](#tabela_de_conteudo)
* [Instalação](#instalacao)
* [Como Usar](#como_usar)
    * [Pre Requisitos](#pre-requisitos)
    * [Local Files](#local-files)
    * [Remote Files](#remote-files)
* [Tests](#testes)
* [Tecnologias](#tecnologias)


## Status do Projeto
<h4 align="center">
    🚧 Em construção... 🚧

### Features
- [x] Envio do Projeto para o Github
- [ ] Passar o modelling para notebook
- [ ] Terminar o texto para o Github Pages
- [ ] Alterar a Tabela  tb_abt_sellers, tb_churn_score para tb_sell_score


## Como Usar <a name="como_usar"></a>

### Pré Requisitos <a name="pre-requisitos"></a>
Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
- [Git]
- [Python]
- [SQL]

### Local Files <a name="local-files"></a>
* Realizar o Download do repositório e do banco de dados conforme as instruções abaixo:
    1. git clone https://github.com/thifujikawa/clientes_olist.git
    2. Efetuar o Download do Banco de dados da Olist O banco de dados deve estar salvo no diretório Data

* Instalar as bibliotecas:
    1. No Repositório o arquivo requirements.txt possui todas as bibliotecas necessárias para o projeto.

* Utilização dos programas:
    * Programa gerador de scores da base ativa:
        1. Executar o arquivo get_the_last_model.py, Este programa irá gerar as safras e em seguida coleta do arquivo Pickle toda a Pipeline gerar um score dos usuários. Estes Scores serão salvos no banco de dados com o nome de tb_sell_score


## 🛠 Tecnologias

- [Python](https://www.python.org)
- [SQL]()
