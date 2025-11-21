-- Check if cooldown column exists before adding it
SET @dbname = DATABASE();
SET @tablename = 'costume';
SET @columnname = 'cooldown';

SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM information_schema.COLUMNS
    WHERE (TABLE_SCHEMA = @dbname) AND (TABLE_NAME = @tablename) AND (COLUMN_NAME = @columnname)
  ) > 0,
  "SELECT 'Column cooldown already exists in costume table';",
  "ALTER TABLE `costume` ADD COLUMN (`cooldown` mediumint NOT NULL DEFAULT -1);"
));

PREPARE stmt FROM @preparedStatement;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
