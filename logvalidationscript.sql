-- Script: LogValidation.sql
-- Description: Validates log usage and forces job failure if thresholds exceeded
-- Author: Jennifer Ochonogor
-- Date: 2025-12-03

SET NOCOUNT ON;

DECLARE @MaxPercentUsed FLOAT = 70;  -- Threshold
DECLARE @FailCount INT = 0;
DECLARE @ErrorMessage NVARCHAR(500);

DECLARE @Summary TABLE (
    DatabaseName SYSNAME,
    LogSizeMB FLOAT,
    LogUsedPercent FLOAT,
    Status VARCHAR(20)
);

CREATE TABLE #LogSpace (
    DatabaseName SYSNAME,
    LogSizeMB FLOAT,
    LogUsedPercent FLOAT,
    Status INT
);

INSERT INTO #LogSpace
EXEC('DBCC SQLPERF(LOGSPACE)');

-- Evaluate each DB and classify
INSERT INTO @Summary (DatabaseName, LogSizeMB, LogUsedPercent, Status)
SELECT 
    DatabaseName,
    LogSizeMB,
    LogUsedPercent,
    CASE 
        WHEN LogUsedPercent > @MaxPercentUsed 
             AND LogSizeMB > 512000  -- 500GB threshold
        THEN 'FAILED'
        ELSE 'OK'
    END
FROM #LogSpace;

-- Count failures
SELECT @FailCount = COUNT(*) FROM @Summary WHERE Status = 'FAILED';

-- Print readable results (always visible in job history)
PRINT '===== Log File Validation Summary =====';
SELECT * FROM @Summary;

-- Build clear error message
SET @ErrorMessage = 
      'Log validation failed: ' 
    + CAST(@FailCount AS VARCHAR(10)) 
    + ' database(s) exceeded log thresholds. Check job step output for details.';

-- Throw only if violations exist
IF @FailCount > 0
BEGIN
    THROW 51002, @ErrorMessage, 1;
END
ELSE
BEGIN
    PRINT 'All databases passed log validation.';
END;

DROP TABLE #LogSpace;
