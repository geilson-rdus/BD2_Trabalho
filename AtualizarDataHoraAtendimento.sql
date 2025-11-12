CREATE PROC AtualizarDataHoraAtendimento
    (@idAtendimento INT,
    @dataHora datetime = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from Atendimento where idAtendimento = @idAtendimento)
    throw 50041, 'Atendimento não encontrado', 1

    UPDATE Atendimento
    SET
        atend_dataHora = COALESCE(@dataHora, atend_dataHora)
    WHERE idAtendimento = @idAtendimento;
    COMMIT TRAN
    SELECT 'Atendimento reagendado'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO