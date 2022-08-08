
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

--  COMMENT  ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--SET search_path = bookings, pg_catalog;

--
-- Name: lang(); Type: FUNCTION; Schema: bookings; Owner: -
--

CREATE FUNCTION lang() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
  RETURN current_setting('bookings.lang');
EXCEPTION
  WHEN undefined_object THEN
    RETURN NULL;
END;
$$;


CREATE FUNCTION now() RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '2021-10-05 18:00:00'::TIMESTAMP AT TIME ZONE 'Africa/Mogadishu';$$;


CREATE TABLE IF NOT EXISTS airlines (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    iata_code VARCHAR(5) NOT NULL,
    main_airport VARCHAR(3) NOT NULL,
    created_at timestamptz NOT NULL DEFAULT (now())
 -- account numeric NOT NULL,
 --   CONSTRAINT airlines_pk PRIMARY KEY (id)
  );


CREATE SEQUENCE IF NOT EXISTS airlines_id_seq
    START WITH 4001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE airlines_id_seq OWNED BY airlines.id;
  
  CREATE TABLE aircrafts (
   -- id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
     id BIGSERIAL PRIMARY KEY NOT NULL,
    icao_code text NOT NULL,
    -- Check if it is a valid aircraft icao code, e.g. A5, B487, etc.
    CHECK (icao_code ~ '\A[A-Z0-9]{2,4}\Z'),
    iata_code text NOT NULL,
    -- Check if it is a valid aircraft iata code, e.g. A4F, 313, etc.
    CHECK (iata_code ~ '\A[A-Z0-9]{3}\Z'),
    name text NOT NULL,
    UNIQUE (icao_code, iata_code)
);
  
/*CREATE TABLE IF NOT EXISTS aircraft_model (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    aircraft_code VARCHAR(3) NOT NULL,
    model jsonb NOT NULL,
    range integer NOT NULL,
    company_id BIGSERIAL NOT NULL,
    CONSTRAINT aircrafts_range_check CHECK ((range > 0)),
   -- CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_code),
    CONSTRAINT airlines_pk FOREIGN KEY (company_id) REFERENCES airlines (id)
);
*/




--CREATE VIEW aircrafts AS
 --SELECT ml.aircraft_id,
--    ml.model AS model,
 --   ml.range
 --  FROM aircrafts ml;



CREATE TABLE IF NOT EXISTS airports_data (
    airport_code VARCHAR(3) NOT NULL,
    airport_name text NOT NULL,
    city text NOT NULL,
    coordinates point NOT NULL,
    timezone text NOT NULL
);




CREATE VIEW airports AS
 SELECT ml.airport_code,
    ml.airport_name AS airport_name,
    ml.city AS city,
    ml.coordinates,
    ml.timezone
   FROM airports_data ml;




CREATE TABLE IF NOT EXISTS boarding_passes (
    ticket_no VARCHAR(13) NOT NULL,
    flight_id integer NOT NULL,
    boarding_no integer NOT NULL,
    seat_no VARCHAR(4) NOT NULL
);


--
-- Name: TABLE boarding_passes; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON TABLE boarding_passes IS 'Boarding passes';


--
-- Name: COLUMN boarding_passes.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN boarding_passes.ticket_no IS 'Ticket number';


--
-- Name: COLUMN boarding_passes.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN boarding_passes.flight_id IS 'Flight ID';


--
-- Name: COLUMN boarding_passes.boarding_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN boarding_passes.boarding_no IS 'Boarding pass number';


--
-- Name: COLUMN boarding_passes.seat_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN boarding_passes.seat_no IS 'Seat number';


--
-- Name: bookings; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE IF NOT EXISTS bookings (
    book_ref VARCHAR(6) NOT NULL,
    book_date timestamp with time zone NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


--
-- Name: TABLE bookings; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON TABLE bookings IS 'Bookings';


--
-- Name: COLUMN bookings.book_ref; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN bookings.book_ref IS 'Booking number';


--
-- Name: COLUMN bookings.book_date; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN bookings.book_date IS 'Booking date';


--
-- Name: COLUMN bookings.total_amount; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN bookings.total_amount IS 'Total booking cost';


--
-- Name: flights; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE IF NOT EXISTS flights (
    flight_id integer NOT NULL,
    flight_no VARCHAR(6) NOT NULL,
    company_id BIGSERIAL NOT NULL,
    scheduled_departure timestamp with time zone NOT NULL,
    scheduled_arrival timestamp with time zone NOT NULL,
    departure_airport VARCHAR(3) NOT NULL,
    arrival_airport VARCHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    aircraft_id BIGSERIAL NOT NULL,
    actual_departure timestamp with time zone,
    actual_arrival timestamp with time zone,
    
    CONSTRAINT flights_check CHECK ((scheduled_arrival > scheduled_departure)),
    
    CONSTRAINT flights_flight_no_scheduled_departure_key UNIQUE (flight_no, scheduled_departure),
    
    CONSTRAINT flights_check_airlines_key UNIQUE (flight_id, company_id),
    
    CONSTRAINT flights_check1 CHECK (((actual_arrival IS NULL) OR ((actual_departure IS NOT NULL) AND (actual_arrival IS NOT NULL) AND (actual_arrival > actual_departure)))),
    
    CONSTRAINT flights_status_check CHECK (((status)::text = ANY (ARRAY[('On Time'::VARCHAR)::text, ('Delayed'::VARCHAR)::text, ('Departed'::VARCHAR)::text, ('Arrived'::VARCHAR)::text, ('Scheduled'::VARCHAR)::text, ('Cancelled'::VARCHAR)::text])))
);


CREATE SEQUENCE IF NOT EXISTS flights_flight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE flights_flight_id_seq OWNED BY flights.flight_id;


CREATE VIEW flights_v AS
 SELECT f.flight_id,
    f.flight_no,
    f.company_id,
    f.scheduled_departure,
    timezone(dep.timezone, f.scheduled_departure) AS scheduled_departure_local,
    f.scheduled_arrival,
    timezone(arr.timezone, f.scheduled_arrival) AS scheduled_arrival_local,
    (f.scheduled_arrival - f.scheduled_departure) AS scheduled_duration,
    f.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f.status,
    f.aircraft_id,
    f.actual_departure,
    timezone(dep.timezone, f.actual_departure) AS actual_departure_local,
    f.actual_arrival,
    timezone(arr.timezone, f.actual_arrival) AS actual_arrival_local,
    (f.actual_arrival - f.actual_departure) AS actual_duration
   FROM flights f,
    airports dep,
    airports arr
  WHERE ((f.departure_airport = dep.airport_code) AND (f.arrival_airport = arr.airport_code));


--
-- Name: VIEW flights_v; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON VIEW flights_v IS 'Flights (extended)';


--
-- Name: COLUMN flights_v.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.flight_id IS 'Flight ID';


--
-- Name: COLUMN flights_v.flight_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.flight_no IS 'Flight number';


--
-- Name: COLUMN flights_v.scheduled_departure; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.scheduled_departure IS 'Scheduled departure time';


--
-- Name: COLUMN flights_v.scheduled_departure_local; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.scheduled_departure_local IS 'Scheduled departure time, local time at the point of departure';


--
-- Name: COLUMN flights_v.scheduled_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.scheduled_arrival IS 'Scheduled arrival time';


--
-- Name: COLUMN flights_v.scheduled_arrival_local; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.scheduled_arrival_local IS 'Scheduled arrival time, local time at the point of destination';


--
-- Name: COLUMN flights_v.scheduled_duration; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.scheduled_duration IS 'Scheduled flight duration';


--
-- Name: COLUMN flights_v.departure_airport; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.departure_airport IS 'Deprature airport code';


--
-- Name: COLUMN flights_v.departure_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.departure_airport_name IS 'Departure airport name';


--
-- Name: COLUMN flights_v.departure_city; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.departure_city IS 'City of departure';


--
-- Name: COLUMN flights_v.arrival_airport; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.arrival_airport IS 'Arrival airport code';


--
-- Name: COLUMN flights_v.arrival_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.arrival_airport_name IS 'Arrival airport name';


--
-- Name: COLUMN flights_v.arrival_city; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.arrival_city IS 'City of arrival';


--
-- Name: COLUMN flights_v.status; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.status IS 'Flight status';


--
-- Name: COLUMN flights_v.aircraft_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.aircraft_id IS 'Aircraft code, IATA';


--
-- Name: COLUMN flights_v.actual_departure; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.actual_departure IS 'Actual departure time';


--
-- Name: COLUMN flights_v.actual_departure_local; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.actual_departure_local IS 'Actual departure time, local time at the point of departure';


--
-- Name: COLUMN flights_v.actual_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.actual_arrival IS 'Actual arrival time';


--
-- Name: COLUMN flights_v.actual_arrival_local; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.actual_arrival_local IS 'Actual arrival time, local time at the point of destination';


--
-- Name: COLUMN flights_v.actual_duration; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN flights_v.actual_duration IS 'Actual flight duration';


--
-- Name: routes; Type: VIEW; Schema: bookings; Owner: -
--

CREATE VIEW routes AS
 WITH f3 AS (
         SELECT f2.flight_no,
            f2.company_id,
            f2.departure_airport,
            f2.arrival_airport,
            f2.aircraft_id,
            f2.duration,
            array_agg(f2.days_of_week) AS days_of_week
           FROM ( SELECT f1.flight_no,
                    f1.company_id,
                    f1.departure_airport,
                    f1.arrival_airport,
                    f1.aircraft_id,
                    f1.duration,
                    f1.days_of_week
                   FROM ( SELECT flights.flight_no,
                   flights.company_id,
                            flights.departure_airport,
                            flights.arrival_airport,
                            flights.aircraft_id,
                            (flights.scheduled_arrival - flights.scheduled_departure) AS duration,
                            (to_char(flights.scheduled_departure, 'ID'::text))::integer AS days_of_week
                           FROM flights) f1
                  GROUP BY f1.flight_no, f1.company_id, f1.departure_airport, f1.arrival_airport, f1.aircraft_id, f1.duration, f1.days_of_week
                  ORDER BY f1.flight_no, f1.company_id, f1.departure_airport, f1.arrival_airport, f1.aircraft_id, f1.duration, f1.days_of_week) f2
          GROUP BY f2.flight_no,
          f2.company_id, f2.departure_airport, f2.arrival_airport, f2.aircraft_id, f2.duration
        )
 SELECT f3.flight_no,
    f3.company_id,
    f3.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f3.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f3.aircraft_id,
    f3.duration,
    f3.days_of_week
   FROM f3,
    airports dep,
    airports arr
  WHERE ((f3.departure_airport = dep.airport_code) AND (f3.arrival_airport = arr.airport_code));


--
-- Name: VIEW routes; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON VIEW routes IS 'Routes';


--
-- Name: COLUMN routes.flight_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.flight_no IS 'Flight number';


--
-- Name: COLUMN routes.departure_airport; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.departure_airport IS 'Code of airport of departure';


--
-- Name: COLUMN routes.departure_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.departure_airport_name IS 'Name of airport of departure';


--
-- Name: COLUMN routes.departure_city; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.departure_city IS 'City of departure';


--
-- Name: COLUMN routes.arrival_airport; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.arrival_airport IS 'Code of airport of arrival';


--
-- Name: COLUMN routes.arrival_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.arrival_airport_name IS 'Name of airport of arrival';


--
-- Name: COLUMN routes.arrival_city; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.arrival_city IS 'City of arrival';


--
-- Name: COLUMN routes.aircraft_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.aircraft_id IS 'Aircraft code, IATA';


--
-- Name: COLUMN routes.duration; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.duration IS 'Scheduled duration of flight';


--
-- Name: COLUMN routes.days_of_week; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN routes.days_of_week IS 'Days of week on which flights are scheduled';


--
-- Name: seats; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE IF NOT EXISTS seats (
    aircraft_id BIGSERIAL NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    CONSTRAINT seats_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::VARCHAR)::text, ('Comfort'::VARCHAR)::text, ('Business'::VARCHAR)::text])))
);


--
-- Name: TABLE seats; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON TABLE seats IS 'Seats';


--
-- Name: COLUMN seats.aircraft_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN seats.aircraft_id IS 'Aircraft code, IATA';


--
-- Name: COLUMN seats.seat_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN seats.seat_no IS 'Seat number';


--
-- Name: COLUMN seats.fare_conditions; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN seats.fare_conditions IS 'Travel class';


--
-- Name: ticket_flights; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE IF NOT EXISTS ticket_flights (
    ticket_no VARCHAR(13) NOT NULL,
    flight_id integer NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    amount numeric(10,2) NOT NULL,
    CONSTRAINT ticket_flights_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT ticket_flights_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::VARCHAR)::text, ('Comfort'::VARCHAR)::text, ('Business'::VARCHAR)::text])))
);


--
-- Name: TABLE ticket_flights; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON TABLE ticket_flights IS 'Flight segment';


--
-- Name: COLUMN ticket_flights.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN ticket_flights.ticket_no IS 'Ticket number';


--
-- Name: COLUMN ticket_flights.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN ticket_flights.flight_id IS 'Flight ID';


--
-- Name: COLUMN ticket_flights.fare_conditions; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN ticket_flights.fare_conditions IS 'Travel class';


--
-- Name: COLUMN ticket_flights.amount; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN ticket_flights.amount IS 'Travel cost';


--
-- Name: tickets; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE IF NOT EXISTS tickets (
    ticket_no VARCHAR(13) NOT NULL,
    book_ref VARCHAR(6) NOT NULL,
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name text NOT NULL,
    contact_data jsonb NOT NULL
);


--
-- Name: TABLE tickets; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON TABLE tickets IS 'Tickets';


--
-- Name: COLUMN tickets.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN tickets.ticket_no IS 'Ticket number';


--
-- Name: COLUMN tickets.book_ref; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN tickets.book_ref IS 'Booking number';


--
-- Name: COLUMN tickets.passenger_id; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN tickets.passenger_id IS 'Passenger ID';


--
-- Name: COLUMN tickets.passenger_name; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN tickets.passenger_name IS 'Passenger name';


--
-- Name: COLUMN tickets.contact_data; Type: COMMENT; Schema: bookings; Owner: -
--

  COMMENT  ON COLUMN tickets.contact_data IS 'Passenger contact information';


--
-- Name: flights flight_id; Type: DEFAULT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights ALTER COLUMN flight_id SET DEFAULT nextval('flights_flight_id_seq'::regclass);


--
-- Data for Name: aircrafts; Type: TABLE DATA; Schema: bookings; Owner: -
--
--
-- Data for Name: aircrafts; Type: TABLE DATA; Schema: bookings; Owner: -
--


--
-- Name: aircrafts aircrafts_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

--ALTER TABLE ONLY aircrafts
    --ADD CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_id);


--
-- Name: airports_data airports_data_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY airports_data
    ADD CONSTRAINT airports_data_pkey PRIMARY KEY (airport_code);


--
-- Name: boarding_passes boarding_passes_flight_id_boarding_no_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_boarding_no_key UNIQUE (flight_id, boarding_no);


--
-- Name: boarding_passes boarding_passes_flight_id_seat_no_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_seat_no_key UNIQUE (flight_id, seat_no);


--
-- Name: boarding_passes boarding_passes_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_pkey PRIMARY KEY (ticket_no, flight_id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (book_ref);


/*ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_flight_no_scheduled_departure_key UNIQUE (flight_no, scheduled_departure);
*/
--
-- Name: flights flights_flight_no_scheduled_departure_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);


--
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (aircraft_id, seat_no);


--
-- Name: ticket_flights ticket_flights_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_pkey PRIMARY KEY (ticket_no, flight_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_no);


--
-- Name: boarding_passes boarding_passes_ticket_no_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_ticket_no_fkey FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id);


--
-- Name: flights flights_aircraft_id_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_aircraft_id_fkey FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id);


--
-- Name: flights flights_arrival_airport_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_arrival_airport_fkey FOREIGN KEY (arrival_airport) REFERENCES airports_data(airport_code);


--
-- Name: flights flights_departure_airport_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_departure_airport_fkey FOREIGN KEY (departure_airport) REFERENCES airports_data(airport_code);

ALTER TABLE ONLY airlines
    ADD CONSTRAINT airlines_main_airport_fkey FOREIGN KEY (main_airport) REFERENCES airports_data(airport_code);

--
-- Name: seats seats_aircraft_id_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_aircraft_id_fkey FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id) ON DELETE CASCADE;


--
-- Name: ticket_flights ticket_flights_flight_id_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES flights(flight_id);


--
-- Name: ticket_flights ticket_flights_ticket_no_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_ticket_no_fkey FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no);


--
-- Name: tickets tickets_book_ref_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_book_ref_fkey FOREIGN KEY (book_ref) REFERENCES bookings(book_ref);

ALTER TABLE ONLY airlines
   ADD CONSTRAINT airports_airline_co_fk FOREIGN KEY (main_airport) REFERENCES airports_data (airport_code);



ALTER TABLE ONLY flights
   ADD CONSTRAINT airline_co_fk FOREIGN KEY (company_id) REFERENCES airlines (id);
  
  

/*--

ALTER DATABASE flightBookings SET search_path = bookings, public;
ALTER DATABASE flightBookings SET bookings.lang = en;
DROP TABLE IF EXISTS airlines CASCADE;
DROP TABLE IF EXISTS aircrafts CASCADE;
DROP VIEW IF EXISTS aircrafts CASCADE;
DROP SEQUENCE IF EXISTS airlines_id_seq CASCADE;
DROP TABLE IF EXISTS airports_data CASCADE;
DROP VIEW IF EXISTS airports CASCADE;
DROP TABLE IF EXISTS boarding_passes CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS flights CASCADE;
DROP SEQUENCE IF EXISTS flights_flight_id_seq CASCADE;
DROP VIEW IF EXISTS flights_v CASCADE;
DROP VIEW IF EXISTS routes CASCADE;
DROP TABLE IF EXISTS seats CASCADE;
DROP TABLE IF EXISTS ticket_flights CASCADE;
DROP TABLE IF EXISTS tickets CASCADE;


*/