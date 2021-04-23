-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.26 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for 02_mysql_project
CREATE DATABASE IF NOT EXISTS `02_mysql_project` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `02_mysql_project`;

-- Dumping structure for view 02_mysql_project.bills_view
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `bills_view` (
	`Order's ID` INT(100) NOT NULL,
	`Units` INT(100) NOT NULL,
	`Date of Purchase` TIMESTAMP NOT NULL,
	`Client's Full Name` VARCHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Car's Model` VARCHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Car's Manufacturer` VARCHAR(100) NOT NULL COLLATE 'latin1_swedish_ci',
	`Car's Price` DECIMAL(22,2) NOT NULL,
	`Client's Payment` DECIMAL(22,2) NOT NULL
) ENGINE=MyISAM;

-- Dumping structure for table 02_mysql_project.cars
CREATE TABLE IF NOT EXISTS `cars` (
  `ID_car` int(100) NOT NULL AUTO_INCREMENT,
  `model_car` varchar(100) NOT NULL,
  `manufacturer_car` varchar(100) NOT NULL,
  `price_car` decimal(22,2) NOT NULL,
  `stock_car` int(100) NOT NULL,
  PRIMARY KEY (`ID_car`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.cars: 0 rows
/*!40000 ALTER TABLE `cars` DISABLE KEYS */;
/*!40000 ALTER TABLE `cars` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.cars_backup
CREATE TABLE IF NOT EXISTS `cars_backup` (
  `ID_car` int(100) DEFAULT NULL,
  `model_car` varchar(100) DEFAULT NULL,
  `manufacturer_car` varchar(100) DEFAULT NULL,
  `price_car` decimal(22,2) DEFAULT NULL,
  `stock_car` int(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.cars_backup: 0 rows
/*!40000 ALTER TABLE `cars_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `cars_backup` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `ID_cli` int(100) NOT NULL AUTO_INCREMENT,
  `ID_sel` int(100) NOT NULL,
  `name_cli` varchar(100) NOT NULL,
  `city_cli` varchar(100) NOT NULL,
  `payment_cli` decimal(22,2) NOT NULL,
  PRIMARY KEY (`ID_cli`),
  KEY `ID_sel` (`ID_sel`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.clients: 0 rows
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.clients_backup
CREATE TABLE IF NOT EXISTS `clients_backup` (
  `ID_cli` int(100) DEFAULT NULL,
  `ID_sel` int(100) DEFAULT NULL,
  `name_cli` varchar(100) DEFAULT NULL,
  `city_cli` varchar(100) DEFAULT NULL,
  `payment_cli` decimal(22,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.clients_backup: 0 rows
/*!40000 ALTER TABLE `clients_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients_backup` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `ID_gro` int(100) NOT NULL AUTO_INCREMENT,
  `name_gro` varchar(100) NOT NULL,
  `country_gro` enum('Australia','Canada','Ireland','New Zealand','UK','USA') NOT NULL,
  PRIMARY KEY (`ID_gro`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.groups: 0 rows
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.groups_backup
CREATE TABLE IF NOT EXISTS `groups_backup` (
  `ID_gro` int(100) DEFAULT NULL,
  `name_gro` varchar(100) DEFAULT NULL,
  `country_gro` enum('Australia','Canada','Ireland','New Zealand','UK','USA') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.groups_backup: 0 rows
/*!40000 ALTER TABLE `groups_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_backup` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `ID_ord` int(100) NOT NULL AUTO_INCREMENT,
  `ID_cli` int(100) NOT NULL,
  `ID_car` int(100) NOT NULL,
  `quantity_ord` int(100) NOT NULL,
  `date_ord` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_ord`),
  KEY `ID_cli` (`ID_cli`),
  KEY `ID_car` (`ID_car`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.orders: 0 rows
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.orders_backup
CREATE TABLE IF NOT EXISTS `orders_backup` (
  `ID_ord` int(100) DEFAULT NULL,
  `ID_cli` int(100) DEFAULT NULL,
  `ID_car` int(100) DEFAULT NULL,
  `quantity_ord` int(100) DEFAULT NULL,
  `date_ord` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.orders_backup: 0 rows
/*!40000 ALTER TABLE `orders_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_backup` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.sellers
CREATE TABLE IF NOT EXISTS `sellers` (
  `ID_sel` int(100) NOT NULL AUTO_INCREMENT,
  `ID_gro` int(100) NOT NULL,
  `name_sel` varchar(100) NOT NULL,
  `surname_sel` varchar(100) NOT NULL,
  `charge_sel` enum('M','S') NOT NULL,
  `salary_sel` decimal(22,2) NOT NULL,
  `commissionForSales_sel` int(2) NOT NULL,
  `manager_sel` int(100) DEFAULT NULL,
  `hiringDate_sel` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_sel`),
  KEY `ID_gro` (`ID_gro`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.sellers: 0 rows
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;

-- Dumping structure for table 02_mysql_project.sellers_backup
CREATE TABLE IF NOT EXISTS `sellers_backup` (
  `ID_sel` int(100) DEFAULT NULL,
  `ID_gro` int(100) DEFAULT NULL,
  `name_sel` varchar(100) DEFAULT NULL,
  `surname_sel` varchar(100) DEFAULT NULL,
  `charge_sel` enum('M','S') DEFAULT NULL,
  `salary_sel` decimal(22,2) DEFAULT NULL,
  `commissionForSales_sel` int(2) DEFAULT NULL,
  `manager_sel` int(100) DEFAULT NULL,
  `hiringDate_sel` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table 02_mysql_project.sellers_backup: 0 rows
/*!40000 ALTER TABLE `sellers_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `sellers_backup` ENABLE KEYS */;

-- Dumping structure for trigger 02_mysql_project.01_backup_trigger_cars
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER 01_backup_trigger_cars BEFORE DELETE ON cars FOR EACH ROW 
BEGIN
INSERT INTO cars_backup VALUES(
old.ID_car, old.model_car, old.manufacturer_car, old.price_car, old.stock_car
);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.02_backup_trigger_orders
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER 02_backup_trigger_orders BEFORE DELETE ON orders FOR EACH ROW
BEGIN
INSERT INTO orders_backup VALUES(
old.ID_ord, old.ID_cli, old.ID_car, old.quantity_ord, old.date_ord
);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.03_backup_trigger_clients
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER 03_backup_trigger_clients BEFORE DELETE ON clients FOR EACH ROW
BEGIN
INSERT INTO clients_backup VALUES(
old.ID_cli, old.ID_sel, old.name_cli, old.city_cli, old.payment_cli
);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.04_backup_trigger_sellers
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER 04_backup_trigger_sellers BEFORE DELETE ON sellers FOR EACH ROW
BEGIN
INSERT INTO sellers_backup VALUES(
old.ID_sel, old.ID_gro, old.name_sel, old.surname_sel, old.charge_sel, old.salary_sel, old.commissionForSales_sel, old.manager_sel, old.hiringDate_sel
);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.05_backup_trigger_groups
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER 05_backup_trigger_groups BEFORE DELETE ON groups FOR EACH ROW
BEGIN
INSERT INTO groups_backup VALUES(
old.ID_gro, old.name_gro, old.country_gro
);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.stop_order_making_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER stop_order_making_trigger BEFORE INSERT ON orders FOR EACH ROW
BEGIN 
SET @stock = (SELECT stock_car FROM cars WHERE ID_car = new.ID_car);
IF @stock = 0 THEN signal sqlstate '45000' SET message_text = 'You can\'t order this car because its stock is empty, please try other model';
END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger 02_mysql_project.update_stock_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER update_stock_trigger BEFORE INSERT ON orders FOR EACH ROW
BEGIN
UPDATE cars SET cars.stock_car = cars.stock_car - new.quantity_ord WHERE cars.ID_car = new.ID_car;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for view 02_mysql_project.bills_view
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `bills_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `bills_view` AS select `o`.`ID_ord` AS `Order's ID`,`o`.`quantity_ord` AS `Units`,
`o`.`date_ord` AS `Date of Purchase`,`k`.`name_cli` AS `Client's Full Name`,`c`.`model_car` AS `Car's Model`,`c`.`manufacturer_car` AS `Car's Manufacturer`,
`c`.`price_car` AS `Car's Price`,`k`.`payment_cli` AS `Client's Payment` from ((`orders` `o` join `cars` `c` on((`o`.`ID_car` = `c`.`ID_car`))) join `clients` `k` on((`o`.`ID_cli` = `k`.`ID_cli`)));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
