USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_ConsultaIntegrantes(@Historieta VARCHAR(50))
AS
BEGIN
	DECLARE @Filas INT

	SELECT H.Nombre, C.Nombre, C.Apellido, R.Descripcion
	FROM Historietas H
	JOIN Integrantes I ON H.IdHistorieta = I.IdHistorieta
	JOIN Roles R ON I.IdRol = R.IdRol
	JOIN Cuentas C ON I.IdCuenta = C.IdCuenta
	WHERE H.Nombre = @Historieta

	SET @Filas = @@ROWCOUNT

	IF (@Filas = 0)
	BEGIN
		RAISERROR ('El titulo no se encuentra en sistema', 16, 1)
	END
END;
GO

-- Ejemplo correcto
EXEC sp_ConsultaIntegrantes 'El gato negro';
GO

-- Ejemplo de titulo inexistente
EXEC sp_ConsultaIntegrantes 'El gato azul';
GO