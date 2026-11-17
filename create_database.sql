--
-- PostgreSQL database dump
--

\restrict 82noiyjFOXrRe84Q13KZhk2jogePDDW8AwYhcmaxIctVK3JBL7PxAoajaUTrM1x

-- Dumped from database version 18.7
-- Dumped by pg_dump version 18.7

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
-- Name: course_instance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_instance (
    instance_id integer NOT NULL,
    num_students integer NOT NULL,
    study_period integer NOT NULL,
    study_year integer NOT NULL,
    course_code character varying(500) NOT NULL,
    CONSTRAINT course_instance_num_students_check CHECK ((num_students >= 0)),
    CONSTRAINT course_instance_study_period_check CHECK (((study_period >= 1) AND (study_period <= 4)))
);


ALTER TABLE public.course_instance OWNER TO postgres;

--
-- Name: course_instance_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.course_instance ALTER COLUMN instance_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.course_instance_instance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: course_layout; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_layout (
    course_code character varying(500) NOT NULL,
    course_name character varying(500) NOT NULL,
    min_students integer NOT NULL,
    max_students integer NOT NULL,
    hp numeric(4,2) NOT NULL,
    CONSTRAINT course_layout_check CHECK ((max_students >= min_students)),
    CONSTRAINT course_layout_hp_check CHECK ((hp > (0)::numeric)),
    CONSTRAINT course_layout_min_students_check CHECK ((min_students >= 0))
);


ALTER TABLE public.course_layout OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    department_name character varying(500) NOT NULL,
    manager_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.department ALTER COLUMN department_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.department_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employment_id integer NOT NULL,
    personal_number character varying(500) NOT NULL,
    job_title_id integer NOT NULL,
    department_id integer NOT NULL,
    supervisor_id integer,
    salary numeric(10,2) NOT NULL,
    CONSTRAINT employee_salary_check CHECK ((salary >= (0)::numeric))
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_allocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_allocation (
    employment_id integer NOT NULL,
    planned_activity_id integer NOT NULL
);


ALTER TABLE public.employee_allocation OWNER TO postgres;

--
-- Name: employee_employment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee ALTER COLUMN employment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_employment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: employee_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_skill (
    employment_id integer NOT NULL,
    skill character varying(500) NOT NULL
);


ALTER TABLE public.employee_skill OWNER TO postgres;

--
-- Name: job_title; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_title (
    job_title_id integer NOT NULL,
    job_title character varying(500) NOT NULL
);


ALTER TABLE public.job_title OWNER TO postgres;

--
-- Name: job_title_job_title_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.job_title ALTER COLUMN job_title_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.job_title_job_title_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    personal_number character varying(500) NOT NULL,
    first_name character varying(500) NOT NULL,
    last_name character varying(500) NOT NULL,
    phone_number character varying(500),
    address character varying(500) NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: planned_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planned_activity (
    planned_activity_id integer NOT NULL,
    planned_hours numeric(24,2) NOT NULL,
    instance_id integer NOT NULL,
    activity_name character varying(500) NOT NULL,
    CONSTRAINT planned_activity_planned_hours_check CHECK ((planned_hours >= (0)::numeric))
);


ALTER TABLE public.planned_activity OWNER TO postgres;

--
-- Name: planned_activity_planned_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.planned_activity ALTER COLUMN planned_activity_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planned_activity_planned_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: teaching_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teaching_activity (
    activity_name character varying(500) NOT NULL,
    factor numeric(4,2) NOT NULL,
    CONSTRAINT teaching_activity_factor_check CHECK ((factor >= (1)::numeric))
);


ALTER TABLE public.teaching_activity OWNER TO postgres;

--
-- Name: course_instance course_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT course_instance_pkey PRIMARY KEY (instance_id);


--
-- Name: course_layout course_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_layout
    ADD CONSTRAINT course_layout_pkey PRIMARY KEY (course_code);


--
-- Name: department department_department_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_department_name_key UNIQUE (department_name);


--
-- Name: department department_manager_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_manager_id_key UNIQUE (manager_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: employee_allocation employee_allocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_allocation
    ADD CONSTRAINT employee_allocation_pkey PRIMARY KEY (employment_id, planned_activity_id);


--
-- Name: employee employee_personal_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_personal_number_key UNIQUE (personal_number);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employment_id);


--
-- Name: employee_skill employee_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_skill
    ADD CONSTRAINT employee_skill_pkey PRIMARY KEY (employment_id, skill);


--
-- Name: job_title job_title_job_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT job_title_job_title_key UNIQUE (job_title);


--
-- Name: job_title job_title_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_title
    ADD CONSTRAINT job_title_pkey PRIMARY KEY (job_title_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (personal_number);


--
-- Name: planned_activity planned_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_pkey PRIMARY KEY (planned_activity_id);


--
-- Name: teaching_activity teaching_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaching_activity
    ADD CONSTRAINT teaching_activity_pkey PRIMARY KEY (activity_name);


--
-- Name: course_instance course_instance_course_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_instance
    ADD CONSTRAINT course_instance_course_code_fkey FOREIGN KEY (course_code) REFERENCES public.course_layout(course_code);


--
-- Name: department department_manager_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_manager_fk FOREIGN KEY (manager_id) REFERENCES public.employee(employment_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: employee_allocation employee_allocation_employment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_allocation
    ADD CONSTRAINT employee_allocation_employment_id_fkey FOREIGN KEY (employment_id) REFERENCES public.employee(employment_id);


--
-- Name: employee_allocation employee_allocation_planned_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_allocation
    ADD CONSTRAINT employee_allocation_planned_activity_id_fkey FOREIGN KEY (planned_activity_id) REFERENCES public.planned_activity(planned_activity_id);


--
-- Name: employee employee_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: employee employee_job_title_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_job_title_id_fkey FOREIGN KEY (job_title_id) REFERENCES public.job_title(job_title_id);


--
-- Name: employee employee_personal_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_personal_number_fkey FOREIGN KEY (personal_number) REFERENCES public.person(personal_number);


--
-- Name: employee_skill employee_skill_employment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_skill
    ADD CONSTRAINT employee_skill_employment_id_fkey FOREIGN KEY (employment_id) REFERENCES public.employee(employment_id);


--
-- Name: employee employee_supervisor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_supervisor_id_fkey FOREIGN KEY (supervisor_id) REFERENCES public.employee(employment_id);


--
-- Name: planned_activity planned_activity_activity_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_activity_name_fkey FOREIGN KEY (activity_name) REFERENCES public.teaching_activity(activity_name);


--
-- Name: planned_activity planned_activity_instance_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planned_activity
    ADD CONSTRAINT planned_activity_instance_id_fkey FOREIGN KEY (instance_id) REFERENCES public.course_instance(instance_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 82noiyjFOXrRe84Q13KZhk2jogePDDW8AwYhcmaxIctVK3JBL7PxAoajaUTrM1x

