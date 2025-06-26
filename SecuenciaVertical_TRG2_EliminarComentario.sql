USE DBSecuenciaVertical;
GO

-- reemplaza comentarios ofensivos por una notificacion de que ha sido borrado
CREATE TRIGGER tr_Eliminar_Comentario
ON Comentarios
INSTEAD OF DELETE
AS
BEGIN
	-- chequea que el comentario no haya sido eliminado ya
	DECLARE @Comentario VARCHAR (30)
	SELECT @Comentario = Comentario FROM deleted

	IF (@Comentario = '!--- Este mensaje ha sido eliminado por su contenido ofensivo. ---!')
	BEGIN
		RAISERROR ('No se pudo eliminar comentario: el comentario ya ha sido eliminado.', 16, 1)
		RETURN
	END

	-- si pasa la validacion, procede a eliminarlo
	DECLARE @IdComentario INT
	SELECT @IdComentario = IdComentario FROM deleted;
	
	BEGIN TRY
		UPDATE Comentarios
		SET Comentario = '!--- Este mensaje ha sido eliminado por su contenido ofensivo. ---!'
		WHERE IdComentario = @IdComentario

		PRINT ('Se intentó eliminar un comentario. Se ejecutó Trigger tr_Eliminar_Comentario en su lugar.')
	END TRY

	BEGIN CATCH
		RAISERROR ('No se pudo eliminar comentario: error no definido.', 16, 1)
	END CATCH
END;
GO

-- Ejemplo de uso
DELETE FROM Comentarios
WHERE IdComentario = 54;
GO

SELECT CU.IdCuenta,
	   CU.Nombre,
	   CO.IdComentario AS 'Comentario N°', 
	   CO.Comentario,
	   ES.Descripcion AS 'Estado de cuenta',
	   CU.Bloqueo
FROM Comentarios CO
JOIN Cuentas CU ON CU.IdCuenta = CO.IdCuenta 
JOIN EstadoCuenta ES ON CU.IdEstadoCuenta = ES.IdEstadoCuenta
WHERE CO.Advertencia = 1
GO