--EXTRAÍDO DEL DOCUMENTO DEL TEST
----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tRol
(
cod_rol INT IDENTITY PRIMARY KEY
, txt_desc VARCHAR(500)
, sn_activo INT
)
GO
INSERT INTO trol VALUES ( 'Administrador',-1)
INSERT INTO trol VALUES ( 'Cliente', -1)
GO
CREATE TABLE tUsers
(cod_usuario INT PRIMARY KEY IDENTITY, txt_user VARCHAR(50), txt_password
VARCHAR(50),txt_nombre VARCHAR(200), txt_apellido VARCHAR(200), nro_doc
VARCHAR(50), cod_rol INT, sn_activo INT
, CONSTRAINT fk_user_rol FOREIGN KEY (cod_rol) REFERENCES tRol(cod_rol)
)
GO
INSERT INTO tUsers VALUES ( 'Admin', 'PassAdmin123', 'Administrador', 'Test', '1234321', 1,-1)
INSERT INTO tUsers VALUES ('userTest', 'Test1', 'Ariel', 'ApellidoConA', '12312321', 1, -1)
INSERT INTO tUsers VALUES ('userTest2', 'Test2', 'Bernardo', 'ApellidoConB', '12312322', 1, -1)
INSERT INTO tUsers VALUES ('userTest3', 'Test3', 'Carlos', 'ApellidoConC', '12312323', 1, -1)
GO
CREATE TABLE tPelicula (cod_pelicula INT PRIMARY KEY IDENTITY, txt_desc
VARCHAR(500), cant_disponibles_alquiler INT, cant_disponibles_venta INT,
precio_alquiler NUMERIC(18,2), precio_venta NUMERIC(18,2))
GO
INSERT INTO tPelicula VALUES ('Duro de matar III', 3, 0,1.5,5.0)
INSERT INTO tPelicula VALUES ('Todo Poderoso', 2,1,1.5,7.0)
INSERT INTO tPelicula VALUES ('Stranger than fiction', 1,1,1.5,8.0)
INSERT INTO tPelicula VALUES ('OUIJA', 0,2,2.0,20.50)
GO
CREATE TABLE tGenero (cod_genero INT PRIMARY KEY IDENTITY, txt_desc
VARCHAR(500) )
INSERT INTO tGenero VALUES('Acción')
INSERT INTO tGenero VALUES('Comedia')
INSERT INTO tGenero VALUES('Drama')
INSERT INTO tGenero VALUES('Terror')
GO
CREATE TABLE tGeneroPelicula (cod_pelicula INT, cod_genero INT
, PRIMARY KEY(cod_pelicula, cod_genero)
, CONSTRAINT fk_genero_pelicula FOREIGN KEY(cod_pelicula) REFERENCES
tpelicula(cod_pelicula), CONSTRAINT fk_pelicula_genero FOREIGN KEY(cod_genero) REFERENCES
tGenero(cod_genero))
GO
INSERT INTO tGeneroPelicula VALUES(1,1)
INSERT INTO tGeneroPelicula VALUES(2,2)
INSERT INTO tGeneroPelicula VALUES(3,2)
INSERT INTO tGeneroPelicula VALUES(3,3)
INSERT INTO tGeneroPelicula VALUES(4,4)
GO
--TERMINA EXTRAÍDO DEL DOCUMENTO DEL TEST
----------------------------------------------------------------------------------------------------------------------------




-- PRIMER TASK - CREAR UNA TABLA DE ALQUILER DE PELÍCULAS Y OTRA DE VENTAS
--TABLA ALQUILER
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE tAlquiler(
	alquilerID int IDENTITY(200,1) NOT NULL,
	usuario int NOT NULL,
	pelicula int NOT NULL,
	fecha datetime NOT NULL,
	total numeric(18, 2) NOT NULL,
	devuelto bit NULL,
	fecha_devolucion datetime NOT NULL,
 CONSTRAINT PK_tAlquiler PRIMARY KEY CLUSTERED 
(
	alquilerID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
--TABLA VENTAS
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE tVentas(
	ventaID int IDENTITY(100,1) NOT NULL,
	usuario int NOT NULL,
	pelicula int NOT NULL,
	fecha datetime NOT NULL,
	total numeric(18, 2) NOT NULL,
 CONSTRAINT PK_tVentas PRIMARY KEY CLUSTERED 
(
	ventaID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--FKs tAlquiler
ALTER TABLE tAlquiler  WITH CHECK ADD  CONSTRAINT FK_tAlquiler_tPelicula FOREIGN KEY(pelicula)
REFERENCES tPelicula (cod_pelicula)
GO
ALTER TABLE tAlquiler CHECK CONSTRAINT FK_tAlquiler_tPelicula
GO
ALTER TABLE tAlquiler  WITH CHECK ADD  CONSTRAINT FK_tAlquiler_tUsers FOREIGN KEY(usuario)
REFERENCES tUsers (cod_usuario)
GO
ALTER TABLE tAlquiler CHECK CONSTRAINT FK_tAlquiler_tUsers
GO

--FKs tVentas
ALTER TABLE tVentas  WITH CHECK ADD  CONSTRAINT FK_tVentas_tPelicula FOREIGN KEY(pelicula)
REFERENCES tPelicula (cod_pelicula)
GO
ALTER TABLE tVentas CHECK CONSTRAINT FK_tVentas_tPelicula
GO
ALTER TABLE tVentas  WITH CHECK ADD  CONSTRAINT FK_tVentas_tUsers FOREIGN KEY(usuario)
REFERENCES tUsers (cod_usuario)
GO
ALTER TABLE tVentas CHECK CONSTRAINT FK_tVentas_tUsers
GO

--SEGUNDO TASK - AGREGAR USUARIO CONDICIONALMENTE AL nro_doc
CREATE PROCEDURE AGREGARUSER
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

EXEC AGREGARUSER @nro_doc = 1231232134

select * from tUsers


--TERCER TASK - CREAR/BORRAR/ MODIFICAR PELICULA (CRUD)
--CREAR
CREATE PROCEDURE AGREGARPELICULA
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

-- MODIFICAR
CREATE PROCEDURE MODIFICARPELICULA
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

--BORRAR
CREATE PROCEDURE BORRARPELICULA
@cod_pelicula int
AS
BEGIN
  SET NOCOUNT ON
  UPDATE tPelicula
	SET cant_disponibles_alquiler = 0,
		cant_disponibles_venta = 0
	WHERE cod_pelicula = @cod_pelicula
END

EXEC AGREGARPELICULA @txt_desc = 'prueba 500'

EXEC MODIFICARPELICULA @cod_pelicula = 5, @precio_alquiler = 50

EXEC BORRARPELICULA @cod_pelicula = 5

select * from tPelicula





--CUARTO TASK - CREAR GÉNEROS
CREATE PROCEDURE AGREGARGENERO
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


--QUINTO TASK - ASIGNAR GÉNEROS A PELÍCULAS, VERIFICAR QUE LA PELICULA NO TENGA GÉNERO ASIGNADO
CREATE PROCEDURE ASIGNARGENERO
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

EXEC ASIGNARGENERO @cod_pelicula = 5, @cod_genero = 4



-- SEXTO TASK - ALQUILAR Y VENDER PELICULAS
CREATE PROCEDURE ALQUILAR_VENDERPELICULAS
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

exec ALQUILAR_VENDERPELICULAS @tipo_proceso = 'VENDER', @usuario = 2, @pelicula = 3, @fecha = '2022-11-07 23:24:40', @fecha_devolucion = '2022-11-12 23:24:40'

select * from tPelicula

SELECT * FROM tVentas

SELECT * FROM tAlquiler


-- SÉPTIMO TASK - OBTENER PELÍCULAS EN STOCK PARA ALQUILER
CREATE PROCEDURE STOCK_ALQUILER
AS
BEGIN
	IF(SELECT COUNT(*) FROM tPelicula WHERE cant_disponibles_alquiler > 0) > 0
		SELECT cod_pelicula, txt_desc,cant_disponibles_alquiler, precio_alquiler
		FROM tPelicula
		WHERE cant_disponibles_alquiler > 0
	ELSE
		RAISERROR('NO QUEDAN UNIDADES DISPONIBLES PARA ALQUILER DE NINGUNA PELÍCULA.',0,0)
END

EXEC STOCK_ALQUILER

-- OCTAVO TASK - OBTENER PELÍCULAS EN STOCK PARA VENDER
CREATE PROCEDURE STOCK_VENTAS
AS
BEGIN
	IF(SELECT COUNT(*) FROM tPelicula WHERE cant_disponibles_venta > 0) > 0
		SELECT cod_pelicula, txt_desc,cant_disponibles_venta, precio_venta
		FROM tPelicula
		WHERE cant_disponibles_venta > 0
	ELSE
		RAISERROR('NO QUEDAN UNIDADES DISPONIBLES PARA VENTA DE NINGUNA PELÍCULA.',0,0)
END

EXEC STOCK_VENTAS

-- NOVENO TASK - ALQUILAR PELÍCULA
CREATE PROCEDURE ALQUILAR_PELICULAS
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

exec ALQUILAR_PELICULAS @usuario = 2, @pelicula = 3, @fecha = '2022-11-07 23:24:40', @fecha_devolucion = '2022-11-12 23:24:40'

-- DÉCIMO TASK - VENDER PELÍCULA
CREATE PROCEDURE VENDER_PELICULAS
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

exec VENDER_PELICULAS @usuario = 2, @pelicula = 3, @fecha = '2022-11-07 23:24:40'

-- DÉCIMO PRIMERA TASK - DEVOLVER PELÍCULA
CREATE PROCEDURE DEVOLVER_PELICULA
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

exec DEVOLVER_PELICULA @usuario = 15, @pelicula = 3

select * from tAlquiler

-- DÉCIMO SEGUNDO TASK - VER PELÍCULAS NO DEVUELTAS Y QUIÉN LA TIENE
CREATE PROCEDURE PENDIENTES_DEVOLUCION
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

exec PENDIENTES_DEVOLUCION


-- DÉCIMO TERCERO TASK - VER PELÍCULAS ALQUILADAS POR USUARIO CUANTÓ PAGÓ Y QUE DÍA
CREATE PROCEDURE PELICULAS_ALQUILADAS
AS
BEGIN
	SELECT usuario, CONCAT(u.txt_nombre, ' ', u.txt_apellido) AS nombre_usuario, u.txt_user, p.txt_desc, total, fecha
	FROM tAlquiler a
	INNER JOIN tPelicula p
	ON a.pelicula = p.cod_pelicula
	INNER JOIN tUsers u
	ON a.usuario = u.cod_usuario
END

--ALQUILADAS FILTRADAS POR USUARIO
CREATE PROCEDURE ALQUILADAS_USUARIO
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

EXEC PELICULAS_ALQUILADAS

EXEC ALQUILADAS_USUARIO @usuario = 4

-- ÚLTIMO TASK SQL - VER PELÍCULAS, CUANTAS VECES FUERON ALQUILADAS Y CUANTO SE RECAUDÓ POR ELLAS
CREATE PROCEDURE RECAUDACION_PELICULAS
AS
BEGIN
	SELECT a.pelicula, p.txt_desc,COUNT(a.pelicula) as 'Cantidad_veces_alquiladas', SUM(a.total) as 'Total_recaudado_alquiler'
	from tAlquiler a
	INNER JOIN tPelicula p
	ON a.pelicula = p.cod_pelicula
	Group by a.pelicula, p.txt_desc
END

EXEC RECAUDACION_PELICULAS

	
