--liquibase formatted sql changeLogId:a1d3b321-0935-46d6-98a7-408832548f89

--changeset SteveZ:45555-createtablecontacts context:"DEV,QA" labels:Jira123,Feature321
CREATE TABLE contacts (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255)
);
--rollback drop table contacts;

--changeset SteveZ:45556-createtableactor
CREATE TABLE actor (
	"name" varchar NULL
);
--rollback drop table actor;

--changeset MikeO:45556-altertableactor
ALTER TABLE actor
  ADD COLUMN twitter VARCHAR(15);
--rollback alter table actor drop column twitter;
 
--changeset AmyS:45678-createtablecolors
CREATE TABLE colors (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);
--rollback drop table colors;
 
--changeset BenG:45679-insertcolors
INSERT INTO colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  ('red', 'green'),
  ('red', 'blue'),
  ('green', 'red'),
  ('green', 'blue'),
  ('green', 'green'),
  ('blue', 'red'),
  ('blue', 'green'),
  ('blue', 'blue');
--rollback delete from colors where bcolor = 'red' and fcolor = 'red';
--rollback delete from colors where bcolor = 'red' and fcolor IS NULL;
--rollback delete from colors where bcolor IS NULL and fcolor = 'red';
--rollback delete from colors where bcolor = 'red' and fcolor = 'green';
--rollback delete from colors where bcolor = 'red' and fcolor = 'blue';
--rollback delete from colors where bcolor = 'green' and fcolor = 'red';
--rollback delete from colors where bcolor = 'green' and fcolor = 'blue';
--rollback delete from colors where bcolor = 'green' and fcolor = 'green';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'red';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'green';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'blue';

--changeset SteveZ:45679-createfunction_get_film_count splitStatements:false
create or replace function get_film_count(len_from int, len_to int)
returns int
language plpgsql
as
$$
declare
   film_count integer;
begin
   select count(*) 
   into film_count
   from film
   where length between len_from and len_to;
   
   return film_count;
end;
$$;
/
--rollback drop function get_film_count


--changeset SteveZ:45679-proc_empinfo splitStatements:false
CREATE OR REPLACE PROCEDURE insert_data(a integer, b integer)
LANGUAGE SQL
AS $$
INSERT INTO colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  ('red', 'green')
$$;
--rollback DROP PROCEDURE insert_data;

--changeset SteveZ:45679-createfunction_myFunction1 splitStatements:false
CREATE FUNCTION myFunction1(argument1 integer,argument2 integer)
 RETURNS integer AS $body$
BEGIN
  select count(*) from databasechangelog;
END;
$body$
language plpgsql;
--rollback DROP FUNCTION myFunction1

--changeset SteveZ:45679-createPackage_empinfo splitStatements:false
CREATE OR REPLACE PACKAGE empinfo
IS
    emp_name        VARCHAR2(10);
    PROCEDURE get_name (
        p_empno     NUMBER
    );
    FUNCTION display_counter
    RETURN INTEGER;
END;
--rollback DROP PACKAGE empinfo

--changeset SteveZ:45679-createPackageBody_empinfo endDelimiter:/ runOnChange:true
CREATE OR REPLACE PACKAGE BODY empinfo
IS
    v_counter       INTEGER;
    PROCEDURE get_name (
        p_empno     NUMBER
    )
    IS
    BEGIN
        SELECT ename INTO emp_name FROM emp WHERE empno = p_empno;
        v_counter := v_counter + 1;
    END;
    FUNCTION display_counter
    RETURN INTEGER
    IS
    BEGIN
        RETURN v_counter;
    END;
BEGIN
    v_counter := 0;
    DBMS_OUTPUT.PUT_LINE('Initialized counter');
END;
/
--rollback DROP PACKAGE BODY empinfo
