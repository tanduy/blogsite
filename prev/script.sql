DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS entry;
DROP TABLE IF EXISTS comment;

CREATE TABLE account(
	id SERIAL 	PRIMARY KEY,
	username 	VARCHAR(60),
	password 	VARCHAR(60),
	nicename 	VARCHAR(50),
	email 	 	VARCHAR(100),
	url	 		VARCHAR(100),
	registered 	TIMESTAMP,
	activation_key 	VARCHAR(60),
	status    	INTEGER,
	display_name 	VARCHAR(250)
);

CREATE TABLE entry(
	id SERIAL PRIMARY KEY,
	account_id INTEGER,
	title VARCHAR(255),
	body TEXT,
	created_at TIMESTAMP,
	updated_at TIMESTAMP
);

CREATE TABLE comment(
	id SERIAL PRIMARY KEY,
	entry_id INTEGER,
	account_id INTEGER,
	body TEXT,
	created_at TIMESTAMP,
	updated_at TIMESTAMP
);
