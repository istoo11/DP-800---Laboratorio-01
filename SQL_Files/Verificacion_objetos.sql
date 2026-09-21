 USE EcommerceDB;
 GO

 -- Verify constraints work
 -- This should fail: negative price
 INSERT INTO Product (ProductName, CategoryID, SupplierID, BasePrice, StockQuantity)
 VALUES ('Invalid', 1, 1, -50, 10);

 INSERT INTO OrderDetail (OrderLineID, OrderID, OrderDate, ProductID, Quantity, UnitPrice)
 VALUES 
     (NEXT VALUE FOR OrderLineSequence, 1, '2025-01-15', 1, 2, 99.99),
     (NEXT VALUE FOR OrderLineSequence, 1, '2025-01-15', 2, 1, 149.99),
     (NEXT VALUE FOR OrderLineSequence, 2, '2025-02-20', 1, 3, 99.99);
 GO