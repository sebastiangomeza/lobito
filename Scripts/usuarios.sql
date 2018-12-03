
-- Estructura de tabla para la tabla `usuarios`
--
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL auto_increment,
  `cedula` varchar(45) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` int(10) NOT NULL,
  `rol` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) 

-- estructura de tabla para la tabla 'programas'
--
CREATE TABLE PROGRAMAS
		(CODFAC     int(5),
		CCOSTO      int(8),
		PROGRAMA  	int(5) PRIMARY KEY,
	    COD_SNIES	int(21),
	    NOMBREP    	varchar(60),
	    ESTADO    	varchar(4),
	    TIPO_PROG   varchar(8),
	    METODOL     varchar(3),
	    TIPO_ENSE	varchar(15),
	    TIPO_PER    varchar(8),     
	    NRO_SEMES   int(2),
	    CREDITOS_G  int(3),
	    IND_ZONAL   varchar(1),
	    SEDE_PPAL	varchar(8),
	    IND_ACRED   varchar(1),
	    FECHA_ACRE  Date,
	    REG_CALIF   varchar(55),
	    VERSION_VI  varchar(2),
	    TOPE_CRED   int(3),
	    SEM_INIC  	varchar(5),
	    SEM_FINAL	varchar(5),
	    AREA_CONOC	varchar(1),
	    TIPO_TITUL  varchar(11),
	    TITULO      varchar(110),
	    COD_ICFES	varchar(21),
	    NOM_JEFE    varchar(40),
	    TEL_JEFE    varchar(20),
	    EMAIL_JEFE  varchar(100),
	    DESC_PROG   Memo,
	    MISION      Memo,
	    PERFIL_ASP  Memo,
	    PERFIL_EGR  Memo)   

  -- estructura de tabla para la tabla 'facultades'
      CREATE TABLE FACULTADES;
		(CODFAC     C(2) PRIMARY KEY,;
		CCOSTO      C(8) ,;
	    NOMBREF    	C(62),;
	    NOMBRECOR   C(40),;
	    AREA     	C(50))

  -- estructura de tabla para la tabla 'centro de costo'

CREATE TABLE CENCOS;
		(CCOSTO      C(8) PRIMARY KEY,;
		CODFAC       C(2),;
	    NOMBREC    	 C(100),;
	    CCOSTOANT    C(4),;
	    NOMBREC    	 C(100))

  -- estructura de tabla para la tabla 'tipo inscripcion  '
CREATE TABLE TIPO_INSCRIPCION;
		 (TIPO_INSCR	C(8) PRIMARY KEY,;
		 DESCRIPCION	C(100))     
  -- estructura de tabla para la tabla 'tipo aceptacion '

CREATE TABLE TIPO_ACEPTACION;
		 (TIPO_ACEPT	C(8) PRIMARY KEY,;
		 DESCRIPCION	C(100)) 

  -- estructura de tabla para la tabla 'tipo admitidos '
  CREATE TABLE ADMITIDOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE	 	 C(5),;
		 ADMITIDOS	NUMBER(3),;
		 CODFAC		     C(2),
   PRIMARY KEY (PROGRAMA, SEMESTRE))  

-- estructura de tabla para la tabla 'tipo admitidos desagregados  '

CREATE ADMITIDOS_DES;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 tipo_acept		 c(8),;
		 ADMITIDOS	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE)) 

-- estructura de tabla para la tabla 'cupos '

CREATE TABLE CUPOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 CUPOS		NUMBER(3),;
		 CODFAC          C(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'cupos desagregados '

CREATE TABLE CUPOS_DES;
		 (PROGRAMA		C(5),;
		 SEMESTRE		C(5),;
		 TIPO_INSCR		C(8),;
		 CUPOS		NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'inscritos'
CREATE TABLE INSCRITOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 INSCRITOS	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'inscritos desagregados'

CREATE TABLE INSCRITOS_DES;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 TIPO_INSCR		 C(8),;
		 INSCRITOS	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'cortes de examen'

CREATE CORTES;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 CORTE   	NUMBER(6,2),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'promedios de examen'

CREATE TABLE PROMEDIOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 PROMEDIO  	NUMBER(6,2),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados'

CREATE TABLE MATRICULADOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 MATRICULAD	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados * estrato'
CREATE TABLE MATRIC_X_ESTRATO;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 ESTRATO         C(1),;
		 MATRICULAD	NUMBER(5),;
		 CODFAC          C(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE , ESTRATO))

-- estructura de tabla para la tabla 'matriculados estrato'

CREATE TABLE MATRIC_ESTRATO;
		 (PROGRAMA	      C(5),;
		 SEMESTRE	      C(5),;
		 ESTRATO1  NUMBER (4),;
		 ESTRATO2  NUMBER (4),;
		 ESTRATO3  NUMBER (4),;
		 ESTRATO4  NUMBER (4),;
		 ESTRATO5  NUMBER (4),;
		 ESTRATO6  NUMBER (4),;
		 CODFAC           C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados 1er semestre '

CREATE TABLE MATRIC_1ER;
		 (PROGRAMA	 C(5),;
		 SEMESTRE		 C(5),;
		 MATRICULAD	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'graduados'

CREATE TABLE GRADUADOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 GRADUADOS	NUMBER(3),;
		 prom_stres number(4,1);
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'graduados duracion'
CREATE TABLE GRADUADOS_DURACION;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 NRO_STRES  NUMBER(2),;
		 GRADUADOS	NUMBER(4),;
		 CODFAC          C(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'retirados'

CREATE TABLE RETIRADOS;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 RETIRADOS	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'insuficientes'
CREATE TABLE INSUFICIENTES;
		 (PROGRAMA		 C(5),;
		 SEMESTRE		 C(5),;
		 INSUFICIEN	NUMBER(3),;
		 CODFAC          C(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'pensums vigentes'

CREATE TABLE PENSUM;
		 (CODFAC	    C(2),;
		 PROGRAMA		C(5),;
		 VERSION	    C(2),;
		 CONCEC	        C(2),;
		 MATERIA	    C(7),;
		 NOMBRE_MAT     C(60),;
		 NIVEL	 		C(2),;
		 PRERR_CRED     NUMBER(3),;
		 IND_DESTREZA   C(1),;
		 NRO_SNAS       NUMBER(2),;
		 HORAS_TEO	    NUMBER(3),;
		 HORAS_PRAC     NUMBER(3),;
		 HORAS_TEOPRA   NUMBER(3),;
		 HORAS_ESPEC    NUMBER(3),;
		 CREDITOS       NUMBER(2),;
		 COMENTARIO     C(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'pensums no vigentes'

CREATE TABLE PENSUM_NO_VIG;
		 (CODFAC	    C(2),;
		 PROGRAMA		C(5),;
		 VERSION	    C(2),;
		 CONCEC	        C(2),;
		 MATERIA	    C(7),;
		 NOMBRE_MAT     C(60),;
		 NIVEL	 		C(2),;
		 PRERR_CRED     NUMBER(3),;
		 IND_DESTREZA   C(1),;
		 NRO_SNAS       NUMBER(2),;
		 HORAS_TEO	    NUMBER(3),;
		 HORAS_PRAC     NUMBER(3),;
		 HORAS_TEOPRA   NUMBER(3),;
		 HORAS_ESPEC    NUMBER(3),;
		 CREDITOS       NUMBER(2),;
		 COMENTARIO     C(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'electivas de versiones vigentes'
CREATE TABLE ELECTIVAS;
		 (CODFAC	    C(2),;
		 PROGRAMA		C(5),;
		 VERSION	    C(2),;
		 CONCEC	        C(2),;
		 MATERIA	    C(7),;
		 NOMBRE_MAT     C(60),;
		 BANCO	 		C(35),;
		 CREDITOS       NUMBER(2),;
		 ESTADO			C(8),;
		 COMENTARIO     C(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'electivas de versiones no vigentes'

CREATE TABLE ELECTIVAS_NO_VIG;
		 (CODFAC	    C(2),;
		 PROGRAMA		C(5),;
		 VERSION	    C(2),;
		 CONCEC	        C(2),;
		 MATERIA	    C(7),;
		 NOMBRE_MAT     C(60),;
		 BANCO	 		C(35),;
		 CREDITOS       NUMBER(2),;
		 ESTADO			C(8),;
		 COMENTARIO     C(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'desercion  por cohorte'
CREATE TABLE ADMITIDOS_EST;
		 (COHORTE	     C(5),;
		  STRE_INI		 C(5),;
		  STRE_FIN        C(5),;
		  PROGRAMA		 C(5),;
		  CEDULA		 C(11),;
		  ESTADO		 C(20),;
		  SEXO			 C(1),;
		  A�O_NAC		 C(4),;
		  ESTRATO		 C(1),;
		  STRE_CORTE	 C(5),;
		  DESER_TEMP 	 C(1),;
		  CODFAC         C(2),      
     PRIMARY KEY (PROGRAMA,CEDULA,COHORTE))  

-- estructura de tabla para la tabla 'admitidos graduados'

CREATE TABLE ADMITIDOS_GRAD
		 (COHORTE	     C(5),;
		  PROGRAMA		 C(5),;
		  CEDULA		 C(11),;
		  TIPOACEPT	     C(8),;
		  OPCION		 C(1),;
		  STRE_GRADO	 C(5),;
		  NOHIZOUSO		 C(1),;
		  DESER_TEMP	 C(1),;
		  ESTADO		 C(20),;
		  STRE_INI		 C(5),;
		  STRE_FIN       C(5),;
		  stre_corte	 c(5),;
		  Stres_c_u		 n(3),;
		  Stres_c_g		 n(3),;
		  grad_alcor	 c(1),;
		  sexo			 c(1),;
		  a�o_nac		 c(4),;
		  estrato		 c(1),;
		  CODFAC         C(2),
      PRIMARY KEY (PROGRAMA,CEDULA,COHORTE))

-- estructura de tabla para la tabla 'desercion'

CREATE TABLE DESERCION;
		 (PROGRAMA		 C(5),;
		  COHORTE	     C(5),;
		  STRE_CORTE	 C(5),;
		  ADMITIDOS	     N(3),;
		  ACTIVOS	     N(3),;
		  CANCELOSEM     N(3),;
		  DESERTORES	 N(3),;
		  GRADUADOS		 N(3),;
		  PRECOCES   	 N(3),;
		  TEMPRANOS      N(3),;
		  TERMINOMAT   	 N(3),;
		  P_ACTIVOS	     N(6,3),;
  		  P_CANCELOS     N(6,3),;
		  P_DESERTOR	 N(6,3),;
		  P_GRADUADO	 N(6,3),;
		  P_PRECOCES   	 N(6,3),;
		  P_TEMPRANO     N(6,3),;
		  P_TERMINOM   	 N(6,3),;
		  CODFAC         C(2),;
      PRIMARY KEY (PROGRAMA,COHORTE))

-- estructura de tabla para la tabla 'desercion por periodo'

CREATE TABLE DESERTORES;
		 (PROGRAMA		 C(5),;
		  STRE_FINAL     C(5),;
		  CEDULA		 C(11),;
		  ESTADOALUM     C(11),;
		  SEXO			 C(1),;
		  ANO_NAC		 C(4),;
		  ESTRATO		 C(1),;
		  CODFAC         C(2),;
		  STRE_DESER     C(5),
      PRIMARY KEY (PROGRAMA,CEDULA,STRE_DESER))

-- estructura de tabla para la tabla 'desercion per'

CREATE TABLE DESERCION_PER;
		 (PROGRAMA		 C(5),;
		  SEMESTRE		 C(5),;
		  MATRICULAD	 N(4),;
		  DESERTORES	 N(3),;
		  p_DESERCIO     N(6,3),;
		  P_RETENCIO     N(6,3),;
		  CODFAC         C(2),;
		  IND_REG		 C(1),;
		   PRIMARY KEY (PROGRAMA,SEMESTRE))

-- estructura de tabla para la tabla 'profesores de catedra'
CREATE TABLE COCA; 
		 (SEMESTRE	 C(5),;
		 CEDULA		 C(11),;
		 NOMBRE		 C(53),;
		 SEXO		 C(1),;
		 CODFAC		 C(2),;
		 CCOSTO		 C(8),;
		 claseemple	 C(5),;
		 categoria	 C(5),;
		 NIVELACAD	 C(10),;
		 ACTIVIDAD	 C(5),;
		 PRIM_APELL	 C(15),;
		 SDO_APELL	 C(15),;
		 NOMBRES	 C(30),;
		 HORAS		NUMBER(4),;
		 RESERVA	NUMBER(12,2),
     PRIMARY KEY (CEDULA,SEMESTRE))

-- estructura de tabla para la tabla 'produccion'

CREATE TABLE PRODUCCION; 
		 (CEDULA					C(11),;
		 FECHA_VIG                  DATE,;
		 COD_PROD	                NUMBER(7),;
		 PROTITULO1                 C(110),;
		 PROTITULO2                 C(110),;
		 PROTITULO3                 C(110),;
		 MATERIAL					C(50),;
		 TIPOCONCEP	                C(2),;
		 PTOS			            NUMBER(7,3),;
		 PAIS_PROD                  C(4),;
		 COD_REV_PR  	            C(10),;
		 NOM_REV_PR					C(100),;
		 PAI_REV_PR                 C(4),;
		 ISSN_REV					C(20),;
		 EDIT_REV					C(60),;
		 ENTIDAD_PR					C(100),;
		 IDIOMA						C(5),;
		 SEMESTRE					C(5),;
		 CODFAC						C(2),;
		 CCOSTO						C(8),;
		 VINCULA					C(2),;
		 NIVELACAD					C(10),;
		 COD_MATER					C(10),;
		 CATEG_MATE					C(20),;
		 TIPO_MATER					C(22),;
		 CAT_MIN					C(13),;
		 CAT_OBS					C(13),
      PRIMARY KEY (CEDULA,COD_PROD))

-- estructura de tabla para la tabla 'produccion de catedras'

CREATE TABLE PRODUCCION_CAT; 
		 (CEDULA					C(11),;
		 FECHA_VIG                  DATE,;
		 COD_PROD	                NUMBER(7),;
		 PROTITULO1                 C(110),;
		 PROTITULO2                 C(110),;
		 PROTITULO3                 C(110),;
		 MATERIAL					C(50),;
		 TIPOCONCEP	                C(2),;
		 PTOS			            NUMBER(7,3),;
		 PAIS_PROD                  C(4),;
		 COD_REV_PR  	            C(10),;
		 NOM_REV_PR					C(100),;
		 PAI_REV_PR                 C(4),;
		 ISSN_REV					C(20),;
		 EDIT_REV					C(60),;
		 ENTIDAD_PR					C(100),;
		 IDIOMA						C(5),;
		 SEMESTRE					C(5),;
		 CODFAC						C(2),;
		 CCOSTO						C(8),;
		 VINCULA					C(2),;
		 NIVELACAD					C(10),;
		 COD_MATER					C(10),;
		 CATEG_MATE					C(20),;
		 TIPO_MATER					C(22),;
		 CAT_MIN					C(13),;
		 CAT_OBS					C(13),
     PRIMARY KEY (CEDULA,COD_PROD))


-- estructura de tabla para la tabla 'titulos'
CREATE TABLE TITULOS; 
		 (CEDULA				C(11),;
		 TIPOPROG				C(5),;
		 FECHA_VIG              DATE,;
		 FECHA_GRAD				DATE,;
		 COD_PROG				C(8),;
		 NOMBRE_PROG            C(100),;
		 COD_INST               C(15),;
		 INSTITUCION            C(100),;
		 PAIS                   C(4),
     PRIMARY KEY (CEDULA,COD_PROD,COD_INST,FECHA_GRAD))

-- estructura de tabla para la tabla 'titulos catedra'

CREATE TABLE TITULOS_CAT; 
		 (CEDULA				C(11),;
		 TIPOPROG				C(5),;
		 FECHA_VIG              DATE,;
		 FECHA_GRAD				DATE,;
		 COD_PROG				C(8),;
		 NOMBRE_PROG            C(100),;
		 COD_INST               C(15),;
		 INSTITUCION            C(100),;
		 PAIS                   C(4),
     PRIMARY KEY (CEDULA,COD_PROD,COD_INST,FECHA_GRAD))

-- estructura de tabla para la tabla 'profesores regulares y ocasionales'

CREATE TABLE PROFESORES;
		 (SEMESTRE		C(5),;
		 CODFAC			C(2),;
		 CCOSTO			C(8),;
		 CEDULA			C(11),;
		 NOMBRE			C(50),;
		 VINCULA		C(2),;
		 DEDICACION	number(5,3),;
		 fecha_vin		date,;
		 fecha_finv		date,;
		 fecha_nac		date,;
		 sexo			C(1),;
		 NIVELACAD		C(10),;
		 CATEGORIA		C(10),;
		 CLASE_EMP		C(5),;
		 FAC_ACTUAL		C(2),;
		 CCO_ACTUAL		C(4),;
		 HORAS_VIN		C(3),;
		 TIPO_DOC	    C(2),;
		 NOMBRES		C(30),;
		 PRIM_APELL		C(15),;
		 SDO_APELL		C(15),
     PRIMARY KEY (CEDULA,SEMESTRE))




























































