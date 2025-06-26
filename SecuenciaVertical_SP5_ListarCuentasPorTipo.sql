USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_ListarCuentasPorTipo(@Descripcion VARCHAR (20))
AS
BEGIN
	-- chequea que exista la descripcion ingresada
	IF NOT EXISTS (SELECT 1 FROM TipoLector WHERE Descripcion = @Descripcion)
	BEGIN
		RAISERROR ('Error al listar cuentas: TipoUsuario invalido. Tipos: "Free", "Premium".', 16, 1)
		RETURN
	END

	-- si pasa la validacion, trae la cuenta de ocurrencias de cuentas con esa descripcion
	DECLARE @Resultado INT

	SELECT @Resultado = COUNT(IdCuenta)
						FROM Cuentas C
						JOIN TipoLector TU ON C.IdTipoLector = TU.IdTipoLector
						WHERE TU.Descripcion LIKE '%' + @Descripcion + '%'

	PRINT ('Cantidad de cuentas ' + @Descripcion + ': ' + CAST(@Resultado as VARCHAR(20)))	
END;
GO

-- Ejemplo correcto
EXEC sp_ListarCuentasPorTipo 'Free';
GO

EXEC sp_ListarCuentasPorTipo 'Premium';
GO

-- Ejemplo TipoLector invalido
EXEC sp_ListarCuentasPorTipo 'Gratis';
GO