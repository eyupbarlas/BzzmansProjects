--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: testdb1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE testdb1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Turkish_Turkey.1254';


ALTER DATABASE testdb1 OWNER TO postgres;

\connect testdb1

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
-- Name: getfood1(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getfood1(categoryid integer) RETURNS TABLE(food_name character varying, cat_id integer, cat_name character varying)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY
        SELECT "foods"."FoodName", "foods"."FoodCategoryId", "categories"."CategoryName" FROM public.foods
        INNER JOIN public.categories ON "foods"."FoodCategoryId" = "categories"."Id"
        WHERE "foods"."FoodCategoryId" = categoryId;
END;
$$;


ALTER FUNCTION public.getfood1(categoryid integer) OWNER TO postgres;

--
-- Name: getfood2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getfood2() RETURNS TABLE(food_name character varying, cat_id integer, cat_name character varying)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY
        SELECT "foods"."FoodName", "foods"."FoodCategoryId", "categories"."CategoryName" FROM public.foods
        INNER JOIN public.categories ON "foods"."FoodCategoryId" = "categories"."Id"
        ;
END;
$$;


ALTER FUNCTION public.getfood2() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accessibility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accessibility (
    "Id" integer NOT NULL,
    "isRare" boolean,
    "WhereToBuy" character varying(100) NOT NULL
);


ALTER TABLE public.accessibility OWNER TO postgres;

--
-- Name: accessibility_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."accessibility_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."accessibility_Id_seq" OWNER TO postgres;

--
-- Name: accessibility_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."accessibility_Id_seq" OWNED BY public.accessibility."Id";


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    "Id" integer NOT NULL,
    "CategoryName" character varying(40) NOT NULL,
    "Description" text NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."categories_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."categories_Id_seq" OWNER TO postgres;

--
-- Name: categories_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."categories_Id_seq" OWNED BY public.categories."Id";


--
-- Name: cookplace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cookplace (
    "Id" integer NOT NULL,
    "PlaceName" character varying(40) NOT NULL
);


ALTER TABLE public.cookplace OWNER TO postgres;

--
-- Name: cookplace_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."cookplace_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."cookplace_Id_seq" OWNER TO postgres;

--
-- Name: cookplace_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."cookplace_Id_seq" OWNED BY public.cookplace."Id";


--
-- Name: cuisine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuisine (
    "Id" integer NOT NULL,
    "CuisineName" character varying(40) NOT NULL
);


ALTER TABLE public.cuisine OWNER TO postgres;

--
-- Name: cuisine_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."cuisine_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."cuisine_Id_seq" OWNER TO postgres;

--
-- Name: cuisine_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."cuisine_Id_seq" OWNED BY public.cuisine."Id";


--
-- Name: difflevel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.difflevel (
    "Id" integer NOT NULL,
    "LevelName" character varying(40) NOT NULL
);


ALTER TABLE public.difflevel OWNER TO postgres;

--
-- Name: difflevel_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."difflevel_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."difflevel_Id_seq" OWNER TO postgres;

--
-- Name: difflevel_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."difflevel_Id_seq" OWNED BY public.difflevel."Id";


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    "isFav" boolean NOT NULL,
    "FoodId" integer NOT NULL,
    "CreationDate" timestamp without time zone NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- Name: food_ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_ingredient (
    "FoodId" integer NOT NULL,
    "IngredientId" integer NOT NULL
);


ALTER TABLE public.food_ingredient OWNER TO postgres;

--
-- Name: food_tool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_tool (
    "FoodId" integer NOT NULL,
    "ToolId" integer NOT NULL
);


ALTER TABLE public.food_tool OWNER TO postgres;

--
-- Name: foods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foods (
    "Id" integer NOT NULL,
    "FoodName" character varying(40) NOT NULL,
    "FoodCategoryId" integer NOT NULL,
    "FoodTypeId" integer,
    "CuisineId" integer,
    "DifficultyId" integer,
    "Calories" character varying(40),
    "CookingTime" character varying(40),
    "CookingPlaceId" integer,
    "Yield" integer,
    "PriceId" integer,
    "isFavourite" boolean,
    "RatingId" integer,
    "Recipe" text NOT NULL,
    "CreationDate" timestamp without time zone NOT NULL
);


ALTER TABLE public.foods OWNER TO postgres;

--
-- Name: foods_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."foods_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."foods_Id_seq" OWNER TO postgres;

--
-- Name: foods_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."foods_Id_seq" OWNED BY public.foods."Id";


--
-- Name: foodtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foodtype (
    "Id" integer NOT NULL,
    "TypeName" character varying(40) NOT NULL,
    "Description" text
);


ALTER TABLE public.foodtype OWNER TO postgres;

--
-- Name: foodtype_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."foodtype_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."foodtype_Id_seq" OWNER TO postgres;

--
-- Name: foodtype_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."foodtype_Id_seq" OWNED BY public.foodtype."Id";


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients (
    "Id" integer NOT NULL,
    "IngredientName" character varying(100) NOT NULL,
    "Description" text,
    "AccessId" integer
);


ALTER TABLE public.ingredients OWNER TO postgres;

--
-- Name: ingredients_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ingredients_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ingredients_Id_seq" OWNER TO postgres;

--
-- Name: ingredients_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ingredients_Id_seq" OWNED BY public.ingredients."Id";


--
-- Name: kitchentools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitchentools (
    "Id" integer NOT NULL,
    "ToolName" character varying NOT NULL,
    "AccessId" integer
);


ALTER TABLE public.kitchentools OWNER TO postgres;

--
-- Name: kitchentools_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."kitchentools_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."kitchentools_Id_seq" OWNER TO postgres;

--
-- Name: kitchentools_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."kitchentools_Id_seq" OWNED BY public.kitchentools."Id";


--
-- Name: price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price (
    "Id" integer NOT NULL,
    "PriceRange" character varying(40) NOT NULL
);


ALTER TABLE public.price OWNER TO postgres;

--
-- Name: price_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."price_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."price_Id_seq" OWNER TO postgres;

--
-- Name: price_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."price_Id_seq" OWNED BY public.price."Id";


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    "Id" integer NOT NULL,
    "RatingScore" integer NOT NULL
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- Name: ratings_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ratings_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ratings_Id_seq" OWNER TO postgres;

--
-- Name: ratings_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ratings_Id_seq" OWNED BY public.ratings."Id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    "Id" integer NOT NULL,
    "Firstname" character varying(40) NOT NULL,
    "Lastname" character varying(40) NOT NULL,
    "Nickname" character varying(40) NOT NULL,
    "Email" character varying(120) NOT NULL,
    "Password" character varying(40) NOT NULL,
    "CreationDate" timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."users_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users_Id_seq" OWNER TO postgres;

--
-- Name: users_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."users_Id_seq" OWNED BY public.users."Id";


--
-- Name: accessibility Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessibility ALTER COLUMN "Id" SET DEFAULT nextval('public."accessibility_Id_seq"'::regclass);


--
-- Name: categories Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN "Id" SET DEFAULT nextval('public."categories_Id_seq"'::regclass);


--
-- Name: cookplace Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cookplace ALTER COLUMN "Id" SET DEFAULT nextval('public."cookplace_Id_seq"'::regclass);


--
-- Name: cuisine Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuisine ALTER COLUMN "Id" SET DEFAULT nextval('public."cuisine_Id_seq"'::regclass);


--
-- Name: difflevel Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difflevel ALTER COLUMN "Id" SET DEFAULT nextval('public."difflevel_Id_seq"'::regclass);


--
-- Name: foods Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods ALTER COLUMN "Id" SET DEFAULT nextval('public."foods_Id_seq"'::regclass);


--
-- Name: foodtype Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodtype ALTER COLUMN "Id" SET DEFAULT nextval('public."foodtype_Id_seq"'::regclass);


--
-- Name: ingredients Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN "Id" SET DEFAULT nextval('public."ingredients_Id_seq"'::regclass);


--
-- Name: kitchentools Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitchentools ALTER COLUMN "Id" SET DEFAULT nextval('public."kitchentools_Id_seq"'::regclass);


--
-- Name: price Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price ALTER COLUMN "Id" SET DEFAULT nextval('public."price_Id_seq"'::regclass);


--
-- Name: ratings Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN "Id" SET DEFAULT nextval('public."ratings_Id_seq"'::regclass);


--
-- Name: users Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN "Id" SET DEFAULT nextval('public."users_Id_seq"'::regclass);


--
-- Data for Name: accessibility; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.accessibility ("Id", "isRare", "WhereToBuy") VALUES (1, false, 'Grocery Store');
INSERT INTO public.accessibility ("Id", "isRare", "WhereToBuy") VALUES (2, false, 'Migros');
INSERT INTO public.accessibility ("Id", "isRare", "WhereToBuy") VALUES (3, true, 'Macro Center');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories ("Id", "CategoryName", "Description") VALUES (1, 'Appetizers', 'The first course of the meal. Small portions of food, served either hot or cold.');
INSERT INTO public.categories ("Id", "CategoryName", "Description") VALUES (2, 'Main Course', 'The main part of the meal. Medium to large portions of food, served either hot or cold');
INSERT INTO public.categories ("Id", "CategoryName", "Description") VALUES (3, 'Side Dish', 'A small portion of food. Typically bread, salad or vegetables in sauce, that you eat with a main meal.');
INSERT INTO public.categories ("Id", "CategoryName", "Description") VALUES (4, 'Dessert', 'The last course of a meal. Typically a sweet dish, such as cake, pudding or ice-cream. Alternatively, a savoury dish like cheeze and biscuits may be offered as the final course, instead.');


--
-- Data for Name: cookplace; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cookplace ("Id", "PlaceName") VALUES (1, 'Oven');
INSERT INTO public.cookplace ("Id", "PlaceName") VALUES (2, 'Grill');
INSERT INTO public.cookplace ("Id", "PlaceName") VALUES (3, 'Microwave');
INSERT INTO public.cookplace ("Id", "PlaceName") VALUES (4, 'Pan');
INSERT INTO public.cookplace ("Id", "PlaceName") VALUES (5, 'Cooker');


--
-- Data for Name: cuisine; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (1, 'Turkish');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (2, 'American');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (3, 'Far-eastern');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (4, 'Middle-eastern');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (5, 'British');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (6, 'European');
INSERT INTO public.cuisine ("Id", "CuisineName") VALUES (7, 'Scandinavian');


--
-- Data for Name: difflevel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.difflevel ("Id", "LevelName") VALUES (1, 'Beginner');
INSERT INTO public.difflevel ("Id", "LevelName") VALUES (2, 'Amateur');
INSERT INTO public.difflevel ("Id", "LevelName") VALUES (3, 'Mid-level');
INSERT INTO public.difflevel ("Id", "LevelName") VALUES (4, 'Hard');
INSERT INTO public.difflevel ("Id", "LevelName") VALUES (5, 'Masterchef');


--
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.favourites ("isFav", "FoodId", "CreationDate") VALUES (true, 1, '2020-01-10 00:00:00');


--
-- Data for Name: food_ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.food_ingredient ("FoodId", "IngredientId") VALUES (1, 1);
INSERT INTO public.food_ingredient ("FoodId", "IngredientId") VALUES (2, 2);


--
-- Data for Name: food_tool; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.food_tool ("FoodId", "ToolId") VALUES (3, 3);


--
-- Data for Name: foods; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.foods ("Id", "FoodName", "FoodCategoryId", "FoodTypeId", "CuisineId", "DifficultyId", "Calories", "CookingTime", "CookingPlaceId", "Yield", "PriceId", "isFavourite", "RatingId", "Recipe", "CreationDate") VALUES (1, 'Food1', 1, NULL, 1, 1, '100kcal', NULL, NULL, 1, 1, NULL, 1, 'recipe', '2020-01-10 00:00:00');
INSERT INTO public.foods ("Id", "FoodName", "FoodCategoryId", "FoodTypeId", "CuisineId", "DifficultyId", "Calories", "CookingTime", "CookingPlaceId", "Yield", "PriceId", "isFavourite", "RatingId", "Recipe", "CreationDate") VALUES (2, 'Food2', 2, 2, 2, 2, '200 kcal', '30', 2, 2, 2, true, 1, 'Recipe2', '2020-01-10 00:00:00');
INSERT INTO public.foods ("Id", "FoodName", "FoodCategoryId", "FoodTypeId", "CuisineId", "DifficultyId", "Calories", "CookingTime", "CookingPlaceId", "Yield", "PriceId", "isFavourite", "RatingId", "Recipe", "CreationDate") VALUES (3, 'Food3', 3, 3, 3, 3, '300 kcal', '30', 3, 3, 3, true, 3, 'Recipe3', '2020-03-10 00:00:00');


--
-- Data for Name: foodtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.foodtype ("Id", "TypeName", "Description") VALUES (1, 'Animal based', 'This type contains animal fats or meat. Not advisable for vegeterians');
INSERT INTO public.foodtype ("Id", "TypeName", "Description") VALUES (2, 'Vegeterian', 'This is a vegeterian food.');
INSERT INTO public.foodtype ("Id", "TypeName", "Description") VALUES (3, 'Vegan', 'This is a vegan food.');


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredients ("Id", "IngredientName", "Description", "AccessId") VALUES (1, 'Blabla1', 'Blablabla1', 1);
INSERT INTO public.ingredients ("Id", "IngredientName", "Description", "AccessId") VALUES (2, 'blabla2', 'blablabla2', 2);


--
-- Data for Name: kitchentools; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (1, 'Spoon', 1);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (2, 'Fork', 2);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (3, 'Spatula', 2);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (4, 'Knife', 2);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (5, 'Ladle', 2);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (6, 'Whisk', 2);
INSERT INTO public.kitchentools ("Id", "ToolName", "AccessId") VALUES (7, 'Chopsticks', 3);


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.price ("Id", "PriceRange") VALUES (1, '10');
INSERT INTO public.price ("Id", "PriceRange") VALUES (2, '30');
INSERT INTO public.price ("Id", "PriceRange") VALUES (3, '50');
INSERT INTO public.price ("Id", "PriceRange") VALUES (4, '70');
INSERT INTO public.price ("Id", "PriceRange") VALUES (5, '100');


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ratings ("Id", "RatingScore") VALUES (2, 2);
INSERT INTO public.ratings ("Id", "RatingScore") VALUES (3, 3);
INSERT INTO public.ratings ("Id", "RatingScore") VALUES (4, 4);
INSERT INTO public.ratings ("Id", "RatingScore") VALUES (5, 5);
INSERT INTO public.ratings ("Id", "RatingScore") VALUES (1, 1);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (1, 'Bzzman', 'Bzzky', 'Bzzman', 'bzzbzz@gmail.com', '1234', '2020-12-12 13:22:58.725232');
INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (2, 'Zeliha', 'Barlas', 'zeliş', 'zeliş@gmail.com', '1111', '2020-12-12 13:32:50.190292');
INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (3, 'kaan', 'yüksel', 'lieston', 'blabla@gmail.com', '4444', '2020-12-13 10:33:46.929897');
INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (4, 'ali', 'barlas', 'aliş', 'alibarlas@gmail.com', '5555', '2020-12-13 10:49:13.818213');
INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (5, 'Engin', 'Özcan', 'Engo', 'engo@gmail.com', '6666', '2020-12-13 11:12:48.147003');
INSERT INTO public.users ("Id", "Firstname", "Lastname", "Nickname", "Email", "Password", "CreationDate") VALUES (6, 'Eyüp11', 'Barlas11', 'Bzzman11', '11@gmail.com', '111111', '2020-12-30 00:11:18.565772');


--
-- Name: accessibility_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."accessibility_Id_seq"', 1, false);


--
-- Name: categories_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."categories_Id_seq"', 1, false);


--
-- Name: cookplace_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."cookplace_Id_seq"', 1, false);


--
-- Name: cuisine_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."cuisine_Id_seq"', 1, false);


--
-- Name: difflevel_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."difflevel_Id_seq"', 1, false);


--
-- Name: foods_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."foods_Id_seq"', 1, false);


--
-- Name: foodtype_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."foodtype_Id_seq"', 1, false);


--
-- Name: ingredients_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ingredients_Id_seq"', 1, false);


--
-- Name: kitchentools_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."kitchentools_Id_seq"', 1, false);


--
-- Name: price_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."price_Id_seq"', 1, false);


--
-- Name: ratings_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ratings_Id_seq"', 1, false);


--
-- Name: users_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."users_Id_seq"', 6, true);


--
-- Name: accessibility accessibility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessibility
    ADD CONSTRAINT accessibility_pkey PRIMARY KEY ("Id");


--
-- Name: categories categories_CategoryName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "categories_CategoryName_key" UNIQUE ("CategoryName");


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY ("Id");


--
-- Name: cookplace cookplace_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cookplace
    ADD CONSTRAINT cookplace_pkey PRIMARY KEY ("Id");


--
-- Name: cuisine cuisine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuisine
    ADD CONSTRAINT cuisine_pkey PRIMARY KEY ("Id");


--
-- Name: difflevel difflevel_LevelName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difflevel
    ADD CONSTRAINT "difflevel_LevelName_key" UNIQUE ("LevelName");


--
-- Name: difflevel difflevel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difflevel
    ADD CONSTRAINT difflevel_pkey PRIMARY KEY ("Id");


--
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY ("isFav");


--
-- Name: food_ingredient food_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_ingredient
    ADD CONSTRAINT food_ingredient_pkey PRIMARY KEY ("FoodId", "IngredientId");


--
-- Name: food_tool food_tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_tool
    ADD CONSTRAINT food_tool_pkey PRIMARY KEY ("FoodId", "ToolId");


--
-- Name: foods foods_FoodName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_FoodName_key" UNIQUE ("FoodName");


--
-- Name: foods foods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT foods_pkey PRIMARY KEY ("Id");


--
-- Name: foodtype foodtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foodtype
    ADD CONSTRAINT foodtype_pkey PRIMARY KEY ("Id");


--
-- Name: ingredients ingredients_IngredientName_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT "ingredients_IngredientName_key" UNIQUE ("IngredientName");


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY ("Id");


--
-- Name: kitchentools kitchentools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitchentools
    ADD CONSTRAINT kitchentools_pkey PRIMARY KEY ("Id");


--
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY ("Id");


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY ("Id");


--
-- Name: users users_Email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_Email_key" UNIQUE ("Email");


--
-- Name: users users_Nickname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_Nickname_key" UNIQUE ("Nickname");


--
-- Name: users users_Password_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_Password_key" UNIQUE ("Password");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("Id");


--
-- Name: favourites favourites_FoodId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT "favourites_FoodId_fkey" FOREIGN KEY ("FoodId") REFERENCES public.foods("Id");


--
-- Name: food_ingredient food_ingredient_FoodId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_ingredient
    ADD CONSTRAINT "food_ingredient_FoodId_fkey" FOREIGN KEY ("FoodId") REFERENCES public.foods("Id");


--
-- Name: food_ingredient food_ingredient_IngredientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_ingredient
    ADD CONSTRAINT "food_ingredient_IngredientId_fkey" FOREIGN KEY ("IngredientId") REFERENCES public.ingredients("Id");


--
-- Name: food_tool food_tool_FoodId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_tool
    ADD CONSTRAINT "food_tool_FoodId_fkey" FOREIGN KEY ("FoodId") REFERENCES public.foods("Id");


--
-- Name: food_tool food_tool_ToolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_tool
    ADD CONSTRAINT "food_tool_ToolId_fkey" FOREIGN KEY ("ToolId") REFERENCES public.kitchentools("Id");


--
-- Name: foods foods_CookingPlaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_CookingPlaceId_fkey" FOREIGN KEY ("CookingPlaceId") REFERENCES public.cookplace("Id");


--
-- Name: foods foods_CuisineId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_CuisineId_fkey" FOREIGN KEY ("CuisineId") REFERENCES public.cuisine("Id");


--
-- Name: foods foods_DifficultyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_DifficultyId_fkey" FOREIGN KEY ("DifficultyId") REFERENCES public.difflevel("Id");


--
-- Name: foods foods_FoodCategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_FoodCategoryId_fkey" FOREIGN KEY ("FoodCategoryId") REFERENCES public.categories("Id");


--
-- Name: foods foods_FoodTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_FoodTypeId_fkey" FOREIGN KEY ("FoodTypeId") REFERENCES public.foodtype("Id");


--
-- Name: foods foods_PriceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_PriceId_fkey" FOREIGN KEY ("PriceId") REFERENCES public.price("Id");


--
-- Name: foods foods_RatingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_RatingId_fkey" FOREIGN KEY ("RatingId") REFERENCES public.ratings("Id");


--
-- Name: foods foods_isFavourite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foods
    ADD CONSTRAINT "foods_isFavourite_fkey" FOREIGN KEY ("isFavourite") REFERENCES public.favourites("isFav");


--
-- Name: ingredients ingredients_AccessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT "ingredients_AccessId_fkey" FOREIGN KEY ("AccessId") REFERENCES public.accessibility("Id");


--
-- Name: kitchentools kitchentools_AccessId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitchentools
    ADD CONSTRAINT "kitchentools_AccessId_fkey" FOREIGN KEY ("AccessId") REFERENCES public.accessibility("Id");


--
-- PostgreSQL database dump complete
--

