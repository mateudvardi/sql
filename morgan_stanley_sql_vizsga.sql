--1. feladat
--Kérdezd le, hogy az egyes városokba összesen hány darab rendelésünk volt, darabszám szerint növekvő sorrendben.
select ShipCity, COUNT(*) as 'NumberOfOrders' from Orders
group by ShipCity
order by COUNT(*) asc

--2. feladat
--Kérdezd le a 10 legnagyobb készlettel rendelkező termék nevét, árát és készletét, készlet mennyiség szerint csökkenő sorrendben.
select top 10 ProductName, UnitPrice, UnitsInStock from Products
order by UnitsInStock desc

--3. feladat
--Kérdezd le, hogy az egyes termékkategóriákban hány darab különböző termékünk van és mi a legmagasabb ár?
select CategoryName, COUNT(*) as 'NumberOfProducts' , MAX(UnitPrice) as 'HighestPrice' from Categories
join Products on Categories.CategoryID = Products.CategoryID
group by CategoryName

--4. feladat
--Kérdezd le a rendelésszámot, rendelés dátumát és a rendeléshez tartozó termékek össz. darabszámát minden olyan rendeléshez, ami 1996-ban lett megrendelve és már ki lett szállítva.
select Orders.OrderID, OrderDate, sum(Quantity) as 'TotalNumberOfProducts' from Orders
join [Order Details] on Orders.OrderID = [Order Details].OrderID
where YEAR(OrderDate) = 1996 and ShippedDate is not null
group by Orders.OrderID, OrderDate

--5. feladat
--Kérdezd le a vevőink nevét és hogy az egyes években hány db rendelésük volt és mennyi terméket rendeltek, de csak a már kiszállított rendelésekre vonatkozóan.
select ContactName as 'CustomerName', year(OrderDate) as 'Year', COUNT(Orders.OrderID) as 'TotalNumberOfOrders', SUM(Quantity) as 'TotalNumberOfProducts' from Customers
join Orders on Customers.CustomerID = Orders.CustomerID
join [Order Details] on Orders.OrderID = [Order Details].OrderID
where ShippedDate is not null
group by ContactName, year(OrderDate)

--6. feladat
--Írj egy lekérdezést, ami megmutatja, hogy az egyes dolgozókhoz mennyi rendelés tartozik, valamint ez alapján sorold is be őket 3 kategóriába: rendelések száma 50 – 80: „low performer”; 81 – 130: „good performer”; >130: „high performer”. De csak azokat jelenítsd meg, akiknek legalább 50 rendelése van és Sales Representative beosztásúak.
select Employees.FirstName, Employees.LastName,COUNT(*) as 'NumberOfOrders',
Performance = case when COUNT(*) between 50 and 80 then 'low performer'
when COUNT(*) between 81 and 130 then 'good performer'
when COUNT(*) > 131 then 'high performer'
end
from Employees
join Orders on Orders.EmployeeID = Employees.EmployeeID
group by Employees.FirstName, Employees.LastName, Title
having COUNT(*) > 50 and Employees.Title = 'Sales representative'
