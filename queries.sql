SELECT c.name, c.city, a.account_type, a.balance 
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

SELECT 
    account_id,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY account_id;

SELECT 
    c.name,
    SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.name
ORDER BY total_balance DESC
LIMIT 3;

-- compute month-start and sums in a derived table, then left-join to previous month
SELECT
  m.account_id,
  m.month_start,
  m.monthly_spending,
  p.monthly_spending AS prev_month_spending
FROM (
  SELECT
    account_id,
    DATE_FORMAT(txn_date, '%Y-%m-01') AS month_start,
    SUM(amount) AS monthly_spending
  FROM transactions
  WHERE txn_type = 'Debit'
  GROUP BY account_id, month_start
) m
LEFT JOIN (
  SELECT
    account_id,
    DATE_FORMAT(txn_date, '%Y-%m-01') AS month_start,
    SUM(amount) AS monthly_spending
  FROM transactions
  WHERE txn_type = 'Debit'
  GROUP BY account_id, month_start
) p
  ON m.account_id = p.account_id
  AND p.month_start = DATE_SUB(m.month_start, INTERVAL 1 MONTH)
ORDER BY m.account_id, m.month_start;

SELECT *
FROM transactions
WHERE amount > (
    SELECT AVG(amount) FROM transactions
);

SELECT
  customer_id,
  name,
  total_spending,
  @r := @r + 1 AS spending_rank
FROM (
  SELECT 
    c.customer_id,
    c.name,
    SUM(t.amount) AS total_spending
  FROM customers c
  JOIN accounts a ON c.customer_id = a.customer_id
  JOIN transactions t ON a.account_id = t.account_id
  WHERE t.txn_type = 'Debit'
  GROUP BY c.customer_id, c.name
  ORDER BY SUM(t.amount) DESC
) AS cs
CROSS JOIN (SELECT @r := 0) AS vars;
