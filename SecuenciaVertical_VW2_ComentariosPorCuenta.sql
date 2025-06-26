USE DBSecuenciaVertical;
GO

CREATE VIEW WV_ComentariosPorCuenta
AS
SELECT 
    Com.IdComentario,
    C.IdCuenta,
    C.Nombre,
    C.Apellido,
    C.Apodo,
    H.Nombre AS Historieta,
    Com.Comentario
FROM Comentarios Com
JOIN Cuentas C ON com.IdCuenta = c.IdCuenta
JOIN Historietas H ON com.IdHistorieta = h.IdHistorieta;
GO

-- Ejemplo de uso
SELECT *
FROM WV_ComentariosPorCuenta