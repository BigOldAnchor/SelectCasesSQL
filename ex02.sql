USE Locadora_2
GO

--Fazer uma consulta que retorne ID, Ano, nome do Filme (Caso o nome do filme tenha
--mais de 10 caracteres, para caber no campo da tela, mostrar os 10 primeiros
--caracteres, seguidos de reticências ...) dos filmes cujos DVDs foram fabricados depois
--de 01/01/2020
SELECT
	Filme.id,
	Filme.ano,
	CASE
		WHEN (LEN(Filme.titulo) > 10) THEN SUBSTRING(Filme.titulo, 1, 10) + '...'
		ELSE Filme.titulo
	END AS titulo_filme,
	DVD.data_fabricacao
FROM Filme
INNER JOIN DVD ON Filme.id = DVD.Filmeid
WHERE DVD.data_fabricacao > '2020-01-01';

--Fazer uma consulta que retorne num, data_fabricacao, qtd_meses_desde_fabricacao
--(Quantos meses desde que o dvd foi fabricado até hoje) do filme Interestelar
SELECT
	DVD.num,
	DVD.data_fabricacao,
	DATEDIFF(MONTH, DVD.data_fabricacao, GETDATE()) AS qtd_meses_desde_fabricacao
FROM DVD
INNER JOIN Filme ON Filme.id = DVD.Filmeid
WHERE Filme.titulo LIKE '%Interestelar%';

--Fazer uma consulta que retorne num_dvd, data_locacao, data_devolucao,
--dias_alugado(Total de dias que o dvd ficou alugado) e valor das locações da cliente que
--tem, no nome, o termo Rosa
SELECT
	DVD.num,
	Locacao.data_locacao,
	Locacao.data_devolucao,
	DATEDIFF(DAY, Locacao.data_locacao, Locacao.data_devolucao) AS dias_alugado
FROM DVD 
INNER JOIN Locacao ON Locacao.DVDnum = DVD.num
INNER JOIN Cliente ON Locacao.Clientenum_cadastro = cliente.num_cadastro
WHERE Cliente.nome LIKE '%Rosa%';

--Nome, endereço_completo (logradouro e número concatenados), cep (formato
--XXXXX-XXX) dos clientes que alugaram DVD de num 10002.
SELECT
	cliente.nome,
	cliente.logradouro + ',' + CAST(cliente.num AS CHAR(10)) AS endereco_completo,
	SUBSTRING(cliente.cep, 1, 5) + '-' + SUBSTRING(cliente.cep, 6,8) AS CEP
FROM cliente
INNER JOIN Locacao ON cliente.num_cadastro = Locacao.Clientenum_cadastro
WHERE Locacao.DVDnum = 10002;