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
* [Autor](#autor)


## Status do Projeto
<h4 align="center">

    🚧 Em construção... 🚧

## Features
- [x] Envio do Projeto para o Github
- [x] Alterado o nome da Flag
- [x] Alterar a Tabela  tb_abt_sellers, tb_churn_score para tb_sell_score
- [x] Passar o modelling para notebook
- [ ] Explicar melhor o passo a passo nesse Github
- [ ] Explicar melhor com Markdowns o notebook afim de gerar um storytelling mais claro
- [ ] Verificar se retiro do notebook os algoritmos selecionados na fase inicial do estudo
- [X] Terminar o texto para o Github Pages
- [X] Formatar o texto para o Github Pages


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
        1. Executar o arquivo get_the_last_model.py, Este programa irá gerar as safras e em seguida coleta do arquivo Pickle toda a Pipeline gerar um score dos usuários. Estes Scores serão salvos no banco de dados com o nome de **tb_no_sells_score**


## 🛠 Tecnologias <a name="tecnologias"></a>

- [Python](https://www.python.org)
- [SQL]()

## 🙍 Autor <a name="autor"></a>
Feito por Thiago Ide.

[![Linkedin Badge](https://img.shields.io/badge/-Thiago-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/thide)](https://www.linkedin.com/in/thide/)
[![Gmail Badge](https://img.shields.io/badge/-thiago.ide@icloud.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:thiago.ide@icloud.com)](mailto:thiago.ide@icloud.com)


## 📚 Licença

MIT License

Copyright (c) <2020> <Seu Nome>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
