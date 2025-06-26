USE DBSecuenciaVertical;
GO

-- previene la eliminacion fisica de cuentas, en lugar eliminandolas logicamente
CREATE TRIGGER tr_Eliminar_Cuenta
ON Cuentas
INSTEAD OF DELETE
AS
BEGIN
	-- chequea que la cuenta no este dada de baja primero
	DECLARE @IdEstadoCuenta INT
	SELECT @IdEstadoCuenta = IdEstadoCuenta FROM deleted

	IF (@IdEstadoCuenta = 3)
	BEGIN
		RAISERROR ('No se pudo eliminar la cuenta: IdEstadoCuenta: Baja', 16, 1)
		RETURN
	END
	
	-- si pasa la validacion, la da de baja
	DECLARE @IdCuenta INT
	SELECT @IdCuenta = IdCuenta FROM deleted

	BEGIN TRY
		UPDATE Cuentas
		SET IdEstadoCuenta = 3
		WHERE IdCuenta = @IdCuenta

		PRINT ('Se intentó eliminar una cuenta. Se ejecutó Trigger tr_Eliminar_Cuenta en su lugar.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo eliminar cuenta: error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo de uso
DELETE FROM Cuentas
WHERE IdCuenta = (SELECT IdCuenta FROM Cuentas WHERE Email = 'moncho@hotmail.com');
GO