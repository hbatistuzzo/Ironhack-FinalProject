USE ame;

-- Qual a quantidade de respondentes de cada país?
SELECT Country, COUNT(*) from respondente
JOIN country on country.Country_id = respondente.Country_id
GROUP BY Country
ORDER BY COUNT(*) DESC;
	-- see output
    
-- Quantos usuários que moram em “United States” gostam de Windows?
SELECT * from respondente
JOIN country on country.Country_id = respondente.Country_id
JOIN os on os.OS_id = respondente.OS_id
WHERE Country = 'United States' and OperatingSystem = 'Windows';
	-- returns 7635 users
    
-- Qual a média de salário dos usuários que moram em Israel e gostam de Linux?
SELECT AVG(ConvertedSalary) from respondente
JOIN country on country.Country_id = respondente.Country_id
JOIN os on os.OS_id = respondente.OS_id
WHERE Country = 'Israel' and OperatingSystem = 'Linux-based'  and CSMR != 0;
	-- returns 178 users in total, but only 93 with actual salary input. CSMR mean yields 43487.84135304659 monthly reais
    -- 'CSMR' stands for ConvertedSalaryMonthlyReais
    -- 'ConvertedSalary' is yearly in USD

-- Qual a média e o desvio padrão do salário dos usuários que usam Slack para cada tamanho de empresa disponível?
SELECT CompanySize,AVG(ConvertedSalary),STDDEV(ConvertedSalary) from respondente
join resp_usa_ferramenta as ruf on ruf.respondent = respondente.respondent
join tool on tool.Tool_id = ruf.Tool_id
join companies on companies.Company_id = respondente.Company_id
where CommunicationTools = 'Slack' and CSMR != 0
GROUP BY CompanySize
ORDER BY AVG(ConvertedSalary);
	-- 29483 users who use slack. Now to group by companysize


 -- Qual a diferença entre a média de salário dos respondentes do Brasil que acham que criar
 -- código é um hobby e a média de todos de salário de todos os respondentes brasileiros
 -- agrupado por cada sistema operacional que eles usam?
SELECT OperatingSystem,AVG(ConvertedSalary) as media_hobby from respondente
JOIN country on country.Country_id = respondente.Country_id
JOIN os on os.OS_id = respondente.OS_id
where Country = 'Brazil' and Hobby = 1
GROUP BY OperatingSystem;

SELECT OperatingSystem,AVG(ConvertedSalary) as media_geral from respondente
JOIN country on country.Country_id = respondente.Country_id
JOIN os on os.OS_id = respondente.OS_id
where Country = 'Brazil'
GROUP BY OperatingSystem;
	-- hmmmm cuidado com as virgulas. fix in python

-- Quais são as top 3 tecnologias mais usadas pelos desenvolvedores?
SELECT CommunicationTools,COUNT(CommunicationTools) from respondente
join resp_usa_ferramenta as ruf on ruf.respondent = respondente.respondent
join tool on tool.Tool_id = ruf.Tool_id
join companies on companies.Company_id = respondente.Company_id
GROUP BY CommunicationTools
ORDER BY Count(CommunicationTools) DESC
LIMIT 3;
	-- Slack, Jira, Office


-- Quais são os top 5 países em questão de salário?
SELECT Country, AVG(ConvertedSalary) from respondente
JOIN country on country.Country_id = respondente.Country_id
where ConvertedSalary != 0
GROUP BY Country
ORDER BY AVG(ConvertedSalary) DESC;
	-- hmmmm

