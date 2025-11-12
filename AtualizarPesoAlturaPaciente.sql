CREATE PROC AtualizarPesoAlturaPaciente
    (@idPaciente INT,
    @altura decimal(3,2) = NULL,
    @peso decimal(5,2) = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from Paciente where idpaciente = @idpaciente)
    throw 50045, 'Paciente não cadastrado', 1

    UPDATE Paciente
    SET
        pac_altura = COALESCE(@altura, pac_altura),
        pac_peso = COALESCE(@peso, pac_peso)      
    WHERE idPaciente = @idPaciente;
    COMMIT TRAN
    SELECT 'DADOS ATUALIZADOS'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO