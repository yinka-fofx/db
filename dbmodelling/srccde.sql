-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema JethronEstateDb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema JethronEstateDb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `JethronEstateDb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `JethronEstateDb` ;

-- -----------------------------------------------------
-- Table `JethronEstateDb`.`user_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`user_category` (
  `USER_CAT_ID` INT NOT NULL,
  `USER_CAT_NAME` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`USER_CAT_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JethronEstateDb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`users` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `USER_FIRSTNAME` VARCHAR(30) NOT NULL,
  `USER_LASTNAME` VARCHAR(30) NOT NULL,
  `USER_ADDRESS` TEXT(500) NOT NULL,
  `USER_DOB` DATETIME(6) NOT NULL,
  `USER_PHONE` VARCHAR(15) NOT NULL,
  `USER_EMAIL` VARCHAR(100) NOT NULL,
  `USER_CAT_ID` INT NOT NULL,
  `GENDER` ENUM('Male', 'Female') NULL DEFAULT 'Male',
  `USER_STATUS` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`USER_ID`),
  INDEX `fk_user_cat_id_idx` (`USER_CAT_ID` ASC),
  CONSTRAINT `fk_user_cat_id`
    FOREIGN KEY (`USER_CAT_ID`)
    REFERENCES `JethronEstateDb`.`user_category` (`USER_CAT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JethronEstateDb`.`house_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`house_category` (
  `HOUSE_CAT_ID` INT NOT NULL AUTO_INCREMENT,
  `HOUSE_CAT-NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`HOUSE_CAT_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JethronEstateDb`.`house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`house` (
  `HOUSE_ID` INT NOT NULL AUTO_INCREMENT,
  `HOUSE-CAT_ID` INT NOT NULL,
  `HOUSE-ADDRESS` TEXT(300) NOT NULL,
  `HOUSE _OWNER` INT NOT NULL,
  PRIMARY KEY (`HOUSE_ID`),
  INDEX `fk_house_cat_id_idx` (`HOUSE-CAT_ID` ASC),
  INDEX `fk_user_id_idx` (`HOUSE _OWNER` ASC),
  CONSTRAINT `fk_house_cat_id`
    FOREIGN KEY (`HOUSE-CAT_ID`)
    REFERENCES `JethronEstateDb`.`house_category` (`HOUSE_CAT_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_house_owner`
    FOREIGN KEY (`HOUSE _OWNER`)
    REFERENCES `JethronEstateDb`.`users` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JethronEstateDb`.`dues_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`dues_category` (
  `DUES-CAT_ID` INT NOT NULL AUTO_INCREMENT,
  `DUES-CAT-NAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DUES-CAT_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JethronEstateDb`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `JethronEstateDb`.`payments` (
  `PAYMENT_ID` INT NOT NULL AUTO_INCREMENT,
  `PAYMENT-DATE` DATETIME(6) NOT NULL,
  `PAID_BY` INT NOT NULL,
  `PAYMENT_FOR` VARCHAR(100) NOT NULL,
  `PAYMENT_TYPE` INT NOT NULL,
  `AMOUNT` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`PAYMENT_ID`),
  INDEX `fk_dues_cat_id_idx` (`PAYMENT_TYPE` ASC),
  INDEX `fk_paid_by_idx` (`PAID_BY` ASC),
  CONSTRAINT `fk_dues_cat_id`
    FOREIGN KEY (`PAYMENT_TYPE`)
    REFERENCES `JethronEstateDb`.`dues_category` (`DUES-CAT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paid_by`
    FOREIGN KEY (`PAID_BY`)
    REFERENCES `JethronEstateDb`.`users` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
