-- 1. Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя
SELECT a.*
FROM EMPLOYEE a, EMPLOYEE b
WHERE b.EMP_ID = a.CHIEF_EMP_ID
and a.salary > b.salary

-- 2. Вывести список сотрудников, получающих максимальную заработную плату в своем отделе
SELECT a.*
FROM EMPLOYEE a
WHERE a.salary = 
( SELECT max(salary) FROM EMPLOYEE b
 WHERE b.dep_id = a.DEP_ID )

-- 3. Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек
SELECT dep_id
FROM EMPLOYEE
GROUP BY dep_id
HAVING COUNT(*) <= 3

-- 4. Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том-же отделе
SELECT  a.*
FROM  EMPLOYEE a
LEFT JOIN EMPLOYEE b ON (b.emp_id = a.chief_emp_id AND b.dep_id = a.dep_id)
WHERE b.emp_id IS null

-- 5. Найти список ID отделов с максимальной суммарной зарплатой сотрудников
WITH  dep_salary AS
(SELECT  dep_id, sum(salary) AS salary
 FROM  EMPLOYEE
 GROUP BY dep_id)
 SELECT dep_id
 FROM dep_salary
 WHERE  dep_salary.salary = (SELECT max(salary) FROM  dep_salary)

-- 6. Вывести список сотрудников с доходом от 30 000 и проживающих в гор. Химки
SELECT  e.emp_id
FROM  EMPLOYEE e 
JOIN EMPLOYEE_Address es ON e.emp_id = es.emp_id
WHERE  e.salary > 30000 AND es.Address LIKE '%Химки%'

-- 7. Разделить сотрудников на 5 групп случайным образом
SELECT 
(ROW_NUMBER() OVER(ORDER BY emp_id asc)) rownumber
, NTILE(5) OVER(ORDER BY RAND()) group_num
, t.*
FROM EMPLOYEE t

-- 8. Вывести список сотрудников с указанием суммарного дохода с предыдущими сотрудниками в пределах своего отдела накопительным итогом, отсортированным по возрастанию по доходу сотрудника для каждого подразделения (по каждому подразделению суммирование свое).


-- 9. Для чего нужны индексы
Индексы помогают ускорить поиск в базе данных. Если в выражении WHERE не задан индекс никакого столбца, SQL-сервер в поиске соответствия будет проверять каждую строку во всей таблице. 
Если данных много, эта операция может оказаться довольно медленной.
Индексы используются для поиска всех строк, совпадающих по каким-то столбцам, а затем уже в этих выборках ведется поиск нужных данных.
