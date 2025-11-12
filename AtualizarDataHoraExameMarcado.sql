CREATE PROC AtualizarDataHoraExame
    (@idExame INT,
    @dataHora datetime = NULL)
AS
BEGIN
BEGIN TRY
    BEGIN TRAN
    if not exists(select * from exameMarcado where idExameMarcado = @idExame)
    throw 50046, 'Exame não encontrado', 1

    UPDATE ExameMarcado
    SET
        examMarc_dataHora = COALESCE(@dataHora,examMarc_dataHora)
    WHERE idExameMarcado = @idExame;
    COMMIT TRAN
    SELECT 'Exame reagendado'
END TRY
BEGIN CATCH
    ROLLBACK TRAN
    SELECT 'ERRO ' + ERROR_MESSAGE()
END CATCH
END;
GO