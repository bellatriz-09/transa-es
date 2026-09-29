-- PARTE 3 - BACKUP E RECOVERY
-- Estes comandos sao executados no terminal (CMD/PowerShell),
-- e nao dentro do editor SQL.

-- 1. Backup simples:
-- mysqldump -u root -p ecommerce > ecommerce_backup.sql

-- 2. Backup completo com procedures, eventos e triggers:
-- mysqldump -u root -p --routines --events --triggers ecommerce > ecommerce_backup_completo.sql

-- 3. Backup de diferentes bancos:
-- mysqldump -u root -p --routines --events --triggers --databases ecommerce empresa biblioteca > bancos_backup.sql

-- 4. Recovery:
-- Primeiro crie o banco, se necessario:
-- CREATE DATABASE ecommerce;

-- Depois, no terminal:
-- mysql -u root -p ecommerce < ecommerce_backup_completo.sql

-- 5. Conferencia no MySQL:
-- USE ecommerce;
-- SHOW TABLES;
-- SHOW PROCEDURE STATUS WHERE Db = 'ecommerce';
-- SHOW EVENTS FROM ecommerce;
-- SHOW TRIGGERS FROM ecommerce;
