USE DBSecuenciaVertical;
GO

CREATE PROCEDURE sp_CrearCuenta (@Nombre VARCHAR(20) = NULL,
								 @Apellido VARCHAR(20) = NULL,
								 @Apodo VARCHAR(20) = NULL,
								 @Email VARCHAR (30) = NULL,
								 @Biografia VARCHAR (250) = NULL,
								 @Contrasenia VARCHAR (20),
								 @IdEstadoCuenta TINYINT,
								 @IdTipoUsuario TINYINT,
								 @IdTipoLector TINYINT = NULL)
AS
BEGIN
	-- chequea que las FK que se ingresan existan ya en las tablas padre
	IF NOT EXISTS (SELECT 1 FROM EstadoCuenta WHERE IdEstadoCuenta = @IdEstadoCuenta)
	BEGIN
		RAISERROR ('No se pudo agregar cuenta: EstadoCuenta inválido.', 16, 1)
		RETURN
	END

	IF NOT EXISTS (SELECT 1 FROM TipoUsuario WHERE IdTipoUsuario = @IdTipoUsuario)
	BEGIN
		RAISERROR ('No se pudo agregar cuenta: TipoUsuario inválido.', 16, 1)
		RETURN
	END

	IF @IdTipoLector IS NOT NULL AND NOT EXISTS (SELECT 1 FROM TipoLector WHERE IdTipoLector = @IdTipoLector)
	BEGIN
		RAISERROR ('No se pudo agregar cuenta: TipoLector inválido.', 16, 1)
		RETURN
	END

	BEGIN TRY
		-- si pasa las validaciones, inserta en tabla Cuentas
		INSERT INTO Cuentas (Nombre,
							 Apellido,
							 Apodo,
							 Email,
							 Biografia,
							 Contrasenia,
							 IdEstadoCuenta,
							 IdTipoUsuario,
							 IdTipoLector)
		VALUES (@Nombre,
				@Apellido,
				@Apodo,
				@Email,
				@Biografia,
				@Contrasenia,
				@IdEstadoCuenta,
				@IdTipoUsuario,
				@IdTipoLector)
	END TRY 

	BEGIN CATCH
		RAISERROR ('No se pudo agregar la cuenta: Error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo correcto
EXEC sp_CrearCuenta 'Pablo',
					'Poliserpi',
					'Taco',
					'Pablo@Jotmeil.com',
					'Una biografia random',
					'UnaPasswordSegura',
					1,
					1;
GO

-- Ejemplos con valores fuera del rango de las FK
EXEC sp_CrearCuenta 'Pablo',
					'Poliserpi',
					'Taco',
					'Pablo@Jotmeil.com',
					'Una biografia random',
					'UnaPasswordSegura',
					12,
					1;
GO

EXEC sp_CrearCuenta 'Pablo',
					'Poliserpi',
					'Taco',
					'Pablo@Jotmeil.com',
					'Una biografia random',
					'UnaPasswordSegura',
					1,
					17;
GO

EXEC sp_CrearCuenta 'Pablo',
					'Poliserpi',
					'Taco',
					'Pablo@Jotmeil.com',
					'Una biografia random',
					'UnaPasswordSegura',
					1,
					1,
					7;
GO