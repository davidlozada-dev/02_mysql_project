# 02_mysql_project

__Project's status: *finished*__ :heavy_check_mark:

## Index

1. [Introduction](#1-Introduction)

	1.[Motivation behind the project](#11-Motivation-behind-the-project)

	2.[Naming convention](#12-Naming-convention)

	3.[Database schemas](#13-Database-schemas )

1. [Technical aspects](#2-Technical-aspects)

	1.[Triggers](#21-Triggers)

	2.[View](#22-View)

1. [Contributor](#3-Contributor)

## 1 Introduction

### 1.1 Motivation behind the project
	
This project's main purpose is to put into practice SQL structures such as triggers and views, by taking a fictitious car dealearship case whose relational database schemas that must be followed are sketched with the designing tool __Dia__. To spice things up, all the  SQL statements are created and run in the __MySQL Command-Line__ and the resulting database is exported as a SQL file with __HeidiSQL__. 

#### Technologies/tools used for this project
	
	1. Dia
	2. HeidiSQL
	3. MySQL

### 1.2 Naming convention

1. The __table names__ are in plural and lowercase. 
	
	>E.g: *__users__*.

1. The __column names__ are fully human-readable, in order to make that possible the names are in singular and use camelCase naming practice followed by an underscore and then the first three letters of the table's name where each column belongs to. 
	
	>E.g: *__userName_use__*. This is a column that belongs to a table called "users".

1. The __primary key column names__ use as default name "ID" followed by an underscore and then the first three letters of the table's name where each primary key column belongs to.

### 1.3 Database schemas 
#### Related tables
The 1st schema shows the tables that are in the database and how they are related to each other through one-to-many relationships.

![01 schema](https://raw.githubusercontent.com/davidlozada-dev/02_mysql_project/master/img/02_mysql_project_db_schema_01.png)

#### Non-related tables
The 2nd schema show the tables thar are not related with each other in the database, these have as main function to backup all the data from the related tables.

![02 schema](https://raw.githubusercontent.com/davidlozada-dev/02_mysql_project/master/img/02_mysql_project_db_schema_02.png)

## 2 Technical aspects

### 2.1 Triggers

#### 01_backup_trigger_cars

The *01_backup_trigger_cars* is a trigger that makes a copy of the record from the __cars table__ in the __cars_backup table__ before it is deleted.

```SQL
DELIMITER //

CREATE TRIGGER 01_backup_trigger_cars BEFORE DELETE ON cars FOR EACH ROW 
BEGIN
INSERT INTO cars_backup VALUES(
old.id_car, old.model_car, old.manufacturer_car, old.price_car, old.stock_car
);
END//

DELIMITER ;
```
---

##### 02_backup_trigger_orders

The *02_backup_trigger_orders* is a trigger that makes a copy of the record from the __orders table__ in the __orders_backup table__ before it is deleted.

```SQL
DELIMITER //

CREATE TRIGGER 02_backup_trigger_orders BEFORE DELETE ON orders FOR EACH ROW
BEGIN
INSERT INTO orders_backup VALUES(
old.id_ord, old.id_cli, old.id_car, old.quantity_ord, old.date_ord
);
END//

DELIMITER ;
```
---

#### 03_backup_trigger_clients

The *03_backup_trigger_clients* is a trigger that makes a copy of the record from the __clients table__ in the __clients_backup table__ before it is deleted.

```SQL
DELIMITER //

CREATE TRIGGER 03_backup_trigger_clients BEFORE DELETE ON clients FOR EACH ROW
BEGIN
INSERT INTO clients_backup VALUES(
old.id_cli, old.id_sel, old.name_cli, old.city_cli, old.payment_cli
);
END//

DELIMITER ;
```
---

#### 04_backup_trigger_sellers

The *04_backup_trigger_sellers* is a trigger that makes a copy of the record from the __sellers table__ in the __sellers_backup table__ before it is deleted.

```SQL
DELIMITER //

CREATE TRIGGER 04_backup_trigger_sellers BEFORE DELETE ON sellers FOR EACH ROW
BEGIN
INSERT INTO sellers_backup VALUES(
old.id_sel, old.id_gro, old.name_sel, old.surname_sel, old.charge_sel, old.salary_sel, old.commissionForSales_sel, old.manager_sel, old.hiringDate_sel
);
END//

DELIMITER ;
```
---

#### 05_backup_trigger_groups

The *05_backup_trigger_groups* is a trigger that makes a copy of the record from the __groups table__ in the __groups_backup table__ before it is deleted.

```SQL
DELIMITER //

CREATE TRIGGER 05_backup_trigger_groups BEFORE DELETE ON groups FOR EACH ROW
BEGIN
INSERT INTO groups_backup VALUES(
old.id_gro, old.name_gro, old.country_gro
);
END//

DELIMITER ;
```
---

#### stop_order_making_trigger

The *stop_order_making_trigger* is a trigger that prevents making an order if the car model is out of stock, at the same time it shows an error message.

```SQL
DELIMITER //

CREATE TRIGGER stop_order_making_trigger BEFORE INSERT ON orders FOR EACH ROW
BEGIN 
SET @stock = (SELECT stock_car FROM cars WHERE id_car = new.id_car);
IF @stock = 0 THEN signal sqlstate '45000' SET message_text = 'You can\'t order this car because its stock is empty, please try other model';
END IF;
END//

DELIMITER ;
```
---

#### update_stock_trigger

The *update_stock_trigger* is a trigger that updates the quantity available in stock of a car model once an order is made.

```SQL
DELIMITER //

CREATE TRIGGER update_stock_trigger BEFORE INSERT ON orders FOR EACH ROW
BEGIN
UPDATE cars SET cars.stock_car = cars.stock_car - new.quantity_ord WHERE cars.id_car = new.id_car;
END//

DELIMITER ;
```
---

### 2.2 View 

#### bills_view

The *bills_view* shows the basic bill information using the data stored in the __cars__, __clients__ and __orders__ tables

```SQL
DROP TABLE IF EXISTS `bills_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `bills_view` AS select `o`.`id_ord` AS `Order's ID`,`o`.`quantity_ord` AS `Units`,
`o`.`date_ord` AS `Date of Purchase`,`k`.`name_cli` AS `Client's Full Name`,`c`.`model_car` AS `Car's Model`,`c`.`manufacturer_car` AS `Car's Manufacturer`,
`c`.`price_car` AS `Car's Price`,`k`.`payment_cli` AS `Client's Payment` from ((`orders` `o` join `cars` `c` on((`o`.`id_car` = `c`.`id_car`))) join `clients` `k` on((`o`.`id_cli` = `k`.`id_cli`)));

```

--- 

## 3 Contributor

Copyright © 2021 __David Lozada__