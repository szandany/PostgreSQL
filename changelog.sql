-- liquibase formatted sql changeLogId:ef0c1e71-ea2c-4d37-962d-6c2d3b0795d5

--changeset SteveZ:45555-createtablecontacts
CREATE TABLE contacts (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255)
);
--rollback drop table contacts;

