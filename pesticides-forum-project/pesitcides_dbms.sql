-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pesticides forum work flow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pesticides forum work flow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pesticides forum work flow` ;
USE `pesticides forum work flow` ;

-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`manufacturer` (
  `mid` INT NOT NULL AUTO_INCREMENT,
  `m_name` TINYTEXT NOT NULL,
  `type` ENUM('pesticides', 'fertilizers', 'bio') NOT NULL COMMENT '\n\n\n\n\n',
  `m_contact_no` INT NOT NULL,
  `contact_pearson` VARCHAR(45) NOT NULL,
  `m_gst` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mid`),
  UNIQUE INDEX `contact_pearson_UNIQUE` (`contact_pearson` ASC) VISIBLE,
  UNIQUE INDEX `m_gst_UNIQUE` (`m_gst` ASC) VISIBLE,
  UNIQUE INDEX `mid_UNIQUE` (`mid` ASC) VISIBLE,
  INDEX `m_name` () VISIBLE,
  UNIQUE INDEX `m_name_UNIQUE` (`m_name` ASC) VISIBLE,
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE,
  UNIQUE INDEX `m_contact_no_UNIQUE` (`m_contact_no` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`products` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(40) NOT NULL,
  `mid` INT NOT NULL,
  `100ml_cost` INT NULL,
  `250ml_cost` INT NULL,
  `500ml_cost` INT NULL,
  `1L_cost` INT NULL,
  `5L_cost` INT NULL,
  `10L_cost` INT NULL,
  PRIMARY KEY (`pid`),
  INDEX `product_name` (`product_name` ASC) VISIBLE,
  UNIQUE INDEX `mid_UNIQUE` (`mid` ASC) VISIBLE,
  CONSTRAINT `fk_product_mid`
    FOREIGN KEY (`mid`)
    REFERENCES `pesticides forum work flow`.`manufacturer` (`mid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`customer` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phoneno` VARCHAR(45) NOT NULL,
  `gstin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE INDEX `customer_name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `phoneno_UNIQUE` (`phoneno` ASC) VISIBLE,
  UNIQUE INDEX `gstin_UNIQUE` (`gstin` ASC) VISIBLE,
  INDEX `custome_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`Booking_id`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`Booking_id` (
  `Bid` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `cid` INT NOT NULL,
  `otype` ENUM('cash', 'credit') NOT NULL,
  UNIQUE INDEX `cid_UNIQUE` (`cid` ASC) VISIBLE,
  PRIMARY KEY (`Bid`),
  CONSTRAINT `fk_customers`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`customer` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`contract` (
  `cid` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `mid` INT NOT NULL,
  UNIQUE INDEX `conid_UNIQUE` (`cid` ASC) VISIBLE,
  UNIQUE INDEX `mid_UNIQUE` (`mid` ASC) VISIBLE,
  PRIMARY KEY (`cid`),
  CONSTRAINT `fk_manufacture`
    FOREIGN KEY (`mid`)
    REFERENCES `pesticides forum work flow`.`manufacturer` (`mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`due_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`due_dates` (
  `due_id` INT NOT NULL AUTO_INCREMENT,
  `cid` INT NOT NULL,
  `date` DATE NOT NULL,
  `due_date` VARCHAR(45) NOT NULL,
  `due_cost` INT NOT NULL,
  PRIMARY KEY (`due_id`),
  UNIQUE INDEX `due_id_UNIQUE` (`due_id` ASC) VISIBLE,
  INDEX `fk_contract_idx` (`cid` ASC) VISIBLE,
  CONSTRAINT `fk_contract`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`contract` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '											';


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`credit_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`credit_bill` (
  `cdid` INT NOT NULL AUTO_INCREMENT,
  `credit_customerid` INT NOT NULL,
  `balance_amount` INT NULL,
  `bill_amount` INT NOT NULL,
  `due_date` DATE NOT NULL,
  PRIMARY KEY (`cdid`),
  UNIQUE INDEX `cdid_UNIQUE` (`cdid` ASC) VISIBLE,
  INDEX `fk_orders_idx` (`credit_customerid` ASC) INVISIBLE,
  CONSTRAINT `fk_orders`
    FOREIGN KEY (`credit_customerid`)
    REFERENCES `pesticides forum work flow`.`Booking_id` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`order_details` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `bid` INT NOT NULL,
  `pid` INT NOT NULL,
  `product_cost` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Booking_idx` (`bid` ASC) VISIBLE,
  INDEX `fk_products_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_Booking`
    FOREIGN KEY (`bid`)
    REFERENCES `pesticides forum work flow`.`Booking_id` (`Bid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products`
    FOREIGN KEY (`pid`)
    REFERENCES `pesticides forum work flow`.`products` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pesticides forum work flow`.`c_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pesticides forum work flow`.`c_products` (
  `c_pid` INT NOT NULL AUTO_INCREMENT,
  `cid` INT NOT NULL,
  `pid` INT NOT NULL,
  `p_quantity` INT NULL,
  `p_cost` INT NULL,
  PRIMARY KEY (`c_pid`),
  UNIQUE INDEX `c_pid_UNIQUE` (`c_pid` ASC) VISIBLE,
  INDEX `fk_contract_idx` (`cid` ASC) VISIBLE,
  INDEX `fk_products_idx` (`pid` ASC) VISIBLE,
  CONSTRAINT `fk_contract`
    FOREIGN KEY (`cid`)
    REFERENCES `pesticides forum work flow`.`contract` (`cid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products`
    FOREIGN KEY (`pid`)
    REFERENCES `pesticides forum work flow`.`products` (`pid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
