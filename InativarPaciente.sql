CREATE PROC InativarPaciente
    (@idPaciente INT,
    @status bit = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from Paciente where idpaciente = @idpaciente)
    throw 50042, 'Paciente não cadastrado', 1

    UPDATE Paciente
    SET
        pac_nome = COALESCE(@nome, pac_nome),
        pac_status = COALESCE(@status, pac_status)
    WHERE idPaciente = @idPaciente;
    COMMIT TRAN
    SELECT 'PACIENTE INATIVADO'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO