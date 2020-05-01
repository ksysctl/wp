-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: cms
-- ------------------------------------------------------
-- Server version	5.7.29

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
-- Table structure for table `cerber_acl`
--

DROP TABLE IF EXISTS `cerber_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_acl` (
  `ip` varchar(81) CHARACTER SET ascii NOT NULL,
  `ip_long_begin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ip_long_end` bigint(20) unsigned NOT NULL DEFAULT '0',
  `tag` char(1) NOT NULL COMMENT 'Type: B or W',
  `comments` varchar(250) NOT NULL,
  `acl_slice` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ver6` smallint(5) unsigned NOT NULL DEFAULT '0',
  `v6range` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `req_uri` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  KEY `main_for_selects` (`acl_slice`,`ver6`,`ip_long_begin`,`ip_long_end`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber IP Access Lists';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_acl`
--

LOCK TABLES `cerber_acl` WRITE;
/*!40000 ALTER TABLE `cerber_acl` DISABLE KEYS */;
INSERT INTO `cerber_acl` VALUES ('172.20.0.*',2886991872,2886992127,'W','My subnet',0,0,'','');
/*!40000 ALTER TABLE `cerber_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_blocks`
--

DROP TABLE IF EXISTS `cerber_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_blocks` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL COMMENT 'Remote IP',
  `block_until` bigint(20) unsigned NOT NULL COMMENT 'Unix timestamp',
  `reason` varchar(250) NOT NULL COMMENT 'Why IP was blocked',
  `reason_id` int(11) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber list of currently blocked IPs';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_blocks`
--

LOCK TABLES `cerber_blocks` WRITE;
/*!40000 ALTER TABLE `cerber_blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_countries`
--

DROP TABLE IF EXISTS `cerber_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_countries` (
  `country` char(3) NOT NULL DEFAULT '' COMMENT 'Country code',
  `locale` char(10) NOT NULL DEFAULT '' COMMENT 'Locale i18n',
  `country_name` varchar(250) NOT NULL DEFAULT '' COMMENT 'Country name',
  PRIMARY KEY (`country`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_countries`
--

LOCK TABLES `cerber_countries` WRITE;
/*!40000 ALTER TABLE `cerber_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_lab`
--

DROP TABLE IF EXISTS `cerber_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_lab` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL COMMENT 'Remote IP',
  `reason_id` int(11) unsigned NOT NULL DEFAULT '0',
  `stamp` bigint(20) unsigned NOT NULL COMMENT 'Unix timestamp',
  `details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber lab cache';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_lab`
--

LOCK TABLES `cerber_lab` WRITE;
/*!40000 ALTER TABLE `cerber_lab` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_lab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_lab_ip`
--

DROP TABLE IF EXISTS `cerber_lab_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_lab_ip` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL COMMENT 'IP',
  `reputation` int(11) unsigned NOT NULL COMMENT 'Reputation of IP',
  `expires` int(11) unsigned NOT NULL COMMENT 'Unix timestamp',
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber lab IP cache';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_lab_ip`
--

LOCK TABLES `cerber_lab_ip` WRITE;
/*!40000 ALTER TABLE `cerber_lab_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_lab_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_lab_net`
--

DROP TABLE IF EXISTS `cerber_lab_net`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_lab_net` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL DEFAULT '' COMMENT 'IP address',
  `ip_long_begin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ip_long_end` bigint(20) unsigned NOT NULL DEFAULT '0',
  `country` char(3) CHARACTER SET ascii NOT NULL DEFAULT '' COMMENT 'Country code',
  `expires` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ip`),
  UNIQUE KEY `begin_end` (`ip_long_begin`,`ip_long_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber lab network cache';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_lab_net`
--

LOCK TABLES `cerber_lab_net` WRITE;
/*!40000 ALTER TABLE `cerber_lab_net` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_lab_net` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_log`
--

DROP TABLE IF EXISTS `cerber_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_log` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL COMMENT 'Remote IP',
  `ip_long` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_login` varchar(60) NOT NULL COMMENT 'Username from HTTP request',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `stamp` decimal(14,4) NOT NULL,
  `activity` int(10) unsigned NOT NULL DEFAULT '0',
  `session_id` char(32) CHARACTER SET ascii NOT NULL DEFAULT '',
  `country` char(3) CHARACTER SET ascii NOT NULL DEFAULT '' COMMENT 'Country code',
  `details` varchar(250) CHARACTER SET ascii NOT NULL DEFAULT '' COMMENT 'Details about HTTP request',
  KEY `ip` (`ip`),
  KEY `ip_long` (`ip_long`),
  KEY `session_index` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cerber activity log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_log`
--

LOCK TABLES `cerber_log` WRITE;
/*!40000 ALTER TABLE `cerber_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_qmem`
--

DROP TABLE IF EXISTS `cerber_qmem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_qmem` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL,
  `http_code` int(10) unsigned NOT NULL,
  `stamp` int(10) unsigned NOT NULL,
  KEY `ip_stamp` (`ip`,`stamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_qmem`
--

LOCK TABLES `cerber_qmem` WRITE;
/*!40000 ALTER TABLE `cerber_qmem` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_qmem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cerber_traffic`
--

DROP TABLE IF EXISTS `cerber_traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cerber_traffic` (
  `ip` varchar(39) CHARACTER SET ascii NOT NULL,
  `ip_long` bigint(20) unsigned NOT NULL DEFAULT '0',
  `hostname` varchar(250) NOT NULL DEFAULT '',
  `uri` text NOT NULL,
  `request_fields` mediumtext NOT NULL,
  `request_details` mediumtext NOT NULL,
  `session_id` char(32) CHARACTER SET ascii NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `stamp` decimal(14,4) NOT NULL,
  `processing` int(10) NOT NULL DEFAULT '0',
  `country` char(3) CHARACTER SET ascii NOT NULL DEFAULT '',
  `request_method` char(8) CHARACTER SET ascii NOT NULL,
  `http_code` int(10) unsigned NOT NULL,
  `wp_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `wp_type` int(10) unsigned NOT NULL DEFAULT '0',
  `is_bot` int(10) unsigned NOT NULL DEFAULT '0',
  `blog_id` int(10) unsigned NOT NULL DEFAULT '0',
  `php_errors` text NOT NULL,
  KEY `stamp` (`stamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cerber_traffic`
--

LOCK TABLES `cerber_traffic` WRITE;
/*!40000 ALTER TABLE `cerber_traffic` DISABLE KEYS */;
/*!40000 ALTER TABLE `cerber_traffic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_cerber_files`
--

DROP TABLE IF EXISTS `xwp_cerber_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_cerber_files` (
  `scan_id` int(10) unsigned NOT NULL,
  `scan_type` int(10) unsigned NOT NULL DEFAULT '1',
  `scan_mode` int(10) unsigned NOT NULL DEFAULT '0',
  `scan_status` int(10) unsigned NOT NULL DEFAULT '0',
  `file_status` int(10) unsigned NOT NULL DEFAULT '0',
  `file_name_hash` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `file_name` text NOT NULL,
  `file_type` int(10) unsigned NOT NULL DEFAULT '0',
  `file_hash` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `file_md5` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `file_hash_repo` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `hash_match` int(10) unsigned NOT NULL DEFAULT '0',
  `file_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `file_perms` int(11) NOT NULL DEFAULT '0',
  `file_writable` int(10) unsigned NOT NULL DEFAULT '0',
  `file_mtime` int(10) unsigned NOT NULL DEFAULT '0',
  `extra` text NOT NULL,
  PRIMARY KEY (`scan_id`,`file_name_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_cerber_files`
--

LOCK TABLES `xwp_cerber_files` WRITE;
/*!40000 ALTER TABLE `xwp_cerber_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `xwp_cerber_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_cerber_sets`
--

DROP TABLE IF EXISTS `xwp_cerber_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_cerber_sets` (
  `the_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `the_id` bigint(20) NOT NULL DEFAULT '0',
  `the_value` longtext NOT NULL,
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`the_key`,`the_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_cerber_sets`
--

LOCK TABLES `xwp_cerber_sets` WRITE;
/*!40000 ALTER TABLE `xwp_cerber_sets` DISABLE KEYS */;
INSERT INTO `xwp_cerber_sets` VALUES ('admin_message',0,'a:0:{}',0),('admin_notice',0,'a:0:{}',0),('boot_cerber_addons',0,'a:0:{}',0),('cerber_user',1,'a:2:{s:10:\"last_login\";a:2:{s:2:\"ip\";s:13:\"192.168.144.1\";s:2:\"ua\";s:40:\"50391b044bf8a8025865f5992e230346dc12dd6f\";}s:11:\"2fa_history\";a:2:{i:0;i:16;i:1;i:1588014100;}}',0),('garbage_collector',0,'1588353111',0),('refresh_add_on_list',0,'0',0),('_activated',0,'a:3:{s:7:\"Version\";s:3:\"8.6\";s:4:\"time\";i:1588012304;s:4:\"user\";i:1;}',0),('_cerberkey_',0,'a:3:{i:0;s:32:\"9bf8306c5ceddf93f000a27c98fe2e57\";i:1;i:1588095858;i:4;s:40:\"SK//EXQB0DMSGJPNOW1H23UYF96TA7CI5ZL8KR4V\";}',0),('_cerber_mnemosyne',0,'a:3:{i:0;s:18:\"2GJHXE64LVRQY9KUID\";i:4;i:6;i:6;s:19:\"ASY6LHRDZFB82N9Q3I5\";}',0);
/*!40000 ALTER TABLE `xwp_cerber_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_cerber_uss`
--

DROP TABLE IF EXISTS `xwp_cerber_uss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_cerber_uss` (
  `user_id` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) CHARACTER SET ascii NOT NULL,
  `country` char(3) CHARACTER SET ascii NOT NULL DEFAULT '',
  `started` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  `session_id` char(32) CHARACTER SET ascii NOT NULL DEFAULT '',
  `wp_session_token` varchar(250) CHARACTER SET ascii NOT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_cerber_uss`
--

LOCK TABLES `xwp_cerber_uss` WRITE;
/*!40000 ALTER TABLE `xwp_cerber_uss` DISABLE KEYS */;
INSERT INTO `xwp_cerber_uss` VALUES (1,'192.168.144.1','',1588350500,1588523300,'vus5aPcRUDZToJxmSVlk8EKQ','831dee462f6ef9eb686e92833df5ad480342c3c3007fb06d9eadefc7c6a0cfa6');
/*!40000 ALTER TABLE `xwp_cerber_uss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_commentmeta`
--

DROP TABLE IF EXISTS `xwp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_commentmeta`
--

LOCK TABLES `xwp_commentmeta` WRITE;
/*!40000 ALTER TABLE `xwp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `xwp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_comments`
--

DROP TABLE IF EXISTS `xwp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_comments`
--

LOCK TABLES `xwp_comments` WRITE;
/*!40000 ALTER TABLE `xwp_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `xwp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_links`
--

DROP TABLE IF EXISTS `xwp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_links`
--

LOCK TABLES `xwp_links` WRITE;
/*!40000 ALTER TABLE `xwp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `xwp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_options`
--

DROP TABLE IF EXISTS `xwp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=467 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_options`
--

LOCK TABLES `xwp_options` WRITE;
/*!40000 ALTER TABLE `xwp_options` DISABLE KEYS */;
INSERT INTO `xwp_options` VALUES (1,'siteurl','https://cms.loc','yes'),(2,'home','https://cms.loc','yes'),(3,'blogname','WP Project','yes'),(4,'blogdescription','Just another WordPress site','yes'),(5,'users_can_register','0','yes'),(6,'admin_email','cms@cms.loc','yes'),(7,'start_of_week','1','yes'),(8,'use_balanceTags','0','yes'),(9,'use_smilies','1','yes'),(10,'require_name_email','1','yes'),(11,'comments_notify','1','yes'),(12,'posts_per_rss','10','yes'),(13,'rss_use_excerpt','0','yes'),(14,'mailserver_url','mail.cms.loc','yes'),(15,'mailserver_login','login@cms.loc','yes'),(16,'mailserver_pass','password','yes'),(17,'mailserver_port','110','yes'),(18,'default_category','1','yes'),(19,'default_comment_status','open','yes'),(20,'default_ping_status','open','yes'),(21,'default_pingback_flag','1','yes'),(22,'posts_per_page','10','yes'),(23,'date_format','F j, Y','yes'),(24,'time_format','g:i a','yes'),(25,'links_updated_date_format','F j, Y g:i a','yes'),(26,'comment_moderation','0','yes'),(27,'moderation_notify','1','yes'),(28,'permalink_structure','/%year%/%monthnum%/%day%/%postname%/','yes'),(30,'hack_file','0','yes'),(31,'blog_charset','UTF-8','yes'),(32,'moderation_keys','','no'),(33,'active_plugins','a:8:{i:0;s:21:\"polylang/polylang.php\";i:1;s:31:\"query-monitor/query-monitor.php\";i:2;s:30:\"advanced-custom-fields/acf.php\";i:3;s:49:\"advanced-database-cleaner/advanced-db-cleaner.php\";i:4;s:19:\"akismet/akismet.php\";i:5;s:23:\"wp-cerber/wp-cerber.php\";i:6;s:35:\"wp-fastest-cache/wpFastestCache.php\";i:7;s:29:\"wp-mail-smtp/wp_mail_smtp.php\";}','yes'),(34,'category_base','','yes'),(35,'ping_sites','http://rpc.pingomatic.com/','yes'),(36,'comment_max_links','2','yes'),(37,'gmt_offset','-6','yes'),(38,'default_email_category','1','yes'),(39,'recently_edited','','no'),(40,'template','twentytwenty','yes'),(41,'stylesheet','twentytwenty','yes'),(42,'comment_whitelist','1','yes'),(43,'blacklist_keys','','no'),(44,'comment_registration','0','yes'),(45,'html_type','text/html','yes'),(46,'use_trackback','0','yes'),(47,'default_role','subscriber','yes'),(48,'db_version','47018','yes'),(49,'uploads_use_yearmonth_folders','1','yes'),(50,'upload_path','','yes'),(51,'blog_public','1','yes'),(52,'default_link_category','0','yes'),(53,'show_on_front','posts','yes'),(54,'tag_base','','yes'),(55,'show_avatars','1','yes'),(56,'avatar_rating','G','yes'),(57,'upload_url_path','','yes'),(58,'thumbnail_size_w','150','yes'),(59,'thumbnail_size_h','150','yes'),(60,'thumbnail_crop','1','yes'),(61,'medium_size_w','300','yes'),(62,'medium_size_h','300','yes'),(63,'avatar_default','mystery','yes'),(64,'large_size_w','1024','yes'),(65,'large_size_h','1024','yes'),(66,'image_default_link_type','none','yes'),(67,'image_default_size','','yes'),(68,'image_default_align','','yes'),(69,'close_comments_for_old_posts','0','yes'),(70,'close_comments_days_old','14','yes'),(71,'thread_comments','1','yes'),(72,'thread_comments_depth','5','yes'),(73,'page_comments','0','yes'),(74,'comments_per_page','50','yes'),(75,'default_comments_page','newest','yes'),(76,'comment_order','asc','yes'),(77,'sticky_posts','a:0:{}','yes'),(78,'widget_categories','a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(79,'widget_text','a:3:{i:2;a:4:{s:5:\"title\";s:15:\"About This Site\";s:4:\"text\";s:85:\"This may be a good place to introduce yourself and your site or include some credits.\";s:6:\"filter\";b:1;s:6:\"visual\";b:1;}i:3;a:4:{s:5:\"title\";s:7:\"Find Us\";s:4:\"text\";s:168:\"<strong>Address</strong>\n123 Main Street\nNew York, NY 10001\n\n<strong>Hours</strong>\nMonday&ndash;Friday: 9:00AM&ndash;5:00PM\nSaturday &amp; Sunday: 11:00AM&ndash;3:00PM\";s:6:\"filter\";b:1;s:6:\"visual\";b:1;}s:12:\"_multiwidget\";i:1;}','yes'),(80,'widget_rss','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes'),(81,'uninstall_plugins','a:2:{s:23:\"wp-cerber/wp-cerber.php\";s:13:\"cerber_finito\";s:49:\"advanced-database-cleaner/advanced-db-cleaner.php\";a:2:{i:0;s:24:\"ADBC_Advanced_DB_Cleaner\";i:1;s:14:\"aDBc_uninstall\";}}','no'),(82,'timezone_string','','yes'),(83,'page_for_posts','0','yes'),(84,'page_on_front','0','yes'),(85,'default_post_format','0','yes'),(86,'link_manager_enabled','0','yes'),(87,'finished_splitting_shared_terms','1','yes'),(88,'site_icon','0','yes'),(89,'medium_large_size_w','768','yes'),(90,'medium_large_size_h','0','yes'),(91,'wp_page_for_privacy_policy','3','yes'),(92,'show_comments_cookies_opt_in','1','yes'),(93,'admin_email_lifespan','1603555971','yes'),(94,'initial_db_version','47018','yes'),(95,'xwp_user_roles','a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}','yes'),(96,'fresh_site','1','yes'),(97,'widget_search','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(98,'widget_recent-posts','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(99,'widget_recent-comments','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(100,'widget_archives','a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(101,'widget_meta','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(102,'sidebars_widgets','a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";}s:9:\"sidebar-2\";a:3:{i:0;s:10:\"archives-2\";i:1;s:12:\"categories-2\";i:2;s:6:\"meta-2\";}s:13:\"array_version\";i:3;}','yes'),(103,'cron','a:11:{i:1588353173;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1588353404;a:1:{s:18:\"cerber_bg_launcher\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:8:\"crb_five\";s:4:\"args\";a:0:{}s:8:\"interval\";i:300;}}}i:1588353422;a:1:{s:24:\"wp_fastest_cache_Preload\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:15:\"everyfiveminute\";s:4:\"args\";a:0:{}s:8:\"interval\";i:300;}}}i:1588356000;a:1:{s:15:\"cerber_hourly_1\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1588356600;a:1:{s:15:\"cerber_hourly_2\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1588360800;a:1:{s:12:\"cerber_daily\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1588392773;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1588435973;a:1:{s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1588435983;a:3:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1588695173;a:1:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','yes'),(104,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(105,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(106,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(107,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(108,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(109,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(110,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(111,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(112,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(114,'recovery_keys','a:0:{}','yes'),(118,'theme_mods_twentytwenty','a:1:{s:18:\"custom_css_post_id\";i:-1;}','yes'),(127,'can_compress_scripts','0','no'),(140,'recently_activated','a:4:{s:46:\"wp-clean-up-optimizer/wp-cleanup-optimizer.php\";i:1588101577;s:33:\"lingotek-translation/lingotek.php\";i:1588023214;s:51:\"wp-limit-login-attempts/wp-limit-login-attempts.php\";i:1588012668;s:33:\"wps-hide-login/wps-hide-login.php\";i:1588012664;}','yes'),(141,'acf_version','5.8.9','yes'),(145,'WPLANG','','yes'),(146,'new_admin_email','cms@cms.loc','yes'),(163,'WpFc_api_key','8b37bd2c5170cfb23d3cae8293dc9051','yes'),(164,'WpFastestCachePreLoad','{\"homepage\":-1,\"post\":1,\"category\":1,\"page\":1,\"tag\":0,\"attachment\":-1,\"customposttypes\":0,\"customTaxonomies\":0,\"number\":\"4\"}','yes'),(165,'WpFastestCache','{\"wpFastestCacheStatus\":\"on\",\"wpFastestCachePreload\":\"on\",\"wpFastestCachePreload_homepage\":\"on\",\"wpFastestCachePreload_post\":\"on\",\"wpFastestCachePreload_category\":\"on\",\"wpFastestCachePreload_page\":\"on\",\"wpFastestCachePreload_tag\":\"on\",\"wpFastestCachePreload_attachment\":\"on\",\"wpFastestCachePreload_customposttypes\":\"on\",\"wpFastestCachePreload_customTaxonomies\":\"on\",\"wpFastestCachePreload_number\":\"4\",\"wpFastestCachePreload_restart\":\"on\",\"wpFastestCacheLoggedInUser\":\"on\",\"wpFastestCacheMobile\":\"on\",\"wpFastestCacheNewPost\":\"on\",\"wpFastestCacheNewPost_type\":\"all\",\"wpFastestCacheUpdatePost\":\"on\",\"wpFastestCacheUpdatePost_type\":\"post\",\"wpFastestCacheMinifyHtml\":\"on\",\"wpFastestCacheMinifyCss\":\"on\",\"wpFastestCacheCombineCss\":\"on\",\"wpFastestCacheCombineJs\":\"on\",\"wpFastestCacheGzip\":\"on\",\"wpFastestCacheLBC\":\"on\",\"wpFastestCacheDisableEmojis\":\"on\",\"wpFastestCacheLanguage\":\"eng\"}','yes'),(166,'wpfc-group','','yes'),(178,'dnh_dismissed_notices','a:1:{i:0;s:24:\"wrm_1e278f4992d8bb3f1f0b\";}','yes'),(184,'WpFastestCacheExclude','[{\"prefix\":\"exact\",\"content\":\"mngr\",\"type\":\"page\"}]','yes'),(192,'widget_akismet_widget','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(194,'akismet_strictness','1','yes'),(195,'akismet_show_user_comments_approved','1','yes'),(196,'akismet_comment_form_privacy_notice','display','yes'),(197,'wordpress_api_key','e735d1a5e1e2','yes'),(198,'akismet_spam_count','0','yes'),(206,'limit_login_captcha','checked','yes'),(207,'limit_login_install_date','2020-04-27 18:14:45','yes'),(215,'cerber-main','a:30:{s:9:\"boot-mode\";s:1:\"0\";s:8:\"attempts\";s:1:\"5\";s:6:\"period\";s:2:\"30\";s:7:\"lockout\";s:2:\"60\";s:8:\"agperiod\";s:2:\"24\";s:7:\"aglocks\";s:1:\"2\";s:6:\"aglast\";s:1:\"4\";s:10:\"limitwhite\";s:0:\"\";s:5:\"proxy\";s:0:\"\";s:10:\"cookiepref\";s:0:\"\";s:6:\"subnet\";s:0:\"\";s:8:\"nonusers\";s:0:\"\";s:7:\"wplogin\";s:0:\"\";s:10:\"noredirect\";s:0:\"\";s:7:\"page404\";s:1:\"1\";s:9:\"loginpath\";s:4:\"mngr\";s:9:\"loginnowp\";s:1:\"1\";s:10:\"citadel_on\";s:1:\"1\";s:7:\"cilimit\";s:3:\"100\";s:8:\"ciperiod\";s:2:\"15\";s:10:\"ciduration\";s:2:\"60\";s:8:\"cinotify\";s:1:\"1\";s:7:\"keeplog\";s:2:\"30\";s:12:\"keeplog_auth\";s:2:\"30\";s:8:\"ip_extra\";s:1:\"1\";s:9:\"cerberlab\";s:0:\"\";s:11:\"cerberproto\";s:1:\"1\";s:7:\"usefile\";s:0:\"\";s:10:\"dateformat\";s:0:\"\";s:10:\"admin_lang\";s:1:\"1\";}','no'),(216,'cerber-hardening','a:13:{s:8:\"stopenum\";s:1:\"1\";s:8:\"adminphp\";s:0:\"\";s:8:\"phpnoupl\";i:1;s:8:\"nophperr\";s:1:\"1\";s:6:\"xmlrpc\";s:1:\"1\";s:7:\"nofeeds\";s:0:\"\";s:10:\"norestuser\";s:1:\"1\";s:6:\"norest\";s:1:\"1\";s:8:\"restauth\";s:1:\"1\";s:9:\"restroles\";a:1:{i:0;s:13:\"administrator\";}s:9:\"restwhite\";a:1:{i:0;s:6:\"oembed\";}s:10:\"hashauthor\";s:0:\"\";s:9:\"cleanhead\";s:0:\"\";}','no'),(217,'cerber-users','a:16:{s:8:\"authonly\";i:0;s:11:\"authonlyacl\";i:0;s:11:\"authonlymsg\";s:68:\"Only registered and logged in users are allowed to view this website\";s:13:\"authonlyredir\";s:0:\"\";s:12:\"reglimit_num\";i:3;s:12:\"reglimit_min\";i:60;s:6:\"emrule\";i:0;s:6:\"emlist\";a:0:{}s:10:\"prohibited\";a:0:{}s:11:\"auth_expire\";s:0:\"\";s:8:\"usersort\";s:0:\"\";s:11:\"pdata_erase\";i:0;s:14:\"pdata_sessions\";i:0;s:12:\"pdata_export\";i:0;s:9:\"pdata_act\";i:0;s:9:\"pdata_trf\";a:0:{}}','no'),(218,'cerber-antispam','a:9:{s:8:\"botscomm\";i:1;s:7:\"botsreg\";i:0;s:7:\"botsany\";i:0;s:8:\"botssafe\";i:0;s:10:\"botsnoauth\";i:1;s:9:\"botswhite\";s:0:\"\";s:8:\"spamcomm\";i:0;s:10:\"trashafter\";i:7;s:18:\"trashafter-enabled\";i:0;}','no'),(219,'cerber-recaptcha','a:14:{s:7:\"sitekey\";s:40:\"6LddMO4UAAAAABWzPeYhd_zKnjxudya6FwTfYbPR\";s:9:\"secretkey\";s:40:\"6LddMO4UAAAAAHpshqJ78w2PmTZClBV6fu_x40Tz\";s:9:\"invirecap\";s:0:\"\";s:10:\"recaplogin\";s:1:\"1\";s:9:\"recaplost\";s:1:\"1\";s:8:\"recapreg\";s:1:\"1\";s:13:\"recapwoologin\";s:1:\"1\";s:12:\"recapwoolost\";s:1:\"1\";s:11:\"recapwooreg\";s:1:\"1\";s:8:\"recapcom\";s:1:\"1\";s:12:\"recapcomauth\";s:1:\"1\";s:16:\"recaptcha-period\";s:2:\"60\";s:16:\"recaptcha-number\";s:1:\"3\";s:16:\"recaptcha-within\";s:2:\"30\";}','no'),(220,'cerber-notifications','a:11:{s:6:\"notify\";i:1;s:5:\"above\";i:3;s:5:\"email\";s:0:\"\";s:9:\"emailrate\";i:12;s:14:\"notify-new-ver\";s:1:\"1\";s:7:\"pbtoken\";s:0:\"\";s:8:\"pbdevice\";s:0:\"\";s:12:\"wreports-day\";s:1:\"1\";s:13:\"wreports-time\";i:9;s:12:\"email-report\";s:0:\"\";s:13:\"enable-report\";s:1:\"1\";}','no'),(221,'cerber-traffic','a:16:{s:9:\"tienabled\";s:1:\"1\";s:9:\"tiipwhite\";i:0;s:7:\"tiwhite\";s:0:\"\";s:8:\"tierrmon\";s:1:\"1\";s:11:\"tierrnoauth\";i:0;s:6:\"timode\";s:1:\"1\";s:9:\"tinocrabs\";s:1:\"1\";s:8:\"tifields\";i:0;s:6:\"timask\";s:0:\"\";s:6:\"tihdrs\";i:0;s:6:\"tisenv\";i:0;s:7:\"ticandy\";i:0;s:8:\"tiphperr\";i:0;s:11:\"tithreshold\";s:0:\"\";s:9:\"tikeeprec\";i:30;s:14:\"tikeeprec_auth\";i:30;}','no'),(222,'cerber-user_shield','a:9:{s:7:\"ds_4acc\";i:0;s:13:\"ds_regs_roles\";a:0:{}s:10:\"ds_add_acc\";a:1:{i:0;s:13:\"administrator\";}s:11:\"ds_edit_acc\";a:1:{i:0;s:13:\"administrator\";}s:11:\"ds_4acc_acl\";i:0;s:9:\"ds_4roles\";i:0;s:11:\"ds_add_role\";a:1:{i:0;s:13:\"administrator\";}s:12:\"ds_edit_role\";a:1:{i:0;s:13:\"administrator\";}s:13:\"ds_4roles_acl\";i:0;}','no'),(223,'cerber-opt_shield','a:4:{s:8:\"ds_4opts\";i:0;s:14:\"ds_4opts_roles\";a:1:{i:0;s:13:\"administrator\";}s:13:\"ds_4opts_list\";a:7:{s:11:\"admin_email\";i:1;s:12:\"default_role\";i:1;s:4:\"home\";i:1;s:7:\"siteurl\";i:1;s:18:\"users_can_register\";i:1;s:14:\"active_plugins\";i:1;s:8:\"template\";i:1;}s:12:\"ds_4opts_acl\";i:0;}','no'),(224,'cerber-scanner','a:10:{s:8:\"scan_cpt\";a:0:{}s:9:\"scan_uext\";a:0:{}s:12:\"scan_exclude\";a:0:{}s:9:\"scan_inew\";s:1:\"1\";s:9:\"scan_imod\";s:1:\"1\";s:10:\"scan_chmod\";s:1:\"0\";s:8:\"scan_tmp\";s:1:\"1\";s:9:\"scan_sess\";s:1:\"1\";s:10:\"scan_debug\";s:1:\"0\";s:13:\"scan_qcleanup\";s:2:\"30\";}','no'),(225,'cerber-schedule','a:8:{s:11:\"scan_aquick\";i:0;s:10:\"scan_afull\";s:5:\"05:00\";s:18:\"scan_afull-enabled\";i:0;s:10:\"scan_reinc\";a:5:{i:3;i:1;i:4;i:1;i:15;i:1;i:50;i:1;i:51;i:1;}s:12:\"scan_relimit\";i:3;s:10:\"scan_isize\";i:0;s:12:\"scan_ierrors\";i:0;s:10:\"email-scan\";s:0:\"\";}','no'),(226,'cerber-policies','a:9:{s:13:\"scan_delunatt\";i:0;s:11:\"scan_delupl\";a:0:{}s:14:\"scan_delunwant\";i:0;s:15:\"scan_recover_wp\";i:0;s:15:\"scan_recover_pl\";i:0;s:14:\"scan_nodeltemp\";i:0;s:14:\"scan_nodelsess\";i:0;s:13:\"scan_delexdir\";a:0:{}s:13:\"scan_delexext\";a:0:{}}','no'),(227,'cerber-nexus_master','a:7:{s:13:\"master_tolist\";i:1;s:13:\"master_swshow\";i:1;s:14:\"master_at_site\";i:1;s:13:\"master_locale\";i:0;s:9:\"master_dt\";i:0;s:9:\"master_tz\";i:0;s:11:\"master_diag\";i:0;}','no'),(228,'cerber-nexus-slave','a:3:{s:9:\"slave_ips\";s:0:\"\";s:12:\"slave_access\";i:2;s:10:\"slave_diag\";i:0;}','no'),(229,'_cerber_db_errors','','no'),(230,'cerber-antibot','a:2:{i:0;a:3:{i:0;a:2:{i:0;s:9:\"FwJdkYpT_\";i:1;s:9:\"KRXTcqSp2\";}i:1;a:2:{i:0;s:8:\"emcIFGzS\";i:1;s:8:\"ECm1bdTG\";}i:2;a:2:{i:0;s:8:\"PXQBZmCg\";i:1;s:8:\"2MUj*zZq\";}}i:1;a:4:{i:0;a:2:{i:0;s:7:\"GSJvONF\";i:1;s:7:\"ifQepI[\";}i:1;a:2:{i:0;s:9:\"mayroGVvS\";i:1;s:9:\"UoS7W9gIp\";}i:2;a:2:{i:0;s:14:\"ztNMRBuk_OYVwX\";i:1;s:14:\"ONbUvA6KH13SJo\";}i:3;a:2:{i:0;s:10:\"YIWyONxCQF\";i:1;s:10:\"TXmZL630.E\";}}}','no'),(232,'_cerber_up','a:2:{s:1:\"v\";s:5:\"8.6.3\";s:1:\"t\";i:1588095858;}','no'),(233,'cerber-groove','5ahVBDGojkerTbuH','no'),(234,'cerber-groove-x','a:2:{i:0;s:32:\"Aw8tNnhEoHJuUDypvesjKd1lrOkL92BF\";i:1;s:26:\"M3h1bYD82sA9dHTOI7XcjvSePB\";}','no'),(244,'cerber_configuration','a:58:{s:9:\"boot-mode\";s:1:\"0\";s:8:\"attempts\";s:1:\"5\";s:7:\"lockout\";s:2:\"60\";s:10:\"aggressive\";s:0:\"\";s:10:\"limitwhite\";s:0:\"\";s:6:\"subnet\";s:0:\"\";s:8:\"nonusers\";s:0:\"\";s:10:\"noredirect\";s:0:\"\";s:7:\"wplogin\";s:0:\"\";s:7:\"page404\";s:1:\"1\";s:9:\"loginpath\";s:4:\"mngr\";s:9:\"loginnowp\";s:1:\"1\";s:5:\"proxy\";s:0:\"\";s:10:\"cookiepref\";s:0:\"\";s:10:\"citadel_on\";s:1:\"1\";s:7:\"citadel\";s:0:\"\";s:10:\"ciduration\";s:2:\"60\";s:8:\"cinotify\";s:1:\"1\";s:7:\"keeplog\";s:2:\"30\";s:12:\"keeplog_auth\";s:2:\"30\";s:9:\"cerberlab\";s:0:\"\";s:11:\"cerberproto\";s:1:\"1\";s:7:\"usefile\";s:0:\"\";s:8:\"ip_extra\";s:1:\"1\";s:10:\"dateformat\";s:0:\"\";s:10:\"admin_lang\";s:1:\"1\";s:6:\"period\";s:2:\"30\";s:8:\"agperiod\";s:2:\"24\";s:7:\"aglocks\";s:1:\"2\";s:6:\"aglast\";s:1:\"4\";s:7:\"cilimit\";s:3:\"100\";s:8:\"ciperiod\";s:2:\"15\";s:8:\"stopenum\";s:1:\"1\";s:8:\"adminphp\";s:0:\"\";s:8:\"phpnoupl\";s:0:\"\";s:8:\"nophperr\";s:1:\"1\";s:6:\"xmlrpc\";s:1:\"1\";s:7:\"nofeeds\";s:0:\"\";s:10:\"norestuser\";s:1:\"1\";s:6:\"norest\";s:1:\"1\";s:8:\"restauth\";s:1:\"1\";s:9:\"restroles\";a:1:{i:0;s:13:\"administrator\";}s:9:\"restwhite\";s:6:\"oembed\";s:7:\"sitekey\";s:40:\"6LddMO4UAAAAABWzPeYhd_zKnjxudya6FwTfYbPR\";s:9:\"secretkey\";s:40:\"6LddMO4UAAAAAHpshqJ78w2PmTZClBV6fu_x40Tz\";s:9:\"invirecap\";s:0:\"\";s:8:\"recapreg\";s:1:\"1\";s:11:\"recapwooreg\";s:1:\"1\";s:9:\"recaplost\";s:1:\"1\";s:12:\"recapwoolost\";s:1:\"1\";s:10:\"recaplogin\";s:1:\"1\";s:13:\"recapwoologin\";s:1:\"1\";s:8:\"recapcom\";s:1:\"1\";s:12:\"recapcomauth\";s:1:\"1\";s:10:\"recaplimit\";s:0:\"\";s:16:\"recaptcha-period\";s:2:\"60\";s:16:\"recaptcha-number\";s:1:\"3\";s:16:\"recaptcha-within\";s:2:\"30\";}','no'),(273,'polylang','a:14:{s:7:\"browser\";i:1;s:7:\"rewrite\";i:1;s:12:\"hide_default\";i:1;s:10:\"force_lang\";i:0;s:13:\"redirect_lang\";i:0;s:13:\"media_support\";b:1;s:9:\"uninstall\";i:0;s:4:\"sync\";a:0:{}s:10:\"post_types\";a:0:{}s:10:\"taxonomies\";a:0:{}s:7:\"domains\";a:0:{}s:7:\"version\";s:5:\"2.7.2\";s:16:\"first_activation\";i:1588022876;s:12:\"default_lang\";s:2:\"en\";}','yes'),(274,'polylang_wpml_strings','a:0:{}','yes'),(275,'widget_polylang','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(283,'pll_dismissed_notices','a:2:{i:0;s:6:\"wizard\";i:1;s:8:\"lingotek\";}','yes'),(290,'lingotek_plugin_version','1.4.6','yes'),(296,'rewrite_rules','a:129:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:50:\"(es)/type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:67:\"index.php?lang=$matches[1]&post_format=$matches[2]&feed=$matches[3]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:58:\"index.php?lang=en&post_format=$matches[1]&feed=$matches[2]\";s:45:\"(es)/type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:67:\"index.php?lang=$matches[1]&post_format=$matches[2]&feed=$matches[3]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:58:\"index.php?lang=en&post_format=$matches[1]&feed=$matches[2]\";s:26:\"(es)/type/([^/]+)/embed/?$\";s:61:\"index.php?lang=$matches[1]&post_format=$matches[2]&embed=true\";s:21:\"type/([^/]+)/embed/?$\";s:52:\"index.php?lang=en&post_format=$matches[1]&embed=true\";s:38:\"(es)/type/([^/]+)/page/?([0-9]{1,})/?$\";s:68:\"index.php?lang=$matches[1]&post_format=$matches[2]&paged=$matches[3]\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:59:\"index.php?lang=en&post_format=$matches[1]&paged=$matches[2]\";s:20:\"(es)/type/([^/]+)/?$\";s:50:\"index.php?lang=$matches[1]&post_format=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:41:\"index.php?lang=en&post_format=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:37:\"(es)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?lang=$matches[1]&&feed=$matches[2]\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:35:\"index.php?lang=en&&feed=$matches[1]\";s:32:\"(es)/(feed|rdf|rss|rss2|atom)/?$\";s:44:\"index.php?lang=$matches[1]&&feed=$matches[2]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:35:\"index.php?lang=en&&feed=$matches[1]\";s:13:\"(es)/embed/?$\";s:38:\"index.php?lang=$matches[1]&&embed=true\";s:8:\"embed/?$\";s:29:\"index.php?lang=en&&embed=true\";s:25:\"(es)/page/?([0-9]{1,})/?$\";s:45:\"index.php?lang=$matches[1]&&paged=$matches[2]\";s:20:\"page/?([0-9]{1,})/?$\";s:36:\"index.php?lang=en&&paged=$matches[1]\";s:7:\"(es)/?$\";s:26:\"index.php?lang=$matches[1]\";s:46:\"(es)/comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:59:\"index.php?lang=$matches[1]&&feed=$matches[2]&withcomments=1\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?lang=en&&feed=$matches[1]&withcomments=1\";s:41:\"(es)/comments/(feed|rdf|rss|rss2|atom)/?$\";s:59:\"index.php?lang=$matches[1]&&feed=$matches[2]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?lang=en&&feed=$matches[1]&withcomments=1\";s:22:\"(es)/comments/embed/?$\";s:38:\"index.php?lang=$matches[1]&&embed=true\";s:17:\"comments/embed/?$\";s:29:\"index.php?lang=en&&embed=true\";s:49:\"(es)/search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:57:\"index.php?lang=$matches[1]&s=$matches[2]&feed=$matches[3]\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:48:\"index.php?lang=en&s=$matches[1]&feed=$matches[2]\";s:44:\"(es)/search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:57:\"index.php?lang=$matches[1]&s=$matches[2]&feed=$matches[3]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:48:\"index.php?lang=en&s=$matches[1]&feed=$matches[2]\";s:25:\"(es)/search/(.+)/embed/?$\";s:51:\"index.php?lang=$matches[1]&s=$matches[2]&embed=true\";s:20:\"search/(.+)/embed/?$\";s:42:\"index.php?lang=en&s=$matches[1]&embed=true\";s:37:\"(es)/search/(.+)/page/?([0-9]{1,})/?$\";s:58:\"index.php?lang=$matches[1]&s=$matches[2]&paged=$matches[3]\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:49:\"index.php?lang=en&s=$matches[1]&paged=$matches[2]\";s:19:\"(es)/search/(.+)/?$\";s:40:\"index.php?lang=$matches[1]&s=$matches[2]\";s:14:\"search/(.+)/?$\";s:31:\"index.php?lang=en&s=$matches[1]\";s:52:\"(es)/author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:67:\"index.php?lang=$matches[1]&author_name=$matches[2]&feed=$matches[3]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:58:\"index.php?lang=en&author_name=$matches[1]&feed=$matches[2]\";s:47:\"(es)/author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:67:\"index.php?lang=$matches[1]&author_name=$matches[2]&feed=$matches[3]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:58:\"index.php?lang=en&author_name=$matches[1]&feed=$matches[2]\";s:28:\"(es)/author/([^/]+)/embed/?$\";s:61:\"index.php?lang=$matches[1]&author_name=$matches[2]&embed=true\";s:23:\"author/([^/]+)/embed/?$\";s:52:\"index.php?lang=en&author_name=$matches[1]&embed=true\";s:40:\"(es)/author/([^/]+)/page/?([0-9]{1,})/?$\";s:68:\"index.php?lang=$matches[1]&author_name=$matches[2]&paged=$matches[3]\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:59:\"index.php?lang=en&author_name=$matches[1]&paged=$matches[2]\";s:22:\"(es)/author/([^/]+)/?$\";s:50:\"index.php?lang=$matches[1]&author_name=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:41:\"index.php?lang=en&author_name=$matches[1]\";s:74:\"(es)/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&day=$matches[4]&feed=$matches[5]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:69:\"(es)/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&day=$matches[4]&feed=$matches[5]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:50:\"(es)/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:91:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&day=$matches[4]&embed=true\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:62:\"(es)/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:98:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&day=$matches[4]&paged=$matches[5]\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:44:\"(es)/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:80:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&day=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:61:\"(es)/([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:81:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&feed=$matches[4]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:56:\"(es)/([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:81:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&feed=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:37:\"(es)/([0-9]{4})/([0-9]{1,2})/embed/?$\";s:75:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&embed=true\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:49:\"(es)/([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:82:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]&paged=$matches[4]\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:31:\"(es)/([0-9]{4})/([0-9]{1,2})/?$\";s:64:\"index.php?lang=$matches[1]&year=$matches[2]&monthnum=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:48:\"(es)/([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:60:\"index.php?lang=$matches[1]&year=$matches[2]&feed=$matches[3]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:43:\"(es)/([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:60:\"index.php?lang=$matches[1]&year=$matches[2]&feed=$matches[3]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:24:\"(es)/([0-9]{4})/embed/?$\";s:54:\"index.php?lang=$matches[1]&year=$matches[2]&embed=true\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:36:\"(es)/([0-9]{4})/page/?([0-9]{1,})/?$\";s:61:\"index.php?lang=$matches[1]&year=$matches[2]&paged=$matches[3]\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:18:\"(es)/([0-9]{4})/?$\";s:43:\"index.php?lang=$matches[1]&year=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:58:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:68:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:88:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:64:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:53:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$\";s:91:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$\";s:85:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1\";s:77:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]\";s:61:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]\";s:47:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:57:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:77:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:53:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]\";s:38:\"([0-9]{4})/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&cpage=$matches[2]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";}','yes'),(338,'clean-up-optimizer-admin-email','cms@cms.loc','yes'),(342,'category_children','a:0:{}','yes'),(344,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.4.1.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-5.4.1.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-5.4.1-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-5.4.1-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"5.4.1\";s:7:\"version\";s:5:\"5.4.1\";s:11:\"php_version\";s:6:\"5.6.20\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"5.3\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1588350116;s:15:\"version_checked\";s:5:\"5.4.1\";s:12:\"translations\";a:0:{}}','no'),(348,'_site_transient_update_themes','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1588350117;s:7:\"checked\";a:1:{s:12:\"twentytwenty\";s:3:\"1.2\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}}','no'),(354,'aDBc_settings','a:5:{s:9:\"left_menu\";s:1:\"1\";s:16:\"menu_under_tools\";s:1:\"1\";s:14:\"plugin_version\";s:5:\"3.0.0\";s:12:\"installed_on\";s:10:\"2020/04/28\";s:9:\"keep_last\";a:1:{s:8:\"revision\";i:0;}}','no'),(356,'_site_transient_timeout_cerber_daily_1','1588522915','no'),(357,'_site_transient_cerber_daily_1','a:2:{i:0;i:1588350114;i:1;i:1588350115;}','no'),(361,'_site_transient_timeout_browser_f4b0e0f62d28d45e22100cecb7e768f8','1588707087','no'),(362,'_site_transient_browser_f4b0e0f62d28d45e22100cecb7e768f8','a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:13:\"81.0.4044.122\";s:8:\"platform\";s:9:\"Macintosh\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','no'),(363,'_site_transient_timeout_php_check_09a2ad9330cccb8a83c2e6443b87150f','1588707088','no'),(364,'_site_transient_php_check_09a2ad9330cccb8a83c2e6443b87150f','a:5:{s:19:\"recommended_version\";s:3:\"7.3\";s:15:\"minimum_version\";s:6:\"5.6.20\";s:12:\"is_supported\";b:1;s:9:\"is_secure\";b:1;s:13:\"is_acceptable\";b:1;}','no'),(445,'_site_transient_update_plugins','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1588350117;s:7:\"checked\";a:8:{s:30:\"advanced-custom-fields/acf.php\";s:5:\"5.8.9\";s:49:\"advanced-database-cleaner/advanced-db-cleaner.php\";s:5:\"3.0.0\";s:19:\"akismet/akismet.php\";s:5:\"4.1.5\";s:21:\"polylang/polylang.php\";s:5:\"2.7.2\";s:31:\"query-monitor/query-monitor.php\";s:5:\"3.5.2\";s:23:\"wp-cerber/wp-cerber.php\";s:5:\"8.6.3\";s:35:\"wp-fastest-cache/wpFastestCache.php\";s:7:\"0.9.0.5\";s:29:\"wp-mail-smtp/wp_mail_smtp.php\";s:5:\"2.0.0\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:8:{s:30:\"advanced-custom-fields/acf.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:36:\"w.org/plugins/advanced-custom-fields\";s:4:\"slug\";s:22:\"advanced-custom-fields\";s:6:\"plugin\";s:30:\"advanced-custom-fields/acf.php\";s:11:\"new_version\";s:5:\"5.8.9\";s:3:\"url\";s:53:\"https://wordpress.org/plugins/advanced-custom-fields/\";s:7:\"package\";s:71:\"https://downloads.wordpress.org/plugin/advanced-custom-fields.5.8.9.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:75:\"https://ps.w.org/advanced-custom-fields/assets/icon-256x256.png?rev=1082746\";s:2:\"1x\";s:75:\"https://ps.w.org/advanced-custom-fields/assets/icon-128x128.png?rev=1082746\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:78:\"https://ps.w.org/advanced-custom-fields/assets/banner-1544x500.jpg?rev=1729099\";s:2:\"1x\";s:77:\"https://ps.w.org/advanced-custom-fields/assets/banner-772x250.jpg?rev=1729102\";}s:11:\"banners_rtl\";a:0:{}}s:49:\"advanced-database-cleaner/advanced-db-cleaner.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:39:\"w.org/plugins/advanced-database-cleaner\";s:4:\"slug\";s:25:\"advanced-database-cleaner\";s:6:\"plugin\";s:49:\"advanced-database-cleaner/advanced-db-cleaner.php\";s:11:\"new_version\";s:5:\"3.0.0\";s:3:\"url\";s:56:\"https://wordpress.org/plugins/advanced-database-cleaner/\";s:7:\"package\";s:74:\"https://downloads.wordpress.org/plugin/advanced-database-cleaner.3.0.0.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:78:\"https://ps.w.org/advanced-database-cleaner/assets/icon-256x256.png?rev=1306117\";s:2:\"1x\";s:78:\"https://ps.w.org/advanced-database-cleaner/assets/icon-128x128.png?rev=1306117\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:80:\"https://ps.w.org/advanced-database-cleaner/assets/banner-772x250.png?rev=1630620\";}s:11:\"banners_rtl\";a:0:{}}s:19:\"akismet/akismet.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:21:\"w.org/plugins/akismet\";s:4:\"slug\";s:7:\"akismet\";s:6:\"plugin\";s:19:\"akismet/akismet.php\";s:11:\"new_version\";s:5:\"4.1.5\";s:3:\"url\";s:38:\"https://wordpress.org/plugins/akismet/\";s:7:\"package\";s:56:\"https://downloads.wordpress.org/plugin/akismet.4.1.5.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:59:\"https://ps.w.org/akismet/assets/icon-256x256.png?rev=969272\";s:2:\"1x\";s:59:\"https://ps.w.org/akismet/assets/icon-128x128.png?rev=969272\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:61:\"https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=479904\";}s:11:\"banners_rtl\";a:0:{}}s:21:\"polylang/polylang.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:22:\"w.org/plugins/polylang\";s:4:\"slug\";s:8:\"polylang\";s:6:\"plugin\";s:21:\"polylang/polylang.php\";s:11:\"new_version\";s:5:\"2.7.2\";s:3:\"url\";s:39:\"https://wordpress.org/plugins/polylang/\";s:7:\"package\";s:57:\"https://downloads.wordpress.org/plugin/polylang.2.7.2.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:61:\"https://ps.w.org/polylang/assets/icon-256x256.png?rev=1331499\";s:2:\"1x\";s:61:\"https://ps.w.org/polylang/assets/icon-128x128.png?rev=1331499\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:64:\"https://ps.w.org/polylang/assets/banner-1544x500.png?rev=1405299\";s:2:\"1x\";s:63:\"https://ps.w.org/polylang/assets/banner-772x250.png?rev=1405299\";}s:11:\"banners_rtl\";a:0:{}}s:31:\"query-monitor/query-monitor.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:27:\"w.org/plugins/query-monitor\";s:4:\"slug\";s:13:\"query-monitor\";s:6:\"plugin\";s:31:\"query-monitor/query-monitor.php\";s:11:\"new_version\";s:5:\"3.5.2\";s:3:\"url\";s:44:\"https://wordpress.org/plugins/query-monitor/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/plugin/query-monitor.3.5.2.zip\";s:5:\"icons\";a:3:{s:2:\"2x\";s:66:\"https://ps.w.org/query-monitor/assets/icon-256x256.png?rev=2056073\";s:2:\"1x\";s:58:\"https://ps.w.org/query-monitor/assets/icon.svg?rev=2056073\";s:3:\"svg\";s:58:\"https://ps.w.org/query-monitor/assets/icon.svg?rev=2056073\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/query-monitor/assets/banner-1544x500.png?rev=1629576\";s:2:\"1x\";s:68:\"https://ps.w.org/query-monitor/assets/banner-772x250.png?rev=1731469\";}s:11:\"banners_rtl\";a:0:{}}s:23:\"wp-cerber/wp-cerber.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:23:\"w.org/plugins/wp-cerber\";s:4:\"slug\";s:9:\"wp-cerber\";s:6:\"plugin\";s:23:\"wp-cerber/wp-cerber.php\";s:11:\"new_version\";s:5:\"8.6.3\";s:3:\"url\";s:40:\"https://wordpress.org/plugins/wp-cerber/\";s:7:\"package\";s:58:\"https://downloads.wordpress.org/plugin/wp-cerber.8.6.3.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:62:\"https://ps.w.org/wp-cerber/assets/icon-256x256.png?rev=1241659\";s:2:\"1x\";s:62:\"https://ps.w.org/wp-cerber/assets/icon-128x128.png?rev=1241659\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:64:\"https://ps.w.org/wp-cerber/assets/banner-772x250.jpg?rev=1237452\";}s:11:\"banners_rtl\";a:0:{}}s:35:\"wp-fastest-cache/wpFastestCache.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:30:\"w.org/plugins/wp-fastest-cache\";s:4:\"slug\";s:16:\"wp-fastest-cache\";s:6:\"plugin\";s:35:\"wp-fastest-cache/wpFastestCache.php\";s:11:\"new_version\";s:7:\"0.9.0.5\";s:3:\"url\";s:47:\"https://wordpress.org/plugins/wp-fastest-cache/\";s:7:\"package\";s:67:\"https://downloads.wordpress.org/plugin/wp-fastest-cache.0.9.0.5.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:69:\"https://ps.w.org/wp-fastest-cache/assets/icon-256x256.png?rev=2064586\";s:2:\"1x\";s:69:\"https://ps.w.org/wp-fastest-cache/assets/icon-128x128.png?rev=1068904\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:71:\"https://ps.w.org/wp-fastest-cache/assets/banner-772x250.jpg?rev=1064099\";}s:11:\"banners_rtl\";a:0:{}}s:29:\"wp-mail-smtp/wp_mail_smtp.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:26:\"w.org/plugins/wp-mail-smtp\";s:4:\"slug\";s:12:\"wp-mail-smtp\";s:6:\"plugin\";s:29:\"wp-mail-smtp/wp_mail_smtp.php\";s:11:\"new_version\";s:5:\"2.0.0\";s:3:\"url\";s:43:\"https://wordpress.org/plugins/wp-mail-smtp/\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/plugin/wp-mail-smtp.2.0.0.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:65:\"https://ps.w.org/wp-mail-smtp/assets/icon-256x256.png?rev=1755440\";s:2:\"1x\";s:65:\"https://ps.w.org/wp-mail-smtp/assets/icon-128x128.png?rev=1755440\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:68:\"https://ps.w.org/wp-mail-smtp/assets/banner-1544x500.png?rev=2120094\";s:2:\"1x\";s:67:\"https://ps.w.org/wp-mail-smtp/assets/banner-772x250.png?rev=2120094\";}s:11:\"banners_rtl\";a:0:{}}}}','no'),(448,'_site_transient_timeout_cerber_hourly_1','1588360313','no'),(449,'_site_transient_cerber_hourly_1','a:2:{i:0;i:1588353113;i:1;i:1588353113;}','no'),(450,'_site_transient_timeout_cerber_hourly_2','1588360313','no'),(451,'_site_transient_cerber_hourly_2','a:2:{i:0;i:1588353113;i:1;i:1588353113;}','no'),(456,'wp_mail_smtp_initial_version','2.0.0','no'),(457,'wp_mail_smtp_version','2.0.0','no'),(458,'wp_mail_smtp','a:8:{s:4:\"mail\";a:6:{s:10:\"from_email\";s:11:\"cms@cms.loc\";s:9:\"from_name\";s:9:\"WP Mailer\";s:6:\"mailer\";s:4:\"smtp\";s:11:\"return_path\";b:0;s:16:\"from_email_force\";b:0;s:15:\"from_name_force\";b:0;}s:4:\"smtp\";a:7:{s:7:\"autotls\";i:0;s:4:\"auth\";i:0;s:4:\"host\";s:2:\"mc\";s:10:\"encryption\";s:4:\"none\";s:4:\"port\";i:1025;s:4:\"user\";s:0:\"\";s:4:\"pass\";s:0:\"\";}s:7:\"smtpcom\";a:2:{s:7:\"api_key\";s:0:\"\";s:7:\"channel\";s:0:\"\";}s:11:\"pepipostapi\";a:1:{s:7:\"api_key\";s:0:\"\";}s:10:\"sendinblue\";a:1:{s:7:\"api_key\";s:0:\"\";}s:7:\"mailgun\";a:3:{s:7:\"api_key\";s:0:\"\";s:6:\"domain\";s:0:\"\";s:6:\"region\";s:2:\"US\";}s:8:\"sendgrid\";a:1:{s:7:\"api_key\";s:0:\"\";}s:5:\"gmail\";a:2:{s:9:\"client_id\";s:0:\"\";s:13:\"client_secret\";s:0:\"\";}}','no'),(460,'_transient_pll_languages_list','a:1:{i:0;a:26:{s:7:\"term_id\";i:2;s:4:\"name\";s:7:\"English\";s:4:\"slug\";s:2:\"en\";s:10:\"term_group\";i:0;s:16:\"term_taxonomy_id\";i:2;s:8:\"taxonomy\";s:8:\"language\";s:11:\"description\";s:5:\"en_US\";s:6:\"parent\";i:0;s:5:\"count\";i:2;s:10:\"tl_term_id\";i:3;s:19:\"tl_term_taxonomy_id\";i:3;s:8:\"tl_count\";i:1;s:6:\"locale\";R:9;s:6:\"is_rtl\";i:0;s:3:\"w3c\";s:5:\"en-US\";s:8:\"facebook\";s:5:\"en_US\";s:8:\"flag_url\";s:56:\"https://cms.loc/wp-content/plugins/polylang/flags/us.png\";s:4:\"flag\";s:901:\"<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAALCAIAAAD5gJpuAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHzSURBVHjaYkxOP8IAB//+Mfz7w8Dwi4HhP5CcJb/n/7evb16/APL/gRFQDiAAw3JuAgAIBEDQ/iswEERjGzBQLEru97ll0g0+3HvqMn1SpqlqGsZMsZsIe0SICA5gt5a/AGIEarCPtFh+6N/ffwxA9OvP/7//QYwff/6fZahmePeB4dNHhi+fGb59Y4zyvHHmCEAAAW3YDzQYaJJ93a+vX79aVf58//69fvEPlpIfnz59+vDhw7t37968efP3b/SXL59OnjwIEEAsDP+YgY53b2b89++/awvLn98MDi2cVxl+/vl6mituCtBghi9f/v/48e/XL86krj9XzwEEEENy8g6gu22rfn78+NGs5Ofr16+ZC58+fvyYwX8rxOxXr169fPny+fPn1//93bJlBUAAsQADZMEBxj9/GBxb2P/9+S/R8u3vzxuyaX8ZHv3j8/YGms3w8ycQARmi2eE37t4ACCDGR4/uSkrKAS35B3TT////wADOgLOBIaXIyjBlwxKAAGKRXjCB0SOEaeu+/y9fMnz4AHQxCP348R/o+l+//sMZQBNLEvif3AcIIMZbty7Ly6t9ZmXl+fXj/38GoHH/UcGfP79//BBiYHjy9+8/oUkNAAHEwt1V/vI/KBY/QSISFqM/GBg+MzB8A6PfYC5EFiDAABqgW776MP0rAAAAAElFTkSuQmCC\" title=\"English\" alt=\"English\" width=\"16\" height=\"11\" />\";s:8:\"home_url\";s:16:\"https://cms.loc/\";s:10:\"search_url\";s:16:\"https://cms.loc/\";s:4:\"host\";N;s:5:\"mo_id\";s:2:\"17\";s:13:\"page_on_front\";N;s:14:\"page_for_posts\";N;s:6:\"filter\";s:3:\"raw\";s:9:\"flag_code\";s:2:\"us\";}}','yes'),(461,'_transient_timeout_192-168-144-1','1588436971','no'),(462,'_transient_192-168-144-1','s:84:\"a:2:{s:8:\"hostname\";s:13:\"192.168.144.1\";s:13:\"hostname_html\";s:13:\"192.168.144.1\";}\";','no'),(463,'_transient_timeout_172-31-0-1','1588436992','no'),(464,'_transient_172-31-0-1','s:78:\"a:2:{s:8:\"hostname\";s:10:\"172.31.0.1\";s:13:\"hostname_html\";s:10:\"172.31.0.1\";}\";','no');
/*!40000 ALTER TABLE `xwp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_postmeta`
--

DROP TABLE IF EXISTS `xwp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_postmeta`
--

LOCK TABLES `xwp_postmeta` WRITE;
/*!40000 ALTER TABLE `xwp_postmeta` DISABLE KEYS */;
INSERT INTO `xwp_postmeta` VALUES (1,2,'_wp_page_template','default'),(30,17,'_pll_strings_translations','a:4:{i:0;a:2:{i:0;s:10:\"WP Project\";i:1;s:10:\"WP Project\";}i:1;a:2:{i:0;s:27:\"Just another WordPress site\";i:1;s:27:\"Just another WordPress site\";}i:2;a:2:{i:0;s:6:\"F j, Y\";i:1;s:6:\"F j, Y\";}i:3;a:2:{i:0;s:5:\"g:i a\";i:1;s:5:\"g:i a\";}}'),(31,18,'_pll_strings_translations','a:4:{i:0;a:2:{i:0;s:10:\"WP Project\";i:1;s:11:\"Proyecto WP\";}i:1;a:2:{i:0;s:27:\"Just another WordPress site\";i:1;s:27:\"Just another WordPress site\";}i:2;a:2:{i:0;s:6:\"F j, Y\";i:1;s:6:\"F j, Y\";}i:3;a:2:{i:0;s:5:\"g:i a\";i:1;s:5:\"g:i a\";}}');
/*!40000 ALTER TABLE `xwp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_posts`
--

DROP TABLE IF EXISTS `xwp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_posts`
--

LOCK TABLES `xwp_posts` WRITE;
/*!40000 ALTER TABLE `xwp_posts` DISABLE KEYS */;
INSERT INTO `xwp_posts` VALUES (1,1,'2020-04-27 16:12:51','2020-04-27 16:12:51','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2020-04-27 16:12:51','2020-04-27 16:12:51','',0,'http://cms.loc/?p=1',0,'post','',0),(2,1,'2020-04-27 16:12:51','2020-04-27 16:12:51','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://cms.loc/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','publish','closed','open','','sample-page','','','2020-04-27 16:12:51','2020-04-27 16:12:51','',0,'http://cms.loc/?page_id=2',0,'page','',0),(17,1,'2020-04-27 15:28:47','2020-04-27 21:28:47','','polylang_mo_2','','private','closed','closed','','polylang_mo_2','','','2020-04-27 15:28:47','2020-04-27 21:28:47','',0,'https://cms.loc/?post_type=polylang_mo&p=17',0,'polylang_mo','',0),(18,1,'2020-04-27 15:28:47','2020-04-27 21:28:47','','polylang_mo_5','','private','closed','closed','','polylang_mo_5','','','2020-04-27 15:28:47','2020-04-27 21:28:47','',0,'https://cms.loc/?post_type=polylang_mo&p=18',0,'polylang_mo','',0);
/*!40000 ALTER TABLE `xwp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_term_relationships`
--

DROP TABLE IF EXISTS `xwp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_term_relationships`
--

LOCK TABLES `xwp_term_relationships` WRITE;
/*!40000 ALTER TABLE `xwp_term_relationships` DISABLE KEYS */;
INSERT INTO `xwp_term_relationships` VALUES (1,1,0),(1,2,0),(1,3,0),(1,4,0),(2,2,0),(19,2,0),(20,2,0),(21,2,0),(22,2,0);
/*!40000 ALTER TABLE `xwp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_term_taxonomy`
--

DROP TABLE IF EXISTS `xwp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_term_taxonomy`
--

LOCK TABLES `xwp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `xwp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `xwp_term_taxonomy` VALUES (1,1,'category','',0,1),(2,2,'language','a:3:{s:6:\"locale\";s:5:\"en_US\";s:3:\"rtl\";i:0;s:9:\"flag_code\";s:2:\"us\";}',0,2),(3,3,'term_language','',0,1),(4,4,'term_translations','a:2:{s:2:\"en\";i:1;s:2:\"es\";i:7;}',0,1);
/*!40000 ALTER TABLE `xwp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_termmeta`
--

DROP TABLE IF EXISTS `xwp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_termmeta`
--

LOCK TABLES `xwp_termmeta` WRITE;
/*!40000 ALTER TABLE `xwp_termmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `xwp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_terms`
--

DROP TABLE IF EXISTS `xwp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_terms`
--

LOCK TABLES `xwp_terms` WRITE;
/*!40000 ALTER TABLE `xwp_terms` DISABLE KEYS */;
INSERT INTO `xwp_terms` VALUES (1,'Uncategorized','uncategorized',0),(2,'English','en',0),(3,'English','pll_en',0),(4,'pll_5ea74e8f5a90b','pll_5ea74e8f5a90b',0);
/*!40000 ALTER TABLE `xwp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_usermeta`
--

DROP TABLE IF EXISTS `xwp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_usermeta`
--

LOCK TABLES `xwp_usermeta` WRITE;
/*!40000 ALTER TABLE `xwp_usermeta` DISABLE KEYS */;
INSERT INTO `xwp_usermeta` VALUES (1,1,'nickname','cms'),(2,1,'first_name',''),(3,1,'last_name',''),(4,1,'description',''),(5,1,'rich_editing','true'),(6,1,'syntax_highlighting','true'),(7,1,'comment_shortcuts','false'),(8,1,'admin_color','fresh'),(9,1,'use_ssl','0'),(10,1,'show_admin_bar_front','true'),(11,1,'locale',''),(12,1,'xwp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),(13,1,'xwp_user_level','10'),(14,1,'dismissed_wp_pointers','lingotek-professional-translation,lingotek-translation'),(15,1,'show_welcome_panel','1'),(17,1,'xwp_user-settings','libraryContent=browse&editor=html&hidetb=1'),(18,1,'xwp_user-settings-time','1588003978'),(19,1,'xwp_dashboard_quick_press_last_post_id','22'),(20,1,'community-events-location','a:1:{s:2:\"ip\";s:13:\"192.168.144.0\";}'),(21,1,'wp_limit_login_nag_ignore','true'),(22,1,'closedpostboxes_dashboard','a:0:{}'),(23,1,'metaboxhidden_dashboard','a:1:{i:0;s:17:\"dashboard_primary\";}'),(24,1,'session_tokens','a:1:{s:64:\"831dee462f6ef9eb686e92833df5ad480342c3c3007fb06d9eadefc7c6a0cfa6\";a:4:{s:10:\"expiration\";i:1588523300;s:2:\"ip\";s:13:\"192.168.144.1\";s:2:\"ua\";s:121:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36\";s:5:\"login\";i:1588350500;}}');
/*!40000 ALTER TABLE `xwp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xwp_users`
--

DROP TABLE IF EXISTS `xwp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xwp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xwp_users`
--

LOCK TABLES `xwp_users` WRITE;
/*!40000 ALTER TABLE `xwp_users` DISABLE KEYS */;
INSERT INTO `xwp_users` VALUES (1,'cms','$P$BrVHtIlH1NXXZxhubrFsgxN/t8I.nO.','cms','cms@cms.loc','http://cms.loc','2020-04-27 16:12:51','',0,'cms');
/*!40000 ALTER TABLE `xwp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-01 17:12:30
