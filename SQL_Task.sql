
-- 1.List all customers

SELECT * FROM Customers;

-- 2. Find all orders placed in January 2023

SELECT OrderID, CustomerID, OrderDate
FROM Orders
WHERE OrderDate >= '2023-01-01' AND OrderDate <= '2023-01-31';

-- For full details
SELECT c.FirstName, c.Email, o.OrderDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '2023-01-01' AND o.OrderDate <= '2023-01-31';

-- 3. Get the details of each order, including the customer name and email

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, c.Email
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 4. List the products purchased in a specific order (e.g., OrderID = 1)

SELECT p.ProductName, oi.Quantity
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE oi.OrderID = 1;

-- 5. Calculate the total amount spent by each customer

SELECT c.CustomerID, c.FirstName, c.LastName,
    SUM(p.Price * oi.Quantity) AS TotalSpent
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 6. Find the most popular product (the one that has been ordered the most)

SELECT p.ProductID, p.ProductName,
    SUM(oi.Quantity) AS TotalQuantity
FROM Products p
INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;

-- 7. Get the total number of orders and the total sales amount for each month in 2023

SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(p.Price * oi.Quantity) AS TotalSalesAmount
FROM Orders o
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE YEAR(o.OrderDate) = 2023
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m');

-- 8. Find customers who have spent more than $1000

SELECT c.CustomerID, c.FirstName, c.LastName,
    SUM(p.Price * oi.Quantity) AS TotalSpent
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING SUM(p.Price * oi.Quantity) > 1000;