-- phpMyAdmin SQL Dump
-- version 3.3.7deb3
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 03-12-2018 a las 13:27:48
-- Versión del servidor: 5.0.51
-- Versión de PHP: 5.3.3-7+squeeze29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `dbDedo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL auto_increment,
  `cedula` varchar(45) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `clave` varchar(45) NOT NULL,
  `rol` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=52 ;

--
-- Volcar la base de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `cedula`, `nombre`, `clave`, `rol`) VALUES
(1, 'carlos.congote', 'secrededo', 'secrededo', 'auxiliar'),
(21, '43839488', '15', '', 'unidad'),
(3, 'admindedo', 'admindedo', 'admindedo', 'auxiliar'),
(42, '71266740', 'secrededo', '', 'auxiliar'),
(5, '8127994', 'docente', 'docente', 'docente'),
(20, '71645226', '2', '', 'unidad'),
(6, 'r.profesoral', 'Representante Profesoral', 'n4dr2', 'comite*'),
(7, 'r.consejo', 'Representante del Consejo Académico', 'mt4z2', 'comite*'),
(8, 'r.talentoh', 'Representante de Talento Humano', 'y49d2', 'comite*'),
(9, 'presidente', 'Presidente del Comité', 'om2ak', 'comite*'),
(22, '43740745', '3', '', 'unidad'),
(23, '36163016', '40', '', 'unidad'),
(24, '32512547', '9', '', 'unidad'),
(25, '43666374', '12', '', 'unidad'),
(26, '43506067', '10', '', 'unidad'),
(27, '43575352', '20', '', 'unidad'),
(28, '98629787', '75', '', 'unidad'),
(29, '43026945', '60', '', 'unidad'),
(30, '71279066', '14', '', 'unidad'),
(31, '43826514', '13', '', 'unidad'),
(32, '71705809', '25', '', 'unidad'),
(33, '43024961', '55', '', 'unidad'),
(34, '8029836', '30', '', 'unidad'),
(35, '32522696', '45', '', 'unidad'),
(36, '43081056', '70', '', 'unidad'),
(37, '43724327', '80', '', 'unidad'),
(38, '91231876', '35', '', 'unidad'),
(39, '71905037', '11', '', 'unidad'),
(40, '15511345', '16', '', 'unidad'),
(41, '98579302', '50', '', 'unidad'),
(43, '43627089', 'Representante de Talento Humano', '', 'comite'),
(44, '43743580', 'Representante del Consejo Académico', '', 'comite'),
(49, '42825417', 'spatricia.monsalve', '', 'auxiliar'),
(50, '1046912393', 'Maria Isabel', '123', 'auxiliar'),
(47, '8296311', 'Representante Profesoral', '', 'comite'),
(48, '--42876784', 'Presidente del Comité', '', 'comite*'),
(51, '42876784', 'Presidente del Comité', '', 'comite');
