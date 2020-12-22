CREATE TABLE `users` (
`id` INT(11) PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(255) DEFAULT NULL,
`gender` BOOLEAN NOT NULL COMMENT 'true - мужчина, false - женщина.',
`birth_date` DATETIME NOT NULL COMMENT 'Дата в DATETIME.'
);
CREATE TABLE `phone_numbers` (
id INT(11) PRIMARY KEY AUTO_INCREMENT,
user_id INT(11) NOT NULL,
phone VARCHAR(255) DEFAULT NULL,
CONSTRAINT FK_User_Phones FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL ON UPDATE SET NULL
);

INSERT INTO users (name,gender,birth_date) VALUES('girl1',false,'2020-01-01 00:00:00'),('man1',true,'1955-01-01'),('girl2',false,'2000-01-01');

INSERT INTO phone_numbers (user_id,phone) VALUES(1,'89995551234'),(2,'84447771234'),(3,'81112221234'),(3,'86784561234');

SELECT COUNT(phone_numbers.phone) AS phone_count,users.name 
FROM phone_numbers 
  INNER JOIN users ON (phone_numbers.user_id = users.id) 
WHERE (DATE_ADD(users.birth_date, INTERVAL 18 YEAR) <= NOW()) 
  AND (DATE_ADD(users.birth_date, INTERVAL 23 YEAR) > NOW()) 
  AND NOT users.gender 
GROUP BY users.name;


+-------------+-------+
| phone_count | name  |
+-------------+-------+
|           2 | girl2 |
+-------------+-------+
