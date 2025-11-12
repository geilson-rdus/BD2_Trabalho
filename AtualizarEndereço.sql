CREATE PROC AtualizarEnderecoPaciente
    (@idPaciente INT,
    @rua varchar(100) = NULL,
    @numero varchar(10) = NULL,
    @bairro varchar(50) = NULL,
    @cidade varchar(50)  = NULL,
    @uf char(2) = NULL,
    @cep varchar(10) = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from paciente where idPaciente = @idpaciente)
    throw 50040, 'Paciente não cadastrado', 1

    UPDATE Paciente
    SET
        pac_rua = COALESCE(@rua, pac_rua),
        pac_numero = COALESCE(@numero, pac_numero),
        pac_bairro = COALESCE(@bairro, pac_bairro),
        pac_cidade = COALESCE(@cidade, pac_cidade),
        pac_uf = COALESCE(@uf, pac_uf),
        pac_cep = COALESCE(@cep, pac_cep)
    WHERE idPaciente = @idPaciente;
    COMMIT TRAN
    SELECT 'ENDEREÇO ATUALIZADO'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO