-- SCRIPT PRINCIPAL DO DESAFIO

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


-- PARTE 2 - TRANSACAO COM PROCEDURE
-- Banco: ecommerce

USE ecommerce;

DELIMITER $$

DROP PROCEDURE IF EXISTS realizar_venda $$

CREATE PROCEDURE realizar_venda(
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_estoque INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro durante a transacao. ROLLBACK realizado.' AS mensagem;
    END;

    START TRANSACTION;

    SELECT estoque
    INTO v_estoque
    FROM produtos
    WHERE id = p_produto_id
    FOR UPDATE;

    IF v_estoque IS NULL THEN
        ROLLBACK;
        SELECT 'Produto nao encontrado. Transacao cancelada.' AS mensagem;

    ELSEIF p_quantidade <= 0 THEN
        ROLLBACK;
        SELECT 'Quantidade invalida. Transacao cancelada.' AS mensagem;

    ELSEIF v_estoque < p_quantidade THEN
        ROLLBACK;
        SELECT 'Estoque insuficiente. Transacao cancelada.' AS mensagem;

    ELSE
        UPDATE produtos
        SET estoque = estoque - p_quantidade
        WHERE id = p_produto_id;

        COMMIT;

        SELECT 'Venda realizada com sucesso.' AS mensagem;
    END IF;
END $$

DELIMITER ;

-- Exemplos de execucao:
-- CALL realizar_venda(1, 2);
-- CALL realizar_venda(1, 9999);

-- Conferencia:
-- SELECT id, nome, estoque FROM produtos WHERE id = 1;
