USE [MovieStore]
GO
/****** Object:  Table [dbo].[tAlquiler]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAlquiler](
	[alquilerID] [int] IDENTITY(200,1) NOT NULL,
	[usuario] [int] NOT NULL,
	[pelicula] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[devuelto] [bit] NULL,
	[fecha_devolucion] [datetime] NOT NULL,
 CONSTRAINT [PK_tAlquiler] PRIMARY KEY CLUSTERED 
(
	[alquilerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tGenero]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tGenero](
	[cod_genero] [int] IDENTITY(1,1) NOT NULL,
	[txt_desc] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tGeneroPelicula]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tGeneroPelicula](
	[cod_pelicula] [int] NOT NULL,
	[cod_genero] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_pelicula] ASC,
	[cod_genero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPelicula]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPelicula](
	[cod_pelicula] [int] IDENTITY(1,1) NOT NULL,
	[txt_desc] [varchar](500) NULL,
	[cant_disponibles_alquiler] [int] NULL,
	[cant_disponibles_venta] [int] NULL,
	[precio_alquiler] [numeric](18, 2) NULL,
	[precio_venta] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_pelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tRol]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tRol](
	[cod_rol] [int] IDENTITY(1,1) NOT NULL,
	[txt_desc] [varchar](500) NULL,
	[sn_activo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tUsers]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tUsers](
	[cod_usuario] [int] IDENTITY(1,1) NOT NULL,
	[txt_user] [varchar](50) NULL,
	[txt_password] [varchar](50) NULL,
	[txt_nombre] [varchar](200) NULL,
	[txt_apellido] [varchar](200) NULL,
	[nro_doc] [varchar](50) NULL,
	[cod_rol] [int] NULL,
	[sn_activo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tVentas]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tVentas](
	[ventaID] [int] IDENTITY(100,1) NOT NULL,
	[usuario] [int] NOT NULL,
	[pelicula] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_tVentas] PRIMARY KEY CLUSTERED 
(
	[ventaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tAlquiler]  WITH CHECK ADD  CONSTRAINT [FK_tAlquiler_tPelicula] FOREIGN KEY([pelicula])
REFERENCES [dbo].[tPelicula] ([cod_pelicula])
GO
ALTER TABLE [dbo].[tAlquiler] CHECK CONSTRAINT [FK_tAlquiler_tPelicula]
GO
ALTER TABLE [dbo].[tAlquiler]  WITH CHECK ADD  CONSTRAINT [FK_tAlquiler_tUsers] FOREIGN KEY([usuario])
REFERENCES [dbo].[tUsers] ([cod_usuario])
GO
ALTER TABLE [dbo].[tAlquiler] CHECK CONSTRAINT [FK_tAlquiler_tUsers]
GO
ALTER TABLE [dbo].[tGeneroPelicula]  WITH CHECK ADD  CONSTRAINT [fk_genero_pelicula] FOREIGN KEY([cod_pelicula])
REFERENCES [dbo].[tPelicula] ([cod_pelicula])
GO
ALTER TABLE [dbo].[tGeneroPelicula] CHECK CONSTRAINT [fk_genero_pelicula]
GO
ALTER TABLE [dbo].[tGeneroPelicula]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_genero] FOREIGN KEY([cod_genero])
REFERENCES [dbo].[tGenero] ([cod_genero])
GO
ALTER TABLE [dbo].[tGeneroPelicula] CHECK CONSTRAINT [fk_pelicula_genero]
GO
ALTER TABLE [dbo].[tUsers]  WITH CHECK ADD  CONSTRAINT [fk_user_rol] FOREIGN KEY([cod_rol])
REFERENCES [dbo].[tRol] ([cod_rol])
GO
ALTER TABLE [dbo].[tUsers] CHECK CONSTRAINT [fk_user_rol]
GO
ALTER TABLE [dbo].[tVentas]  WITH CHECK ADD  CONSTRAINT [FK_tVentas_tPelicula] FOREIGN KEY([pelicula])
REFERENCES [dbo].[tPelicula] ([cod_pelicula])
GO
ALTER TABLE [dbo].[tVentas] CHECK CONSTRAINT [FK_tVentas_tPelicula]
GO
ALTER TABLE [dbo].[tVentas]  WITH CHECK ADD  CONSTRAINT [FK_tVentas_tUsers] FOREIGN KEY([usuario])
REFERENCES [dbo].[tUsers] ([cod_usuario])
GO
ALTER TABLE [dbo].[tVentas] CHECK CONSTRAINT [FK_tVentas_tUsers]
GO
/****** Object:  StoredProcedure [dbo].[AGREGARGENERO]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AGREGARGENERO]
@txt_desc varchar(500) = NULL
AS
BEGIN
  SET NOCOUNT ON
  INSERT INTO tGenero(
	txt_desc
	)
	VALUES
	(
		@txt_desc
	)
END
GO
/****** Object:  StoredProcedure [dbo].[AGREGARPELICULA]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AGREGARPELICULA]
@txt_desc varchar(500),
@cant_disponibles_alquiler int = NULL,
@cant_disponibles_venta int = NULL,
@precio_alquiler numeric(18,2)  = NULL,
@precio_venta numeric(18,2) = NULL
AS
BEGIN
  SET NOCOUNT ON
  INSERT INTO tPelicula(
	txt_desc,
	cant_disponibles_alquiler,
	cant_disponibles_venta,
	precio_alquiler, 
	precio_venta
	)
	VALUES
	(
		@txt_desc,
		@cant_disponibles_alquiler,
		@cant_disponibles_venta,
		@precio_alquiler,
		@precio_venta
	)
END
GO
/****** Object:  StoredProcedure [dbo].[AGREGARUSER]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AGREGARUSER]
@txt_user varchar(50) = NULL,
@txt_password varchar(50) = NULL,
@txt_nombre varchar(50) = NULL,
@txt_apellido varchar(50) = NULL,
@nro_doc varchar(50),
@cod_rol int = NULL,
@sn_activo int = NULL
AS
IF EXISTS (SELECT * FROM tUsers WHERE nro_doc = @nro_doc)
BEGIN 
	RAISERROR('ESTE REGISTRO EXISTE',0,0)
END
ELSE
BEGIN
  SET NOCOUNT ON
  INSERT INTO tUsers(
	txt_user,
	txt_password,
	txt_nombre,
	txt_apellido, 
	nro_doc,
	cod_rol,
	sn_activo
	)
	VALUES
	(
		@txt_user,
		@txt_password,
		@txt_nombre,
		@txt_apellido,
		@nro_doc,
		@cod_rol,
		@sn_activo
	)
END
GO
/****** Object:  StoredProcedure [dbo].[ALQUILADAS_USUARIO]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ALQUILADAS_USUARIO]
@usuario int = NULL
AS
BEGIN
	SELECT p.txt_desc, total, fecha
	FROM tAlquiler a
	INNER JOIN tPelicula p
	ON a.pelicula = p.cod_pelicula
	INNER JOIN tUsers u
	ON a.usuario = u.cod_usuario
	WHERE a.usuario = @usuario
END
GO
/****** Object:  StoredProcedure [dbo].[ALQUILAR_PELICULAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ALQUILAR_PELICULAS]
@usuario int = NULL,
@pelicula int = NULL,
@fecha datetime = NULL,
@fecha_devolucion datetime = NULL
AS
BEGIN
DECLARE @VENTAS INT =  (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula)
	IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) > 0
	BEGIN
		SET NOCOUNT ON
		INSERT INTO tAlquiler(
			usuario,
			pelicula,
			fecha,
			total,
			devuelto,
			fecha_devolucion
		)
		SELECT @usuario, @pelicula, @fecha, precio_alquiler, 0, @fecha_devolucion
		FROM tPelicula 
		WHERE cod_pelicula = @pelicula

		UPDATE tPelicula
			SET cant_disponibles_alquiler = cant_disponibles_alquiler - 1
				WHERE cod_pelicula = @pelicula
		BEGIN
			DECLARE @ALQUILER_REST INT =  (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula)
			IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			BEGIN
				PRINT('ESTA FUE LA ÚLTIMA UNIDAD EN INVENTARIO DISPONIBLE PARA ALQUILER DE ESTA PELÍCULA.')
			END
			ELSE IF(SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			BEGIN
				PRINT('QUEDA SOLO UNA UNIDAD DISPONIBLE EN INVENTARIO PARA ALQUILER DE ESTA PELÍCULA.')
			END
			ELSE
			BEGIN
				PRINT(CONCAT('QUEDAN ', @ALQUILER_REST, ' UNIDADES DISPONIBLES PARA ALQUILER DE ESTA PELÍCULA.'))
			END
		END
	END
	ELSE
	BEGIN
		IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			RAISERROR('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER NI DE VENTA DE ESTA PELÍCULA.',0,0)
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			PRINT('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER PERO SI UNA ÚNICA UNIDAD DISPONIBLE PARA VENTA DE ESTA PELÍCULA.')
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) > 1
			PRINT(CONCAT('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER PERO SI ', @VENTAS, ' UNIDADES DISPONIBLES PARA VENTA DE ESTA PELÍCULA.'))
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ALQUILAR_VENDERPELICULAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ALQUILAR_VENDERPELICULAS]
@tipo_proceso NVARCHAR(20) = '',
@usuario int = NULL,
@pelicula int = NULL,
@fecha datetime = NULL,
@fecha_devolucion datetime = NULL
AS
IF @tipo_proceso = 'VENDER'
BEGIN 
DECLARE @ALQUILER INT =  (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula)
	IF (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) > 0
	BEGIN
		SET NOCOUNT ON
		INSERT INTO tVentas(
			usuario,
			pelicula,
			fecha,
			total
			)
			SELECT @usuario, @pelicula, @fecha, precio_venta 
			FROM tPelicula 
			WHERE cod_pelicula = @pelicula

		UPDATE tPelicula
			SET cant_disponibles_venta = cant_disponibles_venta - 1
				WHERE cod_pelicula = @pelicula

		BEGIN
			DECLARE @VENTAS_REST INT =  (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula)
			IF (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			BEGIN
				PRINT('ESTA FUE LA ÚLTIMA UNIDAD EN INVENTARIO DISPONIBLE PARA VENTA DE ESTA PELÍCULA.')
			END
			ELSE IF(SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			BEGIN
				PRINT('QUEDA SOLO UNA UNIDAD DISPONIBLE EN INVENTARIO PARA VENTA DE ESTA PELÍCULA.')
			END
			ELSE
			BEGIN
				PRINT(CONCAT('QUEDAN ', @VENTAS_REST, ' UNIDADES DISPONIBLES PARA VENTA DE ESTA PELÍCULA.'))
			END
		END
	END
	ELSE
	BEGIN
		IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			RAISERROR('NO QUEDAN UNIDADES DISPONIBLES DE VENTA NI DE ALQUILER DE ESTA PELÍCULA.',0,0)
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) > 1 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			PRINT(CONCAT('NO QUEDAN UNIDADES DISPONIBLES DE VENTA PERO SI ', @ALQUILER, ' UNIDADES DISPONIBLES PARA ALQUILER DE ESTA PELÍCULA.'))
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 1 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			PRINT('NO QUEDAN UNIDADES DISPONIBLES DE VENTA PERO SI UNA ÚNICA UNIDAD DISPONIBLE PARA ALQUILER DE ESTA PELÍCULA.')
	END
END
IF @tipo_proceso = 'ALQUILAR'
BEGIN
DECLARE @VENTAS INT =  (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula)
	IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) > 0
	BEGIN
		SET NOCOUNT ON
		INSERT INTO tAlquiler(
			usuario,
			pelicula,
			fecha,
			total,
			devuelto,
			fecha_devolucion
		)
		SELECT @usuario, @pelicula, @fecha, precio_alquiler, 0, @fecha_devolucion
		FROM tPelicula 
		WHERE cod_pelicula = @pelicula

		UPDATE tPelicula
			SET cant_disponibles_alquiler = cant_disponibles_alquiler - 1
				WHERE cod_pelicula = @pelicula
		BEGIN
			DECLARE @ALQUILER_REST INT =  (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula)
			IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			BEGIN
				PRINT('ESTA FUE LA ÚLTIMA UNIDAD EN INVENTARIO DISPONIBLE PARA ALQUILER DE ESTA PELÍCULA.')
			END
			ELSE IF(SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			BEGIN
				PRINT('QUEDA SOLO UNA UNIDAD DISPONIBLE EN INVENTARIO PARA ALQUILER DE ESTA PELÍCULA.')
			END
			ELSE
			BEGIN
				PRINT(CONCAT('QUEDAN ', @ALQUILER_REST, ' UNIDADES DISPONIBLES PARA ALQUILER DE ESTA PELÍCULA.'))
			END
		END
	END
	ELSE
	BEGIN
		IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			RAISERROR('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER NI DE VENTA DE ESTA PELÍCULA.',0,0)
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			PRINT('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER PERO SI UNA ÚNICA UNIDAD DISPONIBLE PARA VENTA DE ESTA PELÍCULA.')
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) > 1
			PRINT(CONCAT('NO QUEDAN UNIDADES DISPONIBLES DE ALQUILER PERO SI ', @VENTAS, ' UNIDADES DISPONIBLES PARA VENTA DE ESTA PELÍCULA.'))
	END
END
GO
/****** Object:  StoredProcedure [dbo].[ASIGNARGENERO]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ASIGNARGENERO]
@cod_pelicula int = NULL,
@cod_genero int = NULL
AS
IF EXISTS (SELECT * FROM tGeneroPelicula WHERE cod_pelicula = @cod_pelicula)
BEGIN 
	RAISERROR('ESTA PELÍCULA YA TIENE UN GÉNERO ASIGNADO.',0,0)
END
ELSE
BEGIN
  SET NOCOUNT ON
  INSERT INTO tGeneroPelicula(
	cod_pelicula,
	cod_genero
	)
	VALUES
	(
		@cod_pelicula,
		@cod_genero
	)
END
GO
/****** Object:  StoredProcedure [dbo].[BORRARPELICULA]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BORRARPELICULA]
@cod_pelicula int
AS
BEGIN
  SET NOCOUNT ON
  UPDATE tPelicula
	SET cant_disponibles_alquiler = 0,
		cant_disponibles_venta = 0
	WHERE cod_pelicula = @cod_pelicula
END
GO
/****** Object:  StoredProcedure [dbo].[DEVOLVER_PELICULA]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DEVOLVER_PELICULA]
@usuario int = NULL,
@pelicula int = NULL
AS
BEGIN
	SET NOCOUNT ON
	IF(SELECT COUNT(*) FROM tAlquiler WHERE usuario = @usuario AND pelicula = @pelicula) > 0
		UPDATE tAlquiler
		SET devuelto = 1
		WHERE usuario = @usuario AND pelicula = @pelicula
	ELSE
		RAISERROR('ESTE USUARIO NO TIENE DEVOLUCIONES PENDIENTES DE ESTA PELÍCULA.',0,0)
END
GO
/****** Object:  StoredProcedure [dbo].[MODIFICARPELICULA]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MODIFICARPELICULA]
@cod_pelicula int,
@txt_desc varchar(500) = NULL,
@cant_disponibles_alquiler int = NULL,
@cant_disponibles_venta int = NULL,
@precio_alquiler numeric(18,2)  = NULL,
@precio_venta numeric(18,2) = NULL
AS
BEGIN
  SET NOCOUNT ON
  UPDATE tPelicula
	SET txt_desc = ISNULL(@txt_desc, txt_desc),
		cant_disponibles_alquiler = ISNULL(@cant_disponibles_alquiler, cant_disponibles_alquiler),
		cant_disponibles_venta = ISNULL(@cant_disponibles_venta, cant_disponibles_venta),
		precio_alquiler = ISNULL(@precio_alquiler, precio_alquiler), 
		precio_venta = ISNULL(@precio_venta, precio_venta)
	WHERE cod_pelicula = @cod_pelicula
END
GO
/****** Object:  StoredProcedure [dbo].[PELICULAS_ALQUILADAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PELICULAS_ALQUILADAS]
AS
BEGIN
	SELECT usuario, CONCAT(u.txt_nombre, ' ', u.txt_apellido) AS nombre_usuario, u.txt_user, p.txt_desc, total, fecha
	FROM tAlquiler a
	INNER JOIN tPelicula p
	ON a.pelicula = p.cod_pelicula
	INNER JOIN tUsers u
	ON a.usuario = u.cod_usuario
END
GO
/****** Object:  StoredProcedure [dbo].[PENDIENTES_DEVOLUCION]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PENDIENTES_DEVOLUCION]
AS
BEGIN
	SET NOCOUNT ON
	IF(SELECT COUNT(*) FROM tAlquiler WHERE devuelto = 0) > 0
		SELECT alquilerID, usuario, CONCAT(u.txt_nombre, ' ', u.txt_apellido) AS nombre_usuario, u.txt_user, u.nro_doc, p.txt_desc as Pelicula, fecha_devolucion
		FROM tAlquiler a
		INNER JOIN tUsers u
		ON a.usuario = u.cod_usuario
		INNER JOIN  tPelicula p
		ON a.pelicula = p.cod_pelicula
		WHERE devuelto = 0
	ELSE
		RAISERROR('TODAS LAS PELÍCULAS EN ALQUILER FUERON DEVUELTAS.',0,0)
END
GO
/****** Object:  StoredProcedure [dbo].[RECAUDACION_PELICULAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RECAUDACION_PELICULAS]
AS
BEGIN
	SELECT a.pelicula, p.txt_desc,COUNT(a.pelicula) as 'Cantidad_veces_alquiladas', SUM(a.total) as 'Total_recaudado_alquiler'
	from tAlquiler a
	INNER JOIN tPelicula p
	ON a.pelicula = p.cod_pelicula
	Group by a.pelicula, p.txt_desc
END
GO
/****** Object:  StoredProcedure [dbo].[STOCK_ALQUILER]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STOCK_ALQUILER]
AS
BEGIN
	IF(SELECT COUNT(*) FROM tPelicula WHERE cant_disponibles_alquiler > 0) > 0
		SELECT cod_pelicula, txt_desc,cant_disponibles_alquiler, precio_alquiler
		FROM tPelicula
		WHERE cant_disponibles_alquiler > 0
	ELSE
		RAISERROR('NO QUEDAN UNIDADES DISPONIBLES PARA ALQUILER DE NINGUNA PELÍCULA.',0,0)
END
GO
/****** Object:  StoredProcedure [dbo].[STOCK_VENTAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[STOCK_VENTAS]
AS
BEGIN
	IF(SELECT COUNT(*) FROM tPelicula WHERE cant_disponibles_venta > 0) > 0
		SELECT cod_pelicula, txt_desc,cant_disponibles_venta, precio_venta
		FROM tPelicula
		WHERE cant_disponibles_venta > 0
	ELSE
		RAISERROR('NO QUEDAN UNIDADES DISPONIBLES PARA VENTA DE NINGUNA PELÍCULA.',0,0)
END
GO
/****** Object:  StoredProcedure [dbo].[VENDER_PELICULAS]    Script Date: 8/11/2022 2:13:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[VENDER_PELICULAS]
@usuario int = NULL,
@pelicula int = NULL,
@fecha datetime = NULL
AS
DECLARE @ALQUILER INT =  (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula)
BEGIN 
	IF (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) > 0
	BEGIN
		SET NOCOUNT ON
		INSERT INTO tVentas(
			usuario,
			pelicula,
			fecha,
			total
			)
			SELECT @usuario, @pelicula, @fecha, precio_venta 
			FROM tPelicula 
			WHERE cod_pelicula = @pelicula

		UPDATE tPelicula
			SET cant_disponibles_venta = cant_disponibles_venta - 1
				WHERE cod_pelicula = @pelicula

		BEGIN
			DECLARE @VENTAS_REST INT =  (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula)
			IF (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			BEGIN
				PRINT('ESTA FUE LA ÚLTIMA UNIDAD EN INVENTARIO DISPONIBLE PARA VENTA DE ESTA PELÍCULA.')
			END
			ELSE IF(SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 1
			BEGIN
				PRINT('QUEDA SOLO UNA UNIDAD DISPONIBLE EN INVENTARIO PARA VENTA DE ESTA PELÍCULA.')
			END
			ELSE
			BEGIN
				PRINT(CONCAT('QUEDAN ', @VENTAS_REST, ' UNIDADES DISPONIBLES PARA VENTA DE ESTA PELÍCULA.'))
			END
		END
	END
	ELSE
	BEGIN
		IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 0 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			RAISERROR('NO QUEDAN UNIDADES DISPONIBLES DE VENTA NI DE ALQUILER DE ESTA PELÍCULA.',0,0)
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) > 1 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			PRINT(CONCAT('NO QUEDAN UNIDADES DISPONIBLES DE VENTA PERO SI ', @ALQUILER, ' UNIDADES DISPONIBLES PARA ALQUILER DE ESTA PELÍCULA.'))
		ELSE IF (SELECT cant_disponibles_alquiler FROM tPelicula WHERE cod_pelicula = @pelicula) = 1 AND (SELECT cant_disponibles_venta FROM tPelicula WHERE cod_pelicula = @pelicula) = 0
			PRINT('NO QUEDAN UNIDADES DISPONIBLES DE VENTA PERO SI UNA ÚNICA UNIDAD DISPONIBLE PARA ALQUILER DE ESTA PELÍCULA.')
	END
END
GO
