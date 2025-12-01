# Setup Guide

Quick setup instructions for running the Netflix Content Quality Analysis project.

## Prerequisites

- Python 3.7+
- SQL database (SQL Server, MySQL, PostgreSQL, or SQLite)
- Power BI Desktop (optional)

## Installation

```bash
pip install -r src/requirements.txt
```

## Data Preparation

1. Download Netflix dataset from [Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)
2. Save as `data/netflix_titles.csv`

## Execution

### Step 1: Data Cleaning (Python)

```bash
python 01_python_data_cleaning.py
```

**Output:**
- `data/processed/netflix_cleaned.csv`
- `data/processed/data_quality_report.json`
- `data/processed/missing_values_visualization.png`

### Step 2: Business Reports (SQL)

1. Import `data/processed/netflix_cleaned.csv` into your database as table `netflix_cleaned`
2. Execute queries from `sql/business_reports.sql`

**Note:** Adjust SQL syntax for your database:
- SQL Server: Uses `STRING_SPLIT()` and `FORMAT()`
- MySQL: Use `SUBSTRING_INDEX()` instead of `STRING_SPLIT()`
- PostgreSQL: Use `unnest(string_to_array(...))` instead of `STRING_SPLIT()`

### Step 3: Visualization (Power BI - Optional)

1. Open Power BI Desktop
2. Import `data/processed/netflix_cleaned.csv`
3. Follow `dashboards/POWER_BI_SETUP.md` for dashboard creation

## Project Structure

```
.
├── 01_python_data_cleaning.py    # Data cleaning script
├── data/
│   ├── netflix_titles.csv        # Raw data
│   └── processed/               # Cleaned data (generated)
├── sql/
│   └── business_reports.sql     # SQL queries
├── dashboards/
│   └── POWER_BI_SETUP.md        # Power BI guide
└── src/
    └── requirements.txt         # Python dependencies
```

## Reports Generated

1. **Overview Statistics** - Total titles, movies, TV shows
2. **TOP 10 Countries** - Content by country
3. **Genre Distribution** - Most popular genres
4. **Movie vs TV Show Comparison** - Content type analysis
5. **Content Over the Years** - Trend analysis
6. **New Content Added by Month** - Release strategy
7. **Data Quality by Type** - Metadata completeness

