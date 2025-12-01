# Power BI Dashboard Setup - Netflix Content Quality Analysis

This guide explains how to create a Power BI dashboard for Netflix Content Quality Analysis.

## Prerequisites

- Power BI Desktop installed
- Processed data file:
  - `data/processed/netflix_cleaned.csv` (from Python data cleaning)

## Data Import

1. Open Power BI Desktop
2. Click "Get Data" → "Text/CSV"
3. Navigate to `data/processed/netflix_cleaned.csv`
4. Click "Load"
5. Verify the data loaded correctly (should show ~8,000+ rows)

## Dashboard Design

### Page 1: Overview Dashboard

#### Visualizations:

1. **KPI Cards**
   - Total Titles: `COUNTROWS(netflix_cleaned)`
   - Total Movies: `COUNTROWS(FILTER(netflix_cleaned, netflix_cleaned[type] = "Movie"))`
   - Total TV Shows: `COUNTROWS(FILTER(netflix_cleaned, netflix_cleaned[type] = "TV Show"))`
   - Titles with Full Metadata: Count where all fields are not null

2. **Pie Chart - Movies vs TV Shows**
   - Legend: `type`
   - Values: Count of `show_id`

3. **Bar Chart - Top 10 Countries**
   - Axis: `country` (first country, may need to split)
   - Values: Count of `show_id`
   - Sort by: Count descending

4. **Bar Chart - Rating Distribution**
   - Axis: `rating`
   - Values: Count of `show_id`
   - Filter: Exclude null values

5. **Line Chart - Content Growth Over Time**
   - Axis: `release_year`
   - Values: Count of `show_id`
   - Legend: `type` (Movie vs TV Show)
   - Filter: Years >= 2000

### Page 2: Content Analysis

#### Visualizations:

1. **Horizontal Bar Chart - Genre Distribution**
   - Axis: `listed_in` (may need to split by comma)
   - Values: Count of `show_id`
   - Top 15 genres
   - Sort by: Count descending

2. **Line Chart - Content Over Time**
   - Axis: `release_year`
   - Values: Count of `show_id`
   - Legend: `type` (Movie vs TV Show)
   - Filter: Years >= 2000
   - Add trend line

3. **Area Chart - New Content Added by Month**
   - Axis: `date_added` (grouped by month)
   - Values: Count of `show_id`
   - Legend: `type`
   - Shows release strategy trends

4. **Scatter Plot - Content by Country and Year**
   - X-axis: `release_year`
   - Y-axis: Count of titles
   - Size: Count of titles
   - Color: `country` (top 5 countries)
   - Filter: Years >= 2000

5. **Table - Top Titles**
   - Columns: `title`, `type`, `release_year`, `rating`, `country`
   - Filter: `release_year >= 2015`
   - Sort by: `release_year` descending

### Page 3: Data Quality Dashboard

#### Visualizations:

1. **KPI Cards - Data Quality**
   - Titles with Director: Count where `director` is not null
   - Titles with Cast: Count where `cast` is not null
   - Titles with Country: Count where `country` is not null
   - Titles with Rating: Count where `rating` is not null
   - Data Completeness %: Percentage of titles with full metadata

2. **Stacked Bar Chart - Data Completeness by Type**
   - Axis: `type` (Movie vs TV Show)
   - Values: Count for each metadata field (director, cast, country, rating, description)
   - Shows completeness by type

3. **Horizontal Bar Chart - Missing Values**
   - Axis: Column names
   - Values: Count of null values
   - Shows which fields have most missing data
   - Sort by: Count descending

4. **Waterfall Chart - Data Quality Improvement**
   - Shows data quality before and after cleaning
   - Start: Total titles before cleaning
   - End: Titles with full metadata after cleaning
   - Steps: Removed duplicates, cleaned data

5. **Gauge Chart - Overall Data Completeness**
   - Shows percentage of titles with complete metadata
   - Target: 100%
   - Current: Actual completeness percentage

## DAX Measures

Create these measures for advanced analysis:

```dax
// Basic Counts
Total Titles = COUNTROWS(netflix_cleaned)

Movies Count = 
CALCULATE(
    COUNTROWS(netflix_cleaned),
    netflix_cleaned[type] = "Movie"
)

TV Shows Count = 
CALCULATE(
    COUNTROWS(netflix_cleaned),
    netflix_cleaned[type] = "TV Show"
)

// Data Quality Measures
Titles with Full Metadata = 
CALCULATE(
    COUNTROWS(netflix_cleaned),
    netflix_cleaned[director] <> BLANK(),
    netflix_cleaned[cast] <> BLANK(),
    netflix_cleaned[country] <> BLANK(),
    netflix_cleaned[rating] <> BLANK(),
    netflix_cleaned[description] <> BLANK()
)

Data Completeness % = 
DIVIDE(
    [Titles with Full Metadata],
    [Total Titles],
    0
) * 100

// Average Release Year
Average Release Year = 
AVERAGE(netflix_cleaned[release_year])
```

## Filters

Add these filters to all pages:

- **Type Filter**: Slicer for `type` (Movie/TV Show)
- **Year Filter**: Slicer for `release_year` (range)
- **Rating Filter**: Multi-select for `rating`

## Formatting Tips

1. Use consistent color scheme across all pages
2. Add titles to all visualizations
3. Format numbers appropriately (no decimals for counts, 1 decimal for percentages)
4. Use tooltips for additional context
5. Ensure responsive layout for different screen sizes

## Publishing

1. Click "Publish" in Power BI Desktop
2. Select your workspace
3. Dashboard will be available in Power BI Service
4. Set up scheduled refresh if data source is updated regularly

## Next Steps

- Add more advanced visualizations
- Create drill-through pages for detailed analysis
- Add custom visuals from AppSource
- Set up data refresh schedule
- Share dashboard with stakeholders

---

**Note:** This dashboard uses the cleaned data from Python. Make sure to run `01_python_data_cleaning.py` first!
