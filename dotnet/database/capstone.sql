USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone;
GO

USE final_capstone;
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)

);

CREATE TABLE ingredients (

ingredient_id int IDENTITY(1,1) NOT NULL,
ingredient_name varchar(50) NOT NULL,
user_id integer NOT NULL,
--CONSTRAINT FK_user_id FOREIGN KEY (user_id),
CONSTRAINT PK_ingredients_ingredient_id PRIMARY KEY (ingredient_id)
);

CREATE TABLE recipe_ingredients (
ingredient_id int NOT NULL,
recipe_id int NOT NULL,
measurment_unit varchar(30) NOT NULL
CONSTRAINT PK_recipe_ingredient_ingredient_id_recipe_id PRIMARY KEY (ingredient_id, recipe_id)
);

CREATE TABLE recipe (
recipe_id int identity(1,1) NOT NULL,
recipe_name varchar(50) NOT NULL,
recipe_description varchar (2200),
recipe_instructions varchar (2200),
user_id int NOT NULL,
CONSTRAINT PK_recipe_recipe_id PRIMARY KEY (recipe_id)
);




--populate default data
-- user/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
--admin/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');

ALTER TABLE ingredients
ADD FOREIGN KEY(user_id)
REFERENCES users(user_id);

ALTER TABLE recipe
ADD FOREIGN KEY(user_id)
REFERENCES users(user_id);

ALTER TABLE recipe_ingredients
ADD FOREIGN KEY(ingredient_id)
REFERENCES ingredients(ingredient_id);

ALTER TABLE recipe_ingredients
ADD FOREIGN KEY(recipe_id)
REFERENCES recipe(recipe_id);



GO