# Desafio SQL - Transacoes, Procedures e Backup

## Estrutura

- `scripts/parte1_transacoes.sql`: COMMIT, ROLLBACK e SAVEPOINT.
- `scripts/parte2_procedure.sql`: procedure com transacao e tratamento de erros.
- `scripts/parte3_backup_recovery.sql`: comandos de backup e recovery com mysqldump.
- `backup/`: local destinado ao arquivo de backup gerado pelo mysqldump.

## Observacao

Os scripts consideram uma tabela `produtos` com as colunas `id`, `nome` e `estoque`.
Caso o banco fornecido na disciplina use nomes diferentes, ajuste os nomes das tabelas e colunas.

## Backup completo

No CMD/PowerShell:

```bash
mysqldump -u root -p --routines --events --triggers ecommerce > ecommerce_backup_completo.sql
```

## Recovery

```bash
mysql -u root -p ecommerce < ecommerce_backup_completo.sql
```
