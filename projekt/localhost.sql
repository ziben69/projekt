-- phpMyAdmin SQL Dump
-- version home.pl
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Czas wygenerowania: 06 Maj 2016, 21:40
-- Wersja serwera: 5.5.44-37.3-log
-- Wersja PHP: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `09424370_crm`
--
CREATE DATABASE `09424370_crm` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `09424370_crm`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `realization_timeline`
--

CREATE TABLE IF NOT EXISTS `realization_timeline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `realization_type` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `control_date` date NOT NULL,
  `notes` varchar(500) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=4 ;

--
-- Zrzut danych tabeli `realization_timeline`
--

INSERT INTO `realization_timeline` (`id`, `task_id`, `user_id`, `realization_type`, `control_date`, `notes`) VALUES
(1, 1, 1, 'phone', '2016-05-19', 'dasdasdsadsa'),
(2, 1, 1, 'users', '2016-05-06', 'test'),
(3, 1, 1, 'file-text-o', '2016-05-06', 'asdfgdfd');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'User'),
(2, 'Admin');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `status`
--

CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=4 ;

--
-- Zrzut danych tabeli `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'Do realizacji'),
(2, 'W trakcie realizacji'),
(3, 'Zrealizowane');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tasks`
--

CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `notes` varchar(500) COLLATE utf8_polish_ci DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `client_name` varchar(200) COLLATE utf8_polish_ci NOT NULL,
  `contact_phone` varchar(15) COLLATE utf8_polish_ci NOT NULL,
  `contact_email` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`status_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=5 ;

--
-- Zrzut danych tabeli `tasks`
--

INSERT INTO `tasks` (`id`, `task_name`, `user_id`, `notes`, `status_id`, `start_date`, `end_date`, `client_name`, `contact_phone`, `contact_email`) VALUES
(1, '1 zlecenie testowe', 1, '1 zadanie testowe - opis', 1, '2016-04-25', '2016-04-30', 'Jan Nowak', '158655455', 'grucha@gmail.com'),
(2, '2 zlecenie testowe', 1, '2 zadanie testowe - opis', 1, '2016-04-25', '2016-04-30', '', '0', ''),
(3, '3 zlecenie testowe', 1, '3 zadanie testowe - opis', 2, '2016-04-25', '2016-04-30', '', '0', ''),
(4, '2 zlecenie testowe', 1, '3 zadanie testowe - opis', 3, '2016-04-25', '2016-06-23', '', '0', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_polish_ci NOT NULL,
  `login` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `password` varchar(25) COLLATE utf8_polish_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_ibfk_1` (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AUTO_INCREMENT=2 ;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `name`, `login`, `password`, `role_id`) VALUES
(1, 'Giacomo Goraj', 'admin', 'admin', 1);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `realization_timeline`
--
ALTER TABLE `realization_timeline`
  ADD CONSTRAINT `realization_timeline_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `realization_timeline_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ograniczenia dla tabeli `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Ograniczenia dla tabeli `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
--
-- Baza danych: `information_schema`
--
CREATE DATABASE `information_schema` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `information_schema`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `CHARACTER_SETS`
--

CREATE TEMPORARY TABLE `CHARACTER_SETS` (
  `CHARACTER_SET_NAME` varchar(32) NOT NULL DEFAULT '',
  `DEFAULT_COLLATE_NAME` varchar(32) NOT NULL DEFAULT '',
  `DESCRIPTION` varchar(60) NOT NULL DEFAULT '',
  `MAXLEN` bigint(3) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `CHARACTER_SETS`
--

INSERT INTO `CHARACTER_SETS` (`CHARACTER_SET_NAME`, `DEFAULT_COLLATE_NAME`, `DESCRIPTION`, `MAXLEN`) VALUES
('big5', 'big5_chinese_ci', 'Big5 Traditional Chinese', 2),
('dec8', 'dec8_swedish_ci', 'DEC West European', 1),
('cp850', 'cp850_general_ci', 'DOS West European', 1),
('hp8', 'hp8_english_ci', 'HP West European', 1),
('koi8r', 'koi8r_general_ci', 'KOI8-R Relcom Russian', 1),
('latin1', 'latin1_swedish_ci', 'cp1252 West European', 1),
('latin2', 'latin2_general_ci', 'ISO 8859-2 Central European', 1),
('swe7', 'swe7_swedish_ci', '7bit Swedish', 1),
('ascii', 'ascii_general_ci', 'US ASCII', 1),
('ujis', 'ujis_japanese_ci', 'EUC-JP Japanese', 3),
('sjis', 'sjis_japanese_ci', 'Shift-JIS Japanese', 2),
('hebrew', 'hebrew_general_ci', 'ISO 8859-8 Hebrew', 1),
('tis620', 'tis620_thai_ci', 'TIS620 Thai', 1),
('euckr', 'euckr_korean_ci', 'EUC-KR Korean', 2),
('koi8u', 'koi8u_general_ci', 'KOI8-U Ukrainian', 1),
('gb2312', 'gb2312_chinese_ci', 'GB2312 Simplified Chinese', 2),
('greek', 'greek_general_ci', 'ISO 8859-7 Greek', 1),
('cp1250', 'cp1250_general_ci', 'Windows Central European', 1),
('gbk', 'gbk_chinese_ci', 'GBK Simplified Chinese', 2),
('latin5', 'latin5_turkish_ci', 'ISO 8859-9 Turkish', 1),
('armscii8', 'armscii8_general_ci', 'ARMSCII-8 Armenian', 1),
('utf8', 'utf8_general_ci', 'UTF-8 Unicode', 3),
('ucs2', 'ucs2_general_ci', 'UCS-2 Unicode', 2),
('cp866', 'cp866_general_ci', 'DOS Russian', 1),
('keybcs2', 'keybcs2_general_ci', 'DOS Kamenicky Czech-Slovak', 1),
('macce', 'macce_general_ci', 'Mac Central European', 1),
('macroman', 'macroman_general_ci', 'Mac West European', 1),
('cp852', 'cp852_general_ci', 'DOS Central European', 1),
('latin7', 'latin7_general_ci', 'ISO 8859-13 Baltic', 1),
('utf8mb4', 'utf8mb4_general_ci', 'UTF-8 Unicode', 4),
('cp1251', 'cp1251_general_ci', 'Windows Cyrillic', 1),
('utf16', 'utf16_general_ci', 'UTF-16 Unicode', 4),
('cp1256', 'cp1256_general_ci', 'Windows Arabic', 1),
('cp1257', 'cp1257_general_ci', 'Windows Baltic', 1),
('utf32', 'utf32_general_ci', 'UTF-32 Unicode', 4),
('binary', 'binary', 'Binary pseudo charset', 1),
('geostd8', 'geostd8_general_ci', 'GEOSTD8 Georgian', 1),
('cp932', 'cp932_japanese_ci', 'SJIS for Windows Japanese', 2),
('eucjpms', 'eucjpms_japanese_ci', 'UJIS for Windows Japanese', 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `CLIENT_STATISTICS`
--

CREATE TEMPORARY TABLE `CLIENT_STATISTICS` (
  `CLIENT` varchar(64) NOT NULL DEFAULT '',
  `TOTAL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONCURRENT_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONNECTED_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BUSY_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CPU_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_RECEIVED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_SENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BINLOG_BYTES_WRITTEN` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_FETCHED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_UPDATED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TABLE_ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SELECT_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `UPDATE_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OTHER_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMMIT_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROLLBACK_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DENIED_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `LOST_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ACCESS_DENIED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `EMPTY_QUERIES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TOTAL_SSL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS,SUPER privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `COLLATIONS`
--

CREATE TEMPORARY TABLE `COLLATIONS` (
  `COLLATION_NAME` varchar(32) NOT NULL DEFAULT '',
  `CHARACTER_SET_NAME` varchar(32) NOT NULL DEFAULT '',
  `ID` bigint(11) NOT NULL DEFAULT '0',
  `IS_DEFAULT` varchar(3) NOT NULL DEFAULT '',
  `IS_COMPILED` varchar(3) NOT NULL DEFAULT '',
  `SORTLEN` bigint(3) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `COLLATIONS`
--

INSERT INTO `COLLATIONS` (`COLLATION_NAME`, `CHARACTER_SET_NAME`, `ID`, `IS_DEFAULT`, `IS_COMPILED`, `SORTLEN`) VALUES
('big5_chinese_ci', 'big5', 1, 'Yes', 'Yes', 1),
('big5_bin', 'big5', 84, '', 'Yes', 1),
('dec8_swedish_ci', 'dec8', 3, 'Yes', 'Yes', 1),
('dec8_bin', 'dec8', 69, '', 'Yes', 1),
('cp850_general_ci', 'cp850', 4, 'Yes', 'Yes', 1),
('cp850_bin', 'cp850', 80, '', 'Yes', 1),
('hp8_english_ci', 'hp8', 6, 'Yes', 'Yes', 1),
('hp8_bin', 'hp8', 72, '', 'Yes', 1),
('koi8r_general_ci', 'koi8r', 7, 'Yes', 'Yes', 1),
('koi8r_bin', 'koi8r', 74, '', 'Yes', 1),
('latin1_german1_ci', 'latin1', 5, '', 'Yes', 1),
('latin1_swedish_ci', 'latin1', 8, 'Yes', 'Yes', 1),
('latin1_danish_ci', 'latin1', 15, '', 'Yes', 1),
('latin1_german2_ci', 'latin1', 31, '', 'Yes', 2),
('latin1_bin', 'latin1', 47, '', 'Yes', 1),
('latin1_general_ci', 'latin1', 48, '', 'Yes', 1),
('latin1_general_cs', 'latin1', 49, '', 'Yes', 1),
('latin1_spanish_ci', 'latin1', 94, '', 'Yes', 1),
('latin2_czech_cs', 'latin2', 2, '', 'Yes', 4),
('latin2_general_ci', 'latin2', 9, 'Yes', 'Yes', 1),
('latin2_hungarian_ci', 'latin2', 21, '', 'Yes', 1),
('latin2_croatian_ci', 'latin2', 27, '', 'Yes', 1),
('latin2_bin', 'latin2', 77, '', 'Yes', 1),
('swe7_swedish_ci', 'swe7', 10, 'Yes', 'Yes', 1),
('swe7_bin', 'swe7', 82, '', 'Yes', 1),
('ascii_general_ci', 'ascii', 11, 'Yes', 'Yes', 1),
('ascii_bin', 'ascii', 65, '', 'Yes', 1),
('ujis_japanese_ci', 'ujis', 12, 'Yes', 'Yes', 1),
('ujis_bin', 'ujis', 91, '', 'Yes', 1),
('sjis_japanese_ci', 'sjis', 13, 'Yes', 'Yes', 1),
('sjis_bin', 'sjis', 88, '', 'Yes', 1),
('hebrew_general_ci', 'hebrew', 16, 'Yes', 'Yes', 1),
('hebrew_bin', 'hebrew', 71, '', 'Yes', 1),
('tis620_thai_ci', 'tis620', 18, 'Yes', 'Yes', 4),
('tis620_bin', 'tis620', 89, '', 'Yes', 1),
('euckr_korean_ci', 'euckr', 19, 'Yes', 'Yes', 1),
('euckr_bin', 'euckr', 85, '', 'Yes', 1),
('koi8u_general_ci', 'koi8u', 22, 'Yes', 'Yes', 1),
('koi8u_bin', 'koi8u', 75, '', 'Yes', 1),
('gb2312_chinese_ci', 'gb2312', 24, 'Yes', 'Yes', 1),
('gb2312_bin', 'gb2312', 86, '', 'Yes', 1),
('greek_general_ci', 'greek', 25, 'Yes', 'Yes', 1),
('greek_bin', 'greek', 70, '', 'Yes', 1),
('cp1250_general_ci', 'cp1250', 26, 'Yes', 'Yes', 1),
('cp1250_czech_cs', 'cp1250', 34, '', 'Yes', 2),
('cp1250_croatian_ci', 'cp1250', 44, '', 'Yes', 1),
('cp1250_bin', 'cp1250', 66, '', 'Yes', 1),
('cp1250_polish_ci', 'cp1250', 99, '', 'Yes', 1),
('gbk_chinese_ci', 'gbk', 28, 'Yes', 'Yes', 1),
('gbk_bin', 'gbk', 87, '', 'Yes', 1),
('latin5_turkish_ci', 'latin5', 30, 'Yes', 'Yes', 1),
('latin5_bin', 'latin5', 78, '', 'Yes', 1),
('armscii8_general_ci', 'armscii8', 32, 'Yes', 'Yes', 1),
('armscii8_bin', 'armscii8', 64, '', 'Yes', 1),
('utf8_general_ci', 'utf8', 33, 'Yes', 'Yes', 1),
('utf8_bin', 'utf8', 83, '', 'Yes', 1),
('utf8_unicode_ci', 'utf8', 192, '', 'Yes', 8),
('utf8_icelandic_ci', 'utf8', 193, '', 'Yes', 8),
('utf8_latvian_ci', 'utf8', 194, '', 'Yes', 8),
('utf8_romanian_ci', 'utf8', 195, '', 'Yes', 8),
('utf8_slovenian_ci', 'utf8', 196, '', 'Yes', 8),
('utf8_polish_ci', 'utf8', 197, '', 'Yes', 8),
('utf8_estonian_ci', 'utf8', 198, '', 'Yes', 8),
('utf8_spanish_ci', 'utf8', 199, '', 'Yes', 8),
('utf8_swedish_ci', 'utf8', 200, '', 'Yes', 8),
('utf8_turkish_ci', 'utf8', 201, '', 'Yes', 8),
('utf8_czech_ci', 'utf8', 202, '', 'Yes', 8),
('utf8_danish_ci', 'utf8', 203, '', 'Yes', 8),
('utf8_lithuanian_ci', 'utf8', 204, '', 'Yes', 8),
('utf8_slovak_ci', 'utf8', 205, '', 'Yes', 8),
('utf8_spanish2_ci', 'utf8', 206, '', 'Yes', 8),
('utf8_roman_ci', 'utf8', 207, '', 'Yes', 8),
('utf8_persian_ci', 'utf8', 208, '', 'Yes', 8),
('utf8_esperanto_ci', 'utf8', 209, '', 'Yes', 8),
('utf8_hungarian_ci', 'utf8', 210, '', 'Yes', 8),
('utf8_sinhala_ci', 'utf8', 211, '', 'Yes', 8),
('utf8_general_mysql500_ci', 'utf8', 223, '', 'Yes', 1),
('utf8_general50_ci', 'utf8', 253, '', 'Yes', 1),
('ucs2_general_ci', 'ucs2', 35, 'Yes', 'Yes', 1),
('ucs2_bin', 'ucs2', 90, '', 'Yes', 1),
('ucs2_unicode_ci', 'ucs2', 128, '', 'Yes', 8),
('ucs2_icelandic_ci', 'ucs2', 129, '', 'Yes', 8),
('ucs2_latvian_ci', 'ucs2', 130, '', 'Yes', 8),
('ucs2_romanian_ci', 'ucs2', 131, '', 'Yes', 8),
('ucs2_slovenian_ci', 'ucs2', 132, '', 'Yes', 8),
('ucs2_polish_ci', 'ucs2', 133, '', 'Yes', 8),
('ucs2_estonian_ci', 'ucs2', 134, '', 'Yes', 8),
('ucs2_spanish_ci', 'ucs2', 135, '', 'Yes', 8),
('ucs2_swedish_ci', 'ucs2', 136, '', 'Yes', 8),
('ucs2_turkish_ci', 'ucs2', 137, '', 'Yes', 8),
('ucs2_czech_ci', 'ucs2', 138, '', 'Yes', 8),
('ucs2_danish_ci', 'ucs2', 139, '', 'Yes', 8),
('ucs2_lithuanian_ci', 'ucs2', 140, '', 'Yes', 8),
('ucs2_slovak_ci', 'ucs2', 141, '', 'Yes', 8),
('ucs2_spanish2_ci', 'ucs2', 142, '', 'Yes', 8),
('ucs2_roman_ci', 'ucs2', 143, '', 'Yes', 8),
('ucs2_persian_ci', 'ucs2', 144, '', 'Yes', 8),
('ucs2_esperanto_ci', 'ucs2', 145, '', 'Yes', 8),
('ucs2_hungarian_ci', 'ucs2', 146, '', 'Yes', 8),
('ucs2_sinhala_ci', 'ucs2', 147, '', 'Yes', 8),
('ucs2_general50_ci', 'ucs2', 159, '', 'Yes', 1),
('cp866_general_ci', 'cp866', 36, 'Yes', 'Yes', 1),
('cp866_bin', 'cp866', 68, '', 'Yes', 1),
('keybcs2_general_ci', 'keybcs2', 37, 'Yes', 'Yes', 1),
('keybcs2_bin', 'keybcs2', 73, '', 'Yes', 1),
('macce_general_ci', 'macce', 38, 'Yes', 'Yes', 1),
('macce_bin', 'macce', 43, '', 'Yes', 1),
('macroman_general_ci', 'macroman', 39, 'Yes', 'Yes', 1),
('macroman_bin', 'macroman', 53, '', 'Yes', 1),
('cp852_general_ci', 'cp852', 40, 'Yes', 'Yes', 1),
('cp852_bin', 'cp852', 81, '', 'Yes', 1),
('latin7_estonian_cs', 'latin7', 20, '', 'Yes', 1),
('latin7_general_ci', 'latin7', 41, 'Yes', 'Yes', 1),
('latin7_general_cs', 'latin7', 42, '', 'Yes', 1),
('latin7_bin', 'latin7', 79, '', 'Yes', 1),
('utf8mb4_general_ci', 'utf8mb4', 45, 'Yes', 'Yes', 1),
('utf8mb4_bin', 'utf8mb4', 46, '', 'Yes', 1),
('utf8mb4_unicode_ci', 'utf8mb4', 224, '', 'Yes', 8),
('utf8mb4_icelandic_ci', 'utf8mb4', 225, '', 'Yes', 8),
('utf8mb4_latvian_ci', 'utf8mb4', 226, '', 'Yes', 8),
('utf8mb4_romanian_ci', 'utf8mb4', 227, '', 'Yes', 8),
('utf8mb4_slovenian_ci', 'utf8mb4', 228, '', 'Yes', 8),
('utf8mb4_polish_ci', 'utf8mb4', 229, '', 'Yes', 8),
('utf8mb4_estonian_ci', 'utf8mb4', 230, '', 'Yes', 8),
('utf8mb4_spanish_ci', 'utf8mb4', 231, '', 'Yes', 8),
('utf8mb4_swedish_ci', 'utf8mb4', 232, '', 'Yes', 8),
('utf8mb4_turkish_ci', 'utf8mb4', 233, '', 'Yes', 8),
('utf8mb4_czech_ci', 'utf8mb4', 234, '', 'Yes', 8),
('utf8mb4_danish_ci', 'utf8mb4', 235, '', 'Yes', 8),
('utf8mb4_lithuanian_ci', 'utf8mb4', 236, '', 'Yes', 8),
('utf8mb4_slovak_ci', 'utf8mb4', 237, '', 'Yes', 8),
('utf8mb4_spanish2_ci', 'utf8mb4', 238, '', 'Yes', 8),
('utf8mb4_roman_ci', 'utf8mb4', 239, '', 'Yes', 8),
('utf8mb4_persian_ci', 'utf8mb4', 240, '', 'Yes', 8),
('utf8mb4_esperanto_ci', 'utf8mb4', 241, '', 'Yes', 8),
('utf8mb4_hungarian_ci', 'utf8mb4', 242, '', 'Yes', 8),
('utf8mb4_sinhala_ci', 'utf8mb4', 243, '', 'Yes', 8),
('cp1251_bulgarian_ci', 'cp1251', 14, '', 'Yes', 1),
('cp1251_ukrainian_ci', 'cp1251', 23, '', 'Yes', 1),
('cp1251_bin', 'cp1251', 50, '', 'Yes', 1),
('cp1251_general_ci', 'cp1251', 51, 'Yes', 'Yes', 1),
('cp1251_general_cs', 'cp1251', 52, '', 'Yes', 1),
('utf16_general_ci', 'utf16', 54, 'Yes', 'Yes', 1),
('utf16_bin', 'utf16', 55, '', 'Yes', 1),
('utf16_unicode_ci', 'utf16', 101, '', 'Yes', 8),
('utf16_icelandic_ci', 'utf16', 102, '', 'Yes', 8),
('utf16_latvian_ci', 'utf16', 103, '', 'Yes', 8),
('utf16_romanian_ci', 'utf16', 104, '', 'Yes', 8),
('utf16_slovenian_ci', 'utf16', 105, '', 'Yes', 8),
('utf16_polish_ci', 'utf16', 106, '', 'Yes', 8),
('utf16_estonian_ci', 'utf16', 107, '', 'Yes', 8),
('utf16_spanish_ci', 'utf16', 108, '', 'Yes', 8),
('utf16_swedish_ci', 'utf16', 109, '', 'Yes', 8),
('utf16_turkish_ci', 'utf16', 110, '', 'Yes', 8),
('utf16_czech_ci', 'utf16', 111, '', 'Yes', 8),
('utf16_danish_ci', 'utf16', 112, '', 'Yes', 8),
('utf16_lithuanian_ci', 'utf16', 113, '', 'Yes', 8),
('utf16_slovak_ci', 'utf16', 114, '', 'Yes', 8),
('utf16_spanish2_ci', 'utf16', 115, '', 'Yes', 8),
('utf16_roman_ci', 'utf16', 116, '', 'Yes', 8),
('utf16_persian_ci', 'utf16', 117, '', 'Yes', 8),
('utf16_esperanto_ci', 'utf16', 118, '', 'Yes', 8),
('utf16_hungarian_ci', 'utf16', 119, '', 'Yes', 8),
('utf16_sinhala_ci', 'utf16', 120, '', 'Yes', 8),
('cp1256_general_ci', 'cp1256', 57, 'Yes', 'Yes', 1),
('cp1256_bin', 'cp1256', 67, '', 'Yes', 1),
('cp1257_lithuanian_ci', 'cp1257', 29, '', 'Yes', 1),
('cp1257_bin', 'cp1257', 58, '', 'Yes', 1),
('cp1257_general_ci', 'cp1257', 59, 'Yes', 'Yes', 1),
('utf32_general_ci', 'utf32', 60, 'Yes', 'Yes', 1),
('utf32_bin', 'utf32', 61, '', 'Yes', 1),
('utf32_unicode_ci', 'utf32', 160, '', 'Yes', 8),
('utf32_icelandic_ci', 'utf32', 161, '', 'Yes', 8),
('utf32_latvian_ci', 'utf32', 162, '', 'Yes', 8),
('utf32_romanian_ci', 'utf32', 163, '', 'Yes', 8),
('utf32_slovenian_ci', 'utf32', 164, '', 'Yes', 8),
('utf32_polish_ci', 'utf32', 165, '', 'Yes', 8),
('utf32_estonian_ci', 'utf32', 166, '', 'Yes', 8),
('utf32_spanish_ci', 'utf32', 167, '', 'Yes', 8),
('utf32_swedish_ci', 'utf32', 168, '', 'Yes', 8),
('utf32_turkish_ci', 'utf32', 169, '', 'Yes', 8),
('utf32_czech_ci', 'utf32', 170, '', 'Yes', 8),
('utf32_danish_ci', 'utf32', 171, '', 'Yes', 8),
('utf32_lithuanian_ci', 'utf32', 172, '', 'Yes', 8),
('utf32_slovak_ci', 'utf32', 173, '', 'Yes', 8),
('utf32_spanish2_ci', 'utf32', 174, '', 'Yes', 8),
('utf32_roman_ci', 'utf32', 175, '', 'Yes', 8),
('utf32_persian_ci', 'utf32', 176, '', 'Yes', 8),
('utf32_esperanto_ci', 'utf32', 177, '', 'Yes', 8),
('utf32_hungarian_ci', 'utf32', 178, '', 'Yes', 8),
('utf32_sinhala_ci', 'utf32', 179, '', 'Yes', 8),
('binary', 'binary', 63, 'Yes', 'Yes', 1),
('geostd8_general_ci', 'geostd8', 92, 'Yes', 'Yes', 1),
('geostd8_bin', 'geostd8', 93, '', 'Yes', 1),
('cp932_japanese_ci', 'cp932', 95, 'Yes', 'Yes', 1),
('cp932_bin', 'cp932', 96, '', 'Yes', 1),
('eucjpms_japanese_ci', 'eucjpms', 97, 'Yes', 'Yes', 1),
('eucjpms_bin', 'eucjpms', 98, '', 'Yes', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `COLLATION_CHARACTER_SET_APPLICABILITY`
--

CREATE TEMPORARY TABLE `COLLATION_CHARACTER_SET_APPLICABILITY` (
  `COLLATION_NAME` varchar(32) NOT NULL DEFAULT '',
  `CHARACTER_SET_NAME` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `COLLATION_CHARACTER_SET_APPLICABILITY`
--

INSERT INTO `COLLATION_CHARACTER_SET_APPLICABILITY` (`COLLATION_NAME`, `CHARACTER_SET_NAME`) VALUES
('big5_chinese_ci', 'big5'),
('big5_bin', 'big5'),
('dec8_swedish_ci', 'dec8'),
('dec8_bin', 'dec8'),
('cp850_general_ci', 'cp850'),
('cp850_bin', 'cp850'),
('hp8_english_ci', 'hp8'),
('hp8_bin', 'hp8'),
('koi8r_general_ci', 'koi8r'),
('koi8r_bin', 'koi8r'),
('latin1_german1_ci', 'latin1'),
('latin1_swedish_ci', 'latin1'),
('latin1_danish_ci', 'latin1'),
('latin1_german2_ci', 'latin1'),
('latin1_bin', 'latin1'),
('latin1_general_ci', 'latin1'),
('latin1_general_cs', 'latin1'),
('latin1_spanish_ci', 'latin1'),
('latin2_czech_cs', 'latin2'),
('latin2_general_ci', 'latin2'),
('latin2_hungarian_ci', 'latin2'),
('latin2_croatian_ci', 'latin2'),
('latin2_bin', 'latin2'),
('swe7_swedish_ci', 'swe7'),
('swe7_bin', 'swe7'),
('ascii_general_ci', 'ascii'),
('ascii_bin', 'ascii'),
('ujis_japanese_ci', 'ujis'),
('ujis_bin', 'ujis'),
('sjis_japanese_ci', 'sjis'),
('sjis_bin', 'sjis'),
('hebrew_general_ci', 'hebrew'),
('hebrew_bin', 'hebrew'),
('tis620_thai_ci', 'tis620'),
('tis620_bin', 'tis620'),
('euckr_korean_ci', 'euckr'),
('euckr_bin', 'euckr'),
('koi8u_general_ci', 'koi8u'),
('koi8u_bin', 'koi8u'),
('gb2312_chinese_ci', 'gb2312'),
('gb2312_bin', 'gb2312'),
('greek_general_ci', 'greek'),
('greek_bin', 'greek'),
('cp1250_general_ci', 'cp1250'),
('cp1250_czech_cs', 'cp1250'),
('cp1250_croatian_ci', 'cp1250'),
('cp1250_bin', 'cp1250'),
('cp1250_polish_ci', 'cp1250'),
('gbk_chinese_ci', 'gbk'),
('gbk_bin', 'gbk'),
('latin5_turkish_ci', 'latin5'),
('latin5_bin', 'latin5'),
('armscii8_general_ci', 'armscii8'),
('armscii8_bin', 'armscii8'),
('utf8_general_ci', 'utf8'),
('utf8_bin', 'utf8'),
('utf8_unicode_ci', 'utf8'),
('utf8_icelandic_ci', 'utf8'),
('utf8_latvian_ci', 'utf8'),
('utf8_romanian_ci', 'utf8'),
('utf8_slovenian_ci', 'utf8'),
('utf8_polish_ci', 'utf8'),
('utf8_estonian_ci', 'utf8'),
('utf8_spanish_ci', 'utf8'),
('utf8_swedish_ci', 'utf8'),
('utf8_turkish_ci', 'utf8'),
('utf8_czech_ci', 'utf8'),
('utf8_danish_ci', 'utf8'),
('utf8_lithuanian_ci', 'utf8'),
('utf8_slovak_ci', 'utf8'),
('utf8_spanish2_ci', 'utf8'),
('utf8_roman_ci', 'utf8'),
('utf8_persian_ci', 'utf8'),
('utf8_esperanto_ci', 'utf8'),
('utf8_hungarian_ci', 'utf8'),
('utf8_sinhala_ci', 'utf8'),
('utf8_general_mysql500_ci', 'utf8'),
('utf8_general50_ci', 'utf8'),
('ucs2_general_ci', 'ucs2'),
('ucs2_bin', 'ucs2'),
('ucs2_unicode_ci', 'ucs2'),
('ucs2_icelandic_ci', 'ucs2'),
('ucs2_latvian_ci', 'ucs2'),
('ucs2_romanian_ci', 'ucs2'),
('ucs2_slovenian_ci', 'ucs2'),
('ucs2_polish_ci', 'ucs2'),
('ucs2_estonian_ci', 'ucs2'),
('ucs2_spanish_ci', 'ucs2'),
('ucs2_swedish_ci', 'ucs2'),
('ucs2_turkish_ci', 'ucs2'),
('ucs2_czech_ci', 'ucs2'),
('ucs2_danish_ci', 'ucs2'),
('ucs2_lithuanian_ci', 'ucs2'),
('ucs2_slovak_ci', 'ucs2'),
('ucs2_spanish2_ci', 'ucs2'),
('ucs2_roman_ci', 'ucs2'),
('ucs2_persian_ci', 'ucs2'),
('ucs2_esperanto_ci', 'ucs2'),
('ucs2_hungarian_ci', 'ucs2'),
('ucs2_sinhala_ci', 'ucs2'),
('ucs2_general50_ci', 'ucs2'),
('cp866_general_ci', 'cp866'),
('cp866_bin', 'cp866'),
('keybcs2_general_ci', 'keybcs2'),
('keybcs2_bin', 'keybcs2'),
('macce_general_ci', 'macce'),
('macce_bin', 'macce'),
('macroman_general_ci', 'macroman'),
('macroman_bin', 'macroman'),
('cp852_general_ci', 'cp852'),
('cp852_bin', 'cp852'),
('latin7_estonian_cs', 'latin7'),
('latin7_general_ci', 'latin7'),
('latin7_general_cs', 'latin7'),
('latin7_bin', 'latin7'),
('utf8mb4_general_ci', 'utf8mb4'),
('utf8mb4_bin', 'utf8mb4'),
('utf8mb4_unicode_ci', 'utf8mb4'),
('utf8mb4_icelandic_ci', 'utf8mb4'),
('utf8mb4_latvian_ci', 'utf8mb4'),
('utf8mb4_romanian_ci', 'utf8mb4'),
('utf8mb4_slovenian_ci', 'utf8mb4'),
('utf8mb4_polish_ci', 'utf8mb4'),
('utf8mb4_estonian_ci', 'utf8mb4'),
('utf8mb4_spanish_ci', 'utf8mb4'),
('utf8mb4_swedish_ci', 'utf8mb4'),
('utf8mb4_turkish_ci', 'utf8mb4'),
('utf8mb4_czech_ci', 'utf8mb4'),
('utf8mb4_danish_ci', 'utf8mb4'),
('utf8mb4_lithuanian_ci', 'utf8mb4'),
('utf8mb4_slovak_ci', 'utf8mb4'),
('utf8mb4_spanish2_ci', 'utf8mb4'),
('utf8mb4_roman_ci', 'utf8mb4'),
('utf8mb4_persian_ci', 'utf8mb4'),
('utf8mb4_esperanto_ci', 'utf8mb4'),
('utf8mb4_hungarian_ci', 'utf8mb4'),
('utf8mb4_sinhala_ci', 'utf8mb4'),
('cp1251_bulgarian_ci', 'cp1251'),
('cp1251_ukrainian_ci', 'cp1251'),
('cp1251_bin', 'cp1251'),
('cp1251_general_ci', 'cp1251'),
('cp1251_general_cs', 'cp1251'),
('utf16_general_ci', 'utf16'),
('utf16_bin', 'utf16'),
('utf16_unicode_ci', 'utf16'),
('utf16_icelandic_ci', 'utf16'),
('utf16_latvian_ci', 'utf16'),
('utf16_romanian_ci', 'utf16'),
('utf16_slovenian_ci', 'utf16'),
('utf16_polish_ci', 'utf16'),
('utf16_estonian_ci', 'utf16'),
('utf16_spanish_ci', 'utf16'),
('utf16_swedish_ci', 'utf16'),
('utf16_turkish_ci', 'utf16'),
('utf16_czech_ci', 'utf16'),
('utf16_danish_ci', 'utf16'),
('utf16_lithuanian_ci', 'utf16'),
('utf16_slovak_ci', 'utf16'),
('utf16_spanish2_ci', 'utf16'),
('utf16_roman_ci', 'utf16'),
('utf16_persian_ci', 'utf16'),
('utf16_esperanto_ci', 'utf16'),
('utf16_hungarian_ci', 'utf16'),
('utf16_sinhala_ci', 'utf16'),
('cp1256_general_ci', 'cp1256'),
('cp1256_bin', 'cp1256'),
('cp1257_lithuanian_ci', 'cp1257'),
('cp1257_bin', 'cp1257'),
('cp1257_general_ci', 'cp1257'),
('utf32_general_ci', 'utf32'),
('utf32_bin', 'utf32'),
('utf32_unicode_ci', 'utf32'),
('utf32_icelandic_ci', 'utf32'),
('utf32_latvian_ci', 'utf32'),
('utf32_romanian_ci', 'utf32'),
('utf32_slovenian_ci', 'utf32'),
('utf32_polish_ci', 'utf32'),
('utf32_estonian_ci', 'utf32'),
('utf32_spanish_ci', 'utf32'),
('utf32_swedish_ci', 'utf32'),
('utf32_turkish_ci', 'utf32'),
('utf32_czech_ci', 'utf32'),
('utf32_danish_ci', 'utf32'),
('utf32_lithuanian_ci', 'utf32'),
('utf32_slovak_ci', 'utf32'),
('utf32_spanish2_ci', 'utf32'),
('utf32_roman_ci', 'utf32'),
('utf32_persian_ci', 'utf32'),
('utf32_esperanto_ci', 'utf32'),
('utf32_hungarian_ci', 'utf32'),
('utf32_sinhala_ci', 'utf32'),
('binary', 'binary'),
('geostd8_general_ci', 'geostd8'),
('geostd8_bin', 'geostd8'),
('cp932_japanese_ci', 'cp932'),
('cp932_bin', 'cp932'),
('eucjpms_japanese_ci', 'eucjpms'),
('eucjpms_bin', 'eucjpms');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `COLUMNS`
--

CREATE TEMPORARY TABLE `COLUMNS` (
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',
  `ORDINAL_POSITION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COLUMN_DEFAULT` longtext,
  `IS_NULLABLE` varchar(3) NOT NULL DEFAULT '',
  `DATA_TYPE` varchar(64) NOT NULL DEFAULT '',
  `CHARACTER_MAXIMUM_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `CHARACTER_OCTET_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `NUMERIC_PRECISION` bigint(21) unsigned DEFAULT NULL,
  `NUMERIC_SCALE` bigint(21) unsigned DEFAULT NULL,
  `CHARACTER_SET_NAME` varchar(32) DEFAULT NULL,
  `COLLATION_NAME` varchar(32) DEFAULT NULL,
  `COLUMN_TYPE` longtext NOT NULL,
  `COLUMN_KEY` varchar(3) NOT NULL DEFAULT '',
  `EXTRA` varchar(27) NOT NULL DEFAULT '',
  `PRIVILEGES` varchar(80) NOT NULL DEFAULT '',
  `COLUMN_COMMENT` varchar(1024) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `COLUMNS`
--

INSERT INTO `COLUMNS` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `COLUMN_DEFAULT`, `IS_NULLABLE`, `DATA_TYPE`, `CHARACTER_MAXIMUM_LENGTH`, `CHARACTER_OCTET_LENGTH`, `NUMERIC_PRECISION`, `NUMERIC_SCALE`, `CHARACTER_SET_NAME`, `COLLATION_NAME`, `COLUMN_TYPE`, `COLUMN_KEY`, `EXTRA`, `PRIVILEGES`, `COLUMN_COMMENT`) VALUES
('def', 'information_schema', 'CHARACTER_SETS', 'CHARACTER_SET_NAME', 1, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'CHARACTER_SETS', 'DEFAULT_COLLATE_NAME', 2, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'CHARACTER_SETS', 'DESCRIPTION', 3, '', 'NO', 'varchar', 60, 180, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(60)', '', '', 'select', ''),
('def', 'information_schema', 'CHARACTER_SETS', 'MAXLEN', 4, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(3)', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'CLIENT', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'TOTAL_CONNECTIONS', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'CONCURRENT_CONNECTIONS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'CONNECTED_TIME', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'BUSY_TIME', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'CPU_TIME', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'BYTES_RECEIVED', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'BYTES_SENT', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'BINLOG_BYTES_WRITTEN', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'ROWS_FETCHED', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'ROWS_UPDATED', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'TABLE_ROWS_READ', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'SELECT_COMMANDS', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'UPDATE_COMMANDS', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'OTHER_COMMANDS', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'COMMIT_TRANSACTIONS', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'ROLLBACK_TRANSACTIONS', 17, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'DENIED_CONNECTIONS', 18, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'LOST_CONNECTIONS', 19, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'ACCESS_DENIED', 20, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'EMPTY_QUERIES', 21, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'TOTAL_SSL_CONNECTIONS', 22, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'COLLATION_NAME', 1, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'CHARACTER_SET_NAME', 2, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'ID', 3, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(11)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'IS_DEFAULT', 4, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'IS_COMPILED', 5, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATIONS', 'SORTLEN', 6, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(3)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATION_CHARACTER_SET_APPLICABILITY', 'COLLATION_NAME', 1, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLLATION_CHARACTER_SET_APPLICABILITY', 'CHARACTER_SET_NAME', 2, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'TABLE_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLUMN_NAME', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'ORDINAL_POSITION', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLUMN_DEFAULT', 6, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'IS_NULLABLE', 7, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'DATA_TYPE', 8, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'CHARACTER_MAXIMUM_LENGTH', 9, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'CHARACTER_OCTET_LENGTH', 10, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'NUMERIC_PRECISION', 11, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'NUMERIC_SCALE', 12, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'CHARACTER_SET_NAME', 13, NULL, 'YES', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLLATION_NAME', 14, NULL, 'YES', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLUMN_TYPE', 15, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLUMN_KEY', 16, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'EXTRA', 17, '', 'NO', 'varchar', 27, 81, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(27)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'PRIVILEGES', 18, '', 'NO', 'varchar', 80, 240, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(80)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMNS', 'COLUMN_COMMENT', 19, '', 'NO', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'GRANTEE', 1, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'TABLE_CATALOG', 2, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'TABLE_SCHEMA', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'TABLE_NAME', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'COLUMN_NAME', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'PRIVILEGE_TYPE', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'IS_GRANTABLE', 7, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INDEX_STATISTICS', 'TABLE_SCHEMA', 1, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INDEX_STATISTICS', 'TABLE_NAME', 2, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INDEX_STATISTICS', 'INDEX_NAME', 3, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INDEX_STATISTICS', 'ROWS_READ', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'ENGINE', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'SUPPORT', 2, '', 'NO', 'varchar', 8, 24, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8)', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'COMMENT', 3, '', 'NO', 'varchar', 80, 240, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(80)', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'TRANSACTIONS', 4, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'XA', 5, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'ENGINES', 'SAVEPOINTS', 6, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_CATALOG', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'DEFINER', 4, '', 'NO', 'varchar', 77, 231, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(77)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'TIME_ZONE', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_BODY', 6, '', 'NO', 'varchar', 8, 24, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_DEFINITION', 7, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_TYPE', 8, '', 'NO', 'varchar', 9, 27, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(9)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EXECUTE_AT', 9, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'INTERVAL_VALUE', 10, NULL, 'YES', 'varchar', 256, 768, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(256)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'INTERVAL_FIELD', 11, NULL, 'YES', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'SQL_MODE', 12, '', 'NO', 'varchar', 8192, 24576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8192)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'STARTS', 13, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'ENDS', 14, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'STATUS', 15, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'ON_COMPLETION', 16, '', 'NO', 'varchar', 12, 36, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(12)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'CREATED', 17, '0000-00-00 00:00:00', 'NO', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'LAST_ALTERED', 18, '0000-00-00 00:00:00', 'NO', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'LAST_EXECUTED', 19, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'EVENT_COMMENT', 20, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'ORIGINATOR', 21, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(10)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'CHARACTER_SET_CLIENT', 22, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'COLLATION_CONNECTION', 23, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'EVENTS', 'DATABASE_COLLATION', 24, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'FILE_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'FILE_NAME', 2, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'FILE_TYPE', 3, '', 'NO', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TABLESPACE_NAME', 4, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TABLE_CATALOG', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TABLE_SCHEMA', 6, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TABLE_NAME', 7, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'LOGFILE_GROUP_NAME', 8, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'LOGFILE_GROUP_NUMBER', 9, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'ENGINE', 10, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'FULLTEXT_KEYS', 11, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'DELETED_ROWS', 12, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'UPDATE_COUNT', 13, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'FREE_EXTENTS', 14, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TOTAL_EXTENTS', 15, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'EXTENT_SIZE', 16, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'INITIAL_SIZE', 17, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'MAXIMUM_SIZE', 18, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'AUTOEXTEND_SIZE', 19, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'CREATION_TIME', 20, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'LAST_UPDATE_TIME', 21, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'LAST_ACCESS_TIME', 22, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'RECOVER_TIME', 23, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TRANSACTION_COUNTER', 24, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'VERSION', 25, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'ROW_FORMAT', 26, NULL, 'YES', 'varchar', 10, 30, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(10)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'TABLE_ROWS', 27, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'AVG_ROW_LENGTH', 28, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'DATA_LENGTH', 29, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'MAX_DATA_LENGTH', 30, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'INDEX_LENGTH', 31, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'DATA_FREE', 32, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'CREATE_TIME', 33, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'UPDATE_TIME', 34, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'CHECK_TIME', 35, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'CHECKSUM', 36, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'STATUS', 37, '', 'NO', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'FILES', 'EXTRA', 38, NULL, 'YES', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(255)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_STATUS', 'VARIABLE_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_STATUS', 'VARIABLE_VALUE', 2, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'SESSION_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'ENGINE', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'NAME', 5, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'TABLE_ROWS', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'AVG_ROW_LENGTH', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'DATA_LENGTH', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'INDEX_LENGTH', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'CREATE_TIME', 10, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'UPDATE_TIME', 11, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_VARIABLES', 'VARIABLE_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'GLOBAL_VARIABLES', 'VARIABLE_VALUE', 2, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'CONSTRAINT_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'CONSTRAINT_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'CONSTRAINT_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'TABLE_CATALOG', 4, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'TABLE_SCHEMA', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'TABLE_NAME', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'COLUMN_NAME', 7, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'ORDINAL_POSITION', 8, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(10)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'POSITION_IN_UNIQUE_CONSTRAINT', 9, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(10)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'REFERENCED_TABLE_SCHEMA', 10, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'REFERENCED_TABLE_NAME', 11, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'REFERENCED_COLUMN_NAME', 12, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'SPECIFIC_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'SPECIFIC_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'SPECIFIC_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'ORDINAL_POSITION', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'PARAMETER_MODE', 5, NULL, 'YES', 'varchar', 5, 15, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(5)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'PARAMETER_NAME', 6, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'DATA_TYPE', 7, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'CHARACTER_MAXIMUM_LENGTH', 8, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'CHARACTER_OCTET_LENGTH', 9, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'NUMERIC_PRECISION', 10, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'NUMERIC_SCALE', 11, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'CHARACTER_SET_NAME', 12, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'COLLATION_NAME', 13, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'DTD_IDENTIFIER', 14, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PARAMETERS', 'ROUTINE_TYPE', 15, '', 'NO', 'varchar', 9, 27, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(9)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'TABLE_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_NAME', 4, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'SUBPARTITION_NAME', 5, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_ORDINAL_POSITION', 6, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'SUBPARTITION_ORDINAL_POSITION', 7, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_METHOD', 8, NULL, 'YES', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'SUBPARTITION_METHOD', 9, NULL, 'YES', 'varchar', 12, 36, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(12)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_EXPRESSION', 10, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'SUBPARTITION_EXPRESSION', 11, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_DESCRIPTION', 12, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'TABLE_ROWS', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'AVG_ROW_LENGTH', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'DATA_LENGTH', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'MAX_DATA_LENGTH', 16, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'INDEX_LENGTH', 17, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'DATA_FREE', 18, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'CREATE_TIME', 19, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'UPDATE_TIME', 20, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'CHECK_TIME', 21, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'CHECKSUM', 22, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'PARTITION_COMMENT', 23, '', 'NO', 'varchar', 80, 240, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(80)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'NODEGROUP', 24, '', 'NO', 'varchar', 12, 36, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(12)', '', '', 'select', ''),
('def', 'information_schema', 'PARTITIONS', 'TABLESPACE_NAME', 25, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_VERSION', 2, '', 'NO', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_STATUS', 3, '', 'NO', 'varchar', 10, 30, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(10)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_TYPE', 4, '', 'NO', 'varchar', 80, 240, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(80)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_TYPE_VERSION', 5, '', 'NO', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_LIBRARY', 6, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_LIBRARY_VERSION', 7, NULL, 'YES', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_AUTHOR', 8, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_DESCRIPTION', 9, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'PLUGIN_LICENSE', 10, NULL, 'YES', 'varchar', 80, 240, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(80)', '', '', 'select', ''),
('def', 'information_schema', 'PLUGINS', 'LOAD_OPTION', 11, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'ID', 1, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'USER', 2, '', 'NO', 'varchar', 16, 48, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(16)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'HOST', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'DB', 4, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'COMMAND', 5, '', 'NO', 'varchar', 16, 48, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(16)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'TIME', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(7)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'STATE', 7, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'INFO', 8, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'TIME_MS', 9, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(21)', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'ROWS_SENT', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'ROWS_EXAMINED', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PROCESSLIST', 'ROWS_READ', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'QUERY_ID', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'SEQ', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'STATE', 3, '', 'NO', 'varchar', 30, 90, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(30)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'DURATION', 4, '0.000000', 'NO', 'decimal', NULL, NULL, 9, 6, NULL, NULL, 'decimal(9,6)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'CPU_USER', 5, NULL, 'YES', 'decimal', NULL, NULL, 9, 6, NULL, NULL, 'decimal(9,6)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'CPU_SYSTEM', 6, NULL, 'YES', 'decimal', NULL, NULL, 9, 6, NULL, NULL, 'decimal(9,6)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'CONTEXT_VOLUNTARY', 7, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'CONTEXT_INVOLUNTARY', 8, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'BLOCK_OPS_IN', 9, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'BLOCK_OPS_OUT', 10, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'MESSAGES_SENT', 11, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'MESSAGES_RECEIVED', 12, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'PAGE_FAULTS_MAJOR', 13, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'PAGE_FAULTS_MINOR', 14, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'SWAPS', 15, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'SOURCE_FUNCTION', 16, NULL, 'YES', 'varchar', 30, 90, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(30)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'SOURCE_FILE', 17, NULL, 'YES', 'varchar', 20, 60, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(20)', '', '', 'select', ''),
('def', 'information_schema', 'PROFILING', 'SOURCE_LINE', 18, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(20)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'CONSTRAINT_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'CONSTRAINT_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'CONSTRAINT_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'UNIQUE_CONSTRAINT_CATALOG', 4, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'UNIQUE_CONSTRAINT_SCHEMA', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'UNIQUE_CONSTRAINT_NAME', 6, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'MATCH_OPTION', 7, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'UPDATE_RULE', 8, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'DELETE_RULE', 9, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'TABLE_NAME', 10, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'REFERENCED_TABLE_NAME', 11, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'SPECIFIC_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_CATALOG', 2, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_SCHEMA', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_NAME', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_TYPE', 5, '', 'NO', 'varchar', 9, 27, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(9)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'DATA_TYPE', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'CHARACTER_MAXIMUM_LENGTH', 7, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'CHARACTER_OCTET_LENGTH', 8, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'NUMERIC_PRECISION', 9, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'NUMERIC_SCALE', 10, NULL, 'YES', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(21)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'CHARACTER_SET_NAME', 11, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'COLLATION_NAME', 12, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'DTD_IDENTIFIER', 13, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_BODY', 14, '', 'NO', 'varchar', 8, 24, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_DEFINITION', 15, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'EXTERNAL_NAME', 16, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'EXTERNAL_LANGUAGE', 17, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'PARAMETER_STYLE', 18, '', 'NO', 'varchar', 8, 24, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'IS_DETERMINISTIC', 19, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'SQL_DATA_ACCESS', 20, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'SQL_PATH', 21, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'SECURITY_TYPE', 22, '', 'NO', 'varchar', 7, 21, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(7)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'CREATED', 23, '0000-00-00 00:00:00', 'NO', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'LAST_ALTERED', 24, '0000-00-00 00:00:00', 'NO', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'SQL_MODE', 25, '', 'NO', 'varchar', 8192, 24576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8192)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'ROUTINE_COMMENT', 26, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'DEFINER', 27, '', 'NO', 'varchar', 77, 231, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(77)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'CHARACTER_SET_CLIENT', 28, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'COLLATION_CONNECTION', 29, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'ROUTINES', 'DATABASE_COLLATION', 30, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'QUERY_RESPONSE_TIME', 'time', 1, '', 'NO', 'varchar', 14, 42, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(14)', '', '', 'select', ''),
('def', 'information_schema', 'QUERY_RESPONSE_TIME', 'count', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'QUERY_RESPONSE_TIME', 'total', 3, '', 'NO', 'varchar', 14, 42, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(14)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMATA', 'CATALOG_NAME', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMATA', 'SCHEMA_NAME', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMATA', 'DEFAULT_CHARACTER_SET_NAME', 3, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMATA', 'DEFAULT_COLLATION_NAME', 4, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMATA', 'SQL_PATH', 5, NULL, 'YES', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'GRANTEE', 1, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'TABLE_CATALOG', 2, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'TABLE_SCHEMA', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'PRIVILEGE_TYPE', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'IS_GRANTABLE', 5, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'SESSION_STATUS', 'VARIABLE_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'SESSION_STATUS', 'VARIABLE_VALUE', 2, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'SESSION_VARIABLES', 'VARIABLE_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'SESSION_VARIABLES', 'VARIABLE_VALUE', 2, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', '');
INSERT INTO `COLUMNS` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `COLUMN_DEFAULT`, `IS_NULLABLE`, `DATA_TYPE`, `CHARACTER_MAXIMUM_LENGTH`, `CHARACTER_OCTET_LENGTH`, `NUMERIC_PRECISION`, `NUMERIC_SCALE`, `CHARACTER_SET_NAME`, `COLLATION_NAME`, `COLUMN_TYPE`, `COLUMN_KEY`, `EXTRA`, `PRIVILEGES`, `COLUMN_COMMENT`) VALUES
('def', 'information_schema', 'STATISTICS', 'TABLE_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'NON_UNIQUE', 4, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(1)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'INDEX_SCHEMA', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'INDEX_NAME', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'SEQ_IN_INDEX', 7, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(2)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'COLUMN_NAME', 8, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'COLLATION', 9, NULL, 'YES', 'varchar', 1, 3, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'CARDINALITY', 10, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(21)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'SUB_PART', 11, NULL, 'YES', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(3)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'PACKED', 12, NULL, 'YES', 'varchar', 10, 30, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(10)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'NULLABLE', 13, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'INDEX_TYPE', 14, '', 'NO', 'varchar', 16, 48, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(16)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'COMMENT', 15, NULL, 'YES', 'varchar', 16, 48, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(16)', '', '', 'select', ''),
('def', 'information_schema', 'STATISTICS', 'INDEX_COMMENT', 16, '', 'NO', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_TYPE', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'ENGINE', 5, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'VERSION', 6, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'ROW_FORMAT', 7, NULL, 'YES', 'varchar', 10, 30, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(10)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_ROWS', 8, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'AVG_ROW_LENGTH', 9, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'DATA_LENGTH', 10, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'MAX_DATA_LENGTH', 11, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'INDEX_LENGTH', 12, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'DATA_FREE', 13, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'AUTO_INCREMENT', 14, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'CREATE_TIME', 15, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'UPDATE_TIME', 16, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'CHECK_TIME', 17, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_COLLATION', 18, NULL, 'YES', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'CHECKSUM', 19, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'CREATE_OPTIONS', 20, NULL, 'YES', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(255)', '', '', 'select', ''),
('def', 'information_schema', 'TABLES', 'TABLE_COMMENT', 21, '', 'NO', 'varchar', 2048, 6144, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(2048)', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'TABLESPACE_NAME', 1, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'ENGINE', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'TABLESPACE_TYPE', 3, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'LOGFILE_GROUP_NAME', 4, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'EXTENT_SIZE', 5, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'AUTOEXTEND_SIZE', 6, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'MAXIMUM_SIZE', 7, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'NODEGROUP_ID', 8, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLESPACES', 'TABLESPACE_COMMENT', 9, NULL, 'YES', 'varchar', 2048, 6144, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(2048)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'CONSTRAINT_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'CONSTRAINT_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'CONSTRAINT_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'TABLE_SCHEMA', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'TABLE_NAME', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'CONSTRAINT_TYPE', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'GRANTEE', 1, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'TABLE_CATALOG', 2, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'TABLE_SCHEMA', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'TABLE_NAME', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'PRIVILEGE_TYPE', 5, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'IS_GRANTABLE', 6, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'TABLE_SCHEMA', 1, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'TABLE_NAME', 2, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'ROWS_READ', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'ROWS_CHANGED', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'ROWS_CHANGED_X_INDEXES', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'SESSION_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'ENGINE', 4, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'NAME', 5, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'TABLE_ROWS', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'AVG_ROW_LENGTH', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'DATA_LENGTH', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'INDEX_LENGTH', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'CREATE_TIME', 10, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'UPDATE_TIME', 11, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'THREAD_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'TOTAL_CONNECTIONS', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'CONCURRENT_CONNECTIONS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'CONNECTED_TIME', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'BUSY_TIME', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'CPU_TIME', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'BYTES_RECEIVED', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'BYTES_SENT', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'BINLOG_BYTES_WRITTEN', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'ROWS_FETCHED', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'ROWS_UPDATED', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'TABLE_ROWS_READ', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'SELECT_COMMANDS', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'UPDATE_COMMANDS', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'OTHER_COMMANDS', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'COMMIT_TRANSACTIONS', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'ROLLBACK_TRANSACTIONS', 17, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'DENIED_CONNECTIONS', 18, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'LOST_CONNECTIONS', 19, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'ACCESS_DENIED', 20, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'EMPTY_QUERIES', 21, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'TOTAL_SSL_CONNECTIONS', 22, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'TRIGGER_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'TRIGGER_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'TRIGGER_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'EVENT_MANIPULATION', 4, '', 'NO', 'varchar', 6, 18, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(6)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'EVENT_OBJECT_CATALOG', 5, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'EVENT_OBJECT_SCHEMA', 6, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'EVENT_OBJECT_TABLE', 7, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_ORDER', 8, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(4)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_CONDITION', 9, NULL, 'YES', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_STATEMENT', 10, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_ORIENTATION', 11, '', 'NO', 'varchar', 9, 27, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(9)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_TIMING', 12, '', 'NO', 'varchar', 6, 18, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(6)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_REFERENCE_OLD_TABLE', 13, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_REFERENCE_NEW_TABLE', 14, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_REFERENCE_OLD_ROW', 15, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'ACTION_REFERENCE_NEW_ROW', 16, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'CREATED', 17, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'SQL_MODE', 18, '', 'NO', 'varchar', 8192, 24576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8192)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'DEFINER', 19, '', 'NO', 'varchar', 77, 231, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(77)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'CHARACTER_SET_CLIENT', 20, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'COLLATION_CONNECTION', 21, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'TRIGGERS', 'DATABASE_COLLATION', 22, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'USER_PRIVILEGES', 'GRANTEE', 1, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'USER_PRIVILEGES', 'TABLE_CATALOG', 2, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'USER_PRIVILEGES', 'PRIVILEGE_TYPE', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'USER_PRIVILEGES', 'IS_GRANTABLE', 4, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'USER', 1, '', 'NO', 'varchar', 144, 432, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(144)', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'TOTAL_CONNECTIONS', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'CONCURRENT_CONNECTIONS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'CONNECTED_TIME', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'BUSY_TIME', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'CPU_TIME', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'BYTES_RECEIVED', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'BYTES_SENT', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'BINLOG_BYTES_WRITTEN', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'ROWS_FETCHED', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'ROWS_UPDATED', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'TABLE_ROWS_READ', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'SELECT_COMMANDS', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'UPDATE_COMMANDS', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'OTHER_COMMANDS', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'COMMIT_TRANSACTIONS', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'ROLLBACK_TRANSACTIONS', 17, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'DENIED_CONNECTIONS', 18, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'LOST_CONNECTIONS', 19, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'ACCESS_DENIED', 20, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'EMPTY_QUERIES', 21, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'USER_STATISTICS', 'TOTAL_SSL_CONNECTIONS', 22, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'TABLE_CATALOG', 1, '', 'NO', 'varchar', 512, 1536, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(512)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'TABLE_SCHEMA', 2, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'TABLE_NAME', 3, '', 'NO', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'VIEW_DEFINITION', 4, NULL, 'NO', 'longtext', 4294967295, 4294967295, NULL, NULL, 'utf8', 'utf8_general_ci', 'longtext', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'CHECK_OPTION', 5, '', 'NO', 'varchar', 8, 24, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'IS_UPDATABLE', 6, '', 'NO', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'DEFINER', 7, '', 'NO', 'varchar', 77, 231, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(77)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'SECURITY_TYPE', 8, '', 'NO', 'varchar', 7, 21, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(7)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'CHARACTER_SET_CLIENT', 9, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'VIEWS', 'COLLATION_CONNECTION', 10, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'page_size', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(5)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'buffer_pool_instance', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'pages_used', 3, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'pages_free', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'relocation_ops', 5, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(21)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'relocation_time', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'rseg_id', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'space_id', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'zip_size', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'page_no', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'max_size', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_RSEG', 'curr_size', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'trx_id', 1, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'rseg_id', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'useg_id', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'type', 4, '', 'NO', 'varchar', 256, 768, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(256)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'state', 5, '', 'NO', 'varchar', 256, 768, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(256)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'size', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'page_size', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(5)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'buffer_pool_instance', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'pages_used', 3, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'pages_free', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'relocation_ops', 5, '0', 'NO', 'bigint', NULL, NULL, 19, 0, NULL, NULL, 'bigint(21)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'relocation_time', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'TABLE_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'SCHEMA', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'NAME', 3, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'STATS_INITIALIZED', 4, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'NUM_ROWS', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'CLUST_INDEX_SIZE', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'OTHER_INDEX_SIZE', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'MODIFIED_COUNTER', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'AUTOINC', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'MYSQL_HANDLES_OPENED', 10, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCK_WAITS', 'requesting_trx_id', 1, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCK_WAITS', 'requested_lock_id', 2, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCK_WAITS', 'blocking_trx_id', 3, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCK_WAITS', 'blocking_lock_id', 4, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'table_schema', 1, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'table_name', 2, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'index_name', 3, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'fields', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'rows_per_key', 5, '', 'NO', 'varchar', 256, 768, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(256)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'index_total_pages', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'index_leaf_pages', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'page_size', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(5)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'compress_ops', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'compress_ops_ok', 3, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'compress_time', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'uncompress_ops', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP', 'uncompress_time', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'page_size', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(5)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'compress_ops', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'compress_ops_ok', 3, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'compress_time', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'uncompress_ops', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'uncompress_time', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', 'space_id', 1, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', 'page_id', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', 'start_lsn', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', 'end_lsn', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'page_type', 1, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'space_id', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'page_no', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'lru_position', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'fix_count', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'flush_type', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_id', 1, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_state', 2, '', 'NO', 'varchar', 13, 39, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(13)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_started', 3, '0000-00-00 00:00:00', 'NO', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_requested_lock_id', 4, NULL, 'YES', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_wait_started', 5, NULL, 'YES', 'datetime', NULL, NULL, NULL, NULL, NULL, NULL, 'datetime', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_weight', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_mysql_thread_id', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_query', 8, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_operation_state', 9, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_tables_in_use', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_tables_locked', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_lock_structs', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_lock_memory_bytes', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_rows_locked', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_rows_modified', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_concurrency_tickets', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_isolation_level', 17, '', 'NO', 'varchar', 16, 48, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(16)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_unique_checks', 18, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(1)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_foreign_key_checks', 19, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(1)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_last_foreign_key_error', 20, NULL, 'YES', 'varchar', 256, 768, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(256)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_adaptive_hash_latched', 21, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(1)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TRX', 'trx_adaptive_hash_timeout', 22, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'index_id', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'space_id', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'page_no', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'n_recs', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'data_size', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'hashed', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'access_time', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'modified', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'dirty', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'old', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'lru_position', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'fix_count', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'flush_type', 13, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_id', 1, '', 'NO', 'varchar', 81, 243, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(81)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_trx_id', 2, '', 'NO', 'varchar', 18, 54, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(18)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_mode', 3, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_type', 4, '', 'NO', 'varchar', 32, 96, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(32)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_table', 5, '', 'NO', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_index', 6, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_space', 7, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_page', 8, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_rec', 9, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'lock_data', 10, NULL, 'YES', 'varchar', 8192, 24576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(8192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'space_id', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'page_no', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'compressed', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'part_len', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'next_page_no', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'lru_position', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'fix_count', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'flush_type', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'TABLE_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'SCHEMA', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'NAME', 3, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'FLAG', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'N_COLS', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'SPACE', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FIELDS', 'INDEX_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FIELDS', 'NAME', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FIELDS', 'POS', 3, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'TABLE_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'NAME', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'POS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'MTYPE', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'PRTYPE', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'LEN', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'POOL_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'BLOCK_ID', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'SPACE', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'PAGE_NUMBER', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'PAGE_TYPE', 5, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'FLUSH_TYPE', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'FIX_COUNT', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'IS_HASHED', 8, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'NEWEST_MODIFICATION', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', '');
INSERT INTO `COLUMNS` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `COLUMN_DEFAULT`, `IS_NULLABLE`, `DATA_TYPE`, `CHARACTER_MAXIMUM_LENGTH`, `CHARACTER_OCTET_LENGTH`, `NUMERIC_PRECISION`, `NUMERIC_SCALE`, `CHARACTER_SET_NAME`, `COLLATION_NAME`, `COLUMN_TYPE`, `COLUMN_KEY`, `EXTRA`, `PRIVILEGES`, `COLUMN_COMMENT`) VALUES
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'OLDEST_MODIFICATION', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'ACCESS_TIME', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'TABLE_NAME', 12, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'INDEX_NAME', 13, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'NUMBER_RECORDS', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'DATA_SIZE', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'COMPRESSED_SIZE', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'PAGE_STATE', 17, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'IO_FIX', 18, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'IS_OLD', 19, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'FREE_PAGE_CLOCK', 20, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_STATS', 'INDEX_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_STATS', 'KEY_COLS', 2, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_STATS', 'DIFF_VALS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_STATS', 'NON_NULL_VALS', 4, NULL, 'YES', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'ID', 1, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'FOR_NAME', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'REF_NAME', 3, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'N_COLS', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'TYPE', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'INDEX_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'NAME', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'TABLE_ID', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'TYPE', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'N_FIELDS', 5, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'PAGE_NO', 6, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'SPACE', 7, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', '', '', 'select', ''),
('def', 'information_schema', 'XTRADB_ADMIN_COMMAND', 'result_message', 1, '', 'NO', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'table_schema', 1, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'table_name', 2, '', 'NO', 'varchar', 192, 576, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(192)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'rows', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'clust_size', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'other_size', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'modified', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', 'ID', 1, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', 'FOR_COL_NAME', 2, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', 'REF_COL_NAME', 3, '', 'NO', 'varchar', 193, 579, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(193)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', 'POS', 4, '0', 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'POOL_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'LRU_POSITION', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'SPACE', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'PAGE_NUMBER', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'PAGE_TYPE', 5, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'FLUSH_TYPE', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'FIX_COUNT', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'IS_HASHED', 8, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'NEWEST_MODIFICATION', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'OLDEST_MODIFICATION', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'ACCESS_TIME', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'TABLE_NAME', 12, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'INDEX_NAME', 13, NULL, 'YES', 'varchar', 1024, 3072, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(1024)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'NUMBER_RECORDS', 14, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'DATA_SIZE', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'COMPRESSED_SIZE', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'COMPRESSED', 17, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'IO_FIX', 18, NULL, 'YES', 'varchar', 64, 192, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(64)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'IS_OLD', 19, NULL, 'YES', 'varchar', 3, 9, NULL, NULL, 'utf8', 'utf8_general_ci', 'varchar(3)', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'FREE_PAGE_CLOCK', 20, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'POOL_ID', 1, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'POOL_SIZE', 2, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'FREE_BUFFERS', 3, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'DATABASE_PAGES', 4, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'OLD_DATABASE_PAGES', 5, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'MODIFIED_DATABASE_PAGES', 6, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PENDING_DECOMPRESS', 7, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PENDING_READS', 8, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PENDING_FLUSH_LRU', 9, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PENDING_FLUSH_LIST', 10, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_MADE_YOUNG', 11, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_NOT_MADE_YOUNG', 12, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_MADE_YOUNG_RATE', 13, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_MADE_NOT_YOUNG_RATE', 14, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_PAGES_READ', 15, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_PAGES_CREATED', 16, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_PAGES_WRITTEN', 17, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_READ_RATE', 18, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_CREATE_RATE', 19, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'PAGES_WRITTEN_RATE', 20, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_PAGES_GET', 21, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'HIT_RATE', 22, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'YOUNG_MAKE_PER_THOUSAND_GETS', 23, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NOT_YOUNG_MAKE_PER_THOUSAND_GETS', 24, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_PAGES_READ_AHEAD', 25, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'NUMBER_READ_AHEAD_EVICTED', 26, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'READ_AHEAD_RATE', 27, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'READ_AHEAD_EVICTED_RATE', 28, '0', 'NO', 'double', NULL, NULL, 12, NULL, NULL, NULL, 'double', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'LRU_IO_TOTAL', 29, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'LRU_IO_CURRENT', 30, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'UNCOMPRESS_TOTAL', 31, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'UNCOMPRESS_CURRENT', 32, '0', 'NO', 'bigint', NULL, NULL, 20, 0, NULL, NULL, 'bigint(21) unsigned', '', '', 'select', ''),
('def', '09424370_crm', 'realization_timeline', 'id', 1, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'PRI', 'auto_increment', 'select,insert,update,references', ''),
('def', '09424370_crm', 'realization_timeline', 'task_id', 2, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'MUL', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'realization_timeline', 'user_id', 3, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'MUL', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'realization_timeline', 'realization_type', 4, NULL, 'NO', 'varchar', 50, 150, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(50)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'realization_timeline', 'control_date', 5, NULL, 'NO', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'realization_timeline', 'notes', 6, NULL, 'NO', 'varchar', 500, 1500, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(500)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'role', 'id', 1, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'PRI', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'role', 'name', 2, NULL, 'NO', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(255)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'status', 'id', 1, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'PRI', 'auto_increment', 'select,insert,update,references', ''),
('def', '09424370_crm', 'status', 'name', 2, NULL, 'NO', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(255)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'id', 1, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'PRI', 'auto_increment', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'task_name', 2, NULL, 'NO', 'varchar', 50, 150, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(50)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'user_id', 3, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'MUL', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'notes', 4, NULL, 'YES', 'varchar', 500, 1500, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(500)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'status_id', 5, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'MUL', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'start_date', 6, NULL, 'NO', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'end_date', 7, NULL, 'NO', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'client_name', 8, NULL, 'NO', 'varchar', 200, 600, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(200)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'contact_phone', 9, NULL, 'NO', 'varchar', 15, 45, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(15)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'tasks', 'contact_email', 10, NULL, 'NO', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(255)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'users', 'id', 1, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'PRI', 'auto_increment', 'select,insert,update,references', ''),
('def', '09424370_crm', 'users', 'name', 2, NULL, 'NO', 'varchar', 255, 765, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(255)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'users', 'login', 3, NULL, 'NO', 'varchar', 25, 75, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(25)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'users', 'password', 4, NULL, 'NO', 'varchar', 25, 75, NULL, NULL, 'utf8', 'utf8_polish_ci', 'varchar(25)', '', '', 'select,insert,update,references', ''),
('def', '09424370_crm', 'users', 'role_id', 5, NULL, 'NO', 'int', NULL, NULL, 10, 0, NULL, NULL, 'int(11)', 'MUL', '', 'select,insert,update,references', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `COLUMN_PRIVILEGES`
--

CREATE TEMPORARY TABLE `COLUMN_PRIVILEGES` (
  `GRANTEE` varchar(81) NOT NULL DEFAULT '',
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',
  `PRIVILEGE_TYPE` varchar(64) NOT NULL DEFAULT '',
  `IS_GRANTABLE` varchar(3) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INDEX_STATISTICS`
--

CREATE TEMPORARY TABLE `INDEX_STATISTICS` (
  `TABLE_SCHEMA` varchar(192) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(192) NOT NULL DEFAULT '',
  `INDEX_NAME` varchar(192) NOT NULL DEFAULT '',
  `ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `INDEX_STATISTICS`
--

INSERT INTO `INDEX_STATISTICS` (`TABLE_SCHEMA`, `TABLE_NAME`, `INDEX_NAME`, `ROWS_READ`) VALUES
('09424370_crm', 'contact_timeline', 'user_id', 40),
('09424370_crm', 'realization_timeline', 'task_id', 12),
('09424370_crm', 'users', 'PRIMARY', 546),
('09424370_crm', 'realization_timeline', 'user_id', 5),
('09424370_crm', 'clients', 'PRIMARY', 743),
('09424370_crm', 'contact_timeline', 'PRIMARY', 80),
('09424370_crm', 'status', 'PRIMARY', 280),
('09424370_crm', 'company_sectors', 'PRIMARY', 374),
('09424370_crm', 'role', 'PRIMARY', 50),
('09424370_crm', 'tasks', 'status_id', 82),
('09424370_crm', 'clients', 'sector_id', 348),
('09424370_crm', 'users', 'users_ibfk_1', 21),
('09424370_crm', 'realization_timeline', 'PRIMARY', 41),
('09424370_crm', 'tasks', 'PRIMARY', 274);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ENGINES`
--

CREATE TEMPORARY TABLE `ENGINES` (
  `ENGINE` varchar(64) NOT NULL DEFAULT '',
  `SUPPORT` varchar(8) NOT NULL DEFAULT '',
  `COMMENT` varchar(80) NOT NULL DEFAULT '',
  `TRANSACTIONS` varchar(3) DEFAULT NULL,
  `XA` varchar(3) DEFAULT NULL,
  `SAVEPOINTS` varchar(3) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `ENGINES`
--

INSERT INTO `ENGINES` (`ENGINE`, `SUPPORT`, `COMMENT`, `TRANSACTIONS`, `XA`, `SAVEPOINTS`) VALUES
('MRG_MYISAM', 'YES', 'Collection of identical MyISAM tables', 'NO', 'NO', 'NO'),
('PERFORMANCE_SCHEMA', 'YES', 'Performance Schema', 'NO', 'NO', 'NO'),
('CSV', 'YES', 'CSV storage engine', 'NO', 'NO', 'NO'),
('MyISAM', 'YES', 'MyISAM storage engine', 'NO', 'NO', 'NO'),
('InnoDB', 'DEFAULT', 'Percona-XtraDB, Supports transactions, row-level locking, and foreign keys', 'YES', 'YES', 'YES'),
('MEMORY', 'YES', 'Hash based, stored in memory, useful for temporary tables', 'NO', 'NO', 'NO');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `EVENTS`
--

CREATE TEMPORARY TABLE `EVENTS` (
  `EVENT_CATALOG` varchar(64) NOT NULL DEFAULT '',
  `EVENT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `EVENT_NAME` varchar(64) NOT NULL DEFAULT '',
  `DEFINER` varchar(77) NOT NULL DEFAULT '',
  `TIME_ZONE` varchar(64) NOT NULL DEFAULT '',
  `EVENT_BODY` varchar(8) NOT NULL DEFAULT '',
  `EVENT_DEFINITION` longtext NOT NULL,
  `EVENT_TYPE` varchar(9) NOT NULL DEFAULT '',
  `EXECUTE_AT` datetime DEFAULT NULL,
  `INTERVAL_VALUE` varchar(256) DEFAULT NULL,
  `INTERVAL_FIELD` varchar(18) DEFAULT NULL,
  `SQL_MODE` varchar(8192) NOT NULL DEFAULT '',
  `STARTS` datetime DEFAULT NULL,
  `ENDS` datetime DEFAULT NULL,
  `STATUS` varchar(18) NOT NULL DEFAULT '',
  `ON_COMPLETION` varchar(12) NOT NULL DEFAULT '',
  `CREATED` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LAST_ALTERED` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LAST_EXECUTED` datetime DEFAULT NULL,
  `EVENT_COMMENT` varchar(64) NOT NULL DEFAULT '',
  `ORIGINATOR` bigint(10) NOT NULL DEFAULT '0',
  `CHARACTER_SET_CLIENT` varchar(32) NOT NULL DEFAULT '',
  `COLLATION_CONNECTION` varchar(32) NOT NULL DEFAULT '',
  `DATABASE_COLLATION` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `FILES`
--

CREATE TEMPORARY TABLE `FILES` (
  `FILE_ID` bigint(4) NOT NULL DEFAULT '0',
  `FILE_NAME` varchar(64) DEFAULT NULL,
  `FILE_TYPE` varchar(20) NOT NULL DEFAULT '',
  `TABLESPACE_NAME` varchar(64) DEFAULT NULL,
  `TABLE_CATALOG` varchar(64) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) DEFAULT NULL,
  `TABLE_NAME` varchar(64) DEFAULT NULL,
  `LOGFILE_GROUP_NAME` varchar(64) DEFAULT NULL,
  `LOGFILE_GROUP_NUMBER` bigint(4) DEFAULT NULL,
  `ENGINE` varchar(64) NOT NULL DEFAULT '',
  `FULLTEXT_KEYS` varchar(64) DEFAULT NULL,
  `DELETED_ROWS` bigint(4) DEFAULT NULL,
  `UPDATE_COUNT` bigint(4) DEFAULT NULL,
  `FREE_EXTENTS` bigint(4) DEFAULT NULL,
  `TOTAL_EXTENTS` bigint(4) DEFAULT NULL,
  `EXTENT_SIZE` bigint(4) NOT NULL DEFAULT '0',
  `INITIAL_SIZE` bigint(21) unsigned DEFAULT NULL,
  `MAXIMUM_SIZE` bigint(21) unsigned DEFAULT NULL,
  `AUTOEXTEND_SIZE` bigint(21) unsigned DEFAULT NULL,
  `CREATION_TIME` datetime DEFAULT NULL,
  `LAST_UPDATE_TIME` datetime DEFAULT NULL,
  `LAST_ACCESS_TIME` datetime DEFAULT NULL,
  `RECOVER_TIME` bigint(4) DEFAULT NULL,
  `TRANSACTION_COUNTER` bigint(4) DEFAULT NULL,
  `VERSION` bigint(21) unsigned DEFAULT NULL,
  `ROW_FORMAT` varchar(10) DEFAULT NULL,
  `TABLE_ROWS` bigint(21) unsigned DEFAULT NULL,
  `AVG_ROW_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `DATA_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `MAX_DATA_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `INDEX_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `DATA_FREE` bigint(21) unsigned DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `CHECK_TIME` datetime DEFAULT NULL,
  `CHECKSUM` bigint(21) unsigned DEFAULT NULL,
  `STATUS` varchar(20) NOT NULL DEFAULT '',
  `EXTRA` varchar(255) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `GLOBAL_STATUS`
--

CREATE TEMPORARY TABLE `GLOBAL_STATUS` (
  `VARIABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `VARIABLE_VALUE` varchar(1024) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `GLOBAL_STATUS`
--

INSERT INTO `GLOBAL_STATUS` (`VARIABLE_NAME`, `VARIABLE_VALUE`) VALUES
('ABORTED_CLIENTS', '4029'),
('ABORTED_CONNECTS', '96362'),
('BINLOG_CACHE_DISK_USE', '0'),
('BINLOG_CACHE_USE', '0'),
('BINLOG_STMT_CACHE_DISK_USE', '0'),
('BINLOG_STMT_CACHE_USE', '0'),
('BYTES_RECEIVED', '365606584173'),
('BYTES_SENT', '3184369895193'),
('COM_ADMIN_COMMANDS', '8356352'),
('COM_ASSIGN_TO_KEYCACHE', '0'),
('COM_ALTER_DB', '6'),
('COM_ALTER_DB_UPGRADE', '0'),
('COM_ALTER_EVENT', '0'),
('COM_ALTER_FUNCTION', '0'),
('COM_ALTER_PROCEDURE', '0'),
('COM_ALTER_SERVER', '0'),
('COM_ALTER_TABLE', '15318'),
('COM_ALTER_TABLESPACE', '0'),
('COM_ANALYZE', '0'),
('COM_BEGIN', '3248928'),
('COM_BINLOG', '0'),
('COM_CALL_PROCEDURE', '4495'),
('COM_CHANGE_DB', '13466379'),
('COM_CHANGE_MASTER', '0'),
('COM_CHECK', '137418'),
('COM_CHECKSUM', '0'),
('COM_COMMIT', '3296141'),
('COM_CREATE_DB', '52'),
('COM_CREATE_EVENT', '0'),
('COM_CREATE_FUNCTION', '1'),
('COM_CREATE_INDEX', '4'),
('COM_CREATE_PROCEDURE', '10'),
('COM_CREATE_SERVER', '0'),
('COM_CREATE_TABLE', '51659'),
('COM_CREATE_TRIGGER', '0'),
('COM_CREATE_UDF', '0'),
('COM_CREATE_USER', '0'),
('COM_CREATE_VIEW', '42'),
('COM_DEALLOC_SQL', '0'),
('COM_DELETE', '8176723'),
('COM_DELETE_MULTI', '80071'),
('COM_DO', '0'),
('COM_DROP_DB', '13'),
('COM_DROP_EVENT', '0'),
('COM_DROP_FUNCTION', '0'),
('COM_DROP_INDEX', '0'),
('COM_DROP_PROCEDURE', '0'),
('COM_DROP_SERVER', '0'),
('COM_DROP_TABLE', '9115'),
('COM_DROP_TRIGGER', '0'),
('COM_DROP_USER', '7'),
('COM_DROP_VIEW', '2'),
('COM_EMPTY_QUERY', '7'),
('COM_EXECUTE_SQL', '0'),
('COM_FLUSH', '221'),
('COM_GRANT', '1'),
('COM_HA_CLOSE', '0'),
('COM_HA_OPEN', '0'),
('COM_HA_READ', '0'),
('COM_HELP', '0'),
('COM_INSERT', '211640902'),
('COM_INSERT_SELECT', '22550'),
('COM_INSTALL_PLUGIN', '0'),
('COM_KILL', '124'),
('COM_LOAD', '0'),
('COM_LOCK_TABLES', '73875'),
('COM_OPTIMIZE', '158'),
('COM_PRELOAD_KEYS', '0'),
('COM_PREPARE_SQL', '0'),
('COM_PURGE', '0'),
('COM_PURGE_BEFORE_DATE', '0'),
('COM_RELEASE_SAVEPOINT', '227'),
('COM_RENAME_TABLE', '0'),
('COM_RENAME_USER', '0'),
('COM_REPAIR', '1'),
('COM_REPLACE', '225777'),
('COM_REPLACE_SELECT', '1589'),
('COM_RESET', '0'),
('COM_RESIGNAL', '0'),
('COM_REVOKE', '0'),
('COM_REVOKE_ALL', '6'),
('COM_ROLLBACK', '2085'),
('COM_ROLLBACK_TO_SAVEPOINT', '0'),
('COM_SAVEPOINT', '229'),
('COM_SELECT', '148049795'),
('COM_SET_OPTION', '38561307'),
('COM_SIGNAL', '0'),
('COM_SHOW_AUTHORS', '0'),
('COM_SHOW_BINLOG_EVENTS', '0'),
('COM_SHOW_BINLOGS', '145'),
('COM_SHOW_CHARSETS', '0'),
('COM_SHOW_CLIENT_STATISTICS', '0'),
('COM_SHOW_COLLATIONS', '9'),
('COM_SHOW_CONTRIBUTORS', '0'),
('COM_SHOW_CREATE_DB', '7'),
('COM_SHOW_CREATE_EVENT', '0'),
('COM_SHOW_CREATE_FUNC', '62'),
('COM_SHOW_CREATE_PROC', '696'),
('COM_SHOW_CREATE_TABLE', '922067'),
('COM_SHOW_CREATE_TRIGGER', '0'),
('COM_SHOW_DATABASES', '1179'),
('COM_SHOW_ENGINE_LOGS', '0'),
('COM_SHOW_ENGINE_MUTEX', '0'),
('COM_SHOW_ENGINE_STATUS', '1'),
('COM_SHOW_EVENTS', '9'),
('COM_SHOW_ERRORS', '0'),
('COM_SHOW_FIELDS', '4028280'),
('COM_SHOW_FUNCTION_STATUS', '13499'),
('COM_SHOW_GRANTS', '87'),
('COM_SHOW_INDEX_STATISTICS', '0'),
('COM_SHOW_KEYS', '7839'),
('COM_SHOW_MASTER_STATUS', '227'),
('COM_SHOW_OPEN_TABLES', '0'),
('COM_SHOW_PLUGINS', '87'),
('COM_SHOW_PRIVILEGES', '0'),
('COM_SHOW_PROCEDURE_STATUS', '13499'),
('COM_SHOW_PROCESSLIST', '746029'),
('COM_SHOW_PROFILE', '0'),
('COM_SHOW_PROFILES', '1621'),
('COM_SHOW_RELAYLOG_EVENTS', '0'),
('COM_SHOW_SLAVE_HOSTS', '0'),
('COM_SHOW_SLAVE_STATUS', '227'),
('COM_SHOW_SLAVE_STATUS_NOLOCK', '0'),
('COM_SHOW_STATUS', '464442'),
('COM_SHOW_STORAGE_ENGINES', '27'),
('COM_SHOW_TABLE_STATISTICS', '0'),
('COM_SHOW_TABLE_STATUS', '950713'),
('COM_SHOW_TABLES', '740629'),
('COM_SHOW_TEMPORARY_TABLES', '0'),
('COM_SHOW_THREAD_STATISTICS', '0'),
('COM_SHOW_TRIGGERS', '901756'),
('COM_SHOW_USER_STATISTICS', '0'),
('COM_SHOW_VARIABLES', '485798'),
('COM_SHOW_WARNINGS', '340'),
('COM_SLAVE_START', '0'),
('COM_SLAVE_STOP', '0'),
('COM_STMT_CLOSE', '911'),
('COM_STMT_EXECUTE', '911'),
('COM_STMT_FETCH', '0'),
('COM_STMT_PREPARE', '911'),
('COM_STMT_REPREPARE', '0'),
('COM_STMT_RESET', '0'),
('COM_STMT_SEND_LONG_DATA', '0'),
('COM_TRUNCATE', '12092'),
('COM_UNINSTALL_PLUGIN', '0'),
('COM_UNLOCK_TABLES', '73877'),
('COM_UPDATE', '22901887'),
('COM_UPDATE_MULTI', '4240'),
('COM_XA_COMMIT', '0'),
('COM_XA_END', '0'),
('COM_XA_PREPARE', '0'),
('COM_XA_RECOVER', '0'),
('COM_XA_ROLLBACK', '0'),
('COM_XA_START', '0'),
('COMPRESSION', 'OFF'),
('CONNECTIONS', '16678133'),
('CREATED_TMP_DISK_TABLES', '15451920'),
('CREATED_TMP_FILES', '51163'),
('CREATED_TMP_TABLES', '41503112'),
('DELAYED_ERRORS', '0'),
('DELAYED_INSERT_THREADS', '0'),
('DELAYED_WRITES', '0'),
('FLASHCACHE_ENABLED', 'OFF'),
('FLUSH_COMMANDS', '1'),
('HANDLER_COMMIT', '144514841'),
('HANDLER_DELETE', '14368987'),
('HANDLER_DISCOVER', '0'),
('HANDLER_PREPARE', '0'),
('HANDLER_READ_FIRST', '31577993'),
('HANDLER_READ_KEY', '12358953317'),
('HANDLER_READ_LAST', '622070'),
('HANDLER_READ_NEXT', '25203382253'),
('HANDLER_READ_PREV', '256610939'),
('HANDLER_READ_RND', '1498701429'),
('HANDLER_READ_RND_NEXT', '82600714246'),
('HANDLER_ROLLBACK', '9383'),
('HANDLER_SAVEPOINT', '222'),
('HANDLER_SAVEPOINT_ROLLBACK', '0'),
('HANDLER_UPDATE', '1361024185'),
('HANDLER_WRITE', '2349384395'),
('INNODB_ADAPTIVE_HASH_CELLS', '553229'),
('INNODB_ADAPTIVE_HASH_HEAP_BUFFERS', '513'),
('INNODB_ADAPTIVE_HASH_HASH_SEARCHES', '14100218252'),
('INNODB_ADAPTIVE_HASH_NON_HASH_SEARCHES', '5386382414'),
('INNODB_BACKGROUND_LOG_SYNC', '2268497'),
('INNODB_BUFFER_POOL_PAGES_DATA', '15869'),
('INNODB_BUFFER_POOL_BYTES_DATA', '259997696'),
('INNODB_BUFFER_POOL_PAGES_DIRTY', '702'),
('INNODB_BUFFER_POOL_BYTES_DIRTY', '11501568'),
('INNODB_BUFFER_POOL_PAGES_FLUSHED', '33192479'),
('INNODB_BUFFER_POOL_PAGES_LRU_FLUSHED', '551190'),
('INNODB_BUFFER_POOL_PAGES_FREE', '0'),
('INNODB_BUFFER_POOL_PAGES_MADE_NOT_YOUNG', '0'),
('INNODB_BUFFER_POOL_PAGES_MADE_YOUNG', '174062213'),
('INNODB_BUFFER_POOL_PAGES_MISC', '514'),
('INNODB_BUFFER_POOL_PAGES_OLD', '5837'),
('INNODB_BUFFER_POOL_PAGES_TOTAL', '16383'),
('INNODB_BUFFER_POOL_READ_AHEAD_RND', '0'),
('INNODB_BUFFER_POOL_READ_AHEAD', '10790780'),
('INNODB_BUFFER_POOL_READ_AHEAD_EVICTED', '811128'),
('INNODB_BUFFER_POOL_READ_REQUESTS', '61647298950'),
('INNODB_BUFFER_POOL_READS', '125636971'),
('INNODB_BUFFER_POOL_WAIT_FREE', '0'),
('INNODB_BUFFER_POOL_WRITE_REQUESTS', '311574370'),
('INNODB_CHECKPOINT_AGE', '673983'),
('INNODB_CHECKPOINT_MAX_AGE', '53647074'),
('INNODB_CHECKPOINT_TARGET_AGE', '51970603'),
('INNODB_DATA_FSYNCS', '6589738'),
('INNODB_DATA_PENDING_FSYNCS', '0'),
('INNODB_DATA_PENDING_READS', '0'),
('INNODB_DATA_PENDING_WRITES', '0'),
('INNODB_DATA_READ', '2242185023488'),
('INNODB_DATA_READS', '136879128'),
('INNODB_DATA_WRITES', '36446909'),
('INNODB_DATA_WRITTEN', '1118883004928'),
('INNODB_DBLWR_PAGES_WRITTEN', '33192479'),
('INNODB_DBLWR_WRITES', '484759'),
('INNODB_DEADLOCKS', '3'),
('INNODB_DICT_TABLES', '27511'),
('INNODB_HAVE_ATOMIC_BUILTINS', 'ON'),
('INNODB_HISTORY_LIST_LENGTH', '2137'),
('INNODB_IBUF_DISCARDED_DELETE_MARKS', '0'),
('INNODB_IBUF_DISCARDED_DELETES', '0'),
('INNODB_IBUF_DISCARDED_INSERTS', '0'),
('INNODB_IBUF_FREE_LIST', '1422'),
('INNODB_IBUF_MERGED_DELETE_MARKS', '1182464'),
('INNODB_IBUF_MERGED_DELETES', '90183'),
('INNODB_IBUF_MERGED_INSERTS', '852965'),
('INNODB_IBUF_MERGES', '701933'),
('INNODB_IBUF_SEGMENT_SIZE', '1424'),
('INNODB_IBUF_SIZE', '1'),
('INNODB_LOG_WAITS', '7'),
('INNODB_LOG_WRITE_REQUESTS', '67455081'),
('INNODB_LOG_WRITES', '2192208'),
('INNODB_LSN_CURRENT', '4905596675659'),
('INNODB_LSN_FLUSHED', '4905596675659'),
('INNODB_LSN_LAST_CHECKPOINT', '4905596001676'),
('INNODB_MASTER_THREAD_1_SECOND_LOOPS', '2204837'),
('INNODB_MASTER_THREAD_10_SECOND_LOOPS', '219605'),
('INNODB_MASTER_THREAD_BACKGROUND_LOOPS', '14904'),
('INNODB_MASTER_THREAD_MAIN_FLUSH_LOOPS', '14896'),
('INNODB_MASTER_THREAD_SLEEPS', '2202441'),
('INNODB_MAX_TRX_ID', '4885180470'),
('INNODB_MEM_ADAPTIVE_HASH', '12851424'),
('INNODB_MEM_DICTIONARY', '229661438'),
('INNODB_MEM_TOTAL', '275513344'),
('INNODB_MUTEX_OS_WAITS', '161551'),
('INNODB_MUTEX_SPIN_ROUNDS', '24193009'),
('INNODB_MUTEX_SPIN_WAITS', '11848237'),
('INNODB_OLDEST_VIEW_LOW_LIMIT_TRX_ID', '4885180459'),
('INNODB_OS_LOG_FSYNCS', '2416227'),
('INNODB_OS_LOG_PENDING_FSYNCS', '0'),
('INNODB_OS_LOG_PENDING_WRITES', '0'),
('INNODB_OS_LOG_WRITTEN', '31116575232'),
('INNODB_PAGE_SIZE', '16384'),
('INNODB_PAGES_CREATED', '1133091'),
('INNODB_PAGES_READ', '136851994'),
('INNODB_PAGES_WRITTEN', '33192479'),
('INNODB_PURGE_TRX_ID', '4885180453'),
('INNODB_PURGE_UNDO_NO', '0'),
('INNODB_ROW_LOCK_CURRENT_WAITS', '0'),
('INNODB_CURRENT_ROW_LOCKS', '0'),
('INNODB_ROW_LOCK_TIME', '48851'),
('INNODB_ROW_LOCK_TIME_AVG', '7'),
('INNODB_ROW_LOCK_TIME_MAX', '2571'),
('INNODB_ROW_LOCK_WAITS', '6297'),
('INNODB_ROWS_DELETED', '11562552'),
('INNODB_ROWS_INSERTED', '27159409'),
('INNODB_ROWS_READ', '34399341173'),
('INNODB_ROWS_UPDATED', '16343151'),
('INNODB_READ_VIEWS_MEMORY', '472'),
('INNODB_DESCRIPTORS_MEMORY', '8000'),
('INNODB_S_LOCK_OS_WAITS', '787558'),
('INNODB_S_LOCK_SPIN_ROUNDS', '31922489'),
('INNODB_S_LOCK_SPIN_WAITS', '2629412'),
('INNODB_TRUNCATED_STATUS_WRITES', '0'),
('INNODB_X_LOCK_OS_WAITS', '120415'),
('INNODB_X_LOCK_SPIN_ROUNDS', '7676765'),
('INNODB_X_LOCK_SPIN_WAITS', '204213'),
('KEY_BLOCKS_NOT_FLUSHED', '0'),
('KEY_BLOCKS_UNUSED', '183356'),
('KEY_BLOCKS_USED', '198552'),
('KEY_READ_REQUESTS', '7844831030'),
('KEY_READS', '3578885'),
('KEY_WRITE_REQUESTS', '610164674'),
('KEY_WRITES', '224266598'),
('LAST_QUERY_COST', '0.000000'),
('MAX_USED_CONNECTIONS', '51'),
('NOT_FLUSHED_DELAYED_ROWS', '0'),
('OPEN_FILES', '1965'),
('OPEN_STREAMS', '0'),
('OPEN_TABLE_DEFINITIONS', '3714'),
('OPEN_TABLES', '4096'),
('OPENED_FILES', '65282660'),
('OPENED_TABLE_DEFINITIONS', '1798503'),
('OPENED_TABLES', '1871182'),
('PERFORMANCE_SCHEMA_COND_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_COND_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_HANDLES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_LOCKER_LOST', '0'),
('PERFORMANCE_SCHEMA_MUTEX_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_MUTEX_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_RWLOCK_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_RWLOCK_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_TABLE_HANDLES_LOST', '0'),
('PERFORMANCE_SCHEMA_TABLE_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_THREAD_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_THREAD_INSTANCES_LOST', '0'),
('PREPARED_STMT_COUNT', '0'),
('QCACHE_FREE_BLOCKS', '10947'),
('QCACHE_FREE_MEMORY', '33868456'),
('QCACHE_HITS', '1058430398'),
('QCACHE_INSERTS', '127013474'),
('QCACHE_LOWMEM_PRUNES', '66754237'),
('QCACHE_NOT_CACHED', '21045013'),
('QCACHE_QUERIES_IN_CACHE', '32524'),
('QCACHE_TOTAL_BLOCKS', '82630'),
('QUERIES', '1543665116'),
('QUESTIONS', '1534884083'),
('RPL_STATUS', 'AUTH_MASTER'),
('SELECT_FULL_JOIN', '2208147'),
('SELECT_FULL_RANGE_JOIN', '22435'),
('SELECT_RANGE', '8594159'),
('SELECT_RANGE_CHECK', '79737'),
('SELECT_SCAN', '29194653'),
('SLAVE_HEARTBEAT_PERIOD', '0.000'),
('SLAVE_OPEN_TEMP_TABLES', '0'),
('SLAVE_RECEIVED_HEARTBEATS', '0'),
('SLAVE_RETRIED_TRANSACTIONS', '0'),
('SLAVE_RUNNING', 'OFF'),
('SLOW_LAUNCH_THREADS', '1'),
('SLOW_QUERIES', '21155078'),
('SORT_MERGE_PASSES', '25571'),
('SORT_RANGE', '8378694'),
('SORT_ROWS', '450528392'),
('SORT_SCAN', '24877641'),
('SSL_ACCEPT_RENEGOTIATES', '0'),
('SSL_ACCEPTS', '0'),
('SSL_CALLBACK_CACHE_HITS', '0'),
('SSL_CIPHER', ''),
('SSL_CIPHER_LIST', ''),
('SSL_CLIENT_CONNECTS', '0'),
('SSL_CONNECT_RENEGOTIATES', '0'),
('SSL_CTX_VERIFY_DEPTH', '0'),
('SSL_CTX_VERIFY_MODE', '0'),
('SSL_DEFAULT_TIMEOUT', '0'),
('SSL_FINISHED_ACCEPTS', '0'),
('SSL_FINISHED_CONNECTS', '0'),
('SSL_SESSION_CACHE_HITS', '0'),
('SSL_SESSION_CACHE_MISSES', '0'),
('SSL_SESSION_CACHE_MODE', 'NONE'),
('SSL_SESSION_CACHE_OVERFLOWS', '0'),
('SSL_SESSION_CACHE_SIZE', '0'),
('SSL_SESSION_CACHE_TIMEOUTS', '0'),
('SSL_SESSIONS_REUSED', '0'),
('SSL_USED_SESSION_CACHE_ENTRIES', '0'),
('SSL_VERIFY_DEPTH', '0'),
('SSL_VERIFY_MODE', '0'),
('SSL_VERSION', ''),
('TABLE_LOCKS_IMMEDIATE', '531745932'),
('TABLE_LOCKS_WAITED', '166266'),
('TC_LOG_MAX_PAGES_USED', '0'),
('TC_LOG_PAGE_SIZE', '0'),
('TC_LOG_PAGE_WAITS', '0'),
('THREADPOOL_IDLE_THREADS', '0'),
('THREADPOOL_THREADS', '0'),
('THREADS_CACHED', '13'),
('THREADS_CONNECTED', '4'),
('THREADS_CREATED', '23818'),
('THREADS_RUNNING', '1'),
('UPTIME', '2239158'),
('UPTIME_SINCE_FLUSH_STATUS', '2239158'),
('BINLOG_COMMITS', '0'),
('BINLOG_GROUP_COMMITS', '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `GLOBAL_TEMPORARY_TABLES`
--

CREATE TEMPORARY TABLE `GLOBAL_TEMPORARY_TABLES` (
  `SESSION_ID` bigint(4) NOT NULL DEFAULT '0',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `ENGINE` varchar(64) NOT NULL DEFAULT '',
  `NAME` varchar(512) NOT NULL DEFAULT '',
  `TABLE_ROWS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `AVG_ROW_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `INDEX_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `GLOBAL_VARIABLES`
--

CREATE TEMPORARY TABLE `GLOBAL_VARIABLES` (
  `VARIABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `VARIABLE_VALUE` varchar(1024) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `GLOBAL_VARIABLES`
--

INSERT INTO `GLOBAL_VARIABLES` (`VARIABLE_NAME`, `VARIABLE_VALUE`) VALUES
('MAX_PREPARED_STMT_COUNT', '16382'),
('EXPIRE_LOGS_DAYS', '0'),
('HAVE_CRYPT', 'YES'),
('PERFORMANCE_SCHEMA_EVENTS_WAITS_HISTORY_LONG_SIZE', '10000'),
('INNODB_VERSION', '5.5.44-37.3'),
('MAX_SORT_LENGTH', '1024'),
('MAX_SLOWLOG_FILES', '0'),
('PERFORMANCE_SCHEMA_MAX_COND_INSTANCES', '1000'),
('PROFILING_HISTORY_SIZE', '15'),
('MAX_SLOWLOG_SIZE', '0'),
('LONG_QUERY_TIME', '1.000000'),
('THREAD_STACK', '262144'),
('DELAYED_INSERT_TIMEOUT', '300'),
('PERFORMANCE_SCHEMA_MAX_MUTEX_INSTANCES', '1000000'),
('DATETIME_FORMAT', '%Y-%m-%d %H:%i:%s'),
('PERFORMANCE_SCHEMA_MAX_RWLOCK_INSTANCES', '1000000'),
('FOREIGN_KEY_CHECKS', 'ON'),
('PERFORMANCE_SCHEMA_MAX_RWLOCK_CLASSES', '30'),
('BASEDIR', '/usr/local/pssql55/'),
('PERFORMANCE_SCHEMA_MAX_MUTEX_CLASSES', '200'),
('UPDATABLE_VIEWS_WITH_LIMIT', 'YES'),
('BACK_LOG', '128'),
('SLOW_LAUNCH_TIME', '2'),
('PERFORMANCE_SCHEMA_MAX_FILE_HANDLES', '32768'),
('MAX_USER_CONNECTIONS', '0'),
('INNODB_FILE_PER_TABLE', 'ON'),
('RELAY_LOG_INDEX', ''),
('LOWER_CASE_TABLE_NAMES', '0'),
('SQL_QUOTE_SHOW_CREATE', 'ON'),
('INNODB_FORCE_LOAD_CORRUPTED', 'OFF'),
('QUERY_PREALLOC_SIZE', '8192'),
('OLD_PASSWORDS', 'OFF'),
('WAIT_TIMEOUT', '120'),
('FT_STOPWORD_FILE', '(built-in)'),
('PERFORMANCE_SCHEMA_MAX_TABLE_HANDLES', '100000'),
('CHARACTER_SETS_DIR', '/usr/local/pssql55/share/charsets/'),
('QUERY_RESPONSE_TIME_STATS', 'OFF'),
('CONCURRENT_INSERT', 'NEVER'),
('LOG_SLOW_SP_STATEMENTS', 'ON'),
('CHARACTER_SET_RESULTS', 'latin2'),
('MYISAM_SORT_BUFFER_SIZE', '8388608'),
('CHARACTER_SET_CONNECTION', 'latin2'),
('INNODB_ROLLBACK_SEGMENTS', '128'),
('STORAGE_ENGINE', 'InnoDB'),
('LARGE_FILES_SUPPORT', 'ON'),
('RELAY_LOG_SPACE_LIMIT', '0'),
('HAVE_QUERY_CACHE', 'YES'),
('EVENT_SCHEDULER', 'OFF'),
('NET_BUFFER_LENGTH', '65536'),
('SKIP_EXTERNAL_LOCKING', 'ON'),
('SKIP_SHOW_DATABASE', 'OFF'),
('MAX_BINLOG_CACHE_SIZE', '18446744073709547520'),
('GROUP_CONCAT_MAX_LEN', '1024'),
('SSL_CAPATH', ''),
('RANGE_ALLOC_BLOCK_SIZE', '4096'),
('FT_MAX_WORD_LEN', '84'),
('TMPDIR', '/tmp'),
('LC_MESSAGES_DIR', '/usr/local/pssql55/share/'),
('INNODB_LOG_FILE_SIZE', '33554432'),
('REPORT_HOST', ''),
('TRANSACTION_PREALLOC_SIZE', '4096'),
('LOG', 'OFF'),
('MYISAM_RECOVER_OPTIONS', 'BACKUP,FORCE'),
('LOG_QUERIES_NOT_USING_INDEXES', 'ON'),
('THREAD_STATISTICS', 'OFF'),
('INNODB_BUFFER_POOL_SHM_KEY', '0'),
('LOW_PRIORITY_UPDATES', 'ON'),
('AUTOMATIC_SP_PRIVILEGES', 'ON'),
('REPORT_PASSWORD', ''),
('DELAYED_INSERT_LIMIT', '100'),
('MAX_INSERT_DELAYED_THREADS', '0'),
('COMPLETION_TYPE', 'NO_CHAIN'),
('SQL_BIG_SELECTS', 'ON'),
('INNODB_OLD_BLOCKS_PCT', '37'),
('TRANSACTION_ALLOC_BLOCK_SIZE', '8192'),
('PERFORMANCE_SCHEMA_MAX_THREAD_CLASSES', '50'),
('SLOW_QUERY_LOG_TIMESTAMP_ALWAYS', 'OFF'),
('AUTO_INCREMENT_OFFSET', '1'),
('INNODB_THREAD_CONCURRENCY_TIMER_BASED', 'OFF'),
('JOIN_BUFFER_SIZE', '1048576'),
('PID_FILE', '/sql/var/v323.pid'),
('CONNECT_TIMEOUT', '10'),
('INNODB_FLUSH_METHOD', ''),
('SQL_LOW_PRIORITY_UPDATES', 'ON'),
('PERFORMANCE_SCHEMA_MAX_FILE_INSTANCES', '10000'),
('INIT_FILE', ''),
('INNODB_IO_CAPACITY', '200'),
('LARGE_PAGES', 'OFF'),
('PROTOCOL_VERSION', '10'),
('LARGE_PAGE_SIZE', '0'),
('HAVE_SYMLINK', 'YES'),
('INIT_SLAVE', ''),
('QUERY_RESPONSE_TIME_RANGE_BASE', '10'),
('EXPAND_FAST_INDEX_CREATION', 'OFF'),
('INNODB_TABLE_LOCKS', 'ON'),
('MAX_BINLOG_SIZE', '1073741824'),
('INNODB_AUTOEXTEND_INCREMENT', '8'),
('SYNC_FRM', 'ON'),
('MYISAM_DATA_POINTER_SIZE', '6'),
('MAX_CONNECTIONS', '500'),
('INNODB_THREAD_SLEEP_DELAY', '10000'),
('LOG_WARNINGS_SUPPRESS', ''),
('INNODB_READ_AHEAD', 'linear'),
('READ_BUFFER_SIZE', '1048576'),
('SLAVE_TRANSACTION_RETRIES', '10'),
('PERFORMANCE_SCHEMA_MAX_THREAD_INSTANCES', '1000'),
('GENERAL_LOG', 'OFF'),
('LOWER_CASE_FILE_SYSTEM', 'OFF'),
('INNODB_REPLICATION_DELAY', '0'),
('MAX_RELAY_LOG_SIZE', '0'),
('QUERY_CACHE_MIN_RES_UNIT', '4096'),
('HAVE_SSL', 'DISABLED'),
('SORT_BUFFER_SIZE', '1048576'),
('INIT_CONNECT', ''),
('INNODB_ROLLBACK_ON_TIMEOUT', 'OFF'),
('KEY_CACHE_AGE_THRESHOLD', '300'),
('INNODB_USE_GLOBAL_FLUSH_LOG_AT_TRX_COMMIT', 'ON'),
('NET_RETRY_COUNT', '10'),
('INNODB_ADDITIONAL_MEM_POOL_SIZE', '8388608'),
('MAX_LONG_DATA_SIZE', '8388608'),
('READ_RND_BUFFER_SIZE', '524288'),
('SLAVE_MAX_ALLOWED_PACKET', '1073741824'),
('INNODB_FILE_FORMAT', 'Antelope'),
('FT_QUERY_EXPANSION_LIMIT', '20'),
('BIG_TABLES', 'OFF'),
('PERFORMANCE_SCHEMA_MAX_FILE_CLASSES', '50'),
('OPTIMIZER_SEARCH_DEPTH', '62'),
('SYNC_RELAY_LOG', '0'),
('DATE_FORMAT', '%Y-%m-%d'),
('HAVE_RESPONSE_TIME_DISTRIBUTION', 'YES'),
('READ_ONLY', 'OFF'),
('MAX_LENGTH_FOR_SORT_DATA', '1024'),
('OPTIMIZER_SWITCH', 'index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on'),
('INNODB_DATA_FILE_PATH', 'ib_data:16M:autoextend'),
('FLUSH', 'OFF'),
('THREAD_CONCURRENCY', '10'),
('THREAD_CACHE_SIZE', '16'),
('BINLOG_DIRECT_NON_TRANSACTIONAL_UPDATES', 'OFF'),
('MAX_HEAP_TABLE_SIZE', '67108864'),
('INNODB_STRICT_MODE', 'OFF'),
('INNODB_BUFFER_POOL_SHM_CHECKSUM', 'ON'),
('SQL_MAX_JOIN_SIZE', '18446744073709551615'),
('SQL_LOG_BIN', 'ON'),
('SKIP_NAME_RESOLVE', 'ON'),
('PERFORMANCE_SCHEMA_MAX_COND_CLASSES', '80'),
('DELAY_KEY_WRITE', 'ON'),
('LOG_SLOW_VERBOSITY', ''),
('BINLOG_CACHE_SIZE', '32768'),
('THREAD_POOL_IDLE_TIMEOUT', '60'),
('COLLATION_SERVER', 'latin2_general_ci'),
('MAX_BINLOG_FILES', '0'),
('FLUSH_TIME', '0'),
('HAVE_PARTITIONING', 'YES'),
('NET_WRITE_TIMEOUT', '60'),
('LOG_SLOW_RATE_TYPE', 'session'),
('QUERY_CACHE_LIMIT', '1048576'),
('INNODB_KILL_IDLE_TRANSACTION', '0'),
('LOG_BIN', 'OFF'),
('INNODB_AUTOINC_LOCK_MODE', '1'),
('PERFORMANCE_SCHEMA_EVENTS_WAITS_HISTORY_SIZE', '10'),
('INNODB_COMMIT_CONCURRENCY', '0'),
('MAX_SEEKS_FOR_KEY', '18446744073709551615'),
('INNODB_MIRRORED_LOG_GROUPS', '1'),
('METADATA_LOCKS_CACHE_SIZE', '1024'),
('INNODB_PURGE_BATCH_SIZE', '20'),
('BULK_INSERT_BUFFER_SIZE', '8388608'),
('VERSION', '5.5.44-37.3-log'),
('QUERY_CACHE_SIZE', '134217728'),
('INNODB_SUPPORT_XA', 'ON'),
('AUTOCOMMIT', 'ON'),
('INNODB_SYNC_SPIN_LOOPS', '30'),
('VERSION_COMMENT', 'home.pl'),
('INNODB_BLOCKING_BUFFER_POOL_RESTORE', 'OFF'),
('DELAYED_QUEUE_SIZE', '1000'),
('INNODB_SHOW_LOCKS_HELD', '10'),
('THREAD_POOL_STALL_LIMIT', '500'),
('INNODB_ADAPTIVE_HASH_INDEX', 'ON'),
('QUERY_ALLOC_BLOCK_SIZE', '8192'),
('INNODB_IBUF_ACCEL_RATE', '100'),
('MIN_EXAMINED_ROW_LIMIT', '0'),
('DIV_PRECISION_INCREMENT', '4'),
('HAVE_GEOMETRY', 'YES'),
('INNODB_IBUF_MAX_SIZE', '134201344'),
('QUERY_CACHE_WLOCK_INVALIDATE', 'OFF'),
('INNODB_DATA_HOME_DIR', ''),
('QUERY_CACHE_STRIP_COMMENTS', 'OFF'),
('INNODB_READ_IO_THREADS', '4'),
('THREAD_POOL_MAX_THREADS', '100000'),
('INNODB_MAX_BITMAP_FILE_SIZE', '104857600'),
('SLAVE_COMPRESSED_PROTOCOL', 'OFF'),
('INNODB_BUFFER_POOL_INSTANCES', '1'),
('MULTI_RANGE_COUNT', '256'),
('INNODB_FORCE_RECOVERY', '0'),
('RELAY_LOG_INFO_FILE', 'relay-log.info'),
('INNODB_LOG_FILES_IN_GROUP', '2'),
('SKIP_NETWORKING', 'OFF'),
('FT_BOOLEAN_SYNTAX', '+ -><()~*:""&|'),
('HAVE_DYNAMIC_LOADING', 'YES'),
('MAX_CONNECT_ERRORS', '4096'),
('SYNC_BINLOG', '0'),
('INNODB_PRINT_ALL_DEADLOCKS', 'OFF'),
('OPTIMIZER_PRUNE_LEVEL', '1'),
('INNODB_OPEN_FILES', '300'),
('TABLE_OPEN_CACHE', '4096'),
('INNODB_IMPORT_TABLE_FROM_XTRABACKUP', '0'),
('TIMED_MUTEXES', 'OFF'),
('INNODB_READ_AHEAD_THRESHOLD', '56'),
('INNODB_ADAPTIVE_FLUSHING_METHOD', 'estimate'),
('KEY_BUFFER_SIZE', '268435456'),
('CHARACTER_SET_DATABASE', 'latin2'),
('HAVE_NDBCLUSTER', 'NO'),
('THREAD_POOL_OVERSUBSCRIBE', '3'),
('VERSION_COMPILE_MACHINE', 'x86_64'),
('INNODB_STATS_METHOD', 'nulls_equal'),
('TABLE_DEFINITION_CACHE', '400'),
('INNODB_FAST_SHUTDOWN', '1'),
('OPTIMIZER_FIX', 'ON'),
('INNODB_RECOVERY_UPDATE_RELAY_LOG', 'OFF'),
('LOG_WARNINGS', '2'),
('INNODB_THREAD_CONCURRENCY', '0'),
('TMP_TABLE_SIZE', '67108864'),
('SLAVE_NET_TIMEOUT', '3600'),
('THREAD_HANDLING', 'one-thread-per-connection'),
('INNODB_STATS_SAMPLE_PAGES', '8'),
('QUERY_CACHE_TYPE', 'ON'),
('LOCAL_INFILE', 'ON'),
('SQL_BIG_TABLES', 'OFF'),
('HAVE_RTREE_KEYS', 'YES'),
('LOCK_WAIT_TIMEOUT', '31536000'),
('INNODB_BUFFER_POOL_RESTORE_AT_STARTUP', '0'),
('MAX_SP_RECURSION_DEPTH', '0'),
('OLD_ALTER_TABLE', 'OFF'),
('REPORT_PORT', '3306'),
('INNODB_PAGE_SIZE', '16384'),
('SSL_CIPHER', ''),
('EXTRA_MAX_CONNECTIONS', '1'),
('SLAVE_EXEC_MODE', 'STRICT'),
('RELAY_LOG_RECOVERY', 'OFF'),
('NEW', 'OFF'),
('MAX_DELAYED_THREADS', '0'),
('SQL_MODE', 'NO_UNSIGNED_SUBTRACTION'),
('SLOW_QUERY_LOG_USE_GLOBAL_CONTROL', ''),
('INNODB_LOG_GROUP_HOME_DIR', './'),
('INNODB_FLUSH_LOG_AT_TRX_COMMIT', '0'),
('BINLOG_FORMAT', 'STATEMENT'),
('THREAD_POOL_HIGH_PRIO_MODE', 'transactions'),
('HOSTNAME', 'v323.home.net.pl'),
('INNODB_RANDOM_READ_AHEAD', 'OFF'),
('KEEP_FILES_ON_CREATE', 'OFF'),
('CSV_MODE', ''),
('SECURE_FILE_PRIV', ''),
('PORT', '3306'),
('ENGINE_CONDITION_PUSHDOWN', 'ON'),
('CHARACTER_SET_CLIENT', 'latin2'),
('SSL_CA', ''),
('LOG_BIN_TRUST_FUNCTION_CREATORS', 'OFF'),
('AUTO_INCREMENT_INCREMENT', '1'),
('INNODB_MAX_CHANGED_PAGES', '1000000'),
('NET_READ_TIMEOUT', '30'),
('HAVE_OPENSSL', 'DISABLED'),
('MAX_BINLOG_STMT_CACHE_SIZE', '18446744073709547520'),
('THREAD_POOL_SIZE', '32'),
('INNODB_BUFFER_POOL_POPULATE', 'OFF'),
('KEY_CACHE_BLOCK_SIZE', '1024'),
('INNODB_SPIN_WAIT_DELAY', '6'),
('HAVE_CSV', 'YES'),
('INNODB_ADAPTIVE_HASH_INDEX_PARTITIONS', '1'),
('REPORT_USER', ''),
('DEFAULT_STORAGE_ENGINE', 'InnoDB'),
('PRELOAD_BUFFER_SIZE', '32768'),
('INNODB_LOCK_WAIT_TIMEOUT', '50'),
('FAST_INDEX_CREATION', 'ON'),
('INNODB_OLD_BLOCKS_TIME', '0'),
('TX_ISOLATION', 'REPEATABLE-READ'),
('RPL_RECOVERY_RANK', '0'),
('LOG_ERROR', '/sql/var/v323.err'),
('SLOW_QUERY_LOG', 'ON'),
('LOG_SLOW_FILTER', ''),
('USERSTAT', 'ON'),
('SLAVE_LOAD_TMPDIR', '/tmp'),
('LOCKED_IN_MEMORY', 'OFF'),
('IGNORE_BUILTIN_INNODB', 'OFF'),
('INNODB_LOCKING_FAKE_CHANGES', 'ON'),
('CHARACTER_SET_FILESYSTEM', 'binary'),
('DATADIR', '/sql/var/'),
('CHARACTER_SET_SYSTEM', 'utf8'),
('SSL_KEY', ''),
('COLLATION_DATABASE', 'latin2_general_ci'),
('LC_MESSAGES', 'en_US'),
('VERSION_COMPILE_OS', 'Linux'),
('SLAVE_SKIP_ERRORS', 'OFF'),
('HAVE_INNODB', 'YES'),
('SQL_WARNINGS', 'OFF'),
('RELAY_LOG_PURGE', 'ON'),
('MYISAM_MMAP_SIZE', '18446744073709551615'),
('INNODB_USE_SYS_STATS_TABLE', 'OFF'),
('EXTRA_PORT', '0'),
('INNODB_FAKE_CHANGES', 'OFF'),
('PLUGIN_DIR', '/usr/local/pssql55/lib/mysql/plugin/'),
('INNODB_LOG_BUFFER_SIZE', '8388608'),
('TIME_FORMAT', '%H:%i:%s'),
('INNODB_STATS_UPDATE_NEED_LOCK', '1'),
('OPEN_FILES_LIMIT', '1000000'),
('INNODB_MAX_PURGE_LAG', '0'),
('LOG_SLAVE_UPDATES', 'OFF'),
('MYISAM_MAX_SORT_FILE_SIZE', '9223372036853727232'),
('MAX_TMP_TABLES', '32'),
('SLAVE_TYPE_CONVERSIONS', ''),
('HAVE_PROFILING', 'YES'),
('SQL_NOTES', 'ON'),
('SQL_LOG_OFF', 'OFF'),
('MYISAM_STATS_METHOD', 'nulls_unequal'),
('OLD', 'OFF'),
('MAX_ALLOWED_PACKET', '8388608'),
('SLOW_QUERY_LOG_FILE', '/sql/var/v323-slow.log'),
('INNODB_IBUF_ACTIVE_CONTRACT', '1'),
('SQL_SLAVE_SKIP_COUNTER', '0'),
('LOG_SLOW_SLAVE_STATEMENTS', 'OFF'),
('SLOW_QUERY_LOG_TIMESTAMP_PRECISION', 'second'),
('INNODB_USE_ATOMIC_WRITES', 'OFF'),
('HAVE_FLASHCACHE', 'YES'),
('INNODB_DICT_SIZE_LIMIT', '0'),
('STORED_PROGRAM_CACHE', '256'),
('INNODB_DOUBLEWRITE', 'ON'),
('INNODB_RECOVERY_STATS', 'OFF'),
('BINLOG_STMT_CACHE_SIZE', '32768'),
('HAVE_COMPRESS', 'YES'),
('DEFAULT_WEEK_FORMAT', '0'),
('INNODB_DOUBLEWRITE_FILE', ''),
('LOG_OUTPUT', 'FILE'),
('INNODB_CHECKSUMS', 'ON'),
('PERFORMANCE_SCHEMA_MAX_TABLE_INSTANCES', '50000'),
('INNODB_LOCKS_UNSAFE_FOR_BINLOG', 'OFF'),
('INNODB_USE_NATIVE_AIO', 'ON'),
('MYISAM_USE_MMAP', 'OFF'),
('INTERACTIVE_TIMEOUT', '300'),
('INNODB_CONCURRENCY_TICKETS', '500'),
('TIME_ZONE', 'SYSTEM'),
('SQL_SAFE_UPDATES', 'OFF'),
('INNODB_TRACK_CHANGED_PAGES', 'OFF'),
('LOG_SLOW_RATE_LIMIT', '1'),
('MAX_JOIN_SIZE', '18446744073709551615'),
('SYNC_MASTER_INFO', '0'),
('FT_MIN_WORD_LEN', '3'),
('LOG_SLOW_QUERIES', 'ON'),
('THREAD_POOL_HIGH_PRIO_TICKETS', '4294967295'),
('INNODB_BUFFER_POOL_SIZE', '268435456'),
('SERVER_ID', '0'),
('INNODB_FILE_FORMAT_MAX', 'Antelope'),
('SQL_BUFFER_RESULT', 'OFF'),
('INNODB_FAST_CHECKSUM', 'OFF'),
('INNODB_LARGE_PREFIX', 'OFF'),
('SOCKET', '/usr/run/mysql/mysql'),
('SYNC_RELAY_LOG_INFO', '0'),
('SSL_CERT', ''),
('INNODB_LOG_BLOCK_SIZE', '512'),
('MAX_ERROR_COUNT', '64'),
('INNODB_STATS_AUTO_UPDATE', '1'),
('INNODB_STATS_ON_METADATA', 'ON'),
('INNODB_WRITE_IO_THREADS', '4'),
('INNODB_ADAPTIVE_FLUSHING', 'ON'),
('MYISAM_REPAIR_THREADS', '1'),
('SLOW_QUERY_LOG_ALWAYS_WRITE_TIME', '10.000000'),
('CHARACTER_SET_SERVER', 'latin2'),
('INNODB_CHANGE_BUFFERING', 'all'),
('INNODB_SHOW_VERBOSE_LOCKS', '0'),
('PERFORMANCE_SCHEMA', 'OFF'),
('SQL_AUTO_IS_NULL', 'OFF'),
('SECURE_AUTH', 'OFF'),
('INNODB_FILE_FORMAT_CHECK', 'ON'),
('MAX_WRITE_LOCK_COUNT', '18446744073709551615'),
('RELAY_LOG', ''),
('SQL_SELECT_LIMIT', '18446744073709551615'),
('INNODB_USE_SYS_MALLOC', 'ON'),
('INNODB_CORRUPT_TABLE_ACTION', 'assert'),
('INNODB_CHECKPOINT_AGE_TARGET', '0'),
('INNODB_FLUSH_NEIGHBOR_PAGES', 'area'),
('LICENSE', 'GPL'),
('INNODB_MAX_DIRTY_PAGES_PCT', '75'),
('ENFORCE_STORAGE_ENGINE', ''),
('LOG_SLOW_ADMIN_STATEMENTS', 'OFF'),
('COLLATION_CONNECTION', 'latin2_general_ci'),
('INNODB_MERGE_SORT_BLOCK_SIZE', '1048576'),
('UNIQUE_CHECKS', 'ON'),
('PROFILING', 'OFF'),
('SYSTEM_TIME_ZONE', 'CEST'),
('INNODB_PURGE_THREADS', '1'),
('LC_TIME_NAMES', 'en_US'),
('KEY_CACHE_DIVISION_LIMIT', '100'),
('INNODB_LAZY_DROP_TABLE', '0'),
('GENERAL_LOG_FILE', '/sql/var/v323.log');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `KEY_COLUMN_USAGE`
--

CREATE TEMPORARY TABLE `KEY_COLUMN_USAGE` (
  `CONSTRAINT_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `CONSTRAINT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `CONSTRAINT_NAME` varchar(64) NOT NULL DEFAULT '',
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',
  `ORDINAL_POSITION` bigint(10) NOT NULL DEFAULT '0',
  `POSITION_IN_UNIQUE_CONSTRAINT` bigint(10) DEFAULT NULL,
  `REFERENCED_TABLE_SCHEMA` varchar(64) DEFAULT NULL,
  `REFERENCED_TABLE_NAME` varchar(64) DEFAULT NULL,
  `REFERENCED_COLUMN_NAME` varchar(64) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `KEY_COLUMN_USAGE`
--

INSERT INTO `KEY_COLUMN_USAGE` (`CONSTRAINT_CATALOG`, `CONSTRAINT_SCHEMA`, `CONSTRAINT_NAME`, `TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `COLUMN_NAME`, `ORDINAL_POSITION`, `POSITION_IN_UNIQUE_CONSTRAINT`, `REFERENCED_TABLE_SCHEMA`, `REFERENCED_TABLE_NAME`, `REFERENCED_COLUMN_NAME`) VALUES
('def', '09424370_crm', 'PRIMARY', 'def', '09424370_crm', 'realization_timeline', 'id', 1, NULL, NULL, NULL, NULL),
('def', '09424370_crm', 'realization_timeline_ibfk_1', 'def', '09424370_crm', 'realization_timeline', 'task_id', 1, 1, '09424370_crm', 'tasks', 'id'),
('def', '09424370_crm', 'realization_timeline_ibfk_2', 'def', '09424370_crm', 'realization_timeline', 'user_id', 1, 1, '09424370_crm', 'users', 'id'),
('def', '09424370_crm', 'PRIMARY', 'def', '09424370_crm', 'role', 'id', 1, NULL, NULL, NULL, NULL),
('def', '09424370_crm', 'PRIMARY', 'def', '09424370_crm', 'status', 'id', 1, NULL, NULL, NULL, NULL),
('def', '09424370_crm', 'PRIMARY', 'def', '09424370_crm', 'tasks', 'id', 1, NULL, NULL, NULL, NULL),
('def', '09424370_crm', 'tasks_ibfk_1', 'def', '09424370_crm', 'tasks', 'user_id', 1, 1, '09424370_crm', 'users', 'id'),
('def', '09424370_crm', 'tasks_ibfk_2', 'def', '09424370_crm', 'tasks', 'status_id', 1, 1, '09424370_crm', 'status', 'id'),
('def', '09424370_crm', 'PRIMARY', 'def', '09424370_crm', 'users', 'id', 1, NULL, NULL, NULL, NULL),
('def', '09424370_crm', 'users_ibfk_1', 'def', '09424370_crm', 'users', 'role_id', 1, 1, '09424370_crm', 'role', 'id');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PARAMETERS`
--

CREATE TEMPORARY TABLE `PARAMETERS` (
  `SPECIFIC_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `SPECIFIC_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `SPECIFIC_NAME` varchar(64) NOT NULL DEFAULT '',
  `ORDINAL_POSITION` int(21) NOT NULL DEFAULT '0',
  `PARAMETER_MODE` varchar(5) DEFAULT NULL,
  `PARAMETER_NAME` varchar(64) DEFAULT NULL,
  `DATA_TYPE` varchar(64) NOT NULL DEFAULT '',
  `CHARACTER_MAXIMUM_LENGTH` int(21) DEFAULT NULL,
  `CHARACTER_OCTET_LENGTH` int(21) DEFAULT NULL,
  `NUMERIC_PRECISION` int(21) DEFAULT NULL,
  `NUMERIC_SCALE` int(21) DEFAULT NULL,
  `CHARACTER_SET_NAME` varchar(64) DEFAULT NULL,
  `COLLATION_NAME` varchar(64) DEFAULT NULL,
  `DTD_IDENTIFIER` longtext NOT NULL,
  `ROUTINE_TYPE` varchar(9) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PARTITIONS`
--

CREATE TEMPORARY TABLE `PARTITIONS` (
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `PARTITION_NAME` varchar(64) DEFAULT NULL,
  `SUBPARTITION_NAME` varchar(64) DEFAULT NULL,
  `PARTITION_ORDINAL_POSITION` bigint(21) unsigned DEFAULT NULL,
  `SUBPARTITION_ORDINAL_POSITION` bigint(21) unsigned DEFAULT NULL,
  `PARTITION_METHOD` varchar(18) DEFAULT NULL,
  `SUBPARTITION_METHOD` varchar(12) DEFAULT NULL,
  `PARTITION_EXPRESSION` longtext,
  `SUBPARTITION_EXPRESSION` longtext,
  `PARTITION_DESCRIPTION` longtext,
  `TABLE_ROWS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `AVG_ROW_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `MAX_DATA_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `INDEX_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_FREE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `CHECK_TIME` datetime DEFAULT NULL,
  `CHECKSUM` bigint(21) unsigned DEFAULT NULL,
  `PARTITION_COMMENT` varchar(80) NOT NULL DEFAULT '',
  `NODEGROUP` varchar(12) NOT NULL DEFAULT '',
  `TABLESPACE_NAME` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `PARTITIONS`
--

INSERT INTO `PARTITIONS` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `PARTITION_NAME`, `SUBPARTITION_NAME`, `PARTITION_ORDINAL_POSITION`, `SUBPARTITION_ORDINAL_POSITION`, `PARTITION_METHOD`, `SUBPARTITION_METHOD`, `PARTITION_EXPRESSION`, `SUBPARTITION_EXPRESSION`, `PARTITION_DESCRIPTION`, `TABLE_ROWS`, `AVG_ROW_LENGTH`, `DATA_LENGTH`, `MAX_DATA_LENGTH`, `INDEX_LENGTH`, `DATA_FREE`, `CREATE_TIME`, `UPDATE_TIME`, `CHECK_TIME`, `CHECKSUM`, `PARTITION_COMMENT`, `NODEGROUP`, `TABLESPACE_NAME`) VALUES
('def', 'information_schema', 'CHARACTER_SETS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 384, 0, 65739264, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'CLIENT_STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 362, 0, 66014682, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'COLLATIONS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 231, 0, 66819522, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'COLLATION_CHARACTER_SET_APPLICABILITY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 195, 0, 65431080, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'COLUMNS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'COLUMN_PRIVILEGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2565, 0, 67028580, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INDEX_STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1743, 0, 67068897, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'ENGINES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 490, 0, 66297000, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'EVENTS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'FILES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2677, 0, 67032080, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'GLOBAL_STATUS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3268, 0, 67026680, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2174, 0, 67046160, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'GLOBAL_VARIABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3268, 0, 67026680, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'KEY_COLUMN_USAGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4637, 0, 67064931, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'PARAMETERS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'PARTITIONS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'PLUGINS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'PROCESSLIST', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'PROFILING', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 308, 0, 66248336, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4814, 0, 67078276, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'ROUTINES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'QUERY_RESPONSE_TIME', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 91, 0, 63613550, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'SCHEMATA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3464, 0, 66952192, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2179, 0, 66954133, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'SESSION_STATUS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3268, 0, 67026680, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'SESSION_VARIABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3268, 0, 67026680, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 5753, 0, 67022450, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 9450, 0, 67057200, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TABLESPACES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6951, 0, 67098003, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TABLE_CONSTRAINTS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2504, 0, 66894360, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TABLE_PRIVILEGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2372, 0, 66994768, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TABLE_STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1181, 0, 66937899, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TEMPORARY_TABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2174, 0, 67046160, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'THREAD_STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 177, 0, 64555794, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'TRIGGERS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'USER_PRIVILEGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1986, 0, 66906354, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'USER_STATISTICS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 603, 0, 66556728, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'VIEWS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 281474976710655, 1024, 0, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 29, 0, 60817408, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_RSEG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 49, 0, 58720228, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_UNDO_LOGS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1620, 0, 66943260, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_CMPMEM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 29, 0, 60817408, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1796, 0, 66958472, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_LOCK_WAITS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 599, 0, 66996952, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_INDEX_STATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2529, 0, 66922398, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_CMP', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25, 0, 52428800, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_CMP_RESET', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25, 0, 52428800, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 25, 0, 52428800, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 234, 0, 65431080, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_TRX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 4534, 0, 67075996, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 105, 0, 62914530, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_LOCKS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 31244, 0, 67080868, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 65, 0, 60584355, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_TABLES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1183, 0, 67051257, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_FIELDS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 594, 0, 66437712, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 610, 0, 66454620, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6852, 0, 67067376, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_STATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 29, 0, 60817408, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1752, 0, 66803760, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_INDEXES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 614, 0, 66890388, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'XTRADB_ADMIN_COMMAND', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3075, 0, 66998100, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_TABLE_STATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1189, 0, 66939511, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1748, 0, 66955392, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 6669, 0, 67076802, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 257, 0, 65329400, 0, 0, '2016-05-06 19:40:39', NULL, NULL, NULL, '', '', NULL),
('def', '09424370_crm', 'realization_timeline', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 5461, 16384, NULL, 32768, 0, '2016-05-06 01:56:34', NULL, NULL, NULL, '', '', NULL),
('def', '09424370_crm', 'role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 8192, 16384, NULL, 0, 0, '2016-05-06 01:56:34', NULL, NULL, NULL, '', '', NULL),
('def', '09424370_crm', 'status', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 5461, 16384, NULL, 0, 0, '2016-05-06 01:56:34', NULL, NULL, NULL, '', '', NULL),
('def', '09424370_crm', 'tasks', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 4096, 16384, NULL, 32768, 0, '2016-05-06 01:56:34', NULL, NULL, NULL, '', '', NULL),
('def', '09424370_crm', 'users', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 16384, 16384, NULL, 16384, 0, '2016-05-06 01:56:34', NULL, NULL, NULL, '', '', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PLUGINS`
--

CREATE TEMPORARY TABLE `PLUGINS` (
  `PLUGIN_NAME` varchar(64) NOT NULL DEFAULT '',
  `PLUGIN_VERSION` varchar(20) NOT NULL DEFAULT '',
  `PLUGIN_STATUS` varchar(10) NOT NULL DEFAULT '',
  `PLUGIN_TYPE` varchar(80) NOT NULL DEFAULT '',
  `PLUGIN_TYPE_VERSION` varchar(20) NOT NULL DEFAULT '',
  `PLUGIN_LIBRARY` varchar(64) DEFAULT NULL,
  `PLUGIN_LIBRARY_VERSION` varchar(20) DEFAULT NULL,
  `PLUGIN_AUTHOR` varchar(64) DEFAULT NULL,
  `PLUGIN_DESCRIPTION` longtext,
  `PLUGIN_LICENSE` varchar(80) DEFAULT NULL,
  `LOAD_OPTION` varchar(64) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `PLUGINS`
--

INSERT INTO `PLUGINS` (`PLUGIN_NAME`, `PLUGIN_VERSION`, `PLUGIN_STATUS`, `PLUGIN_TYPE`, `PLUGIN_TYPE_VERSION`, `PLUGIN_LIBRARY`, `PLUGIN_LIBRARY_VERSION`, `PLUGIN_AUTHOR`, `PLUGIN_DESCRIPTION`, `PLUGIN_LICENSE`, `LOAD_OPTION`) VALUES
('binlog', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'MySQL AB', 'This is a pseudo storage engine to represent the binlog in a transaction', 'GPL', 'FORCE'),
('mysql_native_password', '1.0', 'ACTIVE', 'AUTHENTICATION', '1.0', NULL, NULL, 'R.J.Silk, Sergei Golubchik', 'Native MySQL authentication', 'GPL', 'FORCE'),
('mysql_old_password', '1.0', 'ACTIVE', 'AUTHENTICATION', '1.0', NULL, NULL, 'R.J.Silk, Sergei Golubchik', 'Old MySQL-4.0 authentication', 'GPL', 'FORCE'),
('MRG_MYISAM', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'MySQL AB', 'Collection of identical MyISAM tables', 'GPL', 'FORCE'),
('CSV', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'Brian Aker, MySQL AB', 'CSV storage engine', 'GPL', 'FORCE'),
('MyISAM', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'MySQL AB', 'MyISAM storage engine', 'GPL', 'FORCE'),
('MEMORY', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'MySQL AB', 'Hash based, stored in memory, useful for temporary tables', 'GPL', 'FORCE'),
('InnoDB', '5.5', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'Oracle Corporation', 'Percona-XtraDB, Supports transactions, row-level locking, and foreign keys', 'GPL', 'ON'),
('INNODB_RSEG', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB rollback segment information', 'GPL', 'ON'),
('INNODB_UNDO_LOGS', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB rollback undo segment information', 'GPL', 'ON'),
('INNODB_TRX', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB transactions', 'GPL', 'ON'),
('INNODB_LOCKS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB conflicting locks', 'GPL', 'ON'),
('INNODB_LOCK_WAITS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB which lock is blocking which', 'GPL', 'ON'),
('INNODB_CMP', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'Statistics for the InnoDB compression', 'GPL', 'ON'),
('INNODB_CMP_RESET', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'Statistics for the InnoDB compression; reset cumulated counts', 'GPL', 'ON'),
('INNODB_CMPMEM', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'Statistics for the InnoDB compressed buffer pool', 'GPL', 'ON'),
('INNODB_CMPMEM_RESET', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'Statistics for the InnoDB compressed buffer pool; reset cumulated counts', 'GPL', 'ON'),
('INNODB_SYS_TABLES', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_TABLES', 'GPL', 'ON'),
('INNODB_SYS_TABLESTATS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_TABLESTATS', 'GPL', 'ON'),
('INNODB_SYS_INDEXES', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_INDEXES', 'GPL', 'ON'),
('INNODB_SYS_COLUMNS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_COLUMNS', 'GPL', 'ON'),
('INNODB_SYS_FIELDS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_FIELDS', 'GPL', 'ON'),
('INNODB_SYS_FOREIGN', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_FOREIGN', 'GPL', 'ON'),
('INNODB_SYS_FOREIGN_COLS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB SYS_FOREIGN_COLS', 'GPL', 'ON'),
('INNODB_SYS_STATS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'XtraDB SYS_STATS table', 'GPL', 'ON'),
('INNODB_TABLE_STATS', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB table statistics in memory', 'GPL', 'ON'),
('INNODB_INDEX_STATS', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB index statistics in memory', 'GPL', 'ON'),
('INNODB_BUFFER_POOL_PAGES', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB buffer pool pages', 'GPL', 'ON'),
('INNODB_BUFFER_POOL_PAGES_INDEX', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB buffer pool index pages', 'GPL', 'ON'),
('INNODB_BUFFER_POOL_PAGES_BLOB', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB buffer pool blob pages', 'GPL', 'ON'),
('XTRADB_ADMIN_COMMAND', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'XtraDB specific command acceptor', 'GPL', 'ON'),
('INNODB_CHANGED_PAGES', '1.0', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Percona', 'InnoDB CHANGED_PAGES table', 'GPL', 'ON'),
('INNODB_BUFFER_PAGE', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB Buffer Page Information', 'GPL', 'ON'),
('INNODB_BUFFER_PAGE_LRU', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB Buffer Page in LRU', 'GPL', 'ON'),
('INNODB_BUFFER_POOL_STATS', '5.5', 'ACTIVE', 'INFORMATION SCHEMA', '50544.0', NULL, NULL, 'Oracle Corporation', 'InnoDB Buffer Pool Statistics Information ', 'GPL', 'ON'),
('PERFORMANCE_SCHEMA', '0.1', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'Marc Alff, Oracle', 'Performance Schema', 'GPL', 'FORCE'),
('partition', '1.0', 'ACTIVE', 'STORAGE ENGINE', '50544.0', NULL, NULL, 'Mikael Ronstrom, MySQL AB', 'Partition Storage Engine Helper', 'GPL', 'ON');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PROCESSLIST`
--

CREATE TEMPORARY TABLE `PROCESSLIST` (
  `ID` bigint(4) NOT NULL DEFAULT '0',
  `USER` varchar(16) NOT NULL DEFAULT '',
  `HOST` varchar(64) NOT NULL DEFAULT '',
  `DB` varchar(64) DEFAULT NULL,
  `COMMAND` varchar(16) NOT NULL DEFAULT '',
  `TIME` int(7) NOT NULL DEFAULT '0',
  `STATE` varchar(64) DEFAULT NULL,
  `INFO` longtext,
  `TIME_MS` bigint(21) NOT NULL DEFAULT '0',
  `ROWS_SENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_EXAMINED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `PROCESSLIST`
--

INSERT INTO `PROCESSLIST` (`ID`, `USER`, `HOST`, `DB`, `COMMAND`, `TIME`, `STATE`, `INFO`, `TIME_MS`, `ROWS_SENT`, `ROWS_EXAMINED`, `ROWS_READ`) VALUES
(16678131, '09424370_crm', 'localhost', '09424370_crm', 'Query', 0, 'executing', 'SELECT * FROM `information_schema`.`PROCESSLIST`', 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `PROFILING`
--

CREATE TEMPORARY TABLE `PROFILING` (
  `QUERY_ID` int(20) NOT NULL DEFAULT '0',
  `SEQ` int(20) NOT NULL DEFAULT '0',
  `STATE` varchar(30) NOT NULL DEFAULT '',
  `DURATION` decimal(9,6) NOT NULL DEFAULT '0.000000',
  `CPU_USER` decimal(9,6) DEFAULT NULL,
  `CPU_SYSTEM` decimal(9,6) DEFAULT NULL,
  `CONTEXT_VOLUNTARY` int(20) DEFAULT NULL,
  `CONTEXT_INVOLUNTARY` int(20) DEFAULT NULL,
  `BLOCK_OPS_IN` int(20) DEFAULT NULL,
  `BLOCK_OPS_OUT` int(20) DEFAULT NULL,
  `MESSAGES_SENT` int(20) DEFAULT NULL,
  `MESSAGES_RECEIVED` int(20) DEFAULT NULL,
  `PAGE_FAULTS_MAJOR` int(20) DEFAULT NULL,
  `PAGE_FAULTS_MINOR` int(20) DEFAULT NULL,
  `SWAPS` int(20) DEFAULT NULL,
  `SOURCE_FUNCTION` varchar(30) DEFAULT NULL,
  `SOURCE_FILE` varchar(20) DEFAULT NULL,
  `SOURCE_LINE` int(20) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `REFERENTIAL_CONSTRAINTS`
--

CREATE TEMPORARY TABLE `REFERENTIAL_CONSTRAINTS` (
  `CONSTRAINT_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `CONSTRAINT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `CONSTRAINT_NAME` varchar(64) NOT NULL DEFAULT '',
  `UNIQUE_CONSTRAINT_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `UNIQUE_CONSTRAINT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `UNIQUE_CONSTRAINT_NAME` varchar(64) DEFAULT NULL,
  `MATCH_OPTION` varchar(64) NOT NULL DEFAULT '',
  `UPDATE_RULE` varchar(64) NOT NULL DEFAULT '',
  `DELETE_RULE` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `REFERENCED_TABLE_NAME` varchar(64) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `REFERENTIAL_CONSTRAINTS`
--

INSERT INTO `REFERENTIAL_CONSTRAINTS` (`CONSTRAINT_CATALOG`, `CONSTRAINT_SCHEMA`, `CONSTRAINT_NAME`, `UNIQUE_CONSTRAINT_CATALOG`, `UNIQUE_CONSTRAINT_SCHEMA`, `UNIQUE_CONSTRAINT_NAME`, `MATCH_OPTION`, `UPDATE_RULE`, `DELETE_RULE`, `TABLE_NAME`, `REFERENCED_TABLE_NAME`) VALUES
('def', '09424370_crm', 'realization_timeline_ibfk_1', 'def', '09424370_crm', 'PRIMARY', 'NONE', 'CASCADE', 'CASCADE', 'realization_timeline', 'tasks'),
('def', '09424370_crm', 'realization_timeline_ibfk_2', 'def', '09424370_crm', 'PRIMARY', 'NONE', 'RESTRICT', 'RESTRICT', 'realization_timeline', 'users'),
('def', '09424370_crm', 'tasks_ibfk_1', 'def', '09424370_crm', 'PRIMARY', 'NONE', 'RESTRICT', 'RESTRICT', 'tasks', 'users'),
('def', '09424370_crm', 'tasks_ibfk_2', 'def', '09424370_crm', 'PRIMARY', 'NONE', 'RESTRICT', 'RESTRICT', 'tasks', 'status'),
('def', '09424370_crm', 'users_ibfk_1', 'def', '09424370_crm', 'PRIMARY', 'NONE', 'RESTRICT', 'RESTRICT', 'users', 'role');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ROUTINES`
--

CREATE TEMPORARY TABLE `ROUTINES` (
  `SPECIFIC_NAME` varchar(64) NOT NULL DEFAULT '',
  `ROUTINE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `ROUTINE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `ROUTINE_NAME` varchar(64) NOT NULL DEFAULT '',
  `ROUTINE_TYPE` varchar(9) NOT NULL DEFAULT '',
  `DATA_TYPE` varchar(64) NOT NULL DEFAULT '',
  `CHARACTER_MAXIMUM_LENGTH` int(21) DEFAULT NULL,
  `CHARACTER_OCTET_LENGTH` int(21) DEFAULT NULL,
  `NUMERIC_PRECISION` int(21) DEFAULT NULL,
  `NUMERIC_SCALE` int(21) DEFAULT NULL,
  `CHARACTER_SET_NAME` varchar(64) DEFAULT NULL,
  `COLLATION_NAME` varchar(64) DEFAULT NULL,
  `DTD_IDENTIFIER` longtext,
  `ROUTINE_BODY` varchar(8) NOT NULL DEFAULT '',
  `ROUTINE_DEFINITION` longtext,
  `EXTERNAL_NAME` varchar(64) DEFAULT NULL,
  `EXTERNAL_LANGUAGE` varchar(64) DEFAULT NULL,
  `PARAMETER_STYLE` varchar(8) NOT NULL DEFAULT '',
  `IS_DETERMINISTIC` varchar(3) NOT NULL DEFAULT '',
  `SQL_DATA_ACCESS` varchar(64) NOT NULL DEFAULT '',
  `SQL_PATH` varchar(64) DEFAULT NULL,
  `SECURITY_TYPE` varchar(7) NOT NULL DEFAULT '',
  `CREATED` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `LAST_ALTERED` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SQL_MODE` varchar(8192) NOT NULL DEFAULT '',
  `ROUTINE_COMMENT` longtext NOT NULL,
  `DEFINER` varchar(77) NOT NULL DEFAULT '',
  `CHARACTER_SET_CLIENT` varchar(32) NOT NULL DEFAULT '',
  `COLLATION_CONNECTION` varchar(32) NOT NULL DEFAULT '',
  `DATABASE_COLLATION` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `QUERY_RESPONSE_TIME`
--

CREATE TEMPORARY TABLE `QUERY_RESPONSE_TIME` (
  `time` varchar(14) NOT NULL DEFAULT '',
  `count` int(11) unsigned NOT NULL DEFAULT '0',
  `total` varchar(14) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `QUERY_RESPONSE_TIME`
--

INSERT INTO `QUERY_RESPONSE_TIME` (`time`, `count`, `total`) VALUES
('      0.000001', 0, '      0.000000'),
('      0.000010', 0, '      0.000000'),
('      0.000100', 0, '      0.000000'),
('      0.001000', 0, '      0.000000'),
('      0.010000', 0, '      0.000000'),
('      0.100000', 0, '      0.000000'),
('      1.000000', 0, '      0.000000'),
('     10.000000', 0, '      0.000000'),
('    100.000000', 0, '      0.000000'),
('   1000.000000', 0, '      0.000000'),
('  10000.000000', 0, '      0.000000'),
(' 100000.000000', 0, '      0.000000'),
('1000000.000000', 0, '      0.000000'),
('TOO LONG', 0, 'TOO LONG');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `SCHEMATA`
--

CREATE TEMPORARY TABLE `SCHEMATA` (
  `CATALOG_NAME` varchar(512) NOT NULL DEFAULT '',
  `SCHEMA_NAME` varchar(64) NOT NULL DEFAULT '',
  `DEFAULT_CHARACTER_SET_NAME` varchar(32) NOT NULL DEFAULT '',
  `DEFAULT_COLLATION_NAME` varchar(32) NOT NULL DEFAULT '',
  `SQL_PATH` varchar(512) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `SCHEMATA`
--

INSERT INTO `SCHEMATA` (`CATALOG_NAME`, `SCHEMA_NAME`, `DEFAULT_CHARACTER_SET_NAME`, `DEFAULT_COLLATION_NAME`, `SQL_PATH`) VALUES
('def', 'information_schema', 'utf8', 'utf8_general_ci', NULL),
('def', '09424370_crm', 'utf8', 'utf8_general_ci', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `SCHEMA_PRIVILEGES`
--

CREATE TEMPORARY TABLE `SCHEMA_PRIVILEGES` (
  `GRANTEE` varchar(81) NOT NULL DEFAULT '',
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `PRIVILEGE_TYPE` varchar(64) NOT NULL DEFAULT '',
  `IS_GRANTABLE` varchar(3) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `SCHEMA_PRIVILEGES`
--

INSERT INTO `SCHEMA_PRIVILEGES` (`GRANTEE`, `TABLE_CATALOG`, `TABLE_SCHEMA`, `PRIVILEGE_TYPE`, `IS_GRANTABLE`) VALUES
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'SELECT', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'INSERT', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'UPDATE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'DELETE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'CREATE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'DROP', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'REFERENCES', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'INDEX', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'ALTER', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'CREATE TEMPORARY TABLES', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'LOCK TABLES', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'EXECUTE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'CREATE VIEW', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'SHOW VIEW', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'CREATE ROUTINE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'ALTER ROUTINE', 'NO'),
('''09424370_crm''@''%''', 'def', '09424370\\_crm', 'TRIGGER', 'NO');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `SESSION_STATUS`
--

CREATE TEMPORARY TABLE `SESSION_STATUS` (
  `VARIABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `VARIABLE_VALUE` varchar(1024) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `SESSION_STATUS`
--

INSERT INTO `SESSION_STATUS` (`VARIABLE_NAME`, `VARIABLE_VALUE`) VALUES
('ABORTED_CLIENTS', '4029'),
('ABORTED_CONNECTS', '96362'),
('BINLOG_CACHE_DISK_USE', '0'),
('BINLOG_CACHE_USE', '0'),
('BINLOG_STMT_CACHE_DISK_USE', '0'),
('BINLOG_STMT_CACHE_USE', '0'),
('BYTES_RECEIVED', '10991'),
('BYTES_SENT', '308710'),
('COM_ADMIN_COMMANDS', '0'),
('COM_ASSIGN_TO_KEYCACHE', '0'),
('COM_ALTER_DB', '0'),
('COM_ALTER_DB_UPGRADE', '0'),
('COM_ALTER_EVENT', '0'),
('COM_ALTER_FUNCTION', '0'),
('COM_ALTER_PROCEDURE', '0'),
('COM_ALTER_SERVER', '0'),
('COM_ALTER_TABLE', '0'),
('COM_ALTER_TABLESPACE', '0'),
('COM_ANALYZE', '0'),
('COM_BEGIN', '0'),
('COM_BINLOG', '0'),
('COM_CALL_PROCEDURE', '0'),
('COM_CHANGE_DB', '2'),
('COM_CHANGE_MASTER', '0'),
('COM_CHECK', '0'),
('COM_CHECKSUM', '0'),
('COM_COMMIT', '0'),
('COM_CREATE_DB', '0'),
('COM_CREATE_EVENT', '0'),
('COM_CREATE_FUNCTION', '0'),
('COM_CREATE_INDEX', '0'),
('COM_CREATE_PROCEDURE', '0'),
('COM_CREATE_SERVER', '0'),
('COM_CREATE_TABLE', '0'),
('COM_CREATE_TRIGGER', '0'),
('COM_CREATE_UDF', '0'),
('COM_CREATE_USER', '0'),
('COM_CREATE_VIEW', '0'),
('COM_DEALLOC_SQL', '0'),
('COM_DELETE', '0'),
('COM_DELETE_MULTI', '0'),
('COM_DO', '0'),
('COM_DROP_DB', '0'),
('COM_DROP_EVENT', '0'),
('COM_DROP_FUNCTION', '0'),
('COM_DROP_INDEX', '0'),
('COM_DROP_PROCEDURE', '0'),
('COM_DROP_SERVER', '0'),
('COM_DROP_TABLE', '0'),
('COM_DROP_TRIGGER', '0'),
('COM_DROP_USER', '0'),
('COM_DROP_VIEW', '0'),
('COM_EMPTY_QUERY', '0'),
('COM_EXECUTE_SQL', '0'),
('COM_FLUSH', '0'),
('COM_GRANT', '0'),
('COM_HA_CLOSE', '0'),
('COM_HA_OPEN', '0'),
('COM_HA_READ', '0'),
('COM_HELP', '0'),
('COM_INSERT', '0'),
('COM_INSERT_SELECT', '0'),
('COM_INSTALL_PLUGIN', '0'),
('COM_KILL', '0'),
('COM_LOAD', '0'),
('COM_LOCK_TABLES', '0'),
('COM_OPTIMIZE', '0'),
('COM_PRELOAD_KEYS', '0'),
('COM_PREPARE_SQL', '0'),
('COM_PURGE', '0'),
('COM_PURGE_BEFORE_DATE', '0'),
('COM_RELEASE_SAVEPOINT', '0'),
('COM_RENAME_TABLE', '0'),
('COM_RENAME_USER', '0'),
('COM_REPAIR', '0'),
('COM_REPLACE', '0'),
('COM_REPLACE_SELECT', '0'),
('COM_RESET', '0'),
('COM_RESIGNAL', '0'),
('COM_REVOKE', '0'),
('COM_REVOKE_ALL', '0'),
('COM_ROLLBACK', '0'),
('COM_ROLLBACK_TO_SAVEPOINT', '0'),
('COM_SAVEPOINT', '0'),
('COM_SELECT', '32'),
('COM_SET_OPTION', '34'),
('COM_SIGNAL', '0'),
('COM_SHOW_AUTHORS', '0'),
('COM_SHOW_BINLOG_EVENTS', '0'),
('COM_SHOW_BINLOGS', '0'),
('COM_SHOW_CHARSETS', '0'),
('COM_SHOW_CLIENT_STATISTICS', '0'),
('COM_SHOW_COLLATIONS', '0'),
('COM_SHOW_CONTRIBUTORS', '0'),
('COM_SHOW_CREATE_DB', '0'),
('COM_SHOW_CREATE_EVENT', '0'),
('COM_SHOW_CREATE_FUNC', '0'),
('COM_SHOW_CREATE_PROC', '0'),
('COM_SHOW_CREATE_TABLE', '30'),
('COM_SHOW_CREATE_TRIGGER', '0'),
('COM_SHOW_DATABASES', '1'),
('COM_SHOW_ENGINE_LOGS', '0'),
('COM_SHOW_ENGINE_MUTEX', '0'),
('COM_SHOW_ENGINE_STATUS', '0'),
('COM_SHOW_EVENTS', '0'),
('COM_SHOW_ERRORS', '0'),
('COM_SHOW_FIELDS', '0'),
('COM_SHOW_FUNCTION_STATUS', '2'),
('COM_SHOW_GRANTS', '0'),
('COM_SHOW_INDEX_STATISTICS', '0'),
('COM_SHOW_KEYS', '0'),
('COM_SHOW_MASTER_STATUS', '0'),
('COM_SHOW_OPEN_TABLES', '0'),
('COM_SHOW_PLUGINS', '0'),
('COM_SHOW_PRIVILEGES', '0'),
('COM_SHOW_PROCEDURE_STATUS', '2'),
('COM_SHOW_PROCESSLIST', '0'),
('COM_SHOW_PROFILE', '0'),
('COM_SHOW_PROFILES', '0'),
('COM_SHOW_RELAYLOG_EVENTS', '0'),
('COM_SHOW_SLAVE_HOSTS', '0'),
('COM_SHOW_SLAVE_STATUS', '0'),
('COM_SHOW_SLAVE_STATUS_NOLOCK', '0'),
('COM_SHOW_STATUS', '0'),
('COM_SHOW_STORAGE_ENGINES', '0'),
('COM_SHOW_TABLE_STATISTICS', '0'),
('COM_SHOW_TABLE_STATUS', '60'),
('COM_SHOW_TABLES', '2'),
('COM_SHOW_TEMPORARY_TABLES', '0'),
('COM_SHOW_THREAD_STATISTICS', '0'),
('COM_SHOW_TRIGGERS', '29'),
('COM_SHOW_USER_STATISTICS', '0'),
('COM_SHOW_VARIABLES', '2'),
('COM_SHOW_WARNINGS', '0'),
('COM_SLAVE_START', '0'),
('COM_SLAVE_STOP', '0'),
('COM_STMT_CLOSE', '0'),
('COM_STMT_EXECUTE', '0'),
('COM_STMT_FETCH', '0'),
('COM_STMT_PREPARE', '0'),
('COM_STMT_REPREPARE', '0'),
('COM_STMT_RESET', '0'),
('COM_STMT_SEND_LONG_DATA', '0'),
('COM_TRUNCATE', '0'),
('COM_UNINSTALL_PLUGIN', '0'),
('COM_UNLOCK_TABLES', '0'),
('COM_UPDATE', '0'),
('COM_UPDATE_MULTI', '0'),
('COM_XA_COMMIT', '0'),
('COM_XA_END', '0'),
('COM_XA_PREPARE', '0'),
('COM_XA_RECOVER', '0'),
('COM_XA_ROLLBACK', '0'),
('COM_XA_START', '0'),
('COMPRESSION', 'OFF'),
('CONNECTIONS', '16678133'),
('CREATED_TMP_DISK_TABLES', '105'),
('CREATED_TMP_FILES', '51163'),
('CREATED_TMP_TABLES', '483'),
('DELAYED_ERRORS', '0'),
('DELAYED_INSERT_THREADS', '0'),
('DELAYED_WRITES', '0'),
('FLASHCACHE_ENABLED', 'OFF'),
('FLUSH_COMMANDS', '1'),
('HANDLER_COMMIT', '5'),
('HANDLER_DELETE', '0'),
('HANDLER_DISCOVER', '0'),
('HANDLER_PREPARE', '0'),
('HANDLER_READ_FIRST', '11'),
('HANDLER_READ_KEY', '5'),
('HANDLER_READ_LAST', '0'),
('HANDLER_READ_NEXT', '186'),
('HANDLER_READ_PREV', '0'),
('HANDLER_READ_RND', '0'),
('HANDLER_READ_RND_NEXT', '2364'),
('HANDLER_ROLLBACK', '0'),
('HANDLER_SAVEPOINT', '0'),
('HANDLER_SAVEPOINT_ROLLBACK', '0'),
('HANDLER_UPDATE', '0'),
('HANDLER_WRITE', '2401'),
('INNODB_ADAPTIVE_HASH_CELLS', '553229'),
('INNODB_ADAPTIVE_HASH_HEAP_BUFFERS', '513'),
('INNODB_ADAPTIVE_HASH_HASH_SEARCHES', '14100218340'),
('INNODB_ADAPTIVE_HASH_NON_HASH_SEARCHES', '5386382485'),
('INNODB_BACKGROUND_LOG_SYNC', '2268497'),
('INNODB_BUFFER_POOL_PAGES_DATA', '15869'),
('INNODB_BUFFER_POOL_BYTES_DATA', '259997696'),
('INNODB_BUFFER_POOL_PAGES_DIRTY', '705'),
('INNODB_BUFFER_POOL_BYTES_DIRTY', '11550720'),
('INNODB_BUFFER_POOL_PAGES_FLUSHED', '33192479'),
('INNODB_BUFFER_POOL_PAGES_LRU_FLUSHED', '551190'),
('INNODB_BUFFER_POOL_PAGES_FREE', '0'),
('INNODB_BUFFER_POOL_PAGES_MADE_NOT_YOUNG', '0'),
('INNODB_BUFFER_POOL_PAGES_MADE_YOUNG', '174062226'),
('INNODB_BUFFER_POOL_PAGES_MISC', '514'),
('INNODB_BUFFER_POOL_PAGES_OLD', '5837'),
('INNODB_BUFFER_POOL_PAGES_TOTAL', '16383'),
('INNODB_BUFFER_POOL_READ_AHEAD_RND', '0'),
('INNODB_BUFFER_POOL_READ_AHEAD', '10790780'),
('INNODB_BUFFER_POOL_READ_AHEAD_EVICTED', '811128'),
('INNODB_BUFFER_POOL_READ_REQUESTS', '61647299706'),
('INNODB_BUFFER_POOL_READS', '125636982'),
('INNODB_BUFFER_POOL_WAIT_FREE', '0'),
('INNODB_BUFFER_POOL_WRITE_REQUESTS', '311574385'),
('INNODB_CHECKPOINT_AGE', '674815'),
('INNODB_CHECKPOINT_MAX_AGE', '53647074'),
('INNODB_CHECKPOINT_TARGET_AGE', '51970603'),
('INNODB_DATA_FSYNCS', '6589738'),
('INNODB_DATA_PENDING_FSYNCS', '0'),
('INNODB_DATA_PENDING_READS', '0'),
('INNODB_DATA_PENDING_WRITES', '0'),
('INNODB_DATA_READ', '2242185203712'),
('INNODB_DATA_READS', '136879139'),
('INNODB_DATA_WRITES', '36446909'),
('INNODB_DATA_WRITTEN', '1118883004928'),
('INNODB_DBLWR_PAGES_WRITTEN', '33192479'),
('INNODB_DBLWR_WRITES', '484759'),
('INNODB_DEADLOCKS', '3'),
('INNODB_DICT_TABLES', '27511'),
('INNODB_HAVE_ATOMIC_BUILTINS', 'ON'),
('INNODB_HISTORY_LIST_LENGTH', '2140'),
('INNODB_IBUF_DISCARDED_DELETE_MARKS', '0'),
('INNODB_IBUF_DISCARDED_DELETES', '0'),
('INNODB_IBUF_DISCARDED_INSERTS', '0'),
('INNODB_IBUF_FREE_LIST', '1422'),
('INNODB_IBUF_MERGED_DELETE_MARKS', '1182464'),
('INNODB_IBUF_MERGED_DELETES', '90183'),
('INNODB_IBUF_MERGED_INSERTS', '852965'),
('INNODB_IBUF_MERGES', '701933'),
('INNODB_IBUF_SEGMENT_SIZE', '1424'),
('INNODB_IBUF_SIZE', '1'),
('INNODB_LOG_WAITS', '7'),
('INNODB_LOG_WRITE_REQUESTS', '67455082'),
('INNODB_LOG_WRITES', '2192208'),
('INNODB_LSN_CURRENT', '4905596676491'),
('INNODB_LSN_FLUSHED', '4905596675659'),
('INNODB_LSN_LAST_CHECKPOINT', '4905596001676'),
('INNODB_MASTER_THREAD_1_SECOND_LOOPS', '2204837'),
('INNODB_MASTER_THREAD_10_SECOND_LOOPS', '219605'),
('INNODB_MASTER_THREAD_BACKGROUND_LOOPS', '14904'),
('INNODB_MASTER_THREAD_MAIN_FLUSH_LOOPS', '14896'),
('INNODB_MASTER_THREAD_SLEEPS', '2202441'),
('INNODB_MAX_TRX_ID', '4885180484'),
('INNODB_MEM_ADAPTIVE_HASH', '12851424'),
('INNODB_MEM_DICTIONARY', '229661438'),
('INNODB_MEM_TOTAL', '275513344'),
('INNODB_MUTEX_OS_WAITS', '161551'),
('INNODB_MUTEX_SPIN_ROUNDS', '24193009'),
('INNODB_MUTEX_SPIN_WAITS', '11848237'),
('INNODB_OLDEST_VIEW_LOW_LIMIT_TRX_ID', '4885180459'),
('INNODB_OS_LOG_FSYNCS', '2416227'),
('INNODB_OS_LOG_PENDING_FSYNCS', '0'),
('INNODB_OS_LOG_PENDING_WRITES', '0'),
('INNODB_OS_LOG_WRITTEN', '31116575232'),
('INNODB_PAGE_SIZE', '16384'),
('INNODB_PAGES_CREATED', '1133091'),
('INNODB_PAGES_READ', '136852005'),
('INNODB_PAGES_WRITTEN', '33192479'),
('INNODB_PURGE_TRX_ID', '4885180453'),
('INNODB_PURGE_UNDO_NO', '0'),
('INNODB_ROW_LOCK_CURRENT_WAITS', '0'),
('INNODB_CURRENT_ROW_LOCKS', '0'),
('INNODB_ROW_LOCK_TIME', '48851'),
('INNODB_ROW_LOCK_TIME_AVG', '7'),
('INNODB_ROW_LOCK_TIME_MAX', '2571'),
('INNODB_ROW_LOCK_WAITS', '6297'),
('INNODB_ROWS_DELETED', '11562552'),
('INNODB_ROWS_INSERTED', '27159409'),
('INNODB_ROWS_READ', '34399341435'),
('INNODB_ROWS_UPDATED', '16343154'),
('INNODB_READ_VIEWS_MEMORY', '472'),
('INNODB_DESCRIPTORS_MEMORY', '8000'),
('INNODB_S_LOCK_OS_WAITS', '787558'),
('INNODB_S_LOCK_SPIN_ROUNDS', '31922489'),
('INNODB_S_LOCK_SPIN_WAITS', '2629412'),
('INNODB_TRUNCATED_STATUS_WRITES', '0'),
('INNODB_X_LOCK_OS_WAITS', '120415'),
('INNODB_X_LOCK_SPIN_ROUNDS', '7676765'),
('INNODB_X_LOCK_SPIN_WAITS', '204213'),
('KEY_BLOCKS_NOT_FLUSHED', '0'),
('KEY_BLOCKS_UNUSED', '183356'),
('KEY_BLOCKS_USED', '198552'),
('KEY_READ_REQUESTS', '7844831040'),
('KEY_READS', '3578885'),
('KEY_WRITE_REQUESTS', '610164676'),
('KEY_WRITES', '224266598'),
('LAST_QUERY_COST', '10.499000'),
('MAX_USED_CONNECTIONS', '51'),
('NOT_FLUSHED_DELAYED_ROWS', '0'),
('OPEN_FILES', '1965'),
('OPEN_STREAMS', '0'),
('OPEN_TABLE_DEFINITIONS', '3714'),
('OPEN_TABLES', '4096'),
('OPENED_FILES', '65282928'),
('OPENED_TABLE_DEFINITIONS', '0'),
('OPENED_TABLES', '0'),
('PERFORMANCE_SCHEMA_COND_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_COND_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_HANDLES_LOST', '0'),
('PERFORMANCE_SCHEMA_FILE_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_LOCKER_LOST', '0'),
('PERFORMANCE_SCHEMA_MUTEX_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_MUTEX_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_RWLOCK_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_RWLOCK_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_TABLE_HANDLES_LOST', '0'),
('PERFORMANCE_SCHEMA_TABLE_INSTANCES_LOST', '0'),
('PERFORMANCE_SCHEMA_THREAD_CLASSES_LOST', '0'),
('PERFORMANCE_SCHEMA_THREAD_INSTANCES_LOST', '0'),
('PREPARED_STMT_COUNT', '0'),
('QCACHE_FREE_BLOCKS', '10940'),
('QCACHE_FREE_MEMORY', '33854840'),
('QCACHE_HITS', '1058430398'),
('QCACHE_INSERTS', '127013480'),
('QCACHE_LOWMEM_PRUNES', '66754237'),
('QCACHE_NOT_CACHED', '21045029'),
('QCACHE_QUERIES_IN_CACHE', '32529'),
('QCACHE_TOTAL_BLOCKS', '82635'),
('QUERIES', '1543665211'),
('QUESTIONS', '196'),
('RPL_STATUS', 'AUTH_MASTER'),
('SELECT_FULL_JOIN', '0'),
('SELECT_FULL_RANGE_JOIN', '0'),
('SELECT_RANGE', '0'),
('SELECT_RANGE_CHECK', '0'),
('SELECT_SCAN', '129'),
('SLAVE_HEARTBEAT_PERIOD', '0.000'),
('SLAVE_OPEN_TEMP_TABLES', '0'),
('SLAVE_RECEIVED_HEARTBEATS', '0'),
('SLAVE_RETRIED_TRANSACTIONS', '0'),
('SLAVE_RUNNING', 'OFF'),
('SLOW_LAUNCH_THREADS', '1'),
('SLOW_QUERIES', '30'),
('SORT_MERGE_PASSES', '0'),
('SORT_RANGE', '0'),
('SORT_ROWS', '0'),
('SORT_SCAN', '0'),
('SSL_ACCEPT_RENEGOTIATES', '0'),
('SSL_ACCEPTS', '0'),
('SSL_CALLBACK_CACHE_HITS', '0'),
('SSL_CIPHER', ''),
('SSL_CIPHER_LIST', ''),
('SSL_CLIENT_CONNECTS', '0'),
('SSL_CONNECT_RENEGOTIATES', '0'),
('SSL_CTX_VERIFY_DEPTH', '0'),
('SSL_CTX_VERIFY_MODE', '0'),
('SSL_DEFAULT_TIMEOUT', '0'),
('SSL_FINISHED_ACCEPTS', '0'),
('SSL_FINISHED_CONNECTS', '0'),
('SSL_SESSION_CACHE_HITS', '0'),
('SSL_SESSION_CACHE_MISSES', '0'),
('SSL_SESSION_CACHE_MODE', 'NONE'),
('SSL_SESSION_CACHE_OVERFLOWS', '0'),
('SSL_SESSION_CACHE_SIZE', '0'),
('SSL_SESSION_CACHE_TIMEOUTS', '0'),
('SSL_SESSIONS_REUSED', '0'),
('SSL_USED_SESSION_CACHE_ENTRIES', '0'),
('SSL_VERIFY_DEPTH', '0'),
('SSL_VERIFY_MODE', '0'),
('SSL_VERSION', ''),
('TABLE_LOCKS_IMMEDIATE', '531745962'),
('TABLE_LOCKS_WAITED', '166266'),
('TC_LOG_MAX_PAGES_USED', '0'),
('TC_LOG_PAGE_SIZE', '0'),
('TC_LOG_PAGE_WAITS', '0'),
('THREADPOOL_IDLE_THREADS', '0'),
('THREADPOOL_THREADS', '0'),
('THREADS_CACHED', '13'),
('THREADS_CONNECTED', '4'),
('THREADS_CREATED', '23818'),
('THREADS_RUNNING', '2'),
('UPTIME', '2239158'),
('UPTIME_SINCE_FLUSH_STATUS', '2239158'),
('BINLOG_COMMITS', '0'),
('BINLOG_GROUP_COMMITS', '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `SESSION_VARIABLES`
--

CREATE TEMPORARY TABLE `SESSION_VARIABLES` (
  `VARIABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `VARIABLE_VALUE` varchar(1024) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `SESSION_VARIABLES`
--

INSERT INTO `SESSION_VARIABLES` (`VARIABLE_NAME`, `VARIABLE_VALUE`) VALUES
('MAX_PREPARED_STMT_COUNT', '16382'),
('EXPIRE_LOGS_DAYS', '0'),
('HAVE_CRYPT', 'YES'),
('PERFORMANCE_SCHEMA_EVENTS_WAITS_HISTORY_LONG_SIZE', '10000'),
('INNODB_VERSION', '5.5.44-37.3'),
('MAX_SORT_LENGTH', '1024'),
('MAX_SLOWLOG_FILES', '0'),
('PERFORMANCE_SCHEMA_MAX_COND_INSTANCES', '1000'),
('PROFILING_HISTORY_SIZE', '15'),
('MAX_SLOWLOG_SIZE', '0'),
('LONG_QUERY_TIME', '1.000000'),
('THREAD_STACK', '262144'),
('DELAYED_INSERT_TIMEOUT', '300'),
('PERFORMANCE_SCHEMA_MAX_MUTEX_INSTANCES', '1000000'),
('DATETIME_FORMAT', '%Y-%m-%d %H:%i:%s'),
('PERFORMANCE_SCHEMA_MAX_RWLOCK_INSTANCES', '1000000'),
('FOREIGN_KEY_CHECKS', 'ON'),
('PERFORMANCE_SCHEMA_MAX_RWLOCK_CLASSES', '30'),
('BASEDIR', '/usr/local/pssql55/'),
('PERFORMANCE_SCHEMA_MAX_MUTEX_CLASSES', '200'),
('UPDATABLE_VIEWS_WITH_LIMIT', 'YES'),
('BACK_LOG', '128'),
('SLOW_LAUNCH_TIME', '2'),
('PERFORMANCE_SCHEMA_MAX_FILE_HANDLES', '32768'),
('MAX_USER_CONNECTIONS', '0'),
('INNODB_FILE_PER_TABLE', 'ON'),
('RELAY_LOG_INDEX', ''),
('LOWER_CASE_TABLE_NAMES', '0'),
('SQL_QUOTE_SHOW_CREATE', 'ON'),
('INNODB_FORCE_LOAD_CORRUPTED', 'OFF'),
('QUERY_PREALLOC_SIZE', '8192'),
('OLD_PASSWORDS', 'OFF'),
('WAIT_TIMEOUT', '120'),
('FT_STOPWORD_FILE', '(built-in)'),
('PERFORMANCE_SCHEMA_MAX_TABLE_HANDLES', '100000'),
('CHARACTER_SETS_DIR', '/usr/local/pssql55/share/charsets/'),
('QUERY_RESPONSE_TIME_STATS', 'OFF'),
('CONCURRENT_INSERT', 'NEVER'),
('LOG_SLOW_SP_STATEMENTS', 'ON'),
('CHARACTER_SET_RESULTS', 'utf8'),
('MYISAM_SORT_BUFFER_SIZE', '8388608'),
('CHARACTER_SET_CONNECTION', 'utf8'),
('INNODB_ROLLBACK_SEGMENTS', '128'),
('STORAGE_ENGINE', 'InnoDB'),
('LARGE_FILES_SUPPORT', 'ON'),
('RELAY_LOG_SPACE_LIMIT', '0'),
('HAVE_QUERY_CACHE', 'YES'),
('EVENT_SCHEDULER', 'OFF'),
('NET_BUFFER_LENGTH', '65536'),
('SKIP_EXTERNAL_LOCKING', 'ON'),
('SKIP_SHOW_DATABASE', 'OFF'),
('MAX_BINLOG_CACHE_SIZE', '18446744073709547520'),
('GROUP_CONCAT_MAX_LEN', '1024'),
('SSL_CAPATH', ''),
('RANGE_ALLOC_BLOCK_SIZE', '4096'),
('FT_MAX_WORD_LEN', '84'),
('TMPDIR', '/tmp'),
('LC_MESSAGES_DIR', '/usr/local/pssql55/share/'),
('INNODB_LOG_FILE_SIZE', '33554432'),
('REPORT_HOST', ''),
('TRANSACTION_PREALLOC_SIZE', '4096'),
('LOG', 'OFF'),
('MYISAM_RECOVER_OPTIONS', 'BACKUP,FORCE'),
('LOG_QUERIES_NOT_USING_INDEXES', 'ON'),
('THREAD_STATISTICS', 'OFF'),
('INNODB_BUFFER_POOL_SHM_KEY', '0'),
('LOW_PRIORITY_UPDATES', 'ON'),
('AUTOMATIC_SP_PRIVILEGES', 'ON'),
('REPORT_PASSWORD', ''),
('DELAYED_INSERT_LIMIT', '100'),
('MAX_INSERT_DELAYED_THREADS', '0'),
('COMPLETION_TYPE', 'NO_CHAIN'),
('SQL_BIG_SELECTS', 'ON'),
('INNODB_OLD_BLOCKS_PCT', '37'),
('TRANSACTION_ALLOC_BLOCK_SIZE', '8192'),
('PERFORMANCE_SCHEMA_MAX_THREAD_CLASSES', '50'),
('SLOW_QUERY_LOG_TIMESTAMP_ALWAYS', 'OFF'),
('AUTO_INCREMENT_OFFSET', '1'),
('INNODB_THREAD_CONCURRENCY_TIMER_BASED', 'OFF'),
('JOIN_BUFFER_SIZE', '1048576'),
('PID_FILE', '/sql/var/v323.pid'),
('CONNECT_TIMEOUT', '10'),
('INNODB_FLUSH_METHOD', ''),
('SQL_LOW_PRIORITY_UPDATES', 'ON'),
('PERFORMANCE_SCHEMA_MAX_FILE_INSTANCES', '10000'),
('INIT_FILE', ''),
('INNODB_IO_CAPACITY', '200'),
('LARGE_PAGES', 'OFF'),
('PROTOCOL_VERSION', '10'),
('LARGE_PAGE_SIZE', '0'),
('HAVE_SYMLINK', 'YES'),
('INIT_SLAVE', ''),
('QUERY_RESPONSE_TIME_RANGE_BASE', '10'),
('EXPAND_FAST_INDEX_CREATION', 'OFF'),
('INNODB_TABLE_LOCKS', 'ON'),
('MAX_BINLOG_SIZE', '1073741824'),
('INNODB_AUTOEXTEND_INCREMENT', '8'),
('SYNC_FRM', 'ON'),
('MYISAM_DATA_POINTER_SIZE', '6'),
('MAX_CONNECTIONS', '500'),
('INNODB_THREAD_SLEEP_DELAY', '10000'),
('LOG_WARNINGS_SUPPRESS', ''),
('INNODB_READ_AHEAD', 'linear'),
('READ_BUFFER_SIZE', '1048576'),
('SLAVE_TRANSACTION_RETRIES', '10'),
('PSEUDO_THREAD_ID', '16678131'),
('LAST_INSERT_ID', '0'),
('PERFORMANCE_SCHEMA_MAX_THREAD_INSTANCES', '1000'),
('GENERAL_LOG', 'OFF'),
('LOWER_CASE_FILE_SYSTEM', 'OFF'),
('INNODB_REPLICATION_DELAY', '0'),
('MAX_RELAY_LOG_SIZE', '0'),
('QUERY_CACHE_MIN_RES_UNIT', '4096'),
('HAVE_SSL', 'DISABLED'),
('SORT_BUFFER_SIZE', '1048576'),
('INIT_CONNECT', ''),
('INNODB_ROLLBACK_ON_TIMEOUT', 'OFF'),
('KEY_CACHE_AGE_THRESHOLD', '300'),
('INNODB_USE_GLOBAL_FLUSH_LOG_AT_TRX_COMMIT', 'ON'),
('NET_RETRY_COUNT', '10'),
('INNODB_ADDITIONAL_MEM_POOL_SIZE', '8388608'),
('MAX_LONG_DATA_SIZE', '8388608'),
('READ_RND_BUFFER_SIZE', '524288'),
('SLAVE_MAX_ALLOWED_PACKET', '1073741824'),
('INNODB_FILE_FORMAT', 'Antelope'),
('FT_QUERY_EXPANSION_LIMIT', '20'),
('BIG_TABLES', 'OFF'),
('PERFORMANCE_SCHEMA_MAX_FILE_CLASSES', '50'),
('OPTIMIZER_SEARCH_DEPTH', '62'),
('SYNC_RELAY_LOG', '0'),
('DATE_FORMAT', '%Y-%m-%d'),
('HAVE_RESPONSE_TIME_DISTRIBUTION', 'YES'),
('READ_ONLY', 'OFF'),
('MAX_LENGTH_FOR_SORT_DATA', '1024'),
('RAND_SEED1', '0'),
('OPTIMIZER_SWITCH', 'index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on'),
('INNODB_DATA_FILE_PATH', 'ib_data:16M:autoextend'),
('FLUSH', 'OFF'),
('THREAD_CONCURRENCY', '10'),
('THREAD_CACHE_SIZE', '16'),
('BINLOG_DIRECT_NON_TRANSACTIONAL_UPDATES', 'OFF'),
('MAX_HEAP_TABLE_SIZE', '67108864'),
('INNODB_STRICT_MODE', 'OFF'),
('PROXY_USER', ''),
('INNODB_BUFFER_POOL_SHM_CHECKSUM', 'ON'),
('SQL_MAX_JOIN_SIZE', '18446744073709551615'),
('SQL_LOG_BIN', 'ON'),
('SKIP_NAME_RESOLVE', 'ON'),
('PERFORMANCE_SCHEMA_MAX_COND_CLASSES', '80'),
('DELAY_KEY_WRITE', 'ON'),
('LOG_SLOW_VERBOSITY', ''),
('BINLOG_CACHE_SIZE', '32768'),
('THREAD_POOL_IDLE_TIMEOUT', '60'),
('COLLATION_SERVER', 'latin2_general_ci'),
('MAX_BINLOG_FILES', '0'),
('FLUSH_TIME', '0'),
('HAVE_PARTITIONING', 'YES'),
('NET_WRITE_TIMEOUT', '60'),
('LOG_SLOW_RATE_TYPE', 'session'),
('QUERY_CACHE_LIMIT', '1048576'),
('INNODB_KILL_IDLE_TRANSACTION', '0'),
('LOG_BIN', 'OFF'),
('INNODB_AUTOINC_LOCK_MODE', '1'),
('PERFORMANCE_SCHEMA_EVENTS_WAITS_HISTORY_SIZE', '10'),
('INNODB_COMMIT_CONCURRENCY', '0'),
('MAX_SEEKS_FOR_KEY', '18446744073709551615'),
('INNODB_MIRRORED_LOG_GROUPS', '1'),
('METADATA_LOCKS_CACHE_SIZE', '1024'),
('INNODB_PURGE_BATCH_SIZE', '20'),
('BULK_INSERT_BUFFER_SIZE', '8388608'),
('VERSION', '5.5.44-37.3-log'),
('QUERY_CACHE_SIZE', '134217728'),
('INNODB_SUPPORT_XA', 'ON'),
('AUTOCOMMIT', 'ON'),
('INNODB_SYNC_SPIN_LOOPS', '30'),
('VERSION_COMMENT', 'home.pl'),
('INNODB_BLOCKING_BUFFER_POOL_RESTORE', 'OFF'),
('DELAYED_QUEUE_SIZE', '1000'),
('INNODB_SHOW_LOCKS_HELD', '10'),
('THREAD_POOL_STALL_LIMIT', '500'),
('INNODB_ADAPTIVE_HASH_INDEX', 'ON'),
('QUERY_ALLOC_BLOCK_SIZE', '8192'),
('INNODB_IBUF_ACCEL_RATE', '100'),
('MIN_EXAMINED_ROW_LIMIT', '0'),
('DIV_PRECISION_INCREMENT', '4'),
('HAVE_GEOMETRY', 'YES'),
('INNODB_IBUF_MAX_SIZE', '134201344'),
('QUERY_CACHE_WLOCK_INVALIDATE', 'OFF'),
('INNODB_DATA_HOME_DIR', ''),
('QUERY_CACHE_STRIP_COMMENTS', 'OFF'),
('INNODB_READ_IO_THREADS', '4'),
('THREAD_POOL_MAX_THREADS', '100000'),
('INNODB_MAX_BITMAP_FILE_SIZE', '104857600'),
('SLAVE_COMPRESSED_PROTOCOL', 'OFF'),
('INNODB_BUFFER_POOL_INSTANCES', '1'),
('MULTI_RANGE_COUNT', '256'),
('INNODB_FORCE_RECOVERY', '0'),
('RELAY_LOG_INFO_FILE', 'relay-log.info'),
('INNODB_LOG_FILES_IN_GROUP', '2'),
('SKIP_NETWORKING', 'OFF'),
('ERROR_COUNT', '0'),
('FT_BOOLEAN_SYNTAX', '+ -><()~*:""&|'),
('HAVE_DYNAMIC_LOADING', 'YES'),
('MAX_CONNECT_ERRORS', '4096'),
('SYNC_BINLOG', '0'),
('RAND_SEED2', '0'),
('INNODB_PRINT_ALL_DEADLOCKS', 'OFF'),
('OPTIMIZER_PRUNE_LEVEL', '1'),
('INNODB_OPEN_FILES', '300'),
('TABLE_OPEN_CACHE', '4096'),
('INNODB_IMPORT_TABLE_FROM_XTRABACKUP', '0'),
('TIMED_MUTEXES', 'OFF'),
('INNODB_READ_AHEAD_THRESHOLD', '56'),
('EXTERNAL_USER', ''),
('INNODB_ADAPTIVE_FLUSHING_METHOD', 'estimate'),
('TIMESTAMP', '1462563639'),
('KEY_BUFFER_SIZE', '268435456'),
('CHARACTER_SET_DATABASE', 'utf8'),
('HAVE_NDBCLUSTER', 'NO'),
('THREAD_POOL_OVERSUBSCRIBE', '3'),
('PSEUDO_SLAVE_MODE', 'OFF'),
('VERSION_COMPILE_MACHINE', 'x86_64'),
('INNODB_STATS_METHOD', 'nulls_equal'),
('TABLE_DEFINITION_CACHE', '400'),
('INNODB_FAST_SHUTDOWN', '1'),
('OPTIMIZER_FIX', 'ON'),
('INNODB_RECOVERY_UPDATE_RELAY_LOG', 'OFF'),
('LOG_WARNINGS', '2'),
('INNODB_THREAD_CONCURRENCY', '0'),
('TMP_TABLE_SIZE', '67108864'),
('SLAVE_NET_TIMEOUT', '3600'),
('THREAD_HANDLING', 'one-thread-per-connection'),
('INNODB_STATS_SAMPLE_PAGES', '8'),
('QUERY_CACHE_TYPE', 'ON'),
('LOCAL_INFILE', 'ON'),
('SQL_BIG_TABLES', 'OFF'),
('HAVE_RTREE_KEYS', 'YES'),
('LOCK_WAIT_TIMEOUT', '31536000'),
('INNODB_BUFFER_POOL_RESTORE_AT_STARTUP', '0'),
('MAX_SP_RECURSION_DEPTH', '0'),
('OLD_ALTER_TABLE', 'OFF'),
('REPORT_PORT', '3306'),
('INNODB_PAGE_SIZE', '16384'),
('SSL_CIPHER', ''),
('EXTRA_MAX_CONNECTIONS', '1'),
('SLAVE_EXEC_MODE', 'STRICT'),
('RELAY_LOG_RECOVERY', 'OFF'),
('NEW', 'OFF'),
('MAX_DELAYED_THREADS', '0'),
('SQL_MODE', ''),
('SLOW_QUERY_LOG_USE_GLOBAL_CONTROL', ''),
('INNODB_LOG_GROUP_HOME_DIR', './'),
('INNODB_FLUSH_LOG_AT_TRX_COMMIT', '0'),
('BINLOG_FORMAT', 'STATEMENT'),
('THREAD_POOL_HIGH_PRIO_MODE', 'transactions'),
('HOSTNAME', 'v323.home.net.pl'),
('INNODB_RANDOM_READ_AHEAD', 'OFF'),
('KEEP_FILES_ON_CREATE', 'OFF'),
('CSV_MODE', ''),
('SECURE_FILE_PRIV', ''),
('PORT', '3306'),
('ENGINE_CONDITION_PUSHDOWN', 'ON'),
('CHARACTER_SET_CLIENT', 'utf8'),
('SSL_CA', ''),
('LOG_BIN_TRUST_FUNCTION_CREATORS', 'OFF'),
('AUTO_INCREMENT_INCREMENT', '1'),
('INNODB_MAX_CHANGED_PAGES', '1000000'),
('NET_READ_TIMEOUT', '30'),
('HAVE_OPENSSL', 'DISABLED'),
('WARNING_COUNT', '0'),
('MAX_BINLOG_STMT_CACHE_SIZE', '18446744073709547520'),
('THREAD_POOL_SIZE', '32'),
('INNODB_BUFFER_POOL_POPULATE', 'OFF'),
('KEY_CACHE_BLOCK_SIZE', '1024'),
('INNODB_SPIN_WAIT_DELAY', '6'),
('HAVE_CSV', 'YES'),
('INNODB_ADAPTIVE_HASH_INDEX_PARTITIONS', '1'),
('REPORT_USER', ''),
('DEFAULT_STORAGE_ENGINE', 'InnoDB'),
('PRELOAD_BUFFER_SIZE', '32768'),
('INNODB_LOCK_WAIT_TIMEOUT', '50'),
('FAST_INDEX_CREATION', 'ON'),
('INNODB_OLD_BLOCKS_TIME', '0'),
('TX_ISOLATION', 'REPEATABLE-READ'),
('RPL_RECOVERY_RANK', '0'),
('LOG_ERROR', '/sql/var/v323.err'),
('SLOW_QUERY_LOG', 'ON'),
('LOG_SLOW_FILTER', ''),
('USERSTAT', 'ON'),
('SLAVE_LOAD_TMPDIR', '/tmp'),
('LOCKED_IN_MEMORY', 'OFF'),
('IGNORE_BUILTIN_INNODB', 'OFF'),
('INNODB_LOCKING_FAKE_CHANGES', 'ON'),
('CHARACTER_SET_FILESYSTEM', 'binary'),
('DATADIR', '/sql/var/'),
('CHARACTER_SET_SYSTEM', 'utf8'),
('SSL_KEY', ''),
('COLLATION_DATABASE', 'utf8_general_ci'),
('LC_MESSAGES', 'en_US'),
('VERSION_COMPILE_OS', 'Linux'),
('SLAVE_SKIP_ERRORS', 'OFF'),
('HAVE_INNODB', 'YES'),
('INSERT_ID', '0'),
('SQL_WARNINGS', 'OFF'),
('RELAY_LOG_PURGE', 'ON'),
('MYISAM_MMAP_SIZE', '18446744073709551615'),
('INNODB_USE_SYS_STATS_TABLE', 'OFF'),
('EXTRA_PORT', '0'),
('INNODB_FAKE_CHANGES', 'OFF'),
('PLUGIN_DIR', '/usr/local/pssql55/lib/mysql/plugin/'),
('INNODB_LOG_BUFFER_SIZE', '8388608'),
('TIME_FORMAT', '%H:%i:%s'),
('INNODB_STATS_UPDATE_NEED_LOCK', '1'),
('OPEN_FILES_LIMIT', '1000000'),
('INNODB_MAX_PURGE_LAG', '0'),
('LOG_SLAVE_UPDATES', 'OFF'),
('MYISAM_MAX_SORT_FILE_SIZE', '9223372036853727232'),
('MAX_TMP_TABLES', '32'),
('SLAVE_TYPE_CONVERSIONS', ''),
('HAVE_PROFILING', 'YES'),
('SQL_NOTES', 'ON'),
('SQL_LOG_OFF', 'OFF'),
('MYISAM_STATS_METHOD', 'nulls_unequal'),
('OLD', 'OFF'),
('MAX_ALLOWED_PACKET', '8388608'),
('SLOW_QUERY_LOG_FILE', '/sql/var/v323-slow.log'),
('INNODB_IBUF_ACTIVE_CONTRACT', '1'),
('SQL_SLAVE_SKIP_COUNTER', '0'),
('LOG_SLOW_SLAVE_STATEMENTS', 'OFF'),
('SLOW_QUERY_LOG_TIMESTAMP_PRECISION', 'second'),
('INNODB_USE_ATOMIC_WRITES', 'OFF'),
('HAVE_FLASHCACHE', 'YES'),
('INNODB_DICT_SIZE_LIMIT', '0'),
('STORED_PROGRAM_CACHE', '256'),
('INNODB_DOUBLEWRITE', 'ON'),
('INNODB_RECOVERY_STATS', 'OFF'),
('BINLOG_STMT_CACHE_SIZE', '32768'),
('HAVE_COMPRESS', 'YES'),
('DEFAULT_WEEK_FORMAT', '0'),
('INNODB_DOUBLEWRITE_FILE', ''),
('LOG_OUTPUT', 'FILE'),
('INNODB_CHECKSUMS', 'ON'),
('PERFORMANCE_SCHEMA_MAX_TABLE_INSTANCES', '50000'),
('INNODB_LOCKS_UNSAFE_FOR_BINLOG', 'OFF'),
('INNODB_USE_NATIVE_AIO', 'ON'),
('MYISAM_USE_MMAP', 'OFF'),
('INTERACTIVE_TIMEOUT', '300'),
('INNODB_CONCURRENCY_TICKETS', '500'),
('TIME_ZONE', '+00:00'),
('SQL_SAFE_UPDATES', 'OFF'),
('INNODB_TRACK_CHANGED_PAGES', 'OFF'),
('LOG_SLOW_RATE_LIMIT', '1'),
('MAX_JOIN_SIZE', '18446744073709551615'),
('SYNC_MASTER_INFO', '0'),
('FT_MIN_WORD_LEN', '3'),
('LOG_SLOW_QUERIES', 'ON'),
('THREAD_POOL_HIGH_PRIO_TICKETS', '4294967295'),
('INNODB_BUFFER_POOL_SIZE', '268435456'),
('SERVER_ID', '0'),
('INNODB_FILE_FORMAT_MAX', 'Antelope'),
('SQL_BUFFER_RESULT', 'OFF'),
('INNODB_FAST_CHECKSUM', 'OFF'),
('INNODB_LARGE_PREFIX', 'OFF'),
('SOCKET', '/usr/run/mysql/mysql'),
('SYNC_RELAY_LOG_INFO', '0'),
('IDENTITY', '0'),
('SSL_CERT', ''),
('INNODB_LOG_BLOCK_SIZE', '512'),
('MAX_ERROR_COUNT', '64'),
('INNODB_STATS_AUTO_UPDATE', '1'),
('INNODB_STATS_ON_METADATA', 'ON'),
('INNODB_WRITE_IO_THREADS', '4'),
('INNODB_ADAPTIVE_FLUSHING', 'ON'),
('MYISAM_REPAIR_THREADS', '1'),
('SLOW_QUERY_LOG_ALWAYS_WRITE_TIME', '10.000000'),
('CHARACTER_SET_SERVER', 'latin2'),
('INNODB_CHANGE_BUFFERING', 'all'),
('INNODB_SHOW_VERBOSE_LOCKS', '0'),
('PERFORMANCE_SCHEMA', 'OFF'),
('SQL_AUTO_IS_NULL', 'OFF'),
('SECURE_AUTH', 'OFF'),
('INNODB_FILE_FORMAT_CHECK', 'ON'),
('MAX_WRITE_LOCK_COUNT', '18446744073709551615'),
('RELAY_LOG', ''),
('SQL_SELECT_LIMIT', '18446744073709551615'),
('INNODB_USE_SYS_MALLOC', 'ON'),
('INNODB_CORRUPT_TABLE_ACTION', 'assert'),
('INNODB_CHECKPOINT_AGE_TARGET', '0'),
('INNODB_FLUSH_NEIGHBOR_PAGES', 'area'),
('LICENSE', 'GPL'),
('INNODB_MAX_DIRTY_PAGES_PCT', '75'),
('ENFORCE_STORAGE_ENGINE', ''),
('LOG_SLOW_ADMIN_STATEMENTS', 'OFF'),
('COLLATION_CONNECTION', 'utf8_general_ci'),
('INNODB_MERGE_SORT_BLOCK_SIZE', '1048576'),
('UNIQUE_CHECKS', 'ON'),
('PROFILING', 'OFF'),
('SYSTEM_TIME_ZONE', 'CEST'),
('INNODB_PURGE_THREADS', '1'),
('LC_TIME_NAMES', 'en_US'),
('KEY_CACHE_DIVISION_LIMIT', '100'),
('INNODB_LAZY_DROP_TABLE', '0'),
('GENERAL_LOG_FILE', '/sql/var/v323.log');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `STATISTICS`
--

CREATE TEMPORARY TABLE `STATISTICS` (
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `NON_UNIQUE` bigint(1) NOT NULL DEFAULT '0',
  `INDEX_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `INDEX_NAME` varchar(64) NOT NULL DEFAULT '',
  `SEQ_IN_INDEX` bigint(2) NOT NULL DEFAULT '0',
  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',
  `COLLATION` varchar(1) DEFAULT NULL,
  `CARDINALITY` bigint(21) DEFAULT NULL,
  `SUB_PART` bigint(3) DEFAULT NULL,
  `PACKED` varchar(10) DEFAULT NULL,
  `NULLABLE` varchar(3) NOT NULL DEFAULT '',
  `INDEX_TYPE` varchar(16) NOT NULL DEFAULT '',
  `COMMENT` varchar(16) DEFAULT NULL,
  `INDEX_COMMENT` varchar(1024) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `STATISTICS`
--

INSERT INTO `STATISTICS` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `NON_UNIQUE`, `INDEX_SCHEMA`, `INDEX_NAME`, `SEQ_IN_INDEX`, `COLUMN_NAME`, `COLLATION`, `CARDINALITY`, `SUB_PART`, `PACKED`, `NULLABLE`, `INDEX_TYPE`, `COMMENT`, `INDEX_COMMENT`) VALUES
('def', '09424370_crm', 'realization_timeline', 0, '09424370_crm', 'PRIMARY', 1, 'id', 'A', 3, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'realization_timeline', 1, '09424370_crm', 'task_id', 1, 'task_id', 'A', 3, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'realization_timeline', 1, '09424370_crm', 'task_id', 2, 'user_id', 'A', 3, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'realization_timeline', 1, '09424370_crm', 'user_id', 1, 'user_id', 'A', 3, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'role', 0, '09424370_crm', 'PRIMARY', 1, 'id', 'A', 2, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'status', 0, '09424370_crm', 'PRIMARY', 1, 'id', 'A', 3, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'tasks', 0, '09424370_crm', 'PRIMARY', 1, 'id', 'A', 4, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'tasks', 1, '09424370_crm', 'user_id', 1, 'user_id', 'A', 2, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'tasks', 1, '09424370_crm', 'user_id', 2, 'status_id', 'A', 4, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'tasks', 1, '09424370_crm', 'status_id', 1, 'status_id', 'A', 4, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'users', 0, '09424370_crm', 'PRIMARY', 1, 'id', 'A', 1, NULL, NULL, '', 'BTREE', '', ''),
('def', '09424370_crm', 'users', 1, '09424370_crm', 'users_ibfk_1', 1, 'role_id', 'A', 1, NULL, NULL, '', 'BTREE', '', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TABLES`
--

CREATE TEMPORARY TABLE `TABLES` (
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `TABLE_TYPE` varchar(64) NOT NULL DEFAULT '',
  `ENGINE` varchar(64) DEFAULT NULL,
  `VERSION` bigint(21) unsigned DEFAULT NULL,
  `ROW_FORMAT` varchar(10) DEFAULT NULL,
  `TABLE_ROWS` bigint(21) unsigned DEFAULT NULL,
  `AVG_ROW_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `DATA_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `MAX_DATA_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `INDEX_LENGTH` bigint(21) unsigned DEFAULT NULL,
  `DATA_FREE` bigint(21) unsigned DEFAULT NULL,
  `AUTO_INCREMENT` bigint(21) unsigned DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `CHECK_TIME` datetime DEFAULT NULL,
  `TABLE_COLLATION` varchar(32) DEFAULT NULL,
  `CHECKSUM` bigint(21) unsigned DEFAULT NULL,
  `CREATE_OPTIONS` varchar(255) DEFAULT NULL,
  `TABLE_COMMENT` varchar(2048) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `TABLES`
--

INSERT INTO `TABLES` (`TABLE_CATALOG`, `TABLE_SCHEMA`, `TABLE_NAME`, `TABLE_TYPE`, `ENGINE`, `VERSION`, `ROW_FORMAT`, `TABLE_ROWS`, `AVG_ROW_LENGTH`, `DATA_LENGTH`, `MAX_DATA_LENGTH`, `INDEX_LENGTH`, `DATA_FREE`, `AUTO_INCREMENT`, `CREATE_TIME`, `UPDATE_TIME`, `CHECK_TIME`, `TABLE_COLLATION`, `CHECKSUM`, `CREATE_OPTIONS`, `TABLE_COMMENT`) VALUES
('def', 'information_schema', 'CHARACTER_SETS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 384, 0, 65739264, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=174762', ''),
('def', 'information_schema', 'CLIENT_STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 362, 0, 66014682, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=185383', ''),
('def', 'information_schema', 'COLLATIONS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 231, 0, 66819522, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=290514', ''),
('def', 'information_schema', 'COLLATION_CHARACTER_SET_APPLICABILITY', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 195, 0, 65431080, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=344148', ''),
('def', 'information_schema', 'COLUMNS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=11210', ''),
('def', 'information_schema', 'COLUMN_PRIVILEGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2565, 0, 67028580, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=26163', ''),
('def', 'information_schema', 'INDEX_STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1743, 0, 67068897, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=38501', ''),
('def', 'information_schema', 'ENGINES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 490, 0, 66297000, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=136956', ''),
('def', 'information_schema', 'EVENTS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=2475', ''),
('def', 'information_schema', 'FILES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2677, 0, 67032080, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=25068', ''),
('def', 'information_schema', 'GLOBAL_STATUS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3268, 0, 67026680, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=20535', ''),
('def', 'information_schema', 'GLOBAL_TEMPORARY_TABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2174, 0, 67046160, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=30868', ''),
('def', 'information_schema', 'GLOBAL_VARIABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3268, 0, 67026680, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=20535', ''),
('def', 'information_schema', 'KEY_COLUMN_USAGE', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 4637, 0, 67064931, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=14472', ''),
('def', 'information_schema', 'PARAMETERS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=24200', ''),
('def', 'information_schema', 'PARTITIONS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=22317', ''),
('def', 'information_schema', 'PLUGINS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=45313', ''),
('def', 'information_schema', 'PROCESSLIST', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=91428', ''),
('def', 'information_schema', 'PROFILING', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 308, 0, 66248336, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=217885', ''),
('def', 'information_schema', 'REFERENTIAL_CONSTRAINTS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 4814, 0, 67078276, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=13940', ''),
('def', 'information_schema', 'ROUTINES', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=2334', ''),
('def', 'information_schema', 'QUERY_RESPONSE_TIME', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 91, 0, 63613550, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=737460', ''),
('def', 'information_schema', 'SCHEMATA', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3464, 0, 66952192, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=19373', ''),
('def', 'information_schema', 'SCHEMA_PRIVILEGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2179, 0, 66954133, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=30798', ''),
('def', 'information_schema', 'SESSION_STATUS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3268, 0, 67026680, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=20535', ''),
('def', 'information_schema', 'SESSION_VARIABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3268, 0, 67026680, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=20535', ''),
('def', 'information_schema', 'STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 5753, 0, 67022450, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=11665', ''),
('def', 'information_schema', 'TABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 9450, 0, 67057200, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=7101', ''),
('def', 'information_schema', 'TABLESPACES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 6951, 0, 67098003, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=9654', ''),
('def', 'information_schema', 'TABLE_CONSTRAINTS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2504, 0, 66894360, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=26800', ''),
('def', 'information_schema', 'TABLE_PRIVILEGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2372, 0, 66994768, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=28292', ''),
('def', 'information_schema', 'TABLE_STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1181, 0, 66937899, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=56823', ''),
('def', 'information_schema', 'TEMPORARY_TABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2174, 0, 67046160, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=30868', ''),
('def', 'information_schema', 'THREAD_STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 177, 0, 64555794, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=379146', ''),
('def', 'information_schema', 'TRIGGERS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=2277', ''),
('def', 'information_schema', 'USER_PRIVILEGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1986, 0, 66906354, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=33790', ''),
('def', 'information_schema', 'USER_STATISTICS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 603, 0, 66556728, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=111291', ''),
('def', 'information_schema', 'VIEWS', 'SYSTEM VIEW', 'MyISAM', 10, 'Dynamic', NULL, 0, 0, 281474976710655, 1024, 0, NULL, '2016-05-06 19:40:39', '2016-05-06 19:40:39', NULL, 'utf8_general_ci', NULL, 'max_rows=27742', ''),
('def', 'information_schema', 'INNODB_CMPMEM_RESET', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 29, 0, 60817408, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2314098', ''),
('def', 'information_schema', 'INNODB_RSEG', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 49, 0, 58720228, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=1369568', ''),
('def', 'information_schema', 'INNODB_UNDO_LOGS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1620, 0, 66943260, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=41425', ''),
('def', 'information_schema', 'INNODB_CMPMEM', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 29, 0, 60817408, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2314098', ''),
('def', 'information_schema', 'INNODB_SYS_TABLESTATS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1796, 0, 66958472, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=37365', ''),
('def', 'information_schema', 'INNODB_LOCK_WAITS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 599, 0, 66996952, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=112034', ''),
('def', 'information_schema', 'INNODB_INDEX_STATS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 2529, 0, 66922398, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=26535', ''),
('def', 'information_schema', 'INNODB_CMP', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 25, 0, 52428800, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2684354', ''),
('def', 'information_schema', 'INNODB_CMP_RESET', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 25, 0, 52428800, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2684354', ''),
('def', 'information_schema', 'INNODB_CHANGED_PAGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 25, 0, 52428800, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2684354', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 234, 0, 65431080, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=286790', ''),
('def', 'information_schema', 'INNODB_TRX', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 4534, 0, 67075996, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=14801', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_INDEX', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 105, 0, 62914530, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=639132', ''),
('def', 'information_schema', 'INNODB_LOCKS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 31244, 0, 67080868, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2147', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_PAGES_BLOB', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 65, 0, 60584355, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=1032444', ''),
('def', 'information_schema', 'INNODB_SYS_TABLES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1183, 0, 67051257, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=56727', ''),
('def', 'information_schema', 'INNODB_SYS_FIELDS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 594, 0, 66437712, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=112977', ''),
('def', 'information_schema', 'INNODB_SYS_COLUMNS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 610, 0, 66454620, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=110014', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 6852, 0, 67067376, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=9794', ''),
('def', 'information_schema', 'INNODB_SYS_STATS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 29, 0, 60817408, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=2314098', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1752, 0, 66803760, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=38304', ''),
('def', 'information_schema', 'INNODB_SYS_INDEXES', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 614, 0, 66890388, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=109297', ''),
('def', 'information_schema', 'XTRADB_ADMIN_COMMAND', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 3075, 0, 66998100, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=21824', ''),
('def', 'information_schema', 'INNODB_TABLE_STATS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1189, 0, 66939511, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=56441', ''),
('def', 'information_schema', 'INNODB_SYS_FOREIGN_COLS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 1748, 0, 66955392, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=38391', ''),
('def', 'information_schema', 'INNODB_BUFFER_PAGE_LRU', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 6669, 0, 67076802, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=10062', ''),
('def', 'information_schema', 'INNODB_BUFFER_POOL_STATS', 'SYSTEM VIEW', 'MEMORY', 10, 'Fixed', NULL, 257, 0, 65329400, 0, 0, NULL, '2016-05-06 19:40:39', NULL, NULL, 'utf8_general_ci', NULL, 'max_rows=261123', ''),
('def', '09424370_crm', 'realization_timeline', 'BASE TABLE', 'InnoDB', 10, 'Compact', 3, 5461, 16384, 0, 32768, 0, 4, '2016-05-06 01:56:34', NULL, NULL, 'utf8_polish_ci', NULL, '', ''),
('def', '09424370_crm', 'role', 'BASE TABLE', 'InnoDB', 10, 'Compact', 2, 8192, 16384, 0, 0, 0, NULL, '2016-05-06 01:56:34', NULL, NULL, 'utf8_polish_ci', NULL, '', ''),
('def', '09424370_crm', 'status', 'BASE TABLE', 'InnoDB', 10, 'Compact', 3, 5461, 16384, 0, 0, 0, 4, '2016-05-06 01:56:34', NULL, NULL, 'utf8_polish_ci', NULL, '', ''),
('def', '09424370_crm', 'tasks', 'BASE TABLE', 'InnoDB', 10, 'Compact', 4, 4096, 16384, 0, 32768, 0, 5, '2016-05-06 01:56:34', NULL, NULL, 'utf8_polish_ci', NULL, '', ''),
('def', '09424370_crm', 'users', 'BASE TABLE', 'InnoDB', 10, 'Compact', 1, 16384, 16384, 0, 16384, 0, 2, '2016-05-06 01:56:34', NULL, NULL, 'utf8_polish_ci', NULL, '', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TABLESPACES`
--

CREATE TEMPORARY TABLE `TABLESPACES` (
  `TABLESPACE_NAME` varchar(64) NOT NULL DEFAULT '',
  `ENGINE` varchar(64) NOT NULL DEFAULT '',
  `TABLESPACE_TYPE` varchar(64) DEFAULT NULL,
  `LOGFILE_GROUP_NAME` varchar(64) DEFAULT NULL,
  `EXTENT_SIZE` bigint(21) unsigned DEFAULT NULL,
  `AUTOEXTEND_SIZE` bigint(21) unsigned DEFAULT NULL,
  `MAXIMUM_SIZE` bigint(21) unsigned DEFAULT NULL,
  `NODEGROUP_ID` bigint(21) unsigned DEFAULT NULL,
  `TABLESPACE_COMMENT` varchar(2048) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TABLE_CONSTRAINTS`
--

CREATE TEMPORARY TABLE `TABLE_CONSTRAINTS` (
  `CONSTRAINT_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `CONSTRAINT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `CONSTRAINT_NAME` varchar(64) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `CONSTRAINT_TYPE` varchar(64) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `TABLE_CONSTRAINTS`
--

INSERT INTO `TABLE_CONSTRAINTS` (`CONSTRAINT_CATALOG`, `CONSTRAINT_SCHEMA`, `CONSTRAINT_NAME`, `TABLE_SCHEMA`, `TABLE_NAME`, `CONSTRAINT_TYPE`) VALUES
('def', '09424370_crm', 'PRIMARY', '09424370_crm', 'realization_timeline', 'PRIMARY KEY'),
('def', '09424370_crm', 'realization_timeline_ibfk_1', '09424370_crm', 'realization_timeline', 'FOREIGN KEY'),
('def', '09424370_crm', 'realization_timeline_ibfk_2', '09424370_crm', 'realization_timeline', 'FOREIGN KEY'),
('def', '09424370_crm', 'PRIMARY', '09424370_crm', 'role', 'PRIMARY KEY'),
('def', '09424370_crm', 'PRIMARY', '09424370_crm', 'status', 'PRIMARY KEY'),
('def', '09424370_crm', 'PRIMARY', '09424370_crm', 'tasks', 'PRIMARY KEY'),
('def', '09424370_crm', 'tasks_ibfk_1', '09424370_crm', 'tasks', 'FOREIGN KEY'),
('def', '09424370_crm', 'tasks_ibfk_2', '09424370_crm', 'tasks', 'FOREIGN KEY'),
('def', '09424370_crm', 'PRIMARY', '09424370_crm', 'users', 'PRIMARY KEY'),
('def', '09424370_crm', 'users_ibfk_1', '09424370_crm', 'users', 'FOREIGN KEY');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TABLE_PRIVILEGES`
--

CREATE TEMPORARY TABLE `TABLE_PRIVILEGES` (
  `GRANTEE` varchar(81) NOT NULL DEFAULT '',
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `PRIVILEGE_TYPE` varchar(64) NOT NULL DEFAULT '',
  `IS_GRANTABLE` varchar(3) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TABLE_STATISTICS`
--

CREATE TEMPORARY TABLE `TABLE_STATISTICS` (
  `TABLE_SCHEMA` varchar(192) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(192) NOT NULL DEFAULT '',
  `ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_CHANGED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_CHANGED_X_INDEXES` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `TABLE_STATISTICS`
--

INSERT INTO `TABLE_STATISTICS` (`TABLE_SCHEMA`, `TABLE_NAME`, `ROWS_READ`, `ROWS_CHANGED`, `ROWS_CHANGED_X_INDEXES`) VALUES
('09424370_crm', '#sql-a2_84880c', 0, 4, 12),
('09424370_crm', 'realization_timeline', 58, 4, 12),
('09424370_crm', 'clients', 1091, 40, 90),
('09424370_crm', '#sql-a2_71b3e3', 0, 16, 32),
('09424370_crm', '#sql-a2_84975a', 0, 4, 12),
('09424370_crm', 'tasks', 356, 5, 15),
('09424370_crm', '#sql-a2_64b0f6', 0, 5, 5),
('09424370_crm', 'role', 50, 2, 2),
('09424370_crm', 'company_sectors', 374, 12, 12),
('09424370_crm', '#sql-a2_bfe149', 0, 4, 12),
('09424370_crm', '#sql-a2_64b05d', 0, 5, 5),
('09424370_crm', '#sql-a2_71b1c2', 0, 16, 32),
('09424370_crm', 'status', 280, 4, 4),
('09424370_crm', 'users', 567, 11, 12),
('09424370_crm', '#sql-a2_7314f8', 0, 3, 3),
('09424370_crm', '#sql-a2_64b015', 0, 15, 45),
('09424370_crm', '#sql-a2_64b0b7', 0, 5, 15),
('09424370_crm', '#sql-a2_84955b', 0, 4, 12),
('09424370_crm', '#sql-a2_71b094', 0, 16, 32),
('09424370_crm', '#sql-a2_62a986', 0, 50, 130),
('09424370_crm', 'contact_timeline', 120, 5, 5),
('09424370_crm', '#sql-a2_849329', 0, 4, 12);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TEMPORARY_TABLES`
--

CREATE TEMPORARY TABLE `TEMPORARY_TABLES` (
  `SESSION_ID` bigint(4) NOT NULL DEFAULT '0',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `ENGINE` varchar(64) NOT NULL DEFAULT '',
  `NAME` varchar(512) NOT NULL DEFAULT '',
  `TABLE_ROWS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `AVG_ROW_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `INDEX_LENGTH` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `THREAD_STATISTICS`
--

CREATE TEMPORARY TABLE `THREAD_STATISTICS` (
  `THREAD_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TOTAL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONCURRENT_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONNECTED_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BUSY_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CPU_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_RECEIVED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_SENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BINLOG_BYTES_WRITTEN` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_FETCHED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_UPDATED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TABLE_ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SELECT_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `UPDATE_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OTHER_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMMIT_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROLLBACK_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DENIED_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `LOST_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ACCESS_DENIED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `EMPTY_QUERIES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TOTAL_SSL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS,SUPER privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `TRIGGERS`
--

CREATE TEMPORARY TABLE `TRIGGERS` (
  `TRIGGER_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TRIGGER_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TRIGGER_NAME` varchar(64) NOT NULL DEFAULT '',
  `EVENT_MANIPULATION` varchar(6) NOT NULL DEFAULT '',
  `EVENT_OBJECT_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `EVENT_OBJECT_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `EVENT_OBJECT_TABLE` varchar(64) NOT NULL DEFAULT '',
  `ACTION_ORDER` bigint(4) NOT NULL DEFAULT '0',
  `ACTION_CONDITION` longtext,
  `ACTION_STATEMENT` longtext NOT NULL,
  `ACTION_ORIENTATION` varchar(9) NOT NULL DEFAULT '',
  `ACTION_TIMING` varchar(6) NOT NULL DEFAULT '',
  `ACTION_REFERENCE_OLD_TABLE` varchar(64) DEFAULT NULL,
  `ACTION_REFERENCE_NEW_TABLE` varchar(64) DEFAULT NULL,
  `ACTION_REFERENCE_OLD_ROW` varchar(3) NOT NULL DEFAULT '',
  `ACTION_REFERENCE_NEW_ROW` varchar(3) NOT NULL DEFAULT '',
  `CREATED` datetime DEFAULT NULL,
  `SQL_MODE` varchar(8192) NOT NULL DEFAULT '',
  `DEFINER` varchar(77) NOT NULL DEFAULT '',
  `CHARACTER_SET_CLIENT` varchar(32) NOT NULL DEFAULT '',
  `COLLATION_CONNECTION` varchar(32) NOT NULL DEFAULT '',
  `DATABASE_COLLATION` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `USER_PRIVILEGES`
--

CREATE TEMPORARY TABLE `USER_PRIVILEGES` (
  `GRANTEE` varchar(81) NOT NULL DEFAULT '',
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `PRIVILEGE_TYPE` varchar(64) NOT NULL DEFAULT '',
  `IS_GRANTABLE` varchar(3) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `USER_PRIVILEGES`
--

INSERT INTO `USER_PRIVILEGES` (`GRANTEE`, `TABLE_CATALOG`, `PRIVILEGE_TYPE`, `IS_GRANTABLE`) VALUES
('''09424370_crm''@''%''', 'def', 'USAGE', 'NO');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `USER_STATISTICS`
--

CREATE TEMPORARY TABLE `USER_STATISTICS` (
  `USER` varchar(144) NOT NULL DEFAULT '',
  `TOTAL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONCURRENT_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CONNECTED_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BUSY_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CPU_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_RECEIVED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BYTES_SENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BINLOG_BYTES_WRITTEN` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_FETCHED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROWS_UPDATED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TABLE_ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SELECT_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `UPDATE_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OTHER_COMMANDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMMIT_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ROLLBACK_TRANSACTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DENIED_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `LOST_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ACCESS_DENIED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `EMPTY_QUERIES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TOTAL_SSL_CONNECTIONS` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS,SUPER privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `VIEWS`
--

CREATE TEMPORARY TABLE `VIEWS` (
  `TABLE_CATALOG` varchar(512) NOT NULL DEFAULT '',
  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',
  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',
  `VIEW_DEFINITION` longtext NOT NULL,
  `CHECK_OPTION` varchar(8) NOT NULL DEFAULT '',
  `IS_UPDATABLE` varchar(3) NOT NULL DEFAULT '',
  `DEFINER` varchar(77) NOT NULL DEFAULT '',
  `SECURITY_TYPE` varchar(7) NOT NULL DEFAULT '',
  `CHARACTER_SET_CLIENT` varchar(32) NOT NULL DEFAULT '',
  `COLLATION_CONNECTION` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_CMPMEM_RESET`
--

CREATE TEMPORARY TABLE `INNODB_CMPMEM_RESET` (
  `page_size` int(5) NOT NULL DEFAULT '0',
  `buffer_pool_instance` int(11) NOT NULL DEFAULT '0',
  `pages_used` int(11) NOT NULL DEFAULT '0',
  `pages_free` int(11) NOT NULL DEFAULT '0',
  `relocation_ops` bigint(21) NOT NULL DEFAULT '0',
  `relocation_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_RSEG`
--

CREATE TEMPORARY TABLE `INNODB_RSEG` (
  `rseg_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `space_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `zip_size` bigint(21) unsigned NOT NULL DEFAULT '0',
  `page_no` bigint(21) unsigned NOT NULL DEFAULT '0',
  `max_size` bigint(21) unsigned NOT NULL DEFAULT '0',
  `curr_size` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_UNDO_LOGS`
--

CREATE TEMPORARY TABLE `INNODB_UNDO_LOGS` (
  `trx_id` varchar(18) NOT NULL DEFAULT '',
  `rseg_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `useg_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `type` varchar(256) NOT NULL DEFAULT '',
  `state` varchar(256) NOT NULL DEFAULT '',
  `size` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_CMPMEM`
--

CREATE TEMPORARY TABLE `INNODB_CMPMEM` (
  `page_size` int(5) NOT NULL DEFAULT '0',
  `buffer_pool_instance` int(11) NOT NULL DEFAULT '0',
  `pages_used` int(11) NOT NULL DEFAULT '0',
  `pages_free` int(11) NOT NULL DEFAULT '0',
  `relocation_ops` bigint(21) NOT NULL DEFAULT '0',
  `relocation_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_TABLESTATS`
--

CREATE TEMPORARY TABLE `INNODB_SYS_TABLESTATS` (
  `TABLE_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SCHEMA` varchar(193) NOT NULL DEFAULT '',
  `NAME` varchar(193) NOT NULL DEFAULT '',
  `STATS_INITIALIZED` varchar(193) NOT NULL DEFAULT '',
  `NUM_ROWS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `CLUST_INDEX_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OTHER_INDEX_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `MODIFIED_COUNTER` bigint(21) unsigned NOT NULL DEFAULT '0',
  `AUTOINC` bigint(21) unsigned NOT NULL DEFAULT '0',
  `MYSQL_HANDLES_OPENED` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_LOCK_WAITS`
--

CREATE TEMPORARY TABLE `INNODB_LOCK_WAITS` (
  `requesting_trx_id` varchar(18) NOT NULL DEFAULT '',
  `requested_lock_id` varchar(81) NOT NULL DEFAULT '',
  `blocking_trx_id` varchar(18) NOT NULL DEFAULT '',
  `blocking_lock_id` varchar(81) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_INDEX_STATS`
--

CREATE TEMPORARY TABLE `INNODB_INDEX_STATS` (
  `table_schema` varchar(192) NOT NULL DEFAULT '',
  `table_name` varchar(192) NOT NULL DEFAULT '',
  `index_name` varchar(192) NOT NULL DEFAULT '',
  `fields` bigint(21) unsigned NOT NULL DEFAULT '0',
  `rows_per_key` varchar(256) NOT NULL DEFAULT '',
  `index_total_pages` bigint(21) unsigned NOT NULL DEFAULT '0',
  `index_leaf_pages` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_CMP`
--

CREATE TEMPORARY TABLE `INNODB_CMP` (
  `page_size` int(5) NOT NULL DEFAULT '0',
  `compress_ops` int(11) NOT NULL DEFAULT '0',
  `compress_ops_ok` int(11) NOT NULL DEFAULT '0',
  `compress_time` int(11) NOT NULL DEFAULT '0',
  `uncompress_ops` int(11) NOT NULL DEFAULT '0',
  `uncompress_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_CMP_RESET`
--

CREATE TEMPORARY TABLE `INNODB_CMP_RESET` (
  `page_size` int(5) NOT NULL DEFAULT '0',
  `compress_ops` int(11) NOT NULL DEFAULT '0',
  `compress_ops_ok` int(11) NOT NULL DEFAULT '0',
  `compress_time` int(11) NOT NULL DEFAULT '0',
  `uncompress_ops` int(11) NOT NULL DEFAULT '0',
  `uncompress_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_CHANGED_PAGES`
--

CREATE TEMPORARY TABLE `INNODB_CHANGED_PAGES` (
  `space_id` int(11) unsigned NOT NULL DEFAULT '0',
  `page_id` int(11) unsigned NOT NULL DEFAULT '0',
  `start_lsn` bigint(21) unsigned NOT NULL DEFAULT '0',
  `end_lsn` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_POOL_PAGES`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_POOL_PAGES` (
  `page_type` varchar(64) DEFAULT NULL,
  `space_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `page_no` bigint(21) unsigned NOT NULL DEFAULT '0',
  `lru_position` bigint(21) unsigned NOT NULL DEFAULT '0',
  `fix_count` bigint(21) unsigned NOT NULL DEFAULT '0',
  `flush_type` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_TRX`
--

CREATE TEMPORARY TABLE `INNODB_TRX` (
  `trx_id` varchar(18) NOT NULL DEFAULT '',
  `trx_state` varchar(13) NOT NULL DEFAULT '',
  `trx_started` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `trx_requested_lock_id` varchar(81) DEFAULT NULL,
  `trx_wait_started` datetime DEFAULT NULL,
  `trx_weight` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_mysql_thread_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_query` varchar(1024) DEFAULT NULL,
  `trx_operation_state` varchar(64) DEFAULT NULL,
  `trx_tables_in_use` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_tables_locked` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_lock_structs` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_lock_memory_bytes` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_rows_locked` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_rows_modified` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_concurrency_tickets` bigint(21) unsigned NOT NULL DEFAULT '0',
  `trx_isolation_level` varchar(16) NOT NULL DEFAULT '',
  `trx_unique_checks` int(1) NOT NULL DEFAULT '0',
  `trx_foreign_key_checks` int(1) NOT NULL DEFAULT '0',
  `trx_last_foreign_key_error` varchar(256) DEFAULT NULL,
  `trx_adaptive_hash_latched` int(1) NOT NULL DEFAULT '0',
  `trx_adaptive_hash_timeout` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_POOL_PAGES_INDEX`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_POOL_PAGES_INDEX` (
  `index_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `space_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `page_no` bigint(21) unsigned NOT NULL DEFAULT '0',
  `n_recs` bigint(21) unsigned NOT NULL DEFAULT '0',
  `data_size` bigint(21) unsigned NOT NULL DEFAULT '0',
  `hashed` bigint(21) unsigned NOT NULL DEFAULT '0',
  `access_time` bigint(21) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(21) unsigned NOT NULL DEFAULT '0',
  `dirty` bigint(21) unsigned NOT NULL DEFAULT '0',
  `old` bigint(21) unsigned NOT NULL DEFAULT '0',
  `lru_position` bigint(21) unsigned NOT NULL DEFAULT '0',
  `fix_count` bigint(21) unsigned NOT NULL DEFAULT '0',
  `flush_type` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_LOCKS`
--

CREATE TEMPORARY TABLE `INNODB_LOCKS` (
  `lock_id` varchar(81) NOT NULL DEFAULT '',
  `lock_trx_id` varchar(18) NOT NULL DEFAULT '',
  `lock_mode` varchar(32) NOT NULL DEFAULT '',
  `lock_type` varchar(32) NOT NULL DEFAULT '',
  `lock_table` varchar(1024) NOT NULL DEFAULT '',
  `lock_index` varchar(1024) DEFAULT NULL,
  `lock_space` bigint(21) unsigned DEFAULT NULL,
  `lock_page` bigint(21) unsigned DEFAULT NULL,
  `lock_rec` bigint(21) unsigned DEFAULT NULL,
  `lock_data` varchar(8192) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_POOL_PAGES_BLOB`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_POOL_PAGES_BLOB` (
  `space_id` bigint(21) unsigned NOT NULL DEFAULT '0',
  `page_no` bigint(21) unsigned NOT NULL DEFAULT '0',
  `compressed` bigint(21) unsigned NOT NULL DEFAULT '0',
  `part_len` bigint(21) unsigned NOT NULL DEFAULT '0',
  `next_page_no` bigint(21) unsigned NOT NULL DEFAULT '0',
  `lru_position` bigint(21) unsigned NOT NULL DEFAULT '0',
  `fix_count` bigint(21) unsigned NOT NULL DEFAULT '0',
  `flush_type` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_TABLES`
--

CREATE TEMPORARY TABLE `INNODB_SYS_TABLES` (
  `TABLE_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SCHEMA` varchar(193) NOT NULL DEFAULT '',
  `NAME` varchar(193) NOT NULL DEFAULT '',
  `FLAG` int(11) NOT NULL DEFAULT '0',
  `N_COLS` int(11) NOT NULL DEFAULT '0',
  `SPACE` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_FIELDS`
--

CREATE TEMPORARY TABLE `INNODB_SYS_FIELDS` (
  `INDEX_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NAME` varchar(193) NOT NULL DEFAULT '',
  `POS` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_COLUMNS`
--

CREATE TEMPORARY TABLE `INNODB_SYS_COLUMNS` (
  `TABLE_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NAME` varchar(193) NOT NULL DEFAULT '',
  `POS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `MTYPE` int(11) NOT NULL DEFAULT '0',
  `PRTYPE` int(11) NOT NULL DEFAULT '0',
  `LEN` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_PAGE`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_PAGE` (
  `POOL_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `BLOCK_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SPACE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGE_NUMBER` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGE_TYPE` varchar(64) DEFAULT NULL,
  `FLUSH_TYPE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `FIX_COUNT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `IS_HASHED` varchar(3) DEFAULT NULL,
  `NEWEST_MODIFICATION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OLDEST_MODIFICATION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ACCESS_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TABLE_NAME` varchar(1024) DEFAULT NULL,
  `INDEX_NAME` varchar(1024) DEFAULT NULL,
  `NUMBER_RECORDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMPRESSED_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGE_STATE` varchar(64) DEFAULT NULL,
  `IO_FIX` varchar(64) DEFAULT NULL,
  `IS_OLD` varchar(3) DEFAULT NULL,
  `FREE_PAGE_CLOCK` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_STATS`
--

CREATE TEMPORARY TABLE `INNODB_SYS_STATS` (
  `INDEX_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `KEY_COLS` int(11) unsigned NOT NULL DEFAULT '0',
  `DIFF_VALS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NON_NULL_VALS` bigint(21) unsigned DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_FOREIGN`
--

CREATE TEMPORARY TABLE `INNODB_SYS_FOREIGN` (
  `ID` varchar(193) NOT NULL DEFAULT '',
  `FOR_NAME` varchar(193) NOT NULL DEFAULT '',
  `REF_NAME` varchar(193) NOT NULL DEFAULT '',
  `N_COLS` int(11) unsigned NOT NULL DEFAULT '0',
  `TYPE` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_INDEXES`
--

CREATE TEMPORARY TABLE `INNODB_SYS_INDEXES` (
  `INDEX_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NAME` varchar(193) NOT NULL DEFAULT '',
  `TABLE_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TYPE` int(11) NOT NULL DEFAULT '0',
  `N_FIELDS` int(11) NOT NULL DEFAULT '0',
  `PAGE_NO` int(11) NOT NULL DEFAULT '0',
  `SPACE` int(11) NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `XTRADB_ADMIN_COMMAND`
--

CREATE TEMPORARY TABLE `XTRADB_ADMIN_COMMAND` (
  `result_message` varchar(1024) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_TABLE_STATS`
--

CREATE TEMPORARY TABLE `INNODB_TABLE_STATS` (
  `table_schema` varchar(192) NOT NULL DEFAULT '',
  `table_name` varchar(192) NOT NULL DEFAULT '',
  `rows` bigint(21) unsigned NOT NULL DEFAULT '0',
  `clust_size` bigint(21) unsigned NOT NULL DEFAULT '0',
  `other_size` bigint(21) unsigned NOT NULL DEFAULT '0',
  `modified` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_SYS_FOREIGN_COLS`
--

CREATE TEMPORARY TABLE `INNODB_SYS_FOREIGN_COLS` (
  `ID` varchar(193) NOT NULL DEFAULT '',
  `FOR_COL_NAME` varchar(193) NOT NULL DEFAULT '',
  `REF_COL_NAME` varchar(193) NOT NULL DEFAULT '',
  `POS` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_PAGE_LRU`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_PAGE_LRU` (
  `POOL_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `LRU_POSITION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `SPACE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGE_NUMBER` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGE_TYPE` varchar(64) DEFAULT NULL,
  `FLUSH_TYPE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `FIX_COUNT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `IS_HASHED` varchar(3) DEFAULT NULL,
  `NEWEST_MODIFICATION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OLDEST_MODIFICATION` bigint(21) unsigned NOT NULL DEFAULT '0',
  `ACCESS_TIME` bigint(21) unsigned NOT NULL DEFAULT '0',
  `TABLE_NAME` varchar(1024) DEFAULT NULL,
  `INDEX_NAME` varchar(1024) DEFAULT NULL,
  `NUMBER_RECORDS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATA_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMPRESSED_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `COMPRESSED` varchar(3) DEFAULT NULL,
  `IO_FIX` varchar(64) DEFAULT NULL,
  `IS_OLD` varchar(3) DEFAULT NULL,
  `FREE_PAGE_CLOCK` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `INNODB_BUFFER_POOL_STATS`
--

CREATE TEMPORARY TABLE `INNODB_BUFFER_POOL_STATS` (
  `POOL_ID` bigint(21) unsigned NOT NULL DEFAULT '0',
  `POOL_SIZE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `FREE_BUFFERS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `DATABASE_PAGES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `OLD_DATABASE_PAGES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `MODIFIED_DATABASE_PAGES` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PENDING_DECOMPRESS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PENDING_READS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PENDING_FLUSH_LRU` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PENDING_FLUSH_LIST` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGES_MADE_YOUNG` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGES_NOT_MADE_YOUNG` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGES_MADE_YOUNG_RATE` double NOT NULL DEFAULT '0',
  `PAGES_MADE_NOT_YOUNG_RATE` double NOT NULL DEFAULT '0',
  `NUMBER_PAGES_READ` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NUMBER_PAGES_CREATED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NUMBER_PAGES_WRITTEN` bigint(21) unsigned NOT NULL DEFAULT '0',
  `PAGES_READ_RATE` double NOT NULL DEFAULT '0',
  `PAGES_CREATE_RATE` double NOT NULL DEFAULT '0',
  `PAGES_WRITTEN_RATE` double NOT NULL DEFAULT '0',
  `NUMBER_PAGES_GET` bigint(21) unsigned NOT NULL DEFAULT '0',
  `HIT_RATE` bigint(21) unsigned NOT NULL DEFAULT '0',
  `YOUNG_MAKE_PER_THOUSAND_GETS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NOT_YOUNG_MAKE_PER_THOUSAND_GETS` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NUMBER_PAGES_READ_AHEAD` bigint(21) unsigned NOT NULL DEFAULT '0',
  `NUMBER_READ_AHEAD_EVICTED` bigint(21) unsigned NOT NULL DEFAULT '0',
  `READ_AHEAD_RATE` double NOT NULL DEFAULT '0',
  `READ_AHEAD_EVICTED_RATE` double NOT NULL DEFAULT '0',
  `LRU_IO_TOTAL` bigint(21) unsigned NOT NULL DEFAULT '0',
  `LRU_IO_CURRENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  `UNCOMPRESS_TOTAL` bigint(21) unsigned NOT NULL DEFAULT '0',
  `UNCOMPRESS_CURRENT` bigint(21) unsigned NOT NULL DEFAULT '0'
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
-- Błąd odczytu danych: (#1227 - Access denied; you need (at least one of) the PROCESS privilege(s) for this operation)

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
