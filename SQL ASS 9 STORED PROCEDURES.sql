create database company;
use company;

-- CREATING TABLE
create table worker ( Worker_ID int primary key , First_name
char (25), Last_name char(25), Salary INT(15), JoiningDate DATETIME,
Department CHAR(25));
 
 # INSERTING VALUES INTO TABLE
insert into worker values (1,'Alice','Joseph','12000','2018-02-11',
'HR'),(2,'Mary','Johns',15000,'2010-01-23','Finance'),
(3,'george','perera',13500,'2012-03-01','security'),
(4,'Mathew','lewis',22000,'2008-01-01','management'),
(5,'Lisa','thomas',16500,'2011-06-01','Finance'),
(6,'Arun','Santhosh',14500,'2011-01-01','security'),
(7,'Sachin','charley',11000,'2015-01-01','Finance');

select*from worker; 

#1. STORED PROCEDURE USING IN PARAMETER
delimiter //
create procedure workerdetails(in workerID int)
begin
select worker_ID, First_name, Last_name, joiningDate,
department from worker
where worker_ID= workerID;
end //
delimiter ;

call workerdetails(2);

#ADDING NEW RECORD TO THE TABLE
insert into worker values (8,'Ali','Jose','12200','2016-02-01',
'HR');

# CALLING PROCEDURE
call workerdetails(8);

#2. STORED PROCEDURE USING IN PARAMETER AND OUT PARAMETER
delimiter $$
create procedure WorkerSalary(in WorkerID int, out WSalary int(15))
begin
select salary into WSalary from worker
where worker_ID=WorkerID;
end $$
delimiter ;

# DECLARING NULL VARIABLE
set @Wsalary = 0;
call WorkerSalary(5,@Wsalary);
select @wsalary as workers_salary;

#3.STORED PROCEDURE FOR DISPLAY DEPARTMENT WITH ID
delimiter &&
create procedure workerdepartment(in WID int)
begin
select department  from worker
where WID= Worker_ID;
end &&
delimiter ;

# CALLING PROCEDURE

call workerdepartment(3);

#4. STORED PROCEDURE FOR NO.WORKERS IN EACH DEPARTMENT
delimiter &&
create procedure No_Workers (in dpt varchar(50),out p_workercount int)
begin
select count(*) into p_workercount from worker
where department=dpt ;
end &&
delimiter ;
drop procedure No_workers;

set @p_workercount = 0;
call No_Workers ('security',@p_workercount);
select @p_workercount as count_of_workers;

#5. STORED PROCEDURE FOR AVG SALARY OF EACH DEPARTMENT
Delimiter //
create procedure avgsalary(in dpt varchar(50), 
out p_avgsalary decimal(10,2))
begin
select avg(salary) into p_avgsalary from worker
where department= dpt;
end//
delimiter ;

set @p_avgsalary=0;
call avgsalary ('HR',@p_avgsalary);
select @p_avgsalary as average_salary;

