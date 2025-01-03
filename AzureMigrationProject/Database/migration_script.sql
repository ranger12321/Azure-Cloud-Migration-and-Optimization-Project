-- SQL Migration Script
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Products (name, price) VALUES
('Product A', 10.99),
('Product B', 20.50),
('Product C', 15.00);
