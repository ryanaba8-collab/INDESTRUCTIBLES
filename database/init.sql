--
-- PostgreSQL database dump
--

\restrict PZI6njMcenTN1YxuJZj2toKpfUl5VddukY7IfgV7MRxBLQyl8SAKv1030LGBVlD

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-09 12:06:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 16792)
-- Name: annees_academiques; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annees_academiques (
    id integer NOT NULL,
    libelle character varying(20) NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    active boolean DEFAULT false
);


ALTER TABLE public.annees_academiques OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16791)
-- Name: annees_academiques_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.annees_academiques ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.annees_academiques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16855)
-- Name: etudiants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etudiants (
    id integer NOT NULL,
    user_id integer NOT NULL,
    matricule character varying(50) NOT NULL,
    groupe_id integer NOT NULL
);


ALTER TABLE public.etudiants OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16854)
-- Name: etudiants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.etudiants ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.etudiants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16805)
-- Name: filieres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filieres (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    nom character varying(100) NOT NULL
);


ALTER TABLE public.filieres OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16804)
-- Name: filieres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.filieres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.filieres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16827)
-- Name: groupes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupes (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    filiere_id integer NOT NULL,
    niveau_id integer NOT NULL,
    periode character varying(10) NOT NULL,
    annee_academique_id integer NOT NULL,
    capacite integer,
    CONSTRAINT groupes_periode_check CHECK (((periode)::text = ANY ((ARRAY['MATIN'::character varying, 'SOIR'::character varying])::text[])))
);


ALTER TABLE public.groupes OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16826)
-- Name: groupes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.groupes ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.groupes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 250 (class 1259 OID 17087)
-- Name: historique_modifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historique_modifications (
    id integer NOT NULL,
    seance_id integer NOT NULL,
    modifie_par integer NOT NULL,
    ancienne_date date,
    ancienne_heure_debut time without time zone,
    ancienne_heure_fin time without time zone,
    ancienne_salle_id integer,
    nouvelle_date date,
    nouvelle_heure_debut time without time zone,
    nouvelle_heure_fin time without time zone,
    nouvelle_salle_id integer,
    motif text,
    date_modification timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.historique_modifications OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17086)
-- Name: historique_modifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.historique_modifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.historique_modifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 16933)
-- Name: matieres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matieres (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    nom character varying(150) NOT NULL,
    ue_id integer,
    ua_id integer,
    volume_horaire_total numeric(5,2) DEFAULT 0,
    coefficient numeric(4,2)
);


ALTER TABLE public.matieres OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16932)
-- Name: matieres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.matieres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.matieres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16816)
-- Name: niveaux; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveaux (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    libelle character varying(50) NOT NULL
);


ALTER TABLE public.niveaux OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16815)
-- Name: niveaux_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.niveaux ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.niveaux_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16879)
-- Name: professeurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professeurs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    grade character varying(100),
    specialite character varying(150),
    type_prof character varying(20) NOT NULL,
    CONSTRAINT professeurs_type_prof_check CHECK (((type_prof)::text = ANY ((ARRAY['PERMANENT'::character varying, 'VACATAIRE'::character varying])::text[])))
);


ALTER TABLE public.professeurs OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16878)
-- Name: professeurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.professeurs ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.professeurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16750)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    libelle character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16749)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 244 (class 1259 OID 16966)
-- Name: salles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salles (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    nom character varying(100) NOT NULL,
    capacite integer,
    type_salle_id integer NOT NULL,
    disponible boolean DEFAULT true
);


ALTER TABLE public.salles OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16965)
-- Name: salles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.salles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.salles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 248 (class 1259 OID 17053)
-- Name: seances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seances (
    id integer NOT NULL,
    sequence_id integer NOT NULL,
    salle_id integer NOT NULL,
    date_cours date NOT NULL,
    heure_debut time without time zone NOT NULL,
    heure_fin time without time zone NOT NULL,
    statut character varying(20) DEFAULT 'PLANIFIEE'::character varying,
    cree_par integer,
    commentaire text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_heure_fin_sup_debut CHECK ((heure_fin > heure_debut)),
    CONSTRAINT seances_statut_check CHECK (((statut)::text = ANY ((ARRAY['PLANIFIEE'::character varying, 'ANNULEE'::character varying, 'REPORTEE'::character varying, 'EFFECTUEE'::character varying])::text[])))
);


ALTER TABLE public.seances OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17052)
-- Name: seances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.seances ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.seances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 246 (class 1259 OID 16984)
-- Name: sequences_cours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sequences_cours (
    id integer NOT NULL,
    matiere_id integer NOT NULL,
    professeur_id integer NOT NULL,
    groupe_id integer NOT NULL,
    annee_academique_id integer NOT NULL,
    type_cours character varying(20) NOT NULL,
    duree_seance numeric(4,2) NOT NULL,
    volume_total_heures numeric(5,2) NOT NULL,
    heures_restantes numeric(5,2) NOT NULL,
    statut character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sequences_cours_statut_check CHECK (((statut)::text = ANY ((ARRAY['ACTIVE'::character varying, 'TERMINEE'::character varying, 'SUSPENDUE'::character varying])::text[]))),
    CONSTRAINT sequences_cours_type_cours_check CHECK (((type_cours)::text = ANY ((ARRAY['THEORIE'::character varying, 'PRATIQUE'::character varying])::text[])))
);


ALTER TABLE public.sequences_cours OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16983)
-- Name: sequences_cours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sequences_cours ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sequences_cours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 16955)
-- Name: types_salles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.types_salles (
    id integer NOT NULL,
    code character varying(30) NOT NULL,
    libelle character varying(100) NOT NULL
);


ALTER TABLE public.types_salles OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16954)
-- Name: types_salles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.types_salles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.types_salles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 16896)
-- Name: uas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uas (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    nom character varying(150) NOT NULL,
    responsable_user_id integer
);


ALTER TABLE public.uas OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16895)
-- Name: uas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.uas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.uas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 16912)
-- Name: ues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ues (
    id integer NOT NULL,
    code character varying(20) NOT NULL,
    nom character varying(150) NOT NULL,
    ua_id integer,
    responsable_user_id integer
);


ALTER TABLE public.ues OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16911)
-- Name: ues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ues ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16769)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role_id integer NOT NULL,
    actif boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16768)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5181 (class 0 OID 16792)
-- Dependencies: 224
-- Data for Name: annees_academiques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annees_academiques (id, libelle, date_debut, date_fin, active) FROM stdin;
1	2025-2026	2025-09-01	2026-07-31	t
\.


--
-- TOC entry 5189 (class 0 OID 16855)
-- Dependencies: 232
-- Data for Name: etudiants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etudiants (id, user_id, matricule, groupe_id) FROM stdin;
1	2	ETU001	1
\.


--
-- TOC entry 5183 (class 0 OID 16805)
-- Dependencies: 226
-- Data for Name: filieres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filieres (id, code, nom) FROM stdin;
1	INFO	Informatique
2	GEST	Gestion
\.


--
-- TOC entry 5187 (class 0 OID 16827)
-- Dependencies: 230
-- Data for Name: groupes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupes (id, nom, filiere_id, niveau_id, periode, annee_academique_id, capacite) FROM stdin;
1	L2 INFO MATIN A	1	2	MATIN	1	40
\.


--
-- TOC entry 5207 (class 0 OID 17087)
-- Dependencies: 250
-- Data for Name: historique_modifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historique_modifications (id, seance_id, modifie_par, ancienne_date, ancienne_heure_debut, ancienne_heure_fin, ancienne_salle_id, nouvelle_date, nouvelle_heure_debut, nouvelle_heure_fin, nouvelle_salle_id, motif, date_modification) FROM stdin;
1	2	1	2026-04-22	08:00:00	10:00:00	1	2026-04-21	12:00:00	14:00:00	1	Report de la séance	2026-05-05 10:17:33.852
2	2	1	2026-04-21	12:00:00	14:00:00	1	2026-04-21	13:00:00	15:00:00	1	Report de la séance	2026-05-05 10:24:33.992
3	2	1	2026-04-21	13:00:00	15:00:00	1	2026-04-21	13:00:00	15:00:00	1	Report de la séance	2026-05-05 10:35:51.195
4	2	1	2026-04-21	13:00:00	15:00:00	1	2026-04-20	13:00:00	15:00:00	1	Correction horaire	2026-05-07 07:04:35.802
5	2	1	2026-04-20	13:00:00	15:00:00	1	2026-04-21	15:00:00	17:00:00	1	Correction horaire	2026-05-07 07:15:41.217
\.


--
-- TOC entry 5197 (class 0 OID 16933)
-- Dependencies: 240
-- Data for Name: matieres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matieres (id, code, nom, ue_id, ua_id, volume_horaire_total, coefficient) FROM stdin;
1	BD101	Base de données	\N	\N	20.00	2.00
\.


--
-- TOC entry 5185 (class 0 OID 16816)
-- Dependencies: 228
-- Data for Name: niveaux; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.niveaux (id, code, libelle) FROM stdin;
1	L1	Licence 1
2	L2	Licence 2
3	L3	Licence 3
\.


--
-- TOC entry 5191 (class 0 OID 16879)
-- Dependencies: 234
-- Data for Name: professeurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professeurs (id, user_id, grade, specialite, type_prof) FROM stdin;
1	1	Assistant	Bases de données	PERMANENT
\.


--
-- TOC entry 5177 (class 0 OID 16750)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, code, libelle) FROM stdin;
1	ADMIN	Administrateur
2	ADMINSCOL	Administrateur scolaire
3	ADMINSYS	Administrateur système
4	PROF_PERMANENT	Professeur permanent
5	PROF_VACATAIRE	Professeur vacataire
6	ETUDIANT	Étudiant
7	RESPONSABLE_UE	Responsable UE
8	RESPONSABLE_UA	Responsable UA
\.


--
-- TOC entry 5201 (class 0 OID 16966)
-- Dependencies: 244
-- Data for Name: salles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salles (id, code, nom, capacite, type_salle_id, disponible) FROM stdin;
1	A1	Salle A1	50	1	t
\.


--
-- TOC entry 5205 (class 0 OID 17053)
-- Dependencies: 248
-- Data for Name: seances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seances (id, sequence_id, salle_id, date_cours, heure_debut, heure_fin, statut, cree_par, commentaire, created_at) FROM stdin;
3	2	1	2026-04-21	10:00:00	12:00:00	PLANIFIEE	1	Nouvelle séance ajoutée depuis l'API	2026-05-05 09:49:54.973
2	2	1	2026-04-21	15:00:00	17:00:00	ANNULEE	1	Première séance de base de données	2026-04-22 11:14:22.990254
\.


--
-- TOC entry 5203 (class 0 OID 16984)
-- Dependencies: 246
-- Data for Name: sequences_cours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sequences_cours (id, matiere_id, professeur_id, groupe_id, annee_academique_id, type_cours, duree_seance, volume_total_heures, heures_restantes, statut, created_at) FROM stdin;
2	1	1	1	1	THEORIE	2.00	20.00	10.00	ACTIVE	2026-04-22 11:07:54.799666
\.


--
-- TOC entry 5199 (class 0 OID 16955)
-- Dependencies: 242
-- Data for Name: types_salles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.types_salles (id, code, libelle) FROM stdin;
1	THEORIE	Salle de théorie
2	PRATIQUE	Salle de pratique
3	LABO	Laboratoire
\.


--
-- TOC entry 5193 (class 0 OID 16896)
-- Dependencies: 236
-- Data for Name: uas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uas (id, code, nom, responsable_user_id) FROM stdin;
\.


--
-- TOC entry 5195 (class 0 OID 16912)
-- Dependencies: 238
-- Data for Name: ues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ues (id, code, nom, ua_id, responsable_user_id) FROM stdin;
\.


--
-- TOC entry 5179 (class 0 OID 16769)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nom, prenom, email, mot_de_passe, role_id, actif, created_at) FROM stdin;
1	Kane	Moussa	moussa.kane@test.com	pass_hash	4	t	2026-04-22 10:58:07.952888
2	Diallo	Aminata	aminata.diallo@test.com	pass_hash	6	t	2026-04-22 11:03:52.832556
\.


--
-- TOC entry 5213 (class 0 OID 0)
-- Dependencies: 223
-- Name: annees_academiques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annees_academiques_id_seq', 1, true);


--
-- TOC entry 5214 (class 0 OID 0)
-- Dependencies: 231
-- Name: etudiants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etudiants_id_seq', 1, true);


--
-- TOC entry 5215 (class 0 OID 0)
-- Dependencies: 225
-- Name: filieres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filieres_id_seq', 2, true);


--
-- TOC entry 5216 (class 0 OID 0)
-- Dependencies: 229
-- Name: groupes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groupes_id_seq', 1, true);


--
-- TOC entry 5217 (class 0 OID 0)
-- Dependencies: 249
-- Name: historique_modifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historique_modifications_id_seq', 5, true);


--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 239
-- Name: matieres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.matieres_id_seq', 2, true);


--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 227
-- Name: niveaux_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.niveaux_id_seq', 3, true);


--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 233
-- Name: professeurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professeurs_id_seq', 1, true);


--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 8, true);


--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 243
-- Name: salles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salles_id_seq', 1, true);


--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 247
-- Name: seances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seances_id_seq', 3, true);


--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 245
-- Name: sequences_cours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sequences_cours_id_seq', 2, true);


--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 241
-- Name: types_salles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.types_salles_id_seq', 3, true);


--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 235
-- Name: uas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uas_id_seq', 1, false);


--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 237
-- Name: ues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ues_id_seq', 1, false);


--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4956 (class 2606 OID 16803)
-- Name: annees_academiques annees_academiques_libelle_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annees_academiques
    ADD CONSTRAINT annees_academiques_libelle_key UNIQUE (libelle);


--
-- TOC entry 4958 (class 2606 OID 16801)
-- Name: annees_academiques annees_academiques_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annees_academiques
    ADD CONSTRAINT annees_academiques_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 16867)
-- Name: etudiants etudiants_matricule_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_matricule_key UNIQUE (matricule);


--
-- TOC entry 4972 (class 2606 OID 16863)
-- Name: etudiants etudiants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 16865)
-- Name: etudiants etudiants_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT etudiants_user_id_key UNIQUE (user_id);


--
-- TOC entry 4960 (class 2606 OID 16814)
-- Name: filieres filieres_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key UNIQUE (code);


--
-- TOC entry 4962 (class 2606 OID 16812)
-- Name: filieres filieres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 2606 OID 16838)
-- Name: groupes groupes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT groupes_pkey PRIMARY KEY (id);


--
-- TOC entry 5004 (class 2606 OID 17097)
-- Name: historique_modifications historique_modifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_modifications
    ADD CONSTRAINT historique_modifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 16943)
-- Name: matieres matieres_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matieres
    ADD CONSTRAINT matieres_code_key UNIQUE (code);


--
-- TOC entry 4990 (class 2606 OID 16941)
-- Name: matieres matieres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matieres
    ADD CONSTRAINT matieres_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 16825)
-- Name: niveaux niveaux_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveaux
    ADD CONSTRAINT niveaux_code_key UNIQUE (code);


--
-- TOC entry 4966 (class 2606 OID 16823)
-- Name: niveaux niveaux_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveaux
    ADD CONSTRAINT niveaux_pkey PRIMARY KEY (id);


--
-- TOC entry 4976 (class 2606 OID 16887)
-- Name: professeurs professeurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professeurs
    ADD CONSTRAINT professeurs_pkey PRIMARY KEY (id);


--
-- TOC entry 4978 (class 2606 OID 16889)
-- Name: professeurs professeurs_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professeurs
    ADD CONSTRAINT professeurs_user_id_key UNIQUE (user_id);


--
-- TOC entry 4948 (class 2606 OID 16759)
-- Name: roles roles_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_code_key UNIQUE (code);


--
-- TOC entry 4950 (class 2606 OID 16757)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 16977)
-- Name: salles salles_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_code_key UNIQUE (code);


--
-- TOC entry 4998 (class 2606 OID 16975)
-- Name: salles salles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_pkey PRIMARY KEY (id);


--
-- TOC entry 5002 (class 2606 OID 17069)
-- Name: seances seances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT seances_pkey PRIMARY KEY (id);


--
-- TOC entry 5000 (class 2606 OID 17001)
-- Name: sequences_cours sequences_cours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences_cours
    ADD CONSTRAINT sequences_cours_pkey PRIMARY KEY (id);


--
-- TOC entry 4992 (class 2606 OID 16964)
-- Name: types_salles types_salles_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.types_salles
    ADD CONSTRAINT types_salles_code_key UNIQUE (code);


--
-- TOC entry 4994 (class 2606 OID 16962)
-- Name: types_salles types_salles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.types_salles
    ADD CONSTRAINT types_salles_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 16905)
-- Name: uas uas_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uas
    ADD CONSTRAINT uas_code_key UNIQUE (code);


--
-- TOC entry 4982 (class 2606 OID 16903)
-- Name: uas uas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uas
    ADD CONSTRAINT uas_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 16921)
-- Name: ues ues_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ues
    ADD CONSTRAINT ues_code_key UNIQUE (code);


--
-- TOC entry 4986 (class 2606 OID 16919)
-- Name: ues ues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ues
    ADD CONSTRAINT ues_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 2606 OID 16785)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4954 (class 2606 OID 16783)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5009 (class 2606 OID 16873)
-- Name: etudiants fk_etudiants_groupe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT fk_etudiants_groupe FOREIGN KEY (groupe_id) REFERENCES public.groupes(id);


--
-- TOC entry 5010 (class 2606 OID 16868)
-- Name: etudiants fk_etudiants_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etudiants
    ADD CONSTRAINT fk_etudiants_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5006 (class 2606 OID 16849)
-- Name: groupes fk_groupes_annee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT fk_groupes_annee FOREIGN KEY (annee_academique_id) REFERENCES public.annees_academiques(id);


--
-- TOC entry 5007 (class 2606 OID 16839)
-- Name: groupes fk_groupes_filiere; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT fk_groupes_filiere FOREIGN KEY (filiere_id) REFERENCES public.filieres(id);


--
-- TOC entry 5008 (class 2606 OID 16844)
-- Name: groupes fk_groupes_niveau; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupes
    ADD CONSTRAINT fk_groupes_niveau FOREIGN KEY (niveau_id) REFERENCES public.niveaux(id);


--
-- TOC entry 5025 (class 2606 OID 17108)
-- Name: historique_modifications fk_hist_ancienne_salle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_modifications
    ADD CONSTRAINT fk_hist_ancienne_salle FOREIGN KEY (ancienne_salle_id) REFERENCES public.salles(id);


--
-- TOC entry 5026 (class 2606 OID 17113)
-- Name: historique_modifications fk_hist_nouvelle_salle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_modifications
    ADD CONSTRAINT fk_hist_nouvelle_salle FOREIGN KEY (nouvelle_salle_id) REFERENCES public.salles(id);


--
-- TOC entry 5027 (class 2606 OID 17098)
-- Name: historique_modifications fk_hist_seance; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_modifications
    ADD CONSTRAINT fk_hist_seance FOREIGN KEY (seance_id) REFERENCES public.seances(id);


--
-- TOC entry 5028 (class 2606 OID 17103)
-- Name: historique_modifications fk_hist_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_modifications
    ADD CONSTRAINT fk_hist_user FOREIGN KEY (modifie_par) REFERENCES public.users(id);


--
-- TOC entry 5015 (class 2606 OID 16949)
-- Name: matieres fk_matieres_ua; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matieres
    ADD CONSTRAINT fk_matieres_ua FOREIGN KEY (ua_id) REFERENCES public.uas(id);


--
-- TOC entry 5016 (class 2606 OID 16944)
-- Name: matieres fk_matieres_ue; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matieres
    ADD CONSTRAINT fk_matieres_ue FOREIGN KEY (ue_id) REFERENCES public.ues(id);


--
-- TOC entry 5011 (class 2606 OID 16890)
-- Name: professeurs fk_professeurs_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professeurs
    ADD CONSTRAINT fk_professeurs_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5017 (class 2606 OID 16978)
-- Name: salles fk_salles_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT fk_salles_type FOREIGN KEY (type_salle_id) REFERENCES public.types_salles(id);


--
-- TOC entry 5022 (class 2606 OID 17080)
-- Name: seances fk_seances_createur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT fk_seances_createur FOREIGN KEY (cree_par) REFERENCES public.users(id);


--
-- TOC entry 5023 (class 2606 OID 17075)
-- Name: seances fk_seances_salle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT fk_seances_salle FOREIGN KEY (salle_id) REFERENCES public.salles(id);


--
-- TOC entry 5024 (class 2606 OID 17070)
-- Name: seances fk_seances_sequence; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seances
    ADD CONSTRAINT fk_seances_sequence FOREIGN KEY (sequence_id) REFERENCES public.sequences_cours(id);


--
-- TOC entry 5018 (class 2606 OID 17017)
-- Name: sequences_cours fk_sequences_annee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences_cours
    ADD CONSTRAINT fk_sequences_annee FOREIGN KEY (annee_academique_id) REFERENCES public.annees_academiques(id);


--
-- TOC entry 5019 (class 2606 OID 17012)
-- Name: sequences_cours fk_sequences_groupe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences_cours
    ADD CONSTRAINT fk_sequences_groupe FOREIGN KEY (groupe_id) REFERENCES public.groupes(id);


--
-- TOC entry 5020 (class 2606 OID 17002)
-- Name: sequences_cours fk_sequences_matiere; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences_cours
    ADD CONSTRAINT fk_sequences_matiere FOREIGN KEY (matiere_id) REFERENCES public.matieres(id);


--
-- TOC entry 5021 (class 2606 OID 17007)
-- Name: sequences_cours fk_sequences_professeur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequences_cours
    ADD CONSTRAINT fk_sequences_professeur FOREIGN KEY (professeur_id) REFERENCES public.professeurs(id);


--
-- TOC entry 5012 (class 2606 OID 16906)
-- Name: uas fk_uas_responsable; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uas
    ADD CONSTRAINT fk_uas_responsable FOREIGN KEY (responsable_user_id) REFERENCES public.users(id);


--
-- TOC entry 5013 (class 2606 OID 16927)
-- Name: ues fk_ues_responsable; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ues
    ADD CONSTRAINT fk_ues_responsable FOREIGN KEY (responsable_user_id) REFERENCES public.users(id);


--
-- TOC entry 5014 (class 2606 OID 16922)
-- Name: ues fk_ues_ua; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ues
    ADD CONSTRAINT fk_ues_ua FOREIGN KEY (ua_id) REFERENCES public.uas(id);


--
-- TOC entry 5005 (class 2606 OID 16786)
-- Name: users fk_users_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-05-09 12:06:50

--
-- PostgreSQL database dump complete
--

\unrestrict PZI6njMcenTN1YxuJZj2toKpfUl5VddukY7IfgV7MRxBLQyl8SAKv1030LGBVlD

