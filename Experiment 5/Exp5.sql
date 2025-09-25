-----Medium Level Problem------


CREATE TABLE TBL_transaction_data(
	id INT,
	value DECIMAL
);

INSERT INTO TBL_transaction_data(id,value)
SELECT 1, RANDOM()
FROM GENERATE_SERIES(1,1000000);

INSERT INTO TBL_transaction_data(id,value)
SELECT 2, RANDOM()
FROM GENERATE_SERIES(1,1000000);

SELECT * FROM TBL_transaction_data

CREATE VIEW VW_NormalView_salesSummary
AS
SELECT 
	id,
	COUNT(*) AS Total_Orders,
	SUM(value) AS Total_Sales,
	AVG(value) AS Avg_transaction
FROM TBL_transaction_data
GROUP BY id;

EXPLAIN ANALYZE
SELECT * FROM VW_NormalView_salesSummary

CREATE MATERIALIZED VIEW VW_MaterialisedView_salesSummary AS
SELECT
    id,
    COUNT(*) AS Total_Orders,
    SUM(value) AS Total_Sales,
    AVG(value) AS Avg_transaction
FROM TBL_transaction_data
GROUP BY id;

EXPLAIN ANALYZE
SELECT * FROM VW_MaterialisedView_salesSummary





-----Hard Level Problem------


CREATE USER CLIENT_1
WITH PASSWORD '123';

GRANT SELECT ON VW_NormalView_salesSummary TO CLIENT_1;
GRANT SELECT ON VW_MaterialisedView_salesSummary TO CLIENT_1;

REVOKE SELECT ON VW_NormalView_salesSummary FROM CLIENT_1;