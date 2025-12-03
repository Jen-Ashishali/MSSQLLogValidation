-- Query Logspace
dbcc sqlperf(logspace);

--  Query list of files
use janedoedb
select * from sys.database_files
order by type_desc



use janedoedb
ALTER DATABASE janedoedb
SET RECOVERY SIMPLE;
GO  

-- Shrink the truncated log file to 1 MB.  
DBCC SHRINKFILE (janedoedb_log, 1);
GO  

-- Reset the database recovery model.  
ALTER DATABASE janedoedb
SET RECOVERY FULL;
GO