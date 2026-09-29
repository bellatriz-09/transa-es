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

-- Conferencia:
-- SELECT id, nome, estoque FROM produtos WHERE id = 1;
