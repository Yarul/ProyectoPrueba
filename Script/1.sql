-- 2. Para obtener campos por vistas de SIAGIE 
use siagie2_20 --<--PONER NOMBRE DE LA BASE DE DATOS DE SIAGIE QA
go
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES where TABLE_TYPE='VIEW')
order by TABLE_NAME
go



use siagie2_20
SELECT *
FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE  order by CONSTRAINT_COLUMN_USAGE.TABLE_NAME


use siagie2_20
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  WHERE TABLE_NAME IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES where TABLE_TYPE='VIEW')
order by TABLE_CONSTRAINTS .TABLE_NAME

sp_columns actividades

-- 2. Para obtener campos por vistas de SIAGIE 
use siagie2_20 --<--PONER NOMBRE DE LA BASE DE DATOS DE SIAGIE QA
go
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES where TABLE_TYPE='VIEW')
order by TABLE_NAME
go


--4. Para obtener descripcion de los campos
use siagie2_20 --<--PONER NOMBRE DE LA BASE DE DATOS DE SIAGIE QA
go
SELECT sys.objects.name AS TableName, sys.columns.name AS ColumnName,
       ep.name AS PropertyName, ep.value AS Description
FROM sys.objects
INNER JOIN sys.columns ON sys.objects.object_id = sys.columns.object_id
CROSS APPLY fn_listextendedproperty(default,
                  'SCHEMA', schema_name(schema_id),
                  'TABLE', sys.objects.name, 'COLUMN', sys.columns.name) ep
ORDER BY sys.objects.name, sys.columns.column_id
go

