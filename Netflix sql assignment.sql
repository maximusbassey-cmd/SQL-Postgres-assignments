--Problem 1: Latest Performance Snapshot per Movie
--Netflix wants only the most recent performance record for each movie.
--👉 Retrieve one row per movie, showing:
--movie title
--latest end_date
--Views
--hours_viewed

select distinct on(m.title) m.title, v.end_date, v.views,v.hours_viewed
from movie as m
join view_summary as v
on m.id = v.movie_id
order by m.title, v.end_date desc;

--Problem 2: Most Recent Season Performance per TV Show
--For each TV show, retrieve only the latest season performance based on end_date.
--Include:
--TV show title
--season number
--end_date
--Views

select t.title as tv_show_title, s.season_number, v.end_date,v.views
from tv_show as t
join season as s
on t.id = s.tv_show_id
join view_summary as v
on s.id = v.season_id
order by v.end_date desc;

--Problem 3: Movies That Have Viewing Data
--The content team wants to analyze only movies that actually have viewer activity.
--👉 List:
--movie title
--release date
--total views
--total hours viewed
--Only include movies that exist in view_summary.
select m.title, m.release_date, sum(v.views) as total_views, 
sum(v.hours_viewed) as total_hours_viewed
from view_summary as v
join movie as m
on v.movie_id = m.id
group by m.title, m.release_date;

--Problem 4: Seasons with Recorded Viewership
--Retrieve all TV show seasons that have at least one viewing record.
--Include:
--TV show title
--season number
--views
--hours viewed
select t.title as tv_show_title, s.season_number, sum(v.views)as views, sum(v.hours_viewed) as hours_viewed
from tv_show as t
join season as s
on t.id = s.tv_show_id
join view_summary as v
on s.id = v.season_id
group by t.title,s.season_number;

--Problem 5: Movies Without Any Viewership
--Netflix wants to identify underperforming or newly released movies.
--👉 Retrieve all movies, including those with zero viewing records.
--Show:
--movie title
--release date
--views (NULL if none)

select m.title as movie_title, m.release_date, sum(v.views) as views
from movie as m
left join view_summary as v
on m.id = v.movie_id
group by m.id
order by m.release_date desc;

--Problem 6: TV Shows and Their Seasons (Even If Unwatched)
--List all TV shows and their seasons, including seasons that have never been viewed

select t.title as tv_show_title, s.season_number, v.views
from tv_show as t
join season as s
on t.id = s.tv_show_id
join view_summary as v
on s.id = v.season_id;

--Problem 7: Viewing Records Without Movie Metadata
--The data quality team suspects some orphaned view records.
--👉 Find viewing summaries that exist without a matching movie record.
--Return:
--view_summary.id
--movie_id
--views

select v.id as view_summary_id, m.id, v.views
from view_summary as v
left join movie as m
on v.movie_id = m.id
where m.id is null and v.season_id is null;

--Problem 8: Content Coverage Audit
--Netflix wants to audit content data completeness.
--👉 Produce a report that includes:
--All movies
--All view summaries
--Even when one side is missing.
--Show:
--movie title
--views
--start_date
--end_date

select m.title as movie_title, v.views,v.start_date, v.end_date
from movie as m
full outer join view_summary as v
on m.id = v.movie_id;

--Problem 9: Movies That Have NEVER Been Viewed
--Marketing wants to run promotions for content that has zero engagement.
--👉 Return all movies that do not appear in view_summary.

select m.title as movie_title, v.movie_id as view_summary_id, v.views
from movie as m
left join view_summary as v
on m.id = v.movie_id
where v.movie_id is null;

--Problem 10: Seasons Without Any View Records
--Identify TV show seasons that were released but never watched.

select t.title as tv_show_title, s.season_number,s.release_date, v.views
from tv_show as t
join season as s
on t.id = s.tv_show_id
join view_summary as v
on s.id = v.season_id
where s.release_date is not Null and v.views = null;

--Problem 11: View Records Without Valid Seasons
--Find view records that reference a season_id that does not exist in the season table.
--This helps detect broken foreign key references.

select  v.views, v.hours_viewed,v.season_id ,s.id as season_table_id
from view_summary as v
left join season as s
on v.season_id = s.id
where s.id is null and v.season_id is not null;

--Problem 12: Data Integrity Check
--Identify:
--Movies with no view data
--View summaries that do not map to any movie
--Return a unified report showing mismatches from both sides.

select m.id, m.title,v.id as view_summary_id,v.views
from movie as m
full outer join view_summary as v
on m.id = v.movie_id
where m.id is not null and v.movie_id is null
or m.id is null and v.movie_id is not null;

--Problem 13: Weekly Performance Report for TV Shows
--Netflix executives want a weekly performance dashboard.
--👉 For each viewing record, show:
--TV show title
--season number
--start_date
--end_date
--views
--hours_viewed
--view_rank

select t.title as tv_show_title, s.season_number,v.start_date,
v.end_date, v.views, v.hours_viewed, v.view_rank
from tv_show as t
join season as s
on t.id = s.tv_show_id
join view_summary as v
on s.id = v.season_id;

--Problem 14: Global Availability vs Performance
--Analyze how global availability affects performance.
--👉 Retrieve:
--movie title
--available_globally
--total views
--total hours viewed

select m.title as movie_title, m.available_globally, sum(v.views) as total_views,
sum(v.hours_viewed) as total_hours_viewed
from movie as m
join view_summary as v
on m.id = v.id
group by m.id;

--Problem 15: Top-Performing Content by Locale
--Product wants to understand regional performance.
--👉 For each locale:
--list the top-ranked movie or season
--based on lowest view_rank


