# Data Science como ferramenta para retenção de clientes da Olist

## **Introdução**

O objetivo deste projeto é analisar um extrato da base de dados da Olist para identificar os clientes deste serviço que estejam apresentando dificuldades em realizar vendas e propor estratégias de retenção, a serem aplicadas de acordo com o perfil de cada cliente. A partir de variáveis de importância extraídas do banco de dados da Olist, foram elaborados experimentos com diversos algoritmos de machine learning a fim de selecionar o modelo com melhor desempenho na detecção destes vendedores.  
Neste relatório, apresento uma visão geral da metodologia empregada e dos resultados obtidos, a fim de demonstrar como conhecimentos de Data Science podem ser aplicado em um problema recorrente em empresas. Os detalhes técnicos e explicações minuciosas de cada processo encontram-se no meu repositório do [GitHub](https://github.com/thifujikawa/clientes_olist)

## **O que é a Olist**
<img src="img/logo_olist.png" width="300" height="100">

A Olist é uma plataforma de e-commerce que utiliza sua expertise intermediando o vendedor com grandes marketplaces de maneira que um único produto cadastrado seja distribuído para diversos marketplaces simultaneamente facilitando e aumentando as chances de vendas.

<a name="voltar"></a>

## **Metodologia:**
Para este projeto foi realizado a divisão em diversas etapas:

1. [**Problema de Negócio**](#problema_negocio) Um Problema real de negócio que empresas como a Olist constamente enfretam 
2. [**Entendimento dos dados**](#data_understanding)
3. [**Extração Transformação e Carga (ETL-*Extraction Transform Load*)**](#etl) Extração dos dados do banco, geração de variáveis para análise
4. [**Análise Exploratória de Dados (EDA-*Exploratory Data Analysis*)  e Construção do modelo**](#preproc) Análise exploratória dos dados, Processamento dos dados e Construção do modelo de machine learning
5. Resultados
6. [**Operacionalização**](#operacional) Utilização do algoritmo treinado para geração de scores dos vendedores
7. [**Estratégia de Negócio**](#negocio) Como pode ser aplicada os resultados a fim de resolver o problema de negócio

<a name="problema_negocio"></a>

### **1 - Problema de negócio** 

A Olist oferta planos mensais para seus clientes, somado a mensalidade é cobrado um valor de comissão por produto vendido.
Como o Custo de Aquisição do Cliente (CAC) costuma ser mais alto do que manter o cliente com estratégias de retenção, é de extrema importância para a Olist o sucesso dos seus clientes.

#### **1.1 - Solução para o problema**
Afim de minimizar o número de clientes que irão deixar a Olist. Será utilizado o banco de dados para criar um modelo preditivo e assim determinar quais são as chances deste cliente deixar de realizar vendas utilizando a plataforma, desta maneira pode-se realizar certas campanhas, ações ou consultorias direcionadas aos usuários com o intuito de evitar que os usuários abandonem a empresa. Infelizmente não pude usar dados de clientes que entraram e sairam da plataforma para resolver o problema pois estes dados não foram fornecidos.

[**Voltar**](#voltar)

<a name="data_understanding"></a>

### **2 Data Understanding (*Entendimento dos dados*)**
<center><img src="img/dbmap.png" width="600" height="350"> </center>
Tendo conhecimento do problema e o que se espera da resposta do algoritmo, o próximo passo é observar os dados.Esta parte é fundamental para que exista sucesso no projeto. Um bom modelo de machine learning depende de dados que serão utilizados para treinamento do algoritmo. Portanto é fundamental que a empresa possua uma boa estrutura em seu banco de dados.

A base de dados da Olist foi elaborada em star scheme (Esquema Estrela), modelo amplamente adotado em data warehouses, onde no centro temos a tabela *orders_dataset* rodeadas de tabelas auxiliares, cada uma ligada através de uma coluna.  

A tabela *orders_dataset* possui todos os pedidos realizados durante o periodo de 15/09/2016 à 3/09/2018 totalizando 99441 registros. As tabelas auxiliares fornecem informações relacionadas as forma de pagamento, itens comprados, avaliação da compra por parte do comprador, dados dos compradores, entre outros.  

No início havia idealizado um problema focado nos usuários que sairam da plataforma, porém infelizmente como as tabelas se foca apenas em dados referente a ordens de compra e não aos usuários que entraram e sairam da plataforma, tive que alterar abordagem do problema, por isto e outros motivos esta etapa é uma das etapas fundamentais.

[**Voltar**](#voltar)
<a name="etl"></a>

### **3 - Extração Transformação e Carga (ETL-*Extraction Transform Load*)** 

Nesta fase os dados de diferentes tabelas serão extraidos e reunidos em apenas uma tabela, a seleção,processamento destes dados que irão para esta tabela exige um conhecimento do negócio já que a criação de certos indicadores podem auxiliar o algoritmo a compreender o comportamento dos clientes que tendem a não realizar vendas.

### Geração das Safas   
Como a base de dados possui apenas dados relacionados a vendas realizadas durante 2 anos, optei por criar partições destes dados, que nada mais são que um agrupado dos dados dos vendedores em um certo periodo, neste caso, foi considerado um periodo de 6 meses de atividade deste vendedor e nos 3 meses seguintes se o vender realizou alguma venda.   
Exemplo:
Os dados de vendas do usuário durante os meses de Janeiro e Junho foram coletados processados e enviados para a tabela já a variável resposta irá considerar se houve vendas nos próximos 3 meses após o mes de Julho , desta maneira o algoritmo pode avaliar dado ao comportamento do usuário no periodo observado e se houve ou não vendas.   
Desta maneira as safras selecionadas contemplam os seguintes dados:

|Safra       | Comportamento do usuário nos meses   | Periodo observado se houve vendas     |
|----------- |----------------                      | ----------------                      |
|Abr/17      | Out/16 à Abr/17                      | Mai/17 à Jul/17                       |
|Mai/17      | Nov/16 à Mai/17                      | Jun/17 à Set/17                       |
|Jun/17      | Dez/16 à Jun/17                      | Jul/17 à Out/17                       |
|----        | ----                                 | ----                                  |
|Mai/18      | Nov/17 à Mai/19                      | Jun/18 à Set/18                       |

### Criação das Variáveis
Definida a estratégia de particionar os dados gerando safras o próximo passo é reunir todas as informações pertinentes a este problema em uma única tabela onde: Nas linhas temos dados do usuário e nas colunas informações pertinentes a este usuário. Esta e a etapa anterior de entendimento dos dados possuem grande importância para o sucesso do projeto, pois caso informações do usuário nesta tabela que não represente grande relevância para o problema podem prejudicar o treinamento do modelo. Abaixo demonstro as variáveis geradas e utilizadas neste projeto.

|Variável                       |Descrição                                                              |
|-----------                    |----------------                                                       |
|Safra                          |Indica a Safra do dado                                                 |
|Seller ID                      |Identificação do Usuário                                               |
|flag venda                     |Indica se houve vendas nos 3 meses seguintes                           |
|estado                         |Estado do Usuário                                                      |
|idade_dias                     |Qtde de dias que entrou na Plataforma                                  |
|qtde_vendas                    |Qtde de Vendas                                                         |
|variedade_prod                 |Variedade de Produtos Vendidos                                         |
|qtde_prod_vendidos             |Quantidade de Produto Vendidos                                         |
|media_prod_vendidos_order      |Média da Quantidade de Produtos Vendidos por ordem                     |
|media_fotos                    |Média de Fotos nos Anúncios                                            |
|media_letras_desc              |Média de Letras Utilizadas nas Descrições                              |
|avaliacao_safra                |Avaliação das vendas na Safra                                          |
|avaliacao_acumulada            |Avaliação das vendas desde que entrou na Olist                         |
|delta_avaliacao_idade_base     |Diferença entre avaliação Acumulada e da Safra                         |
|ultima_venda                   |Qtde em dias da última venda                                           |
|qtde_mes_ativos                |Qtde de meses que realizou vendas na safra                             |
|prop_atrasos                   |Proporção de atrasos no recebimento que ocorreram nas vendas           |
|media_prazo_entrega            |Média em dias do prazo de entrega                                      |
|ticket_medio                   |Média do valor gasto por venda                                         |
|valor_medio_prod               |Média do valor dos produtos vendidos                                   |
|total_mensal                   |Total Mensal de vendas                                                 |
|frete_medio                    |Valor médio do Frete                                                   |
|prop_valor_frete               |Proporção entre o valor do frete e do Produto                          |
|intervalo_pedidos_dias         |Quantidade de vendas realizadas durante uma safra (6 meses)            |

### Execução da Etapa
A Etapa de Extração, Transformação e Carregamento dos dados (***ETL***) foi elaborada da seguinte maneira:   
Seleção das Variáveis : Um arquivo em formato SQL, efetua a seleção e criação das variáveis acessando as diferentes tabelas e cruzando dados quando necessário.
Criação da tabela com safras: Um aquivo utilizando linguagem Python realiza a criação da tabela e ao usuário inserir a data de início da safra e a quantidade desejada de safras, preenche a tabela utilizando o arquivo de seleção de variáveis. Deste maneira em um tabela temos as safras e todas as variáveis que foram escolhidas;

[**Voltar**](#voltar)
<a name="preproc"></a>

### **4 – Análise Exploratória de Dados (EDA - Exploratory Data Analysis) e Construção do modelo** 

### Falta falar um pouco mais da EDA
Com a tabela gerada na fase de EDA a etapa de compreensão dos dados gerados se inicia.  Através da Análise Exploratória permitiu notar que:
* Existiam valores ausentes na tabela que necessitou devidas estratégias de substituição
* Ao verificar a distribuição dos dados de maneira gráfica alguns vendedores demonstraram um comportamento estranho(Vendedores com poucas vendas, Valor da venda muito alto e baixa avalição) ao investigar um pouco mais estes usuários no banco de dados pode-se notar que são possíveis fraudadores, já que estes usuários não haviam recebido seus produtos ou receberam modelo não condizentes ao anúncio. Como estes usuários não eram interessantes para este projeto estes usuários foram removidos da tabela.
* Através da visualização de correlação entre variáveis foram excluidas 2 variáveis pois estavam altamente corelacionada as outras, desta maneira evitamos que o algoritmo de considere variáveis que estariam explicando a mesma coisa.

Ao término da Análise Exploratória pode-se compreender e tratar os dados quando necessário. Tendo os dados "tratados" a etapa de modelagem do modelo se inicia


Definidas as estratégias para lidar com este dataset foi possível verificar como alguns dos algoritmos estão performando. Com base nos resultados obtidos foram utilizadas métricas de validação e tempo de processamento para a escolha de apenas um algoritmo que posteriormente recebeu otimização que consiste em alterar parâmetros no algoritmo a fim de melhorar os resultados analisados. 

[**Voltar**](#voltar)
<a name="operacional"></a>

### **4 – Operacionalização** 

Utilizando o algoritmo treinado na fase anterior o mesmo irá fazer uma predição das chances do vendedor realizar alguma venda nos próximos 3 meses, esta resposta pode variar entre 0 e 1. Quanto maior este score, maiores são as chances de ocorrer vendas. 
O Id do vendedor junto ao score atribuído pelo algoritmo é enviado para uma tabela no banco de dados  

<img src="img/scores.png" width="350" height="100">


[**Voltar**](#voltar)
<a name="negocio"></a>

### **5 – Possíveis estratégias de negócio** 

Com este score podemos estudar como atuar para impulsionar as vendas utilizando diferentes campanhas para os vendedores. Com estes resultados foi possível separar os vendedores em 4 grupos de acordo com o score:


| Intervalo entre os scores &nbsp; &nbsp;| Ações |
|:----------: | :------------- | 
| **1 e 0,81** | Possuem uma grande chance de não realizarem vendas e podem ser ofertadas soluções que requeiram um investimento maior como: uma consultoria personalizada, desconto na comissão das vendas, meses grátis na plataforma.|
|**0,8 e 0,61** | Para este grupo de vendedores podem ser aplicados outras campanhas de retenção que não exijam tanto investimento quanto ao grupo anterior: envio de e-mails com melhores práticas para vendas, aumentar a relevância e o alcance, aumentar a variedades de produtos na plataforma afim de melhorar as vendas.|
|**0,6 e 0,35**  | Estes vendedores ainda podem representar um potencial risco de não realizar vendas portanto campanhas de e-mails contendo as tendências de vendas atuais e outras análises podem aumentar ainda mais as chances de vendas.|
|**0,34 e 0** | Representam clientes que potencialmente vão realizar vendas e que não serão foco para este case.|

## Considerações finais
Este projeto pode abranger desde início de um projeto da Data Science partindo de um problema de negócio, utilização do banco de dados da empresa, extração e análise dos dados, seleção e otimização do algoritmo de machine learning e por fim um programa que utiliza o algoritmo de machine learning para realizar o score dos vendedores. A partir destes scores pode-se realizar agrupamentos para campanhas distintas de retenção.

[**Voltar**](#voltar)

## 🙍 Autor <a name="autor"></a>
Feito por Thiago Ide.

[![Linkedin Badge](https://img.shields.io/badge/-Thiago-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/thide)](https://www.linkedin.com/in/thide/)
[![Gmail Badge](https://img.shields.io/badge/-thiago.fudji@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:thiago.fudji@gmail.com)](mailto:thiago.fudji@gmail.com)