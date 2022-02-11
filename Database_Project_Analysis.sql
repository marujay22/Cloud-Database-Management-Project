create DATABASE cloud
GO

use cloud
GO

--DOWN

drop table if EXISTS cloud_details
drop table if EXISTS sector_detail
drop table if EXISTS finances
drop table if EXISTS companyy


drop table if exists sector

drop table if exists cloud_detail

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_companys_cloud_id')
    alter table company drop CONSTRAINT fk_companys_cloud_id, fk_companys_sector_id
 drop table if exists company

if exists (select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME='fk_finances_finance_company_id')
    alter table finance drop constraint fk_finances_finance_company_id
 drop table if exists finance


--UP Metadata

--- create the table in the order given below.

create table sector(
	sector_id int identity not null,
	sector_name varchar(50) not null,
	sector_percentage_growth float not null,
	constraint pk_sectors_sector_id primary key(sector_id),
	constraint u_sectors_sector_name UNIQUE(sector_name)
)
GO

create table cloud_detail(
    cloud_id int identity not null,
    migrated_to_service varchar(20) not null,
    cloud_type varchar(20) not null,
    service_model_name varchar(20) not null,
	CONSTRAINT pk_contractors_contractor_id primary key(cloud_id)
 )
 GO

create table company(
    company_id int IDENTITY not null,
    company_name varchar(50) not null,
    company_year_founded int not null,
	company_category varchar(50) not null,
    company_city varchar(20) not null,
    company_state char(2) not null,
	company_zipcode int not null,
	company_website varchar(50) not null,
    company_migration_year int not null,
    company_sector_id int not null,
    company_cloud_id int not null,
    CONSTRAINT pk_companys_company_id primary key(company_id),
    constraint u_companys_company_email UNIQUE(company_website),
 )
 GO

create table finance(
    finance_id int identity not null,
    cloud_budget float not null,
	prev_budget float not null,
	migration_cost float not null,
	current_budget float not null,
    finance_company_id int not null,
    CONSTRAINT ck_customers_valid_prices CHECK(cloud_budget<= current_budget),
    constraint pk_finances_finance_id primary key(finance_id)
)
GO
    
alter table finance
    add constraint fk_finances_finance_company_id foreign key (finance_company_id)
        REFERENCES company(company_id)
GO

alter table company
    add constraint fk_companys_cloud_id foreign key (company_cloud_id)
    REFERENCES cloud_detail(cloud_id),
    constraint fk_companys_sector_id foreign KEY(company_sector_id) REFERENCES sector(sector_id)
GO


--- UP

---execute the insert query in the order given.

--cloud detail table
Insert into cloud_detail values ('AWS','Hybrid Cloud','IaaS')
Insert into cloud_detail values ('AWS','Public Cloud','SaaS')
Insert into cloud_detail values ('AWS','Private Cloud','IaaS')
Insert into cloud_detail values ('Microsoft Azure','Hybrid Cloud','SaaS')
Insert into cloud_detail values ('Microsoft Azure','Public Cloud','PaaS')
Insert into cloud_detail values ('Microsoft Azure','Private Cloud','IaaS')
Insert into cloud_detail values ('Google Cloud','Hybrid Cloud','SaaS')
Insert into cloud_detail values ('Google Cloud','Public Cloud','PaaS')
Insert into cloud_detail values ('Google Cloud','Private Cloud','IaaS')
Insert into cloud_detail values ('IBM','Hybrid Cloud','PaaS')
Insert into cloud_detail values ('IBM','Public Cloud','SaaS')
Insert into cloud_detail values ('IBM','Private Cloud','IaaS')
Insert into cloud_detail values ('Oracle','Hybrid Cloud','SaaS')
Insert into cloud_detail values ('Oracle','Public Cloud','IaaS')
Insert into cloud_detail values ('Oracle','Private Cloud','PaaS')

--sector table
Insert into sector values ('Media',10)
Insert into sector values ('Technology',30.2)
Insert into sector values ('Ecommerce',15.6)
Insert into sector values ('Electronics',20.3)
Insert into sector values ('Professional services',11)
Insert into sector values ('Pharma',29)
Insert into sector values ('Aerospace',9)
Insert into sector values ('Products',17)
Insert into sector values ('Automobile',7)
Insert into sector values ('Retailer',22.4)
Insert into sector values ('Service Provider',10)
Insert into sector values ('Payment service',35)
Insert into sector values ('Banking',12)
Insert into sector values ('Food',27.8)

--company table
Insert into company values ('Netflix',1997,'Media','Scotts Valley','CA',95066,'www.netflix.com',2008,1,10)
Insert into company values ('Xerox',1906,'Technology','Rochester','NY',14602,'www.xerox.com',2012,2,14)
Insert into company values ('Pinterest',2009,'Media','San Francisco','CA',94016,'www.pinterest.com',2017,11,9)
Insert into company values ('Instagram',2010,'Media','San Francisco','CA',94105,'www.instagram.com',2010,1,1)
Insert into company values ('Etsy',2005,'Ecommerce','Brooklyn','NY',11201,'www.etsy.com',2020,12,4)
Insert into company values ('Apple',1976,'Electronics','Los Altos','CA',94022,'www.apple.com',2016,4,7)
Insert into company values ('MediaMath',2007,'Media','New York City','NY',10008,'www.mediamath.com',2014,6,2)
Insert into company values ('Pearson',1998,'Media','London','UK',31642,'www.pearson.com',2012,1,12)
Insert into company values ('Deloitte',1845,'Professional services','London','UK',35203,'www.deloitte.com',2017,5,7)
Insert into company values ('Wipro',1945,'Professional services','Bengaluru','IN',560035,'www.wipro.com',2014,13,3)
Insert into company values ('Goldman Sachs',1869,'Professional services','New York City','NY',10001,'www.goldmansachs.com',2013,5,11)
Insert into company values ('Pfizer',1849,'Pharma','Brooklyn','NY',11208,'www.pfizer.com',2016,6,13)
Insert into company values ('Boeing',1916,'Aerospace','Seattle','WA',98124,'www.boeing.com',2011,7,8)
Insert into company values ('Nike',1964,'Products','Eugene','OR',97401,'www.nike.com',2017,8,3)
Insert into company values ('Dollar General',1939,'Retailer','Scottsville','KY',42164,'www.dollargeneral.com',2011,10,11)
Insert into company values ('Tesla',2003,'Automobile','San Carlos','CA',94070,'www.tesla.com',2012,9,1)
Insert into company values ('Nvidia',1993,'Technology','Santa Clara','CA',95050,'www.nvidia.com',2015,2,14)
Insert into company values ('United Airlines Holdings',1968,'Aerospace','Chicago','IL',60007,'www.unitedairlinesholdings.com',2010,7,9)
Insert into company values ('Nordstrom',1901,'Retailer','Seattle','WA',98101,'www.nordstrom.com',2013,10,5)
Insert into company values ('Uber Technologies',2009,'Service Provider','San Francisco','CA',94102,'www.uber.com',2019,11,8)
Insert into company values ('Ford',1903,'Automobile','Detroit','MI',48127,'www.ford.com',2018,9,2)
Insert into company values ('PayPal',1998,'Payment service','Palo Alto','CA',94020,'www.paypal.com',2016,12,15)
Insert into company values ('Spotify',2006,'Media','Stockholm','SW',10316,'www.spotify.com',2018,1,6)
Insert into company values ('Motorola',1928,'Electronics','Chicago','IL',60018,'www.motorola.com',2015,4,5)
Insert into company values ('Citi',1812,'Banking','New York City','NY',10004,'www.citi.com',2015,13,12)
Insert into company values ('Huntington',1866,'Banking','Columbus','OH',43004,'www.huntington.com',2016,13,13)
Insert into company values ('Whirpool',1911,'Electronics','Benton Harbor','MI',49022,'www.whirpool.com',2018,4,10)
Insert into company values ('Zoom',2011,'Media','San Jose','CA',94088,'www.zoom.com',2020,1,4)
Insert into company values ('Disney',1923,'Media','Los Angeles','CA',90001,'www.disney.com',2015,2,15)
Insert into company values ('Mcdonalds',1955,'Food','San Bernardino','CA',92401,'www.mcdonalds.com',2010,14,11)
Insert into company values ('Nasa',1958,'Aerospace','Washington DC','WA',20001,'www.nasa.com',2011,7,6)
Insert into company values ('Unilever',1929,'Products','London','UK',07632,'www.unilever.com',2012,8,3)

--finance table
Insert into finance values (1000000000,5900000,9000000,2100000000,1)
Insert into finance values (3000000,1200000,230000,15000000,2)
Insert into finance values (1400000,230000,500000,23000000,3)
Insert into finance values (780000000,23000000,460000000,20000000000,4)
Insert into finance values (395868544,243499857,196449300,2122680405,5)
Insert into finance values (1425521742,538226546,129083005,2242347992,6)
Insert into finance values (1996732774,1921809181,154896705,7041769245,7)
Insert into finance values (1622784181,558232790,19904433,9949077094,8)
Insert into finance values (1732686569,1203412299,575225328,3239761659,9)
Insert into finance values (2045340132,1676001144,1215950888,8900462675,10)
Insert into finance values (1488390942,734952381,154599195,4177722507,11)
Insert into finance values (531393923,28918826,17483793,6042369003,12)
Insert into finance values (1390625426,453374744,197591127,2071115171,13)
Insert into finance values (656240862,445193395,428640615,8786354231,14)
Insert into finance values (2380684780,1684204258,217066972,2770962766,15)
Insert into finance values (1187786167,1022701018,124740770,6513809931,16)
Insert into finance values (1297442900,1262266913,879999445,4129308776,17)
Insert into finance values (1964600199,1645637468,1062290556,7440651107,18)
Insert into finance values (1015210762,76264170,18564380,2354683695,19)
Insert into finance values (1838665453,408349147,26966623,5805938722,20)
Insert into finance values (845841245,659009611,12217423,1497314264,21)
Insert into finance values (2450985942,1447998521,755598234,3459344501,22)
Insert into finance values (1104666395,112576084,40355832,9941822747,23)
Insert into finance values (1868143569,926146370,850424217,7891095702,24)
Insert into finance values (1997608730,469892984,270365498,4931976752,25)
Insert into finance values (1251994243,361835871,323873581,7687179865,26)
Insert into finance values (2814158559,1199147373,532082017,6669525114,27)
Insert into finance values (2594349962,1790581752,1101195574,3266393865,28)
Insert into finance values (1273762893,994942096,56676545,5862646535,29)
Insert into finance values (586831599,440639441,165351385,8922154059,30)
Insert into finance values (1294094409,402937303,264328570,2425196195,31)
Insert into finance values (1933793612,1815490340,563907698,7175096977,32)

--select queries
select * from cloud_detail
select * from sector
select * from company
select * from finance 


--Queries 

1) Compute the total budget left after allocating the current budget to cloud & migration cost (using cast function)

select cast(current_budget as money)-cast(cloud_budget as money) - cast(migration_cost as money) as total_budget_left from finance

2) Show the companies which migrated 10 years after their foundation

select * from company where company_migration_year - company_year_founded <=10

3) Find the sector with most number of companies who migrated to a cloud and their average percentage growth

SELECT s.sector_name,COUNT(c.company_category) as mycount,sector_percentage_growth  
FROM company c join sector s on c.company_sector_id=s.sector_id GROUP BY sector_name,sector_percentage_growth order by count(company_category) desc

4) Companies apart from the media category who have migrated to cloud after 2015 and using SaaS model?

select * from company c left join cloud_detail d on c.company_cloud_id = d.cloud_id 
where c.company_migration_year >= 2015 and d.service_model_name='Saas' and c.company_category != 'Media'

5) Select top 5 companies who have migrated to AWS hybrid cloud service

select top 5*
    from Company c
    join Cloud_detail i on c.company_cloud_id=i.cloud_id
     where i.migrated_to_service='AWS' AND i.cloud_type='Hybrid Cloud'
     ORDER BY c.company_name

6) show the details of companies in the Technology sector that have migrated to cloud?

select * from Company
WHERE company_category='technology'

7) Total number of companies that have opted for Public cloud service?

select c.company_name,c.company_year_founded,c.company_category,c.company_state,c.company_zipcode,c.company_website,c.company_migration_year,i.migrated_to_service,i.cloud_type
    from Company c
     join Cloud_detail i on c.company_cloud_id=i.cloud_id
     where i.cloud_type='Public Cloud'
     ORDER BY c.company_name

8) Companies with migration cost more than 40 % of the total budget?

select c.company_name,c.company_year_founded,c.company_category,c.company_state,c.company_zipcode,c.company_website,c.company_migration_year
    from Company c
        join Finance f on c.company_id=f.finance_company_id
        WHERE f.migration_cost> 0.4*f.migration_cost

--CASE
SELECT sector_name,sector_percentage_growth,
CASE
    WHEN sector_percentage_growth < 10 THEN 'This sector has the lowest percentage growth rate'
    WHEN sector_percentage_growth>10 AND sector_percentage_growth<20  THEN 'This sector has a better percentage growth rate'
    WHEN sector_percentage_growth>20 AND sector_percentage_growth<30  THEN 'This sector has grown by 20 to 30 percent percentage growth rate'
    ELSE 'This sector has the best growth rate'
END AS TotalGrowth
FROM Sector
ORDER BY sector_percentage_growth desc 

--- Function with Concat
drop function if exists f_concat
go
-- UP Metadata
create function f_concat(
    @company_name varchar(100), @company_state varchar(100), @sep varchar(5) 
)   returns varchar(20) as
BEGIN 
    return @company_name + @sep + @company_state
END
go

select dbo.f_concat(company_name,company_state,'-') as value from company


--- Views

drop view if exists v_company
go
-- UP Metadata
CREATE VIEW v_company AS
SELECT top 5 dbo.f_concat(c.company_name,s.sector_name,',') as company_sector,c.company_id,c.company_year_founded,c.company_city,c.company_state,c.company_zipcode,
c.company_website,c.company_migration_year,s.sector_percentage_growth FROM company c join sector s on c.company_sector_id= s.sector_id
GO
select * from v_company

-- String split & cross apply

select company_id, company_state, value from company cross apply string_split(company_city,' ')


select cloud_id, migrated_to_service, service_model_name , value from cloud_detail cross apply string_split(cloud_type,' ')


--- Function with String Search
drop function if exists f_search_company
go

create function f_search_company(
    @company_website varchar(50)
)returns table AS
return
    select company_id,company_name,company_category, company_state, company_zipcode, company_city, value from 
    company cross apply string_split(company_website,'.') sear where sear.value=@company_website
GO

select * from dbo.f_search_company('www')


---Triggers

alter table finance
add fin_stat varchar(20)
GO

drop trigger if exists t_company
GO

create trigger t_company on finance
    after update as 
BEGIN
    update finance set fin_stat=
    CASE
    when migration_cost>prev_budget then 'Unstable Budget'
    when migration_cost<prev_budget then 'Stable Budget'
    end
END

update finance set migration_cost=6000000 where finance_id=1
   
select * from finance where finance_id=1

update finance set migration_cost=5800000 where finance_id=1

select * from finance where finance_id=1


