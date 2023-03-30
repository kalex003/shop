--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: shop; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA shop;


ALTER SCHEMA shop OWNER TO postgres;

--
-- Name: staff_delete(); Type: FUNCTION; Schema: shop; Owner: postgres
--

CREATE FUNCTION shop.staff_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE staff set active=false where id=old.id;
        RAISE NOTICE 'Вместо удаления обновлен статус';
        RETURN NULL;
    end;
    $$;


ALTER FUNCTION shop.staff_delete() OWNER TO postgres;

--
-- Name: suppliers_delete(); Type: FUNCTION; Schema: shop; Owner: postgres
--

CREATE FUNCTION shop.suppliers_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE suppliers set active=false where id=old.id;
        RAISE NOTICE 'Вместо удаления обновлен статус';
        RETURN NULL;
    end;
    $$;


ALTER FUNCTION shop.suppliers_delete() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: items; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.items (
    id integer NOT NULL,
    price integer NOT NULL,
    name character varying(30) NOT NULL,
    quantity integer NOT NULL,
    size character varying(3) NOT NULL
);


ALTER TABLE shop.items OWNER TO postgres;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.items_id_seq OWNER TO postgres;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.items_id_seq OWNED BY shop.items.id;


--
-- Name: posts; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.posts (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    salary numeric(8,2) NOT NULL
);


ALTER TABLE shop.posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.posts_id_seq OWNED BY shop.posts.id;


--
-- Name: purchases; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.purchases (
    id integer NOT NULL,
    item_id integer,
    supplier_id integer,
    item_name character varying NOT NULL,
    quantity integer NOT NULL,
    price integer NOT NULL,
    purch_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE shop.purchases OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.purchases_id_seq OWNER TO postgres;

--
-- Name: purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.purchases_id_seq OWNED BY shop.purchases.id;


--
-- Name: sales; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.sales (
    id integer NOT NULL,
    item_id integer,
    seller_id integer,
    quantity integer NOT NULL,
    amount integer NOT NULL,
    sale_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE shop.sales OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.sales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.sales_id_seq OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.sales_id_seq OWNED BY shop.sales.id;


--
-- Name: staff; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.staff (
    id integer NOT NULL,
    id_post integer,
    full_name jsonb NOT NULL,
    phone_number character varying(15) NOT NULL,
    snils character varying(14) NOT NULL,
    inn integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    percent integer NOT NULL,
    percent_income numeric(8,2) DEFAULT 0 NOT NULL
);


ALTER TABLE shop.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.staff_id_seq OWNED BY shop.staff.id;


--
-- Name: suppliers; Type: TABLE; Schema: shop; Owner: postgres
--

CREATE TABLE shop.suppliers (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    inn integer NOT NULL,
    phone_number character varying(15) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    adress text NOT NULL
);


ALTER TABLE shop.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: shop; Owner: postgres
--

CREATE SEQUENCE shop.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shop.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: shop; Owner: postgres
--

ALTER SEQUENCE shop.suppliers_id_seq OWNED BY shop.suppliers.id;


--
-- Name: items id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.items ALTER COLUMN id SET DEFAULT nextval('shop.items_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.posts ALTER COLUMN id SET DEFAULT nextval('shop.posts_id_seq'::regclass);


--
-- Name: purchases id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.purchases ALTER COLUMN id SET DEFAULT nextval('shop.purchases_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sales ALTER COLUMN id SET DEFAULT nextval('shop.sales_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.staff ALTER COLUMN id SET DEFAULT nextval('shop.staff_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.suppliers ALTER COLUMN id SET DEFAULT nextval('shop.suppliers_id_seq'::regclass);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: staff staff_inn_key; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.staff
    ADD CONSTRAINT staff_inn_key UNIQUE (inn);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: staff staff_snils_key; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.staff
    ADD CONSTRAINT staff_snils_key UNIQUE (snils);


--
-- Name: suppliers suppliers_inn_key; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.suppliers
    ADD CONSTRAINT suppliers_inn_key UNIQUE (inn);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: staff staff_trigger; Type: TRIGGER; Schema: shop; Owner: postgres
--

CREATE TRIGGER staff_trigger BEFORE DELETE ON shop.staff FOR EACH ROW EXECUTE FUNCTION shop.staff_delete();


--
-- Name: suppliers suppliers_trigger; Type: TRIGGER; Schema: shop; Owner: postgres
--

CREATE TRIGGER suppliers_trigger BEFORE DELETE ON shop.suppliers FOR EACH ROW EXECUTE FUNCTION shop.suppliers_delete();


--
-- Name: purchases purchases_item_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.purchases
    ADD CONSTRAINT purchases_item_id_fkey FOREIGN KEY (item_id) REFERENCES shop.items(id);


--
-- Name: purchases purchases_supplier_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.purchases
    ADD CONSTRAINT purchases_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES shop.suppliers(id);


--
-- Name: sales sales_item_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sales
    ADD CONSTRAINT sales_item_id_fkey FOREIGN KEY (item_id) REFERENCES shop.items(id);


--
-- Name: sales sales_seller_id_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.sales
    ADD CONSTRAINT sales_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES shop.staff(id);


--
-- Name: staff staff_id_post_fkey; Type: FK CONSTRAINT; Schema: shop; Owner: postgres
--

ALTER TABLE ONLY shop.staff
    ADD CONSTRAINT staff_id_post_fkey FOREIGN KEY (id_post) REFERENCES shop.posts(id);


--
-- PostgreSQL database dump complete
--

