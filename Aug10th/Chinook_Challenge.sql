------------------2.0 BASICS--------------------------------
-- 2.1 select 
select * from "Album";

select * from "Employee";
select * from "Employee" where "LastName" = 'King';
select * from "Employee" where "FirstName" = 'Andrew' and "ReportsTo" = null;

-- 2.2 Order By
select * from "Album" order by "Title" desc;
select * from "Customer" order by "City" asc;

-- 2.3 Insert Into
insert into "Genre"("GenreId","Name") values
	(26,'Video Game'),
	(27,'Techno');
	
insert into "Employee" values
	(9, 'Rogers','Peter','IT Staff',6,
	'1980-06-06 00:00:00.000','2004-03-07 00:00:00.000',
	'123 Baker St.', 'Baldwin','NH','USA',62032,'+1(555)123-2421',
	'+1(403)466-8241','peter@chinookcorp.com'),
	(10, 'Childs','Damon','Sales Support Agent',2,
	'1980-06-06 00:00:00.000','2004-03-07 00:00:00.000',
	'700 Tilapia Rd.', 'Saquachanga','RI','USA',23623,'+1(000)525-7422',
	'+1(403)263-4433','damon@chinookcorp.com');
	
insert into "Customer" values
	(60, 'Clement','Jones','Steak Heaven Inc.','886 RoastBeef St.',
	'Tonabel', 'SD','USA', '26747','+1(523)536-5253',null,'clemj@hotmail.com',10),
	(61, 'Raja','Banks',null,'357 Houston St.',
	'New York', 'NY','USA', '10001','+1(212)843-5773',null,'rbanks01@gmail.com',10);
	
-- 2.4 update 
update "Customer" set ("FirstName","LastName") = ('Robert','Walker') 
where "FirstName" = 'Aaron' and "LastName" ='Mitchell';

select * from "Customer" where "LastName" = 'Walker';

update "Artist" set "Name" = 'CCR' where "Name" = 'Creedence Clearwater Revival';

select * from "Artist" where "Name" = 'CCR';

-- 2.5 like
select * from "Invoice" where "BillingAddress" like 'T%';

-- 2.6 between
select * from "Invoice" where "Total" >= 15 and "Total" < 50;

select * from "Employee" where "HireDate" between '2003-06-01' and 
'2004-03-01';

-- 2.7 delete 
--		1 - remove relationship btwn "InvoiceLine" and "Invoice" matching Robert Walker
delete from "InvoiceLine" where "InvoiceId" in 
	(select "InvoiceId" from "Invoice" where "CustomerId" in 
		(select "CustomerId" from "Customer" where 
		("FirstName","LastName") = ('Robert','Walker')));
-- 		2 - remove relationships btwn "Invoice and Customer" matching Robert Walker
delete from "Invoice" where "CustomerId" in (select "CustomerId" from 
"Customer" where ("FirstName","LastName") = ('Robert','Walker'));
-- 		3 - remove Robert Walker customer entry
delete from "Customer" where ("FirstName","LastName") = ('Robert','Walker');


------------------3.0 FUNCTIONS--------------------------------
-- 3.1 func to return current time
select now();  -- return current time
select count(*) from "MediaType" mt ;	--????

-- 3.2
select avg("Total") from "Invoice"; -- Agg Func 'avg' -> average of all invoices

select max("UnitPrice") from "Track"; -- Agg Func 'max' -> most expensive track
	
-- 3.3
-- Func to return avg price of invoiceline items in invoiceline table
create or replace function avg_invoiceline_price()
returns numeric(10,2) as $average$
declare 
	average numeric(10,2);
begin
	select avg("UnitPrice") from "InvoiceLine" into average;
	return average;
end;
$average$ language plpgsql;

select avg_invoiceline_price(); --call function

-- 3.4
--	Func to return all employees born after 1968
create or replace function born_post68()
returns table (first_name varchar(20), last_name varchar(20))
language plpgsql
as $$
begin
	return query
		select "FirstName", "LastName" 
		from "Employee" 
 		where "BirthDate" >= '1969-01-01';
end; $$

select born_post68(); -- call function
	
	
-- BONUS: Custom Function Stuff
-- Get definition of existing 'now' function for a look-see
select pg_get_functiondef((select oid from pg_catalog.pg_proc where proname = 'timenow')); 

-- Function to get current time in ONLY hours and minutes HH:MM
create or replace function timenow()  --Define func name & creation standard
returns varchar(15) as $timeout$	-- set return type & expected return var name
declare								-- Var declaration section 
	timeout varchar(15) := CURRENT_TIME(0);	-- ':=' used to set var value to result of expression
begin								-- start function BODY
	return left(timeout,5);			-- return statment, using string manipulation func to return only first 5 chars (removing secs & timezone)
end;								-- close function BODY
$timeout$ language plpgsql;			-- required $$ closing of return var and language declaration

select timenow();					-- call function

drop function if exists timenow(); 	--delete func

------------------5.0 TRANSACTIONS------------------------------

------------------7.0 JOINS-------------------------------------
-- 7.1 INNER JOIN
--	joins a table with another by matching values in a column from each
-- Create IJ joining Customers & Orders specifying customer name & invoiceID
select "FirstName", "LastName", "InvoiceId"
from "Customer" 
inner join "Invoice" using ("CustomerId");

-- 7.2 OUTER JOIN
-- 
-- Create OJ joining Customer & Invoice tables, specifying CustomerId, 
--		Firstname, last, invoiceId & total 
select "CustomerId", "FirstName", "LastName", "InvoiceId", "Total"
from "Customer" 
full outer join "Invoice" using ("CustomerId");

--7.3 RIGHT JOIN
--
-- Create RJ of Album & Artist specifying artist name & title
select "Name", "Title"
from "Album" a 
right join "Artist" using ("ArtistId");

-- 7.4 CROSS JOIN
--
-- Join Album & Artist & sort by Artist name in asc 
select *
from "Album"
cross join "Artist" order by "Name" asc;

-- 7.5 SELF JOIN
--		a regular join to the table itself
--		typically used to query hierarchical data, or compare rows in same table
--		can use INNER, LEFT or RIGHT
-- SJ Employee table, joining on the reportsto collate 
	-- e and e2 are separate aliases to enable the join  
select e2 ."FirstName" || ' ' || e2 ."LastName" employee, -- Creating custom col, joining cols with || syntax and ending with the new name
	e."FirstName" || ' ' || e."LastName" boss				-- distinction made by using the aliases
from "Employee" e 									-- first table reference w/ alias 'e'
inner join "Employee" e2 on e2 ."ReportsTo" = e."EmployeeId" -- 2nd table ref w/ alias 'e2', "on" determines the joining condition
order by boss;   		-- order results using the new column name defined in the initial select
