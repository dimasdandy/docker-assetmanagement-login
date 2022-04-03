CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- public.tbl_companies definition

-- Drop table

-- DROP TABLE tbl_companies;

CREATE TABLE tbl_companies (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	"name" varchar(64) NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT company_bk UNIQUE (code),
	CONSTRAINT company_pk PRIMARY KEY (id)
);


-- public.tbl_invoices definition

-- Drop table

-- DROP TABLE tbl_invoices;

CREATE TABLE tbl_invoices (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	invoice_date date NOT NULL,
	total_price numeric NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT invoice_bk UNIQUE (code),
	CONSTRAINT invoice_pk PRIMARY KEY (id)
);


-- public.tbl_item_types definition

-- Drop table

-- DROP TABLE tbl_item_types;

CREATE TABLE tbl_item_types (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	"name" varchar(32) NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT item_type_bk UNIQUE (code),
	CONSTRAINT item_type_pk PRIMARY KEY (id)
);


-- public.tbl_status_assets definition

-- Drop table

-- DROP TABLE tbl_status_assets;

CREATE TABLE tbl_status_assets (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	"name" varchar(32) NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT status_asset_bk UNIQUE (code),
	CONSTRAINT status_asset_pk PRIMARY KEY (id)
);


-- public.tbl_asset_condition definition

-- Drop table

-- DROP TABLE tbl_asset_condition;

CREATE TABLE tbl_asset_condition (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	id_status_asset varchar(36) NOT NULL,
	"name" varchar(32) NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT condition_asset_bk UNIQUE (code),
	CONSTRAINT condition_asset_pk PRIMARY KEY (id),
	CONSTRAINT status_asset_fk FOREIGN KEY (id_status_asset) REFERENCES tbl_status_assets(id)
);


-- public.tbl_employees definition

-- Drop table

-- DROP TABLE tbl_employees;

CREATE TABLE tbl_employees (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	id_company varchar(36) NOT NULL,
	nip varchar(32) NOT NULL,
	email varchar(32) NOT NULL,
	full_name varchar(64) NOT NULL,
	phone_no varchar(13) NOT NULL,
	department varchar(32) NOT NULL,
	"version" int4 NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT email_bk UNIQUE (email),
	CONSTRAINT employee_pk PRIMARY KEY (id),
	CONSTRAINT company_fk FOREIGN KEY (id_company) REFERENCES tbl_companies(id)
);


-- public.tbl_items definition

-- Drop table

-- DROP TABLE tbl_items;

CREATE TABLE tbl_items (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	id_item_type varchar(36) NOT NULL,
	description varchar(32) NOT NULL,
	brand varchar(32) NOT NULL,
	serial varchar(32) NULL,
	price numeric NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT item_pk PRIMARY KEY (id),
	CONSTRAINT item_type_fk FOREIGN KEY (id_item_type) REFERENCES tbl_item_types(id)
);


-- public.tbl_transactions_out definition

-- Drop table

-- DROP TABLE tbl_transactions_out;

CREATE TABLE tbl_transactions_out (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	id_employee varchar(36) NULL,
	check_out_date date NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT code_transaction_out_bk UNIQUE (code),
	CONSTRAINT transaction_out_pk PRIMARY KEY (id),
	CONSTRAINT employee_fk FOREIGN KEY (id_employee) REFERENCES tbl_employees(id)
);


-- public.tbl_assets definition

-- Drop table

-- DROP TABLE tbl_assets;

CREATE TABLE tbl_assets (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	id_item varchar(36) NOT NULL,
	id_status_asset varchar(36) NOT NULL,
	id_company varchar(36) NOT NULL,
	id_invoice varchar(36) NOT NULL,
	expired_date date NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT asset_bk UNIQUE (code),
	CONSTRAINT asset_pk PRIMARY KEY (id),
	CONSTRAINT company_fk FOREIGN KEY (id_company) REFERENCES tbl_companies(id),
	CONSTRAINT invoice_fk FOREIGN KEY (id_invoice) REFERENCES tbl_invoices(id),
	CONSTRAINT item_fk FOREIGN KEY (id_item) REFERENCES tbl_items(id),
	CONSTRAINT status_asset_fk FOREIGN KEY (id_status_asset) REFERENCES tbl_status_assets(id)
);


-- public.tbl_detail_transactions_out definition

-- Drop table

-- DROP TABLE tbl_detail_transactions_out;

CREATE TABLE tbl_detail_transactions_out (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	id_transaction_out varchar(36) NOT NULL,
	id_asset varchar(36) NOT NULL,
	due_date date NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT detail_transactiom_out_pk PRIMARY KEY (id),
	CONSTRAINT asset_fk FOREIGN KEY (id_asset) REFERENCES tbl_assets(id),
	CONSTRAINT transaction_out_fk FOREIGN KEY (id_transaction_out) REFERENCES tbl_transactions_out(id)
);


-- public.tbl_transactions_in definition

-- Drop table

-- DROP TABLE tbl_transactions_in;

CREATE TABLE tbl_transactions_in (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	code varchar(32) NOT NULL,
	id_transaction_out varchar(36) NOT NULL,
	check_in_date date NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT transaction_in_bk UNIQUE (code),
	CONSTRAINT transaction_in_pk PRIMARY KEY (id),
	CONSTRAINT transaction_out_fk FOREIGN KEY (id_transaction_out) REFERENCES tbl_transactions_out(id)
);


-- public.tbl_detail_transactions_in definition

-- Drop table

-- DROP TABLE tbl_detail_transactions_in;

CREATE TABLE tbl_detail_transactions_in (
	id varchar(36) NOT NULL DEFAULT uuid_generate_v4(),
	id_transaction_in varchar(36) NOT NULL,
	id_asset varchar(36) NOT NULL,
	id_asset_condition varchar(36) NOT NULL,
	"version" int4 NOT NULL,
	created_by varchar(36) NOT NULL,
	created_date timestamp NOT NULL,
	updated_by varchar(36) NULL,
	updated_date timestamp NULL,
	is_active bool NOT NULL,
	CONSTRAINT detail_transaction_in_pk PRIMARY KEY (id),
	CONSTRAINT asset_fk FOREIGN KEY (id_asset) REFERENCES tbl_assets(id),
	CONSTRAINT condition_asset_fk FOREIGN KEY (id_asset_condition) REFERENCES tbl_asset_condition(id),
	CONSTRAINT transaction_in_fk FOREIGN KEY (id_transaction_in) REFERENCES tbl_transactions_in(id)
);

INSERT INTO tbl_asset_condition (id, code, id_status_asset, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('2a46411d-fa27-48cd-8d6b-2cdb078d1dfb', 'CA1', '37f85890-256c-4a35-9c70-d3210c14dc7f', 'Ready to Deploy', 0, 'system', '2022-04-01 11:37:06.732', NULL, NULL, true);
INSERT INTO tbl_asset_condition (id, code, id_status_asset, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('55441ccb-6011-4d12-83e7-85c4bde3b45c', 'CA2', '84d7d8b3-5284-4312-b190-d0538570433b', 'Broken', 0, 'system', '2022-04-01 11:37:06.732', NULL, NULL, true);
INSERT INTO tbl_asset_condition (id, code, id_status_asset, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('b840e4fc-3610-47f2-b297-c7e16e45e634', 'CA3', '84d7d8b3-5284-4312-b190-d0538570433b', 'On Repair', 0, 'system', '2022-04-01 11:37:06.732', NULL, NULL, true);
INSERT INTO tbl_asset_condition (id, code, id_status_asset, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('fc6f6085-4b1b-4bf9-90a2-ae9e0e24afae', 'CA4', 'c674062f-4e90-4aac-a610-3c0f58fdbd71', 'Lost/Stolen', 0, 'system', '2022-04-01 11:37:06.732', NULL, NULL, true);

INSERT INTO tbl_assets (id, code, id_item, id_status_asset, id_company, id_invoice, expired_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('21f2f32b-5eaa-40b6-b8b0-1556b43b2c8e', 'LSC1', '55927ac1-1d90-4289-90d1-a80549819496', '37f85890-256c-4a35-9c70-d3210c14dc7f', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', 'f1e3cfd8-521d-4b34-b22d-86912ae77c09', '2022-04-30', 0, 'system', '2022-04-01 11:35:38.582', NULL, NULL, true);
INSERT INTO tbl_assets (id, code, id_item, id_status_asset, id_company, id_invoice, expired_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('0f08a467-1fc6-49a8-bf2e-2e7b5d68bc8c', 'HDD2', 'd988e9d3-4b3d-4faa-8a27-a667e24bd1a8', '37f85890-256c-4a35-9c70-d3210c14dc7f', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '235855cd-41fb-41c5-90ee-3ac0e15b4cf3', NULL, 0, 'system', '2022-04-01 11:33:35.209', NULL, NULL, true);
INSERT INTO tbl_assets (id, code, id_item, id_status_asset, id_company, id_invoice, expired_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('1eac06dc-c5e9-446b-a45f-c813d01e2374', 'LPT1', '7be68358-c48d-493b-9082-b50765773928', '37f85890-256c-4a35-9c70-d3210c14dc7f', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '34b3b0b2-b9ee-4374-8034-572fab7ab7a3', NULL, 0, 'system', '2022-04-01 11:33:35.209', NULL, NULL, true);
INSERT INTO tbl_assets (id, code, id_item, id_status_asset, id_company, id_invoice, expired_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('0177fdb6-8a4c-4eaf-bacd-ef4ddae908ca', 'HDD1', 'ebb66774-60a8-4326-b267-93d85acea918', '37f85890-256c-4a35-9c70-d3210c14dc7f', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '235855cd-41fb-41c5-90ee-3ac0e15b4cf3', NULL, 0, 'system', '2022-04-01 11:33:35.209', NULL, NULL, true);

INSERT INTO tbl_companies (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', 'LWN', 'Lawencon', 0, 'system', '2022-04-01 11:15:23.414', NULL, NULL, true);
INSERT INTO tbl_companies (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('ca636062-949f-4e27-a5ec-fb76cce0689f', 'LNV', 'Linov', 0, 'system', '2022-04-01 11:15:23.414', NULL, NULL, true);

INSERT INTO tbl_transactions_in (id, code, id_transaction_out, check_in_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('e521a661-2dcc-4fa2-b639-3c20b4e7b077', 'TI-01', '4011142e-90c8-4062-85aa-f939082ee0eb', '2022-04-05', 0, 'admin', '2022-04-02 14:12:27.682', NULL, NULL, true);
INSERT INTO tbl_transactions_in (id, code, id_transaction_out, check_in_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('20776379-9391-465e-b07b-fd36a7226ff5', 'TI-02', '060d6e1f-d092-4222-a697-d8c7c28205b5', '2022-04-09', 0, 'admin', '2022-04-03 13:06:34.999', NULL, NULL, true);

INSERT INTO tbl_detail_transactions_in (id, id_transaction_in, id_asset, id_asset_condition, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('32f01fb9-5f69-40ec-b480-709e88c3c632', 'e521a661-2dcc-4fa2-b639-3c20b4e7b077', '21f2f32b-5eaa-40b6-b8b0-1556b43b2c8e', '2a46411d-fa27-48cd-8d6b-2cdb078d1dfb', 0, 'admin', '2022-04-02 14:12:28.841', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_in (id, id_transaction_in, id_asset, id_asset_condition, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('b4ce46d7-8e4f-4a8f-adb4-85c210cd01fb', 'e521a661-2dcc-4fa2-b639-3c20b4e7b077', '0f08a467-1fc6-49a8-bf2e-2e7b5d68bc8c', '2a46411d-fa27-48cd-8d6b-2cdb078d1dfb', 0, 'admin', '2022-04-02 14:12:30.098', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_in (id, id_transaction_in, id_asset, id_asset_condition, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('e6ce3ac9-8995-48df-a601-8b5a7fc5f3ae', '20776379-9391-465e-b07b-fd36a7226ff5', '1eac06dc-c5e9-446b-a45f-c813d01e2374', '2a46411d-fa27-48cd-8d6b-2cdb078d1dfb', 0, 'admin', '2022-04-03 13:06:37.583', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_in (id, id_transaction_in, id_asset, id_asset_condition, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('c0266e0c-3f5c-498a-a3e5-fade11d054ed', '20776379-9391-465e-b07b-fd36a7226ff5', '0177fdb6-8a4c-4eaf-bacd-ef4ddae908ca', '2a46411d-fa27-48cd-8d6b-2cdb078d1dfb', 0, 'admin', '2022-04-03 13:06:37.600', NULL, NULL, true);

INSERT INTO tbl_transactions_out (id, code, id_employee, check_out_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('4011142e-90c8-4062-85aa-f939082ee0eb', 'TO-01', 'aa68f531-e26c-41a0-9d2b-8bb756a3e162', '2022-04-02', 0, 'admin', '2022-04-02 11:40:03.272', NULL, NULL, true);
INSERT INTO tbl_transactions_out (id, code, id_employee, check_out_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('060d6e1f-d092-4222-a697-d8c7c28205b5', 'TO-02', '28e52356-90c6-44f4-a052-0d322901fcb0', '2022-04-03', 0, 'admin', '2022-04-03 13:00:19.281', NULL, NULL, true);

INSERT INTO tbl_detail_transactions_out (id, id_transaction_out, id_asset, due_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('f0d1cc82-5035-4c0a-af05-3b5599824bd4', '4011142e-90c8-4062-85aa-f939082ee0eb', '21f2f32b-5eaa-40b6-b8b0-1556b43b2c8e', '2022-04-05', 0, 'admin', '2022-04-02 11:40:36.032', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_out (id, id_transaction_out, id_asset, due_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('998f7692-95c2-43c5-b7d2-23f42026f530', '4011142e-90c8-4062-85aa-f939082ee0eb', '0f08a467-1fc6-49a8-bf2e-2e7b5d68bc8c', '2022-04-05', 0, 'admin', '2022-04-02 11:40:41.887', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_out (id, id_transaction_out, id_asset, due_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('5753e2ea-8d44-49f8-9d63-24f03eb00611', '060d6e1f-d092-4222-a697-d8c7c28205b5', '1eac06dc-c5e9-446b-a45f-c813d01e2374', '2022-04-10', 0, 'admin', '2022-04-03 13:00:21.522', NULL, NULL, true);
INSERT INTO tbl_detail_transactions_out (id, id_transaction_out, id_asset, due_date, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('d28d616f-6720-4e51-8239-db2e3d407906', '060d6e1f-d092-4222-a697-d8c7c28205b5', '0177fdb6-8a4c-4eaf-bacd-ef4ddae908ca', '2022-04-10', 0, 'admin', '2022-04-03 13:00:21.538', NULL, NULL, true);

INSERT INTO tbl_employees (id, id_company, nip, email, full_name, phone_no, department, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('28e52356-90c6-44f4-a052-0d322901fcb0', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '198609262012051001', 'dimas123@gmail.com', 'Dimas Dandy', '081229659944', 'IT', 0, 'system', '2022-04-01 11:17:33.392', NULL, NULL, true);
INSERT INTO tbl_employees (id, id_company, nip, email, full_name, phone_no, department, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('aa68f531-e26c-41a0-9d2b-8bb756a3e162', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '198409192014051002', 'shani56@gmail.com', 'Shani Rachma', '081329659984', 'Human Resource', 0, 'system', '2022-04-01 11:17:33.392', NULL, NULL, true);
INSERT INTO tbl_employees (id, id_company, nip, email, full_name, phone_no, department, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('0a550ee4-f82e-4536-b696-cb80d75db08a', '44b16f48-d03e-4c8f-a1ed-4cbe9938eeea', '198709182015051003', 'trianaayu@gmail.com', 'Triana Ayu', '081249659974', 'Accounting', 0, 'system', '2022-04-01 11:17:33.392', NULL, NULL, true);

INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('34b3b0b2-b9ee-4374-8034-572fab7ab7a3', 'INVC1', '2022-04-01', 100000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);
INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('199a267a-93a0-4161-ae94-089c3d161e7d', 'INVC2', '2022-04-01', 200000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);
INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('235855cd-41fb-41c5-90ee-3ac0e15b4cf3', 'INVC3', '2022-04-01', 300000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);
INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('a281815d-0765-47a7-90c5-4fb8a52c8381', 'INVC4', '2022-04-01', 400000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);
INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('1af2c83e-b74a-4d5c-b133-64a382b906b1', 'INVC5', '2022-04-01', 100000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);
INSERT INTO tbl_invoices (id, code, invoice_date, total_price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('f1e3cfd8-521d-4b34-b22d-86912ae77c09', 'INVC6', '2022-04-01', 100000000, 0, 'system', '2022-04-01 11:32:16.257', NULL, NULL, true);

INSERT INTO tbl_item_types (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('8dbfc810-dc0c-47c9-9c94-d772539386a2', 'GNL', 'General', 0, 'system', '2022-04-01 11:18:45.857', NULL, NULL, true);
INSERT INTO tbl_item_types (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('a0e38706-8ea4-4563-82f0-05cb32747633', 'LCS', 'Licences', 0, 'system', '2022-04-01 11:18:45.857', NULL, NULL, true);
INSERT INTO tbl_item_types (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('9631fc05-86fa-4523-bd5a-dbd7e9a95f19', 'CPN', 'Component', 0, 'system', '2022-04-01 11:18:45.857', NULL, NULL, true);
INSERT INTO tbl_item_types (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('41e87275-b1c6-4967-99b3-e1bd46a5cb8d', 'CSM', 'Consumable', 0, 'system', '2022-04-01 11:18:45.857', NULL, NULL, true);

INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('7be68358-c48d-493b-9082-b50765773928', '8dbfc810-dc0c-47c9-9c94-d772539386a2', 'Laptop1', 'ASUS', 'A442U', 1200000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('98af086c-6678-4094-af58-520c9665c970', '8dbfc810-dc0c-47c9-9c94-d772539386a2', 'Laptop2', 'ASUS', 'A442U', 1200000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('b9edd259-a4da-4b8f-aa6b-746f9d2c1785', '8dbfc810-dc0c-47c9-9c94-d772539386a2', 'Laptop3', 'ASUS', 'A442U', 1200000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('ebb66774-60a8-4326-b267-93d85acea918', '9631fc05-86fa-4523-bd5a-dbd7e9a95f19', 'Hard Disk 1TB', 'Sandisk', 'H2421', 120000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('d988e9d3-4b3d-4faa-8a27-a667e24bd1a8', '9631fc05-86fa-4523-bd5a-dbd7e9a95f19', 'Hard Disk 2TB', 'Sandisk', 'H2421', 120000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('5eaa56a7-cde4-4acc-8c81-33fa87d7128f', '9631fc05-86fa-4523-bd5a-dbd7e9a95f19', 'Hard Disk 3TB', 'Sandisk', 'H2421', 120000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('5643c129-d3b1-4f2d-b907-dbf96d969377', '41e87275-b1c6-4967-99b3-e1bd46a5cb8d', 'Spidol', 'Snowman', 'BLCK11', 120000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('80a2418f-cdb6-43c5-8cf6-33dec6b01871', '8dbfc810-dc0c-47c9-9c94-d772539386a2', 'Kursi Mekanik', 'Olimpik', '88WSA', 1200000, 0, 'system', '2022-04-01 11:31:13.321', NULL, NULL, true);
INSERT INTO tbl_items (id, id_item_type, description, brand, serial, price, "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('55927ac1-1d90-4289-90d1-a80549819496', 'a0e38706-8ea4-4563-82f0-05cb32747633', 'Windows', 'Microsoft', 'Pro', 1200000, 0, '1', '2022-04-01 11:34:47.589', NULL, NULL, true);

INSERT INTO tbl_status_assets (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('37f85890-256c-4a35-9c70-d3210c14dc7f', 'SA1', 'Deployable', 0, 'system', '2022-04-01 11:21:52.994', NULL, NULL, true);
INSERT INTO tbl_status_assets (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('84d7d8b3-5284-4312-b190-d0538570433b', 'SA2', 'Undeployable', 0, 'system', '2022-04-01 11:21:52.994', NULL, NULL, true);
INSERT INTO tbl_status_assets (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('0447162c-ed89-4a9c-b4d8-63f52a805b93', 'SA3', 'On Assign', 0, 'system', '2022-04-01 11:21:52.994', NULL, NULL, true);
INSERT INTO tbl_status_assets (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('c674062f-4e90-4aac-a610-3c0f58fdbd71', 'SA4', 'Archive', 0, 'system', '2022-04-01 11:21:52.994', NULL, NULL, true);
INSERT INTO tbl_status_assets (id, code, "name", "version", created_by, created_date, updated_by, updated_date, is_active) VALUES('17db13ed-f323-4b0f-ac84-dfb8debb9b34', 'SA5', 'Pending', 0, 'system', '2022-04-01 11:21:52.994', NULL, NULL, true);
