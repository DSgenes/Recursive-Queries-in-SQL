/*
Recursive Sql Queries
*/

--Syntax
With cte_name (column names) as 
              (
			  select query (non recursive query or the base query)
			  union all
			  select query (recursive query using cte_name [with a termination condition]
			  )
select *
from cte_name;

--Queries
--Q.1: Display number from 1 to 10 without using anu inbuilt functions.
--Q.2: Find the hierarchy of employees under a given manager.
--Q.3: Find the hierarchy of managers for a given employee.

--Q.1: Display number from 1 to 10 without using anu inbuilt functions.
with numbers (n) as
    (select 1 as n
	union all
	select n + 1 
	from numbers where n < 10
	)
select *
from numbers;
-------------------------------------------------------------------------------------------
--Q.2: Find the hierarchy of employees under a given manager "Katherine"

create table emp_details 
			(id int , name varchar(100), manager_id int, salary int, designation varchar(100))	  
				  
insert into emp_details
values      (1, 'Shripadh', null , 10000, 'CEO'),
			(2, 'Satya', 5, 1400, 'Software Engineer'),
			(3, 'Jia', 5, 500, 'Data Analyst'),
			(4, 'David', 5, 1800, 'Data Scientist'),
			(5, 'Michael', 7, 3000, 'Manager'),
			(6, 'Arvind', 7, 2400, 'Architect'),
			(7, 'Katherine', 1, 4200, 'CTO'),
			(8, 'Maryam', 1, 3500, 'Manager'),
			(9, 'Reshma', 8, 2000, 'Business Analyst'),
			(10,'Robert', 8, 2500, 'Java Developer');
				  
select *
from emp_details;
				  
with emp_hierarchy (id, name, manager_id, designation, lvl) as 
	(select id, name, manager_id, designation, 1 as lvl
	from emp_details where name = 'Katherine'
	union all
	select E.id, E.name, E.manager_id, E.designation, H.lvl+1 as lvl
	from emp_hierarchy H
	join emp_details E on H.id = E.manager_id
	)
select *
from emp_hierarchy;

--Additional task to do : Now show the employee id, employee name, manager name and lvl.

with emp_hierarchy (id, name, manager_id, designation, lvl) as 
	(select id, name, manager_id, designation, 1 as lvl
	from emp_details where name = 'Katherine'
	union all
	select E.id, E.name, E.manager_id, E.designation, H.lvl+1 as lvl
	from emp_hierarchy H
	join emp_details E on H.id = E.manager_id
	)
select H2.id as emp_id, H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierarchy H2
join emp_details E2 on E2.id = H2.manager_id;
---------------------------------------------------------------------------------------------
--Q.3: Find the hierarchy of managers for a given employee "David".

with emp_hierarchy (id, name, manager_id, designation, lvl) as 
	(select id, name, manager_id, designation, 1 as lvl
	from emp_details where name = 'David'
	union all
	select E.id, E.name, E.manager_id, E.designation, H.lvl+1 as lvl
	from emp_hierarchy H
	join emp_details E on H.manager_id = E.id
	)
select H2.id as emp_id, H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierarchy H2
join emp_details E2 on E2.id = H2.manager_id;
----------------------------------------------------------------------------------------------

