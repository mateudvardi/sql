--1. feladat
select ShipCity, COUNT(*) as 'NumberOfOrders' from Orders
group by ShipCity
order by COUNT(*) asc

--2. feladat
select top 10 ProductName, UnitPrice, UnitsInStock from Products
order by UnitsInStock desc

--3. feladat
select CategoryName, COUNT(*) as 'NumberOfProducts' , MAX(UnitPrice) as 'HighestPrice' from Categories
join Products on Categories.CategoryID = Products.CategoryID
group by CategoryName

--4. feladat
select Orders.OrderID, OrderDate, sum(Quantity) as 'TotalNumberOfProducts' from Orders
join [Order Details] on Orders.OrderID = [Order Details].OrderID
where YEAR(OrderDate) = 1996 and ShippedDate is not null
group by Orders.OrderID, OrderDate

--5. feladat
select ContactName as 'CustomerName', year(OrderDate) as 'Year', COUNT(Orders.OrderID) as 'TotalNumberOfOrders', SUM(Quantity) as 'TotalNumberOfProducts' from Customers
join Orders on Customers.CustomerID = Orders.CustomerID
join [Order Details] on Orders.OrderID = [Order Details].OrderID
where ShippedDate is not null
group by ContactName, year(OrderDate)

--6. feladat
select Employees.FirstName, Employees.LastName,COUNT(*) as 'NumberOfOrders',
Performance = case when COUNT(*) between 50 and 80 then 'low performer'
when COUNT(*) between 81 and 130 then 'good performer'
when COUNT(*) > 131 then 'high performer'
end
from Employees
join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName, Employees.LastName, Title
having COUNT(*) > 50 and Employees.Title = 'Sales representative'