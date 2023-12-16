use bank;

select client_id from bank.client where district_id = 1 limit 5; 

select client_id from bank.client where district_id = 72 order by client_id desc limit 1;

select amount from loan where amount > 0 order by amount limit 3;

select distinct status from loan order by status asc;

select loan_id from loan order by payments desc limit 1;

select account_id, min(amount) as amount from loan group by account_id order by amount desc limit 5;

SELECT account_id, amount FROM loan WHERE duration = 60 ORDER BY amount LIMIT 5;

select DISTINCT `k_symbol` FROM `order`;

SELECT order_id FROM `order` WHERE account_id = 34;

SELECT DISTINCT account_id FROM `order` WHERE order_id BETWEEN 29540 AND 29560;

SELECT amount FROM `order` WHERE account_to = 30067122;

select trans_id, date, type amount from trans where account_id = 793  ORDER BY date DESC LIMIT 10;
 
SELECT district_id, COUNT(*) as num_clients FROM client WHERE district_id < 10 GROUP BY district_id ORDER BY district_id ASC;

SELECT type, COUNT(*) AS card_count FROM card GROUP BY type ORDER BY card_count DESC;

SELECT account_id, SUM(amount) AS suma_total FROM loan GROUP BY account_id ORDER BY suma_total DESC LIMIT 10;

SELECT date, COUNT(*) AS number_of_loans FROM loan WHERE date < 930907 GROUP BY date ORDER BY date DESC;

SELECT DISTINCT date, COUNT(*) AS loan_count FROM loan GROUP BY date ORDER BY date ASC;

SELECT date, duration, COUNT(*) AS loan_count FROM loan WHERE DATE_FORMAT(date, '%Y-%m') = '1997-12' GROUP BY date, duration ORDER BY date ASC, duration ASC;

SELECT
  account_id,
  type,
  SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END) AS total_outgoing_amount,
  SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) AS total_incoming_amount
FROM trans
WHERE account_id = 396

SELECT 
  account_id,
  CASE
    WHEN type = 'VYDAJ' THEN 'Outgoing'
    WHEN type = 'PRIJEM' THEN 'Incoming'
    -- Add more WHEN clauses for other values as needed
    ELSE 'Unknown'
  END AS transaction_type,
  FLOOR(SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS total_outgoing_amount,
  FLOOR(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END)) AS total_incoming_amount
FROM
  trans
WHERE
  account_id = 396
GROUP BY
  account_id, transaction_type;

SELECT
  MAX(account_id) AS account_id,
  MAX(transaction_type) AS transaction_type,
  MAX(total_incoming_amount) AS total_incoming_amount,
  MAX(total_outgoing_amount) AS total_outgoing_amount,
  MAX(total_incoming_amount) - MAX(total_outgoing_amount) AS difference
FROM (
  SELECT
    account_id,
    CASE
      WHEN type = 'VYDAJ' THEN 'Outgoing'
      WHEN type = 'PRIJEM' THEN 'Incoming'
      ELSE 'Unknown'
    END AS transaction_type,
    FLOOR(SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS total_outgoing_amount,
    FLOOR(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END)) AS total_incoming_amount
  FROM
    trans
  WHERE
    account_id = 396
  GROUP BY
    account_id, transaction_type
) AS subquery
GROUP BY
  account_id;

SELECT
  account_id,
  MAX(transaction_type) AS transaction_type,
  MAX(total_incoming_amount) AS total_incoming_amount,
  MAX(total_outgoing_amount) AS total_outgoing_amount,
  MAX(total_incoming_amount) - MAX(total_outgoing_amount) AS difference
FROM (
  SELECT
    account_id,
    CASE
      WHEN type = 'VYDAJ' THEN 'Outgoing'
      WHEN type = 'PRIJEM' THEN 'Incoming'
      ELSE 'Unknown'
    END AS transaction_type,
    FLOOR(SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END)) AS total_outgoing_amount,
    FLOOR(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END)) AS total_incoming_amount
  FROM
    trans
  GROUP BY
    account_id, transaction_type
) AS subquery
GROUP BY
  account_id
ORDER BY
  difference DESC
LIMIT 10;

