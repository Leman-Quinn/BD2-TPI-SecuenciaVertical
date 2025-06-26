USE DBSecuenciaVertical;
GO

-- chequea que la cuenta se encuentre activa para ver si puede realizar un comentario o no
CREATE TRIGGER tr_InsertarComentario
ON Comentarios
INSTEAD OF INSERT
AS
BEGIN
	BEGIN TRY
		DECLARE @IdEstadoActivo TINYINT;
		SELECT @IdEstadoActivo = IdEstadoCuenta FROM EstadoCuenta
		WHERE Descripcion = 'Activo';

		-- chequea que la cuenta se encuentre activa
		 IF NOT EXISTS (SELECT 1
						FROM inserted i
						JOIN Cuentas c ON i.IdCuenta = c.IdCuenta
						WHERE c.IdEstadoCuenta = @IdEstadoActivo) 
		BEGIN
			PRINT ('No se pudo añadir el comentario: Cuenta inactiva.');
			RETURN;
		END

		-- si pasa la validacion, inserta el comentario y lo muestra por pantalla
		INSERT INTO Comentarios (IdCuenta, IdHistorieta, Comentario, Advertencia)
		SELECT i.IdCuenta, i.IdHistorieta, i.Comentario, i.Advertencia
		FROM inserted i
		JOIN Cuentas c ON i.IdCuenta = c.IdCuenta
		WHERE c.IdEstadoCuenta = @IdEstadoActivo;

		PRINT ('Se quiso añadir un comentario de una cuenta inactiva. Se ejecuto trigger tr_InsertarComentario en su lugar.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo añadir el comentario: error no definido.', 16, 1)
	END CATCH  
END;
GO

-- Ejemplo de uso
INSERT INTO Comentarios (IdCuenta, IdHistorieta, Comentario, Advertencia)
VALUES (5, 9, 'Un comentario ofensivo de una cuenta bloqueada', 1)