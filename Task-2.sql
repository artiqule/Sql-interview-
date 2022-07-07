-- 1. Отобрать по каждому договору последнюю доступную запись в таблице				

SELECT * FROM T
ORDER BY DEAL_NO
DESC LIMIT 1

-- 2. Вывести средний баланс по каждому договору за 2017 г.			

SELECT AVG(BALANCE)
FROM T
WHERE year(report_date) = '2017'
GROUP BY report_date

-- 3. Вывести суммарный баланс договоров с тарифом Зарплатный на конец 1 квартала 2018 г.

SELECT sum(balance)
FROM T
WHERE tariff = 'Зарплатный' AND report_date >= '2018-03-31'
