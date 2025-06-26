CREATE DATABASE DBSecuenciaVertical;
GO

USE DBSecuenciaVertical;
GO

-- Tabla 1 EstadoCuenta
CREATE TABLE EstadoCuenta(
	IdEstadoCuenta TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_EstadoCuenta
		PRIMARY KEY (IdEstadoCuenta)
);
GO

-- Tabla 2 TipoUsuario
CREATE TABLE TipoUsuario(
	IdTipoUsuario TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_TipoUsuario
		PRIMARY KEY (IdTipoUsuario)
);
GO

-- Tabla 3 TipoLector
CREATE TABLE TipoLector(
	IdTipoLector TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_TipoLector
		PRIMARY KEY (IdTipoLector)
);
GO

-- Tabla 4 Cuentas
CREATE TABLE Cuentas(
	IdCuenta INT  IDENTITY (1, 1), -- PK
	Contrasenia VARCHAR(20) NOT NULL,
	IdEstadoCuenta TINYINT NOT NULL, -- FK
	IdTipoUsuario TINYINT NOT NULL, -- FK
	Email VARCHAR(30),
	Telefono VARCHAR(20),
	Nombre VARCHAR(20) NOT NULL,
	Apellido VARCHAR(20),
	Apodo VARCHAR(20),
	Biografia VARCHAR(250),
	IdTipoLector TINYINT, -- FK,
	Bloqueo DATETIME DEFAULT '2000-01-01 00:00:00',


	CONSTRAINT PK_Cuentas
		PRIMARY KEY (IdCuenta),
	CONSTRAINT FK_Cuentas_EstadoCuenta
		FOREIGN KEY (IdEstadoCuenta)
		REFERENCES EstadoCuenta(IdEstadoCuenta),
	CONSTRAINT FK_Cuentas_TipoUsuario
		FOREIGN KEY (IdTipoUsuario)
		REFERENCES TipoUsuario(IdTipoUsuario),
	CONSTRAINT FK_Cuentas_TipoLector
		FOREIGN KEY (IdTipoLector)
		REFERENCES TipoLector(IdTipoLector)
);
GO

-- Tabla 5 RedesSociales
CREATE TABLE RedesSociales(
	IdRedSocial INT IDENTITY (1, 1), -- PK
	IdCuenta INT, -- FK
	Url VARCHAR(100),

	CONSTRAINT PK_RedesSociales
		PRIMARY KEY (IdRedSocial),
	CONSTRAINT FK_RedesSociales_Cuentas
		FOREIGN KEY (IdCuenta)
		REFERENCES Cuentas(IdCuenta)
);
GO

-- Tabla 6 Roles
CREATE TABLE Roles(
	IdRol TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(100) NOT NULL,

	CONSTRAINT PK_Roles
		PRIMARY KEY (IdRol)
);
GO

-- Tabla 7 Genero
CREATE TABLE Genero(
	IdGenero TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Genero
		PRIMARY KEY (IdGenero)
);
GO

-- Tabla 8 EstadoPublicacion
CREATE TABLE EstadoPublicacion(
	IdEstadoPublicacion TINYINT IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_EstadoPublicacion
		PRIMARY KEY (IdEstadoPublicacion)
);
GO

-- Tabla 9 Historietas
CREATE TABLE Historietas(
	IdHistorieta INT IDENTITY (1, 1), -- PK
	Nombre VARCHAR (50) NOT NULL,
	Sinopsis VARCHAR(250) NOT NULL,
	CantidadPaginasActuales SMALLINT NOT NULL,
	TotalPaginas SMALLINT NOT NULL,
	MaterialExtra BIT DEFAULT 0 NOT NULL,
	IdEstadoPublicacion TINYINT NOT NULL, -- FK
	FechaProximaPublicacion DATE,

	CONSTRAINT PK_Historietas
		PRIMARY KEY (IdHistorieta),
	CONSTRAINT FK_Historietas_EstadoPublicacion
		FOREIGN KEY (IdEstadoPublicacion)
		REFERENCES EstadoPublicacion(IdEstadoPublicacion)
);
GO

-- Tabla 10 HistorietaGenero
CREATE TABLE HistorietaGenero(
	IdHistorieta INT NOT NULL, -- PK
	IdGenero TINYINT NOT NULL, -- PK
		
	CONSTRAINT PK_HistorietaGenero
		PRIMARY KEY (IdHistorieta, IdGenero),
	CONSTRAINT FK_HistorietaGenero_Genero
		FOREIGN KEY (IdGenero)
		REFERENCES Genero(IdGenero),
	CONSTRAINT FK_HistorietaGenero_Historieta
		FOREIGN KEY (IdHistorieta)
		REFERENCES Historietas(IdHistorieta)
);
GO

-- Tabla 11 Integrantes
CREATE TABLE Integrantes(
	IdIntegrante INT IDENTITY (1, 1), -- PK
	IdHistorieta INT NOT NULL, -- FK
	IdRol TINYINT NOT NULL, -- FK
	IdCuenta INT NULL, -- FK

	CONSTRAINT PK_IdIntegrante
		PRIMARY KEY (IdIntegrante),
	CONSTRAINT FK_Integrantes_Historietas
		FOREIGN KEY (IdHistorieta)
		REFERENCES Historietas(IdHistorieta),
	CONSTRAINT FK_Integrantes_Roles
		FOREIGN KEY (IdRol)
		REFERENCES Roles(IdRol),
	CONSTRAINT FK_Integrantes_Cuentas
		FOREIGN KEY (IdCuenta)
		REFERENCES Cuentas(IdCuenta)
);
GO

-- Tabla 12 Capitulos
CREATE TABLE Capitulos(
	IdCapitulo TINYINT IDENTITY (1, 1), -- PK
	IdHistorieta INT NOT NULL, -- FK
	Titulo VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(200),
	UrlImagenCaratula VARCHAR(100) NOT NULL,
	Premium BIT DEFAULT 0 NOT NULL,

	CONSTRAINT PK_IdCapitulo
		PRIMARY KEY (IdCapitulo),
	CONSTRAINT FK_Capitulos_Historietas
		FOREIGN KEY (IdHistorieta)
		REFERENCES Historietas(IdHistorieta)
);
GO

-- Tabla 13 Paginas
CREATE TABLE Paginas(
	IdPagina SMALLINT IDENTITY (1, 1), -- PK
	IdCapitulo TINYINT NOT NULL, -- FK
	Orientacion BIT DEFAULT 0,
	UrlPagina VARCHAR (100) NOT NULL,

	CONSTRAINT PK_Paginas
		PRIMARY KEY (IdPagina),
	CONSTRAINT FK_Paginas_Capitulos
		FOREIGN KEY (IdCapitulo)
		REFERENCES Capitulos(IdCapitulo)
);
GO

-- Tabla 14 Comentarios
CREATE TABLE Comentarios(
	IdComentario INT  IDENTITY (1, 1), -- PK
	IdCuenta INT NOT NULL, -- FK
	IdHistorieta INT NOT NULL, -- FK
	Comentario VARCHAR(250) NOT NULL,
	Advertencia BIT DEFAULT 0,

	CONSTRAINT PK_Comentarios
		PRIMARY KEY (IdComentario),
	CONSTRAINT FK_Comentarios_Cuentas
		FOREIGN KEY (IdCuenta)
		REFERENCES Cuentas(IdCuenta),
	CONSTRAINT FK_Comentarios_Historietas
		FOREIGN KEY (IdHistorieta)
		REFERENCES Historietas(IdHistorieta)
);
GO

-- Tabla 15 Valores
CREATE TABLE Valores(
	IdValor INT  IDENTITY (1, 1), -- PK
	Descripcion VARCHAR(20) NOT NULL,

	CONSTRAINT PK_Valores
		PRIMARY KEY (IdValor)
);
GO

-- Tabla 16 Valoraciones
CREATE TABLE Valoraciones(
	IdHistorieta INT NOT NULL, -- PK
	IdCuenta INT NOT NULL, -- PK
	IdValor INT NOT NULL, -- FK

	CONSTRAINT PK_Valoraciones
		PRIMARY KEY (IdHistorieta, IdCuenta),
	CONSTRAINT FK_Valoraciones_Historieta
		FOREIGN KEY (IdHistorieta)
		REFERENCES Historietas(IdHistorieta),
	CONSTRAINT FK_Valoraciones_Cuentas
		FOREIGN KEY (IdCuenta)
		REFERENCES Cuentas(IdCuenta),
	CONSTRAINT FK_Valoraciones_Valores
		FOREIGN KEY (IdValor)
		REFERENCES Valores(IdValor)
);
GO