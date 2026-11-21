USE users_projects_2
GO
SELECT * FROM projects

--Fazer uma consulta que retorne id, nome, email, username e caso a senha seja diferente de
--123mudar, mostrar ******** (8 asteriscos), caso contrário, mostrar a própria senha.
SELECT
	users.id,
	users.nome,
	users.email,
	users.username,
	CASE 
		WHEN (users.senha NOT LIKE '123mudar') THEN '********'
		ELSE users.senha
	END AS senha
FROM users;
		
--Considerando que o projeto 10001 durou 15 dias, fazer uma consulta que mostre o nome do
--projeto, descrição, data, data_final do projeto realizado por usuário de e-mail
--aparecido@empresa.com
SELECT 
	projects.nome,
	projects.descricao,
	CONVERT(CHAR(10), projects.dataCriacao, 103) AS data_inicial,
	CONVERT(char(10), DATEADD(DAY, 15, projects.dataCriacao), 103) AS data_final
FROM projects
INNER JOIN users_has_projects up ON up.projects_id = projects.id
INNER JOIN users ON users.id = up.users_id
WHERE projects.id = 10001 AND users.email LIKE 'aparecido@empresa.com';

--Fazer uma consulta que retorne o nome e o email dos usuários que estão envolvidos no
--projeto de nome Auditoria
SELECT 
	users.nome,
	users.email
FROM users 
INNER JOIN users_has_projects up ON up.users_id = users.id
INNER JOIN projects ON projects.id = up.projects_id
WHERE projects.nome LIKE '%Auditoria%';

--Considerando que o custo diário do projeto, cujo nome tem o termo Manutenção, é de 79.85
--e ele deve finalizar 16/09/2014, consultar, nome, descrição, data, data_final e custo_total do
--projeto
SELECT 
	projects.nome,
	projects.descricao,
	CONVERT(CHAR(10), projects.dataCriacao, 103) AS data_inicial,
	CONVERT(CHAR(10), DATEADD(DAY, 10, projects.dataCriacao), 103) AS data_final,
	CAST((10 * 79.85) AS DECIMAL(5,2)) AS custo_total
FROM projects
WHERE projects.nome LIKE 'Manuten%'; 

