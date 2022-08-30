-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flight booking system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flight booking system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flight booking system` DEFAULT CHARACTER SET utf8 ;
USE `flight booking system` ;

-- -----------------------------------------------------
-- Table `flight booking system`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`airlines` (
  `airline_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`flight` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `airline_id` INT NOT NULL,
  `number` VARCHAR(50) NOT NULL,
  `departure_date_time` DATETIME NULL,
  `arrival_date_time` DATETIME NOT NULL,
  `duration_in_minutes` INT NULL,
  `distance_in_miles` INT NULL,
  `departure_airport_id` INT NULL,
  `arrival_airport_id` INT NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_flight_airlines1_idx` (`airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_flight_airlines`
    FOREIGN KEY (`airline_id`)
    REFERENCES `flight booking system`.`airlines` (`airline_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`passengers` (
  `passenger_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `second_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `flight_id` INT NOT NULL,
  `passenger_id` INT NOT NULL,
  `ticket_number` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  `confirmation_number` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_tickets_flight1_idx` (`flight_id` ASC) VISIBLE,
  INDEX `fk_tickets_passengers1_idx` (`passenger_id` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_flight`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flight booking system`.`flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_passengers`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `flight booking system`.`passengers` (`passenger_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`flight_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`flight_class` (
  `ticket_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  INDEX `fk_flight_class_tickets_idx` (`ticket_id` ASC) VISIBLE,
  PRIMARY KEY (`ticket_id`),
  CONSTRAINT `fk_flight_class_tickets`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `flight booking system`.`tickets` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`airport` (
  `airport_id` INT NOT NULL AUTO_INCREMENT,
  `aitacode` VARCHAR(50) NOT NULL,
  `name` VARCHAR(225) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight booking system`.`flight_airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight booking system`.`flight_airports` (
  `flight_id` INT NOT NULL,
  `airport_id` INT NOT NULL,
  INDEX `fk_flight_airports_flight1_idx` (`flight_id` ASC) VISIBLE,
  INDEX `fk_flight_airports_airport1_idx` (`airport_id` ASC) VISIBLE,
  PRIMARY KEY (`flight_id`, `airport_id`),
  CONSTRAINT `fk_flight_airports_flight1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flight booking system`.`flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_airports_airport1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `flight booking system`.`airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
