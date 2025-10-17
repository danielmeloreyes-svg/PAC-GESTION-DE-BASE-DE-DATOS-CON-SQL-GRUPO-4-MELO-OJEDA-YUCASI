
-- =====================================================
-- 1. CREAR BASE DE DATOS
-- =====================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'G4.database')
BEGIN
    CREATE DATABASE G4.database;
END;
GO

USE G4.database;
GO

-- =====================================================
-- 2. ELIMINAR TABLAS EXISTENTES (EN ORDEN INVERSO POR FOREIGN KEYS)
-- =====================================================
IF OBJECT_ID('G4.inventario', 'U') IS NOT NULL DROP TABLE G4.inventario;
IF OBJECT_ID('G4.compras_detalle', 'U') IS NOT NULL DROP TABLE G4.compras_detalle;
IF OBJECT_ID('G4.compras', 'U') IS NOT NULL DROP TABLE G4.compras;
IF OBJECT_ID('G4.pedidos_detalle', 'U') IS NOT NULL DROP TABLE G4.pedidos_detalle;
IF OBJECT_ID('G4.pedidos', 'U') IS NOT NULL DROP TABLE G4.pedidos;
IF OBJECT_ID('G4.productos', 'U') IS NOT NULL DROP TABLE G4.productos;
IF OBJECT_ID('G4.clientes', 'U') IS NOT NULL DROP TABLE G4.clientes;
IF OBJECT_ID('G4.vendedores', 'U') IS NOT NULL DROP TABLE G4.vendedores;
IF OBJECT_ID('G4.tiendas', 'U') IS NOT NULL DROP TABLE G4.tiendas;
IF OBJECT_ID('G4.proveedores', 'U') IS NOT NULL DROP TABLE G4.proveedores;
IF OBJECT_ID('G4.categorias', 'U') IS NOT NULL DROP TABLE G4.categorias;
IF OBJECT_ID('G4.unidad_medida', 'U') IS NOT NULL DROP TABLE G4.unidad_medida;
IF OBJECT_ID('G4.forma_pago', 'U') IS NOT NULL DROP TABLE G4.forma_pago;
IF OBJECT_ID('G4.tipo_operacion', 'U') IS NOT NULL DROP TABLE G4.tipo_operacion;
IF OBJECT_ID('G4.ubigeo', 'U') IS NOT NULL DROP TABLE G4.ubigeo;
GO

-- =====================================================
-- 3. CREAR TABLAS PRINCIPALES
-- =====================================================

-- Tabla G4.ubigeo (ubicaciones peruanas)
CREATE SCHEMA G4;
GO

CREATE TABLE G4.ubigeo (
    id_ubigeo VARCHAR(6) PRIMARY KEY,
    departamento VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    distrito VARCHAR(50) NOT NULL
);

-- Tabla G4.tipo_operacion
CREATE TABLE G4.tipo_operacion (
    id_tipo_operacion INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Tabla G4.forma_pago
CREATE TABLE G4.forma_pago (
    id_forma_pago INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL,
    dias_vencimiento INT
);

-- Tabla G4.unidad_medida
CREATE TABLE G4.unidad_medida (
    id_unidad_medida INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(20) NOT NULL
);

-- Tabla G4.categorias
CREATE TABLE G4.categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

-- Tabla G4.proveedores
CREATE TABLE G4.proveedores (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    ruc VARCHAR(11) UNIQUE NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    direccion VARCHAR(200),
    id_ubigeo VARCHAR(6),
    celular VARCHAR(15),
    contacto VARCHAR(100),
    FOREIGN KEY (id_ubigeo) REFERENCES G4.ubigeo(id_ubigeo)
);

-- Tabla G4.vendedores
CREATE TABLE G4.vendedores (
    id_vendedor INT IDENTITY(1,1) PRIMARY KEY,
    dni VARCHAR(8) UNIQUE NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_ubigeo VARCHAR(6),
    celular VARCHAR(15),
    FOREIGN KEY (id_ubigeo) REFERENCES G4.ubigeo(id_ubigeo)
);

-- Tabla G4.tiendas
CREATE TABLE G4.tiendas (
    id_tienda INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Tabla G4.clientes
CREATE TABLE G4.clientes (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    tipo_doc VARCHAR(10) NOT NULL,
    nro_doc VARCHAR(20) UNIQUE NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    id_ubigeo VARCHAR(6),
    celular VARCHAR(15),
    FOREIGN KEY (id_ubigeo) REFERENCES G4.ubigeo(id_ubigeo)
);

-- Tabla G4.productos
CREATE TABLE G4.productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_categoria INT NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    id_unidad_medida INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES G4.categorias(id_categoria),
    FOREIGN KEY (id_unidad_medida) REFERENCES G4.unidad_medida(id_unidad_medida)
);

-- Tabla G4.pedidos
CREATE TABLE G4.pedidos (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_tienda INT NOT NULL,
    nro_documento VARCHAR(20) NOT NULL,
    fecha_pedido DATE NOT NULL,
    hora_pedido TIME NOT NULL,
    id_forma_pago INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES G4.clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES G4.vendedores(id_vendedor),
    FOREIGN KEY (id_tienda) REFERENCES G4.tiendas(id_tienda),
    FOREIGN KEY (id_forma_pago) REFERENCES G4.forma_pago(id_forma_pago)
);

-- Tabla G4.pedidos_detalle
CREATE TABLE G4.pedidos_detalle (
    id_pedido_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    sub_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES G4.pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES G4.productos(id_producto)
);

-- Tabla G4.compras
CREATE TABLE G4.compras (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_tienda INT NOT NULL,
    nro_documento VARCHAR(20) NOT NULL,
    fecha_compra DATE NOT NULL,
    hora_compra TIME NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES G4.proveedores(id_proveedor),
    FOREIGN KEY (id_tienda) REFERENCES G4.tiendas(id_tienda)
);

-- Tabla G4.compras_detalle
CREATE TABLE G4.compras_detalle (
    id_compra_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL,
    sub_total DECIMAL(10,2) NOT NULL,
    numero_lote VARCHAR(20),
    FOREIGN KEY (id_compra) REFERENCES G4.compras(id_compra),
    FOREIGN KEY (id_producto) REFERENCES G4.productos(id_producto)
);

-- Tabla G4.inventario
CREATE TABLE G4.inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido_detalle INT,
    id_compra_detalle INT NOT NULL,
    id_tienda INT NOT NULL,
    id_tipo_operacion INT NOT NULL,
    stock_actual INT NOT NULL,
    stock_final INT NOT NULL,
    fecha_inventario DATE NOT NULL,
    hora_inventario TIME NOT NULL,
    FOREIGN KEY (id_pedido_detalle) REFERENCES G4.pedidos_detalle(id_pedido_detalle),
    FOREIGN KEY (id_compra_detalle) REFERENCES G4.compras_detalle(id_compra_detalle),
    FOREIGN KEY (id_tienda) REFERENCES G4.tiendas(id_tienda),
    FOREIGN KEY (id_tipo_operacion) REFERENCES G4.tipo_operacion(id_tipo_operacion)
);

GO

-- =====================================================
-- 4. AGREGAR RESTRICCIONES CON ALTER TABLE
-- =====================================================

-- Restricciones para G4.ubigeo
ALTER TABLE G4.ubigeo ADD CONSTRAINT UK_ubigeo_completo UNIQUE (departamento, provincia, distrito);

-- Restricciones para G4.forma_pago
ALTER TABLE G4.forma_pago ADD CONSTRAINT UK_forma_pago_desc UNIQUE (descripcion);
ALTER TABLE G4.forma_pago ADD CONSTRAINT CK_dias_vencimiento CHECK (dias_vencimiento >= 0);

-- Restricciones para G4.categorias
ALTER TABLE G4.categorias ADD CONSTRAINT UK_categorias_desc UNIQUE (descripcion);

-- Restricciones para G4.productos
ALTER TABLE G4.productos ADD CONSTRAINT UK_productos_descripcion UNIQUE (descripcion);
ALTER TABLE G4.productos ADD CONSTRAINT CK_precio_positivo CHECK (precio > 0);
ALTER TABLE G4.productos ADD CONSTRAINT CK_precio_maximo CHECK (precio <= 999999.99);

-- Restricciones para G4.pedidos
ALTER TABLE G4.pedidos ADD CONSTRAINT UK_pedidos_nro_documento UNIQUE (nro_documento);
ALTER TABLE G4.pedidos ADD CONSTRAINT CK_fecha_pedido CHECK (fecha_pedido >= '2020-01-01' AND fecha_pedido <= GETDATE());
ALTER TABLE G4.pedidos ADD CONSTRAINT CK_hora_pedido CHECK (hora_pedido >= '06:00:00' AND hora_pedido <= '22:00:00');

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================
GO
