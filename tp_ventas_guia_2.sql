-- Ejercicio 1
SELECT * FROM renglones_pdo
WHERE id_pedido >= 110 AND
precio_unitario >= (SELECT precio_unitario FROM productos WHERE descripcion = 'Chocolate Garoto con Nougat')
ORDER BY id_producto, precio_unitario;

-- Ejercicio 2
SELECT cl.apellidos, cl.nombres FROM
clientes AS cl
JOIN pedidos AS pd ON cl.id_cliente = pd.id_cliente
JOIN vendedores AS vend ON pd.id_vend = vend.id_vend
WHERE vend.id_oficina = (SELECT ov.id_oficina FROM oficinas_vtas ov WHERE ov.cod_post = 3000)
GROUP BY cl.apellidos, cl.nombres;

-- Ejercicio 3
SELECT pd.id_pedido FROM 
pedidos AS pd
JOIN renglones_pdo AS rp ON pd.id_pedido = rp.id_pedido
GROUP BY pd.id_pedido
HAVING COUNT(rp.*) > (SELECT COUNT(*) FROM renglones_pdo WHERE id_pedido = 113)
ORDER BY pd.id_pedido;

-- Ejercicio 4
SELECT cargo, AVG(ventas) avg_ventas FROM vendedores
GROUP BY cargo
HAVING AVG(ventas) IS NOT NULL
ORDER BY avg_ventas ASC
LIMIT 1;

-- Ejercicio 5
SELECT apellidos, nombres FROM vendedores
WHERE cargo = 
	(SELECT cargo FROM vendedores
	GROUP BY cargo
	HAVING AVG(ventas) IS NOT NULL
	ORDER BY AVG(ventas) ASC
	LIMIT 1);
	
-- Ejercicio 6
SELECT apellidos FROM clientes
WHERE id_cliente IN 
	(SELECT id_cliente FROM pedidos WHERE pedido_cumplido = 'V');
	
-- Ejercicio 7
-- Inciso a
SELECT ov.id_oficina, ov.nombre FROM
oficinas_vtas AS ov
JOIN stock_local as sl ON sl.id_oficina = ov.id_oficina
WHERE sl.stock > 0
GROUP BY ov.id_oficina, ov.nombre
ORDER BY ov.id_oficina;

-- Inciso b
SELECT ov.id_oficina, ov.nombre FROM
oficinas_vtas AS ov
JOIN stock_local AS sl ON sl.id_oficina = ov.id_oficina
WHERE NOT EXISTS (
	SELECT sl.id_producto FROM stock_local sl JOIN productos AS prod
		ON sl.id_producto = prod.id_producto
)
GROUP BY ov.id_oficina, ov.nombre;

-- Ejercicio 8
SELECT ov.nombre, cl.apellidos, COUNT(pd.*) cant_pedidos
FROM pedidos AS pd JOIN vendedores AS vend ON pd.id_vend = vend.id_vend
JOIN clientes AS cl ON pd.id_cliente = cl.id_cliente
JOIN oficinas_vtas AS ov ON vend.id_oficina = ov.id_oficina
WHERE cl.cod_post = 2000
GROUP BY ov.nombre, cl.apellidos
HAVING COUNT(pd.*) > 1;

-- Ejercicio 9
SELECT cl.id_cliente, cl.apellidos, cl.domicilio, cl.cod_post, ov.nombre nombre_oficina
FROM clientes AS cl JOIN pedidos AS pd ON cl.id_cliente = pd.id_cliente
JOIN vendedores AS vend ON pd.id_vend = vend.id_vend
JOIN oficinas_vtas AS ov ON vend.id_oficina = ov.id_oficina
JOIN localidades AS loc ON cl.cod_post = loc.cod_post
WHERE loc.id_prov = 'S' OR 
	vend.id_oficina = (SELECT id_oficina FROM oficinas_vtas WHERE cod_post = 3300)
ORDER BY cl.apellidos;

-- Ejercicio 10
