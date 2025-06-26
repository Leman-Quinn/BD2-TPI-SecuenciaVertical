USE DBSecuenciaVertical;
GO

-- estad�stica de los t�tulos mejor ranqueados
CREATE VIEW vw_ValoracionesHistorietas
AS
	SELECT H.Nombre,
		   CAST(ROUND(AVG(VNES.IdValor * 1.0), 2) AS DECIMAL(10,2)) Valoraci�n,
		   COUNT(*) as 'Total comentarios'
	FROM Valoraciones VNES
	JOIN Historietas H ON VNES.IdHistorieta = H.IdHistorieta	
	GROUP BY H.Nombre,H.CantidadPaginasActuales;
GO

-- Ejemplo de uso
SELECT *
FROM vw_ValoracionesHistorietas
ORDER BY�Valoraci�n�DESC;
GO



