-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema us_congress_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema us_congress_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `us_congress_db` DEFAULT CHARACTER SET utf8 ;
USE `us_congress_db` ;

-- -----------------------------------------------------
-- Table `us_congress_db`.`bill_stage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`bill_stage` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`bill_stage` (
  `bill_stage_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `bill_stage_name` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`bill_stage_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`bill` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`bill` (
  `bill_id` INT(10) UNSIGNED NULL DEFAULT NULL AUTO_INCREMENT,
  `bill_code` VARCHAR(20) NULL DEFAULT NULL,
  `bill_description` VARCHAR(120) NULL DEFAULT NULL,
  `introduced_in_chamber` VARCHAR(20) NULL DEFAULT NULL COMMENT 'either \"Senate\" or \"House\"',
  `bill_introduction_date` DATE NULL DEFAULT NULL,
  `bill_stage_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `bill_stage_id_idx` (`bill_stage_id` ASC),
  CONSTRAINT `bill_stage_id`
    FOREIGN KEY (`bill_stage_id`)
    REFERENCES `us_congress_db`.`bill_stage` (`bill_stage_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`committee_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`committee_type` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`committee_type` (
  `committee_type_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `committee_type_description` VARCHAR(50) NULL DEFAULT NULL,
  `chamber_affiliation` VARCHAR(25) NULL DEFAULT NULL COMMENT 'There are 3 types of chamber affiliations: \"Senate\",\" House\", \"joint\"',
  PRIMARY KEY (`committee_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`committee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`committee` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`committee` (
  `committee_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `committee_type_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `committee_name` VARCHAR(100) NULL DEFAULT NULL,
  `committee_web_url` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`committee_id`),
  INDEX `committee_type_id_idx` (`committee_type_id` ASC),
  CONSTRAINT `committee_type_id`
    FOREIGN KEY (`committee_type_id`)
    REFERENCES `us_congress_db`.`committee_type` (`committee_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`political_party_affiliation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`political_party_affiliation` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`political_party_affiliation` (
  `political_affiliation_id` VARCHAR(2) NULL DEFAULT NULL COMMENT 'examples: \"R\" for Republican, \"D\" for Democratic, \"I\" for Independent, \"ID\" for Independent Democrat.',
  `political_affiliation_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`political_affiliation_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`member` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`member` (
  `member_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `member_first_name` VARCHAR(25) NULL DEFAULT NULL,
  `middle_name` VARCHAR(2) NULL DEFAULT NULL,
  `member_last_name` VARCHAR(25) NULL DEFAULT NULL,
  `member_gender` VARCHAR(1) NULL DEFAULT NULL,
  `member_state` VARCHAR(2) NULL DEFAULT NULL,
  `political_affiliation_id` VARCHAR(2) NULL DEFAULT NULL,
  `member_date_of_birth` DATE NULL DEFAULT NULL,
  `chamber` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_member_political_party_affiliation1_idx` (`political_affiliation_id` ASC),
  CONSTRAINT `fk_member_political_party_affiliation1`
    FOREIGN KEY (`political_affiliation_id`)
    REFERENCES `us_congress_db`.`political_party_affiliation` (`political_affiliation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`bill_sponsors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`bill_sponsors` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`bill_sponsors` (
  `bill_sponsors_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `bill_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `committee_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `member_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`bill_sponsors_id`),
  INDEX `commitee_id_idx` (`committee_id` ASC),
  INDEX `member_id_idx` (`member_id` ASC),
  INDEX `bill_id_idx` (`bill_id` ASC),
  CONSTRAINT `bill_id`
    FOREIGN KEY (`bill_id`)
    REFERENCES `us_congress_db`.`bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `commitee_id`
    FOREIGN KEY (`committee_id`)
    REFERENCES `us_congress_db`.`committee` (`committee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `member_id`
    FOREIGN KEY (`member_id`)
    REFERENCES `us_congress_db`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `us_congress_db`.`leadership_position`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `us_congress_db`.`leadership_position` ;

CREATE TABLE IF NOT EXISTS `us_congress_db`.`leadership_position` (
  `position_id` INT(11) NULL DEFAULT NULL,
  `position_name` VARCHAR(45) NULL DEFAULT NULL,
  `member_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `chamber_name` VARCHAR(10) NULL DEFAULT NULL,
  `term_start_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`position_id`),
  INDEX `fk_Position_member1_idx` (`member_id` ASC),
  CONSTRAINT `fk_Position_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `us_congress_db`.`member` (`member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
