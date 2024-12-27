--
-- PostgreSQL database dump
--

-- Dumped from database version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.20 (Ubuntu 12.20-0ubuntu0.20.04.1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (22, 'aristo', 3, 2);
INSERT INTO public.users VALUES (24, 'user_1735341918436', 3, 17);
INSERT INTO public.users VALUES (40, 'user_1735342204143', 2, 29);
INSERT INTO public.users VALUES (23, 'user_1735341918437', 6, 9);
INSERT INTO public.users VALUES (39, 'user_1735342204144', 5, 25);
INSERT INTO public.users VALUES (26, 'user_1735341966847', 2, 12);
INSERT INTO public.users VALUES (25, 'user_1735341966848', 5, 9);
INSERT INTO public.users VALUES (28, 'user_1735341989954', 2, 94);
INSERT INTO public.users VALUES (27, 'user_1735341989955', 5, 4);
INSERT INTO public.users VALUES (30, 'user_1735342022659', 2, 96);
INSERT INTO public.users VALUES (29, 'user_1735342022660', 5, 19);
INSERT INTO public.users VALUES (32, 'user_1735342084363', 2, 3);
INSERT INTO public.users VALUES (31, 'user_1735342084364', 5, 8);
INSERT INTO public.users VALUES (34, 'user_1735342110904', 2, 44);
INSERT INTO public.users VALUES (33, 'user_1735342110905', 5, 9);
INSERT INTO public.users VALUES (36, 'user_1735342124523', 2, 100);
INSERT INTO public.users VALUES (35, 'user_1735342124524', 5, 24);
INSERT INTO public.users VALUES (38, 'user_1735342139477', 2, 77);
INSERT INTO public.users VALUES (37, 'user_1735342139478', 5, 18);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 40, true);


--
-- PostgreSQL database dump complete
--

