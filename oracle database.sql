		-- database creation -- 
        
create database studentDb;
drop database studentDb;

		-- table creation-- 
        
create table reservation(
reservation_id bigint(8) primary key not null,
customer_name varchar(30) not null,
reservation_discription varchar(100) not null,
reservation_date date,
adult smallint ,
children smallint,
status varchar(10),
total_amount double default(reservation.adult*500+reservation.children*300)
);

create table studentDetails(
regno bigint(8)  primary key not null,
firstname varchar(20) not null,
lastname varchar(20) not null check(length(lastname)>1) ,
course enum('MCA','BCA','BSC','MSC','MBA','BBA') not null, -- enum index used to insert values or else we can use direct values
branch enum('bangalor','managlore','chennai') not null

);

create table marks(
regno bigint(8) ,
physics smallint(2) not null,
chemistry smallint(2) not null,
maths smallint(2) not null,
cs smallint(2) not null,
totalmarks double not null default(physics+chemistry+maths+cs),
percentage double not null default((totalmarks/400)*100),
foreign key(regno) references studentdetails(regno)
);
     -- alter table with modify,add -- 
     
alter table tablereservation rename to reservation ;
alter table reservation modify reservation_discription varchar(200) not null default "No discription";
alter table reservation modify status varchar(10) not null default "Booked" ;

alter table login modify password varchar(20)  not null ;

alter table reservation modify reservation_date date default(now());
alter table reservation modify reservation_date date default(curdate());

alter table login modify password varchar(150) not null;

alter table reservation add phone_number bigint(10) not null ;
alter table login add foreign key (reservation_id) references reservation (reservation_id);

alter table login drop reservation_id;

alter table reservation modify total_amount double default(reservation.adult*500+reservation.children*300);
		-- insert into values
 insert into studentdetails(firstname,lastname,course,branch) values("satish","naryana",5,3),("naryana","satish",5,3);
insert into studentdetails(firstname,lastname,course,branch) values("mushkan","saheed",1,1);
insert into studentdetails(firstname,lastname,course,branch) values("gokul","Kumar",2,1);
insert into studentdetails(firstname,lastname,course,branch) values("swathi","jayqas",2,1);
insert into studentdetails(firstname,lastname,course,branch) values("ishanth","sharma",3,2);
insert into studentdetails(firstname,lastname,course,branch) values("jadeja","ravidar",3,2);
insert into studentdetails(firstname,lastname,course,branch) values("surya","ks",5,3);
        
insert into marks(regno,physics,chemistry,maths,cs) values(1,79,89,78,99);       
        
insert into reservation values(1235,"amareshv","two biryani","2004-01-22",2,3,"booked",1900);
insert into reservation values(concat("2022","1111"),"hushika","biryani","2022-2-31",2,3,"booked",1900);
insert into reservation values(12335,"jeevam","four biryani","2004-3-22",2,3,"booked",3431);
insert into reservation values(1236,"amareshv","two biryani","2022-7-26",2,3,"cancelled",200);
insert into reservation values(12436,"gopi","two biryani","2022-7-26",2,6,"cancelled",5444);

insert into reservation (reservation_id,customer_name,reservation_discription,reservation_date,adult,children,total_amount) values(45944,"shiva","okbye","2022-6-23",2,7,8787);
insert into reservation (reservation_id,customer_name,reservation_date,adult,children,total_amount) values(35246,"shoiab","2022-6-23",2,7,8934);
insert into reservation (reservation_id,customer_name,adult,children,total_amount,phone_number) values(3466,"Jash",2,7,8080,9849799477);
insert into reservation (reservation_id,customer_name,adult,children,phone_number) values(334256,"loki",2,7,8554643336);
insert into reservation (reservation_id,customer_name,adult,children,phone_number) values(concat(year(now()),2011),"loki",2,7,8554643336);
insert into reservation (reservation_id,customer_name,adult,children,phone_number) values(concat(year(now()),7676),"madhan",3,9,8334553436);

insert into login values("arya@gmail.com", SHA1('ajay@123'),334256);

			-- update table
            
update  reservation set reservation_date="2021-8-2" where reservation_id=1234;
update reservation set reservation_discription="biryani" where reservation_id in (1234,1235);
update reservation set reservation.customer_name="javeed" where reservation_id=20222011;

-- update table with case for more than  2 values
update reservation set phone_number =case when reservation_id=1235 then 7567834444
										  when reservation_id=1236 then 9336698568
										  when reservation_id=4544 then 7567834444
									 END
                                        where reservation_id in(1235,1236,4544);
                                        
update reservation set phone_number =case when reservation_id=12335 then 7557834444
										  when reservation_id=12436 then 9339669568
										  when reservation_id=35246 then 9567834444
                                          when reservation_id=45944 then 8987834444
									 END
                                        where reservation_id in(12335,12436,35246,45944);

-- select statements with where clause

select * from reservation where total_amount>1000;

select * from reservation where total_amount>1000 and total_amount<2000;

select * from reservation where customer_name="amareshv";

select * from reservation where reservation_id in(1234,12436);

select * from reservation where status="booked" ;

select * from reservation where total_amount is not null;
select * from reservation where total_amount is null;

select * from reservation where reservation.adult >(4);

select firstname ,lastname  from studentdetails ;
select concat(firstname," ",lastname) as FullName from studentdetails ;


-- --top --  The SELECT TOP clause is used to specify the number of records to return.

select  * from reservation limit 4 ;
select * from reservation  where status="booked" limit 5;

-- order by --
select * from reservation order by reservation_id;
select * from reservation order by  customer_name desc;
select * from reservation order by reservation_date asc;		

select * from reservation where adult=2 and children=3;		
select reservation_id ,customer_name,status,total_amount from reservation where total_amount<100 or total_amount>2000;	

                                  -- min, max--  
select min(total_amount) as minimumamount from reservation;
select customer_name, max(total_amount) as maximumamount from reservation;

                          -- avg,count,sum
select avg(total_amount) from reservation;
select count(reservation_id) from reservation;
select sum(total_amount) from reservation;
 select sum(total_amount)/count(reservation_id) from reservation;
                                 
                                 -- like operator-- 
 select * from reservation where customer_name like "a%";
 select * from reservation where customer_name like "%a";
 select * from reservation where customer_name like "__o%";  -- displays 3 rd letter having o in the customername;
select * from reservation where customer_name like "%e%";
 select * from reservation where customer_name like "a%v";
select * from reservation where customer_name like '%[a-z]%';
                                 
                                 -- between
select * from reservation where customer_name between "amareshv" and "shiva" order by customer_name asc;
select * from reservation where total_amount between 400 and 1000 order by total_amount asc;
            
select * from reservation where customer_name not between "amareshv" and "shiva" order by customer_name asc;
select * from reservation where total_amount not between 400 and 1000 order by total_amount asc;
            
                               --  alias 
select reservation_id  as RESERVATION_TABLE_ID from reservation;
select total_amount  as RESERVATION_AMOUNT from reservation;
select reservation.customer_name as Name from reservation;

                                       -- --views-- 
create view noofpersons as select adult ,children from reservation where reservation_id in(1234,1235,1236);
create view booked as select* from reservation where status="booked";
create view cancelled as select * from reservation where status="cancelled";
create view confirmed as select * from reservation where status="confirmed";


									-- JOINS-- types inner,fullouter,right,left

-- inner join-

select reservation.customer_name ,reservation.reservation_id,login.username from reservation
inner join login on reservation.reservation_id=login.reservation_id;

select marks.totalmarks,marks.percentage ,studentdetails.firstname,studentdetails.lastname from studentdetails inner join marks on studentdetails.regno=marks.regno;

select login.username, reservation.customer_name,reservation.status,reservation.total_amount from login inner join reservation on reservation.reservation_id=login.reservation_id;

-- outer full join = leftjoin union rightjoin --
select login.username,reservation.phone_number,reservation.customer_name from reservation left join login on login.reservation_id=reservation.reservation_id
union
select login.username,reservation.phone_number,reservation.customer_name from reservation right join login on login.reservation_id=reservation.reservation_id;

-- right join --
select reservation.reservation_id , login.username from reservation right join login on reservation.reservation_id=login.reservation_id ;

select * from login right join reservation on reservation.reservation_id=login.reservation_id;
select * from reservation right join login on reservation.reservation_id=login.reservation_id;
-- left join --

select reservation.reservation_id , login.username from reservation left join login on reservation.reservation_id=login.reservation_id ;

select * from reservation left join login on reservation.reservation_id=login.reservation_id ;
select * from login left join reservation on reservation.reservation_id=login.reservation_id ;


-- union --
select login.reservation_id from login union select reservation.reservation_id from reservation;

-- having --
select * from reservation having count(reservation.adult);





truncate table reservation;-- to delete all the data in the table 
describe reservation;
describe login;
describe studentdetails;
describe marks;
select * from reservation;
select * from login;
select * from studentdetails;
select * from marks;


				-- sql functions
-- orderby --
select  reservation.reservation_date from reservation order by reservation.reservation_id asc;

select lower(username) as LOWER from login;
select upper(username) as LOWER from login;
select ltrim("       kjaf23akkjkfhlalll");
select rtrim("igfisfgsfkdsfjb                           "); ---- 'igfisfgsfkdsfjb'

select mid("Ajayarya",2,5);   -- 'jayar'
select repeat("Ajay  ",5); ---- 'Ajay  Ajay  Ajay  Ajay  Ajay  '
select replace("How are You","are","about");   -- REPLACE(string, from_string, new_string) -- 'How about You'
select reverse("ABCDEFGHIJKLMNOPQRSTUVXYZ"); -- 'ZYXVUTSRQPONMLKJIHGFEDCBA'
select right("JOCKY",4); -- 'OCKY'
select right("JOCKY",2); -- 'KY'
select right("JOCKY",5); -- 'KY'
select left("JOCKY",1); -- J
select substr("ABCDEFG",2,3); -- SUBSTR(string, start, length)            -- 'BCD'
select substring_index("AB.CD.E",'.' ,2); -- SUBSTRING_INDEX(string, delimiter, number)
select greatest(90,70,1000,222);
select least(90,70,1000,222);
select ln(2); -- natural logarithm;
select sum(reservation.total_amount) from reservation;

-- date functions
select adddate("2022-07-21", 10); -- ADDDATE(date, days)
select curdate(); -- returns todays date
select curdate() + 2; -- adds two more days 
select current_date();
select current_timestamp(); -- '2022-07-26 15:26:36'
select day(curdate());
select week(curdate());
select dayofweek(curdate());
select dayname(curdate()); -- 'Tuesday'
select year(curdate());
select monthname(curdate()); -- july
select now(); -- '2022-07-26 15:31:14'
select system_user(); -- 'root@localhost'
select cast("2022-2-2" as date); -- '2022-02-02'
select concat_ws('@',"Ajay","Arya"); -- 'Ajay@Arya'


