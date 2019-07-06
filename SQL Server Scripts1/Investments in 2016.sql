use LeetCodeTests
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[insurance]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].insurance
GO

CREATE TABLE insurance (PID DECIMAL(11), TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2) )
Truncate table insurance
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('1', '10', '5', '10', '10')
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('2', '20', '20', '20', '20')
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('3', '10', '30', '20', '20')
insert into insurance (PID, TIV_2015, TIV_2016, LAT, LON) values ('4', '10', '40', '40', '40')


/* Write a query to print the sum of all total investment values in 2016 (TIV_2016), 
   to a scale of 2 decimal places, for all policy holders who meet the following criteria:
       Have the same TIV_2015 value as one or more other policyholders.
       Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) 
	   attribute pairs must be unique). */

SELECT SUM(i1.TIV_2016)
FROM insurance i1
WHERE i1.TIV_2015 IN (SELECT i2.TIV_2015 
                      FROM insurance i2 
					  WHERE i1.PID != i2.PID)
GROUP BY i1.LAT, i1.LON
HAVING (SELECT count(LON) FROM insurance) = 1
	  AND (SELECT count(LAT) FROM insurance) = 1

SELECT * FROM insurance