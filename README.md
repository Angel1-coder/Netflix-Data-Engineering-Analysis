# Netflix Data Engineering Analysis

A comprehensive Data Engineering project analyzing Netflix content metrics using Python, SQL, and Power BI. This project demonstrates end-to-end data pipeline capabilities including data cleaning, quality assessment, business intelligence reporting, and interactive dashboard creation.

## What do we do?

We analyze Netflix data and find out:
- **Data Quality**: Which titles have incomplete information?
- **Business Insights**: TOP 10 countries, genre distribution, rating analyses
- **Improvement Potential**: Where can we increase data quality?

**Why this structure?**
- **Python**: Data cleaning and quality checks
- **SQL**: Business reports and analyses
- **Power BI**: Professional visualization
- **No redundancy** - each tool has its clear task!

## Requirements

- **Python** (pandas, matplotlib)
- **SQL** (basic queries)
- **Power BI** (optional)

## Project Structure

```
.
├── 01_python_data_cleaning.py          # START HERE! Data cleaning
├── data/
│   ├── netflix_titles.csv              # Netflix data (from Kaggle)
│   └── processed/                      # Cleaned data (will be created)
├── sql/
│   └── business_reports.sql            # Step 2: Business reports
├── dashboards/
│   └── POWER_BI_SETUP.md               # Step 3: Power BI guide
├── src/
│   └── requirements.txt                # Python packages
├── PROJECT_WORKFLOW.md                 # Detailed guide
└── README.md                           # This file
```

That's all! No unnecessary code. Only what's needed.

## Quick Start - Step by Step

### Step 1: Installation

```bash
# Install Python packages
pip install -r src/requirements.txt
```

### Step 2: Prepare data

1. Download Netflix dataset from [Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)
2. Save as `data/netflix_titles.csv`

### Step 3: Python - Data Cleaning START HERE!

**Simplest method (recommended):**
```bash
python 01_python_data_cleaning.py
```

**What happens?**
- Loads raw data
- Cleans data (missing values, duplicates, etc.)
- Creates data quality report
- Exports cleaned data for SQL

**Result:**
- `data/processed/netflix_cleaned.csv` (for SQL and Power BI)
- `data/processed/data_quality_report.json` (Quality statistics)
- `data/processed/missing_values_visualization.png` (Chart)

### Step 4: SQL - Business Reports

Open `sql/business_reports.sql` in your SQL editor and execute the queries.

**What do the SQL queries do?**
- TOP 10 countries by content count
- Genre distribution
- Rating analysis (Movie vs TV Show)
- Content statistics over the years

**Tip:** The data has already been cleaned by Python!

### Step 5: Power BI - Dashboard (optional)

Follow the instructions in `dashboards/POWER_BI_SETUP.md`  
Import `data/processed/netflix_cleaned.csv` into Power BI.

## Clear Division of Work

### Python (Data Cleaning)
- Load and validate data
- Identify missing values
- Remove duplicates
- Data quality checks
- Export cleaned data

### SQL (Business Reports)
- TOP lists (countries, genres, etc.)
- Aggregations and statistics
- Comparisons (Movie vs TV Show)
- Time-based analyses

### Power BI (Visualization)
- Import cleaned data
- Interactive dashboards
- Professional charts
- Business Intelligence reports

## What do we learn?

### Python
- Load data with Pandas
- Data cleaning and validation
- Data quality checks
- Export CSV

### SQL (Basics)
- SELECT statements
- WHERE conditions
- COUNT, GROUP BY, ORDER BY
- Aggregations

### Power BI
- Import data
- Create visualizations
- Dashboard design
- Business reports

## Example Results

### Data Quality (Python)
```
All titles:              8,800
With complete data:     3,200 (36%)
Missing metadata:       5,600 (64%)
```

### Business Report (SQL)
```
TOP 3 Countries:
1. United States: 2,815 titles
2. India:         942 titles
3. United Kingdom: 420 titles
```

## Project Structure

- Clean, professional code structure
- Clear separation of concerns (Python for cleaning, SQL for analysis)
- Production-ready data pipeline

## Next Steps

1. **START:** Run `01_python_data_cleaning.py`
2. Test the SQL reports (`sql/business_reports.sql`)
3. Create Power BI Dashboard (optional)
4. Present your results!

**See also:** `docs/SETUP_GUIDE.md` for setup instructions

## Why This Structure?

**Problem before:**
- Python and SQL did the same thing (redundant)
- "Funnel" didn't fit metadata analysis
- No clear division of work

**Solution now:**
- Python: Data cleaning (its strength)
- SQL: Business reports (its strength)
- Clear, realistic Data Engineering structure
- Each tool does what it's made for!

## Questions?

Check the documentation or open an issue.

---

**Good luck!**
