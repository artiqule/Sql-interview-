-- 1. Отобрать по каждому договору последнюю доступную запись в таблице				

SELECT * 
FROM DEAL d1
WHERE d1.id IN (
SELECT max(id) id
FROM DEAL d
GROUP BY deal_no)

-- 2. Вывести средний баланс по каждому договору за 2017 г.			

SELECT AVG(BALANCE)
FROM DEAL d
WHERE year(report_date) = '2017'
GROUP BY report_date

-- 3. Вывести суммарный баланс договоров с тарифом Зарплатный на конец 1 квартала 2018 г.

SELECT deal_no, sum(balance)
FROM DEAL d
WHERE tariff = 'Зарплатный' AND report_date <= '2018-03-31'
GROUP BY deal_no

# Если в таблице номер договора (deal_no) повторяется, то тогда решение:

SELECT deal_no, sum(balance) 
FROM DEAL d1
WHERE d1.id IN (
SELECT max(id) id
FROM DEAL d
WHERE tariff = 'Зарплатный' AND report_date < '2018-04-01'
GROUP BY deal_no)
GROUP BY deal_no
