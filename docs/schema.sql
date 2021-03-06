--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

-- Started on 2018-06-29 18:47:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 619 (class 1247 OID 16473)
-- Name: board_parent_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.board_parent_type AS ENUM (
    'group',
    'board'
);


ALTER TYPE public.board_parent_type OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16527)
-- Name: board_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: quorum_user
--

CREATE SEQUENCE public.board_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.board_groups_id_seq OWNER TO quorum_user;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 202 (class 1259 OID 16477)
-- Name: board_groups; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.board_groups (
    id bigint DEFAULT nextval('public.board_groups_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    parent bigint DEFAULT '-1'::integer
);


ALTER TABLE public.board_groups OWNER TO quorum_user;

--
-- TOC entry 205 (class 1259 OID 16525)
-- Name: boards_id_seq; Type: SEQUENCE; Schema: public; Owner: quorum_user
--

CREATE SEQUENCE public.boards_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boards_id_seq OWNER TO quorum_user;

--
-- TOC entry 201 (class 1259 OID 16464)
-- Name: boards; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.boards (
    id bigint DEFAULT nextval('public.boards_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(1000) NOT NULL,
    parent_type public.board_parent_type NOT NULL,
    parent bigint NOT NULL,
    alias character varying
);


ALTER TABLE public.boards OWNER TO quorum_user;

--
-- TOC entry 196 (class 1259 OID 16396)
-- Name: logins; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.logins (
    username character varying(50) NOT NULL,
    password character varying(200) NOT NULL,
    email character varying(200)
);


ALTER TABLE public.logins OWNER TO quorum_user;

--
-- TOC entry 207 (class 1259 OID 16529)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: quorum_user
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO quorum_user;

--
-- TOC entry 198 (class 1259 OID 16436)
-- Name: posts; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.posts (
    id bigint DEFAULT nextval('public.posts_id_seq'::regclass) NOT NULL,
    author bigint NOT NULL,
    thread bigint NOT NULL,
    content character varying NOT NULL,
    content_type character varying NOT NULL,
    created date NOT NULL,
    board bigint NOT NULL,
    rendered_content character varying NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE public.posts OWNER TO quorum_user;

--
-- TOC entry 197 (class 1259 OID 16401)
-- Name: sessions; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.sessions (
    id character varying(128) NOT NULL,
    created date NOT NULL,
    expires date,
    uid bigint NOT NULL
);


ALTER TABLE public.sessions OWNER TO quorum_user;

--
-- TOC entry 208 (class 1259 OID 16531)
-- Name: threads_id_seq; Type: SEQUENCE; Schema: public; Owner: quorum_user
--

CREATE SEQUENCE public.threads_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.threads_id_seq OWNER TO quorum_user;

--
-- TOC entry 203 (class 1259 OID 16485)
-- Name: threads; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.threads (
    id bigint DEFAULT nextval('public.threads_id_seq'::regclass) NOT NULL,
    board bigint NOT NULL,
    opening_post bigint,
    last_post bigint NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE public.threads OWNER TO quorum_user;

--
-- TOC entry 199 (class 1259 OID 16446)
-- Name: user_map; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.user_map (
    method character varying NOT NULL,
    identifier character varying NOT NULL,
    uid bigint NOT NULL
);


ALTER TABLE public.user_map OWNER TO quorum_user;

--
-- TOC entry 200 (class 1259 OID 16452)
-- Name: users; Type: TABLE; Schema: public; Owner: quorum_user
--

CREATE TABLE public.users (
    uid bigint NOT NULL,
    username character varying(50) NOT NULL,
    bio character varying(500)
);


ALTER TABLE public.users OWNER TO quorum_user;

--
-- TOC entry 204 (class 1259 OID 16515)
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: quorum_user
--

CREATE SEQUENCE public.users_uid_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_uid_seq OWNER TO quorum_user;

--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quorum_user
--

ALTER SEQUENCE public.users_uid_seq OWNED BY public.users.uid;


--
-- TOC entry 2717 (class 2604 OID 16517)
-- Name: users uid; Type: DEFAULT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.users ALTER COLUMN uid SET DEFAULT nextval('public.users_uid_seq'::regclass);


--
-- TOC entry 2734 (class 2606 OID 16484)
-- Name: board_groups board_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.board_groups
    ADD CONSTRAINT board_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2732 (class 2606 OID 16471)
-- Name: boards boards_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (id);


--
-- TOC entry 2727 (class 2606 OID 16443)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 2723 (class 2606 OID 16408)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 2739 (class 2606 OID 16489)
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- TOC entry 2730 (class 2606 OID 16459)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- TOC entry 2724 (class 1259 OID 16445)
-- Name: board; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX board ON public.posts USING btree (board);


--
-- TOC entry 2725 (class 1259 OID 16512)
-- Name: fki_author_fkey_constraint; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX fki_author_fkey_constraint ON public.posts USING btree (author);


--
-- TOC entry 2735 (class 1259 OID 16501)
-- Name: fki_board_fkey_constraint; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX fki_board_fkey_constraint ON public.threads USING btree (board);


--
-- TOC entry 2736 (class 1259 OID 16523)
-- Name: fki_last_post_fkey_constraint; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX fki_last_post_fkey_constraint ON public.threads USING btree (last_post);


--
-- TOC entry 2737 (class 1259 OID 16495)
-- Name: fki_po; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX fki_po ON public.threads USING btree (opening_post);


--
-- TOC entry 2728 (class 1259 OID 16444)
-- Name: thread; Type: INDEX; Schema: public; Owner: quorum_user
--

CREATE INDEX thread ON public.posts USING btree (thread);


--
-- TOC entry 2741 (class 2606 OID 16507)
-- Name: posts author_fkey_constraint; Type: FK CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT author_fkey_constraint FOREIGN KEY (author) REFERENCES public.users(uid);


--
-- TOC entry 2743 (class 2606 OID 16496)
-- Name: threads board_fkey_constraint; Type: FK CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT board_fkey_constraint FOREIGN KEY (board) REFERENCES public.boards(id);


--
-- TOC entry 2740 (class 2606 OID 16502)
-- Name: posts board_fkey_constraint; Type: FK CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT board_fkey_constraint FOREIGN KEY (board) REFERENCES public.boards(id);


--
-- TOC entry 2744 (class 2606 OID 16518)
-- Name: threads last_post_fkey_constraint; Type: FK CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT last_post_fkey_constraint FOREIGN KEY (last_post) REFERENCES public.posts(id);


--
-- TOC entry 2742 (class 2606 OID 16490)
-- Name: threads op_fkey_constraint; Type: FK CONSTRAINT; Schema: public; Owner: quorum_user
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT op_fkey_constraint FOREIGN KEY (opening_post) REFERENCES public.posts(id);


-- Completed on 2018-06-29 18:47:13

--
-- PostgreSQL database dump complete
--

