# Detecção de clientes que não realizarão vendas na Olist

## Descrição do Projeto

Utilizando Data Science e o Banco de dados da Olist, elaborei um projeto onde pode-se realizar uma Extração do banco de dados trata-los para em seguida realizar alguns algoritmos de machine Learning afim de encontrar clientes que tendem a não realizar vendas na plataforma da Olist. Assim determinadas ações podem ser realizadas afim de auxiliar este vendedor.

## Tabela de conteúdos

* [Sobre](#sobre)
* [Tabela de Conteúdo](#tabela_de_conteudo)
* [Instalação](#instalacao)
* [Como Usar](#como_usar)
    * [Pré Requisitos](#pre-requisitos)
    * [Local Files](#local-files)
* [Descrição do Projeto](#projeto)
* [Tests](#testes)
* [Tecnologias](#tecnologias)
* [Autor](#autor)


## Status do Projeto

<h4 align="center">

    🚧 Em construção... 🚧
    Desenvolvendo a documentação

## Features
- [x] Envio do Projeto para o Github
- [ ] Passar o Banco de dados para Download
- [ ] Melhorar a documentação no GitHub e Notebook

<a name="como_usar"></a>
## Como Usar 

<a name="pre-requisitos"></a>
## Pré Requisitos 
Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
- [Git]
- [Python](https://www.python.org)
- [SQL]

Para a execução do projeto será necessário a extração dos dados diretamente de um banco, portanto é necessário o download de alguns arquivos.
<a name="local-files"></a>
### Local Files 
* Realizar o Download do repositório e do banco de dados conforme as instruções abaixo:
    1. Clonar o [repositório](https://github.com/thifujikawa/clientes_olist.git)
    2. Efetuar o Download do Banco de dados da Olist 

***OBSERVAÇÃO*** O banco de dados deve estar salvo no diretório Data

* Instalar as bibliotecas:
    1. No Repositório o arquivo requirements.txt possui todas as bibliotecas necessárias para o projeto.

<a name="projeto"></a>
## Descrição do Projeto:

O Projeto como um todo possui 5 etapas, sendo que 3 contemplam notebooks e scripts.  
[Neste link](https://thifujikawa.github.io/clientes_olist/) escrevi um pouco mais sobre os detalhes desse projeto.  
Abaixo estarei descrevendo um pouco mais sobre as etapas porém darei enfase para as etapas com código.  
- **Etapa 1/5** - Problema de negócio: Diminuição do churn, sendo que o algoritmo será responsável em detectar vendedores que não irão realizar vendas nos próximos 3 meses. Tendo definido estes vendedores ações possam ser tomadas;  

- **Etapa 2/5** - Extraction Transform and Load (***ETL***): Utilizando o banco de dados da Olist foi realizada uma query (***query_abt.sql***) que ao ser executada pelo script (***geração_abt.py***) cria uma Analytical Base Table (ABT) com os dados coletados pela query, inclusive a variável resposta que nesse caso verifica se a partir da data do fim da safra houveram vendas nos próximos 3 meses.  
Instruções para execução para a geração da ABT:
    * No diretório Query executar via terminal de comando o arquivo **geracao_abt.py** e inserir:  
        - -s : A data inicial de coleta das safras respeitando o formato(YYYY-MM-DD)  
        - -i : Quantidade de safras que serão geradas   
        O programa irá criar uma tabela de nome **tb_abt_no_sells** contendo todos os dados referente a ABT e suas respectivas safras.  
>
- **Etapa 3/5** - Processamento, Exploração dos dados e Construção do modelo: Com a ABT foi criado um notebook (***modelling.ipynb***) onde foi feita a Análise Exploratória de Dados que auxiliou na detecção de outliers, disposição dos dados e na definição de estratégias para preencher dados nulos contidos no dataset, em seguida foi escolhido o algoritmo e otimizado o algoritmo de machine learning. O algortimo e dados adicionais referente as variáveis foram salvos em um arquivo pickle (***modelo_otimizado.pkl***).  

- **Etapa 4/5** - Operacionalização Com o arquivo Pickle contendo o algoritmo e todos os dados para a execução é possível utilizar novos dados afim de localizarmos esses vendores. O script (***get_last_model.py***) através da query  (***query_book_variaveis.sql***), cria uma tabela (***tb_book_sellers***), esta tabela é semelhante a ABT, porém neste caso não temos a variável resposta pois quem irá fornecer essa resposta será o resultado desse algoritmo. Um pouco diferente do normal, ao invés do algoritmo a classificação responder através de (0 ou 1) estou utilizando a probabilidade porntanto, o valor será entre 0 e 1 sendo que quanto mais próximo do valor 1 maiores são as chances do vendedor não realizar vendas. Uma tabela será criada (***tb_no_sells_score***) contendo o ID do Vendedor e seu respectivo score.  
Instruções para execução:  
Geração dos scores:  
    * No diretório Modelling executar via terminal de comando o arquivo **get_last_model.py** e inserir:
        - -s : A data inicial da safra desejada neste caso para prevermos a possibilidade de vendas nos próximos 3 meses inserir a data da safra a partir do último registro -6 meses.  
        - O programa irá gerar os scores e enviar para a tabela **tb_no_sells_score**  
>
- **Etapa 5/5**  - Possíveis estratégias de negócio: No [GithubPages](https://thifujikawa.github.io/clientes_olist/) descrevi melhor uma possível estratégia de retenção de clientes, porém de modo resumido quanto maiores as chances do vendedor não realizar vendas, mais poderia ser investido nestes usuários afim de ajuda-los.  

## Notebook contendo o desenvolvimento do algoritmo de Machine Learning:  
Para quem se interessar em olhar no projeto de Data Science com as respectivas métricas e métodos utilizados o mesmo se  encontra neste repositório na pasta Modelling o arquivo **modelling.ipynb** você poderá ver com mais detalhes o que foi aplicado.   
De maneira resumida o algoritmo de machine learning escolhido para esta tarefa foi o Light Gradient Boosting e em um dataset Out of Time obteve um AUC_SCORE de 0.89 e levando em consideração grupo que não realizará vendas, as métricas **Precision/Recall** obtidas foram de respetivamente **0.73 e 0.76**.  
O Arquivo **modelo_otimizado.pkl** contem os Pipeline completo incluindo o algoritmo aplicando as devidas otimizaçoes. 

<a name="tecnologias"></a>
## 🛠 Tecnologias 

- [Python](https://www.python.org)
- [SQL]()

<a name="autor"></a>
## 🙍 Autor
Feito por Thiago Ide.

[![Linkedin Badge](https://img.shields.io/badge/-Thiago-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/thide)](https://www.linkedin.com/in/thide/)
[![Gmail Badge](https://img.shields.io/badge/-thiago.fudji@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:thiago.fudji@gmail.com)](mailto:thiago.fudji@gmail.com)


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
