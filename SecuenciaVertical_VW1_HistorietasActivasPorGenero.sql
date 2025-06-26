USE DBSecuenciaVertical;
GO

CREATE VIEW vw_HistorietasActivasPorGenero
AS
SELECT G.Descripcion AS Genero,
	   COUNT(DISTINCT H.IdHistorieta) AS CantidadHistorietas
FROM Historietas H
JOIN HistorietaGenero HG ON H.IdHistorieta = HG.IdHistorieta
JOIN Genero G ON HG.IdGenero = G.IdGenero
JOIN EstadoPublicacion EP ON H.IdEstadoPublicacion = EP.IdEstadoPublicacion
WHERE EP.Descripcion = 'Activo'
GROUP BY G.Descripcion;
GO

-- Ejemplos de uso
SELECT *
FROM vw_HistorietasActivasPorGenero;
GO

SELECT *
FROM vw_HistorietasActivasPorGenero
WHERE Genero = 'Comedia';
GO