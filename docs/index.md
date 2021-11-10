# Data Science como ferramenta para Retenção de clientes da Olist

### Introdução

Neste projeto foi aplicado um conjunto de conceitos adquiridos em Data Science focando localizar os clientes da Olist com dificuldades em realizar vendas para que estratégias de retenção possam ser aplicadas. Do banco de dados da Olist, foi extraído as variáveis de importância (ETL) e a partir destes dados foram elaborados experimentos com diversos algoritmos de Machine Learning afim de selecionar aquele que obteve melhor desempenho na detecção destes vendedores. 
Esta é uma demonstração de como o Data Science pode ser introduzido em um ambiente corporativo, neste exemplo foi abordado a redução da taxa de churn.

### O que é a Olist

A Olist é uma plataforma de e-commerce que utiliza sua expertise intermediando o vendedor com grandes marketplaces, de maneira que um único produto cadastrado seja distribuído para diversos marketplaces simultaneamente facilitando e aumentando as chances de vendas.

### Etapas do Projeto:


1. [Problema de Negocio](#problema_negocio) Analisa 
2. [ETL](#etl)
3. [Pré Processamento e Construção do Modelo](#preproc) link
4. [Operacionalização](#operacional)
5. [Estratégia de Negocio](#negocio)


### 1-	Problema de negócio: <a name="problema_negocio"></a>

A Olist oferta planos mensais para seus clientes, somado a mensalidade é cobrado um valor de comissão por produto vendido.
Como o Custo de Aquisição do Cliente (CAC) costuma ser mais alto do que manter o cliente com estratégias de retenção. É de extrema importância para a Olist o sucesso dos seus clientes. 
Utilizando um algoritmo podemos localizar os clientes que tendem a não realizar vendas em um futuro próximo desta maneira pode-se realizar certas campanhas, ações ou consultorias direcionadas aos usuários com o intuito de melhorar suas vendas


### 2-ETL <a name="etl"></a>

A base de dados fornecida pela Olist é composta de diversas tabelas com diferentes informações. Através delas  foi gerado as possíveis variáveis preditoras  relevantes ao problema abordado. O Book de Variáveis contempla todos estes dados em uma única tabela.
Explicando de maneira superficial, para que o algoritmo de Machine Learning possa interpretar e trazer predições é necessário criar uma variável resposta e a partir desta resposta o algoritmo detecta a mudança de padrões e o quão elas impactaram em sua variável resposta.
Para este conjunto de dados foi aplicado o conceito de safras que agrupa toda as vendas efetivadas durante 6 meses. Para elaboração da variável resposta foi considerado os próximos 3 meses.


### 3 – Processamento, Exploração dos dados e Construção do Modelo <a name="preproc"></a>


De posse dos dados do vendedor e sua performance em cada safra, foi analisada a presença de dados nulos, geração de gráficos uni-variados e multivariados para análise, assim é possível ver a disposição dos valores e a correlação entre as variáveis.
Tendo definida as estratégias para substituição de dados nulos presentes no dataset, é possível verificar como  alguns dos algoritmos estão performando. Com base nos resultados obtidos foi utilizado métricas e tempo de processamento para a escolha de apenas um algoritmo que posteriormente recebeu  otimização que consiste em alterar parâmetros no algoritmo a fim de melhorar os resultados analisado. 


### 4 – Operacionalização <a name="operacional"></a>
Utilizando o algoritmo treinado na fase anterior o mesmo irá fazer uma predição das chances do vendedor realizar alguma venda nos próximos 3 meses, esta resposta pode variar entre 0 e 1. Onde quanto maior este score, maiores são as chances de ocorrer vendas. 
O Id do vendedor junto ao score atribuído pelo algoritmo é enviado para uma tabela no banco de dados

#### 4.1 – Possíveis estratégias de negócio. <a name="negocio"></a>
Com este score podemos estudar como atuar para impulsionar as vendas utilizando diferentes campanhas para os vendedores. Na minha opinião, separaria os vendedores em 4 classes de acordo com o score onde:

**Score entre 0 e 0,19** - Possuem uma grande chance de não realizarem vendas e podem ser ofertadas soluções que requeiram um investimento maior como: uma consultoria personalizada, desconto na comissão das vendas, meses grátis na plataforma;  
**Score entre 0,2 e 0,39** - Para este grupo de vendedores podem ser aplicados outras campanhas de retenção que não exijam tanto investimento quanto ao grupo anterior. Dentre elas posso citar envio de e-mails com melhores práticas para vendas, aumentar a relevância e o alcance, aumentar a variedades de produtos na plataforma afim de melhorar as vendas;  
**Score entre 0,4 e 0,59** - Estes vendedores ainda podem representar um potencial risco de não realizar vendas portanto campanhas de e-mails contendo as tendências de vendas atuais e outras análises podem aumentar ainda mais as chances de vendas;  
**Score entre 0,6 e 1** - Representam clientes que potencialmente vão realizar vendas e que não serão foco para este projeto.
