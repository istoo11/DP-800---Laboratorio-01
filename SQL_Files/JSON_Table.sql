 USE EcommerceDB;
 GO

 ALTER TABLE Product ADD Metadata JSON;
 GO
 ALTER TABLE Product ADD MetadataColor AS JSON_VALUE(Metadata, '$.color');
 GO
 CREATE NONCLUSTERED INDEX IX_Product_Metadata_Color
     ON Product (MetadataColor);
 GO
 UPDATE Product SET Metadata = N'{"color":"blue","size":"large","material":"cotton"}'
 WHERE ProductID = 1;
 UPDATE Product SET Metadata = N'{"color":"red","size":"small","material":"silk"}'
 WHERE ProductID = 2;
 GO

 SELECT 
     ProductID,
     ProductName,
     JSON_VALUE(Metadata, '$.color') AS Color,
     JSON_VALUE(Metadata, '$.size') AS Size,
     JSON_VALUE(Metadata, '$.material') AS Material
 FROM Product
 WHERE JSON_VALUE(Metadata, '$.color') = 'blue';