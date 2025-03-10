-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inegi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inegi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inegi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `inegi` ;

-- -----------------------------------------------------
-- Table `inegi`.`actividades_economicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`actividades_economicas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`tipo_asentamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`tipo_asentamiento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`asentamientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`asentamientos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(70) NOT NULL,
  `id_tipo_asentamiento` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tipo_asentamiento_idx` (`id_tipo_asentamiento` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_asentamiento`
    FOREIGN KEY (`id_tipo_asentamiento`)
    REFERENCES `inegi`.`tipo_asentamiento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`contacto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `telefono` VARCHAR(11) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `website` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`razones_sociales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`razones_sociales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`localidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`municipios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`tipo_vialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`tipo_vialidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`ubicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`ubicaciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_exterior` INT NULL DEFAULT NULL,
  `edificio` VARCHAR(50) NULL DEFAULT NULL,
  `codigo_postal` VARCHAR(50) NULL DEFAULT NULL,
  `id_tipo_vial` INT NOT NULL,
  `id_asentamiento` INT NOT NULL,
  `id_municipio` INT NOT NULL,
  `id_localidad` INT NOT NULL,
  `lat` VARCHAR(100) NULL DEFAULT NULL,
  `lng` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_tipo_vial_idx` (`id_tipo_vial` ASC) VISIBLE,
  INDEX `fk_asentamiento_idx` (`id_asentamiento` ASC) VISIBLE,
  INDEX `fk_municipio_idx` (`id_municipio` ASC) VISIBLE,
  INDEX `fk_localidad_idx` (`id_localidad` ASC) VISIBLE,
  CONSTRAINT `fk_asentamiento`
    FOREIGN KEY (`id_asentamiento`)
    REFERENCES `inegi`.`asentamientos` (`id`),
  CONSTRAINT `fk_localidad`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `inegi`.`localidades` (`id`),
  CONSTRAINT `fk_municipio`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `inegi`.`municipios` (`id`),
  CONSTRAINT `fk_tipo_vial`
    FOREIGN KEY (`id_tipo_vial`)
    REFERENCES `inegi`.`tipo_vialidad` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inegi`.`establecimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inegi`.`establecimientos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NOT NULL,
  `id_razon_social` INT NOT NULL,
  `id_act` INT NOT NULL,
  `id_contacto` INT NOT NULL,
  `id_ubicacion` INT NOT NULL,
  `fecha_alta` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_ubicacion_idx` (`id_ubicacion` ASC) VISIBLE,
  INDEX `fk_actividad_economica_idx` (`id_act` ASC) VISIBLE,
  INDEX `fk_razon_social_idx` (`id_razon_social` ASC) VISIBLE,
  INDEX `fk_contacto_idx` (`id_contacto` ASC) VISIBLE,
  CONSTRAINT `fk_actividad_economica`
    FOREIGN KEY (`id_act`)
    REFERENCES `inegi`.`actividades_economicas` (`id`),
  CONSTRAINT `fk_contacto`
    FOREIGN KEY (`id_contacto`)
    REFERENCES `inegi`.`contacto` (`id`),
  CONSTRAINT `fk_razon_social`
    FOREIGN KEY (`id_razon_social`)
    REFERENCES `inegi`.`razones_sociales` (`id`),
  CONSTRAINT `fk_ubicacion`
    FOREIGN KEY (`id_ubicacion`)
    REFERENCES `inegi`.`ubicaciones` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
