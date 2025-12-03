EXECUTE [dbo].[DatabaseBackup]
@Databases = 'janedoedb',
@Directory = 'path to directory or NULL',
@BackupType = 'LOG',
@Verify = 'Y',
@CleanupTime = 96,
@CheckSum = 'Y',
@LogToTable = 'Y'
