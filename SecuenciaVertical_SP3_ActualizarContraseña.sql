USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_ActualizarContrasenia(@IdCuenta INT, @Contrasenia VARCHAR (30))
AS
BEGIN
	-- chequea que la cuenta exista primero
	IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE IdCuenta = @IdCuenta)
	BEGIN
		RAISERROR ('No se pudo cambiar contraseņa: Cuenta invalida.', 16, 1)
		RETURN
	END

	-- chequea que la contraseņa nueva sea distinta a la anterior
	DECLARE @ContraseniaVieja VARCHAR (30)
	SELECT @ContraseniaVieja = Contrasenia FROM Cuentas WHERE IdCuenta = @IdCuenta

	IF (@Contrasenia = @ContraseniaVieja)
	BEGIN
		RAISERROR ('No se pudo cambiar contraseņa: la nueva contraseņa no puede ser la misma que la anterior.', 16, 1)
		RETURN
	END

	BEGIN TRY
		UPDATE Cuentas
		SET Contrasenia = @Contrasenia
		WHERE IdCuenta = @IdCuenta

		PRINT ('Contraseņa actualizada exitosamente.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo cambiar contraseņa: Error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo correcto
EXEC sp_ActualizarContrasenia 24, 'UnaNuevaPassword'
GO

-- Ejemplo cuenta invalida
EXEC sp_ActualizarContrasenia 76, '1234'
GO

-- Ejemplo contraseņa repetida
EXEC sp_ActualizarContrasenia 1, '89qw12nm'
GO
