-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema RCSE_FFCentral
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema RCSE_FFCentral
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `RCSE_FFCentral` DEFAULT CHARACTER SET utf8 ;
USE `RCSE_FFCentral` ;

-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`usergroups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`usergroups` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`usergroups` (
  `usergroup` VARCHAR(64) NOT NULL,
  `priority` INT NOT NULL,
  `permissions` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`usergroup`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`users` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`users` (
  `login` VARCHAR(32) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `email` VARCHAR(128) NOT NULL,
  `usergroup` VARCHAR(64) NOT NULL,
  `brithdate` DATE NOT NULL,
  `regdate` DATE NOT NULL,
  `sex` VARCHAR(5) NOT NULL,
  `origin` VARCHAR(256) NOT NULL,
  `settings` VARCHAR(512) NOT NULL,
  PRIMARY KEY (`login`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC),
  INDEX `fk_users_usergroups_idx` (`usergroup` ASC),
  CONSTRAINT `fk_users_usergroups`
    FOREIGN KEY (`usergroup`)
    REFERENCES `RCSE_FFCentral`.`usergroups` (`usergroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`bans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`bans` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`bans` (
  `ban_id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(32) NOT NULL,
  `dateofban` DATETIME NOT NULL,
  `expirationdate` DATETIME NOT NULL,
  `reason` VARCHAR(64) NOT NULL,
  `prooflink` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`ban_id`),
  UNIQUE INDEX `ban_id_UNIQUE` (`ban_id` ASC),
  INDEX `fk_bans_users1_idx` (`login` ASC),
  CONSTRAINT `fk_bans_users1`
    FOREIGN KEY (`login`)
    REFERENCES `RCSE_FFCentral`.`users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`genres` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`genres` (
  `genre_id` INT UNSIGNED NOT NULL,
  `title_en` VARCHAR(45) NOT NULL,
  `title_ru` VARCHAR(45) NOT NULL,
  `title_ch` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE INDEX `genre_id_UNIQUE` (`genre_id` ASC),
  UNIQUE INDEX `title_en_UNIQUE` (`title_en` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`relationships`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`relationships` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`relationships` (
  `relation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title_en` VARCHAR(45) NOT NULL,
  `title_en_a` VARCHAR(45) NULL,
  `title_ru` VARCHAR(45) NOT NULL,
  `title_ru_a` VARCHAR(45) NULL,
  `title_ch` VARCHAR(45) NOT NULL,
  `title_ch_a` VARCHAR(45) NULL,
  `descr_en` TINYTEXT NOT NULL,
  `descr_ru` TINYTEXT NULL,
  `descr_ch` TINYTEXT NULL,
  PRIMARY KEY (`relation_id`),
  UNIQUE INDEX `relation_id_UNIQUE` (`relation_id` ASC),
  UNIQUE INDEX `title_en_UNIQUE` (`title_en` ASC),
  UNIQUE INDEX `title_en_a_UNIQUE` (`title_en_a` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_ru_a_UNIQUE` (`title_ru_a` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC),
  UNIQUE INDEX `title_ch_a_UNIQUE` (`title_ch_a` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`fandoms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`fandoms` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`fandoms` (
  `fandom_id` INT UNSIGNED NOT NULL,
  `title_ru` VARCHAR(45) NULL,
  `title_en` VARCHAR(45) NULL,
  `title_ch` VARCHAR(45) NULL,
  PRIMARY KEY (`fandom_id`),
  UNIQUE INDEX `fandom_id_UNIQUE` (`fandom_id` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_en_UNIQUE` (`title_en` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`characters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`characters` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`characters` (
  `character_id` INT UNSIGNED NOT NULL,
  `name_en` VARCHAR(45) NOT NULL,
  `name_ru` VARCHAR(45) NULL,
  `name_ch` VARCHAR(45) NULL,
  `fandom_id` INT UNSIGNED NOT NULL,
  `is_original` TINYINT UNSIGNED NOT NULL,
  `is_canonical` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`character_id`),
  UNIQUE INDEX `character_id_UNIQUE` (`character_id` ASC),
  UNIQUE INDEX `fandom_id_UNIQUE` (`fandom_id` ASC),
  CONSTRAINT `fk_characters_fandoms1`
    FOREIGN KEY (`fandom_id`)
    REFERENCES `RCSE_FFCentral`.`fandoms` (`fandom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`collections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`collections` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`collections` (
  `collection_id` INT UNSIGNED NOT NULL,
  `title_en` VARCHAR(45) NOT NULL,
  `title_ru` VARCHAR(45) NULL,
  `title_ch` VARCHAR(45) NULL,
  PRIMARY KEY (`collection_id`),
  UNIQUE INDEX `collection_id_UNIQUE` (`collection_id` ASC),
  UNIQUE INDEX `title_en_UNIQUE` (`title_en` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`ratings` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`ratings` (
  `rating_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title_en` VARCHAR(45) NOT NULL,
  `title_ru` VARCHAR(45) NULL,
  `title_ch` VARCHAR(45) NULL,
  `descr_en` MEDIUMTEXT NOT NULL,
  `descr_ru` MEDIUMTEXT NULL,
  `descr_ch` MEDIUMTEXT NULL,
  PRIMARY KEY (`rating_id`),
  UNIQUE INDEX `rating_id_UNIQUE` (`rating_id` ASC),
  UNIQUE INDEX `title_en_UNIQUE` (`title_en` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`notes` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`notes` (
  `note_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ` title_en` VARCHAR(45) NOT NULL,
  `title_ru` VARCHAR(45) NULL,
  `title_ch` VARCHAR(45) NULL,
  `descr_en` TINYTEXT NOT NULL,
  `descr_ru` TINYTEXT NULL,
  `descr_ch` TINYTEXT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE INDEX `note_id_UNIQUE` (`note_id` ASC),
  UNIQUE INDEX ` title_en_UNIQUE` (` title_en` ASC),
  UNIQUE INDEX `title_ru_UNIQUE` (`title_ru` ASC),
  UNIQUE INDEX `title_ch_UNIQUE` (`title_ch` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RCSE_FFCentral`.`fanfics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RCSE_FFCentral`.`fanfics` ;

CREATE TABLE IF NOT EXISTS `RCSE_FFCentral`.`fanfics` (
  `fanfic_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(512) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `chapters` INT UNSIGNED NOT NULL,
  `fandom_id` VARCHAR(512) NOT NULL,
  `genre_id` VARCHAR(512) NOT NULL,
  `relationship_id` VARCHAR(512) NOT NULL,
  `rating_id` VARCHAR(512) NULL,
  `collection_id` VARCHAR(512) NULL,
  `characters` VARCHAR(512) NOT NULL,
  `authors` VARCHAR(512) NOT NULL,
  `is_crossover` TINYINT NOT NULL,
  `note_id` VARCHAR(512) NULL,
  PRIMARY KEY (`fanfic_id`),
  UNIQUE INDEX `fanfic_id_UNIQUE` (`fanfic_id` ASC),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC),
  INDEX `fk_fanfics_genres1_idx` (`genre_id` ASC),
  INDEX `fk_fanfics_relationships1_idx` (`relationship_id` ASC),
  INDEX `fk_fanfics_characters1_idx` (`characters` ASC),
  INDEX `fk_fanfics_collections1_idx` (`collection_id` ASC),
  INDEX `fk_fanfics_fandoms1_idx` (`fandom_id` ASC),
  INDEX `fk_fanfics_ratings1_idx` (`rating_id` ASC),
  INDEX `fk_fanfics_notes1_idx` (`note_id` ASC),
  CONSTRAINT `fk_fanfics_genres1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `RCSE_FFCentral`.`genres` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_relationships1`
    FOREIGN KEY (`relationship_id`)
    REFERENCES `RCSE_FFCentral`.`relationships` (`relation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_characters1`
    FOREIGN KEY (`characters`)
    REFERENCES `RCSE_FFCentral`.`characters` (`character_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_collections1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `RCSE_FFCentral`.`collections` (`collection_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_fandoms1`
    FOREIGN KEY (`fandom_id`)
    REFERENCES `RCSE_FFCentral`.`fandoms` (`fandom_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_ratings1`
    FOREIGN KEY (`rating_id`)
    REFERENCES `RCSE_FFCentral`.`ratings` (`rating_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fanfics_notes1`
    FOREIGN KEY (`note_id`)
    REFERENCES `RCSE_FFCentral`.`notes` (`note_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
