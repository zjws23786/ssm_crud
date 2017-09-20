/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : ssm_crud

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-09-20 18:09:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_dept
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_emp
-- ----------------------------
DROP TABLE IF EXISTS `tbl_emp`;
CREATE TABLE `tbl_emp` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(255) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `deptId` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `fk_emp_dept` (`deptId`),
  CONSTRAINT `fk_emp_dept` FOREIGN KEY (`deptId`) REFERENCES `tbl_dept` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_emp
-- ----------------------------
