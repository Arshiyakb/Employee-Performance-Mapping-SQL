/*Create a database named employee, 
then import data_science_team.csv proj_table.csv 
and emp_record_table.csv into the employee database from the given resources.*/
create database employee
use employee
select * from emp
select * from proj
select * from team

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
 and DEPARTMENT from the employee record table, and 
 make a list of employees and details of their department.*/
 
 select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT 
 from emp;
 
/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/
select emp_id,first_name,last_name,gender,dept ,emp_rating
from emp where emp_rating<2

select emp_id,first_name,last_name,gender,dept,emp_rating
from emp where emp_rating>4

select emp_id,first_name,last_name,gender,dept,emp_rating 
from emp where emp_rating between 2 and 4

/*Write a query to concatenate the FIRST_NAME and the 
LAST_NAME of employees in the Finance department from 
the employee table and then give the resultant column alias as NAME.*/
select concat(first_name,'',last_name) as NAME 
from emp


/*Write a query to list only those employees who have someone reporting to them.
 Also, show the number of reporters (including the President).*/
 select e.emp_id, e.first_name,e.last_name,e.role,count(e.emp_id) as reporting_emp
 from emp e
 join emp m
 on e.emp_id=m.manager_id
 group by m.role
 order by m.role
 
/*Write a query to list down all the employees from the healthcare and finance departments using union. 
Take data from the employee record table.*/
select emp_id 
from emp
where dept='healthcare'
union all
select emp_id 
from emp
where dept='finance'

 /*Write a query to list down employee details such as EMP_ID, FIRST_NAME,
 LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
 Also include the respective employee rating along with the max emp rating for the department.*/
select EMP_ID, FIRST_NAME,
 LAST_NAME, ROLE, DEPT,EMP_RATING 
 from emp
 group by dept

 /*Write a query to calculate the minimum and the maximum salary of the employees in each role.
 Take data from the employee record table.*/
 select min(salary) as minimum_Salary, max(salary) as maximum_Salary, emp_id ,role
 from emp
 group by role

 /*Write a query to assign ranks to each employee based on their experience. 
 Take data from the employee record table.*/
select emp_id,first_name,last_name, dense_rank() over(order by exp) emp_dense_rank, rank() over(order by exp)  emp_rank
from emp
 
/*Write a query to create a view that displays employees in various countries whose salary is more than six thousand.
 Take data from the employee record table.*/
create or replace view employee_view as
select emp_id,country,salary from emp
where salary>6000
select  * from employee_view
 

/*Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.*/
select emp_id,exp,first_name,last_name
from emp 
where exp in(select exp from emp
          where exp>10)

/*Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years.
 Take data from the employee record table.*/
delimiter $$
create procedure get_experience()
begin
select * from emp 
where exp>3;
end $$
 call get_experience()
 
 /*Write a query using stored functions in the project table to check whether the job profile assigned to each employee 
 in the data science team matches the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER*/

DELIMITER $$
CREATE FUNCTION experience_level(exp int)
RETURNS VARCHAR(2555)
DETERMINISTIC
BEGIN
    DECLARE experience_level VARCHAR(2555);
IF exp <= 2 THEN SET experience_level = 'JUNIOR DATA SCIENTIST'; 
ELSEIF exp <= 5 THEN SET experience_level = 'ASSOCIATE DATA SCIENTIST'; 
ELSEIF exp <= 10 THEN SET experience_level = 'SENIOR DATA SCIENTIST'; 
ELSEIF exp<= 12 THEN SET experience_level= 'LEAD DATA SCIENTIST';
ELSEIF exp > 12 THEN SET experience_level = 'MANAGER';
end if;
return (experience_level);
end$$
delimiter $$
select first_name,last_name,dept,experience_level(exp) as designation,exp 
from employee.emp order by exp


/*Create an index to improve the cost and performance of the query to
find the employee whose FIRST_NAME is ‘Eric’ in the employee table
after checking the execution plan.*/

create index  idx_word on emp(first_name(255));
select * from emp where first_name='eric';


/*Write a query to calculate the bonus for all the employees, based on
their ratings and salaries (Use the formula: 5% of salary * employee
rating).*/

select emp_id,first_name,last_name, salary,emp_rating,((salary *0.05)*emp_rating) as bonus
from emp order by bonus


