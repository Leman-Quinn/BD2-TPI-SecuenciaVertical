USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_EliminarCuenta(@IdCuenta INT)
AS
BEGIN
	-- chequea que el IdCuenta exista primero
	IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE IdCuenta = @IdCuenta)
	BEGIN
		RAISERROR ('No se pudo eliminar cuenta: IdCuenta invalido.', 16, 1)
	END

	-- si pasa la validacion, elimina la cuenta
	BEGIN TRY
		DELETE FROM Cuentas
		WHERE IdCuenta = @IdCuenta

		PRINT ('Cuenta eliminada exitosamente.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo eliminar cuenta: error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo correcto
EXEC sp_EliminarCuenta 27;
GO

-- Ejemplo IdCuenta invalido
EXEC sp_EliminarCuenta 77;
GO