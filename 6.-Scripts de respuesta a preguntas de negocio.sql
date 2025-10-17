
GO

-- =====================================================
-- CONSULTA 1: TOP 2 MONTO MENSUAL DE PEDIDOS POR CATEGORÍA - MAYO 2024
-- =====================================================
SELECT 'CONSULTA 1: TOP 2 MONTO MENSUAL DE PEDIDOS POR CATEGORÍA - MAYO 2024' as consulta;

SELECT TOP 2
    c.descripcion as categoria,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    SUM(pd.cantidad) as unidades_vendidas
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.productos p ON pd.id_producto = p.id_producto
INNER JOIN G4.categorias c ON p.id_categoria = c.id_categoria
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 5
GROUP BY c.id_categoria, c.descripcion
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 2: TOP 3 MONTO MENSUAL DE PEDIDOS POR TIENDAS - JUNIO 2024
-- =====================================================
SELECT 'CONSULTA 2: TOP 3 MONTO MENSUAL DE PEDIDOS POR TIENDAS - JUNIO 2024' as consulta;

SELECT TOP 3
    t.nombre as tienda,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    COUNT(DISTINCT pe.id_cliente) as clientes_unicos,
    SUM(pd.cantidad) as unidades_vendidas
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.tiendas t ON pe.id_tienda = t.id_tienda
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 6
GROUP BY t.id_tienda, t.nombre
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 3: MAYOR MONTO MENSUAL DE PEDIDOS POR FORMA DE PAGO - JULIO 2024
-- =====================================================
SELECT 'CONSULTA 3: MAYOR MONTO MENSUAL DE PEDIDOS POR FORMA DE PAGO - JULIO 2024' as consulta;

SELECT TOP 1
    fp.descripcion as forma_pago,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    AVG(pd.sub_total) as ticket_promedio
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.forma_pago fp ON pe.id_forma_pago = fp.id_forma_pago
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 7
GROUP BY fp.id_forma_pago, fp.descripcion
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 4: MAYOR MONTO MENSUAL DE PEDIDOS POR CLIENTE - JULIO 2024
-- =====================================================
SELECT 'CONSULTA 4: MAYOR MONTO MENSUAL DE PEDIDOS POR CLIENTE - JULIO 2024' as consulta;

SELECT TOP 1
    cl.apellidos + ', ' + cl.nombres as cliente,
    cl.celular,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    AVG(pd.sub_total) as ticket_promedio
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.clientes cl ON pe.id_cliente = cl.id_cliente
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 7
GROUP BY cl.id_cliente, cl.apellidos, cl.nombres, cl.celular
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 5: MAYOR MONTO MENSUAL DE PEDIDOS POR PRODUCTO - JULIO 2024
-- =====================================================
SELECT 'CONSULTA 5: MAYOR MONTO MENSUAL DE PEDIDOS POR PRODUCTO - JULIO 2024' as consulta;

SELECT TOP 1
    p.descripcion as producto,
    c.descripcion as categoria,
    SUM(pd.sub_total) as monto_total_pedidos,
    SUM(pd.cantidad) as unidades_vendidas,
    AVG(pd.precio_unitario) as precio_promedio
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.productos p ON pd.id_producto = p.id_producto
INNER JOIN G4.categorias c ON p.id_categoria = c.id_categoria
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 7
GROUP BY p.id_producto, p.descripcion, c.descripcion
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 6: TOP 5 MONTO MENSUAL DE PEDIDOS POR VENDEDORES - JUNIO 2024
-- =====================================================
SELECT 'CONSULTA 6: TOP 5 MONTO MENSUAL DE PEDIDOS POR VENDEDORES - JUNIO 2024' as consulta;

SELECT TOP 5
    v.apellidos + ', ' + v.nombres as vendedor,
    t.nombre as tienda,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    COUNT(DISTINCT pe.id_cliente) as clientes_atendidos,
    AVG(pd.sub_total) as ticket_promedio
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.vendedores v ON pe.id_vendedor = v.id_vendedor
INNER JOIN G4.tiendas t ON pe.id_tienda = t.id_tienda
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 6
GROUP BY v.id_vendedor, v.apellidos, v.nombres, t.nombre
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 7: MAYOR MONTO MENSUAL DE PEDIDOS POR UBIGEO - JULIO 2024
-- =====================================================
SELECT 'CONSULTA 7: MAYOR MONTO MENSUAL DE PEDIDOS POR UBIGEO - JULIO 2024' as consulta;

SELECT TOP 1
    u.departamento + ', ' + u.provincia + ', ' + u.distrito as ubigeo,
    SUM(pd.sub_total) as monto_total_pedidos,
    COUNT(DISTINCT pe.id_pedido) as total_pedidos,
    COUNT(DISTINCT pe.id_cliente) as clientes_unicos
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
INNER JOIN G4.clientes cl ON pe.id_cliente = cl.id_cliente
INNER JOIN G4.ubigeo u ON cl.id_ubigeo = u.id_ubigeo
WHERE YEAR(pe.fecha_pedido) = 2024 AND MONTH(pe.fecha_pedido) = 7
GROUP BY u.id_ubigeo, u.departamento, u.provincia, u.distrito
ORDER BY monto_total_pedidos DESC;

-- =====================================================
-- CONSULTA 8: PROMEDIO MONTO MENSUAL DE PEDIDOS POR FORMA DE PAGO - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 8: PROMEDIO MONTO MENSUAL DE PEDIDOS POR FORMA DE PAGO - AÑO 2024' as consulta;

SELECT 
    fp.descripcion as forma_pago,
    AVG(ventas_mensuales.monto_mensual) as promedio_mensual_pedidos,
    COUNT(DISTINCT ventas_mensuales.mes) as meses_con_ventas,
    SUM(ventas_mensuales.monto_mensual) as total_anual_pedidos
FROM (
    SELECT 
        pe.id_forma_pago,
        MONTH(pe.fecha_pedido) as mes,
        SUM(pd.sub_total) as monto_mensual
    FROM G4.pedidos pe
    INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
    WHERE YEAR(pe.fecha_pedido) = 2024
    GROUP BY pe.id_forma_pago, MONTH(pe.fecha_pedido)
) ventas_mensuales
INNER JOIN G4.forma_pago fp ON ventas_mensuales.id_forma_pago = fp.id_forma_pago
GROUP BY fp.id_forma_pago, fp.descripcion
ORDER BY promedio_mensual_pedidos DESC;

-- =====================================================
-- CONSULTA 9: PROMEDIO MONTO MENSUAL DE PEDIDOS POR TIENDAS - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 9: PROMEDIO MONTO MENSUAL DE PEDIDOS POR TIENDAS - AÑO 2024' as consulta;

SELECT 
    t.nombre as tienda,
    AVG(ventas_mensuales.monto_mensual) as promedio_mensual_pedidos,
    COUNT(DISTINCT ventas_mensuales.mes) as meses_con_ventas,
    SUM(ventas_mensuales.monto_mensual) as total_anual_pedidos,
    AVG(ventas_mensuales.pedidos_mensual) as promedio_pedidos_mes
FROM (
    SELECT 
        pe.id_tienda,
        MONTH(pe.fecha_pedido) as mes,
        SUM(pd.sub_total) as monto_mensual,
        COUNT(DISTINCT pe.id_pedido) as pedidos_mensual
    FROM G4.pedidos pe
    INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
    WHERE YEAR(pe.fecha_pedido) = 2024
    GROUP BY pe.id_tienda, MONTH(pe.fecha_pedido)
) ventas_mensuales
INNER JOIN G4.tiendas t ON ventas_mensuales.id_tienda = t.id_tienda
GROUP BY t.id_tienda, t.nombre
ORDER BY promedio_mensual_pedidos DESC;

-- =====================================================
-- CONSULTA 10: PROMEDIO MONTO MENSUAL DE PEDIDOS POR CATEGORÍAS - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 10: PROMEDIO MONTO MENSUAL DE PEDIDOS POR CATEGORÍAS - AÑO 2024' as consulta;

SELECT 
    c.descripcion as categoria,
    AVG(ventas_mensuales.monto_mensual) as promedio_mensual_pedidos,
    COUNT(DISTINCT ventas_mensuales.mes) as meses_con_ventas,
    SUM(ventas_mensuales.monto_mensual) as total_anual_pedidos,
    SUM(ventas_mensuales.unidades_mensual) as total_unidades_vendidas
FROM (
    SELECT 
        p.id_categoria,
        MONTH(pe.fecha_pedido) as mes,
        SUM(pd.sub_total) as monto_mensual,
        SUM(pd.cantidad) as unidades_mensual
    FROM G4.pedidos pe
    INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
    INNER JOIN G4.productos p ON pd.id_producto = p.id_producto
    WHERE YEAR(pe.fecha_pedido) = 2024
    GROUP BY p.id_categoria, MONTH(pe.fecha_pedido)
) ventas_mensuales
INNER JOIN G4.categorias c ON ventas_mensuales.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.descripcion
ORDER BY promedio_mensual_pedidos DESC;

-- =====================================================
-- CONSULTA 11: MONTO MENSUAL DE COMPRA POR PROVEEDORES - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 11: MONTO MENSUAL DE COMPRA POR PROVEEDORES - AÑO 2024' as consulta;

SELECT 
    pr.razon_social as proveedor,
    pr.contacto,
    MONTH(c.fecha_compra) as mes,
    DATENAME(MONTH, c.fecha_compra) as nombre_mes,
    SUM(cd.sub_total) as monto_mensual_compra,
    COUNT(DISTINCT c.id_compra) as total_compras_mes,
    SUM(cd.cantidad) as unidades_compradas_mes,
    AVG(cd.costo_unitario) as costo_promedio_mes
FROM G4.compras c
INNER JOIN G4.compras_detalle cd ON c.id_compra = cd.id_compra
INNER JOIN G4.proveedores pr ON c.id_proveedor = pr.id_proveedor
WHERE YEAR(c.fecha_compra) = 2024
GROUP BY pr.id_proveedor, pr.razon_social, pr.contacto, MONTH(c.fecha_compra), DATENAME(MONTH, c.fecha_compra)
ORDER BY pr.razon_social, mes;

-- =====================================================
-- CONSULTA 12: PROMEDIO MONTO MENSUAL DE COMPRA POR CATEGORÍAS - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 12: PROMEDIO MONTO MENSUAL DE COMPRA POR CATEGORÍAS - AÑO 2024' as consulta;

SELECT 
    c.descripcion as categoria,
    AVG(compras_mensuales.monto_mensual) as promedio_mensual_compra,
    COUNT(DISTINCT compras_mensuales.mes) as meses_con_compras,
    SUM(compras_mensuales.monto_mensual) as total_anual_compra,
    SUM(compras_mensuales.unidades_mensual) as total_unidades_compradas
FROM (
    SELECT 
        p.id_categoria,
        MONTH(comp.fecha_compra) as mes,
        SUM(cd.sub_total) as monto_mensual,
        SUM(cd.cantidad) as unidades_mensual
    FROM G4.compras comp
    INNER JOIN G4.compras_detalle cd ON comp.id_compra = cd.id_compra
    INNER JOIN G4.productos p ON cd.id_producto = p.id_producto
    WHERE YEAR(comp.fecha_compra) = 2024
    GROUP BY p.id_categoria, MONTH(comp.fecha_compra)
) compras_mensuales
INNER JOIN G4.categorias c ON compras_mensuales.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.descripcion
ORDER BY promedio_mensual_compra DESC;

-- =====================================================
-- CONSULTA 13: PROMEDIO MONTO MENSUAL DE PEDIDOS POR PEDIDO_DETALLE - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 13: PROMEDIO MONTO MENSUAL DE PEDIDOS POR PEDIDO_DETALLE - AÑO 2024' as consulta;
SELECT MES, NOMBRE_MES,AVG(monto_total_pedido) AS Promedio
FROM (
SELECT 
    MONTH(pe.fecha_pedido) as mes,
    DATENAME(MONTH, pe.fecha_pedido) as nombre_mes,
    pe.id_pedido,
    pe.nro_documento,
    pe.fecha_pedido,
    SUM(pd.sub_total) as monto_total_pedido
    --COUNT(pd.id_pedido_detalle) as total_detalles_pedido,
    --AVG(pd.sub_total) as promedio_subtotal_detalle
FROM G4.pedidos pe
INNER JOIN G4.pedidos_detalle pd ON pe.id_pedido = pd.id_pedido
WHERE YEAR(pe.fecha_pedido) = 2024
GROUP BY MONTH(pe.fecha_pedido), DATENAME(MONTH, pe.fecha_pedido), pe.id_pedido, pe.nro_documento, pe.fecha_pedido ) A 
GROUP BY MES,NOMBRE_MES
ORDER BY MES ASC;

-- =====================================================
-- CONSULTA 14: PROMEDIO MONTO MENSUAL DE COMPRA POR COMPRAS_DETALLE - AÑO 2024
-- =====================================================
SELECT 'CONSULTA 14: PROMEDIO MONTO MENSUAL DE COMPRA POR COMPRAS_DETALLE - AÑO 2024' as consulta;
SELECT MES, NOMBRE_MES,AVG(monto_total_compra) AS Promedio
FROM (
SELECT 
    MONTH(c.fecha_compra) as mes,
    DATENAME(MONTH, c.fecha_compra) as nombre_mes,
    c.id_compra,
    c.nro_documento,
    c.fecha_compra,
    SUM(cd.sub_total) as monto_total_compra,
    COUNT(cd.id_compra_detalle) as total_detalles_compra,
    AVG(cd.sub_total) as promedio_subtotal_detalle
FROM G4.compras c
INNER JOIN G4.compras_detalle cd ON c.id_compra = cd.id_compra
WHERE YEAR(c.fecha_compra) = 2024
GROUP BY MONTH(c.fecha_compra), DATENAME(MONTH, c.fecha_compra), c.id_compra, c.nro_documento, c.fecha_compra) A
GROUP BY MES,NOMBRE_MES
ORDER BY MES ASC;

GO

-- =====================================================
-- FIN DEL SCRIPT
-- =====================================================
