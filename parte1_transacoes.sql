-- PARTE 1 - TRANSACOES
-- Banco: ecommerce

USE ecommerce;

SET autocommit = 0;

-- Transacao com COMMIT
START TRANSACTION;

SELECT id, nome, estoque
FROM produtos
WHERE id = 1;

UPDATE produtos
SET estoque = estoque - 1
WHERE id = 1;

COMMIT;

SELECT id, nome, estoque
FROM produtos
WHERE id = 1;


-- Teste de ROLLBACK
START TRANSACTION;

UPDATE produtos
SET estoque = estoque - 5
WHERE id = 1;

SELECT id, nome, estoque
FROM produtos
WHERE id = 1;

ROLLBACK;

SELECT id, nome, estoque
FROM produtos
WHERE id = 1;


-- Teste de SAVEPOINT
START TRANSACTION;

UPDATE produtos
SET estoque = estoque - 2
WHERE id = 1;

SAVEPOINT estoque_atualizado;

UPDATE produtos
SET estoque = estoque - 10
WHERE id = 2;

ROLLBACK TO SAVEPOINT estoque_atualizado;

COMMIT;

SET autocommit = 1;
