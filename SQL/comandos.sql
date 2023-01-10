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