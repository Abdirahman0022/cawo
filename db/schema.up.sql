
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;



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


CREATE TABLE IF NOT EXISTS airports (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    iata_code text NOT NULL,
    -- Check if it is a valid airport iata code, e.g. TLV, LAX, etc.
    CHECK (iata_code ~ '\A[A-Z]{3}\Z'),
    icao_code text NOT NULL,
    -- Check if it is a valid airport icao code, e.g. LLBG, KLAX, etc.
    CHECK (icao_code ~ '\A[A-Z]{4}\Z'),
    airport_name text NOT NULL,
  --  subdivision_code text NOT NULL,
    -- Check if it is a valid ISO 3166-2 subdivision code, e.g. IL-M, US-CA, etc.
    --CHECK (subdivision_code ~ '\A[A-Z]{2}-[A-Z0-9]{1,3}\Z'),
    city text NOT NULL,
  -- we use below command if PostGIS is installed in our system 
    
  --  coordinates geography(point) NOT NULL,
  -- If PostGIS not installed this'll will work
   -- coordinates point NOT NULL,
   timezone text NOT NULL,
    UNIQUE (iata_code, icao_code)
);
/*
CREATE TABLE IF NOT EXISTS airports_data (
    iata_code VARCHAR(3) NOT NULL,
    airport_name text NOT NULL,
    city text NOT NULL,
    coordinates point NOT NULL,
    timezone text NOT NULL
);

*/
CREATE TABLE IF NOT EXISTS boarding_passes (
    ticket_no VARCHAR(13) NOT NULL,
    -- Check if it is a valid Ticketing and itinerary identifier eg 160-4837291830
    --CHECK (ticket_no ~ '\/^[0-9]{3}(-)?[0-9]{10}$/'),
    
    flight_id integer NOT NULL,
    -- Check if it is a valid IATA (marketing) flight number eg. 
   -- CHECK (flight_id ~ '/^([A-Z][\d]|[\d][A-Z]|[A-Z]{2})(\d{1,})$/'),
    boarding_no integer NOT NULL,
    seat_no VARCHAR(4) NOT NULL
);



  COMMENT  ON TABLE boarding_passes IS 'Boarding passes';



  COMMENT  ON COLUMN boarding_passes.ticket_no IS 'Ticket number';



  COMMENT  ON COLUMN boarding_passes.flight_id IS 'Flight ID';



  COMMENT  ON COLUMN boarding_passes.boarding_no IS 'Boarding pass number';



  COMMENT  ON COLUMN boarding_passes.seat_no IS 'Seat number';

CREATE TABLE IF NOT EXISTS bookings (
    book_ref VARCHAR(6) NOT NULL,
    book_date timestamp with time zone NOT NULL,
    total_amount numeric(10,2) NOT NULL
);

  COMMENT  ON TABLE bookings IS 'Bookings';

  COMMENT  ON COLUMN bookings.book_ref IS 'Booking number';

  COMMENT  ON COLUMN bookings.book_date IS 'Booking date';

  COMMENT  ON COLUMN bookings.total_amount IS 'Total booking cost';

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
  WHERE ((f.departure_airport = dep.iata_code) AND (f.arrival_airport = arr.iata_code));



  COMMENT  ON VIEW flights_v IS 'Flights (extended)';



  COMMENT  ON COLUMN flights_v.flight_id IS 'Flight ID';


  COMMENT  ON COLUMN flights_v.flight_no IS 'Flight number';



  COMMENT  ON COLUMN flights_v.scheduled_departure IS 'Scheduled departure time';



  COMMENT  ON COLUMN flights_v.scheduled_departure_local IS 'Scheduled departure time, local time at the point of departure';



  COMMENT  ON COLUMN flights_v.scheduled_arrival IS 'Scheduled arrival time';



  COMMENT  ON COLUMN flights_v.scheduled_arrival_local IS 'Scheduled arrival time, local time at the point of destination';



  COMMENT  ON COLUMN flights_v.scheduled_duration IS 'Scheduled flight duration';



  COMMENT  ON COLUMN flights_v.departure_airport IS 'Deprature airport code';



  COMMENT  ON COLUMN flights_v.departure_airport_name IS 'Departure airport name';



  COMMENT  ON COLUMN flights_v.departure_city IS 'City of departure';



  COMMENT  ON COLUMN flights_v.arrival_airport IS 'Arrival airport code';



  COMMENT  ON COLUMN flights_v.arrival_airport_name IS 'Arrival airport name';



  COMMENT  ON COLUMN flights_v.arrival_city IS 'City of arrival';



  COMMENT  ON COLUMN flights_v.status IS 'Flight status';



  COMMENT  ON COLUMN flights_v.aircraft_id IS 'Aircraft code, IATA';



  COMMENT  ON COLUMN flights_v.actual_departure IS 'Actual departure time';



  COMMENT  ON COLUMN flights_v.actual_departure_local IS 'Actual departure time, local time at the point of departure';



  COMMENT  ON COLUMN flights_v.actual_arrival IS 'Actual arrival time';



  COMMENT  ON COLUMN flights_v.actual_arrival_local IS 'Actual arrival time, local time at the point of destination';



  COMMENT  ON COLUMN flights_v.actual_duration IS 'Actual flight duration';



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
  WHERE ((f3.departure_airport = dep.iata_code) AND (f3.arrival_airport = arr.iata_code));



  COMMENT  ON VIEW routes IS 'Routes';



  COMMENT  ON COLUMN routes.flight_no IS 'Flight number';



  COMMENT  ON COLUMN routes.departure_airport IS 'Code of airport of departure';



  COMMENT  ON COLUMN routes.departure_airport_name IS 'Name of airport of departure';



  COMMENT  ON COLUMN routes.departure_city IS 'City of departure';



  COMMENT  ON COLUMN routes.arrival_airport IS 'Code of airport of arrival';



  COMMENT  ON COLUMN routes.arrival_airport_name IS 'Name of airport of arrival';



  COMMENT  ON COLUMN routes.arrival_city IS 'City of arrival';



  COMMENT  ON COLUMN routes.aircraft_id IS 'Aircraft code, IATA';



  COMMENT  ON COLUMN routes.duration IS 'Scheduled duration of flight';



  COMMENT  ON COLUMN routes.days_of_week IS 'Days of week on which flights are scheduled';



CREATE TABLE IF NOT EXISTS seats (
    aircraft_id BIGSERIAL NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    CONSTRAINT seats_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::VARCHAR)::text, ('Comfort'::VARCHAR)::text, ('Business'::VARCHAR)::text])))
);




  COMMENT  ON COLUMN seats.aircraft_id IS 'Aircraft code, IATA';



  COMMENT  ON COLUMN seats.seat_no IS 'Seat number';



  COMMENT  ON COLUMN seats.fare_conditions IS 'Travel class';



CREATE TABLE IF NOT EXISTS ticket_flights (
    ticket_no VARCHAR(13) NOT NULL,
    flight_id integer NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    amount numeric(10,2) NOT NULL,
    CONSTRAINT ticket_flights_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT ticket_flights_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::VARCHAR)::text, ('Comfort'::VARCHAR)::text, ('Business'::VARCHAR)::text])))
);



  COMMENT  ON TABLE ticket_flights IS 'Flight segment';



  COMMENT  ON COLUMN ticket_flights.ticket_no IS 'Ticket number';



  COMMENT  ON COLUMN ticket_flights.flight_id IS 'Flight ID';



  COMMENT  ON COLUMN ticket_flights.fare_conditions IS 'Travel class';



  COMMENT  ON COLUMN ticket_flights.amount IS 'Travel cost';



CREATE TABLE IF NOT EXISTS tickets (
    ticket_no VARCHAR(13) NOT NULL,
    book_ref VARCHAR(6) NOT NULL,
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name text NOT NULL,
    contact_data jsonb NOT NULL
);



  COMMENT  ON TABLE tickets IS 'Tickets';



  COMMENT  ON COLUMN tickets.ticket_no IS 'Ticket number';



  COMMENT  ON COLUMN tickets.book_ref IS 'Booking number';



  COMMENT  ON COLUMN tickets.passenger_id IS 'Passenger ID';



  COMMENT  ON COLUMN tickets.passenger_name IS 'Passenger name';



  COMMENT  ON COLUMN tickets.contact_data IS 'Passenger contact information';



ALTER TABLE ONLY flights ALTER COLUMN flight_id SET DEFAULT nextval('flights_flight_id_seq'::regclass);





--ALTER TABLE ONLY aircrafts
    --ADD CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_id);



--ALTER TABLE ONLY airports  ADD CONSTRAINT airports_pkey PRIMARY KEY (iata_code);



ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_boarding_no_key UNIQUE (flight_id, boarding_no);



ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_seat_no_key UNIQUE (flight_id, seat_no);



ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_pkey PRIMARY KEY (ticket_no, flight_id);



ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (book_ref);


/*ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_flight_no_scheduled_departure_key UNIQUE (flight_no, scheduled_departure);
*/


ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);



ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (aircraft_id, seat_no);



ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_pkey PRIMARY KEY (ticket_no, flight_id);



ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_no);



ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_ticket_no_fkey FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id);



ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_aircraft_id_fkey FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id);



-- ALTER TABLE ONLY flights ADD CONSTRAINT flights_arrival_airport_fkey FOREIGN KEY (arrival_airport) REFERENCES airports(iata_code);



-- ALTER TABLE ONLY flights ADD CONSTRAINT flights_departure_airport_fkey FOREIGN KEY (departure_airport) REFERENCES airports(iata_code);

-- ALTER TABLE ONLY airlines ADD CONSTRAINT airlines_main_airport_fkey FOREIGN KEY (main_airport) REFERENCES airports(iata_code);


ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_aircraft_id_fkey FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id) ON DELETE CASCADE;



ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES flights(flight_id);



ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_ticket_no_fkey FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no);



ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_book_ref_fkey FOREIGN KEY (book_ref) REFERENCES bookings(book_ref);


ALTER TABLE ONLY flights
   ADD CONSTRAINT airline_co_fk FOREIGN KEY (company_id) REFERENCES airlines (id);
  
/*--
  ALTER DATABASE postgres SET search_path = bookings, public;


ALTER DATABASE flightBookings SET search_path = bookings, public;
ALTER DATABASE flightBookings SET bookings.lang = en;
DROP TABLE IF EXISTS airlines CASCADE;
DROP TABLE IF EXISTS aircrafts CASCADE;
DROP VIEW IF EXISTS aircrafts CASCADE;
DROP SEQUENCE IF EXISTS airlines_id_seq CASCADE;
DROP TABLE IF EXISTS airports CASCADE;
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
