-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: cities
-- ------------------------------------------------------
-- Server version	5.7.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--

-- Table structure for table `cities`
--

create database if not exists cities;
use cities;

GRANT ALL ON cities.* TO 'shipping'@'%' IDENTIFIED BY 'secret';
GRANT ALL ON cities.* TO 'shipping'@'localhost' IDENTIFIED BY 'secret';

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `uuid` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `region_idx` (`region`),
  KEY `c_code_idx` (`country_code`),
  FULLTEXT KEY `city_idx` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=6223666 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (3185800,'at','aalfang','Aalfang','03',48.8333330,15.0666670),
(3185801,'at','abbtenau','Abbtenau','05',47.5500000,13.3500000),(3185802,'at','aberg','Aberg','05',47.4000000,12.9000000),(3185803,'at','abern','Abern','04',48.0500000,13.1500000),(3185804,'at','abetzberg','Abetzberg','03',48.0833330,14.7666670),(3185805,'at','abetzdorf','Abetzdorf','03',48.0500000,14.7666670),(3185806,'at','abfalter','Abfalter','05',47.7911110,13.0761110),(3185807,'at','abfaltern','Abfaltern','07',46.7638890,12.5200000),(3185808,'at','abfaltersbach','Abfaltersbach','07',46.7602780,12.5419440),(3185809,'at','abriach','Abriach','02',46.5500000,14.5000000),(3185810,'at','absam','Absam','07',47.3000000,11.5000000),(3185811,'at','absberg','Absberg','03',48.4166670,15.9666670),(3185812,'at','abschlag','Abschlag','03',48.6166670,14.8500000),(3185813,'at','absdorf','Absdorf','03',48.3166670,15.6166670),(3185814,'at','abset','Abset','06',46.8944440,15.9319440),(3185815,'at','absmann','Absmann','05',47.9500000,13.0333330),(3185816,'at','abstetten','Abstetten','03',48.2666670,15.9833330),(3185817,'at','abtei','Abtei','02',46.5519440,14.4733330),(3185818,'at','abtenao','Abtenao','05',47.5500000,13.3500000),(3185819,'at','abtenau','Abtenau','05',47.5500000,13.3500000),(3185820,'at','abtissendorf','Abtissendorf','06',46.9958330,15.4563890),(3185821,'at','abtsdorf','Abtsdorf','04',47.9166670,13.5166670),(3185822,'at','abtstorf','Abtstorf','04',47.9166670,13.5166670),(3185823,'at','abwinden','Abwinden','04',48.2666670,14.4333330),(3185824,'at','ach','Ach','04',48.1500000,12.8333330),(3185825,'at','ach','Ach','08',47.5177780,9.8650000),(3185826,'at','achalm','Achalm','02',46.6500000,14.9333330),(3185827,'at','acham','Acham','07',47.3000000,11.8833330),(3185828,'at','acharting','Acharting','05',47.9000000,13.0000000),(3185829,'at','achatzberg','Achatzberg','04',48.2166670,14.8000000),(3185830,'at','achau','Achau','03',48.0666670,16.3833330),(3185831,'at','achenkirch','Achenkirch','07',47.5166670,11.7000000),
(3185832,'at','achenlohe','Achenlohe','04',48.0500000,13.1833330),(3185833,'at','achenrain','Achenrain','07',47.4500000,11.8666670),(3185834,'at','achensee','Achensee','07',47.5000000,11.7000000),(3185835,'at','achenwald','Achenwald','07',47.5666670,11.6666670),(3185836,'at','aching','Aching','04',48.2333330,13.0666670),
(3185837,'at','achleit','Achleit','07',47.5000000,12.0333330),(3185838,'at','achleiten','Achleiten','03',48.1500000,14.6500000),(3185839,'at','achleiten','Achleiten','04',48.5500000,13.4500000),(3185840,'at','achleithen','Achleithen','04',48.0666670,14.1833330),(3185841,'at','achomitz','Achomitz','02',46.5688890,13.6086110),(3185842,'at','achthal','Achthal','04',48.0500000,13.2000000),(3185843,'at','ackersberg','Ackersberg','04',48.0666670,13.5333330),
(3185844,'at','adamsthal','Adamsthal','03',47.9666670,15.8166670);