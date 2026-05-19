CREATE TABLE s_orders 
(
    OrderID VARCHAR(30),
    OrderDate DATE,
    RequiredDate DATE,
    ShipDate DATE,
    ProductID VARCHAR(10),
    CustomerID VARCHAR(10),
    Channel VARCHAR(50),
    SupplierID VARCHAR(10),
    WarehouseID VARCHAR(10),
    OrderQty INT,
    UnitPrice NUMERIC(10,2),
    DiscountPct NUMERIC(5,2),
    Revenue NUMERIC(12,2),
    UnitCost NUMERIC(10,2),
    COGS NUMERIC(12,2),
    GrossProfit NUMERIC(12,2),
    OTIF_Flag BOOLEAN,
    LateDays INT,
    StockoutFlag BOOLEAN,
    ReturnQty INT,
    WasteQty INT,
    QualityIssueFlag BOOLEAN,
    PromoFlag BOOLEAN
);

\copy s_orders from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_orders.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE s_customer (
    CustomerID VARCHAR(10) ,
    CustomerName VARCHAR(100),
    CustomerSegment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    SalesRegion VARCHAR(50),
    Priority VARCHAR(20)
);

\copy s_customer from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_customer.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE s_date (
    Date_Like_ID DATE ,
    Year INT,
    Quarter INT,
    MonthNo INT,
    MonthName VARCHAR(10),
    ISOWeek INT,
    DayName VARCHAR(10),
    IsWeekend BOOLEAN,
    IsSummer BOOLEAN,
    IsDecemberPeak BOOLEAN
);

\copy s_date from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_date.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE s_inventory 
(
    Date_Like_ID DATE,
    ProductID VARCHAR(10),
    WarehouseID VARCHAR(10),
    OpeningStock INT,
    ReceivedQty INT,
    ShippedQty INT,
    ClosingStock INT,
    ReorderPoint INT,
    StockoutFlag BOOLEAN,
    ExpiredQty INT
);

\copy s_inventory from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_inventory.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE S_Warehouse 
(
    WarehouseID VARCHAR(10) ,
    WarehouseName VARCHAR(100),
    Country VARCHAR(50),
    WarehouseRegion VARCHAR(50),
    CapacityPallets INT,
    ColdStorageFlag BOOLEAN
);

\copy s_warehouse from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_warehouse.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE s_product (
    ProductID VARCHAR(10) PRIMARY KEY,
    Category VARCHAR(50),
    Subcategory VARCHAR(50),
    Brand VARCHAR(50),
    ProductName VARCHAR(150),
    ShelfLifeDays INT,
    StorageType VARCHAR(30),
    UnitWeightKg NUMERIC(6,3),
    ListPrice NUMERIC(10,2),
    StandardCost NUMERIC(10,2)
);

\copy s_product from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_product.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE s_supplier 
(
    SupplierID VARCHAR(10) ,
    SupplierName VARCHAR(100),
    SupplierRegion VARCHAR(50),
    RiskTier VARCHAR(20),
    PlannedLeadTimeDays INT,
    ReliabilityPct NUMERIC(5,2),
    AvgDefectRate NUMERIC(6,4),
    City VARCHAR(50),
    Country VARCHAR(50),
    Latitude NUMERIC(8,5),
    Longitude NUMERIC(9,5)
);

\copy s_supplier from 'C:\Users\moham\OneDrive\Documents\Database\Used\Projects\Supply Chain Analytics\Rebuilded one\s_supplier.csv' with(format csv,HEADER true,DELIMITER',',ENCODING 'UTF8')

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Primary Keys
ALTER TABLE s_orders ADD PRIMARY KEY (OrderID);
ALTER TABLE s_customer ADD PRIMARY KEY (CustomerID);
ALTER TABLE s_date ADD PRIMARY KEY (Date_Like_ID);
ALTER TABLE s_inventory ADD PRIMARY KEY (Date_Like_ID, ProductID, WarehouseID);
ALTER TABLE s_warehouse ADD PRIMARY KEY (WarehouseID);
ALTER TABLE s_supplier ADD PRIMARY KEY (SupplierID);

-- Foreign Keys for relationships
ALTER TABLE s_orders
    ADD CONSTRAINT fk_orders_customer FOREIGN KEY (CustomerID) REFERENCES s_customer(CustomerID),
    ADD CONSTRAINT fk_orders_product FOREIGN KEY (ProductID) REFERENCES s_product(ProductID),
    ADD CONSTRAINT fk_orders_supplier FOREIGN KEY (SupplierID) REFERENCES s_supplier(SupplierID),
    ADD CONSTRAINT fk_orders_warehouse FOREIGN KEY (WarehouseID) REFERENCES s_warehouse(WarehouseID),
    ADD CONSTRAINT fk_orders_date FOREIGN KEY (OrderDate) REFERENCES s_date(Date_Like_ID);

ALTER TABLE s_inventory
    ADD CONSTRAINT fk_inventory_product FOREIGN KEY (ProductID) REFERENCES s_product(ProductID),
    ADD CONSTRAINT fk_inventory_warehouse FOREIGN KEY (WarehouseID) REFERENCES s_warehouse(WarehouseID),
    ADD CONSTRAINT fk_inventory_date FOREIGN KEY (Date_Like_ID) REFERENCES s_date(Date_Like_ID);
