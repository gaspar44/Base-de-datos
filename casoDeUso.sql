DROP TABLE alias CASCADE CONSTRAINTS;

DROP TABLE autor CASCADE CONSTRAINTS;

DROP TABLE colabora_en CASCADE CONSTRAINTS;

DROP TABLE colaboraciones CASCADE CONSTRAINTS;

DROP TABLE cuento CASCADE CONSTRAINTS;

DROP TABLE genero CASCADE CONSTRAINTS;

DROP TABLE hace CASCADE CONSTRAINTS;

DROP TABLE hace_colaboracion CASCADE CONSTRAINTS;

DROP TABLE publica_traduccion CASCADE CONSTRAINTS;

DROP TABLE publicar_cuento CASCADE CONSTRAINTS;

DROP TABLE revista CASCADE CONSTRAINTS;

DROP TABLE temas CASCADE CONSTRAINTS;

DROP TABLE traducciones CASCADE CONSTRAINTS;

DROP TABLE traductor CASCADE CONSTRAINTS;

DROP TABLE variante_nombre CASCADE CONSTRAINTS;

DROP TABLE vol_colaboracion CASCADE CONSTRAINTS;

DROP TABLE vol_cuento CASCADE CONSTRAINTS;

DROP TABLE volumen CASCADE CONSTRAINTS;

DROP TABLE volumen_de_revista CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alias (
    valor              VARCHAR2(200 BYTE) NOT NULL,
    autor_author_name  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE alias ADD CONSTRAINT alias_pk PRIMARY KEY ( valor,
                                                        autor_author_name );

CREATE TABLE autor (
    name        VARCHAR2(200 BYTE) NOT NULL,
    biografía   VARCHAR2(2000 BYTE),
    extranjero  INTEGER
);

ALTER TABLE autor ADD CONSTRAINT autor_pk PRIMARY KEY ( name );

CREATE TABLE colabora_en (
    traductor_nombre       VARCHAR2(200 BYTE) NOT NULL,
    colaboraciones_titulo  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE colabora_en ADD CONSTRAINT colabora_en_pk PRIMARY KEY ( traductor_nombre,
                                                                    colaboraciones_titulo );

CREATE TABLE colaboraciones (
    titulo         VARCHAR2(200 BYTE) NOT NULL,
    clasificacion  VARCHAR2(100 BYTE),
    notas          VARCHAR2(500 CHAR),
    versos         VARCHAR2(500 CHAR),
    pinicial       INTEGER,
    pfinal         INTEGER,
    pseudonimo     VARCHAR2(200 BYTE)
);

ALTER TABLE colaboraciones ADD CONSTRAINT colaboraciones_pk PRIMARY KEY ( titulo );

CREATE TABLE cuento (
    tale_title  VARCHAR2(200 BYTE) NOT NULL,
    used_alias  VARCHAR2(200 BYTE),
    autor_name  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE cuento ADD CONSTRAINT cuento_pk PRIMARY KEY ( tale_title );

CREATE TABLE genero (
    valor       VARCHAR2(200 BYTE) NOT NULL,
    tale_title  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( valor,
                                                          tale_title );

CREATE TABLE hace (
    traducciones_titulo  VARCHAR2(200 BYTE) NOT NULL,
    traductor_nombre     VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE hace ADD CONSTRAINT hace_pk PRIMARY KEY ( traducciones_titulo,
                                                      traductor_nombre );

CREATE TABLE hace_colaboracion (
    colaboraciones_titulo  VARCHAR2(200 BYTE) NOT NULL,
    autor_name             VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE hace_colaboracion ADD CONSTRAINT hace_colaboracion_pk PRIMARY KEY ( colaboraciones_titulo,
                                                                                autor_name );

CREATE TABLE publica_traduccion (
    volumen_de_revista_fecha  DATE NOT NULL,
    revista_titulo            VARCHAR2(200 BYTE) NOT NULL,
    traducciones_titulo       VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE publica_traduccion
    ADD CONSTRAINT publica_traduccion_pk PRIMARY KEY ( volumen_de_revista_fecha,
                                                       revista_titulo,
                                                       traducciones_titulo );

CREATE TABLE publicar_cuento (
    cuento_tale_title  VARCHAR2(200 BYTE) NOT NULL,
    paginas            VARCHAR2(200 BYTE),
    revista_fecha      DATE NOT NULL,
    revista_titulo     VARCHAR2(200 BYTE) NOT NULL,
    fiability          INTEGER,
    variante_titulo    VARCHAR2(200 BYTE)
);

ALTER TABLE publicar_cuento
    ADD CONSTRAINT revista_publica_cuento_pk PRIMARY KEY ( cuento_tale_title,
                                                           revista_fecha,
                                                           revista_titulo );

CREATE TABLE revista (
    titulo VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE revista ADD CONSTRAINT revista_pk PRIMARY KEY ( titulo );

CREATE TABLE temas (
    valor       VARCHAR2(200 BYTE) NOT NULL,
    tale_title  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE temas ADD CONSTRAINT temas_pk PRIMARY KEY ( valor,
                                                        tale_title );

CREATE TABLE traducciones (
    titulo           VARCHAR2(200 BYTE) NOT NULL,
    titulo_original  VARCHAR2(200 BYTE),
    firma            VARCHAR2(200 BYTE)
);

ALTER TABLE traducciones ADD CONSTRAINT traducciones_pk PRIMARY KEY ( titulo );

CREATE TABLE traductor (
    nombre VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE traductor ADD CONSTRAINT traductor_pk PRIMARY KEY ( nombre );

CREATE TABLE variante_nombre (
    valor       VARCHAR2(200 BYTE) NOT NULL,
    autor_name  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE variante_nombre ADD CONSTRAINT variante_nombre_pk PRIMARY KEY ( valor,
                                                                            autor_name );

CREATE TABLE vol_colaboracion (
    revista_fecha          DATE NOT NULL,
    revista_titulo         VARCHAR2(200 BYTE) NOT NULL,
    colaboraciones_titulo  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE vol_colaboracion
    ADD CONSTRAINT vol_colaboracion_pk PRIMARY KEY ( revista_fecha,
                                                     revista_titulo,
                                                     colaboraciones_titulo );

CREATE TABLE vol_cuento (
    cuento_tale_title  VARCHAR2(200 BYTE) NOT NULL,
    volumen_titulo     VARCHAR2(200 BYTE) NOT NULL,
    paginas            VARCHAR2(200 BYTE),
    fability           INTEGER,
    volumen_editorial  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE vol_cuento
    ADD CONSTRAINT vol_cuento_pk PRIMARY KEY ( cuento_tale_title,
                                               volumen_titulo,
                                               volumen_editorial );

CREATE TABLE volumen (
    titulo             VARCHAR2(200 BYTE) NOT NULL,
    fecha_publicacion  DATE,
    lugar              VARCHAR2(200 BYTE),
    editorial          VARCHAR2(200 BYTE) NOT NULL,
    autor_name         VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE volumen ADD CONSTRAINT volumen_pk PRIMARY KEY ( titulo,
                                                            editorial );

CREATE TABLE volumen_de_revista (
    fecha           DATE NOT NULL,
    numero          INTEGER,
    volumen         VARCHAR2(200 BYTE),
    revista_titulo  VARCHAR2(200 BYTE) NOT NULL
);

ALTER TABLE volumen_de_revista ADD CONSTRAINT volumen_de_revista_pk PRIMARY KEY ( fecha,
                                                                                  revista_titulo );

ALTER TABLE alias
    ADD CONSTRAINT alias_autor_fk FOREIGN KEY ( autor_author_name )
        REFERENCES autor ( name );

ALTER TABLE hace_colaboracion
    ADD CONSTRAINT autor_fk FOREIGN KEY ( autor_name )
        REFERENCES autor ( name );

ALTER TABLE colabora_en
    ADD CONSTRAINT colabora_en_colaboraciones_fk FOREIGN KEY ( colaboraciones_titulo )
        REFERENCES colaboraciones ( titulo );

ALTER TABLE colabora_en
    ADD CONSTRAINT colabora_en_traductor_fk FOREIGN KEY ( traductor_nombre )
        REFERENCES traductor ( nombre );

ALTER TABLE vol_colaboracion
    ADD CONSTRAINT colaboraciones_fk FOREIGN KEY ( colaboraciones_titulo )
        REFERENCES colaboraciones ( titulo );

ALTER TABLE hace_colaboracion
    ADD CONSTRAINT colaboraciones_fkv1 FOREIGN KEY ( colaboraciones_titulo )
        REFERENCES colaboraciones ( titulo );

ALTER TABLE cuento
    ADD CONSTRAINT cuento_autor_fk FOREIGN KEY ( autor_name )
        REFERENCES autor ( name );

ALTER TABLE genero
    ADD CONSTRAINT genero_cuento_fk FOREIGN KEY ( tale_title )
        REFERENCES cuento ( tale_title );

ALTER TABLE hace
    ADD CONSTRAINT hace_traducciones_fk FOREIGN KEY ( traducciones_titulo )
        REFERENCES traducciones ( titulo );

ALTER TABLE hace
    ADD CONSTRAINT hace_traductor_fk FOREIGN KEY ( traductor_nombre )
        REFERENCES traductor ( nombre );

ALTER TABLE publicar_cuento
    ADD CONSTRAINT publicar_cuento_fk FOREIGN KEY ( cuento_tale_title )
        REFERENCES cuento ( tale_title );

ALTER TABLE temas
    ADD CONSTRAINT temas_cuento_fk FOREIGN KEY ( tale_title )
        REFERENCES cuento ( tale_title );

ALTER TABLE publica_traduccion
    ADD CONSTRAINT traducciones_fk FOREIGN KEY ( traducciones_titulo )
        REFERENCES traducciones ( titulo );

ALTER TABLE variante_nombre
    ADD CONSTRAINT variante_nombre_autor_fk FOREIGN KEY ( autor_name )
        REFERENCES autor ( name );

ALTER TABLE vol_cuento
    ADD CONSTRAINT vol_cuento_cuento_fk FOREIGN KEY ( cuento_tale_title )
        REFERENCES cuento ( tale_title );

ALTER TABLE vol_cuento
    ADD CONSTRAINT vol_cuento_volumen_fk FOREIGN KEY ( volumen_titulo,
                                                       volumen_editorial )
        REFERENCES volumen ( titulo,
                             editorial );

ALTER TABLE volumen
    ADD CONSTRAINT volumen_autor_fk FOREIGN KEY ( autor_name )
        REFERENCES autor ( name );

ALTER TABLE vol_colaboracion
    ADD CONSTRAINT volumen_de_revista_fk FOREIGN KEY ( revista_fecha,
                                                       revista_titulo )
        REFERENCES volumen_de_revista ( fecha,
                                        revista_titulo );

ALTER TABLE publica_traduccion
    ADD CONSTRAINT volumen_de_revista_fkv1 FOREIGN KEY ( volumen_de_revista_fecha,
                                                         revista_titulo )
        REFERENCES volumen_de_revista ( fecha,
                                        revista_titulo );

ALTER TABLE volumen_de_revista
    ADD CONSTRAINT volumen_de_revista_fkv2 FOREIGN KEY ( revista_titulo )
        REFERENCES revista ( titulo );

ALTER TABLE publicar_cuento
    ADD CONSTRAINT volumen_de_revista_fkv3 FOREIGN KEY ( revista_fecha,
                                                         revista_titulo )
        REFERENCES volumen_de_revista ( fecha,
                                        revista_titulo );


@datos/autor.sql;
@datos/alias.sql;
@datos/variante_nombre.sql;

@datos/cuento.sql;
@datos/temas.sql;

@datos/genero.sql;
@datos/revista.sql;

@datos/volumen_de_revista.sql;

@datos/publicar_cuento.sql;

@datos/volumen.sql;
@datos/vol_cuento.sql;

@datos/traducciones.sql;
@datos/traductor.sql;
@datos/hace.sql;

@datos/publica_traduccion.sql;

@datos/colaboraciones.sql;
@datos/colabora_en.sql;
@datos/hace_colaboracion.sql;
@datos/vol_colaboracion.sql;