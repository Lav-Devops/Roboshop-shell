CREATE TABLE shipping (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  address VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(100),
  zip_code VARCHAR(20)
);

INSERT INTO shipping (order_id, address, city, state, zip_code)
VALUES 
(101, '221B Baker Street', 'London', 'London', 'NW1 6XE'),
(102, '221c Oxford Street', 'US', 'London', 'NW1 6XE'),
(103, '221D brick lane ', 'UK', 'London', 'NW1 6XE'),
(104, '221E carnaby Street', 'London', 'London', 'NW1 6XE');
