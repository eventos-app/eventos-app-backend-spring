--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Debian 14.17-1.pgdg120+1)
-- Dumped by pg_dump version 14.17 (Debian 14.17-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.countries (
    id_country integer NOT NULL,
    name character varying
);


ALTER TABLE public.countries OWNER TO festiva;

--
-- Name: countries_id_country_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.countries_id_country_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_country_seq OWNER TO festiva;

--
-- Name: countries_id_country_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.countries_id_country_seq OWNED BY public.countries.id_country;


--
-- Name: events; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.events (
    id_event integer NOT NULL,
    name character varying,
    id_space integer,
    date timestamp without time zone,
    enable boolean,
    description character varying
);


ALTER TABLE public.events OWNER TO festiva;

--
-- Name: events_id_event_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.events_id_event_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_event_seq OWNER TO festiva;

--
-- Name: events_id_event_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.events_id_event_seq OWNED BY public.events.id_event;


--
-- Name: events_tickets; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.events_tickets (
    id_event_ticket integer NOT NULL,
    id_event integer,
    id_ticket integer
);


ALTER TABLE public.events_tickets OWNER TO festiva;

--
-- Name: events_tickets_id_event_ticket_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.events_tickets_id_event_ticket_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_tickets_id_event_ticket_seq OWNER TO festiva;

--
-- Name: events_tickets_id_event_ticket_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.events_tickets_id_event_ticket_seq OWNED BY public.events_tickets.id_event_ticket;


--
-- Name: products; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.products (
    id_product integer NOT NULL,
    name character varying,
    description character varying,
    amount double precision,
    stock integer,
    expiration_date date,
    size character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    id_type_product integer,
    id_provider integer
);


ALTER TABLE public.products OWNER TO festiva;

--
-- Name: productos_id_product_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.productos_id_product_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productos_id_product_seq OWNER TO festiva;

--
-- Name: productos_id_product_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.productos_id_product_seq OWNED BY public.products.id_product;


--
-- Name: providers; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.providers (
    id_provider integer NOT NULL,
    name character varying
);


ALTER TABLE public.providers OWNER TO festiva;

--
-- Name: providers_id_provider_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.providers_id_provider_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.providers_id_provider_seq OWNER TO festiva;

--
-- Name: providers_id_provider_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.providers_id_provider_seq OWNED BY public.providers.id_provider;


--
-- Name: spaces; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.spaces (
    id_space integer NOT NULL,
    name character varying,
    id_country integer,
    latitude double precision,
    longitude double precision
);


ALTER TABLE public.spaces OWNER TO festiva;

--
-- Name: spaces_id_space_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.spaces_id_space_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spaces_id_space_seq OWNER TO festiva;

--
-- Name: spaces_id_space_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.spaces_id_space_seq OWNED BY public.spaces.id_space;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.tickets (
    id_ticket integer NOT NULL,
    id_participant character varying
);


ALTER TABLE public.tickets OWNER TO festiva;

--
-- Name: tickets_id_ticket_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.tickets_id_ticket_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_ticket_seq OWNER TO festiva;

--
-- Name: tickets_id_ticket_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.tickets_id_ticket_seq OWNED BY public.tickets.id_ticket;


--
-- Name: transactions_types; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.transactions_types (
    id_transaction_type integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.transactions_types OWNER TO festiva;

--
-- Name: transaction_type_id_transaction_type_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.transaction_type_id_transaction_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_type_id_transaction_type_seq OWNER TO festiva;

--
-- Name: transaction_type_id_transaction_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.transaction_type_id_transaction_type_seq OWNED BY public.transactions_types.id_transaction_type;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.transactions (
    id_transaction integer NOT NULL,
    date timestamp without time zone,
    id_transaction_type integer,
    amount double precision
);


ALTER TABLE public.transactions OWNER TO festiva;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.transactions_id_transaction_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_transaction_seq OWNER TO festiva;

--
-- Name: transactions_id_transaction_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.transactions_id_transaction_seq OWNED BY public.transactions.id_transaction;


--
-- Name: types_products; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.types_products (
    id_type_product integer NOT NULL,
    name character varying
);


ALTER TABLE public.types_products OWNER TO festiva;

--
-- Name: types_products_id_type_product_seq; Type: SEQUENCE; Schema: public; Owner: festiva
--

CREATE SEQUENCE public.types_products_id_type_product_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.types_products_id_type_product_seq OWNER TO festiva;

--
-- Name: types_products_id_type_product_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: festiva
--

ALTER SEQUENCE public.types_products_id_type_product_seq OWNED BY public.types_products.id_type_product;


--
-- Name: users; Type: TABLE; Schema: public; Owner: festiva
--

CREATE TABLE public.users (
    id_usuario character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    phone character varying,
    email character varying
);


ALTER TABLE public.users OWNER TO festiva;

--
-- Name: countries id_country; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.countries ALTER COLUMN id_country SET DEFAULT nextval('public.countries_id_country_seq'::regclass);


--
-- Name: events id_event; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events ALTER COLUMN id_event SET DEFAULT nextval('public.events_id_event_seq'::regclass);


--
-- Name: events_tickets id_event_ticket; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events_tickets ALTER COLUMN id_event_ticket SET DEFAULT nextval('public.events_tickets_id_event_ticket_seq'::regclass);


--
-- Name: products id_product; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.products ALTER COLUMN id_product SET DEFAULT nextval('public.productos_id_product_seq'::regclass);


--
-- Name: providers id_provider; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.providers ALTER COLUMN id_provider SET DEFAULT nextval('public.providers_id_provider_seq'::regclass);


--
-- Name: spaces id_space; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.spaces ALTER COLUMN id_space SET DEFAULT nextval('public.spaces_id_space_seq'::regclass);


--
-- Name: tickets id_ticket; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id_ticket SET DEFAULT nextval('public.tickets_id_ticket_seq'::regclass);


--
-- Name: transactions id_transaction; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id_transaction SET DEFAULT nextval('public.transactions_id_transaction_seq'::regclass);


--
-- Name: transactions_types id_transaction_type; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.transactions_types ALTER COLUMN id_transaction_type SET DEFAULT nextval('public.transaction_type_id_transaction_type_seq'::regclass);


--
-- Name: types_products id_type_product; Type: DEFAULT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.types_products ALTER COLUMN id_type_product SET DEFAULT nextval('public.types_products_id_type_product_seq'::regclass);


--
-- Name: countries countries_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (id_country);


--
-- Name: events events_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pk PRIMARY KEY (id_event);


--
-- Name: events_tickets events_tickets_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events_tickets
    ADD CONSTRAINT events_tickets_pk PRIMARY KEY (id_event_ticket);


--
-- Name: products productos_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT productos_pk PRIMARY KEY (id_product);


--
-- Name: providers providers_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pk PRIMARY KEY (id_provider);


--
-- Name: spaces spaces_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.spaces
    ADD CONSTRAINT spaces_pk PRIMARY KEY (id_space);


--
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id_ticket);


--
-- Name: transactions_types transaction_type_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.transactions_types
    ADD CONSTRAINT transaction_type_pk PRIMARY KEY (id_transaction_type);


--
-- Name: transactions transactions_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pk PRIMARY KEY (id_transaction);


--
-- Name: types_products types_products_pk; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.types_products
    ADD CONSTRAINT types_products_pk PRIMARY KEY (id_type_product);


--
-- Name: users usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- Name: events events_spaces_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_spaces_fk FOREIGN KEY (id_space) REFERENCES public.spaces(id_space);


--
-- Name: events_tickets events_tickets_events_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events_tickets
    ADD CONSTRAINT events_tickets_events_fk FOREIGN KEY (id_event) REFERENCES public.events(id_event);


--
-- Name: events_tickets events_tickets_tickets_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.events_tickets
    ADD CONSTRAINT events_tickets_tickets_fk FOREIGN KEY (id_ticket) REFERENCES public.tickets(id_ticket);


--
-- Name: products products_providers_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_providers_fk FOREIGN KEY (id_provider) REFERENCES public.providers(id_provider);


--
-- Name: products products_types_products_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_types_products_fk FOREIGN KEY (id_type_product) REFERENCES public.types_products(id_type_product);


--
-- Name: spaces spaces_countries_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.spaces
    ADD CONSTRAINT spaces_countries_fk FOREIGN KEY (id_country) REFERENCES public.countries(id_country);


--
-- Name: tickets tickets_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_users_fk FOREIGN KEY (id_participant) REFERENCES public.users(id_usuario);


--
-- Name: transactions transactions_transactions_types_fk; Type: FK CONSTRAINT; Schema: public; Owner: festiva
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_transactions_types_fk FOREIGN KEY (id_transaction_type) REFERENCES public.transactions_types(id_transaction_type);


--
-- PostgreSQL database dump complete
--

