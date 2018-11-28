-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pesticides forum work flow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pesticides forum work flow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pesticides forum work flow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pesticides forum work flow` ;

-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`customer` (
  `cid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phoneno` VARCHAR(45) NOT NULL,
  `gstin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `customer_name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `phoneno_UNIQUE` (`phoneno` ASC) VISIBLE,
  UNIQUE INDEX `gstin_UNIQUE` (`gstin` ASC) VISIBLE,
  INDEX `custome_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 105
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`booking_id`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`booking_id` (
  `Bid` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `cid` INT(11) NOT NULL,
  `otype` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Bid`),
  UNIQUE INDEX `cid_UNIQUE` (`cid` ASC) VISIBLE,
  CONSTRAINT `fk_customers`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`customer` (`cid`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`manufacturer` (
  `mid` INT(11) NOT NULL AUTO_INCREMENT,
  `m_name` VARCHAR(30) NOT NULL,
  `type` ENUM('pesticides', 'fertilizers', 'bio') NOT NULL COMMENT '\\n\\n\\n\\n\\n',
  `m_contact_no` INT(11) NOT NULL,
  `contact_pearson` VARCHAR(45) NOT NULL,
  `m_gst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mid`),
  UNIQUE INDEX `contact_pearson_UNIQUE` (`contact_pearson` ASC) VISIBLE,
  UNIQUE INDEX `m_gst_UNIQUE` (`m_gst` ASC) VISIBLE,
  UNIQUE INDEX `mid_UNIQUE` (`mid` ASC) VISIBLE,
  UNIQUE INDEX `m_name_UNIQUE` (`m_name` ASC) VISIBLE,
  UNIQUE INDEX `m_contact_no_UNIQUE` (`m_contact_no` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`contract` (
  `cid` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `mid` INT(11) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `conid_UNIQUE` (`cid` ASC) VISIBLE,
  INDEX `FK_PersonOrder` (`mid` ASC) VISIBLE,
  CONSTRAINT `FK_PersonOrder`
    FOREIGN KEY (`mid`)
    REFERENCES `pesticides forum work flow`.`manufacturer` (`mid`))
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`products` (
  `pid` INT(11) NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(40) NOT NULL,
  `mid` INT(11) NOT NULL,
  `100ml_cost` INT(11) NULL DEFAULT NULL,
  `250ml_cost` INT(11) NULL DEFAULT NULL,
  `500ml_cost` INT(11) NULL DEFAULT NULL,
  `1L_cost` INT(11) NULL DEFAULT NULL,
  `5L_cost` INT(11) NULL DEFAULT NULL,
  `10L_cost` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`pid`),
  INDEX `product_name` (`product_name` ASC) VISIBLE,
  INDEX `fk_m` (`mid` ASC) VISIBLE,
  CONSTRAINT `fk_m`
    FOREIGN KEY (`mid`)
    REFERENCES `pesticides forum work flow`.`manufacturer` (`mid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`volume_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`volume_products` (
  `vid` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`vid`))
ENGINE = InnoDB
AUTO_INCREMENT = 10001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`c_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`c_products` (
  `c_pid` INT(11) NOT NULL AUTO_INCREMENT,
  `cid` INT(11) NOT NULL,
  `pid` INT(11) NOT NULL,
  `p_quantity` INT(11) NULL DEFAULT NULL,
  `p_cost` INT(11) NOT NULL,
  `vid` INT(11) NOT NULL,
  PRIMARY KEY (`c_pid`),
  UNIQUE INDEX `c_pid_UNIQUE` (`c_pid` ASC) VISIBLE,
  INDEX `fk_contract_idx` (`cid` ASC) VISIBLE,
  INDEX `fk_products_idx` (`pid` ASC) VISIBLE,
  INDEX `fk_volumes_idx` (`vid` ASC) VISIBLE,
  CONSTRAINT `fk_contracts`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`contract` (`cid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product`
    FOREIGN KEY (`pid`)
    REFERENCES `pesticides forum work flow`.`products` (`pid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_volume`
    FOREIGN KEY (`vid`)
    REFERENCES `pesticides forum work flow`.`volume_products` (`vid`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`credit_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`credit_bill` (
  `cdid` INT(11) NOT NULL AUTO_INCREMENT,
  `credit_customerid` INT(11) NOT NULL,
  `balance_amount` INT(11) NULL DEFAULT NULL,
  `bill_amount` INT(11) NOT NULL,
  `due_date` DATE NOT NULL,
  PRIMARY KEY (`cdid`),
  UNIQUE INDEX `cdid_UNIQUE` (`cdid` ASC) VISIBLE,
  INDEX `fk_orders_idx` (`credit_customerid` ASC) INVISIBLE,
  CONSTRAINT `fk_orders`
    FOREIGN KEY (`credit_customerid`)
    REFERENCES `pesticides forum work flow`.`booking_id` (`cid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`credit_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`credit_customers` (
  `cid` INT(11) NULL DEFAULT NULL,
  `customer_name` VARCHAR(45) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`dead_lines of customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`dead_lines of customer` (
  `deaddate` DATE NOT NULL,
  `cid` INT(11) NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`due_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`due_dates` (
  `due_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cid` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `due_date` VARCHAR(45) NOT NULL,
  `due_cost` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`due_id`),
  UNIQUE INDEX `due_id_UNIQUE` (`due_id` ASC) VISIBLE,
  INDEX `fk_contract_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `fk_contract`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`contract` (`cid`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`order_details` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `bid` INT(11) NOT NULL,
  `pid` INT(11) NOT NULL,
  `product_cost` INT(11) NOT NULL,
  `vid` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Booking_idx` (`bid` ASC) VISIBLE,
  INDEX `fk_products_idx` (`pid` ASC) VISIBLE,
  INDEX `fk_volumes _idx` (`vid` ASC) VISIBLE,
  CONSTRAINT `fk_Booking`
    FOREIGN KEY (`bid`)
    REFERENCES `pesticides forum work flow`.`booking_id` (`Bid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products`
    FOREIGN KEY (`pid`)
    REFERENCES `pesticides forum work flow`.`products` (`pid`),
  CONSTRAINT `fk_volumes `
    FOREIGN KEY (`vid`)
    REFERENCES `pesticides forum work flow`.`volume_products` (`vid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `pesticides forum work flow` ;

-- -----------------------------------------------------
-- procedure sp_due_dates
-- -----------------------------------------------------

DELIMITER $$
USE `pesticides forum work flow`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_due_dates`( 
IN cid INT(4),
IN dat DATE,
IN Qunatity INT(4),
 IN cost INT(6)
 )
BEGIN
DECLARE total_cost INT DEFAULT 0;
Set total_cost= Qunatity * cost;
INSERT into due_dates(`cid`,`date`,`due_date`,`due_cost`) values 
(cid,dat,adddate(dat,45),total_cost);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
