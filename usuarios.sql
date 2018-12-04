
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
		(CODFAC     varchar(5),
		CCOSTO      varchar(8),
		PROGRAMA  	varchar(5) PRIMARY KEY,
	    COD_SNIES	varchar0(21),
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
	    DESC_PROG   varchar(2000),
	    MISION      varchar(2000),
	    PERFIL_ASP  varchar(2000),
	    PERFIL_EGR  varchar(2000))   

  -- estructura de tabla para la tabla 'facultades'
      CREATE TABLE FACULTADES;
		(CODFAC     varchar(2) PRIMARY KEY,
		CCOSTO      varchar(8) ,
	    NOMBREF    	varchar(62),
	    NOMBRECOR   varchar(40),
	    AREA     	varchar(50))

  -- estructura de tabla para la tabla 'centro de costo'

CREATE TABLE CENCOS;
		(CCOSTO      varchar(8) PRIMARY KEY,
		CODFAC       varchar(2),
	    NOMBREC    	 varchar(100),
	    CCOSTOANT    varchar(4),
	    NOMBREC    	 varchar(100))

  -- estructura de tabla para la tabla 'tipo inscripcion  '
CREATE TABLE TIPO_INSCRIPCION;
		 (TIPO_INSCR	varchar(8) PRIMARY KEY,
		 DESCRIPCION	varchar(100))     
  -- estructura de tabla para la tabla 'tipo aceptacion '

CREATE TABLE TIPO_ACEPTACION;
		 (TIPO_ACEPT	varchar(8) PRIMARY KEY,
		 DESCRIPCION	varchar(100)) 

  -- estructura de tabla para la tabla 'tipo admitidos '
  CREATE TABLE ADMITIDOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE	 	 varchar(5),
		 ADMITIDOS	int(3),
		 CODFAC		     varchar(2),
   PRIMARY KEY (PROGRAMA, SEMESTRE))  

-- estructura de tabla para la tabla 'tipo admitidos desagregados  '

CREATE ADMITIDOS_DES;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 tipo_acept		 varchar(8),
		 ADMITIDOS	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE)) 

-- estructura de tabla para la tabla 'cupos '

CREATE TABLE CUPOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 CUPOS		int(3),
		 CODFAC          varchar(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'cupos desagregados '

CREATE TABLE CUPOS_DES;
		 (PROGRAMA		varchar(5),
		 SEMESTRE		varchar(5),
		 TIPO_INSCR		varchar(8),
		 CUPOS		int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'inscritos'
CREATE TABLE INSCRITOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 INSCRITOS	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'inscritos desagregados'

CREATE TABLE INSCRITOS_DES;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 TIPO_INSCR		 varchar(8),
		 INSCRITOS	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'cortes de examen'

CREATE CORTES;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 CORTE   	float(6,2),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'promedios de examen'

CREATE TABLE PROMEDIOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 PROMEDIO  	float(6,2),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados'

CREATE TABLE MATRICULADOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 MATRICULAD	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados * estrato'
CREATE TABLE MATRIC_X_ESTRATO;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 ESTRATO         varchar(1),
		 MATRICULAD	int(5),
		 CODFAC          varchar(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE , ESTRATO))

-- estructura de tabla para la tabla 'matriculados estrato'

CREATE TABLE MATRIC_ESTRATO;
		 (PROGRAMA	      varchar(5),
		 SEMESTRE	      varchar(5),
		 ESTRATO1  int (4),
		 ESTRATO2  int (4),
		 ESTRATO3  int (4),
		 ESTRATO4  int (4),
		 ESTRATO5  int (4),
		 ESTRATO6  int (4),
		 CODFAC           varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'matriculados 1er semestre '

CREATE TABLE MATRIC_1ER;
		 (PROGRAMA	 varchar(5),
		 SEMESTRE		 varchar(5),
		 MATRICULAD	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'graduados'

CREATE TABLE GRADUADOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 GRADUADOS	int(3),
		 prom_stres float(4,1);
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'graduados duracion'
CREATE TABLE GRADUADOS_DURACION;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 NRO_STRES  int(2),
		 GRADUADOS	int(4),
		 CODFAC          varchar(2),
    PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'retirados'

CREATE TABLE RETIRADOS;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 RETIRADOS	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'insuficientes'
CREATE TABLE INSUFICIENTES;
		 (PROGRAMA		 varchar(5),
		 SEMESTRE		 varchar(5),
		 INSUFICIEN	int(3),
		 CODFAC          varchar(2),
     PRIMARY KEY (PROGRAMA, SEMESTRE))

-- estructura de tabla para la tabla 'pensums vigentes'

CREATE TABLE PENSUM;
		 (CODFAC	    varchar(2),
		 PROGRAMA		varchar(5),
		 VERSION	    varchar(2),
		 CONCEC	        varchar(2),
		 MATERIA	    varchar(7),
		 NOMBRE_MAT     varchar(60),
		 NIVEL	 		varchar(2),
		 PRERR_CRED     int(3),
		 IND_DESTREZA   varchar(1),
		 NRO_SNAS       int(2),
		 HORAS_TEO	    int(3),
		 HORAS_PRAC     int(3),
		 HORAS_TEOPRA   int(3),
		 HORAS_ESPEC    int(3),
		 CREDITOS       int(2),
		 COMENTARIO     varchar(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'pensums no vigentes'

CREATE TABLE PENSUM_NO_VIG;
		 (CODFAC	    varchar(2),
		 PROGRAMA		varchar(5),
		 VERSION	    varchar(2),
		 CONCEC	        varchar(2),
		 MATERIA	    varchar(7),
		 NOMBRE_MAT     varchar(60),
		 NIVEL	 		varchar(2),
		 PRERR_CRED     int(3),
		 IND_DESTREZA   varchar(1),
		 NRO_SNAS       int(2),
		 HORAS_TEO	    int(3),
		 HORAS_PRAC     int(3),
		 HORAS_TEOPRA   int(3),
		 HORAS_ESPEC    int(3),
		 CREDITOS       int(2),
		 COMENTARIO     varchar(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'electivas de versiones vigentes'
CREATE TABLE ELECTIVAS;
		 (CODFAC	    varchar(2),
		 PROGRAMA		varchar(5),
		 VERSION	    varchar(2),
		 CONCEC	        varchar(2),
		 MATERIA	    varchar(7),
		 NOMBRE_MAT     varchar(60),
		 BANCO	 		varchar(35),
		 CREDITOS       int(2),
		 ESTADO			varchar(8),
		 COMENTARIO     varchar(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'electivas de versiones no vigentes'

CREATE TABLE ELECTIVAS_NO_VIG;
		 (CODFAC	    varchar(2),
		 PROGRAMA		varchar(5),
		 VERSION	    varchar(2),
		 CONCEC	        varchar(2),
		 MATERIA	    varchar(7),
		 NOMBRE_MAT     varchar(60),
		 BANCO	 		varchar(35),
		 CREDITOS       int(2),
		 ESTADO			varchar(8),
		 COMENTARIO     varchar(100),
     PRIMARY KEY (PROGRAMA, VERSION, MATERIA))

-- estructura de tabla para la tabla 'desercion  por cohorte'
CREATE TABLE ADMITIDOS_EST;
		 (COHORTE	     varchar(5),
		  STRE_INI		 varchar(5),
		  STRE_FIN        varchar(5),
		  PROGRAMA		 varchar(5),
		  CEDULA		 varchar(11),
		  ESTADO		 varchar(20),
		  SEXO			 varchar(1),
		  A�O_NAC		 varchar(4),
		  ESTRATO		 varchar(1),
		  STRE_CORTE	 varchar(5),
		  DESER_TEMP 	 varchar(1),
		  CODFAC         varchar(2),      
     PRIMARY KEY (PROGRAMA,CEDULA,COHORTE))  

-- estructura de tabla para la tabla 'admitidos graduados'

CREATE TABLE ADMITIDOS_GRAD
		 (COHORTE	     varchar(5),
		  PROGRAMA		 varchar(5),
		  CEDULA		 varchar(11),
		  TIPOACEPT	     varchar(8),
		  OPCION		 varchar(1),
		  STRE_GRADO	 varchar(5),
		  NOHIZOUSO		 varchar(1),
		  DESER_TEMP	 varchar(1),
		  ESTADO		 varchar(20),
		  STRE_INI		 varchar(5),
		  STRE_FIN       varchar(5),
		  stre_corte	 varchar(5),
		  Stres_c_u		 n(3),
		  Stres_c_g		 n(3),
		  grad_alcor	 varchar(1),
		  sexo			 varchar(1),
		  a�o_nac		 varchar(4),
		  estrato		 varchar(1),
		  CODFAC         varchar(2),
      PRIMARY KEY (PROGRAMA,CEDULA,COHORTE))

-- estructura de tabla para la tabla 'desercion'

CREATE TABLE DESERCION;
		 (PROGRAMA		 varchar(5),
		  COHORTE	     varchar(5),
		  STRE_CORTE	 varchar(5),
		  ADMITIDOS	     N(3),
		  ACTIVOS	     N(3),
		  CANCELOSEM     N(3),
		  DESERTORES	 N(3),
		  GRADUADOS		 N(3),
		  PRECOCES   	 N(3),
		  TEMPRANOS      N(3),
		  TERMINOMAT   	 N(3),
		  P_ACTIVOS	     N(6,3),
  		  P_CANCELOS     N(6,3),
		  P_DESERTOR	 N(6,3),
		  P_GRADUADO	 N(6,3),
		  P_PRECOCES   	 N(6,3),
		  P_TEMPRANO     N(6,3),
		  P_TERMINOM   	 N(6,3),
		  CODFAC         varchar(2),
      PRIMARY KEY (PROGRAMA,COHORTE))

-- estructura de tabla para la tabla 'desercion por periodo'

CREATE TABLE DESERTORES;
		 (PROGRAMA		 varchar(5),
		  STRE_FINAL     varchar(5),
		  CEDULA		 varchar(11),
		  ESTADOALUM     varchar(11),
		  SEXO			 varchar(1),
		  ANO_NAC		 varchar(4),
		  ESTRATO		 varchar(1),
		  CODFAC         varchar(2),
		  STRE_DESER     varchar(5),
      PRIMARY KEY (PROGRAMA,CEDULA,STRE_DESER))

-- estructura de tabla para la tabla 'desercion per'

CREATE TABLE DESERCION_PER;
		 (PROGRAMA		 varchar(5),
		  SEMESTRE		 varchar(5),
		  MATRICULAD	 N(4),
		  DESERTORES	 N(3),
		  p_DESERCIO     N(6,3),
		  P_RETENCIO     N(6,3),
		  CODFAC         varchar(2),
		  IND_REG		 varchar(1),
		   PRIMARY KEY (PROGRAMA,SEMESTRE))

-- estructura de tabla para la tabla 'profesores de catedra'
CREATE TABLE COCA; 
		 (SEMESTRE	 varchar(5),
		 CEDULA		 varchar(11),
		 NOMBRE		 varchar(53),
		 SEXO		 varchar(1),
		 CODFAC		 varchar(2),
		 CCOSTO		 varchar(8),
		 claseemple	 varchar(5),
		 categoria	 varchar(5),
		 NIVELACAD	 varchar(10),
		 ACTIVIDAD	 varchar(5),
		 PRIM_APELL	 varchar(15),
		 SDO_APELL	 varchar(15),
		 NOMBRES	 varchar(30),
		 HORAS		int(4),
		 RESERVA	float(12,2),
     PRIMARY KEY (CEDULA,SEMESTRE))

-- estructura de tabla para la tabla 'produccion'

CREATE TABLE PRODUCCION; 
		 (CEDULA					varchar(11),
		 FECHA_VIG                  DATE,
		 COD_PROD	                int(7),
		 PROTITULO1                 varchar(110),
		 PROTITULO2                 varchar(110),
		 PROTITULO3                 varchar(110),
		 MATERIAL					varchar(50),
		 TIPOCONCEP	                varchar(2),
		 PTOS			            float(7,3),
		 PAIS_PROD                  varchar(4),
		 COD_REV_PR  	            varchar(10),
		 NOM_REV_PR					varchar(100),
		 PAI_REV_PR                 varchar(4),
		 ISSN_REV					varchar(20),
		 EDIT_REV					varchar(60),
		 ENTIDAD_PR					varchar(100),
		 IDIOMA						varchar(5),
		 SEMESTRE					varchar(5),
		 CODFAC						varchar(2),
		 CCOSTO						varchar(8),
		 VINCULA					varchar(2),
		 NIVELACAD					varchar(10),
		 COD_MATER					varchar(10),
		 CATEG_MATE					varchar(20),
		 TIPO_MATER					varchar(22),
		 CAT_MIN					varchar(13),
		 CAT_OBS					varchar(13),
      PRIMARY KEY (CEDULA,COD_PROD))

-- estructura de tabla para la tabla 'produccion de catedras'

CREATE TABLE PRODUCCION_CAT; 
		 (CEDULA					varchar(11),
		 FECHA_VIG                  DATE,
		 COD_PROD	                int(7),
		 PROTITULO1                 varchar(110),
		 PROTITULO2                 varchar(110),
		 PROTITULO3                 varchar(110),
		 MATERIAL					varchar(50),
		 TIPOCONCEP	                varchar(2),
		 PTOS			            float(7,3),
		 PAIS_PROD                  varchar(4),
		 COD_REV_PR  	            varchar(10),
		 NOM_REV_PR					varchar(100),
		 PAI_REV_PR                 varchar(4),
		 ISSN_REV					varchar(20),
		 EDIT_REV					varchar(60),
		 ENTIDAD_PR					varchar(100),
		 IDIOMA						varchar(5),
		 SEMESTRE					varchar(5),
		 CODFAC						varchar(2),
		 CCOSTO						varchar(8),
		 VINCULA					varchar(2),
		 NIVELACAD					varchar(10),
		 COD_MATER					varchar(10),
		 CATEG_MATE					varchar(20),
		 TIPO_MATER					varchar(22),
		 CAT_MIN					varchar(13),
		 CAT_OBS					varchar(13),
     PRIMARY KEY (CEDULA,COD_PROD))


-- estructura de tabla para la tabla 'titulos'
CREATE TABLE TITULOS; 
		 (CEDULA				varchar(11),
		 TIPOPROG				varchar(5),
		 FECHA_VIG              DATE,
		 FECHA_GRAD				DATE,
		 COD_PROG				varchar(8),
		 NOMBRE_PROG            varchar(100),
		 COD_INST               varchar(15),
		 INSTITUCION            varchar(100),
		 PAIS                   varchar(4),
     PRIMARY KEY (CEDULA,COD_PROD,COD_INST,FECHA_GRAD))

-- estructura de tabla para la tabla 'titulos catedra'

CREATE TABLE TITULOS_CAT; 
		 (CEDULA				varchar(11),
		 TIPOPROG				varchar(5),
		 FECHA_VIG              DATE,
		 FECHA_GRAD				DATE,
		 COD_PROG				varchar(8),
		 NOMBRE_PROG            varchar(100),
		 COD_INST               varchar(15),
		 INSTITUCION            varchar(100),
		 PAIS                   varchar(4),
     PRIMARY KEY (CEDULA,COD_PROD,COD_INST,FECHA_GRAD))

-- estructura de tabla para la tabla 'profesores regulares y ocasionales'

CREATE TABLE PROFESORES;
		 (SEMESTRE		varchar(5),
		 CODFAC			varchar(2),
		 CCOSTO			varchar(8),
		 CEDULA			varchar(11),
		 NOMBRE			varchar(50),
		 VINCULA		varchar(2),
		 DEDICACION		float(5,3),
		 fecha_vin		date,
		 fecha_finv		date,
		 fecha_nac		date,
		 sexo			varchar(1),
		 NIVELACAD		varchar(10),
		 CATEGORIA		varchar(10),
		 CLASE_EMP		varchar(5),
		 FAC_ACTUAL		varchar(2),
		 CCO_ACTUAL		varchar(4),
		 HORAS_VIN		varchar(3),
		 TIPO_DOC	    varchar(2),
		 NOMBRES		varchar(30),
		 PRIM_APELL		varchar(15),
		 SDO_APELL		varchar(15),
     PRIMARY KEY (CEDULA,SEMESTRE))




























































