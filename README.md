# Laboratorio 01: Administración de Base de Datos y Características Avanzadas (DP-800)

Este repositorio contiene la documentación y los scripts de SQL Server desarrollados durante el **Laboratorio 01 de DP-800**, enfocados en la creación de bases de datos, el uso de tablas temporales con versionado del sistema, almacenamiento de metadatos semiestructurados en formato JSON, particionamiento de tablas y el uso de secuencias.

---

## 📋 Contenido del Laboratorio

1. **Creación de Base de Datos y Versionado del Sistema (Temporal Tables):**
   * Configuración de la base de datos `EcommerceDB`.
   * Creación de la tabla `ProductPrice` con soporte para `SYSTEM VERSIONING` (`SysStartTime`, `SysEndTime`).
   * Consultas históricas utilizando la cláusula `FOR SYSTEM TIME ALL`.

2. **Manejo de Datos Semi-estructurados con JSON:**
   * Adición de columnas de tipo `JSON` (`Metadata`) a la tabla `Product`.
   * Creación de columnas calculadas basadas en propiedades JSON (`Color`) con índices no agrupados asociados (`IX_Product_Metadata_Color`).
   * Inserción y filtrado de datos mediante funciones integradas como `JSON_VALUE`.

3. **Particionamiento de Tablas y Secuencias:**
   * Análisis de particiones existentes en la tabla de órdenes (`[Order]`) usando la función de partición `PF_OrderDate` y `$PARTITION`.
   * Creación de un objeto `SEQUENCE` (`OrderLineSequence`) para la generación automática de identificadores de línea.
   * Creación de la tabla transaccional `OrderDetail` con columnas calculadas (`LineTotal`), restricciones (`CHECK`), y claves foráneas compuestas.

4. **Validación e Integridad de Datos:**
   * Pruebas de restricciones de integridad (como `CHECK` constraints en precios base o cantidades).
   * Verificación completa del estado de la base de datos mediante scripts consolidados de comprobación.

---

## 🛠️ Tecnologías Utilizadas

* **Microsoft SQL Server** / Azure SQL Database.
* T-SQL (Transact-SQL).
* Características avanzadas de SQL Server:
  * *Temporal Tables* (Tablas con versionado del sistema).
  * Soporte nativo para *JSON*.
  * *Table Partitioning* (Particionamiento de tablas).
  * *Sequences* (Secuencias).

---


## 📌 Resultados de Validación

El laboratorio incluye consultas de comprobación para verificar:
* El historial de cambios de precios en `ProductPrice`.
* La correcta extracción de propiedades JSON (`Color`, `Size`, `Material`).
* La distribución de registros por partición en las tablas de órdenes.
* La efectividad de las restricciones (`CHECK`) ante inserciones inválidas.
