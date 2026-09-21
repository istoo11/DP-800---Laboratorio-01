 USE EcommerceDB;
 GO

 -- Verify JSON queries work
 SELECT ProductName, JSON_VALUE(Metadata, '$.color') AS Color
 FROM Product
 WHERE Metadata IS NOT NULL;

 -- Verify partitioning
 SELECT $PARTITION.PF_OrderDate(OrderDate) AS Partition, COUNT(*) AS RecordCount
 FROM [Order]
 GROUP BY $PARTITION.PF_OrderDate(OrderDate);

 -- Verify temporal table
 SELECT ProductID, CurrentPrice, SysStartTime, SysEndTime
 FROM ProductPrice FOR SYSTEM_TIME ALL
 ORDER BY ProductID, SysStartTime;