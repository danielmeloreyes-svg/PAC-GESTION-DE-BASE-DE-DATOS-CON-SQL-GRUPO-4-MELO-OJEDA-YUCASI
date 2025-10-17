
GO

-- Variables para loops (se declaran en cada batch)

-- =====================================================
-- 1. LIMPIAR DATOS EXISTENTES
-- =====================================================

-- Eliminar datos en orden inverso por foreign keys
DELETE FROM G4.inventario;
DELETE FROM G4.compras_detalle;
DELETE FROM G4.pedidos_detalle;
DELETE FROM G4.compras;
DELETE FROM G4.pedidos;
DELETE FROM G4.productos;
DELETE FROM G4.clientes;
DELETE FROM G4.vendedores;
DELETE FROM G4.tiendas;
DELETE FROM G4.proveedores;
DELETE FROM G4.categorias;
DELETE FROM G4.unidad_medida;
DELETE FROM G4.forma_pago;
DELETE FROM G4.tipo_operacion;
DELETE FROM G4.ubigeo;

-- Resetear contadores de identidad a 0
DBCC CHECKIDENT ('G4.tipo_operacion', RESEED, 0);
DBCC CHECKIDENT ('G4.forma_pago', RESEED, 0);
DBCC CHECKIDENT ('G4.unidad_medida', RESEED, 0);
DBCC CHECKIDENT ('G4.categorias', RESEED, 0);
DBCC CHECKIDENT ('G4.proveedores', RESEED, 0);
DBCC CHECKIDENT ('G4.tiendas', RESEED, 0);
DBCC CHECKIDENT ('G4.vendedores', RESEED, 0);
DBCC CHECKIDENT ('G4.clientes', RESEED, 0);
DBCC CHECKIDENT ('G4.productos', RESEED, 0);
DBCC CHECKIDENT ('G4.pedidos', RESEED, 0);
DBCC CHECKIDENT ('G4.compras', RESEED, 0);
DBCC CHECKIDENT ('G4.pedidos_detalle', RESEED, 0);
DBCC CHECKIDENT ('G4.compras_detalle', RESEED, 0);
DBCC CHECKIDENT ('G4.inventario', RESEED, 0);

PRINT 'Tablas limpiadas y contadores de identidad reseteados a 0';

GO

-- =====================================================
-- 2. INSERTAR DATOS DE REFERENCIA
-- =====================================================

-- Insertar ubigeo
INSERT INTO G4.ubigeo (id_ubigeo, departamento, provincia, distrito) VALUES
('150101', 'Lima', 'Lima', 'Lima'),
('150121', 'Lima', 'Lima', 'Miraflores'),
('150130', 'Lima', 'Lima', 'San Isidro'),
('150139', 'Lima', 'Lima', 'Santiago de Surco'),
('150134', 'Lima', 'Lima', 'San Martín de Porres'),
('150135', 'Lima', 'Lima', 'San Miguel'),
('150140', 'Lima', 'Lima', 'Surquillo'),
('150120', 'Lima', 'Lima', 'Magdalena del Mar'),
('150124', 'Lima', 'Lima', 'Pueblo Libre'),
('070101', 'Callao', 'Callao', 'Callao'),
('040101', 'Arequipa', 'Arequipa', 'Arequipa'),
('080101', 'Cusco', 'Cusco', 'Cusco');

-- Insertar tipo operación
INSERT INTO G4.tipo_operacion (descripcion) VALUES
('Entrada'),
('Salida'),
('Ajuste'),
('Transferencia');

-- Insertar forma de pago
INSERT INTO G4.forma_pago (descripcion, dias_vencimiento) VALUES
('Efectivo', 0),
('Tarjetas', 0),
('Transferencia', 1),
('Cheque', 7);

-- Insertar unidad de medida
INSERT INTO G4.unidad_medida (descripcion) VALUES
('Unidad'),
('Paquete');

-- Insertar categorías
PRINT 'Insertando categorías...';
INSERT INTO G4.categorias (descripcion) VALUES
('Enchufes'),
('Tomacorrientes'),
('Tableros para llaves'),
('Tubos conduit'),
('llaves termomagneticas');

PRINT 'Categorías insertadas: ' + CAST(@@ROWCOUNT AS VARCHAR);
SELECT 'Verificación de categorías insertadas:' as info;
SELECT id_categoria, descripcion FROM G4.categorias ORDER BY id_categoria;

GO

-- =====================================================
-- 3. INSERTAR DATOS DE NEGOCIO (TABLAS MAESTRAS)
-- =====================================================

-- Insertar proveedores
INSERT INTO G4.proveedores (ruc, razon_social, direccion, id_ubigeo, celular, contacto) VALUES
('20123456789', 'ALEMANNEKES S.A.C.', 'Av. El Derby 254 Santiago de Surco', '150139', '987654321', 'Carlos Mendoza'),
('20123456790', 'USAVITON S.A.C.', 'Av. República de Panamá 3055 San Isidro', '150130', '987654322', 'María González'),
('20123456791', 'SOLESPA S.A.C.', 'Av. El Derby 254 Santiago de Surco', '150139', '987654323', 'Roberto Silva'),
('20123456792', 'CHIEFANG S.A.C.', 'Av. República de Panamá 3055 San Isidro', '150130', '987654324', 'Ana Torres'),
('20123456793', 'FRANGER S.A.C.', 'Av. El Derby 254 Santiago de Surco', '150139', '987654325', 'Luis Ramírez');

GO

-- Insertar tiendas
INSERT INTO G4.tiendas (nombre) VALUES
('ElectroCenter Lima Centro'),
('ElectroCenter Miraflores'),
('ElectroCenter San Isidro'),
('ElectroCenter Santiago de Surco'),
('ElectroCenter San Miguel'),
('ElectroCenter Callao'),
('ElectroCenter San Martín de Porres'),
('ElectroCenter Surquillo'),
('ElectroCenter Pueblo Libre'),
('ElectroCenter Magdalena del Mar');

GO

-- Insertar 50 vendedores
DECLARE @vendedor INT = 1;
WHILE @vendedor <= 50
BEGIN
    INSERT INTO G4.vendedores (dni, apellidos, nombres, direccion, id_ubigeo, celular)
    VALUES (
        RIGHT('00000000' + CAST((@vendedor + 10000000) AS VARCHAR), 8), -- DNI único
        CASE (@vendedor % 20)
            WHEN 0 THEN 'García López'
            WHEN 1 THEN 'Rodríguez Silva'
            WHEN 2 THEN 'Mendoza Torres'
            WHEN 3 THEN 'González Herrera'
            WHEN 4 THEN 'Castro Ramírez'
            WHEN 5 THEN 'López Vargas'
            WHEN 6 THEN 'Silva Morales'
            WHEN 7 THEN 'Torres Jiménez'
            WHEN 8 THEN 'Herrera Cruz'
            WHEN 9 THEN 'Ramírez Flores'
            WHEN 10 THEN 'Vargas Castro'
            WHEN 11 THEN 'Morales López'
            WHEN 12 THEN 'Jiménez Silva'
            WHEN 13 THEN 'Cruz Torres'
            WHEN 14 THEN 'Flores Ramírez'
            WHEN 15 THEN 'Castro Vargas'
            WHEN 16 THEN 'López Morales'
            WHEN 17 THEN 'Silva Jiménez'
            WHEN 18 THEN 'Torres Cruz'
            ELSE 'Ramírez Flores'
        END,
        CASE (@vendedor % 15)
            WHEN 0 THEN 'Carlos Alberto'
            WHEN 1 THEN 'María Elena'
            WHEN 2 THEN 'Luis Fernando'
            WHEN 3 THEN 'Ana Patricia'
            WHEN 4 THEN 'Pedro José'
            WHEN 5 THEN 'Carmen Rosa'
            WHEN 6 THEN 'Roberto Carlos'
            WHEN 7 THEN 'Elena María'
            WHEN 8 THEN 'Miguel Ángel'
            WHEN 9 THEN 'Sofia Alejandra'
            WHEN 10 THEN 'Juan Carlos'
            WHEN 11 THEN 'Patricia Elena'
            WHEN 12 THEN 'Fernando Luis'
            WHEN 13 THEN 'Rosa Carmen'
            ELSE 'Alejandra Sofia'
        END,
        'Av. ' + CASE (@vendedor % 10)
            WHEN 0 THEN 'Javier Prado'
            WHEN 1 THEN 'Arequipa'
            WHEN 2 THEN 'La Marina'
            WHEN 3 THEN 'Universitaria'
            WHEN 4 THEN 'Angamos'
            WHEN 5 THEN 'Brasil'
            WHEN 6 THEN 'Colonial'
            WHEN 7 THEN 'Abancay'
            WHEN 8 THEN 'Elmer Faucett'
            ELSE 'Túpac Amaru'
        END + ' ' + CAST((@vendedor * 100) AS VARCHAR) + ' ' + CASE (@vendedor % 12)
            WHEN 0 THEN 'San Isidro'
            WHEN 1 THEN 'Miraflores'
            WHEN 2 THEN 'Pueblo Libre'
            WHEN 3 THEN 'San Miguel'
            WHEN 4 THEN 'Surquillo'
            WHEN 5 THEN 'Magdalena del Mar'
            WHEN 6 THEN 'Lima'
            WHEN 7 THEN 'Lima'
            WHEN 8 THEN 'Callao'
            WHEN 9 THEN 'San Martín de Porres'
            WHEN 10 THEN 'Santiago de Surco'
            ELSE 'San Isidro'
        END,
        CASE (@vendedor % 12)
            WHEN 0 THEN '150130'
            WHEN 1 THEN '150121'
            WHEN 2 THEN '150124'
            WHEN 3 THEN '150135'
            WHEN 4 THEN '150140'
            WHEN 5 THEN '150120'
            WHEN 6 THEN '150101'
            WHEN 7 THEN '150101'
            WHEN 8 THEN '070101'
            WHEN 9 THEN '150134'
            WHEN 10 THEN '150139'
            ELSE '150101'
        END,
        '9' + RIGHT('00000000' + CAST((@vendedor + 800000000) AS VARCHAR), 8)
    );
    SET @vendedor = @vendedor + 1;
END;

-- Insertar 2000 clientes
DECLARE @cliente INT = 1;
WHILE @cliente <= 2000
BEGIN
    INSERT INTO G4.clientes (tipo_doc, nro_doc, apellidos, nombres, direccion, id_ubigeo, celular)
    VALUES (
        CASE (@cliente % 3)
            WHEN 0 THEN 'DNI'
            WHEN 1 THEN 'RUC'
            ELSE 'CE'
        END,
        CASE (@cliente % 3)
            WHEN 0 THEN RIGHT('00000000' + CAST((@cliente + 20000000) AS VARCHAR), 8)
            WHEN 1 THEN RIGHT('00000000000' + CAST((@cliente + 20000000000) AS VARCHAR), 11)
            ELSE RIGHT('00000000' + CAST((@cliente + 30000000) AS VARCHAR), 8)
        END,
        CASE (@cliente % 25)
            WHEN 0 THEN 'García López'
            WHEN 1 THEN 'Rodríguez Silva'
            WHEN 2 THEN 'Mendoza Torres'
            WHEN 3 THEN 'González Herrera'
            WHEN 4 THEN 'Castro Ramírez'
            WHEN 5 THEN 'López Vargas'
            WHEN 6 THEN 'Silva Morales'
            WHEN 7 THEN 'Torres Jiménez'
            WHEN 8 THEN 'Herrera Cruz'
            WHEN 9 THEN 'Ramírez Flores'
            WHEN 10 THEN 'Vargas Castro'
            WHEN 11 THEN 'Morales López'
            WHEN 12 THEN 'Jiménez Silva'
            WHEN 13 THEN 'Cruz Torres'
            WHEN 14 THEN 'Flores Ramírez'
            WHEN 15 THEN 'Castro Vargas'
            WHEN 16 THEN 'López Morales'
            WHEN 17 THEN 'Silva Jiménez'
            WHEN 18 THEN 'Torres Cruz'
            WHEN 19 THEN 'Ramírez Flores'
            WHEN 20 THEN 'Pérez García'
            WHEN 21 THEN 'Martínez López'
            WHEN 22 THEN 'Sánchez Rodríguez'
            WHEN 23 THEN 'Fernández Silva'
            ELSE 'Gómez Torres'
        END,
        CASE (@cliente % 20)
            WHEN 0 THEN 'Carlos Alberto'
            WHEN 1 THEN 'María Elena'
            WHEN 2 THEN 'Luis Fernando'
            WHEN 3 THEN 'Ana Patricia'
            WHEN 4 THEN 'Pedro José'
            WHEN 5 THEN 'Carmen Rosa'
            WHEN 6 THEN 'Roberto Carlos'
            WHEN 7 THEN 'Elena María'
            WHEN 8 THEN 'Miguel Ángel'
            WHEN 9 THEN 'Sofia Alejandra'
            WHEN 10 THEN 'Juan Carlos'
            WHEN 11 THEN 'Patricia Elena'
            WHEN 12 THEN 'Fernando Luis'
            WHEN 13 THEN 'Rosa Carmen'
            WHEN 14 THEN 'Alejandra Sofia'
            WHEN 15 THEN 'Diego Fernando'
            WHEN 16 THEN 'Valeria Andrea'
            WHEN 17 THEN 'Sebastián David'
            WHEN 18 THEN 'Natalia Camila'
            ELSE 'Andrés Felipe'
        END,
        'Av. ' + CASE (@cliente % 15)
            WHEN 0 THEN 'Javier Prado'
            WHEN 1 THEN 'Arequipa'
            WHEN 2 THEN 'La Marina'
            WHEN 3 THEN 'Universitaria'
            WHEN 4 THEN 'Angamos'
            WHEN 5 THEN 'Brasil'
            WHEN 6 THEN 'Colonial'
            WHEN 7 THEN 'Abancay'
            WHEN 8 THEN 'Elmer Faucett'
            WHEN 9 THEN 'Túpac Amaru'
            WHEN 10 THEN 'Nicolás de Piérola'
            WHEN 11 THEN 'Wilson'
            WHEN 12 THEN 'Garcilazo de la Vega'
            WHEN 13 THEN '28 de Julio'
            ELSE 'Tacna'
        END + ' ' + CAST((@cliente * 50 + (@cliente % 100)) AS VARCHAR) + ' ' + CASE (@cliente % 12)
            WHEN 0 THEN 'San Isidro'
            WHEN 1 THEN 'Miraflores'
            WHEN 2 THEN 'Pueblo Libre'
            WHEN 3 THEN 'San Miguel'
            WHEN 4 THEN 'Surquillo'
            WHEN 5 THEN 'Magdalena del Mar'
            WHEN 6 THEN 'Lima'
            WHEN 7 THEN 'Lima'
            WHEN 8 THEN 'Callao'
            WHEN 9 THEN 'San Martín de Porres'
            WHEN 10 THEN 'Santiago de Surco'
            ELSE 'La Molina'
        END,
        CASE (@cliente % 12)
            WHEN 0 THEN '150130'
            WHEN 1 THEN '150121'
            WHEN 2 THEN '150124'
            WHEN 3 THEN '150135'
            WHEN 4 THEN '150140'
            WHEN 5 THEN '150120'
            WHEN 6 THEN '150101'
            WHEN 7 THEN '150101'
            WHEN 8 THEN '070101'
            WHEN 9 THEN '150134'
            WHEN 10 THEN '150139'
            ELSE '150101'
        END,
        '9' + RIGHT('00000000' + CAST((@cliente + 900000000) AS VARCHAR), 8)
    );
    SET @cliente = @cliente + 1;
END;

-- Insertar 500 productos
PRINT 'Verificando categorías antes de insertar productos...';
SELECT 'Categorías disponibles:' as info;
SELECT id_categoria, descripcion FROM G4.categorias ORDER BY id_categoria;

DECLARE @producto INT = 1;
WHILE @producto <= 500
BEGIN
    INSERT INTO G4.productos (id_categoria, descripcion, id_unidad_medida, precio)
    VALUES (
        CASE 
            WHEN @producto % 5 = 1 THEN 1
            WHEN @producto % 5 = 2 THEN 2
            WHEN @producto % 5 = 3 THEN 3
            WHEN @producto % 5 = 4 THEN 4
            ELSE 5
        END,  -- Categoría del 1 al 5 (100% garantizado)
        'Producto ' + CAST(@producto AS VARCHAR) + ' - Categoría ' + 
        CASE 
            WHEN @producto % 5 = 1 THEN '1'
            WHEN @producto % 5 = 2 THEN '2'
            WHEN @producto % 5 = 3 THEN '3'
            WHEN @producto % 5 = 4 THEN '4'
            ELSE '5'
        END + ' - Modelo ' + CHAR(65 + (@producto % 26)),
        CASE (@producto % 2)
            WHEN 0 THEN 1  -- Unidad
            ELSE 2         -- Paquete
        END,
        CAST(((@producto % 200) + 50 + (@producto % 10)) AS DECIMAL(10,2)) -- Precio entre 50 y 259
    );
    SET @producto = @producto + 1;
END;

PRINT 'Productos insertados: ' + CAST(@@ROWCOUNT AS VARCHAR);

GO

-- =====================================================
-- 4. INSERTAR DATOS TRANSACCIONALES (2000 REGISTROS)
-- =====================================================

-- Insertar 2000 pedidos
DECLARE @pedido INT = 1;
WHILE @pedido <= 2000
BEGIN
    INSERT INTO G4.pedidos (id_cliente, id_vendedor, id_tienda, nro_documento, fecha_pedido, hora_pedido, id_forma_pago)
    VALUES (
        CASE WHEN (@pedido % 2000) = 0 THEN 2000 ELSE (@pedido % 2000) END,  -- Cliente del 1 al 2000
        CASE WHEN (@pedido % 50) = 0 THEN 50 ELSE (@pedido % 50) END,    -- Vendedor del 1 al 50
        CASE WHEN (@pedido % 10) = 0 THEN 10 ELSE (@pedido % 10) END,    -- Tienda del 1 al 10
        'PED-2024-' + RIGHT('0000' + CAST(@pedido AS VARCHAR), 4),
        DATEADD(DAY, @pedido % 365, '2024-01-01'),
        CAST(DATEADD(MINUTE, (@pedido * 17) % 960, '08:00:00') AS TIME),
        CASE WHEN (@pedido % 4) = 0 THEN 4 ELSE (@pedido % 4) END      -- Forma de pago del 1 al 4
    );
    SET @pedido = @pedido + 1;
END;

PRINT 'Pedidos insertados: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- Insertar 2000 compras
DECLARE @compra INT = 1;
WHILE @compra <= 2000
BEGIN
    INSERT INTO G4.compras (id_proveedor, id_tienda, nro_documento, fecha_compra, hora_compra)
    VALUES (
        CASE WHEN (@compra % 5) = 0 THEN 5 ELSE (@compra % 5) END,   -- Proveedor del 1 al 5
        CASE WHEN (@compra % 10) = 0 THEN 10 ELSE (@compra % 10) END,  -- Tienda del 1 al 10
        'COMP-2024-' + RIGHT('0000' + CAST(@compra AS VARCHAR), 4),
        DATEADD(DAY, @compra % 365, '2024-01-01'),
        CAST(DATEADD(MINUTE, (@compra * 23) % 480, '08:00:00') AS TIME)
    );
    SET @compra = @compra + 1;
END;

PRINT 'Compras insertadas: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- Insertar 2000 pedidos_detalle
DECLARE @pedido_det INT = 1;
DECLARE @producto_id INT;
WHILE @pedido_det <= 2000
BEGIN
    SET @producto_id = (@pedido_det % 500);
    IF @producto_id = 0 SET @producto_id = 500;
    
    INSERT INTO G4.pedidos_detalle (id_pedido, id_producto, cantidad, precio_unitario, sub_total)
    VALUES (
        @pedido_det,             -- Pedido correlativo
        @producto_id,            -- Producto del 1 al 500 (garantizado)
        CASE WHEN (@pedido_det % 10) = 0 THEN 10 ELSE (@pedido_det % 10) END,  -- Cantidad del 1 al 10
        CAST(((@pedido_det % 200) + 50) AS DECIMAL(10,2)), -- Precio entre 50 y 249
        CAST(((@pedido_det % 10) + 1) * (((@pedido_det % 200) + 50)) AS DECIMAL(10,2))
    );
    SET @pedido_det = @pedido_det + 1;
END;

PRINT 'Pedidos detalle insertados: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- Insertar 2000 compras_detalle
DECLARE @compra_det INT = 1;
DECLARE @producto_compra INT;
WHILE @compra_det <= 2000
BEGIN
    SET @producto_compra = (@compra_det % 500);
    IF @producto_compra = 0 SET @producto_compra = 500;
    
    INSERT INTO G4.compras_detalle (id_compra, id_producto, cantidad, costo_unitario, sub_total, numero_lote)
    VALUES (
        @compra_det,             -- Compra correlativa
        @producto_compra,        -- Producto del 1 al 500 (garantizado)
        (@compra_det % 100) + 50, -- Cantidad entre 50 y 149
        CAST(((@compra_det % 150) + 30) AS DECIMAL(10,2)), -- Costo entre 30 y 179
        CAST(((@compra_det % 100) + 50) * (((@compra_det % 150) + 30)) AS DECIMAL(10,2)),
        'LOT-2024-' + RIGHT('0000' + CAST(@compra_det AS VARCHAR), 4)
    );
    SET @compra_det = @compra_det + 1;
END;

PRINT 'Compras detalle insertadas: ' + CAST(@@ROWCOUNT AS VARCHAR);

-- Insertar 2000 inventario
DECLARE @inventario INT = 1;
WHILE @inventario <= 2000
BEGIN
    INSERT INTO G4.inventario (id_pedido_detalle, id_compra_detalle, id_tienda, id_tipo_operacion, stock_actual, stock_final, fecha_inventario, hora_inventario)
    VALUES (
        NULL,  -- No referenciar pedidos_detalle por ahora
        @inventario,  -- Referencia a compras_detalle (que sí existe)
        (@inventario % 10) + 1,  -- Tienda del 1 al 10
        (@inventario % 4) + 1,   -- Tipo operación del 1 al 4
        (@inventario % 500),     -- Stock actual entre 0 y 499
        (@inventario % 500) + (@inventario % 200), -- Stock final = actual + incremento
        DATEADD(DAY, @inventario % 365, '2024-01-01'),
        CAST(DATEADD(MINUTE, (@inventario * 13) % 960, '08:00:00') AS TIME)
    );
    SET @inventario = @inventario + 1;
END;

PRINT 'Inventario insertado: ' + CAST(@@ROWCOUNT AS VARCHAR);

GO

-- =====================================================
-- VERIFICACIÓN FINAL
-- =====================================================
PRINT '=== VERIFICACIÓN DE DATOS INSERTADOS ===';

SELECT 'UBIGEO' as tabla, COUNT(*) as registros FROM G4.ubigeo
UNION ALL
SELECT 'CATEGORIAS' as tabla, COUNT(*) as registros FROM G4.categorias
UNION ALL
SELECT 'PRODUCTOS' as tabla, COUNT(*) as registros FROM G4.productos
UNION ALL
SELECT 'CLIENTES' as tabla, COUNT(*) as registros FROM G4.clientes
UNION ALL
SELECT 'VENDEDORES' as tabla, COUNT(*) as registros FROM G4.vendedores
UNION ALL
SELECT 'TIENDAS' as tabla, COUNT(*) as registros FROM G4.tiendas
UNION ALL
SELECT 'PROVEEDORES' as tabla, COUNT(*) as registros FROM G4.proveedores
UNION ALL
SELECT 'PEDIDOS' as tabla, COUNT(*) as registros FROM G4.pedidos
UNION ALL
SELECT 'COMPRAS' as tabla, COUNT(*) as registros FROM G4.compras
UNION ALL
SELECT 'PEDIDOS_DETALLE' as tabla, COUNT(*) as registros FROM G4.pedidos_detalle
UNION ALL
SELECT 'COMPRAS_DETALLE' as tabla, COUNT(*) as registros FROM G4.compras_detalle
UNION ALL
SELECT 'INVENTARIO' as tabla, COUNT(*) as registros FROM G4.inventario;

PRINT '=== SCRIPT COMPLETADO ===';
GO
