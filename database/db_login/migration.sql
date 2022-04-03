CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- public.tbl_roles definition

-- Drop table

-- DROP TABLE tbl_roles;

CREATE TABLE tbl_roles (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	"name" varchar(64) NOT NULL,
	"version" int4 NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT code_role_bk UNIQUE (code),
	CONSTRAINT role_pk PRIMARY KEY (id)
);


-- public.tbl_users definition

-- Drop table

-- DROP TABLE tbl_users;

CREATE TABLE tbl_users (
	id text NOT NULL DEFAULT uuid_generate_v4(),
	id_role varchar(36) NOT NULL,
	username varchar(32) NOT NULL,
	"password" text NOT NULL,
	"version" int4 NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT user_pk PRIMARY KEY (id),
	CONSTRAINT users_bk UNIQUE (username),
	CONSTRAINT role_fk FOREIGN KEY (id_role) REFERENCES tbl_roles(id)
);

INSERT INTO tbl_roles (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('6603cfc2-f74b-4a19-868f-fe4f03a88ef0', 'ADM', 'Admin', 0, 'system', '2022-03-31 22:16:03.970', NULL, NULL, true);
INSERT INTO tbl_users (id, id_role, username, "password", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('2ea0c231-638f-4aa0-8efe-eb2d5adc7a88', '6603cfc2-f74b-4a19-868f-fe4f03a88ef0', 'admin', '$2a$10$6D4OUJIlfuiceaRzyJqzB.7qcvt8ZREA1ofnJlJ2tmH2etApgQLOe', 0, 'system', '2022-03-31 22:21:00.132', NULL, NULL, true);

