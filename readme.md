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
* [Desenvolvimento](#notebook)
* [Tests](#testes)
* [Tecnologias](#tecnologias)
* [Autor](#autor)


## Status do Projeto

<h4 align="center">

    🚧 Em construção... 🚧
    Melhorando a documentação

## Features
- [x] Envio do Projeto para o Github
- [x] Passar o modelling para notebook
- [X] Terminar o texto para o Github Pages
- [ ] Melhorar a documentação no GitHub
- [ ] Explicar melhor o notebook afim de gerar um storytelling mais claro
- [ ] Verificar se retiro do notebook os algoritmos selecionados na fase inicial do estudo
- [ ] Formatar o texto para o Github Pages


## Como Usar <a name="como_usar"></a>

### Pré Requisitos <a name="pre-requisitos"></a>
Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
- [Git]
- [Python]
- [SQL]

Para a execução do projeto será necessário a extração dos dados diretamente de um banco, portanto é necessário o download de alguns arquivos

### Local Files <a name="local-files"></a>
* Realizar o Download do repositório e do banco de dados conforme as instruções abaixo:
    1. git clone https://github.com/thifujikawa/clientes_olist.git
    2. Efetuar o Download do Banco de dados da Olist 

***OBSERVAÇÃO*** O banco de dados deve estar salvo no diretório Data

* Instalar as bibliotecas:
    1. No Repositório o arquivo requirements.txt possui todas as bibliotecas necessárias para o projeto.

### Utilização dos programas:
Como o projeto possui diversas etapas estarei descrevendo cada passo com mais detalhes abaixo:  
* Para a geração da ABT:  
    * Na pasta Query executar via terminal de comando o arquivo **geracao_abt.py** e inserir:  
        -s : A data inicial de coleta das safras respeitando o formato(YYYY-MM-DD)  
        -i : Quantidade de safras que serão geradas   
        O programa irá criar uma tabela de nome **tb_abt_no_sells** contendo todos os dados referente a ABT e suas respectivas safras.
* Geração dos scores:  
    * Na pasta Modelling executar via terminal de comando o arquivo **get_last_model.py** e inserir:
        -s : A data inicial da safra desejada neste caso para prevermos a possibilidade de vendas nos próximos 3 meses inserir a data da safra a partir do último registro -6 meses.  
        O programa irá gerar os scores e enviar para a tabela **tb_no_sells_score** onde quanto mais próximo do valor 1 maiores são as chances deste vendedor realizar vendas nos próximos 3 meses  

## Notebook contendo o desenvolvimento do algoritmo de Machine Learning:  <a name="notebook"></a>
Para quem se interessar em olhar no projeto de Data Science com as respectivas métricas e métodos utilizados o mesmo se  encontra neste repositório na pasta Modelling o arquivo **modelling.ipynb** você poderá ver com mais detalhes o que foi aplicado.   
De maneira resumida o algoritmo de machine learning escolhido para esta tarefa foi o Light Gradient Boosting e em um dataset Out of Time obteve um AUC_SCORE de 0.89 e levando em consideração grupo que não realizará vendas, as métricas **Precision/Recall** obtidas foram de respetivamente **0.77 e 0.74**.  
O Arquivo **modelo_otimizado.pkl** contem os Pipeline completo incluindo o algoritmo aplicando as devidas otimizaçoes. 


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
