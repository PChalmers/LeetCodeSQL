use LeetCodeTests
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[survey_log]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].survey_log
GO


Create table survey_log ("uid" int, "action" varchar(255), question_id int, answer_id int, q_num int, "timestamp" int)
Truncate table survey_log
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '285', Null, '1', '123')
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'answer', '285', '124124', '1', '124')
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'show', '369', '456', '2', '125')
insert into survey_log (uid, action, question_id, answer_id, q_num, timestamp) values ('5', 'skip', '369', '234', '2', '126')

/* Write an SQL query that reports all product names of the products 
   in the Sales table along with their selling year and price. */


SELECT TOP(1) question_id
FROM survey_log
WHERE answer_id IS NOT Null
GROUP BY question_id
ORDER BY count(question_id) DESC
