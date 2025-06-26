USE DBSecuenciaVertical;
GO

-- borra los comentarios de una cuenta y la bloquea
CREATE PROCEDURE sp_Bloqueo_Cuenta (@IdComentario INT)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM Comentarios WHERE IdComentario = @IdComentario

			UPDATE Cuentas
			SET Bloqueo = DATEADD(DAY, 15, GETDATE()),
						  IdEstadoCuenta = 2
			WHERE IdCuenta = (SELECT IdCuenta FROM Comentarios WHERE IdComentario = @IdComentario)	
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo actualizar el estado: error no definido.',16,1)
	END CATCH
END;
GO

-- Ejemplo de uso
EXEC sp_Bloqueo_Cuenta 54;
GO