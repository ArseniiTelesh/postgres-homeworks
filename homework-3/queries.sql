-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT company_name, CONCAT(employees.first_name,' ', employees.last_name) as employee
FROM customers
INNER JOIN employees USING (city)
WHERE customers.city = 'London' and employees.city = 'London' and customers.company_name = 'United Package'

-- ИЛИ

SELECT company_name, CONCAT(employees.first_name,' ', employees.last_name) as employee
FROM customers
INNER JOIN employees USING (city)
INNER JOIN shippers USING (company_name)
WHERE customers.city = 'London' and employees.city = 'London' and customers.company_name = shippers.company_name

-- ОБА НЕ ДАЮТ ОЖИДАЕМОГО ОТВЕТА, ТАК КАК В КОЛОНКЕ company_name НЕТ "United Package", А В ТАБЛИЦЕ customers НЕТ НИ ОДНОЙ СВЯЗУЮЩЕЙ КОЛОНКИ С ТАБЛИЦЕЙ shippers,
-- МОЖЕТ БЫТЬ ОШИБКА В ЗАДАНИИ, УТОЧНИТЕ ПОЖАЛУЙСТА? Я ПРОСМОТРЕЛ ВСЕ ТАБЛИЦЫ И НЕ СМОГ НАЙТИ СВЯЗЕЙ С 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone
FROM products
INNER JOIN suppliers USING(supplier_id)
where discontinued = 0 and units_in_stock < 25 and (category_id = 2 or category_id = 4)
ORDER BY units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT company_name
FROM customers
WHERE NOT EXISTS(SELECT customer_id FROM orders WHERE customers.customer_id = orders.customer_id)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT *
FROM (
    SELECT product_name
    FROM products
    INNER JOIN order_details USING(product_id)
    WHERE order_details.quantity = 10
) AS subquery