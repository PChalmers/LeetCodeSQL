use LeetCodeTests
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Sales]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].Sales
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Product]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].Product
GO

Create table Product (product_id int, product_name varchar(10), unit_price int)
Create table Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int)
Truncate table Product
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000')
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800')
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400')
Truncate table Sales
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800')

/* Write an SQL query that reports the products that were only sold in spring 2019. 
   That is, between 2019-01-01 and 2019-03-31 inclusive. */

SELECT DISTINCT p.product_id, p.product_name
FROM Product p
join 
Sales s
ON p.product_id = s.product_id
WHERE (s.sale_date BETWEEN '2019-01-01' and '2019-03-31') 
       AND p.product_id NOT in (SELECT product_id FROM Sales 
	                            WHERE sale_date < '2019-01-01' OR sale_date > '2019-03-31')
ORDER BY p.product_id