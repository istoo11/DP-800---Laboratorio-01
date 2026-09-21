 USE EcommerceDB;
 GO

 -- Create Price History table with temporal versioning
 CREATE TABLE ProductPrice (
     PriceID INT PRIMARY KEY IDENTITY(1,1),
     ProductID INT NOT NULL,
     CurrentPrice DECIMAL(10,2) NOT NULL,
     EffectiveDate DATE,
     SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
     SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
     PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
     FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
 ) WITH (SYSTEM_VERSIONING = ON);
 GO

 -- Insert initial price data
 INSERT INTO ProductPrice (ProductID, CurrentPrice, EffectiveDate)
 VALUES (1, 99.99, '2025-01-01'), (2, 149.99, '2025-01-01');

 -- Update price (creates history entry)
 UPDATE ProductPrice SET CurrentPrice = 109.99 WHERE ProductID = 1;
 GO

 USE EcommerceDB;
 GO

 -- Query price history
 SELECT ProductID, CurrentPrice, SysStartTime, SysEndTime
 FROM ProductPrice
 FOR SYSTEM_TIME ALL
 WHERE ProductID = 1;