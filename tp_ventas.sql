-- Ej 1
SELECT * FROM pedidos ORDER BY fecha_recepcion;

-- Ej 2
SELECT * FROM vendedores WHERE apellidos LIKE '%D%az%';

-- Ej 3
SELECT id_vend, apellidos FROM vendedores WHERE fecha_ingreso > '01-01-1998'::date ORDER BY fecha_ingreso;

-- Ej 4
SELECT * FROM renglones_pdo WHERE cantidad * precio_unitario >= 200 AND cantidad * precio_unitario <= 300;

-- Ej 5
SELECT * FROM clientes WHERE apellidos LIKE 'R%' OR apellidos LIKE '% R%';

-- Ej 6
SELECT * FROM stock_local AS sl 
JOIN productos AS prod ON prod.id_producto = sl.id_producto
WHERE sl.stock < sl.punto_repedido AND prod.id_proveedor = 1;

-- Ej 7
SELECT * FROM productos WHERE precio_unitario > 10 AND id_proveedor = 3;

-- Ej 8
SELECT * FROM vendedores WHERE id_vend_responde_a IS NULL;

-- Ej 9
SELECT ov.nombre, vend.apellidos FROM 
oficinas_vtas AS ov JOIN vendedores AS vend ON ov.id_oficina = vend.id_oficina
ORDER BY ov.nombre, vend.apellidos;

-- Ej 10
SELECT pd.*, vend.apellidos, cl.apellidos FROM
pedidos AS pd
	JOIN vendedores AS vend ON pd.id_vend = vend.id_vend
	JOIN clientes AS cl ON pd.id_cliente = cl.id_cliente
WHERE fecha_recepcion >= '01-03-2000'::date AND fecha_recepcion <= '15-03-2000'::date;

-- Ej 11
SELECT pd.* FROM
pedidos AS pd
	JOIN clientes AS cl ON pd.id_cliente = cl.id_cliente
WHERE 
LOWER(cl.nombres) LIKE 'daniel%' AND LOWER(cl.apellidos) LIKE '%delponte%'
AND EXTRACT('Year' FROM pd.fecha_recepcion) = 2000;

-- Ej 12
SELECT DISTINCT id_producto, descripcion, id_proveedor
FROM productos
WHERE id_proveedor = 2;

-- Ej 13
SELECT AVG(cantidad * precio_unitario)
FROM renglones_pdo
WHERE id_pedido = 111;

-- Ej 14 terminar
SELECT vend.id_oficina, cl.cod_post, COUNT(pd.id_pedido) FROM
pedidos AS pd
	JOIN clientes AS cl ON pd.id_cliente = cl.id_cliente
	JOIN vendedores AS vend ON pd.id_vend = vend.id_vend
	JOIN oficinas_vtas AS ov ON vend.id_oficina = ov.id_oficina
	JOIN localidades AS loc ON cl.cod_post = loc.cod_post
GROUP BY vend.id_oficina, cl.cod_post
ORDER BY vend.id_oficina


-- Ej 14 profe
SELECT ov.nombre, l.nombre, COUNT(*) AS cant_pedidos
FROM pedidos AS p
JOIN clientes AS c ON p.id_cliente = c.id_cliente
JOIN vendedores AS v ON p.id_vend = v.id_vend
JOIN localidades AS l ON c.cod_post = l.cod_post
JOIN oficinas_vtas AS ov ON v.id_oficina = ov.id_oficina
GROUP BY ov.nombre, l.nombre;




	
select * from pedidos