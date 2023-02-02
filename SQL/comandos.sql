-- ###### COMANDO SELECT ######

-- Todos os email da coluna sales.customers
select email
from sales.customers

-- Liste todos os emails e nomes dos clientes da sales.customers
select email, first_name, last_name
from sales.customers

-- Liste todos os as informações dos clientes sales.customers
select *
from sales.customers


-- ###### COMANDO DISTINCT ######

-- Liste as marcas de carro que consta na tabela products
select brand
from sales.products -- 332 produtos

-- Liste as marcas de carro distintas que constam na tabela products
select distinct brand
from sales.products -- 40 produtos distintos

-- Liste as marcas e anos de modelo distintos que constam na tabela products
select distinct brand, model_year
from sales.products -- 184 conbinações distintas


-- ###### COMANDO WHERE ######

-- Liste os email dos clientes da nossa base que moram no estado de Santa Catarina
select email, state
from sales.customers
where state = 'SC'

-- Liste os email dos clientes da nossa base que moram no estado de Santa Catarina ou Mato Grosso do Sul
select email, state
from sales.customers
where state = 'SC' or state ='MS'

-- Liste os email dos clientes da nossa base que moram no estados de Santa Catarina ou Mato Grosso do Sul
-- e que tenha mais de 30 anos
select email, state, birth_date
from sales.customers
where (state = 'SC' or state = 'MS') and birth_date < '1991-12-28'

select distinct birth_date
from sales.customers


-- ###### COMANDO ORDER BY ######

-- Liste produtos da tabela products na ordem crescente com a base no preço
select *
from sales.products
order by price desc

-- Liste os estdos distintos da tabela customers na ordem crescente
select distinct state
from sales.customers
order by state

-- ###### COMANDO LIMIT ######

-- Liste as 10 primeiras linhas da tabela funnel
select *
from sales.funnel
limit 10

-- Liste os 10 produtos mais caros da tabela products
select *
from sales.products
order by price desc
limit 10


-- ###### COMANDO COLUNA CALCULADA ######

-- Crie uma coluna contendo a idade do cliente da tabela sales.customers
select 
first_name,
email,
(current_date - birth_date) / 365 as idade_cliente
from sales.customers

-- OU

select 
first_name,
email,
(current_date - birth_date) / 365 as "Idade Cliente"
from sales.customers

-- Liste os 10 clientes mais novos da tabela customers
select
first_name,
last_name,
(current_date - birth_date) / 365 as "Idade Cliente"
from sales.customers
order by "Idade Cliente"
limit 10

-- Criação de uma coluna calculada com strings
-- Crie a coluna "nome_completo" contendo o nome completo do cliente
select
first_name || ' ' || last_name as nome_completo
from sales.customers


-- ###### COMANDO OPERADORES COMO FLAG ######

--Crie uma coluna que retorne TRUE sempre que um cliente for um profissional clt
select
customer_id,
first_name,
professional_status,
(professional_status = 'clt') as cliente_clt
from sales.customers

-- ###### COMANDO OPERADORES COMO FLAG ######

-- Uso do comando BETWEEN
-- Selecione veiculos que custam entre 100k a 200k na tabela products
select *
from sales.products
where price >= 100000 and price <= 200000

-- OU

select *
from sales.products
where price between 100000 and 200000

-- Uso comando NOT
-- Selecione veiculos que custam abaixo de 100k ou acima de 200k
select *
from sales.products
where price <100000 or price < 200000

-- OU

select *
from sales.products
where price not between 100000 and 200000

-- Uso comando IN
-- Selecione produtos que seja da marca HONDA, TOYOTA ou RENAULT
select *
from sales.products
where brand = 'HONDA' or brand = 'TOYOTA' or brand = 'RENAULT'

-- OU

select *
from sales.products
where brand in ('HONDA', 'TOYOTA', 'RENAULT')

-- OU Utilizando NOT jutamente com IN

select *
from sales.products
where brand  not in ('HONDA', 'TOYOTA', 'RENAULT')

-- Uso comando LIKE (Matchs imperfeitos)
-- Selecione os primeiros nomes distintos da tabela customers que começam com as iniciais ANA
select distinct first_name
from sales.customers
where first_name = 'ANA'

-- OU Usando LIKE

select distinct first_name
from sales.customers
where first_name like 'ANA'

-- OU Usando LIKE mais coringa %

select distinct first_name
from sales.customers
where first_name like 'ANA%'

-- OU LIKE mais coringa % no começo

select distinct first_name
from sales.customers
where first_name like '%ANA'

-- Uso comando ILIKE (ignora letras maiúsculas e minúsculas)
-- Selecione os primieros nomes distintos com as iniciais 'ana'
select distinct first_name
from sales.customers
where first_name ilike 'ana%'
limit 10

-- uso do comando IS NULL
-- Selecionar apenas linhas que contem nulo no campo polulations
-- na tabela temp_tables.regions
select *
FROM temp_tables.regions

SELECT *
FROM temp_tables.regions
WHERE population is null

-- PARA QUE SERVE ##################################################################
-- Servem para executar operações aritmética nos registros de uma coluna 


-- TIPOS DE FUNÇÕES AGREGADAS ######################################################
-- COUNT()
-- SUM()
-- MIN()
-- MAX()
-- AVG()


-- EXEMPLOS ########################################################################

-- COUNT() -------------------------------------------------------------------------

-- (Exemplo 1) Contagem de todas as linhas de uma tabela
-- Conte todas as visitas realizadas ao site da empresa fictícia
select 
    count(*)
from sales.funnel

-- (Exemplo 2) Contagem das linhas de uma coluna
-- Conte todos os pagamentos registrados na tabela sales.funnel 
select *
from sales.funnel
limit 10

select 
    count(paid_date)
from sales.funnel

-- (Exemplo 3) Contagem distinta de uma coluna
-- Conte todos os produtos distintos visitados em jan/21
select 
    count(distinct product_id)
from sales.funnel
where visit_page_date between '2021-01-01' and '2021-01-31'

-- OUTRAS FUNÇÕES ------------------------------------------------------------------

-- (Exemplo 4) Calcule o preço mínimo, máximo e médio dos productos da tabela products
select 
    min(price), 
    max(price),
    avg(price)
from sales.products

-- (Exemplo 5) Informe qual é o veículo mais caro da tabela products
select 
    max(price) 
from sales.products

-- Como otimizar um consulta com sub query

select *
from sales.products
where price =   (select 
                    max(price) 
                from sales.products)

-- RESUMO ##########################################################################
-- (1) Servem para executar operações aritmética nos registros de uma coluna 
-- (2) Funções agregadas não computam células vazias (NULL) como zero
-- (3) Na função COUNT() pode-se utilizar o asterisco (*) para contar os registros
-- (4) COUNT(DISTINCT ) irá contar apenas os valores exclusivos


-- PARA QUE SERVE ##################################################################
-- Serve para agrupar registros semelhantes de uma coluna
-- Normalmente utilizado em conjunto com as Funções de agregação


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Contagem agrupada de uma coluna
-- Calcule o nº de clientes da tabela customers por estado
select state, count(*) as contagem
from sales.customers
group by state 
order by contagem desc


-- (Exemplo 2) Contagem agrupada de várias colunas
-- Calcule o nº de clientes por estado e status profissional 
select state, professional_status, count(*) as contagem
from sales.customers
group by state, professional_status
order by state, contagem desc

-- (Exemplo 3) Seleção de valores distintos
-- Selecione os estados distintos na tabela customers utilizando o group by
select distinct state
from sales.customers

select state
from sales.customers
group by state


-- RESUMO ##########################################################################
-- (1) Serve para agrupar registros semelhantes de uma coluna, 
-- (2) Normalmente utilizado em conjunto com as Funções de agregação
-- (3) Pode-se referenciar a coluna a ser agrupada pela sua posição ordinal 
-- (ex: GROUP BY 1,2,3 irá agrupar pelas 3 primeiras colunas da tabela) 
-- (4) O GROUP BY sozinho funciona como um DISTINCT, eliminando linhas duplicadas

-- PARA QUE SERVE ##################################################################
-- Serve para filtrar linhas da seleção por uma coluna agrupada


-- EXEMPLOS ########################################################################

-- (Exemplo 1) seleção com filtro no HAVING 
-- Calcule o nº de clientes por estado filtrando apenas estados acima de 100 clientes
select 
    state, 
    count(*)
from sales.customers
group by state
having count(*) > 100
    and state <> 'MG'


-- RESUMO ##########################################################################
-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados 
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas

-- PARA QUE SERVE ##################################################################
-- Servem para combinar colunas de uma ou mais tabelas


-- SINTAXE #########################################################################
select t1.coluna_1, t1.coluna_1, t2.coluna_1, t2.coluna_2
from schema.tabela_1 as t1
ALGUM join schema.tabela_2 as t2
    on condição_de_join


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Utilize o LEFT JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select * from temp_tables.tabela_1
select * from temp_tables.tabela_2

select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 
left join temp_tables.tabela_2 as t2
	on t1.cpf = t2.cpf


-- (Exemplo 2) Utilize o INNER JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select t1.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 
inner join temp_tables.tabela_2 as t2
	on t1.cpf = t2.cpf


-- (Exemplo 3) Utilize o RIGHT JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 
right join temp_tables.tabela_2 as t2
	on t1.cpf = t2.cpf


-- (Exemplo 4) Utilize o FULL JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select t2.cpf, t1.name, t2.state
from temp_tables.tabela_1 as t1 
full join temp_tables.tabela_2 as t2
	on t1.cpf = t2.cpf


-- RESUMO ##########################################################################
-- (1) Servem para combinar colunas de uma ou mais tabelas
-- (2) Pode-se chamar todas as colunas com o asterisco (*), mas não é recomendado
-- (3) É uma boa prática criar aliases para nomear as tabelas utilizadas 
-- (4) O JOIN sozinho funciona como INNER JOIN

-- EXERCÍCIOS ########################################################################

-- (Exemplo 1) Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site

select 
	cus.professional_status,
	count(fun.paid_date) as pagamentos

from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
group by cus.professional_status
order by pagamentos desc


-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
select * from temp_tables.ibge_genders limit 10

select 
	ibge.gender,
	count(fun.paid_date)
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.ibge_genders as ibge
	on lower(cus.first_name) = ibge.first_name
group by ibge.gender


-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select * from sales.customers limit 10
select * from temp_tables.regions limit 10

select
	reg.region,
	count(fun.visit_page_date) as visitas
from sales.funnel as fun
left join sales.customers as cus
	on fun.customer_id = cus.customer_id
left join temp_tables.regions as reg
	on lower(cus.city) = lower(reg.city)
	and lower(cus.state) = lower(reg.state)
group by reg.region
order by visitas desc


-- SINTAXE #########################################################################
select coluna_1, coluna_2
from schema_1.tabela_1

union / union all

select coluna_3, coluna_4 
from schema_2.tabela_2


-- EXEMPLOS ########################################################################

-- (Exemplo 1) União simples de duas tabelas
-- Una a tabela sales.products com a tabela temp_tables.products_2

select * from sales.products
union all
select * from temp_tables.products_2


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas

with primeira_visita as (

	select customer_id, min(visit_page_date) as visita_1
	from sales.funnel
	group by customer_id

)

select
	fun.visit_page_date,
	(fun.visit_page_date <> primeira_visita.visita_1) as lead_recorrente,
	count(*)

from sales.funnel as fun
left join primeira_visita
	on fun.customer_id = primeira_visita.customer_id
group by fun.visit_page_date, lead_recorrente
order by fun.visit_page_date desc, lead_recorrente


-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

with preco_medio as (

	select brand, avg(price) as preco_medio_da_marca
	from sales.products
	group by brand

)

select
	fun.visit_id,
	fun.visit_page_date,
	pro.brand,
	(pro.price * (1+fun.discount)) as preco_final,
	preco_medio.preco_medio_da_marca,
	((pro.price * (1+fun.discount)) - preco_medio.preco_medio_da_marca) as preco_vs_media

from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
left join preco_medio
	on pro.brand = preco_medio.brand