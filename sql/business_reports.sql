-- Netflix Content Quality Analysis - Business Reports

-- ============================================
-- REPORT 1: Overview - Overall Statistics
-- ============================================
SELECT 
    COUNT(*) as total_titles,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) as total_movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) as total_tv_shows,
    COUNT(CASE WHEN rating IS NOT NULL THEN 1 END) as titles_with_rating,
    COUNT(CASE WHEN director IS NOT NULL AND cast IS NOT NULL AND country IS NOT NULL THEN 1 END) as titles_with_full_metadata
FROM netflix_cleaned;

-- ============================================
-- REPORT 2: TOP 10 Countries by Content Count
-- ============================================
-- Which countries produce the most content?

SELECT 
    country,
    COUNT(*) as content_count,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) as movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) as tv_shows,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_cleaned), 2) as percentage
FROM (
    SELECT 
        show_id,
        type,
        TRIM(value) as country
    FROM netflix_cleaned
    CROSS APPLY STRING_SPLIT(country, ',')
) as split_countries
GROUP BY country
HAVING COUNT(*) >= 10  -- Only countries with at least 10 titles
ORDER BY content_count DESC
LIMIT 10;

-- ============================================
-- REPORT 3: Genre Distribution
-- ============================================
-- Which genres are most popular?

SELECT 
    listed_in as genre,
    COUNT(*) as title_count,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) as movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) as tv_shows,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_cleaned), 2) as percentage
FROM (
    SELECT 
        show_id,
        type,
        TRIM(value) as listed_in
    FROM netflix_cleaned
    CROSS APPLY STRING_SPLIT(listed_in, ',')
) as split_genres
GROUP BY listed_in
ORDER BY title_count DESC
LIMIT 15;

-- ============================================
-- REPORT 4: Movie vs TV Show Comparison
-- ============================================
-- Detailed comparison between Movies and TV Shows

SELECT 
    type,
    COUNT(*) as total_count,
    COUNT(CASE WHEN rating IS NOT NULL THEN 1 END) as with_rating,
    COUNT(CASE WHEN director IS NOT NULL THEN 1 END) as with_director,
    COUNT(CASE WHEN cast IS NOT NULL THEN 1 END) as with_cast,
    COUNT(CASE WHEN country IS NOT NULL THEN 1 END) as with_country,
    AVG(CASE WHEN type = 'Movie' THEN CAST(REPLACE(REPLACE(duration, ' min', ''), ' min', '') AS INT) END) as avg_duration_minutes
FROM netflix_cleaned
GROUP BY type;

-- ============================================
-- REPORT 5: Content Over the Years (Trend Analysis)
-- ============================================
-- When was most content produced? Shows content growth trends

SELECT 
    release_year,
    COUNT(*) as content_count,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) as movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) as tv_shows,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_cleaned WHERE release_year IS NOT NULL), 2) as percentage
FROM netflix_cleaned
WHERE release_year IS NOT NULL
  AND release_year >= 2000  -- Only modern years
GROUP BY release_year
ORDER BY release_year DESC
LIMIT 20;

-- ============================================
-- REPORT 6: New Content Added by Month
-- ============================================
-- Which months had the most new content added to Netflix? Important for content strategy

SELECT 
    FORMAT(CAST(date_added AS DATE), 'yyyy-MM') as month_added,
    COUNT(*) as titles_added,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) as movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) as tv_shows,
    COUNT(CASE WHEN listed_in LIKE '%Anime%' OR listed_in LIKE '%Anime Series%' THEN 1 END) as anime_count
FROM netflix_cleaned
WHERE date_added IS NOT NULL
  AND CAST(date_added AS DATE) >= '2020-01-01'  -- Recent additions only
GROUP BY FORMAT(CAST(date_added AS DATE), 'yyyy-MM')
ORDER BY month_added DESC
LIMIT 24;  -- Last 24 months

-- ============================================
-- REPORT 7: Data Quality by Type
-- ============================================
-- Which content type has better data quality? Critical for data engineering

SELECT 
    type,
    COUNT(*) as total,
    COUNT(CASE WHEN director IS NOT NULL THEN 1 END) as with_director,
    COUNT(CASE WHEN cast IS NOT NULL THEN 1 END) as with_cast,
    COUNT(CASE WHEN country IS NOT NULL THEN 1 END) as with_country,
    COUNT(CASE WHEN rating IS NOT NULL THEN 1 END) as with_rating,
    COUNT(CASE WHEN description IS NOT NULL THEN 1 END) as with_description,
    COUNT(CASE WHEN director IS NOT NULL AND cast IS NOT NULL AND country IS NOT NULL 
               AND rating IS NOT NULL AND description IS NOT NULL THEN 1 END) as fully_complete,
    ROUND(COUNT(CASE WHEN director IS NOT NULL AND cast IS NOT NULL AND country IS NOT NULL 
               AND rating IS NOT NULL AND description IS NOT NULL THEN 1 END) * 100.0 / COUNT(*), 2) as completeness_pct
FROM netflix_cleaned
GROUP BY type;

-- ============================================
-- NOTES:
-- ============================================
-- 
-- 1. These queries use the cleaned data from:
--    data/processed/netflix_cleaned.csv
--
-- 2. For some databases you need to adjust the syntax:
--    - SQL Server: STRING_SPLIT() works as above
--    - MySQL: Use SUBSTRING_INDEX() instead of STRING_SPLIT()
--    - PostgreSQL: Use unnest(string_to_array(...))
--    - SQLite: Requires custom functions
--
-- 3. First import the cleaned data into your database:
--    - Import CSV as table "netflix_cleaned"
--
-- 4. These reports focus on business-critical insights:
--    - Content portfolio analysis (countries, genres)
--    - Trend analysis (content growth over time)
--    - Content release strategy (new titles added per month)
--    - Data quality metrics (essential for data engineering)
--    - Business comparisons (Movie vs TV Show performance)
--
-- NOTE: This dataset does NOT contain viewing/streaming data.
--       We analyze content metadata, not viewership numbers.
--


