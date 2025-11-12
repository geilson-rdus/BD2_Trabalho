CREATE PROC InativarMedico
    (@idMedico int,
    @status bit = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from Medico where idMedico = @idmedico)
    throw 50043, 'Medico não cadastrado', 1

    UPDATE Medico
    SET
        med_status = COALESCE(@status, med_status)
    WHERE idMedico = @idMedico;
    COMMIT TRAN
    SELECT 'MEDICO INATIVADO'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO