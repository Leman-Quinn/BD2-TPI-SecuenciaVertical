USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_ActualizarContrasenia(@IdCuenta INT, @Contrasenia VARCHAR (30))
AS
BEGIN
	-- chequea que la cuenta exista primero
	IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE IdCuenta = @IdCuenta)
	BEGIN
		RAISERROR ('No se pudo cambiar contrase�a: Cuenta invalida.', 16, 1)
		RETURN
	END

	-- chequea que la contrase�a nueva sea distinta a la anterior
	DECLARE @ContraseniaVieja VARCHAR (30)
	SELECT @ContraseniaVieja = Contrasenia FROM Cuentas WHERE IdCuenta = @IdCuenta

	IF (@Contrasenia = @ContraseniaVieja)
	BEGIN
		RAISERROR ('No se pudo cambiar contrase�a: la nueva contrase�a no puede ser la misma que la anterior.', 16, 1)
		RETURN
	END

	BEGIN TRY
		UPDATE Cuentas
		SET Contrasenia = @Contrasenia
		WHERE IdCuenta = @IdCuenta

		PRINT ('Contrase�a actualizada exitosamente.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo cambiar contrase�a: Error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo correcto
EXEC sp_ActualizarContrasenia 24, 'UnaNuevaPassword'
GO

-- Ejemplo cuenta invalida
EXEC sp_ActualizarContrasenia 76, '1234'
GO

-- Ejemplo contrase�a repetida
EXEC sp_ActualizarContrasenia 1, '89qw12nm'
GO
