create database PoulamiProject ;
use PoulamiProject;
select * from df_toronto_availability;
select * from listing_toronto_df;
drop table listing_toronto_df;
select * from review_vancouver_df;
select * from df_vancouver_availability;
 select * from host_vancouver_df;
 select * from host_toronto_df;
 select * from host_vancouver_df_new;
  select * from host_toronto_df_new;
 select * from listing_vancouver_df;
 select * from [dbo].[listing_toronto_df _new];
  ---a. Analyze different metrics to draw the distinction between Super Host and Other Hosts:
To achieve this, you can use the following metrics and explore a few yourself as well. 
	Acceptance rate, response rate, instant booking, profile picture, identity verified,
	review review scores, average no of bookings per month, etc. ----        
 ---toronto
 select a.host_is_superhost,a.host_identity_verified,a.host_has_profile_pic,b.instant_bookable,
 DATEPART(month,c.date)as month_number,DATEPART(year,c.date)as year_number,
 count(c.id)total_booking,count(a.host_is_superhost)as count_true_false,
 avg(a.host_acceptance_rate)as avg_acceptance,avg(a.host_response_rate)as avg_response,
 avg(b.review_scores_value)as avg_review from host_toronto_df_new as a inner join
 [dbo].[listing_toronto_df _new] as b on a.host_id=b.host_id join df_toronto_availability c on
 c.id = b.id group by host_is_superhost,a.host_identity_verified,a.host_has_profile_pic,
 b.instant_bookable,DATEPART(month,c.date),DATEPART(year,c.date) having host_is_superhost = 'true'
 or host_is_superhost='false' order by DATEPART(year,c.date) desc;


 select a.host_is_superhost,datename(month,c.date)as month_number,datename(year,c.date)as
 year_number,count(c.id) total_booking from  host_toronto_df_new as a inner join 
  [dbo].[listing_toronto_df _new] as b on a.host_id=b.host_id join df_toronto_availability 
  as c on c.id=b.id group by host_is_superhost,datename(month,c.date),datename(year,c.date) having 
 host_is_superhost = 'true'or host_is_superhost='false'order by datename(year,c.date) desc;

---vancouver
 select a.host_is_superhost,a.host_identity_verified,a.host_has_profile_pic,b.instant_bookable,
 DATEPART(month,c.date)as month_number,DATEPART(year,c.date)as year_number,
 count(c.id)total_booking,count(a.host_is_superhost)as count_true_false,
 avg(a.host_acceptance_rate)as avg_acceptance,avg(a.host_response_rate)as avg_response,
 avg(b.review_scores_value)as avg_review from host_vancouver_df_new as a inner join
 listing_vancouver_df as b on a.host_id=b.host_id join df_vancouver_availability c on
 c.id = b.id group by host_is_superhost,a.host_identity_verified,a.host_has_profile_pic,
 b.instant_bookable,DATEPART(month,c.date),DATEPART(year,c.date) having host_is_superhost = 'true'
 or host_is_superhost='false' order by DATEPART(year,c.date) desc;


 select a.host_is_superhost,datename(month,c.date)as month_number,datename(year,c.date)as
 year_number,count(c.id) total_booking from  host_vancouver_df_new as a inner join 
 listing_vancouver_df as b on a.host_id=b.host_id join df_vancouver_availability as c on 
 c.id=b.id group by host_is_superhost,datename(month,c.date),datename(year,c.date) having 
 host_is_superhost = 'true'or host_is_superhost='false'order by datename(year,c.date) desc;

 --b. Using the above analysis, identify top 3 crucial metrics one needs to maintain to
 become a Super Host and also, find their average values.----

 ---toronto
 select a.host_is_superhost,count(a.host_is_superhost)as count_true_false,
 avg(a.host_acceptance_rate)as avg_acceptance,avg(a.host_response_rate)as avg_response,
 avg(b.review_scores_value)as avg_review from host_toronto_df_new as a inner join 
 [dbo].[listing_toronto_df _new] as b on a.host_id=b.host_id group by host_is_superhost having  
 host_is_superhost = 'true'or host_is_superhost='false';

 select host_is_superhost ,count(host_has_profile_pic)as got_profile_pic from host_toronto_df_new 
 where host_is_superhost = 'true'or host_is_superhost='false' group by  host_is_superhost;

 select host_is_superhost ,count(host_identity_verified)as got_identify_verified from host_toronto_df_new 
 where host_is_superhost = 'true'or host_is_superhost='false' group by  host_is_superhost;


 ---vancouver
 select a.host_is_superhost,count(a.host_is_superhost)as count_host_superhost,
 avg(a.host_acceptance_rate)as avg_acceptance,avg(a.host_response_rate)as avg_response,
 avg(b.review_scores_value)as avg_review from host_vancouver_df_new as a inner join 
 listing_vancouver_df as b on a.host_id=b.host_id group by host_is_superhost having  
 host_is_superhost = 'true'or host_is_superhost='false';
   
   select host_is_superhost ,count(host_has_profile_pic)as got_profile_pic from host_vancouver_df_new 
 where host_is_superhost = 'true'or host_is_superhost='false' group by  host_is_superhost;

 select host_is_superhost ,count(host_identity_verified)as got_identify_verified from host_toronto_df_new 
 where host_is_superhost = 'true'or host_is_superhost='false' group by  host_is_superhost;


   
---c. Analyze how does the comments of reviewers vary for listings of Super Hosts vs Other Hosts
(Extract words from the comments provided by the reviewers)-------
select * from listing_vancouver_df;
 select * from host_vancouver_df_new;
 select * from review_vancouver_df;

 --vancouver
 select top 10 h.host_id,h.host_name,h.host_is_superhost,r.reviewer_name,r.comments 
 from host_vancouver_df_new as h join
 listing_vancouver_df 
 as l on h.host_id=l.host_id join  review_vancouver_df as r on l.id=r.listing_id where
 h.host_is_superhost = 'false' and r.comments 
 like '%good%';


 select top 10 h.host_id,h.host_name,h.host_is_superhost,r.reviewer_name,r.comments from 
 host_vancouver_df_new as h join
 listing_vancouver_df 
 as l on h.host_id=l.host_id join  review_vancouver_df as r on l.id=r.listing_id where
 h.host_is_superhost = 'true' 
 and r.comments 
 like '%good%';
 ---toronto
  select top 10 h.host_id,h.host_name,h.host_is_superhost,r.reviewer_name,r.comments 
 from host_toronto_df_new as h join
 [dbo].[listing_toronto_df _new]
 as l on h.host_id=l.host_id join  review_toronto_df as r on l.id=r.listing_id where
 h.host_is_superhost = 'false' and r.comments 
 like '%good%';

 select top 10 h.host_id,h.host_name,h.host_is_superhost,r.reviewer_name,r.comments from 
 host_toronto_df_new as h join
 [dbo].[listing_toronto_df _new]
 as l on h.host_id=l.host_id join  review_toronto_df as r on l.id=r.listing_id where
 h.host_is_superhost = 'true' 
 and r.comments 
 like '%good%';


  

  
 

d. Analyze do Super Hosts tend to have large property types as compared to Other Hosts
 select * from [dbo].[listing_toronto_df _new];
  select * from host_toronto_df_new;
  select top 10 a.id,max(a.latitude)as length_,max(a.longitude)as width_,a.property_type,
  a.room_type,a.accommodates,
  a.bedrooms,b.host_id,b.host_name,b.host_is_superhost from [dbo].[listing_toronto_df _new] as a
  inner join host_toronto_df_new as b 
  on a.host_id=b.host_id group by a.id,b.host_is_superhost,a.property_type,a.room_type,
  a.accommodates, a.bedrooms,b.host_id,b.host_name
  having 
 host_is_superhost='false';


 --d. Analyze do Super Hosts tend to have large property types as compared to Other Hosts--
 ---vancouver
 select top 10 l.property_type,l.accommodates,h.host_is_superhost, case when l.accommodates>15 then 
 'l' else 's'end property_size,l.host_id from  listing_vancouver_df as l inner join
 host_vancouver_df_new as h on l.host_id=h.host_id group by l.property_type,l.accommodates,
 h.host_is_superhost,l.host_id order by accommodates desc;
 ---toronto
  select top 10 l.property_type,l.accommodates,h.host_is_superhost, case when l.accommodates>15 
  then 'l' else 's'end property_size,l.host_id from  [dbo].[listing_toronto_df _new] as l inner 
  join host_toronto_df_new as h on l.host_id=h.host_id group by l.property_type,l.accommodates,
 h.host_is_superhost,l.host_id order by accommodates desc;
  
    select top 10 a.id,max(a.latitude)as length_,max(a.longitude)as width_,a.property_type,a.room_type,a.accommodates,
  a.bedrooms,b.host_id,b.host_name,b.host_is_superhost from [dbo].[listing_toronto_df _new] as a inner join host_toronto_df as b 
  on a.host_id=b.host_id group by a.id,b.host_is_superhost,a.property_type,a.room_type,a.accommodates, a.bedrooms,b.host_id,b.host_name
  having host_is_superhost = 'true';

-- e. Analyze the average price and availability of the listings for the upcoming year between
Super Hosts and Other Hosts---
 select * from df_toronto_availability;
   select * from host_toronto_df;
   ---toronto
   select datepart(year,a.date) as year_no,avg(a.price) as avg_price,a.available,b.host_name,
   b.host_is_superhost from df_toronto_availability as a 
   join [dbo].[listing_toronto_df _new] as c on a.listing_id=c.id join host_toronto_df_new as b
   on c.host_id=b.host_id where datepart(year,a.date)='2023' and a.available='true' group by
   b.host_is_superhost,b.host_name,datepart(year,a.date),a.available having host_is_superhost =
   'true';

   select distinct datepart(year,a.date) as year_no,avg(a.price) as avg_price,count(a.available) Count_availability from df_toronto_availability as a 
   join [dbo].[listing_toronto_df _new] as c on a.listing_id=c.id join host_toronto_df as b on c.host_id=b.host_id where 
   datepart(year,a.date)='2023' and a.available='true' group by b.host_is_superhost,
   datepart(year,a.date),a.available having b.host_is_superhost = 'true';

     select distinct datepart(year,a.date) as year_no,avg(a.price) as avg_price,count(a.available) Count_availability from df_toronto_availability as a 
   join [dbo].[listing_toronto_df _new] as c on a.listing_id=c.id join host_toronto_df as b on c.host_id=b.host_id where 
   datepart(year,a.date)='2023' and a.available='true' group by b.host_is_superhost,
   datepart(year,a.date),a.available having b.host_is_superhost = 'false';

   ---vancouver
   select datepart(year,a.date) as year_no,avg(a.price) as avg_price,a.available,b.host_name,
   b.host_is_superhost from df_vancouver_availability as a 
   join listing_vancouver_df as c on a.listing_id=c.id join host_vancouver_df_new as b
   on c.host_id=b.host_id where datepart(year,a.date)='2023' and a.available='true' group by
   b.host_is_superhost,b.host_name,datepart(year,a.date),a.available having host_is_superhost =
   'true';
   select distinct datepart(year,a.date) as year_no,avg(a.price) as avg_price,count(a.available) 
   Count_availability from df_vancouver_availability as a join listing_vancouver_df as
   c on a.listing_id=c.id join host_vancouver_df_new as b on c.host_id=b.host_id where 
   datepart(year,a.date)='2023' and a.available='true' group by b.host_is_superhost,
   datepart(year,a.date),a.available having b.host_is_superhost = 'true';

     select distinct datepart(year,a.date) as year_no,avg(a.price) as avg_price,count(a.available) 
	 Count_availability from df_vancouver_availability as a join listing_vancouver_df as c on a.listing_id
	 =c.id join host_vancouver_df_new as b on c.host_id=b.host_id where 
   datepart(year,a.date)='2023' and a.available='true' group by b.host_is_superhost,
   datepart(year,a.date),a.available having b.host_is_superhost = 'false';


---f. Analyze if there is some difference in above mentioned trends between Local Hosts or
Hosts residing in other locations---
----toronto---
select host_location,host_name,host_neighbourhood,host_is_superhost from host_toronto_df_new
where 
host_is_superhost ='true' or 
host_is_superhost ='false';
---vancouver---
select host_location,host_name,host_neighbourhood,host_is_superhost from host_vancouver_df_new
where host_is_superhost ='true' or
host_is_superhost ='false';




--g. Analyze the above trends for the two cities for which data has been provided and
provide insights on comparison----

  


