/* TABLAS DE REFERENCIA */
IDENTIFADMISION
GRUPOADMI
CLASEADMI
IDNOUSOCUPO

/* Querys para APLICATIVO AUTOEVALUACIÓN 
Guardarlos todos como DELIMITADOS con tabulador Y SIN HEADER

/* PROGRAMAS CON ESTUDIANTES MATRICULADOS DESDE 2006-1   1  
d:\bdc\caafi\datos\Planos\PROGRAMAS.TXT   
*/
SELECT A.facultad, A.CCOSTO, a.PROGRAMA, A.codigo_snies, A.nombrelargo, A.ESTADO, A.tipoprog, A.metodol, A.ensenanza_tipo,
       A.tipoperiodo, A.nrosemest, A.creditosgrado, A.indzonal, A.sede_principal, A.ind_acreditacion, TO_CHAR(A.fecha_acreditacion,'DD/MM/YYYY'),
       A.registro_calificado, A.versionvigente, A.tope, A.semestinic, A.semestfin, A.areaconocim, A.titulo_tipo, 
       A.TITULO, A.nombrejefe, A.telefonojefe, A.emailjefe, A.ccosto_ant 
FROM PROGRAMA A, (select distinct AL.programa from alumnosemest al, programa p where AL.PROGRAMA = P.PROGRAMA AND 
                                  p.tipoprog in ('PREGRADO','ESPECIAL','MAESTRIA','DOCTORAD') and semestre > 20052) b
WHERE a.programa = b.programa  AND A.FACULTAD < 90 
ORDER BY A.FACULTAD, a.PROGRAMA;

/* TIPO INSCRIPCIÓN DESDE 2006 EN ADELANTE  2  
d:\bdc\caafi\datos\Planos\TIPO_INSCRIPCION.TXT     
*/
Select distinct a.tipoinsc,  c.nombre, c.tratamientoseleccion
from inscrito a, datosopcion b , tipoaspirante c
where substr(a.idadmision,1,5) > 20052 and 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula and 
      a.tipoinsc = c.tipo and 
      b.opcion = 1 and
      ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and 
      programa not in (402,404,405,406,409,410,413)
order by a.tipoinsc;

/* TIPO ACEPTACIÓN  3 
d:\bdc\caafi\datos\Planos\TIPO_ACEPTACION.TXT
*/
select distinct a.tipoacept, b.descripcion
from admitido a, tipoacept b
where substr(a.idadmision,1,5)>20052 and
      a.tipoacept = b.tipoacept and
      ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and 
      programa not in (402,404,405,406,409,410,413)
order by a.tipoacept;

/* con este query se encuentra que solo 1 estudiante fue admitido en 2007-1 como ABELLDPT, 
   PERO COMO TIENE NÚMEROS TAN DISPARADOS EN LOS CUPOS SE QUITA 
select a.tipoacept, substr(a.idadmision,1,5), COUNT(*)
from admitido a, tipoacept b
where substr(a.idadmision,1,5)>20052 and
      a.tipoacept = b.tipoacept and
      a.programa > 500 and a.programa < 541 AND A.tipoACEPT in ('ABELLNAL','ABELLDPT')
GROUP BY a.tipoacept, substr(a.idadmision,1,5)
order by a.tipoacept;

/* INSCRITOS OPCIÓN 1 - INSCRITOS RESUMIDO 1
d:\bdc\caafi\datos\Planos\INSCRITOS_RES.txt
*/
select b.programa, substr(a.idadmision,1,5) stre, count(*) inscritos
from inscrito a, DATOSOPCION B, GRUPOADMI C
where substr(a.idadmision,1,5) > 20052 AND 
      ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and 
      programa not in (402,404,405,406,409,410,413) and -- PREPARATORIOS 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula and
      b.opcion = 1 AND
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' and 
      A.tipoinsc IN ('ABELLDPT','ARTES','D644ICFE,','DOBLETIT','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','NORMAL','SIN-EXAM','POSGRADO','POSODONT','SUBESPEC')
group by b.programa, substr(a.idadmision,1,5)
order by b.programa, stre;

/* INSCRITOS DESAGREGADOS 2
d:\bdc\caafi\datos\Planos\INSCRITOS_DES.TXT
*/
select b.programa,substr(a.idadmision,1,5) stre, a.tipoinsc, count(*) inscritos
from inscrito a,DATOSOPCION B, GRUPOADMI C
where substr(a.idadmision,1,5) > 20052 AND 
      ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and 
      programa not in (402,404,405,406,409,410,413) and
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula and
      b.opcion = 1 AND
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' and 
      A.tipoinsc IN ('ABELLDPT','ARTES','D644ICFE,','DOBLETIT','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','NORMAL','SIN-EXAM','POSGRADO','POSODONT','SUBESPEC')
group by b.programa, substr(a.idadmision,1,5), a.tipoinsc
order by b.programa, stre, a.tipoinsc;


/* TIPO CUPOS DESDE 2006 */
select distinct tipoinsc, idcupoadic
  from cupoxtipoinsc 
  where  SUBSTR(IDADMISION,1,5) > 20052 and programa>100 and SUBSTR(IDADMISION,12,3) NOT IN ('CAR','CAU')  
  order by tipoinsc, idcupoadic;

/* CUPOS 3
cupos resumido* 'ABELLNAL' y 'ABELLDPT' ANTES en 2007 SON ERRONEOS porque son números muy elevados y después de 2006 no aparecen, 
                          solo en 2007-1 SE ADMITIÓ UNO D644ICFE en 2015-2 son erroneos en la mayoría de casos dejaron los mismos cupos de NORMAL 
                          En cupos en 20092 y 20101 había unos cupos misteriosos con PRENUEANT2 

d:\bdc\caafi\datos\Planos\CUPOS_RES.TXT
*/
select A.programa, substr(a.idadmision,1,5) stre, sum(a.nrocupos) cupos
from cupoxtipoinsc a,programa b, GRUPOADMI C 
where a.programa = b.programa and 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (405,406,409,410,413)  AND
      substr(a.idadmision,1,5) > 20052 and 
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' AND    
      A.tipoinsc IN ('ARTES','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','NORMAL','POSGRADO','POSODONT','SUBESPEC')
group by A.programa, substr(a.idadmision,1,5)
order by a.programa, stre;

/* CUPOS DESAGREGADOS 4
d:\bdc\caafi\datos\Planos\CUPOS_DES.TXT 
*/
select A.programa, substr(a.idadmision,1,5) stre, tipoinsc, sum(a.nrocupos) cupos
from cupoxtipoinsc a,programa b, GRUPOADMI C 
where a.programa = b.programa and 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413)  AND
      SUBSTR(A.idadmision,1,5)>20052 AND 
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' AND    
      A.tipoinsc IN ('ARTES','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','NORMAL','POSGRADO','POSODONT','SUBESPEC')
group by A.programa, substr(a.idadmision,1,5),tipoinsc
order by A.programa, stre;

/* ADMITIDOS RESUMIDO 5
d:\bdc\caafi\datos\Planos\ADMITIDOS_RES.TXT  
*/
select a.programa, substr(a.idadmision,1,5) stre, count(*) admitidos
from admitido a, GRUPOADMI C 
where substr(a.idadmision,1,5) > 20052 and
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) and 
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' AND    
      A.tipoACEPT IN ('ABELLDPT','ARTES','D644ICFE','DEPORT','DOBLETIT','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','POR-EXAM','POSGRADO','POSODONT','SUBESPEC','PREPAVAN','PREPBASI','PREPELEM','SIN-EXAM')
group by a.programa, substr(a.idadmision,1,5)
order by a.programa, stre;

/* ADMITIDOS DESAGREGADOS 6
d:\bdc\caafi\datos\Planos\ADMITIDOS_DES.TXT
*/
select a.programa, substr(a.idadmision,1,5) stre, a.tipoacept, count(*) admitidos
from admitido a, GRUPOADMI C 
where substr(a.idadmision,1,5)>20052 and
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) AND 
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' AND   
      A.tipoACEPT IN ('ABELLDPT','ARTES','D644ICFE','DEPORT','DOBLETIT','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','POR-EXAM','POSGRADO','POSODONT','SUBESPEC','PREPAVAN','PREPBASI','PREPELEM','SIN-EXAM')
group by a.programa, substr(a.idadmision,1,5), a.tipoacept
order by a.programa, stre, a.tipoacept;

/* MATRICULADOS 
MATRICULADOS TOTALES POR PROGRAMA 7
d:\bdc\caafi\datos\Planos\MATRICULADOS_TOTALES.TXT
*/
select a.programa,a.semestre, count(*) matriculados 
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20052 and  
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413)
group by a.programa, a.semestre
order by a.programa, a.semestre;

/* CONTEO ESTUDIANTES POR ESTRATO(QUE PAGARON y MATRICULARON) Mejorado revisando que si hayan matriculado 8  
d:\bdc\caafi\datos\planos\matriculados_x_estrato.txt
*/
Select x.programa, x.semestre, b.estrato, count(*) MAT_X_ESTRATO
from (select distinct d.semestre, d.cedula, d.programa from alumnosemest d 
       where d.semestre > 20052 and d.programa < 1700 and d.programa > 100 and 
             d.programa not in (402,404,405,406,409,410,413) and d.estadosemest not in ('PREPAR','NOMATR')) X
left join 
(SELECT DISTINCT a.cedula, CXC_NUMERO, a.PROGRAMA, a.SEMESTRE, estadocxc_codigo, ESTRATO
  FROM FACART_CXC_ESTUDIANTE a, facart_cxc b, alumnosemest c
  WHERE a.SEMESTRE > 20052 and 
        a.programa > 100 and a.programa < 1700 and 
        a.programa not in (402,404,405,406,409,410,413) AND
        estadocxc_codigo <> 'ANULADO' AND estrato > 0   and
        cxc_numero = numero and a.cedula = c.cedula and 
        a.programa = c.programa and a.semestre = c.semestre) B 
on x.cedula = b.cedula and x.semestre = b.semestre and x.programa = b.programa
group by x.programa, x.semestre, b.estrato
order by x.programa, x.semestre, b.estrato;

/* MATRICULADOS PRIMER SEMESTRE 9
d:\bdc\caafi\datos\Planos\MATRICULADOS_1ER_STRE.TXT
*/
select a.programa, substr(a.idadmision,1,5) stre, count(*) matric_1er
from admitido a, alumnosemest b
where substr(a.idadmision,1,5)>20052 and
      substr(a.idadmision,9,3)<>'REI' and
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) and
      a.tipoacept not in ('REINGRES','REINGMED','SANANDRE','SURSUR','CUPORESE') and 
      a.programa = b.programa and 
      substr(a.idadmision,1,5) = b.semestre and 
      a.cedula = b.cedula
group by a.programa, substr(a.idadmision,1,5)
order by a.programa, stre;

/* GRADUADOS 10
D:\BDC\CAAFI\Datos\planos\GRADUADOS.TXT
*/
select programa, substr(to_char(actafecha,'YYYYMMDD'),1,4)||
       DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE, COUNT(*) graduados
from grado a
where actafecha between '01-jan-2006' and '31-dec-2030' AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413)
group by programa,substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2)
ORDER BY programa,STRE;

/* CONTEO GRADUADOS POR PROGRAMA Y SEMESTRE CON NRO SEMESTRES DE DURACIÓN 11
D:\BDC\CAAFI\Datos\planos\GRADUADOS_duracion.TXT
*/
select programa, substr(to_char(actafecha,'YYYYMMDD'),1,4)||
       DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE, 
       nrosemest, count(*) graduados 
from grado a
where actafecha > '01-jan-2006' 
group by programa, substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2), nrosemest
ORDER BY programa, STRE, nrosemest;

/* RETIRADOS - Canceladores de semestre 12
d:\bdc\caafi\datos\Planos\RETIRADOS.TXT
*/
SELECT A.programa,a.semestre,COUNT(*) retirados
FROM CANCSEMESTRE A 
WHERE A.SEMESTRE > 20052 AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (404, 405, 406, 409, 410, 413) 
GROUP BY a.PROGRAMA, a.semestre
ORDER BY a.PROGRAMA, a.semestre;

/* RETIRADOS - Insuficientes 13
d:\bdc\caafi\datos\Planos\insuficientes.TXT
*/
SELECT A.programa, a.semestre, COUNT(*) insuficientes
FROM alumnosemest A 
WHERE A.SEMESTRE > 20052 AND rango ='INSUFICIEN' and 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) 
GROUP BY a.PROGRAMA, a.semestre
ORDER BY a.PROGRAMA, a.semestre;

/* PUNTAJE DE CORTE POR PROGRAMA 14
d:\bdc\caafi\datos\Planos\CORTES.TXT
*/
Select A.PROGRAMA, substr(a.idadmision,1,5) COHORTE, MIN(CALIFTOTAL) corte 
from admitido A, califtotal B
where ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) and 
      a.tipoacept IN ('POR-EXAM') AND 
      a.programa = B.PROGRAMA AND a.cedula = b.cedula AND 
      substr(a.idadmision,1,4) > 2005 and 
      SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and
      a.idadmision = b.idadmision AND
      b.idestand ='S' 
GROUP BY A.PROGRAMA, substr(a.idadmision,1,5), A.tipoacept
order by A.PROGRAMA,COHORTE;

/* PROMEDIO PUNTAJE CALIFICACION TOTAL STANDARD 15
d:\bdc\caafi\datos\Planos\PROMEDIOS.TXT
*/
select A.PROGRAMA, substr(a.idadmision,1,5) COHORTE, round(AVG(b.califtotal),2) PROMEDIO
from admitido a, califtotal b
where ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) and 
      substr(a.idadmision,1,4) > 2005        AND 
      substr(a.idadmision,6,9) = 'PRENUEANT' AND 
      a.tipoacept IN ('POR-EXAM') AND 
      a.programa   = B.PROGRAMA   AND 
      a.cedula     = b.cedula     AND 
      a.idadmision = b.idadmision AND
      SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and
      b.idestand   = 'S'          
group by A.PROGRAMA, substr(a.idadmision,1,5)
order by A.PROGRAMA, COHORTE;

/* PENSUMES VERSIÓN VIGENTE 16
d:\bdc\caafi\datos\planos\pensum_vig.txt
*/
SELECT  b.facultad, A.programa, a.version, a.consec, a.materia, c.nombrelargo nombre_mat, nivel, a.prereqcredito, a.inddestreza,
        a.tipocurso, a.nrosemana, a.horasteo, a.horasprac, a.horasteoprac, a.horasespec, c.creditos
FROM pensum a, programa b, materia c
where a.programa = b.programa and 
      a.version  = b.versionvigente and 
      a.materia  = c.materia and 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413) 
order by b.facultad, a.programa, a.nivel;

/* PENSUMES VERSIONES NO VIGENTES 17
d:\bdc\caafi\datos\planos\pensum_no_vig.txt
*/
SELECT  b.facultad, A.programa, a.version, a.consec, a.materia, c.nombrelargo nombre_mat, nivel, a.prereqcredito, a.inddestreza,
        a.tipocurso, a.nrosemana, a.horasteo, a.horasprac, a.horasteoprac, a.horasespec, c.creditos
FROM pensum a, programa b, materia c
where a.programa = b.programa and 
      a.version  <> b.versionvigente and 
      a.version < 20 and 
      a.materia  = c.materia and 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413)
order by b.facultad, a.programa, a.nivel;

/* ELECTIVAS DE LA VERSIÓN VIGENTE DE LOS PROGRAMAS 18
d:\bdc\caafi\datos\planos\electivas_ver_vigente.txt
*/
SELECT  b.facultad, A.programa, a.version, a.consec, a.materia, c.nombrelargo nombre_mat, a.banco, c.creditos, a.estado, a.comentario 
FROM electiva a, programa b, materia c
where a.programa = b.programa and 
	  a.version  = b.versionvigente and 
	  a.materia  = c.materia and 
	  ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
          a.programa not in (402,404,405,406,409,410,413)
order by b.facultad, a.programa;

/* ELECTIVAS DE LAS VERSIONES NO VIGENTES DE LOS PROGRAMAS 19
d:\bdc\caafi\datos\planos\electivas_ver_no_vigente.txt
*/
SELECT  b.facultad, A.programa, a.version, a.consec, a.materia, c.nombrelargo nombre_mat, a.banco, c.creditos, a.estado, a.comentario 
FROM electiva a, programa b, materia c
where a.programa = b.programa and 
	  a.version  <> b.versionvigente and 
	  a.materia  = c.materia and 
	  ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
          a.programa not in (402,404,405,406,409,410,413)
order by b.facultad, a.programa;

/* CÁLCULO DE DESERCIÓN 
/* ADMITIDO CASI TODOS, SE EXCLUYEN: REINGRESOS Y TRANSFERENCIAS, CAMBIO PROGRAMA, CAMBIO SEDE, CAMBIO MODALIDAD  20
d:\bdc\caafi\datos\planos\admitidos_grad.txt 
*/
select substr(a.idadmision,1,5) cohorte, a.programa, a.cedula, a.tipoacept, a.opcion, X.STRE_GRADO
from admitido a
LEFT JOIN 
  (select CEDULA, PROGRAMA, substr(to_char(g.actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(g.actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE_GRADO 
    from grado g  
    where  programa > 100 and programa < 1700 and ACTAFECHA > '01-JAN-2000') X
ON A.CEDULA = X.CEDULA AND A.PROGRAMA = X.PROGRAMA
where  A.programa > 100 and A.programa < 1700 and 
        a.programa not in (1477,1622,1629,1641,1642,1643,1645,1651,1660,1661,1662,1663,1665,1668,1670,1683,1684,1697,416,417,418,419,465,468,469,542,548,711,730,778,780,903,905,941) and 
	substr(a.idadmision,6,9) = 'PRENUEANT' AND 
        substr(idadmision,1,4) > 2000 
ORDER BY COHORTE, A.PROGRAMA, CEDULA;

/* ADMITIDOS X PROGRAMA CON ÚLTIMO SEMESTRE Y ESTADO ALUMNO  21
D:\bdc\caafi\datos\planos\admitidos_estado_3_4_6.txt    
Factor 3, 4 y 6 semestres + 4 (9 semestres)
*/
select x.cohorte, x.sem_ini, x.sem_fin ult_stre, ap.programa, ap.cedula, ap.estadoalumn, ap.sexo, ap.año_nac, x.estrato, x.stre_corte
from (select programa, a.cedula, a.estadoalumn, substr(al.sexo,1,1) sexo, substr(to_char(al.fechanace,'yyyy/mm/dd'),1,4) año_nac 
        from alumnoprograma a, alumno al 
        where a.cedula=al.cedula and a.programa > 100 and a.programa < 1700 and
          a.programa not in (1477,1622,1629,1641,1642,1643,1645,1651,1660,1661,1662,1663,1665,1668,1670,1683,1684,1697,416,417,418,419,465,468,469,542,548,711,730,778,780,903,905,941)) ap
right join
(select b.cohorte, a.programa, a.cedula, SUBSTR(b.cohorte,1,4)+4||substr(b.cohorte,5,1) Stre_corte, min(b.estrato) estrato, min(semestre) sem_ini, max(semestre) Sem_fin 
    from alumnosemest a, programa p, (select substr(ad.idadmision,1,5) cohorte, ad.programa, ad.cedula, f.estrato from admitido ad
                                        left join 
                                      (select distinct PROGRAMA, CEDULA, ESTRATO FROM FACART_CXC_ESTUDIANTE WHERE programa>100 and programa<1700 and semestre>20002 and estrato>0) f 
                                      on ad.programa = f.programa and ad.cedula = f.cedula
                                      where  ad.programa > 100 and ad.programa < 1700 and substr(idadmision,6,9) = 'PRENUEANT' AND substr(idadmision,1,4) > 2000) b 
    where a.programa = b.programa and a.programa = p.programa  and 
          p.nrosemest in (2, 3, 4, 6, 7) and 
          a.semestre > 20002 and a.semestre >= b.cohorte and  
          a.cedula = b.cedula 
    group by b.cohorte, a.programa, a.cedula, SUBSTR(b.cohorte,1,4)+4||substr(b.cohorte,5,1)) X 
on ap.cedula = x.cedula and ap.programa = x.programa 
order by x.cohorte, ap.programa, ap.cedula;

/* ADMITIDOS X PROGRAMA CON ÚLTIMO SEMESTRE Y ESTADO ALUMNO   22 
D:\bdc\caafi\datos\planos\admitidos_estado_8_9_10_12_13.txt     
Factor 8, 9, 10, 12 Y 13 semestres + 7 (15 semestres)
*/
select x.cohorte, x.sem_ini, x.sem_fin ult_stre, ap.programa, ap.cedula, ap.estadoalumn, ap.sexo, ap.año_nac, x.estrato, x.stre_corte
from (select programa, a.cedula, a.estadoalumn, substr(al.sexo,1,1) sexo, substr(to_char(al.fechanace,'yyyy/mm/dd'),1,4) año_nac 
        from alumnoprograma a, alumno al 
        where a.cedula=al.cedula and a.programa > 100 and a.programa < 1700 and
          a.programa not in (1477,1622,1629,1641,1642,1643,1645,1651,1660,1661,1662,1663,1665,1668,1670,1683,1684,1697,416,417,418,419,465,468,469,542,548,711,730,778,780,903,905,941)) ap
right join
(select b.cohorte, a.programa, a.cedula, SUBSTR(b.cohorte,1,4)+7||substr(b.cohorte,5,1) Stre_corte, min(b.estrato) estrato, min(semestre) sem_ini, max(semestre) Sem_fin 
    from alumnosemest a, programa p, (select substr(ad.idadmision,1,5) cohorte, ad.programa, ad.cedula, f.estrato from admitido ad
                                        left join 
                                      (select distinct PROGRAMA, CEDULA, ESTRATO FROM FACART_CXC_ESTUDIANTE WHERE programa>100 and programa<1700 and semestre>20002 and estrato>0) f 
                                      on ad.programa = f.programa and ad.cedula = f.cedula
                                      where  ad.programa > 100 and ad.programa < 1700 and substr(idadmision,6,9) = 'PRENUEANT' AND substr(idadmision,1,4) > 2000) b 
    where a.programa = b.programa and a.programa = p.programa  and 
          p.nrosemest in (8, 9, 10, 12, 13) and 
          a.semestre > 20002 and a.semestre >= b.cohorte and  
          a.cedula = b.cedula 
    group by b.cohorte, a.programa, a.cedula, SUBSTR(b.cohorte,1,4)+7||substr(b.cohorte,5,1)) X 
on ap.cedula = x.cedula and ap.programa = x.programa 
order by x.cohorte, ap.programa, ap.cedula;

/* CONTEO DE DESERTORES O QUE NO SE HAN GRADUADO DESPUÉS DE 3 SEMESTRES DE HABER MATRICULADO SU ÚLTIMO SEMESTR  23
D:\bdc\caafi\datos\planos\DESERTORES.txt   
*/
SELECT AP.PROGRAMA, AP.STRE_FINAL, AP.CEDULA, AP.ESTADOALUMN, AP.SEXO, ap.año_nac, f.estrato
FROM (SELECT A.PROGRAMA, X.STRE_FINAL, A.CEDULA, A.ESTADOALUMN, substr(AL.SEXO,1,1) sexo, substr(to_char(AL.fechanace,'yyyy/mm/dd'),1,4) año_nac 
      FROM ALUMNOPROGRAMA A,ALUMNO AL, (SELECT PROGRAMA, CEDULA, MAX(SEMESTRE) STRE_FINAL FROM ALUMNOSEMEST 
                                        WHERE programa > 100 and programa < 1700 AND SEMESTRE > 19992 and
                                              programa not in (402,404,405,406,409,410,413) and
                                              estadosemest not in ('NOMATR','PREPAR') GROUP BY PROGRAMA,CEDULA) X
      WHERE A.ESTADOALUMN NOT IN ('GRADUADO','ACTIVO') AND A.CEDULA = X.CEDULA AND A.CEDULA = AL.CEDULA AND A.PROGRAMA = X.PROGRAMA ORDER BY A.PROGRAMA,STRE_FINAL) AP
LEFT JOIN
(select PROGRAMA, CEDULA, min(ESTRATO) estrato FROM FACART_CXC_ESTUDIANTE WHERE programa>100 and programa<1700 and semestre>19992 and estrato > 0 group by PROGRAMA, CEDULA) F 
on ap.programa = f.programa and ap.cedula = f.cedula;

/* MATRICULADOS DESDE 20001       24
d:\bdc\caafi\datos\Planos\MATRIC_2000_.TXT
*/
select a.programa,a.semestre, count(*) matriculados 
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 19992 and  
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (402,404,405,406,409,410,413)
group by a.programa, a.semestre
order by a.programa, a.semestre;


/* EVALUACIÓN DESAGREGADA   25 
d:\bdc\caafi\datos\planos\eval_99999.txt
*/
select etcsemestre, etccedula, igenombreresumido, etcmateria, etcgrupo, nombre_mat, catdescripcion, 
       etcmedia, etcdesviacion, etccoeficiente, etcrta_valida, letras, ETCCODCATEGORIA
  from evdtotal_categoria a, deptoacad d, evdcategoria e,
  (select distinct materia, nombrelargo nombre_mat from materia) b, (select distinct igenumeroidentific,igenombreresumido from no_infgraempl) c
  where etccedula = igenumeroidentific and etcmateria = materia and etcsemestre = 20081 and substr(lpad(to_char(etcmateria),7,' '),1,2) = d.facultad 
  and substr(lpad(to_char(etcmateria),7,' '),3,2) = d.depto and a.etccodcategoria = e.catcodigo
order by etcsemestre, igenombreresumido, etcmateria, etcgrupo, a.ETCCODCATEGORIA ;

select * from admitido where programa='1477'
select * from admitido where cedula='70785878'
select * from grado where programa in (1477,1622,1629,1641,1642,1643,1645,1651,1660,1661,1662,1663,1665,1668,1670,1683,1684,1697,416,417,418,419,465,
468,469,542,548,711,730,778,780,784,812,903,905,941,972,973,978,979)
order by programa

SELECT * FROM ALUMNOSEMEST WHERE PROGRAMA IN (1477,1622,1629,1641,1642,1643,1645,1651,1660,1661,1662,1663,1665,1668,1670,1683,1684,1697,416,417,418,419,465,
468,469,542,548,711,730,778,780,903,905,941) ORDER BY PROGRAMA,SEMESTRE

/* Evaluación al curso y el profesor */
select * from evdcategoria;
select * from evdevaluacion;       
select * from evdmateria_evaluada WHERE MTECEDULA='98488680' AND MTESEMESTRE='20181' ORDER BY MTEMATERIA,MTEGRUPO AND MTEMATERIA='1501844';
select * from evdtotal_categoria where etccedula='71690522' and etcsemestre='20181' AND ETCMATERIA='1501844' order by etccodcategoria


/************************************************************************************************************************************************************/

/* OTROS INDICADORES */

/* EVALUACIÓN DESAGREGADA PARA UN PROFESOR 
*/
select etcsemestre, etccedula, igenombreresumido, etcmateria, etcgrupo, nombre_mat, catdescripcion, 
       etcmedia, etcdesviacion, etccoeficiente, etcrta_valida, letras, ETCCODCATEGORIA
  from evdtotal_categoria a, deptoacad d, evdcategoria e,
  (select distinct materia, nombrelargo nombre_mat from materia) b, (select distinct igenumeroidentific,igenombreresumido from no_infgraempl) c
  where etccedula = igenumeroidentific and etcmateria = materia and substr(lpad(to_char(etcmateria),7,' '),1,2) = d.facultad 
  and substr(lpad(to_char(etcmateria),7,' '),3,2) = d.depto and a.etccodcategoria = e.catcodigo and
  etccedula = '71651775'
order by etcsemestre, igenombreresumido, etcmateria, etcgrupo, a.ETCCODCATEGORIA ;


/* 1. INSCRITOS ENTRE RANGO DE SEMESTRES POR TIPO INSCRIPCIÓN Y OPCIÓN PARA UN PROGRAMA 
d:\borrar\inscritos.xlsx 
*/
select b.programa, substr(a.idadmision,1,5) stre, a.tipoinsc, b.opcion, count(*) inscritos
from inscrito a, DATOSOPCION B
where PROGRAMA = &PROG AND
      substr(a.idadmision,1,5) >= &SEM_INI AND substr(a.idadmision,1,5) <= &SEM_FIN AND 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula 
group by b.programa, substr(a.idadmision,1,5), a.tipoinsc, b.opcion
order by b.programa, stre, a.tipoinsc, b.opcion;


/* 1.1 INSCRITOS POR SEDE EN RANGO DE SEMESTRES POR TIPO INSCRIPCIÓN Y OPCIÓN
d:\borrar\inscritos.xlsx 
*/
select b.programa, P.NOMBRELARGO,substr(a.idadmision,1,5) stre, a.tipoinsc, b.opcion, count(*) inscritos
from inscrito a, DATOSOPCION B, PROGRAMA P
where B.PROGRAMA = P.PROGRAMA AND
      substr(a.idadmision,1,5) >= &SEM_INI AND substr(a.idadmision,1,5) <= &SEM_FIN AND 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula AND SEDE_PRINCIPAL='P-BERRIO' AND P.PROGRAMA<2000
group by b.programa, P.NOMBRELARGO, substr(a.idadmision,1,5), a.tipoinsc, b.opcion
order by b.programa, stre, a.tipoinsc, b.opcion;


/* 1.2 INSCRITOS ENTRE RANGO DE SEMESTRES POR PROGRAMA, DEPARTAMENTO DEL COLEGIO Y SEXO 
*/
select substr(a.idadmision,1,5) stre, c.depto, a.sexo, count(*) inscritos
from inscrito a, datosopcion b, COLEGIO c
where substr(a.idadmision,1,5) >= &sem_ini AND substr(a.idadmision,1,5) <= &sem_fin AND 
      a.colegio = c.colegio and 
      a.cedula  = b.cedula and
      a.idadmision = b.idadmision and 
      b.opcion  = 1 and 
      b.programa > 100 and b.programa < 1700
group by substr(a.idadmision,1,5), c.depto, a.sexo
order by stre, c.depto, a.sexo ;


/* 2. ADMITIDOS ENTRE RANGO DE SEMESTRES POR OPCIÓN, SEXO Y TIPO ACEPTACIÓN PARA UN PROGRAMA 
d:\borrar\admitidos.xlsx 
*/
select a.programa, substr(a.idadmision,1,5) stre, opcion, sexo, a.tipoacept, count(*) admitidos
from admitido a, inscrito b
where PROGRAMA = &PROG AND 
      substr(a.idadmision,1,5) >= &SEM_INI AND substr(a.idadmision,1,5) <= &SEM_FIN AND 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula 
group by a.programa, substr(a.idadmision,1,5), opcion, sexo, a.tipoacept
order by a.programa, stre, opcion, sexo, a.tipoacept;

/* 2.2. ADMITIDOS ENTRE RANGO DE SEMESTRES POR OPCIÓN, SEXO Y TIPO ACEPTACIÓN PARA UN PROGRAMA 
*/
select substr(a.idadmision,1,5) stre, c.depto, sexo, count(*) admitidos
from admitido a, inscrito b, colegio c
where substr(a.idadmision,1,5) >= &SEM_INI AND substr(a.idadmision,1,5) <= &SEM_FIN AND 
      a.idadmision = b.idadmision and 
      a.cedula = b.cedula and
      b.colegio = c.colegio and
      a.programa =&M_PROG
group by substr(a.idadmision,1,5), c.depto, sexo
order by stre, c.depto, sexo


/* 3. MATRICULADOS POR SEDE Y PROGRAMA EN RANGO DE SEMESTRES */
select a.semestre, a.programa, P.NOMBRELARGO, count(*) matriculados 
from alumnosemest a, PROGRAMA P
where A.estadosemest not in ('PREPAR','NOMATR') and
      A.PROGRAMA=P.PROGRAMA AND 
      A.SEMESTRE >= &SEM_INI AND A.SEMESTRE <= &SEM_FIN AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (404, 405, 406, 409, 410, 413) AND SEDE_PRINCIPAL='P-BERRIO' AND P.PROGRAMA < 2000
group by a.semestre, a.programa, P.NOMBRELARGO
order by a.semestre, a.programa;


/* 3.1 PRIMÍPAROS POR SEDE Y PROGRAMA ENTRE RANGO DE SEMESTRES */
select substr(a.idadmision,1,5) stre, a.programa, p.nombrelargo, count(*) matric_1er
from admitido a, alumnosemest b, programa p
where substr(a.idadmision,1,5) > 20172 and
      substr(a.idadmision,9,3) <> 'REI' and
      A.PROGRAMA = P.PROGRAMA AND 
      b.SEMESTRE >= &SEM_INI AND b.SEMESTRE <= &SEM_FIN AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (404, 405, 406, 409, 410, 413) and
      a.tipoacept not in ('REINGRES','REINGMED','SANANDRE','SURSUR','CUPORESE') and 
      a.programa = b.programa and a.programa = p.programa and 
      substr(a.idadmision,1,5) = b.semestre and 
      a.cedula = b.cedula AND SEDE_PRINCIPAL='P-BERRIO' AND P.PROGRAMA < 2000
group by substr(a.idadmision,1,5), a.programa, p.nombrelargo
order by stre, a.programa;


/* 4. CANCELADORES DE MATERIAS DE UN PROGRAMA ENTRE RANGO DE SEMESTRES 
d:\borrar\canceladores_materias.xlsx 
*/
select a.programa, a.semestre, a.materia, m.nombrelargo nombre_materia, count(*)
from cancmateria a, materia m
where a.materia  = m.materia and 
      a.programa = &prog and 
      a.semestre >= &SEM_INI and a.semestre <= &SEM_fin 
group by a.programa, a.semestre, a.materia, m.nombrelargo      
order by a.programa, semestre, a.materia;

/* 4.1 CANCELADORES DE SEMESTRE POR PROGRAMA PARA UNA SEDE ENTRE RANGO DE SEMESTRES */
SELECT a.semestre, A.programa, P.NOMBRELARGO,COUNT(*) retirados
FROM CANCSEMESTRE A, PROGRAMA P
WHERE A.PROGRAMA=P.PROGRAMA AND 
      A.SEMESTRE >= &SEM_INI AND A.SEMESTRE <= &SEM_FIN AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
       SEDE_PRINCIPAL in ('TURBO','CARMENVI') AND P.PROGRAMA < 2000
GROUP BY a.semestre, A.programa, P.NOMBRELARGO
ORDER BY a.semestre, A.programa;


/* 4.2 CANCELADORES DE SEMESTRE PARA UNA FACULTAD EN RANGO DE SEMESTRES 
d:\borrar\canceladores_stre.xlsx 
*/
SELECT a.semestre, A.programa, COUNT(*) retirados
FROM CANCSEMESTRE A, PROGRAMA P 
WHERE A.SEMESTRE in (20181, 20182) and
      a.programa = p.programa and
      p.facultad = &m_fac 
GROUP BY a.semestre,a.PROGRAMA 
ORDER BY a.semestre,a.PROGRAMA;

/* 5. INSUFICIENTES PARA UNA FACULTAD EN RANGO DE SEMESTRES 
d:\borrar\Insuficientes.xlsx
*/
SELECT a.semestre, A.programa,  COUNT(*) insuficientes
FROM alumnosemest A, PROGRAMA P
WHERE A.SEMESTRE in (20181, 20182) AND rango ='INSUFICIEN' and 
      a.programa = p.programa and 
      p.facultad = &m_fac 
GROUP BY a.semestre,a.PROGRAMA 
ORDER BY a.semestre,a.PROGRAMA;

/* 6. PROMEDIO POR SEMESTRE DE UN PROGRAMA ENTRE RANGO DE SEMESTRES 
d:\borrar\promedio_semestre.xlsx
*/
select a.programa, a.semestre, a.promsemest, count(*) Nro_estudiantes
from alumnosemest a
where a.programa = &prog and 
      a.semestre >= &SEM_INI and a.semestre <= &SEM_fin and
      a.estadosemest NOT IN ('PREPAR', 'NOMATR')
group by a.programa, a.semestre, a.promsemest
order by a.programa, a.semestre, a.promsemest;

/* 7. CONTEO DE ESTUDIANTES MATRICULADOS POR AÑO DE NACIMIENTO PARA UN PROGRAMA ENTRE UN RANGO DE SEMESTRES 
d:\borrar\matriculados_por_año_nacimiento.xlsx
*/
select a.programa, a.semestre, substr(to_char(fechanace,'yyyy-mm-dd'),1,4) año_nac, count(*) Nro_estudiantes
from alumnosemest a, alumno b
where a.programa = &prog and 
      a.semestre >= &SEM_INI and a.semestre <= &SEM_fin and
      a.estadosemest NOT IN ('PREPAR', 'NOMATR') and
      a.cedula   = b.cedula 
group by a.programa, a.semestre, substr(to_char(fechanace,'yyyy-mm-dd'),1,4)
order by a.programa, a.semestre, substr(to_char(fechanace,'yyyy-mm-dd'),1,4);

/* 7.1 CONTEO DE ESTUDIANTES MATRICULADOS POR TIPO DE ADMISION PARA UN PROGRAMA ENTRE UN RANGO DE SEMESTRES 
d:\borrar\matriculados_por_tipo_admision_y_opcion.xlsx
*/
select a.programa, a.semestre, b.tipoacept, b.opcion, count(*) Nro_matriculados
from alumnosemest a, (select programa, cedula, substr(idadmision,1,5) stre, opcion, tipoacept from admitido where programa=&m_prog and substr(idadmision,1,5)>= &_s_ini and substr(idadmision,1,5)<=&s_fin) b
where a.programa = b.programa and 
      a.semestre = b.stre and
      a.estadosemest NOT IN ('PREPAR', 'NOMATR') and
      a.tipoacept <> 'ANTIGUO' AND
      a.cedula   = b.cedula 
group by a.programa, a.semestre, B.tipoacept, B.opcion
order by a.programa, a.semestre, B.tipoacept, B.opcion;

/* 7.2. CONTEO DE ESTUDIANTES DE UN PROGRAMA POR MUNICIPIO DEL COLEGIO DE PROCEDENCIA PARA UN RANGO DE SEMESTRES 
d:\borrar\matriculados_por_municipio_de_colegio.xlsx
*/
Select a.programa, a.semestre, f.depto Dpto_colegio, d.nombre nombre_dep, f.mpio Mpio_Colegio, c.nombre nombre_mcipio, COUNT(*) matriculados_Mcipio_coleg
from alumnosemest a, alumno b, municipio c, departamento d, colegio f
where a.programa     = &prog and 
      a.semestre    >= &SEM_INI and a.semestre <= &SEM_fin and
      a.cedula       = b.cedula and 
      a.estadosemest NOT IN ('PREPAR', 'NOMATR') and
      b.colegio      = f.colegio      and
      f.depto        = c.departamento and
      f.depto        = d.departamento and
      f.mpio         = c.municipio    and 
      d.departamento = c.departamento and 
      c.continente   = d.continente   and
      c.pais         = d.pais         and
      c.pais         = 46             
group by a.programa, a.semestre, f.depto, d.nombre, f.mpio, c.nombre
order by a.programa, a.semestre, f.depto, f.mpio

/* 8. PUNTAJE MAS ALTO CALIFICACION TOTAL STANDARD
d:\borrar\puntaje_Mas_alto.xlsx
*/
select A.PROGRAMA, substr(a.idadmision,1,5) COHORTE, max(a.califtotal) Max_puntaje
from califtotal a
where a.PROGRAMA = &m_prog and 
      substr(a.idadmision,1,5) >= &s_ini  AND 
      substr(a.idadmision,1,5) <= &s_fin  AND 
      a.idestand   = 'S'          
group by A.PROGRAMA, substr(a.idadmision,1,5)
order by A.PROGRAMA, COHORTE;


/* 9. CONTEO MATRICULARON, GANARON Y PERDIERON PARA UN SEMESTRE Y FACULTAD */
select a.semestre, a.materia, a.grupo, count(*) matricularon, 
       COUNT(CASE WHEN A.NOTADEFIN < 3 THEN 1 ELSE NULL END) Perdieron,
       COUNT(CASE WHEN A.NOTADEFIN >= 3 AND A.NOTADEFIN  <= 5 THEN 1 ELSE NULL END) Ganaron,
       COUNT(CASE WHEN A.NOTADEFIN = 7.7 THEN 1 ELSE NULL END) Aprobaron,
       COUNT(CASE WHEN A.NOTADEFIN = 8.8 THEN 1 ELSE NULL END) Desaprobaron
from matricula a 
where a.semestre in (20172,20181) and
        substr(a.materia,1,2) = '50'
group by a.semestre, a.materia, a.grupo
order by a.semestre, a.materia, a.grupo;

/* 9.1 CONTEO DE MATRICULADOS POR MATERIA Y GRUPO, QUE PIERDEN Y GANAN PARA UN SEMESTRE */
SELECT A.SEMESTRE, C.APOCOPE Nom_Dependencia, D.NOMBRELARGO Nom_Depto, A.MATERIA, B.APOCOPE Nom_materia,  A.GRUPO,  COUNT(*) MATRICULADOS,
       COUNT(CASE WHEN A.NOTADEFIN < 3 THEN 1 ELSE NULL END) PIERDEN,
       COUNT(CASE WHEN A.NOTADEFIN >= 3 AND A.NOTADEFIN  <= 5 THEN 1 ELSE NULL END) GANAN,
       COUNT(CASE WHEN A.NOTADEFIN = 7.7 THEN 1 ELSE NULL END) APRUEBAN,
       COUNT(CASE WHEN A.NOTADEFIN = 8.8 THEN 1 ELSE NULL END) DESAPRUEBAN
FROM MATRICULA A
  JOIN MATERIA B
  ON B.MATERIA = A.MATERIA
     JOIN FACULTAD C
     ON C.FACULTAD =  SUBSTR(LPAD(b.MATERIA,7,0),1,2)
        JOIN DEPTOACAD D
        ON D.DEPTO = SUBSTR(LPAD(b.MATERIA,7,0),3,2) AND D.FACULTAD = C.FACULTAD
WHERE A.SEMESTRE in (20172,20181) and C.FACULTAD = 50
GROUP BY A.SEMESTRE, A.MATERIA, B.APOCOPE, D.NOMBRELARGO, C.APOCOPE, A.GRUPO
ORDER BY a.semestre, A.MATERIA

/* 9.2 CONTEO DE MATRICULADOS POR MATERIA, SIN GRUPO, QUE PIERDEN Y GANAN PARA UN SEMESTRE */
SELECT A.SEMESTRE, C.APOCOPE Nom_Dependencia, D.NOMBRELARGO Nom_Depto, A.MATERIA, B.APOCOPE Nom_materia,  COUNT(*) MATRICULADOS,
       COUNT(CASE WHEN A.NOTADEFIN < 3 THEN 1 ELSE NULL END) PIERDEN,
       COUNT(CASE WHEN A.NOTADEFIN >= 3 AND A.NOTADEFIN  <= 5 THEN 1 ELSE NULL END) GANAN,
       COUNT(CASE WHEN A.NOTADEFIN = 7.7 THEN 1 ELSE NULL END) APRUEBAN,
       COUNT(CASE WHEN A.NOTADEFIN = 8.8 THEN 1 ELSE NULL END) DESAPRUEBAN
FROM MATRICULA A
JOIN MATERIA B
ON B.MATERIA = A.MATERIA
JOIN FACULTAD C
ON C.FACULTAD =  SUBSTR(LPAD(b.MATERIA,7,0),1,2)
JOIN DEPTOACAD D
ON D.DEPTO = SUBSTR(LPAD(b.MATERIA,7,0),3,2)
AND D.FACULTAD = C.FACULTAD
WHERE A.SEMESTRE in (20172,20181)
and C.FACULTAD = 50
GROUP BY A.SEMESTRE, A.MATERIA, B.APOCOPE, D.NOMBRELARGO, C.APOCOPE
ORDER BY a.semestre, A.MATERIA

/* 10. CONTEO CANCELARON MATERIAS PARA UN SEMESTRE Y FACULTAD */
select a.semestre, a.materia, a.grupo, count(*) cancelaron
from cancmateria a 
where a.semestre in (20172,20181) and
        substr(a.materia,1,2)='50'
group by a.semestre, a.materia, a.grupo        
order by a.semestre, a.materia, a.grupo        

/* 10.1 CANCELADORES DE MATERIAS CON GRUPO */
Select a.semestre, a.cedula, a.materia, c.grupo,a.programa 
from cancmateria a, programa b, mares_web_temp_cancmateria c 
where a.semestre='20181' and a.programa = b.programa and b.facultad = 25 and a.semestre = c.semestre and
a.cedula=c.cedula and a.materia = c.materia


/* Estudiantes activos en un programa que han ganado algunas materias */
select A.CEDULA, b.primapellido, b.sdoapellido, b.nombrepila, a.materia, a.semestre, notadefin
from matricula a, alumno b, (select CEDULA,PROGRAMA from ALUMNOPROGRAMA where programa=507 and estadoalumn NOT IN ('GRADUADO','DESERTOR','CANCELO SEM','TERMINOMATERIAS')) c
where a.materia in (2555130,2555220,2555230,2555230,2555120,2536100,2568344) and
      a.cedula = b.cedula and
      a.cedula = c.cedula and 
      notadefin >= 3 and notadefin <=5 and 
order by a.cedula,a.materia


/* Estudiantes activos en un programa que han ganado algunas materias */
select A.CEDULA, b.primapellido, b.sdoapellido, b.nombrepila, a.materia, d.nombrelargo, a.semestre, notadefin
from matricula a, alumno b, materia d,(select CEDULA,PROGRAMA from ALUMNOPROGRAMA where programa=516 and estadoalumn NOT IN ('GRADUADO','DESERTOR','CANCELO SEM','TERMINOMATERIAS')) c
where a.materia = d.materia and
      a.cedula = b.cedula and
      a.cedula = c.cedula and 
      notadefin >= 3 and 
      (substr(d.nombrelargo,1,6)='INGLES' or a.materia='2536502')
order by a.cedula,a.materia


/* conteo matricularon, ganaron y perdieron Inglés*/
select a.semestre, a.materia,m.nombrelargo, count(*) matricularon, count(case when notadefin < 3 then 1 else null end) perdieron, 
            count(case when notadefin >= 3 and notadefin <= 5 then 1 else null end) ganaron 
from matricula a, materia m 
where a.semestre in (20161,20162,20163,20164,20171,20172,20173,20174) and
        a.materia=m.materia and 
        m.nombrelargo like ('%INGLES%')
group by a.semestre, a.materia,m.nombrelargo 
order by a.semestre, a.materia,m.nombrelargo

/* MATRICULADOS EN UN SEMESTRE QUE ESTÁN REPITIENDO */
select m.programa, m.nombre_programa, m.cedula, primapellido, nombrepila, m.EMAIL_INSTITU, m.materia, m.nombre_materia, veces_perdida 
from 
(select a.programa, b.nombrelargo nombre_programa, a.cedula, primapellido, nombrepila, e.EMAIL_INSTITU, a.materia, c.nombrelargo nombre_materia 
    from matricula a, programa b, materia c, alumno e
        where semestre = 20181 and b.facultad = 40 and 
	      a.programa = b.programa and
              a.cedula   = e.cedula   and 
              a.materia = c.materia) M, (select cedula, materia, m.programa, count(*) veces_perdida from matricula m, programa p 
                                            where  m.programa = p.programa and notadefin < 3 and semestre < 20181 group by cedula, materia, m.programa) v
where m.programa = v.programa and m.cedula = v.cedula and m.materia = v.materia               
order by 1,3,4;

/* MATRICULADOS EN UN SEMESTRE QUE ESTÁN REPITIENDO */
select m.semestre, m.programa, m.cedula, m.materia, m.nombre_materia, veces_perdida 
from 
(select a.semestre, a.programa, a.cedula, a.materia, c.nombrelargo nombre_materia 
    from matricula a, programa b, materia c, alumno e
        where semestre = 20181 and b.facultad = 40 and 
	      a.programa = b.programa and
              a.cedula   = e.cedula   and 
              a.materia = c.materia) M, (select cedula, materia, m.programa, count(*) veces_perdida from matricula m, programa p 
                                            where  m.programa = p.programa and notadefin < 3 and semestre < 20181 group by cedula, materia, m.programa) v
where m.programa = v.programa and m.cedula = v.cedula and m.materia = v.materia               
order by 1,3,4

/* CURSOS MATRICULADOS CON NOTAS DEFINITIVA Y CRÉDITOS PARA ALGUNOS PROGRAMAS Y DESDE UN SEMESTRE */
select a.cedula, a.primapellido, a.sdoapellido, a.nombrepila, semestre, programa, version, m.materia, grupo, n.creditos, notadefin
  from alumno a, matricula m, materia n where  n.materia = m.materia and a.cedula = m.cedula and programa in (1418, 456, 452, 450, 451) and semestre > 20122 
  order by a.cedula, m.materia, semestre;

/* CURSOS VALIDADOS O CLASIFICADOS CON NOTAS DEFINITIVA Y CRÉDITOS PARA ALGUNOS PROGRAMAS Y DESDE UN SEMESTRE */  
select a.cedula, a.primapellido, a.sdoapellido, a.nombrepila, semestre, programa, version, m.materia, m.creditos, nota, tipovalidac 
  from alumno a, validac v, materia m where v.materia=m.materia and a.cedula = v.cedula and programa in (1418, 456, 452, 450, 451) and semestre>20122
  order by a.cedula, m.materia, semestre;

/* CURSOS HOMOLOGADOS CON NOTA DEFINITIVA Y CRÉDITOS PARA ALGUNOS PROGRAMAS Y DESDE UN SEMESTRE */
select a.cedula, a.primapellido, a.sdoapellido, a.nombrepila, semestre, programa, version, m.materia, consec, m.creditos, nota, tipoHOMOLOG 
  from alumno a, HOMOLOG H, materia m where H.materia = m.materia and a.cedula = H.cedula and programa in (1418, 456, 452, 450, 451) and semestre>20122 
  order by a.cedula, m.materia, semestre;
  

/*********************************************************************************************************************************************************/

/* conteo de cohortes con graduados en pregrado */
select a.programa, p.nombrelargo, b.semestre cohorte, COUNT(*) Graduados
from grado a, (select distinct cedula, programa, substr(idadmision,1,5) semestre from admitido where substr(idadmision,6,9)='PRENUEANT') b, programa p
where (a.PROGRAMA > 100 AND a.PROGRAMA < 1700) and 
      a.programa not in (409,410,413) and a.cedula = b.cedula and a.programa = b.programa and a.programa = p.programa
group by a.programa, p.nombrelargo, b.semestre
ORDER BY a.programa, p.nombrelargo, cohorte;

/* conteo de cohortes con graduados en posgrado */
select a.programa, p.nombrelargo, b.semestre cohorte, COUNT(*) Graduados
from grado a, (select distinct cedula, programa, substr(idadmision,1,5) semestre from admitido where substr(idadmision,6,3)='POS') b, programa p
where ((a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.cedula = b.cedula and a.programa = b.programa and a.programa = p.programa
group by a.programa, p.nombrelargo, b.semestre
ORDER BY a.programa, p.nombrelargo, cohorte;

/* conteo de cohortes con graduados con semestre de grado */
select a.programa, p.nombrelargo, b.semestre cohorte, substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE_grado, COUNT(*) graduados
from grado a, (select distinct cedula, programa, substr(idadmision,1,5) semestre from admitido where substr(idadmision,6,9)='PRENUEANT') b, programa p
where -- actafecha between '01-jan-2006' and '31-dec-2030' AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (409,410,413) and a.cedula = b.cedula and a.programa = b.programa and a.programa = p.programa
group by a.programa, p.nombrelargo, b.semestre, substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2)
ORDER BY a.programa, p.nombrelargo, cohorte, STRE_grado;

/* GRADUADOS DE UN PROGRAMA ENTRE RANGO DE SEMESTRES CON SEMESTRES DE DURACIÓN Y PROMEDIO EN EL PROGRAMA */
select substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE, 
       programa, cedula, nrosemest, promedprogr 
from grado a
where actafecha between '01-jan-1996' and '31-dec-2018' AND a.PROGRAMA in (510,536,539)
ORDER BY programa,STRE;

/* Conteo de estudiantes por rango (normal, insuficiente, incompleto, per-prueba, sobresalie, especial, sin calcul)*/
select semestre,rango,count(*)
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20162 and  
      a.PROGRAMA > 100 AND a.PROGRAMA < 1700  and a.programa not in (404, 405, 406, 409, 410, 413)
group by semestre,rango
order by semestre,rango

/* Conteo de estudiantes por tipo_admision */
select semestre, b.tipoacept, count(*)
from alumnosemest a, admitido b
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20162 and  
      a.PROGRAMA > 100 AND a.PROGRAMA < 1700  and a.programa not in (404, 405, 406, 409, 410, 413) and
      a.cedula = b.cedula and
      a.programa = b.programa and
      semestre >= substr(b.idadmision,1,5)
group by semestre,b.tipoacept
order by semestre,b.tipoacept

/* conteo alumnos por estado alumno, programa */
select semestre, a.programa, estadoalumn, count(*)
from alumnoprograma a, alumnosemest b
where b.semestre = 20171 and  
      a.PROGRAMA > 100 AND a.PROGRAMA < 1700  and a.programa not in (404, 405, 406, 409, 410, 413) and
      a.programa = b.programa and 
      a.cedula   = b.cedula and estadoalumn in ('TERMINOMATERIAS')
group by semestre,a.programa, estadoalumn
order by semestre,a.programa, estadoalumn

/* MATRICULADOS POR TIPO PROGRAMA Y TIPO ENSEÑANZA DE PROGRAMA */
select a.semestre, titulo_tipo, ensenanza_tipo, tipoprog, count(*) matriculados 
from alumnosemest a, PROGRAMA b
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20162 and a.semestre < 20181 and  
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (404, 405, 406, 409, 410, 413) and
      a.programa = b.programa
group by a.semestre, titulo_tipo, ensenanza_tipo, tipoprog
order by a.semestre, tipoprog, ensenanza_tipo

/* MATRICULADOS DE TÉCNICAS Y TECNOLOGÍAS CON TIPO ENSEÑANZA */
select a.semestre, nombrelargo, ensenanza_tipo,count(*) matriculados 
from alumnosemest a, PROGRAMA b
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20162 and a.semestre < 20181 and  
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000) ) and 
      a.programa not in (404, 405, 406, 409, 410, 413) and
      a.programa = b.programa and titulo_tipo='TECNOLOGIA'
group by a.semestre, nombrelargo, ensenanza_tipo
order by a.semestre

/* CONTEO DE GRADUADOS POR SEMESTRE */
select ensenanza_tipo, tipoprog, substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE, COUNT(*) graduados
from grado a, programa p
where actafecha between '01-jan-2018' and '31-dec-2018' AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
       a.programa = p.programa
group by ensenanza_tipo, tipoprog, substr(to_char(actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2)
ORDER BY ensenanza_tipo, tipoprog, STRE;

/* CONTEO PROGRAMAS POR NIVEL DE FORMACIÓN, ÁREA CONOCIMIENTO Y MODALIDAD CON MATRICULADOS EN CIERTOS SEMESTRES */
select DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7) area, titulo_tipo, ensenanza_tipo, tipoprog, count(*) 
from (SELECT DISTINCT PROGRAMA FROM alumnosemest WHERE SEMESTRE IN (20171,20172) AND estadosemest not in ('PREPAR','NOMATR') AND 
     ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<80000)) and programa not in (404, 405, 406, 409, 410, 413)) a, PROGRAMA b
where  a.programa = b.programa 
group by DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7), titulo_tipo, ensenanza_tipo, tipoprog
order by AREA, titulo_tipo, ensenanza_tipo, tipoprog;

/* CONTEO PROGRAMAS POR NIVEL DE FORMACIÓN Y MODALIDAD CON MATRICULADOS EN CIERTOS SEMESTRES */
select titulo_tipo, ensenanza_tipo, tipoprog, count(*) 
from (SELECT DISTINCT PROGRAMA FROM alumnosemest WHERE SEMESTRE IN (20171,20172) AND estadosemest not in ('PREPAR','NOMATR') AND 
     ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and programa not in (404, 405, 406, 409, 410, 413)) a, PROGRAMA b
where  a.programa = b.programa 
group by titulo_tipo, ensenanza_tipo, tipoprog
order by titulo_tipo, ensenanza_tipo, tipoprog;

/* PROGRAMAS POR NIVEL DE FORMACIÓN Y MODALIDAD CON MATRICULADOS EN CIERTOS SEMESTRES */
select nombrelargo,titulo_tipo, ensenanza_tipo, tipoprog, count(*) prog
from (SELECT DISTINCT PROGRAMA FROM alumnosemest WHERE SEMESTRE IN (20171,20172) AND estadosemest not in ('PREPAR','NOMATR') AND 
     ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<61000) or (programa >= 70000 and programa<71000)) and 
       programa not in (404, 405, 406, 409, 410, 413)) a, PROGRAMA b
where  a.programa = b.programa and titulo_tipo='TECNOLOGIA'
group by nombrelargo,titulo_tipo, ensenanza_tipo, tipoprog
order by nombrelargo, titulo_tipo, ensenanza_tipo, tipoprog;

/* CONTEO DE PROGRAMAS POR CÓDIGO DE PROGRAMA POR NIVEL DE FORMACIÓN, ÁREA CONOCIMIENTO Y MODALIDAD 
CON MATRICULADOS EN CIERTOS SEMESTRES Y CONTEO DE MATERIAS DEL PRIMER Y DEL SDO NIVEL */
Select area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion, COUNT(DISTINCT X.PROGRAMA) NRO_PROG, 
    COUNT(CASE WHEN NIVEL=1 THEN 1 ELSE NULL END) Mat_niv_1,  COUNT(CASE WHEN NIVEL = 2 THEN 1 ELSE NULL END) Mat_niv_2 
from (select DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7) area, 
            a.programa, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion
      from (SELECT DISTINCT PROGRAMA FROM alumnosemest WHERE SEMESTRE IN (20171,20172) AND estadosemest not in ('PREPAR','NOMATR') AND 
                            ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<80000)) and 
                            programa not in (404, 405, 406, 409, 410, 413)) a, PROGRAMA b
where  a.programa = b.programa and facultad <> '90') X
JOIN
(SELECT distinct a.programa, nivel, MATERIA FROM PENSUM A, PROGRAMA B WHERE A.VERSION = B.VERSIONVIGENTE AND NIVEL IN (1,2) AND
                 ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (404, 405, 406, 409, 410, 413) AND 
                 a.PROGRAMA = b.PROGRAMA AND FACULTAD <> '90') Y
ON x.programa = y.programa
group by area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion
order by area, titulo_tipo, ensenanza_tipo, tipoprog;

/* CONTEO DE PROGRAMAS POR CÓDIGO SNIES POR NIVEL DE FORMACIÓN, 
ÁREA CONOCIMIENTO Y MODALIDAD CON MATRICULADOS EN CIERTOS SEMESTRES Y 
CONTEO DE MATERIAS DEL PRIMER Y DEL SDO NIVEL */
Select area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion, COUNT(DISTINCT Z.CODIGO_SNIES) NRO_PROG, 
  COUNT(CASE WHEN NIVEL = 1 THEN 1 ELSE NULL END) Mat_niv_1,  COUNT(CASE WHEN NIVEL = 2 THEN 1 ELSE NULL END) Mat_niv_2 
from (select DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7) area, 
             x.codigo_snies, titulo_tipo, ensenanza_tipo, tipoprog,ind_acreditacion
      from (SELECT distinct codigo_snies from alumnosemest a, programa b where semestre in (20171,20172) and estadosemest not in ('PREPAR','NOMATR') AND 
            ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (404, 405, 406, 409, 410, 413) and
            a.programa = b.programa and b.facultad <> '90') X, programa c where x.codigo_snies = c.codigo_snies and facultad<>'90') Z
JOIN
(SELECT distinct b.codigo_snies, nivel, MATERIA FROM PENSUM A, PROGRAMA B WHERE A.VERSION = B.VERSIONVIGENTE AND NIVEL IN (1,2) AND
                 ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (404, 405, 406, 409, 410, 413) AND 
                 a.PROGRAMA = b.PROGRAMA AND FACULTAD <> '90') Y
ON z.codigo_snies = y.codigo_snies
group by area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion
order by area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion

/* algunas especialidades no médicas del área de la salud con matriculados en 2017 para conteo de cursos anualizados quitando estos del conteo que da el query anterior */
Select area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion, COUNT(DISTINCT Z.CODIGO_SNIES) NRO_PROG, 
  COUNT(CASE WHEN NIVEL = 1 THEN 1 ELSE NULL END) Mat_niv_1,  COUNT(CASE WHEN NIVEL = 2 THEN 1 ELSE NULL END) Mat_niv_2 
from (select DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7) area, 
      x.codigo_snies, titulo_tipo, ensenanza_tipo, tipoprog,ind_acreditacion
      from (SELECT distinct codigo_snies from alumnosemest a, programa b where semestre in (20171,20172) and estadosemest not in ('PREPAR','NOMATR') AND 
            b.codigo_snies in (104065, 103919, 102132, 478, 483, 20607, 13990, 55060, 4889, 3284) and
            a.programa = b.programa) X, programa c where x.codigo_snies = c.codigo_snies) Z
JOIN
(SELECT distinct b.codigo_snies, nivel, MATERIA FROM PENSUM A, PROGRAMA B WHERE A.VERSION = B.VERSIONVIGENTE AND NIVEL IN (1,2) AND
                 b.codigo_snies in (104065, 103919, 102132, 478, 483, 20607, 13990, 55060, 4889, 3284) AND 
                 a.PROGRAMA = b.PROGRAMA) Y
ON z.codigo_snies = y.codigo_snies
group by area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion
order by area, titulo_tipo, ensenanza_tipo, tipoprog, ind_acreditacion

SELECT distinct b.facultad, a.programa, codigo_snies, ind_acreditacion from alumnosemest a, programa b where semestre in (20171,20172) and estadosemest not in ('PREPAR','NOMATR') AND 
                ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (405,406,409,410,413) and
                a.programa = b.programa and b.facultad <> '90' order by facultad, a.programa

select DECODE(FACULTAD,'2',8,'3',1,'9',5,'10',5,'11',5,'12',5,'13',5,'14',5,'16',5,'55',5,'15',6,'17',3,'25',3,'20',2,'30',4,'35',4,'40',4,'45',4,'60',4,'70',4,'75',4,'80',4,'85',4,'50',7) area, 
      x.codigo_snies, titulo_tipo, ensenanza_tipo, tipoprog,ind_acreditacion
from (SELECT distinct codigo_snies from alumnosemest a, programa b where semestre in (20171,20172) and estadosemest not in ('PREPAR','NOMATR') AND 
                     ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (404, 405, 406, 409, 410, 413) and
                     a.programa = b.programa and b.facultad <> '90') X, programa c 
where x.codigo_snies = c.codigo_snies and c.facultad<>'90' order by area, x.codigo_snies

SELECT distinct codigo_snies  from alumnosemest a, programa b where semestre in (20171,20172) and estadosemest not in ('PREPAR','NOMATR') AND 
                ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<80000)) and a.programa not in (404, 405, 406, 409, 410, 413) and
                a.programa = b.programa and b.facultad <> '90'
 
/* PRUEBA PARA ENCONTRAR CUPORESER SIN ADMISION ANTERIOR */
select substr(a.idadmision,1,5) stre, a.programa, CEDULA,  a.tipoacept
from admitido a
    where substr(a.idadmision,1,5) > 20052 and
    	 a.programa > 100 and a.programa < 50000 AND 
    	 a.tipoacept in ('CUPORESE') 
	 order by stre, a.programa, a.tipoacept;

Select substr(a.idadmision,1,5) stre, a.programa, A.CEDULA, B.stre_ANT, B.tipoacept
from admitido a, (select programa, CEDULA,TIPOACEPT, substr(idadmision,1,5) STRE_ANT FROM ADMITIDO where tipoacept<>'CUPORESE' AND 
		 			substr(idadmision,1,5) > 20041 and	programa > 100 and programa < 8000 ) B
    where substr(a.idadmision,1,5) > 20052 and
    	 a.programa > 100 and a.programa < 50000 AND 
    	 a.tipoacept in ('CUPORESE') AND
    	 A.CEDULA   = B.CEDULA AND 
		 A.PROGRAMA = B.PROGRAMA 
	 order by stre, a.programa, a.tipoacept

select * from grupoadmi order by tipo
SELECT DISTINCT A.TIPOINSC FROM INSCRITO A, GRUPOADMI B WHERE SUBSTR(a.IDADMISION,12,3) = B.TIPO AND B.ENTIDADEXTERNA='NO' AND substr(a.idadmision,1,5) > 20052 ORDER BY TIPOINSC
SELECT DISTINCT TIPOINSC FROM CUPOXTIPOINSC A, GRUPOADMI C
WHERE  substr(idadmision,1,5) > 20052 AND
SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
        C.ENTIDADEXTERNA='NO' ORDER BY TIPOINSC 

/* TIPO CUPOS DESDE 2006 */
select SUBSTR(IDADMISION,1,5) Stre, programa, tipoinsc, idcupoadic,  sum(nrocupos) nro_cupos, sum(cuposbase) cupos_base
  from cupoxtipoinsc a
  where  SUBSTR(IDADMISION,1,5)>20052 and programa>100 and SUBSTR(IDADMISION,12,3) NOT IN ('CAR','CAU')  
  group by SUBSTR(IDADMISION,1,5), programa, tipoinsc, idcupoadic 
  order by stre, programa, tipoinsc, idcupoadic;

/* TIPO INSCRITO DESDE 2006 */
Select SUBSTR(a.IDADMISION,1,5) Stre, b.programa, a.tipoinsc, c.nombre, c.tratamientoseleccion, COUNT(*) inscritos
  from inscrito a, datosopcion b , tipoaspirante c
  where SUBSTR(a.IDADMISION,1,5)>20052 and b.programa > 100 and SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and   
    a.idadmision = b.idadmision and 
    a.cedula = b.cedula and 
    a.tipoinsc = c.tipo and
    b.opcion = 1
  GROUP BY SUBSTR(a.IDADMISION,1,5), b.programa, a.tipoinsc, c.nombre, c.tratamientoseleccion
  order by Stre, b.programa, a.tipoinsc, c.nombre

/* inscritos resumido*/
Select distinct a.tipoinsc, c.nombre, c.tratamientoseleccion
  from inscrito a, datosopcion b , tipoaspirante c
  where SUBSTR(a.IDADMISION,1,5)>20052 and b.programa > 100 and SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and   
    a.idadmision = b.idadmision and 
    a.cedula = b.cedula and 
    a.tipoinsc = c.tipo and
    b.opcion = 1
    order by a.tipoinsc, c.nombre

/* MATRICULADOS DESDE 2016-1 */
select a.programa,a.semestre, count(*) matriculados 
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
	a.semestre > 20152 and  
	(a.PROGRAMA > 100 AND a.PROGRAMA < 1700) and a.programa not in (404, 405, 406, 409, 410, 413)
group by a.programa, a.semestre
order by a.programa, a.semestre;

/* Admitidos desde 2016-1 */
select SUBSTR(a.IDADMISION,1,5) stre, a.programa, count(*) admitidos
from admitido a
    where SUBSTR(a.IDADMISION,1,5)>20152 and a.programa > 100 and SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and
    GROUP BY SUBSTR(a.IDADMISION,1,5), a.programa
order by stre, a.programa

/* tipo admisión */
select distinct a.tipoacept, b.descripcion
from admitido a, tipoacept b
    where SUBSTR(a.IDADMISION,1,5)>20161 and a.programa > 100 and SUBSTR(a.IDADMISION,12,3) NOT IN ('CAR','CAU') and 
    a.tipoacept = b.tipoacept 
order by a.tipoacept

/* PROGRAMAS - TODOS */
SELECT A.facultad, CCOSTO, PROGRAMA, A.codigo_snies, A.nombrelargo, A.ESTADO, A.tipoprog, A.metodol, A.ensenanza_tipo,
       A.tipoperiodo, A.nrosemest, A.creditosgrado, A.indzonal, A.sede_principal, A.ind_acreditacion, TO_CHAR(A.fecha_acreditacion,'DDMMYYYY'),
       A.registro_calificado, A.versionvigente, A.tope, A.semestinic, A.semestfin, A.areaconocim, A.titulo_tipo, 
       TITULO, A.nombrejefe, A.telefonojefe, A.emailjefe, A.descrip_programa, A.mision_programa, PERFIL_ASPIRANTE, A.perfil_egresado 
FROM PROGRAMA A 
WHERE ((PROGRAMA > 100 AND PROGRAMA < 1700) or (programa >= 50000 and programa<80000)) and programa not in (404, 405, 406, 409, 410, 413)
ORDER BY FACULTAD,PROGRAMA;

/* Matriculados de un programa, con créditos aprobados entre un rango de semestres  para hallar estudiantes por nivel */
select a.programa,a.semestre, credaprobprogpasan, count(*) matriculados 
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
	a.semestre > 20122 and  
	a.PROGRAMA = &M_prog
group by a.programa, a.semestre, credaprobprogpasan
order by a.programa, a.semestre,credaprobprogpasan;

SELECT b.PROGRAMA, b.SEMESTRE, b.cedula, ESTRATO, estadocxc_codigo FROM (SELECT DISTINCT a.cedula, CXC_NUMERO, a.PROGRAMA, a.SEMESTRE, estadocxc_codigo, ESTRATO
FROM FACART_CXC_ESTUDIANTE a, facart_cxc b, alumnosemest c
WHERE a.SEMESTRE = 20181 and 
      a.programa > 100 and a.programa < 1700 and 
      estadocxc_codigo <> 'ANULADO' AND
      a.programa not in (404, 405, 406, 409, 410, 413) AND
      cxc_numero = numero and a.cedula=c.cedula and a.programa=c.programa and a.semestre=c.semestre ) B 
ORDER BY b.PROGRAMA, b.SEMESTRE, ESTRATO;

select x.programa, x.cedula, b.cxc_numero,b.estadocxc_codigo,b.estrato from alumnosemest x
left join 
(SELECT DISTINCT a.cedula, CXC_NUMERO, a.PROGRAMA, a.SEMESTRE, estadocxc_codigo, ESTRATO
  FROM FACART_CXC_ESTUDIANTE a, facart_cxc b, alumnosemest c
  WHERE a.SEMESTRE = 20181 and 
        a.programa > 100 and a.programa < 1700 and 
        estadocxc_codigo <> 'ANULADO' AND
        a.programa not in (404, 405, 406, 409, 410, 413) AND
        cxc_numero = numero and a.cedula=c.cedula and a.programa=c.programa and a.semestre=c.semestre ) B 
on x.cedula = b.cedula
where x.semestre='20181' and x.programa < 1700 and x.programa > 100 and x.estadosemest not in ('PREPAR','NOMATR') and x.programa not in (404, 405, 406, 409, 410, 413)


SELECT A.CEDULA,AL.NOMBREPILA,AL.PRIMAPELLIDO,AL.SDOAPELLIDO,A.PROMPROG FROM ALUMNOSEMEST A 
JOIN ALUMNO AL
ON AL.CEDULA = A.CEDULA
WHERE A.SEMESTRE = 20172 AND A.PROGRAMA = 964 AND A.PROMPROG <= 3.0

/* CONTEO DE CANCELADORES DE SEMESTRE */
SELECT A.programa,a.semestre,COUNT(*) retirados
FROM CANCSEMESTRE A 
WHERE A.SEMESTRE > 20052 AND 
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa not in (404, 405, 406, 409, 410, 413) 
GROUP BY a.PROGRAMA, a.semestre
ORDER BY a.PROGRAMA, a.semestre;



/* CONTEO DE DESERTORES CUYO ÚLTIMO SEMESTRE HAYA SIDO MAYOR A 2014-2  DE  PREGRADOS DE UNA FACULTAD */
SELECT X.STRE, X.PROGRAMA, COUNT(*) DESERTORES 
FROM (SELECT A.PROGRAMA, A.CEDULA,  MAX(SEMESTRE) STRE 
      FROM ALUMNOSEMEST A, PROGRAMA P 
      WHERE A.SEMESTRE>20142 AND A.PROGRAMA=P.PROGRAMA AND P.FACULTAD=40 AND P.PROGRAMA<1000 GROUP BY A.PROGRAMA,A.CEDULA) X, 
     (SELECT a.cedula,a.programa 
      from ALUMNOPROGRAMA A, PROGRAMA P 
      WHERE A.PROGRAMA=P.PROGRAMA AND P.FACULTAD='40' and a.programa<1000 and estadoalumn='DESERTOR' ) Y
WHERE X.CEDULA=Y.CEDULA AND X.PROGRAMA = Y.PROGRAMA 
GROUP BY X.STRE, X.PROGRAMA
ORDER BY X.STRE, X.PROGRAMA


/* Conteo estudiantes en tercio inferior de una facultad */
select semestre, a.programa, count(cedula) Nro_tercio_inferior
from alumnosemest a, programa p 
where semestre > 20142 and 
      a.programa = p.programa and 
      p.facultad='40' and 
      a.programa<1000 and 
      tercioprognivel ='TI' 
group by semestre, a.programa
order by semestre,a.programa


/* CONTEO ESTUDIANTES POR ESTRATO(QUE PAGARON MATRICULA) 15 REEMPLAZADO POR EL QUE TIENE LA CONDICIÓN DE QUE HAYA MATRICULADO
d:\bdc\caafi\datos\planos\matriculados_x_estrato.txt
*/
SELECT PROGRAMA, SEMESTRE, ESTRATO, COUNT(*) MAT_X_ESTRATO 
FROM (SELECT DISTINCT cedula, CXC_NUMERO, PROGRAMA, SEMESTRE, ESTRATO
        FROM FACART_CXC_ESTUDIANTE a, facart_cxc b
        WHERE SEMESTRE > 20052 and 
              programa > 100 and programa < 1700 and 
              estadocxc_codigo <> 'ANULADO' AND
              a.programa not in (402,404,405,406,409,410,413) and estrato > 0 AND
              cxc_numero = numero) B 
GROUP BY PROGRAMA, SEMESTRE, ESTRATO
ORDER BY PROGRAMA, SEMESTRE, ESTRATO;

/* admitidos por cambio de programa a algunos programas */
select a.programa, substr(a.idadmision,1,5) stre, a.tipoacept, count(*) admitidos
from admitido a, GRUPOADMI C 
where substr(a.idadmision,1,5)>20112 and
      ((a.PROGRAMA > 100 AND a.PROGRAMA < 1700) or (a.programa >= 50000 and a.programa<61000) or (a.programa >= 70000 and a.programa<71000)) and 
      a.programa in (1604, 1644, 1654, 1674, 1680, 1628) AND 
      SUBSTR(a.IDADMISION,12,3) = C.TIPO AND 
      C.ENTIDADEXTERNA='NO' AND    
      A.tipoACEPT in ('CAMB-PRG','CAMBSEDE') AND
      A.tipoACEPT not in ('ABELLDPT','ARTES','D644ICFE','DEPORT','DOBLETIT','F-CANO','INDIGENA','LEY1084A','LEY1084B','LEY1084C','NEGRITUD','POR-EXAM','POSGRADO','POSODONT','SUBESPEC','PREPAVAN','PREPBASI','PREPELEM','SIN-EXAM')
group by a.programa, substr(a.idadmision,1,5), a.tipoacept
order by a.programa, stre, a.tipoacept;



*************************************

/* CÁLCULO DE DESERCIÓN  versión obsoleta */
/* ADMITIDOS CASI TODOS, SE EXCLUYEN: REINGRESOS Y TRANSFERENCIAS, CAMBIO PROGRAMA, CAMBIO SEDE, CAMBIO MODALIDAD  20
d:\bdc\caafi\datos\planos\admitidos_grado.txt
*/
select substr(a.idadmision,1,5) cohorte, a.programa, a.cedula, a.tipoacept, a.opcion, X.STRE_GRADO
from admitido a
LEFT JOIN 
  (select CEDULA, PROGRAMA, substr(to_char(g.actafecha,'YYYYMMDD'),1,4)||DECODE(SUBSTR(to_char(g.actafecha,'YYYYMMDD'),5,2),'01',1,'02',1,'03',1,'04',1,'05',1,'06',1,'07',2,'08',2,'09',2,'10',2,'11',2,'12',2) STRE_GRADO from grado g  
    where  programa > 100 and programa < 1700 and ACTAFECHA > '01-JAN-2006') X
ON A.CEDULA=X.CEDULA AND A.PROGRAMA = X.PROGRAMA
where  A.programa > 100 and A.programa < 1700 and 
	substr(a.idadmision,6,9) = 'PRENUEANT' AND 
        substr(idadmision,1,4) > 2005 
ORDER BY COHORTE, A.PROGRAMA, CEDULA;


/* ADMITIDOS X PROGRAMA CON ÚLTIMO SEMESTRE Y ESTADO ALUMNO 21
d:\bdc\caafi\datos\planos\admitidos_estado.txt
*/
select x.cohorte, x.sem_ini, x.sem_fin, ap.programa, ap.cedula, ap.estadoalumn
    from alumnoprograma ap
right join
(select b.cohorte, a.programa, a.cedula, min(a.semestre) sem_ini, max(a.semestre) Sem_fin 
    from alumnosemest a, (select substr(idadmision,1,5) cohorte, programa, cedula from admitido 
                            where  programa > 100 and programa < 1700 and substr(idadmision,6,9) = 'PRENUEANT' AND 
                                   substr(idadmision,1,5) > 20052 ORDER BY COHORTE,PROGRAMA,CEDULA) B
    where a.semestre > 20052      and 
          a.semestre >= b.cohorte and
          a.programa = b.programa and
          a.cedula = b.cedula
group by b.cohorte, a.programa, a.cedula) X 
on ap.cedula = x.cedula and ap.programa = x.programa 
where ap.programa > 100 and ap.programa < 1700
order by x.cohorte, ap.programa, ap.cedula;



select a.programa,a.semestre, count(*) matriculados 
from alumnosemest a, ADMITIDO b
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20172 and  
      a.PROGRAMA = 110  AND
      A.CEDULA=B.CEDULA AND
      A.PROGRAMA = B.PROGRAMA
group by a.programa, a.semestre
order by a.programa, a.semestre;

select a.programa, a.semestre, count(*) matriculados 
from alumnosemest a, (SELECT DISTINCT CEDULA, PROGRAMA, MAX(SUBSTR(IDADMISION,1,5)) COHORTE FROM ADMITIDO WHERE PROGRAMA ='110' GROUP BY CEDULA, PROGRAMA) B
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20172 and  
      a.PROGRAMA = 110  AND
      A.PROGRAMA = B.PROGRAMA AND
      A.CEDULA = B.CEDULA
group by a.programa, a.semestre
order by a.programa, a.semestre;

select a.programa,a.semestre, count(*) matriculados 
from alumnosemest a
where A.estadosemest not in ('PREPAR','NOMATR') and
      a.semestre > 20172 and  
      a.PROGRAMA = 110  
group by a.programa, a.semestre
order by a.programa, a.semestre;

SELECT DISTINCT CEDULA, PROGRAMA, SUBSTR(IDADMISION,1,5) COHORTE FROM ADMITIDO WHERE PROGRAMA ='110' AND SUBSTR(IDADMISION,1,5)>20002;

SELECT DISTINCT CEDULA, PROGRAMA FROM ADMITIDO WHERE PROGRAMA ='110' AND SUBSTR(IDADMISION,1,5)>20002;

SELECT * FROM ADMITIDO WHERE CEDULA IN ('1000305206','1005575809','8433858') ORDER BY CEDULA,IDADMISION
