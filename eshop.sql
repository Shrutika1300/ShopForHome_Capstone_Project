-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'SOFA SETS', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'TABLES', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'CHAIRS', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'LAMPS', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');

--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Solimo Alen Fabric 6 Seater RHS L Shape Sofa', 'https://m.media-amazon.com/images/I/81QjP0YD6bL._SY450_.jpg', 'Sofa Set 1', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Casaliving Lifestyle 6 Seater L Shape Sofa for Living Room [Grey]', 'https://m.media-amazon.com/images/I/61rRwnUYheL._SY450_.jpg', 'Sofa Set 2', 65.00, 0, 60, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Torque - Jamestown L Shape 8 Seater Fabric Sofa Set for Living Room with Center Table and 2 Puffy', 'https://m.media-amazon.com/images/I/714o0Nx9hIS._SL1500_.jpg', 'Sofa Set 3', 45.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Furniture Land Sofa Set for Home and Office sl8', 'https://m.media-amazon.com/images/I/31YGT9PLj7L.jpg', 'Sofa Set 4', 45.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-06-23 23:03:26', 'Home furniture Wooden Sofa Set for Living Room and Office 3 Three Seater', 'https://m.media-amazon.com/images/I/41buES1dngS._SX450_.jpg', 'Sofa Set 5', 45.00, 0, 40, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF006', 0, '2022-06-23 23:03:26', 'Hiputee Premium Floor Seat Sofa, Couch, Pouf and Backrest, Floor Seating, Sofa Living, Reading Book, Playing, Washable Cover', 'https://m.media-amazon.com/images/I/81RBkXXPpcL._SL1500_.jpg', 'Sofa Set 6', 45.00, 0, 40, '2022-06-23 23:03:26');



INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Beautiful Antique Wooden', 'https://m.media-amazon.com/images/I/51eoKWxpEQL._SL1302_.jpg', 'Hanging Fish for Room Decoration', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Coffee Table Sturdy Side Table for Home', 'https://m.media-amazon.com/images/I/512f66M6TxL.jpg', 'Metal Wall Decor Wall Hanging', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Adan Home Farmhouse Accent Coffee Table Simple Modern Bedside Cabinet Table ', 'https://m.media-amazon.com/images/I/51+JefxuIdL.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-06-23 23:03:26', 'Simran Handicrafts Generic Indiana Bowed Round Coffee Table', 'https://m.media-amazon.com/images/I/51DD2ri7gPL.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-06-23 23:03:26', 'Acco & Deco 2 Tier Wooden Multipurpose Turn-n-Tube Engineered Wood End Table', 'https://m.media-amazon.com/images/I/911uQooswYL._SL1500_.jpg', 'Metal Lord Ganesha', 45.00, 0, 50,'2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS006', 1, '2022-06-23 23:03:26', 'Heera Moti Boxx Engineered Wood Coffee Table', 'https://m.media-amazon.com/images/I/414qSz4lKUL.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', ' Supreme Kent Plastic Chair', 'https://m.media-amazon.com/images/I/51UPESeoZmS._AC_UL320_.jpg', 'CHAIR 1', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Furniture 9012 Armchairs', 'https://m.media-amazon.com/images/I/81GjxBoPafL._SL1500_.jpg', 'CHAIR 2', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Featherlite ''Astro'' Mesh Home & Office Ergonomic Chair', 'https://m.media-amazon.com/images/I/71vrTpx6+oL._SX679_.jpg', 'CHAIR 3 ', 95.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-06-23 23:03:26', 'Basics Low-Back Computer Chair', 'https://m.media-amazon.com/images/I/81pEngXQOyS._SL1500_.jpg', 'CHAIR 4 ', 95.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-06-23 23:03:26', 'ANJWAR Tub Chair with Complimentary Cushions Set of 02 ', 'https://m.media-amazon.com/images/I/619Ur58AU7L._SL1500_.jpg', 'CHAIR 5', 95.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA006', 2, '2022-06-23 23:03:26', 'Solimo XXL Faux Leather Bean Bag Cover Without Beans', 'https://m.media-amazon.com/images/I/71c4kiOuIyL._SL1500_.jpg', 'CHAIR 6', 95.00, 0, 70, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Crosscut furniture Wooden Floor Lamp', 'https://m.media-amazon.com/images/I/81U6QhjMTmL._SL1500_.jpg', 'LAMP 1 ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Bonsai Led Light Desk Tree Lamps ', 'https://m.media-amazon.com/images/I/619nfGytrJL._SL1500_.jpg', 'LAMP 2', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'Mushroom Shaped Glass Table lamp', 'https://m.media-amazon.com/images/I/41Cr7nMl+ZL.jpg', 'LAMP 3 ', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-06-23 23:03:26', 'Twilight Wall Light, Wall Lamp Wood Light for Home', 'https://m.media-amazon.com/images/I/819dJoKFDiL._SL1500_.jpg', 'LAMP 4 ', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF005', 3, '2022-06-23 23:03:26', 'olor Changing 15 cm with Stand Moon Night Rechargeable Lamp', 'https://m.media-amazon.com/images/I/51hQn2ywyEL._SL1000_.jpg', 'LAMP 5', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF006', 3, '2022-06-23 23:03:26', 'Homesake Hanging Light', 'https://m.media-amazon.com/images/I/81DuXHJBH5L._SL1500_.jpg', 'LAMP 6 ', 82.00, 0, 20, '2022-06-23 23:03:26');




------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
----------------------------------------------
--USER TABLE


CREATE SEQUENCE IF NOT EXISTS 
public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;