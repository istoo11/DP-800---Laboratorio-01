USE EcommerceDB;
 GO

 -- Create partition function for order dates
 -- Use RANGE RIGHT for date columns to keep same-day values together
 CREATE PARTITION FUNCTION PF_OrderDate (DATE)
     AS RANGE RIGHT FOR VALUES 
     ('2025-01-01', '2025-04-01', '2025-07-01', '2025-10-01');

 -- Create partition scheme (single filegroup recommended)
 CREATE PARTITION SCHEME PS_OrderDate
     AS PARTITION PF_OrderDate ALL TO ([PRIMARY]);

 -- Create partitioned Order table
 -- Include OrderDate in primary key for clustered index alignment
 CREATE TABLE [Order] (
     OrderID BIGINT IDENTITY(1,1),
     OrderDate DATE NOT NULL,
     CustomerName NVARCHAR(100) NOT NULL,
     TotalAmount DECIMAL(12,2) NOT NULL,
     OrderStatus NVARCHAR(20) DEFAULT 'Pending',
     CONSTRAINT PK_Order PRIMARY KEY (OrderID, OrderDate),
     CHECK (TotalAmount > 0),
     CHECK (OrderStatus IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'))
 ) ON PS_OrderDate(OrderDate);

 -- Create partitioned index
 CREATE NONCLUSTERED INDEX IX_Order_Customer
     ON [Order](CustomerName)
     ON PS_OrderDate(OrderDate);
 GO

 -- Insert sample orders
 INSERT INTO [Order] (OrderDate, CustomerName, TotalAmount, OrderStatus) VALUES
     ('2025-01-15', 'John Smith', 299.97, 'Delivered'),
     ('2025-02-20', 'Jane Doe', 149.99, 'Shipped'),
     ('2025-06-10', 'Bob Johnson', 449.95, 'Processing');
 GO

  USE EcommerceDB;
 GO

 -- Query by partition
 SELECT 
     $PARTITION.PF_OrderDate(OrderDate) AS PartitionNumber,
     COUNT(*) AS OrdersInPartition,
     MIN(OrderDate) AS MinDate,
     MAX(OrderDate) AS MaxDate
 FROM [Order]
 GROUP BY $PARTITION.PF_OrderDate(OrderDate);