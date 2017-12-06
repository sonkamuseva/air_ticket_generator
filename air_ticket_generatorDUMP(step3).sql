--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: aiports_planes_relation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE aiports_planes_relation (
    airport_id integer NOT NULL,
    plane_id integer NOT NULL
);


ALTER TABLE aiports_planes_relation OWNER TO postgres;

--
-- Name: airlines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE airlines (
    airline_id integer NOT NULL,
    airline_name character varying(255) NOT NULL,
    date_of_foundation date NOT NULL,
    headquaters character varying(255) NOT NULL,
    international boolean NOT NULL,
    fleet_size integer NOT NULL,
    number_of_destinations integer NOT NULL,
    website character varying(255) NOT NULL,
    CONSTRAINT airlines_fleet_size_check CHECK ((fleet_size > 0)),
    CONSTRAINT airlines_number_of_destinations_check CHECK ((number_of_destinations > 0))
);


ALTER TABLE airlines OWNER TO postgres;

--
-- Name: airlines_airline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE airlines_airline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE airlines_airline_id_seq OWNER TO postgres;

--
-- Name: airlines_airline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE airlines_airline_id_seq OWNED BY airlines.airline_id;


--
-- Name: airports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE airports (
    airport_id integer NOT NULL,
    airport_name character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    address character varying(255) NOT NULL,
    time_zone character varying(255) NOT NULL,
    international boolean NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE airports OWNER TO postgres;

--
-- Name: airports_airlines_relation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE airports_airlines_relation (
    airport_id integer NOT NULL,
    airline_id integer NOT NULL
);


ALTER TABLE airports_airlines_relation OWNER TO postgres;

--
-- Name: airports_airport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE airports_airport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE airports_airport_id_seq OWNER TO postgres;

--
-- Name: airports_airport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE airports_airport_id_seq OWNED BY airports.airport_id;


--
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE flights (
    flight_id integer NOT NULL,
    flight_number character varying(255) NOT NULL,
    date_of_flight date NOT NULL,
    airline_id integer NOT NULL,
    plane_id integer NOT NULL,
    time_of_departure time with time zone NOT NULL,
    time_of_arrival time with time zone NOT NULL,
    departure_airport_id integer NOT NULL,
    arrival_airport_id integer NOT NULL
);


ALTER TABLE flights OWNER TO postgres;

--
-- Name: flights_flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE flights_flight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE flights_flight_id_seq OWNER TO postgres;

--
-- Name: flights_flight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE flights_flight_id_seq OWNED BY flights.flight_id;


--
-- Name: planes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE planes (
    plane_id integer NOT NULL,
    model character varying(255) NOT NULL,
    count_of_places integer NOT NULL,
    national_origin character varying(255) NOT NULL,
    manufacturer character varying(255) NOT NULL,
    first_flight date NOT NULL,
    CONSTRAINT planes_count_of_places_check CHECK ((count_of_places > 0))
);


ALTER TABLE planes OWNER TO postgres;

--
-- Name: planes_airlines_relation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE planes_airlines_relation (
    airline_id integer NOT NULL,
    plane_id integer NOT NULL
);


ALTER TABLE planes_airlines_relation OWNER TO postgres;

--
-- Name: planes_plane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE planes_plane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE planes_plane_id_seq OWNER TO postgres;

--
-- Name: planes_plane_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE planes_plane_id_seq OWNED BY planes.plane_id;


--
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reservation (
    reservation_id integer NOT NULL,
    reservation_number integer NOT NULL,
    reservation_date date NOT NULL,
    customer character varying(255) NOT NULL,
    number_of_tickets integer NOT NULL,
    CONSTRAINT reservation_number_of_tickets_check CHECK ((number_of_tickets > 0)),
    CONSTRAINT reservation_reservation_number_check CHECK ((reservation_number > 99999999))
);


ALTER TABLE reservation OWNER TO postgres;

--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reservation_reservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservation_reservation_id_seq OWNER TO postgres;

--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reservation_reservation_id_seq OWNED BY reservation.reservation_id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tickets (
    ticket_id integer NOT NULL,
    ticket_number integer NOT NULL,
    passenger_name character varying(255) NOT NULL,
    seat_number character varying(255) NOT NULL,
    reservation_id integer NOT NULL,
    flight_id integer NOT NULL,
    possible_to_return boolean NOT NULL,
    CONSTRAINT tickets_ticket_number_check CHECK ((ticket_number > 99999))
);


ALTER TABLE tickets OWNER TO postgres;

--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tickets_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tickets_ticket_id_seq OWNER TO postgres;

--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tickets_ticket_id_seq OWNED BY tickets.ticket_id;


--
-- Name: airlines airline_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airlines ALTER COLUMN airline_id SET DEFAULT nextval('airlines_airline_id_seq'::regclass);


--
-- Name: airports airport_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports ALTER COLUMN airport_id SET DEFAULT nextval('airports_airport_id_seq'::regclass);


--
-- Name: flights flight_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights ALTER COLUMN flight_id SET DEFAULT nextval('flights_flight_id_seq'::regclass);


--
-- Name: planes plane_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes ALTER COLUMN plane_id SET DEFAULT nextval('planes_plane_id_seq'::regclass);


--
-- Name: reservation reservation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservation ALTER COLUMN reservation_id SET DEFAULT nextval('reservation_reservation_id_seq'::regclass);


--
-- Name: tickets ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets ALTER COLUMN ticket_id SET DEFAULT nextval('tickets_ticket_id_seq'::regclass);


--
-- Data for Name: aiports_planes_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aiports_planes_relation (airport_id, plane_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
1	7
1	8
1	9
1	10
1	11
1	12
1	13
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	26
1	27
1	28
1	29
1	30
1	31
1	32
1	33
1	34
1	35
1	36
1	37
1	38
2	1
2	2
2	3
2	4
2	5
2	6
2	7
2	8
2	9
2	10
2	11
2	12
2	13
2	14
2	15
2	16
2	17
2	18
2	19
2	20
2	21
2	22
2	23
2	24
2	25
2	26
2	27
2	28
2	29
2	30
2	31
2	32
2	33
2	34
2	35
2	36
2	37
2	38
3	1
3	2
3	3
3	4
3	5
3	6
3	7
3	8
3	9
3	10
3	11
3	12
3	13
3	14
3	15
3	16
3	17
3	18
3	19
3	20
3	21
3	22
3	23
3	24
3	25
3	26
3	27
3	28
3	29
3	30
3	31
3	32
3	33
3	34
3	35
3	36
3	37
3	38
4	1
4	2
4	3
4	4
4	5
4	6
4	7
4	8
4	9
4	10
4	11
4	12
4	13
4	14
4	15
4	16
4	17
4	18
4	19
4	20
4	21
4	22
4	23
4	24
4	25
4	26
4	27
4	28
4	29
4	30
4	31
4	32
4	33
4	34
4	35
4	36
4	37
4	38
5	1
5	2
5	3
5	4
5	5
5	6
5	7
5	8
5	9
5	10
5	11
5	12
5	13
5	14
5	15
5	16
5	17
5	18
5	19
5	20
5	21
5	22
5	23
5	24
5	25
5	26
5	27
5	28
5	29
5	30
5	31
5	32
5	33
5	34
5	35
5	36
5	37
5	38
6	1
6	2
6	3
6	4
6	5
6	6
6	7
6	8
6	9
6	10
6	11
6	12
6	13
6	14
6	15
6	16
6	17
6	18
6	19
6	20
6	21
6	22
6	23
6	24
6	25
6	26
6	27
6	28
6	29
6	30
6	31
6	32
6	33
6	34
6	35
6	36
6	37
6	38
7	1
7	2
7	3
7	4
7	5
7	6
7	7
7	8
7	9
7	10
7	11
7	12
7	13
7	14
7	15
7	16
7	17
7	18
7	19
7	20
7	21
7	22
7	23
7	24
7	25
7	26
7	27
7	28
7	29
7	30
7	31
7	32
7	33
7	34
7	35
7	36
7	37
7	38
8	1
8	2
8	3
8	4
8	6
8	8
8	10
8	11
8	12
8	13
8	14
8	15
8	16
8	17
8	18
8	19
8	21
8	22
8	23
8	28
8	32
8	33
8	34
9	1
9	2
9	3
9	4
9	5
9	6
9	7
9	8
9	9
9	10
9	11
9	12
9	13
9	14
9	15
9	16
9	17
9	18
9	19
9	20
9	21
9	22
9	23
9	24
9	25
9	26
9	27
9	28
9	29
9	30
9	31
9	32
9	33
9	34
9	35
9	36
9	37
9	38
10	1
10	2
10	3
10	4
10	6
10	8
10	9
10	10
10	11
10	12
10	13
10	14
10	15
10	16
10	17
10	18
10	21
10	22
10	28
10	32
10	33
10	34
11	1
11	2
11	3
11	4
11	5
11	6
11	7
11	8
11	9
11	10
11	11
11	12
11	13
11	14
11	15
11	16
11	17
11	18
11	19
11	20
11	21
11	22
11	23
11	24
11	25
11	26
11	27
11	28
11	29
11	30
11	31
11	32
11	33
11	34
11	35
11	36
11	37
11	38
12	1
12	2
12	6
12	7
12	8
12	10
12	11
12	12
12	13
12	14
12	17
12	18
12	19
12	20
12	21
12	22
12	23
12	24
12	25
12	26
12	28
12	29
12	32
12	33
12	34
13	1
13	2
13	6
13	8
13	11
13	12
13	13
13	14
13	21
13	22
13	26
13	29
13	32
13	33
13	34
14	1
14	2
14	3
14	4
14	6
14	8
14	10
14	11
14	12
14	13
14	14
14	17
14	18
14	21
14	22
14	24
14	26
14	28
14	29
14	32
14	33
14	34
15	1
15	2
15	6
15	7
15	8
15	11
15	12
15	13
15	14
15	15
15	16
15	17
15	18
15	19
15	20
15	21
15	22
15	24
15	25
15	28
15	29
16	1
16	2
16	6
16	12
16	13
16	21
16	22
16	24
16	26
16	29
16	32
16	33
16	34
17	1
17	2
17	6
17	11
17	12
17	13
17	14
17	17
17	18
17	21
17	22
19	1
19	2
19	6
19	7
19	8
19	11
19	12
19	13
19	14
19	15
19	16
19	17
19	18
19	19
19	20
19	21
19	22
19	24
19	25
19	28
19	29
20	1
20	2
20	6
20	11
20	12
20	13
20	14
20	17
20	18
20	21
20	22
\.


--
-- Data for Name: airlines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY airlines (airline_id, airline_name, date_of_foundation, headquaters, international, fleet_size, number_of_destinations, website) FROM stdin;
1	Aeroflot	1923-02-09	Moscow, Russia	t	214	129	www.aeroflot.ru
2	Transaero	1990-12-28	Moscow, Russia	t	97	156	www.transaero.ru
3	S7 Airlines	1957-05-01	Ob, Novosibirsk Oblast, Russia	t	76	146	www.s7.ru
4	Utair	1967-01-01	Khanty-Mansiysk, Russia	t	65	72	www.utair.ru
5	Rossiya	1932-06-24	Saint Petersburg, Russia	t	61	80	www.rossiya-airlines.com
6	Yamal	1997-01-01	Salekhard, Russia	f	36	38	www.yamal.aero
7	Nordwind Airlines	2008-01-01	Moscow, Russia	t	21	81	www.nordwindairlines.ru
8	I fly	2009-10-30	Moscow, Russia	t	10	15	www.iflyltd.ru
9	Ural Airlines	1943-01-01	Yekaterinburg, Russia	t	43	101	www.uralairlines.ru
10	NordStar Airlines	2008-12-17	Norilsk, Russia	f	15	45	www.nordstar.su
11	Pobeda	2014-09-16	Moscow, Russia	t	14	32	www.pobeda.aero
12	Yakutia	2002-01-01	Yakutsk, Russia	t	17	40	www.yakutia.aero
13	Metrojet	1993-01-01	Kogalym, Russia	t	6	16	www.metrojet.ru
14	Izhavia	1992-01-01	Izhevsk, Russia	f	12	17	www.izhavia.su
15	Gazpromavia	1995-02-03	Moscow, Russia	t	157	18	www.gazpromavia.ru
16	Nordavia	2004-01-01	Arkhangelsk, Russia	f	9	21	www.Nordavia.ru
\.


--
-- Name: airlines_airline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('airlines_airline_id_seq', 16, true);


--
-- Data for Name: airports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY airports (airport_id, airport_name, city, address, time_zone, international, active) FROM stdin;
1	Pulkovo	Saint-Petersburg	Pulkovo highway, 41, 196140	UTC+3	t	t
2	Sheremetyevo	Moscow	Khimki, 141400	UTC+3	t	t
3	Vnukovo	Moscow	Vnukovo, 119027	UTC+3	t	t
4	Domodedovo	Moscow	Domodedovo, 142015	UTC+3	t	t
5	Koltsovo	Yekaterinburg	Bakhchivanjee street, 1, 620025	UTC+5	t	t
6	Sochi	Sochi	Sochi, 354355	UTC+3	t	t
7	Tolmachevo	Novosibirsk	Ob, 633104	UTC+7	t	t
8	Pashkovsky	Krasnodar	Krasnodar, 350037	UTC+3	t	t
9	Ufa	Ufa	Bulgakovo, 450501	UTC+5	t	t
10	Kurumoch	Samara	Samara, 443901	UTC+4	t	t
11	Simferopol	Simferopol	Malchenko street, 16, 95491	UTC+3	t	t
12	Roshchino	Tyumen	Ilyushin street, 23, 625033	UTC+5	t	t
13	Salekhard	Salekhard	Aviatsionnaya street, 22, 629004	UTC+5	f	t
14	Tsentralny	Omsk	Transsibirskaya street, 28, 644103	UTC+6	t	t
15	Balandino	Chelyabinsk	Balandino, 454133	UTC+5	t	t
16	Kurgan	Kurgan	Gagarin street, 41d, 640015	UTC+5	f	t
17	Platov	Rostov-on-Don	Rostov Oblast, 346713	UTC+3	t	f
18	Maykop	Maykop	Promishlennaya street, 385006	UTC+3	f	f
19	Mineralnye Vody	Mineralnye Vody	Mineralnye Vody, 357205	UTC+3	t	t
20	Strigino	Nizhny Novgorod	Bezvodnaya street, 603069	UTC+3	t	t
\.


--
-- Data for Name: airports_airlines_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY airports_airlines_relation (airport_id, airline_id) FROM stdin;
1	10
1	7
1	3
1	1
1	5
1	14
1	11
1	9
1	4
1	12
1	6
2	7
2	1
3	8
3	15
3	14
3	11
3	5
3	4
3	12
4	10
4	3
4	14
4	9
4	6
5	10
5	7
5	3
5	1
5	5
5	15
5	11
5	9
5	4
5	12
5	6
6	10
6	7
6	3
6	1
6	5
6	14
6	11
6	9
6	4
6	12
6	6
7	8
7	10
7	7
7	3
7	1
7	5
7	9
7	4
7	12
7	6
8	10
8	7
8	3
8	1
8	14
8	5
8	9
8	4
8	12
8	6
9	10
9	7
9	3
9	1
9	5
9	15
9	14
9	11
9	9
9	4
9	6
10	1
10	8
10	10
10	7
10	11
10	5
10	3
10	9
10	4
11	7
11	3
11	1
11	14
11	5
11	9
11	6
12	1
12	3
12	5
12	4
12	6
12	15
13	6
13	3
14	3
14	1
14	4
14	5
14	6
14	12
14	9
15	8
15	7
15	3
15	1
15	5
15	14
15	11
15	9
15	6
16	4
19	1
19	5
19	4
19	3
19	9
19	12
19	7
20	10
20	7
20	3
20	1
20	15
20	5
20	4
20	6
\.


--
-- Name: airports_airport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('airports_airport_id_seq', 20, true);


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY flights (flight_id, flight_number, date_of_flight, airline_id, plane_id, time_of_departure, time_of_arrival, departure_airport_id, arrival_airport_id) FROM stdin;
1	SU039	2017-11-02	1	1	18:45:00-03	20:00:00-03	1	2
2	S7126	2017-11-05	3	21	22:50:00-04	23:30:00-03	10	4
3	UT897	2017-11-27	4	12	06:50:00-05	07:50:00-03	16	3
4	U6210 	2017-11-16	9	2	15:30:00-03	20:30:00-05	8	5
5	YC45	2017-11-15	6	26	18:30:00-05	20:05:00-05	13	12
6	O7355	2017-11-15	3	6	22:40:00-05	01:40:00-06	12	14
7	DP414	2017-11-09	11	6	06:45:00-05	07:15:00-03	15	3
8	N4187	2017-12-01	7	17	08:05:00-03	10:05:00-03	2	17
9	TR525	2017-11-17	2	13	10:30:00-07	12:05:00-03	7	11
10	Y71032	2017-12-22	10	29	17:00:00-03	19:25:00-05	6	4
11	KG5678	2017-12-24	13	2	19:35:00-03	22:45:00-03	19	1
12	IZ109	2017-01-01	14	32	10:50:00-03	15:35:00-05	6	9
13	SU6402	2017-11-30	5	21	06:15:00-05	07:10:00-03	5	1
14	5N6463	2017-11-11	16	13	21:35:00-03	01:40:00-05	4	9
15	GZ777	2017-11-07	15	36	15:10:00-03	18:20:00-03	20	6
\.


--
-- Name: flights_flight_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('flights_flight_id_seq', 15, true);


--
-- Data for Name: planes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planes (plane_id, model, count_of_places, national_origin, manufacturer, first_flight) FROM stdin;
1	Airbus A320-200	150	Multi-national	Airbus	1987-02-22
2	Airbus A321-200	185	Multi-national	Airbus	1996-03-01
3	Airbus A330-200	316	Multi-national	Airbus	1992-11-02
4	Airbus A330-300	310	Multi-national	Airbus	1992-11-02
5	Airbus A350-900	325	Multi-national	Airbus	2013-06-14
6	Boeing 737-800	175	United States	Boeing Commercial Airplanes	1997-02-09
7	Boeing 777-300ER	396	United States	Boeing Commercial Airplanes	1994-06-12
8	Sukhoi Superjet 100	98	Russia	Komsomolsk-on-Amur Aircraft Production Association	2008-05-19
9	Irkut MC-21	165	Russia	United Aircraft Corporation	2017-05-28
10	Tu-214	180	Soviet Union	Kazan Aircraft Production Association	1989-01-02
11	Boeing 737-300	145	United States	Boeing Commercial Airplanes	1984-02-24
12	Boeing 737-400	163	United States	Boeing Commercial Airplanes	1984-02-24
13	Boeing 737-500	127	United States	Boeing Commercial Airplanes	1984-02-24
14	Boeing 737-700	148	United States	Boeing Commercial Airplanes	1997-02-09
15	Boeing 747-400	416	United States	Boeing Commercial Airplanes	1988-04-29
16	Boeing 747-8I	587	United States	Boeing Commercial Airplanes	2011-03-20
17	Boeing 767-200ER	245	United States	Boeing Commercial Airplanes	1981-09-26
18	Boeing 767-300ER	290	United States	Boeing Commercial Airplanes	1981-09-26
19	Boeing 777-200	313	United States	Boeing Commercial Airplanes	1994-06-12
20	Boeing 777-200ER	313	United States	Boeing Commercial Airplanes	1994-06-12
21	Airbus A319-100	356	Multi-national	Airbus	1987-02-22
22	Airbus A320neo	195	Multi-national	Airbus	2014-09-25
23	Embraer E170	72	Brazil	Embraer	2004-03-17
24	ATR 72-500	70	France/Italy	ATR	1988-10-27
25	Boeing 777-300	396	United States	Boeing Commercial Airplanes	1994-06-12
26	Bombardier CRJ200	50	Canada	Bombardier Aerospace	1991-05-10
27	Let L-410	19	Czech Republic	Let Kunovice	1969-04-16
28	Boeing 757-200	225	United States	Boeing Commercial Airplanes	1982-02-19
29	ATR 42-500	48	France/Italy	ATR	1984-08-16
30	Bombardier Q400	82	Canada	Bombardier Aerospace	1983-06-20
31	Bombardier Q300	50	Canada	Bombardier Aerospace	1983-06-20
32	An-24	50	Soviet Union	Antonov	1959-10-29
33	Yak-42	104	Soviet Union	Yakovlev	1975-03-07
34	Yak-40	32	Soviet Union	Yakovlev	1966-10-21
35	Dassault Falcon 900	19	France	Dassault Aviation	1984-09-21
36	Dassault Falcon 900EX EASy	19	France	Dassault Aviation	1984-09-21
37	Dassault Falcon 900LX	19	France	Dassault Aviation	1984-09-21
38	Dassault Falcon 7X	14	France	Dassault Aviation	2005-05-05
\.


--
-- Data for Name: planes_airlines_relation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planes_airlines_relation (airline_id, plane_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
1	7
1	8
1	9
2	10
2	2
2	6
2	11
2	12
2	13
2	14
2	15
2	16
2	17
2	18
2	19
2	20
2	25
3	21
3	1
3	2
3	22
3	6
3	23
4	24
4	12
4	13
4	6
4	17
5	21
5	1
5	6
5	15
5	19
5	25
6	1
6	2
6	12
6	26
6	27
6	8
7	2
7	3
7	6
7	18
7	20
7	7
8	3
8	4
8	28
9	21
9	1
9	2
10	29
10	11
10	6
11	6
12	28
12	6
12	30
12	31
12	8
12	32
13	2
13	1
14	32
14	33
15	34
15	8
15	35
15	36
15	37
15	38
15	14
16	13
\.


--
-- Name: planes_plane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('planes_plane_id_seq', 38, true);


--
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reservation (reservation_id, reservation_number, reservation_date, customer, number_of_tickets) FROM stdin;
1	852456719	2017-10-26	Maksimov Oleg Ivanovich	1
2	937524183	2017-10-24	Ivanov Maksim Olegovich	2
3	109387622	2017-10-19	Gagarin Nikolay Andreevich	2
4	993865254	2017-10-01	Baragoz Ilya Aleksandrovich	1
5	626738559	2017-10-06	Gordienko Sofya Alekseevna	1
6	987635577	2017-09-26	Marchenko Inna Vitalyevna	1
7	109735524	2017-10-11	Strazhko Anatoliy Igorevich	1
8	877365345	2017-09-18	Tsekhanovich Irina Sergeevna	2
9	309876256	2017-10-27	Chebikina Vlada Igorevna	1
10	465355144	2017-09-04	Valuev Valentin Mikhailovich	1
11	198765435	2017-09-13	Chubarov Dmitriy Vasilyevich	2
12	789653214	2017-09-30	Kovalenko Sofya Germanovna	1
13	234678543	2017-10-08	Kuznetsov Dmitriy Vladimirovich	1
14	236789322	2017-10-29	Rubanovich Artem Victorovich	2
15	259753146	2017-09-02	Kantorovich David Solomonovich	3
16	976367876	2017-08-17	Kopin Shamil Lvovich	1
17	989744322	2017-10-06	Zaitseva Sarah Abramovna	1
18	936621677	2017-10-15	Rozhnov Grigoriy Aleksandrovich	1
\.


--
-- Name: reservation_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reservation_reservation_id_seq', 18, true);


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tickets (ticket_id, ticket_number, passenger_name, seat_number, reservation_id, flight_id, possible_to_return) FROM stdin;
1	100321	Maksimov Oleg Ivanovich	13A	1	10	f
2	100342	Ivanov Maksim Olegovich	10D	2	11	t
3	110343	Ivanova Alla Olegovna	10F	2	11	t
4	100123	Gagarin Nikolay Andreevich	01B	3	8	t
5	100124	Gagarina Anna Nikolaevna	01C	3	8	t
6	210267	Baragoz Ilya Aleksandrovich	26B	4	15	t
7	120556	Gordienko Sofya Alekseevna	12E	5	7	t
8	100167	Marchenko Darya Aleksandrovna	03F	6	1	t
9	100332	Strazhko Anatoliy Igorevich	08C	7	12	f
10	200192	Tsekhanovich Irina Sergeevna	37D	8	4	t
11	200193	Brigin Sergey Vadimovich	37E	8	4	t
12	100418	Chebikina Vlada Igorevna	41A	9	3	f
13	101021	Valuev Valentin Mikhailovich	11B	10	5	t
14	100911	Chubarov Dmitriy Vasilyevich	20F	11	6	f
15	100912	Chubarov Gleb Vasilyevich	20E	11	6	f
16	200111	Kovalenko Valentina Germanovna	31A	12	9	f
17	201992	Kuznetsov Dmitriy Vladimirovich	09C	13	13	t
18	101134	Rubanovich Artem Victorovich	15A	14	10	t
19	101135	Rubanovich Victor Nikolaevich	15B	14	10	t
20	100777	Kantorovich David Solomonovich	02A	15	14	f
21	100778	Kantorovich Iosif Davidovich	02B	15	14	f
22	100779	Kantorovich Berta Iosifovna	03A	15	14	f
23	300634	Kopin Shamil Lvovich	27C	16	2	t
24	300511	Zaitseva Sarah Abramovna	32D	17	13	f
25	100115	Rozhnov Grigoriy Aleksandrovich	33F	18	15	t
\.


--
-- Name: tickets_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tickets_ticket_id_seq', 25, true);


--
-- Name: aiports_planes_relation aiports_planes_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aiports_planes_relation
    ADD CONSTRAINT aiports_planes_relation_pkey PRIMARY KEY (airport_id, plane_id);


--
-- Name: airlines airlines_airline_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airlines
    ADD CONSTRAINT airlines_airline_name_key UNIQUE (airline_name);


--
-- Name: airlines airlines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airlines
    ADD CONSTRAINT airlines_pkey PRIMARY KEY (airline_id);


--
-- Name: airlines airlines_website_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airlines
    ADD CONSTRAINT airlines_website_key UNIQUE (website);


--
-- Name: airports airports_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports
    ADD CONSTRAINT airports_address_key UNIQUE (address);


--
-- Name: airports_airlines_relation airports_airlines_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports_airlines_relation
    ADD CONSTRAINT airports_airlines_relation_pkey PRIMARY KEY (airport_id, airline_id);


--
-- Name: airports airports_airport_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports
    ADD CONSTRAINT airports_airport_name_key UNIQUE (airport_name);


--
-- Name: airports airports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (airport_id);


--
-- Name: flights flights_flight_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_flight_number_key UNIQUE (flight_number);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);


--
-- Name: planes_airlines_relation planes_airlines_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_airlines_relation
    ADD CONSTRAINT planes_airlines_relation_pkey PRIMARY KEY (airline_id, plane_id);


--
-- Name: planes planes_model_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes
    ADD CONSTRAINT planes_model_key UNIQUE (model);


--
-- Name: planes planes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes
    ADD CONSTRAINT planes_pkey PRIMARY KEY (plane_id);


--
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (reservation_id);


--
-- Name: reservation reservation_reservation_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservation
    ADD CONSTRAINT reservation_reservation_number_key UNIQUE (reservation_number);


--
-- Name: tickets tickets_passenger_name_flight_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_passenger_name_flight_id_key UNIQUE (passenger_name, flight_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);


--
-- Name: tickets tickets_seat_number_flight_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_seat_number_flight_id_key UNIQUE (seat_number, flight_id);


--
-- Name: tickets tickets_ticket_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_ticket_number_key UNIQUE (ticket_number);


--
-- Name: aiports_planes_relation aiports_planes_relation_airport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aiports_planes_relation
    ADD CONSTRAINT aiports_planes_relation_airport_id_fkey FOREIGN KEY (airport_id) REFERENCES airports(airport_id);


--
-- Name: aiports_planes_relation aiports_planes_relation_plane_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aiports_planes_relation
    ADD CONSTRAINT aiports_planes_relation_plane_id_fkey FOREIGN KEY (plane_id) REFERENCES planes(plane_id);


--
-- Name: airports_airlines_relation airports_airlines_relation_airline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports_airlines_relation
    ADD CONSTRAINT airports_airlines_relation_airline_id_fkey FOREIGN KEY (airline_id) REFERENCES airlines(airline_id);


--
-- Name: airports_airlines_relation airports_airlines_relation_airport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY airports_airlines_relation
    ADD CONSTRAINT airports_airlines_relation_airport_id_fkey FOREIGN KEY (airport_id) REFERENCES airports(airport_id);


--
-- Name: flights flights_airline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_airline_id_fkey FOREIGN KEY (airline_id) REFERENCES airlines(airline_id);


--
-- Name: flights flights_arrival_airport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_arrival_airport_id_fkey FOREIGN KEY (arrival_airport_id) REFERENCES airports(airport_id);


--
-- Name: flights flights_departure_airport_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_departure_airport_id_fkey FOREIGN KEY (departure_airport_id) REFERENCES airports(airport_id);


--
-- Name: flights flights_plane_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_plane_id_fkey FOREIGN KEY (plane_id) REFERENCES planes(plane_id);


--
-- Name: planes_airlines_relation planes_airlines_relation_airline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_airlines_relation
    ADD CONSTRAINT planes_airlines_relation_airline_id_fkey FOREIGN KEY (airline_id) REFERENCES airlines(airline_id);


--
-- Name: planes_airlines_relation planes_airlines_relation_plane_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_airlines_relation
    ADD CONSTRAINT planes_airlines_relation_plane_id_fkey FOREIGN KEY (plane_id) REFERENCES planes(plane_id);


--
-- Name: tickets tickets_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES flights(flight_id);


--
-- Name: tickets tickets_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id);


--
-- PostgreSQL database dump complete
--

