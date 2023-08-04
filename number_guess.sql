--

-- PostgreSQL database dump

--

  

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

  

SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = on;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = off;

  

DROP DATABASE number_guess;

--

-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp

--

  

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

  
  

ALTER DATABASE number_guess OWNER TO freecodecamp;

  

\connect number_guess

  

SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = on;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = off;

  

SET default_tablespace = '';

  

SET default_table_access_method = heap;

  

--

-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp

--

  

CREATE TABLE public.games (

    game_id integer NOT NULL,

    guesses integer DEFAULT 0 NOT NULL,

    user_id integer NOT NULL

);

  
  

ALTER TABLE public.games OWNER TO freecodecamp;

  

--

-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp

--

  

CREATE SEQUENCE public.games_game_id_seq

    AS integer

    START WITH 1

    INCREMENT BY 1

    NO MINVALUE

    NO MAXVALUE

    CACHE 1;

  
  

ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

  

--

-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp

--

  

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;

  
  

--

-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp

--

  

CREATE TABLE public.players (

    user_id integer NOT NULL,

    username character varying(22) NOT NULL,

    games_played integer DEFAULT 0 NOT NULL

);

  
  

ALTER TABLE public.players OWNER TO freecodecamp;

  

--

-- Name: players_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp

--

  

CREATE SEQUENCE public.players_user_id_seq

    AS integer

    START WITH 1

    INCREMENT BY 1

    NO MINVALUE

    NO MAXVALUE

    CACHE 1;

  
  

ALTER TABLE public.players_user_id_seq OWNER TO freecodecamp;

  

--

-- Name: players_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp

--

  

ALTER SEQUENCE public.players_user_id_seq OWNED BY public.players.user_id;

  
  

--

-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp

--

  

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);

  
  

--

-- Name: players user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp

--

  

ALTER TABLE ONLY public.players ALTER COLUMN user_id SET DEFAULT nextval('public.players_user_id_seq'::regclass);

  
  

--

-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp

--

  

INSERT INTO public.games VALUES (32, 1, 29);

INSERT INTO public.games VALUES (33, 1, 29);

INSERT INTO public.games VALUES (34, 1, 29);

INSERT INTO public.games VALUES (35, 1, 29);

INSERT INTO public.games VALUES (36, 1, 29);

INSERT INTO public.games VALUES (37, 1, 32);

INSERT INTO public.games VALUES (38, 1, 32);

INSERT INTO public.games VALUES (39, 1, 33);

INSERT INTO public.games VALUES (40, 1, 33);

INSERT INTO public.games VALUES (41, 1, 32);

INSERT INTO public.games VALUES (42, 1, 32);

INSERT INTO public.games VALUES (43, 1, 32);

INSERT INTO public.games VALUES (44, 1, 34);

INSERT INTO public.games VALUES (45, 1, 34);

INSERT INTO public.games VALUES (46, 1, 35);

INSERT INTO public.games VALUES (47, 1, 35);

INSERT INTO public.games VALUES (48, 1, 34);

INSERT INTO public.games VALUES (49, 1, 34);

INSERT INTO public.games VALUES (50, 1, 34);

INSERT INTO public.games VALUES (51, 1, 36);

INSERT INTO public.games VALUES (52, 1, 36);

INSERT INTO public.games VALUES (53, 1, 37);

INSERT INTO public.games VALUES (54, 1, 37);

INSERT INTO public.games VALUES (55, 1, 36);

INSERT INTO public.games VALUES (56, 1, 36);

INSERT INTO public.games VALUES (57, 1, 36);

INSERT INTO public.games VALUES (58, 602, 38);

INSERT INTO public.games VALUES (59, 924, 38);

INSERT INTO public.games VALUES (60, 668, 39);

INSERT INTO public.games VALUES (61, 487, 39);

INSERT INTO public.games VALUES (62, 1, 38);

INSERT INTO public.games VALUES (63, 899, 38);

INSERT INTO public.games VALUES (64, 138, 38);

  
  

--

-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp

--

  

INSERT INTO public.players VALUES (30, 'user_1691054641807', 0);

INSERT INTO public.players VALUES (31, 'user_1691054641807', 0);

INSERT INTO public.players VALUES (29, 'user_1691054641808', 5);

INSERT INTO public.players VALUES (33, 'user_1691055201809', 2);

INSERT INTO public.players VALUES (32, 'user_1691055201810', 5);

INSERT INTO public.players VALUES (35, 'user_1691057101807', 2);

INSERT INTO public.players VALUES (34, 'user_1691057101808', 5);

INSERT INTO public.players VALUES (37, 'user_1691057435705', 2);

INSERT INTO public.players VALUES (36, 'user_1691057435706', 5);

INSERT INTO public.players VALUES (39, 'user_1691057881307', 2);

INSERT INTO public.players VALUES (38, 'user_1691057881308', 5);

  
  

--

-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp

--

  

SELECT pg_catalog.setval('public.games_game_id_seq', 64, true);

  
  

--

-- Name: players_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp

--

  

SELECT pg_catalog.setval('public.players_user_id_seq', 39, true);

  
  

--

-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp

--

  

ALTER TABLE ONLY public.games

    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);

  
  

--

-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp

--

  

ALTER TABLE ONLY public.players

    ADD CONSTRAINT players_pkey PRIMARY KEY (user_id);

  
  

--

-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp

--

  

ALTER TABLE ONLY public.games

    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.players(user_id);

  
  

--

-- PostgreSQL database dump complete

--
