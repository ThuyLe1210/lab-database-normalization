CREATE TABLE `actor` (
  `actor_id` smallint,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `last_update` timestamp
);

CREATE TABLE `country` (
  `country_id` smallint,
  `country` varchar(50),
  `last_update` timestamp
);

CREATE TABLE `film_category` (
  `film_id` smallint,
  `category_id` tinyint,
  `last_update` timestamp
);

CREATE TABLE `category` (
  `category_id` tinyint,
  `name` varchar(25),
  `last_update` timestamp
);

CREATE TABLE `film` (
  `film_id` smallint,
  `title` varchar(128),
  `description` text,
  `release_year` year,
  `language_id` tinyint,
  `original_language_id` tinyint,
  `rental_duration` tinyint,
  `rental_rate` decimal(4.2),
  `length` smallint,
  `replacement_cost` decimal(5.2),
  `rating` film_rating_enum,
  `special_features` set('trailers', 'commentaries','deleted scenes','behind the scenes'),
  `last_update` timestamp
);

CREATE TABLE `film_actor` (
  `actor_id` smallint,
  `film_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `film_text` (
  `film_id` smallint,
  `title` varchar(255),
  `description` text
);

CREATE TABLE `language` (
  `language_id` tinyint,
  `name` char(20),
  `last_update` timestamp
);

CREATE TABLE `address` (
  `address_id` smallint,
  `address` varchar(50),
  `address2` varchar(50),
  `district` varchar(20),
  `city_id` smallint,
  `postal_code` varchar(10),
  `phone` smallint,
  `last_update` timestamp
);

CREATE TABLE `iventory` (
  `inventory_id` mediumint,
  `film_id` smallint,
  `store_id` tinyint,
  `last_update` timestamp
);

CREATE TABLE `customer` (
  `customer_id` smallint,
  `store_id` tinyint,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(50),
  `address_id` smallint,
  `active` boolean,
  `create_date` datetime,
  `last_update` timestamp
);

CREATE TABLE `city` (
  `city_id` smallint,
  `city` varchar(50),
  `country_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `rental` (
  `rental_id` int,
  `rental_date` datetime,
  `inventory_id` mediumint,
  `customer_id` smallint,
  `return_date` datetime,
  `staff_id` tinyint,
  `last_update` timestamp
);

CREATE TABLE `staff` (
  `staff_id` tinyint,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `address_id` smallint,
  `picture` blob,
  `email` varchar(50),
  `store_id` tinyint,
  `active` boolean,
  `username` varchar(20),
  `password` varchar(40),
  `last_update` timestamp
);

CREATE TABLE `store` (
  `store_id` tinyint,
  `manager_staff_id` tinyint,
  `address_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `payment` (
  `payment_id` smallint,
  `customer_id` smallint,
  `staff_id` tinyint,
  `rental_id` int,
  `amount` decimal(5.2),
  `payment_date` datetime,
  `last_update` timestamp
);

ALTER TABLE `film` ADD FOREIGN KEY (`film_id`) REFERENCES `film_category` (`film_id`);

ALTER TABLE `category` ADD FOREIGN KEY (`category_id`) REFERENCES `film_category` (`category_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`);

ALTER TABLE `film_text` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film` ADD FOREIGN KEY (`film_id`) REFERENCES `film_actor` (`film_id`);

ALTER TABLE `film_text` ADD FOREIGN KEY (`film_id`) REFERENCES `film_actor` (`film_id`);

ALTER TABLE `iventory` ADD FOREIGN KEY (`inventory_id`) REFERENCES `rental` (`inventory_id`);

ALTER TABLE `iventory` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `address` ADD FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

ALTER TABLE `iventory` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`);

ALTER TABLE `city` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);
