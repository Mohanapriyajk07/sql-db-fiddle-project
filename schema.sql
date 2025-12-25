CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO customers VALUES
(1, 'Asha', 'Chennai', '2020-01-15'),
(2, 'Ravi', 'Mumbai', '2019-11-10'),
(3, 'Meena', 'Delhi', '2021-06-20'),
(4, 'Kiran', 'Bangalore', '2020-08-05'),
(5, 'Divya', 'Hyderabad', '2022-03-14');

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
`
INSERT INTO accounts VALUES
(101, 1, 'Savings', 45000),
(102, 1, 'Current', 20000),
(103, 2, 'Savings', 90000),
(104, 3, 'Savings', 30000),
(105, 4, 'Current', 75000),
(106, 5, 'Savings', 15000);

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(20),
    amount INT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions VALUES
(1, 101, '2023-01-10', 'Debit', 5000),
(2, 101, '2023-01-25', 'Credit', 12000),
(3, 102, '2023-02-05', 'Debit', 3000),
(4, 103, '2023-02-15', 'Debit', 15000),
(5, 103, '2023-03-10', 'Debit', 20000),
(6, 104, '2023-03-22', 'Credit', 10000),
(7, 105, '2023-04-01', 'Debit', 25000),
(8, 105, '2023-04-15', 'Credit', 18000),
(9, 106, '2023-05-10', 'Debit', 5000);
