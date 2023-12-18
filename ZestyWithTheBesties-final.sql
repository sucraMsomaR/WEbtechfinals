-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 16, 2023 at 02:30 PM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `accountID` int NOT NULL AUTO_INCREMENT,
  `lastName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`accountID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`accountID`, `lastName`, `firstName`, `email`, `password`, `roles`, `status`) VALUES
(1, 'Maniego', 'Shawn', 'admin1@admin.com', 'admin1', 'admin', 'online'),
(2, 'Gallegos', 'Marcus', 'reviewer1@reviewer.com', 'rev1', 'reviewer', 'offline'),
(3, 'Agustin', 'Erol', 'requester1@requester.com', 'req1', 'requester', 'online'),
(4, 'rev', 'rev', 'reviewer2@reviewer.com', 'rev2', 'reviewer', 'offline'),
(5, 'rev3', 'rev3', 'reviewer3@reviewer.com', 'rev3', 'reviewer', 'online'),
(6, 'rev4', 'rev4', 'reviewer4@reviewer.com', 'rev4', 'reviewer', 'offline'),
(7, 'rev5', 'rev5', 'reviewer5@reviewer.com', 'rev5', 'reviewer', 'online'),
(8, 'psst', 'ptss', 'requester2@requester.com', 'req2', 'requester', 'online');

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
CREATE TABLE IF NOT EXISTS `document` (
  `document_id` int NOT NULL AUTO_INCREMENT,
  `document_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int NOT NULL,
  `document_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_size` int NOT NULL,
  `document_blob` longblob NOT NULL,
  `upload_datetime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `version` int DEFAULT NULL,
  `current_reviewer` int DEFAULT '1',
  `doc_status` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chosen_office` int DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `account_id` (`account_id`),
  KEY `chosen_office` (`chosen_office`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviewer`
--

DROP TABLE IF EXISTS `reviewer`;
CREATE TABLE IF NOT EXISTS `reviewer` (
  `OfficeID` int NOT NULL AUTO_INCREMENT,
  `position` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `officeName` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewerID` int NOT NULL,
  PRIMARY KEY (`OfficeID`),
  KEY `Reviewer_ID` (`reviewerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviewer`
--

INSERT INTO `reviewer` (`OfficeID`, `position`, `officeName`, `reviewerID`) VALUES
(1, 'President', 'Office 1', 2),
(2, 'Vice President', 'Office 2', 4),
(3, 'Secretary', 'Office 3', 5),
(4, 'Accountant', 'Office 4', 6),
(5, 'Guard', 'Office 5', 7);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `transactionID` int NOT NULL AUTO_INCREMENT,
  `documentID` int NOT NULL,
  `reviewerID` int NOT NULL,
  `Office_ID` int NOT NULL,
  `statusOfDocument` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateReviewed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateAccepted` datetime DEFAULT NULL,
  `comments` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`transactionID`),
  KEY `documentID` (`documentID`),
  KEY `reviewerID` (`reviewerID`),
  KEY `Office_ID` (`Office_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `chosen_office` FOREIGN KEY (`chosen_office`) REFERENCES `reviewer` (`OfficeID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `reviewer`
--
ALTER TABLE `reviewer`
  ADD CONSTRAINT `Reviewer_ID` FOREIGN KEY (`reviewerID`) REFERENCES `accounts` (`accountID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `documentID` FOREIGN KEY (`documentID`) REFERENCES `document` (`document_id`),
  ADD CONSTRAINT `Office_ID` FOREIGN KEY (`Office_ID`) REFERENCES `reviewer` (`OfficeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `reviewerID` FOREIGN KEY (`reviewerID`) REFERENCES `accounts` (`accountID`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
