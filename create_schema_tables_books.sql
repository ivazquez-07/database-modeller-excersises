
CREATE TABLE books.Tb_EDITORIAL (
                cod_editorial VARCHAR(10) NOT NULL,
                nombre_contacto VARCHAR(100) NOT NULL,
                email VARCHAR(50) NOT NULL,
                telefono_1 VARCHAR(12) NOT NULL,
                telefono_2 VARCHAR(12),
                CONSTRAINT tb_editorial_pk PRIMARY KEY (cod_editorial)
);
COMMENT ON TABLE books.Tb_EDITORIAL IS 'Tabla de las editoriales de los libros que serán parte del proyecto del Club del Libro';
COMMENT ON COLUMN books.Tb_EDITORIAL.cod_editorial IS 'Esta es la clave principal ';


CREATE TABLE books.Tb_LIBRO (
                cod_libro VARCHAR(10) NOT NULL,
                titulo VARCHAR(100) NOT NULL,
                categoria VARCHAR(20) NOT NULL,
                isbn VARCHAR(20) NOT NULL,
                fecha_publicacion INTEGER NOT NULL,
                editorial VARCHAR(100) NOT NULL,
                autor VARCHAR(50) NOT NULL,
                valor NUMERIC NOT NULL,
                cod_editorial VARCHAR(10) NOT NULL,
                CONSTRAINT tb_libro_pk PRIMARY KEY (cod_libro)
);
COMMENT ON COLUMN books.Tb_LIBRO.cod_libro IS 'clave parcial debido a que es una entidad debil';
COMMENT ON COLUMN books.Tb_LIBRO.cod_editorial IS 'Esta es la clave principal ';


CREATE TABLE books.Tb_INVENTARIO (
                cod_libro VARCHAR(10) NOT NULL,
                cantidad INTEGER NOT NULL,
                CONSTRAINT tb_inventario_pk PRIMARY KEY (cod_libro)
);
COMMENT ON COLUMN books.Tb_INVENTARIO.cod_libro IS 'clave parcial debido a que es una entidad debil';


CREATE TABLE books.Tb_CLIENTE (
                cod_cliente VARCHAR(10) NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                telefono VARCHAR(12) NOT NULL,
                email VARCHAR(50) NOT NULL,
                calle VARCHAR(50) NOT NULL,
                comuna VARCHAR(50) NOT NULL,
                ciudad VARCHAR(50) NOT NULL,
                region VARCHAR(20) NOT NULL,
                CONSTRAINT tb_cliente_pk PRIMARY KEY (cod_cliente)
);
COMMENT ON TABLE books.Tb_CLIENTE IS 'Tabla para los clientes del Club del Libro';
COMMENT ON COLUMN books.Tb_CLIENTE.cod_cliente IS 'Esta columna será la clave principal.
Se utiliza VARCHAR (alfanuméricos) por una cuestión de diseño para poder usar ceros a la izquierda por ejemplo y evitar que sean eliminado utilizando tipo numéro.';


CREATE TABLE books.Tb_PJ (
                cod_cliente VARCHAR(10) NOT NULL,
                nit VARCHAR(12) NOT NULL,
                rues VARCHAR(12) NOT NULL,
                CONSTRAINT tb_pj_pk PRIMARY KEY (cod_cliente)
);
COMMENT ON TABLE books.Tb_PJ IS 'Tablas de atributos de especialidad para Personas Jurídicas';
COMMENT ON COLUMN books.Tb_PJ.cod_cliente IS 'Esta columna será la clave principal.
Se utiliza VARCHAR (alfanuméricos) por una cuestión de diseño para poder usar ceros a la izquierda por ejemplo y evitar que sean eliminado utilizando tipo numéro.';


CREATE TABLE books.Tb_PN (
                cod_cliente VARCHAR(10) NOT NULL,
                dni VARCHAR(12) NOT NULL,
                rut VARCHAR(12) NOT NULL,
                CONSTRAINT tb_pn_pk PRIMARY KEY (cod_cliente)
);
COMMENT ON TABLE books.Tb_PN IS 'Tablas de atributos de especialidad para personas naturales';
COMMENT ON COLUMN books.Tb_PN.cod_cliente IS 'Esta columna será la clave principal.
Se utiliza VARCHAR (alfanuméricos) por una cuestión de diseño para poder usar ceros a la izquierda por ejemplo y evitar que sean eliminado utilizando tipo numéro.';


CREATE TABLE books.Tb_PEDIDO (
                cod_pedido VARCHAR(10) NOT NULL,
                fecha DATE NOT NULL,
                valor NUMERIC NOT NULL,
                cod_cliente VARCHAR(10) NOT NULL,
                CONSTRAINT tb_pedido_pk PRIMARY KEY (cod_pedido)
);
COMMENT ON COLUMN books.Tb_PEDIDO.cod_pedido IS 'Esta es una clave parcial.';
COMMENT ON COLUMN books.Tb_PEDIDO.cod_cliente IS 'Esta columna será la clave principal.
Se utiliza VARCHAR (alfanuméricos) por una cuestión de diseño para poder usar ceros a la izquierda por ejemplo y evitar que sean eliminado utilizando tipo numéro.';


CREATE TABLE books.Tb_ITEMS (
                cod_pedido VARCHAR(10) NOT NULL,
                cod_libro VARCHAR(10) NOT NULL,
                valor NUMERIC,
                cantidad INTEGER NOT NULL,
                CONSTRAINT tb_items_pk PRIMARY KEY (cod_pedido, cod_libro)
);
COMMENT ON COLUMN books.Tb_ITEMS.cod_pedido IS 'Esta es una clave parcial.';
COMMENT ON COLUMN books.Tb_ITEMS.cod_libro IS 'clave parcial debido a que es una entidad debil';


ALTER TABLE books.Tb_LIBRO ADD CONSTRAINT tb_editorial_tb_libro_fk
FOREIGN KEY (cod_editorial)
REFERENCES books.Tb_EDITORIAL (cod_editorial)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_ITEMS ADD CONSTRAINT tb_libro_tb_items_fk
FOREIGN KEY (cod_libro)
REFERENCES books.Tb_LIBRO (cod_libro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_INVENTARIO ADD CONSTRAINT tb_libro_tb_inventario_fk
FOREIGN KEY (cod_libro)
REFERENCES books.Tb_LIBRO (cod_libro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_PEDIDO ADD CONSTRAINT tb_cliente_tb_pedido_fk
FOREIGN KEY (cod_cliente)
REFERENCES books.Tb_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_PN ADD CONSTRAINT tb_cliente_tb_pn_fk
FOREIGN KEY (cod_cliente)
REFERENCES books.Tb_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_PJ ADD CONSTRAINT tb_cliente_tb_pj_fk
FOREIGN KEY (cod_cliente)
REFERENCES books.Tb_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE books.Tb_ITEMS ADD CONSTRAINT tb_pedido_tb_items_fk
FOREIGN KEY (cod_pedido)
REFERENCES books.Tb_PEDIDO (cod_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
