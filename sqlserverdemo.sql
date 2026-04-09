USE [master]
GO
/****** Object:  Database [sqlserverdemo]    Script Date: 02/18/2026 7:59:40 p. m. ******/
CREATE DATABASE [sqlserverdemo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sqlserverdemo', FILENAME = N'/var/opt/mssql/data/sqlserverdemo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sqlserverdemo_log', FILENAME = N'/var/opt/mssql/data/sqlserverdemo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [sqlserverdemo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sqlserverdemo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sqlserverdemo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sqlserverdemo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sqlserverdemo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sqlserverdemo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sqlserverdemo] SET ARITHABORT OFF 
GO
ALTER DATABASE [sqlserverdemo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sqlserverdemo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sqlserverdemo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sqlserverdemo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sqlserverdemo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sqlserverdemo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sqlserverdemo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sqlserverdemo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sqlserverdemo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sqlserverdemo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [sqlserverdemo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sqlserverdemo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sqlserverdemo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sqlserverdemo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sqlserverdemo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sqlserverdemo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sqlserverdemo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sqlserverdemo] SET RECOVERY FULL 
GO
ALTER DATABASE [sqlserverdemo] SET  MULTI_USER 
GO
ALTER DATABASE [sqlserverdemo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sqlserverdemo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sqlserverdemo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sqlserverdemo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sqlserverdemo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sqlserverdemo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'sqlserverdemo', N'ON'
GO
ALTER DATABASE [sqlserverdemo] SET QUERY_STORE = ON
GO
ALTER DATABASE [sqlserverdemo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [sqlserverdemo]
GO
/****** Object:  UserDefinedTableType [dbo].[TipoCarrito]    Script Date: 02/18/2026 7:59:41 p. m. ******/
CREATE TYPE [dbo].[TipoCarrito] AS TABLE(
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL
)
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[IdDetalle] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[Subtotal] [decimal](12, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DireccionEnvio]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DireccionEnvio](
	[IdDireccion] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[Direccion] [varchar](255) NOT NULL,
	[Ciudad] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[CodigoPostal] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pago]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pago](
	[IdPago] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NOT NULL,
	[Metodo] [varchar](50) NULL,
	[Ultimos4] [varchar](4) NULL,
	[Fecha] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NOT NULL,
	[IdDireccion] [int] NOT NULL,
	[Fecha] [datetime] NULL,
	[Total] [decimal](12, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Detalle_Venta]    Script Date: 02/18/2026 7:59:41 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Detalle_Venta] ON [dbo].[DetalleVenta]
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Producto_Activo]    Script Date: 02/18/2026 7:59:41 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Producto_Activo] ON [dbo].[Producto]
(
	[Activo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Venta_Cliente]    Script Date: 02/18/2026 7:59:41 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Venta_Cliente] ON [dbo].[Venta]
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Venta_IdDireccion]    Script Date: 02/18/2026 7:59:41 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Venta_IdDireccion] ON [dbo].[Venta]
(
	[IdDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[Pago] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([IdProducto])
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[Venta] ([IdVenta])
GO
ALTER TABLE [dbo].[DireccionEnvio]  WITH CHECK ADD  CONSTRAINT [FK_Direccion_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[DireccionEnvio] CHECK CONSTRAINT [FK_Direccion_Cliente]
GO
ALTER TABLE [dbo].[Pago]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[Venta] ([IdVenta])
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Cliente]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Direccion] FOREIGN KEY([IdDireccion])
REFERENCES [dbo].[DireccionEnvio] ([IdDireccion])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Direccion]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerProductos]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ObtenerProductos]
AS
BEGIN
    SELECT IdProducto, Nombre, Descripcion, Precio, Stock
    FROM Producto
    WHERE Activo = 1;
END;

GO
/****** Object:  StoredProcedure [dbo].[ObtenerVentasCliente]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerVentasCliente]
    @Email VARCHAR(150)
AS
BEGIN
    SELECT V.IdVenta, V.Fecha, V.Total
    FROM Venta V
    JOIN Cliente C ON C.IdCliente = V.IdCliente
    WHERE C.Email = @Email;
END;

GO
/****** Object:  StoredProcedure [dbo].[ProcesarCompra]    Script Date: 02/18/2026 7:59:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcesarCompra]
    @Nombre VARCHAR(100),
    @Email VARCHAR(150),
    @Direccion VARCHAR(255),
    @Ciudad VARCHAR(100),
    @Pais VARCHAR(100),
    @CodigoPostal VARCHAR(20),
    @MetodoPago VARCHAR(50),
    @NumeroTarjeta VARCHAR(20),
    @Carrito TipoCarrito READONLY
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @IdCliente INT;
        DECLARE @IdDireccion INT;
        DECLARE @IdVenta INT;
        DECLARE @Total DECIMAL(12,2);

        -- Crear o obtener cliente
        SELECT @IdCliente = IdCliente FROM Cliente WHERE Email = @Email;

        IF @IdCliente IS NULL
        BEGIN
            INSERT INTO Cliente (Nombre, Email)
            VALUES (@Nombre, @Email);

            SET @IdCliente = SCOPE_IDENTITY();
        END

        -- Insertar dirección
        INSERT INTO DireccionEnvio (IdCliente, Direccion, Ciudad, Pais, CodigoPostal)
        VALUES (@IdCliente, @Direccion, @Ciudad, @Pais, @CodigoPostal);

        SET @IdDireccion = SCOPE_IDENTITY();

        -- Validar stock
        IF EXISTS (
            SELECT 1
            FROM @Carrito C
            JOIN Producto P ON P.IdProducto = C.IdProducto
            WHERE P.Stock < C.Cantidad
        )
        BEGIN
            RAISERROR('Stock insuficiente para uno o más productos.',16,1);
        END

        -- Calcular total
        SELECT @Total = SUM(P.Precio * C.Cantidad)
        FROM @Carrito C
        JOIN Producto P ON P.IdProducto = C.IdProducto;

        -- Crear venta
        INSERT INTO Venta (IdCliente, IdDireccion, Total)
        VALUES (@IdCliente, @IdDireccion, @Total);

        SET @IdVenta = SCOPE_IDENTITY();

        -- Insertar detalles
        INSERT INTO DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal)
        SELECT 
            @IdVenta,
            P.IdProducto,
            C.Cantidad,
            P.Precio,
            P.Precio * C.Cantidad
        FROM @Carrito C
        JOIN Producto P ON P.IdProducto = C.IdProducto;

        -- Actualizar stock
        UPDATE P
        SET P.Stock = P.Stock - C.Cantidad
        FROM Producto P
        JOIN @Carrito C ON P.IdProducto = C.IdProducto;

        -- Registrar pago (simulado)
        INSERT INTO Pago (IdVenta, Metodo, Ultimos4)
        VALUES (@IdVenta, @MetodoPago, RIGHT(@NumeroTarjeta,4));

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [sqlserverdemo] SET  READ_WRITE 
GO

