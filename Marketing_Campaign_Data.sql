use marketing_campaign;

# Q.Find the campaign name with the highest revenue.

select campaign_name, max(revenue)
from marketing_campaign_results
group by campaign_name
order by max(revenue) desc;

# Q.Find the campaign name with the highest revenue.

select campaign_name, revenue
from marketing_campaign_results
where revenue = (select max(revenue)
				from marketing_campaign_results);

select * from `campaign_performance`;

# Q: Show campaigns where CTR is higher than the average CTR.
select campaign_id, ctr
from campaign_performance
where ctr > (select avg(ctr)
             from campaign_performance);

# Q: Get the campaign(s) with the highest engagement score.
select campaign_id, max(engagement_score)
from campaign_performance
group by campaign_id;

# Q: Get campaign ID, clicks, revenue from both tables.

select cp.campaign_ID, cp.clicks, ms.revenue
from campaign_performance as cp
inner join marketing_campaign_results ms
on cp.campaign_id=ms.campaign_id;

select * from `marketing_campaign_results`;
select * from `campaign_performance`;

# Q: Combine list of campaign managers and statuses (with duplicates).

select campaign_manager from campaign_performance
union all
select status from marketing_campaign_results;

# Q: Combine all CTRs and conversion rates into one column.
select ctr
from campaign_performance
union all
select conversion_rate
from marketing_campaign_results;

# Q: Get unique campaign managers and campaign statuses.

select campaign_manager from campaign_performance
union 
select status from marketing_campaign_results;

# Q: Get a distinct list of all campaign IDs from both tables.
select campaign_id from campaign_performance
union 
select campaign_id  from marketing_campaign_results;

# Q: Combine all CTRs and conversion rates into one column.
select ctr
from campaign_performance
union all
select conversion_rate
from marketing_campaign_results;
# Q: Get a distinct list of all campaign IDs from both tables.

select campaign_id from marketing_campaign_results
union
select campaign_id from campaign_performance;

select * from `marketing_campaign_results`;
select * from `campaign_performance`;

# Q. List top 5 campaigns with highest CTR.

select campaign_id, ctr
from campaign_performance
order by ctr desc
limit 5;

# Q. Find channels having average revenue more than ₹75,000.

select channel, avg(revenue)
from marketing_campaign_results
group by channel
having avg(revenue) > 75000;

# Q. Count how many campaigns were run by each campaign manager.
select campaign_manager, count(campaign_id)
from campaign_performance
group by campaign_manager;

select * from `marketing_campaign_results`;
select * from `campaign_performance`;

# Q: Get all campaign IDs from both tables with available data from either side.

select campaign_id from marketing_campaign_results
union 
select campaign_id from campaign_performance;
# Q. Display top 5 campaigns by engagement score in descending order.

select campaign_id, engagement_score
from campaign_performance
order by engagement_score desc;
 
# Q. Delete campaigns that ended before 2023.
delete from marketing_campaign_results
where end_date < 2023;

# Q.compare current campaign’s revenue to the next campaign's.

select revenue,
lead(revenue) over (order by revenue) as "next_camp"
from marketing_campaign_results;

# Q. Find to see previous campaign's impressions.

select campaign_id, impressions,
lead(impressions) over (order by impressions) as "next_imp"
from campaign_performance;

# classify campaigns as 'High', 'Medium', or 'Low' engagement based on engagement_score.

select campaign_id, engagement_score, 
case
   when engagement_score > 5 then "High"
   when engagement_score between 3 and 5 then "Medium"
   else "Low"
end as "classify_campaigns"
from campaign_performance;
   
# Q. Find the average click-through rate (CTR) per manager.
select campaign_manager, avg(clicks*ctr)
from campaign_performance
group by campaign_manager; 

select * from `marketing_campaign_results`;
select * from `campaign_performance`;

# Q. Use ROW_NUMBER() to list top 3 campaigns per manager by engagement score.
select campaign_id, engagement_score, campaign_manager,
ROW_NUMBER() over (partition by campaign_manager order by engagement_score)
from campaign_performance;

# Q. Add a new column cost_per_lead to table.
alter table marketing_campaign_results
add column cost_per_lead varchar(10);

# Q. Update cost_per_lead using budget and leads_generated.
update marketing_campaign_results
set cost_per_lead=(budget*leads_generated)
where campaign_id='CMP00001';

# Q. Show total impressions and clicks only for campaigns where CTR > 10 AND engagement_score > 5.

select sum(impressions)
from campaign_performance
where CTR > 10 AND engagement_score > 5;

select * from `marketing_campaign_results`;
select * from `campaign_performance`;
# Q: List all performance metrics even if campaign name is missing.
select ms.campaign_name, cp.impressions, cp.ctr
from campaign_performance as cp
left join marketing_campaign_results as ms
on ms.campaign_id=cp.campaign_id;

# Q. Show campaigns with revenue between ₹50,000 and ₹1,00,000.
select campaign_id, campaign_name, revenue
from marketing_campaign_results
where revenue between 50000 and 100000;

# Q. Find FIRST_VALUE and LAST_VALUE revenue for each channel.
select channel, revenue,
first_value(revenue) over (partition by channel order by revenue) as "first_value",
last_value(revenue) over (partition by channel order by revenue) as "last_value"
from marketing_campaign_results;
select * from `marketing_campaign_results`;
select * from `campaign_performance`;
# Q1. Tag campaigns as "Success" or "Fail" based on conversion_rate >= 5.

select campaign_id,conversion_rate, 
case
   when conversion_rate >= 5 then "Success"
   else "Fail"
end as "Result"
from marketing_campaign_results;

# Q. Rank all campaigns based on revenue within each status.
select campaign_id, revenue, 
Rank() over (partition by status order by revenue)
from marketing_campaign_results;

# Q: Show revenue and CTR for all campaigns, including those without performance data.

select cp.CTR, ms.revenue
from campaign_performance as cp
inner join marketing_campaign_results ms
on cp.campaign_id=ms.campaign_id;

# Q. List all campaigns that have a conversion rate greater than 500%.
select campaign_id, campaign_name, conversion_rate
from marketing_campaign_results
where conversion_rate>(500/100);

select * from `marketing_campaign_results`;
select * from `campaign_performance`;
# Q. ALTER TABLE: Remove the notes column from campaign_performance.

alter table campaign_performance
drop column notes;

# : Combine campaign names and channels into a single list (distinct).

SELECT campaign_name FROM Marketing_Campaign_Results
UNION
SELECT channel FROM Marketing_Campaign_Results;

# Q. Extract month and year from start_date 

select 
   extract (month from start_date) as "st_date",
   extract (year from start_date) as "ye_date"
from marketing_campaign_results;

# Q. Remove campaigns that had zero impressions or clicks.

delete from campaign_performance
where impressions=0 and clicks=0;

select * from `marketing_campaign_results`;
select * from `campaign_performance`;

# Q: Get all campaign IDs from both tables.
select campaign_ID from marketing_campaign_results
union all
select campaign_ID from campaign_performance;

# Q: List all campaigns and include their performance if available.

select *
from campaign_performance as cp
left join marketing_campaign_results ms
on cp.campaign_id=ms.campaign_id
union
select *
from campaign_performance as cp
right join marketing_campaign_results ms
on cp.campaign_id=ms.campaign_id;

# Q: Find campaigns with higher revenue than the average revenue.

select campaign_id, campaign_name, revenue
from marketing_campaign_results
where revenue> (select avg(revenue)
				from marketing_campaign_results);

