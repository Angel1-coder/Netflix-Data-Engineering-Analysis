# Power BI Quick Start Guide - Step by Step

## ⚠️ IMPORTANT: Run Python Script First!

Before opening Power BI, you **must first** run the Python script to create the cleaned data.

### Step 1: Run Python Script

```bash
python 01_python_data_cleaning.py
```

**The script will then create:**
- `data/processed/netflix_cleaned.csv` ← **You need this file for Power BI!**
- `data/processed/data_quality_report.json`
- `data/processed/missing_values_visualization.png`

---

## Step 2: Open Power BI Desktop

1. Open **Power BI Desktop** on your computer

---

## Step 3: Load Data into Power BI

### Option A: Using "Get Data" (Recommended)

1. In Power BI Desktop, click **"Get Data"** (top left)
2. Select **"Text/CSV"** from the list
3. Navigate to your project folder:
   ```
   C:\Users\Angelo Business\Desktop\Netflix Data Engineering Analysis\data\processed\netflix_cleaned.csv
   ```
4. Select the file `netflix_cleaned.csv`
5. Click **"Open"**
6. You'll see a preview of your data
7. Click **"Load"** (bottom right)

### Option B: Drag & Drop

1. Open Power BI Desktop
2. Open Windows Explorer
3. Navigate to: `data\processed\`
4. Drag the file `netflix_cleaned.csv` into Power BI Desktop
5. Power BI will automatically load the file

---

## Step 4: Verify Data

After loading, you should see:
- **~8,000+ rows**
- **Many columns** like: show_id, type, title, director, cast, country, rating, etc.

**Important:** If you get an error that the file was not found:
- Make sure you ran **Step 1** (Python script) first!

---

## Step 5: Create Dashboard

Now follow the detailed guide in:
- `dashboards/POWER_BI_SETUP.md`

There you'll find:
- What visualizations you can create
- KPI Cards, Charts, Tables
- Three different dashboard pages

---

## Summary

1. ✅ **Run Python script** → creates `netflix_cleaned.csv`
2. ✅ **Open Power BI Desktop**
3. ✅ **Get Data → Text/CSV**
4. ✅ **Select file:** `data/processed/netflix_cleaned.csv`
5. ✅ **Click Load**
6. ✅ **Create dashboard** (see POWER_BI_SETUP.md)

---

## Troubleshooting

**Problem:** File not found
- **Solution:** Run `python 01_python_data_cleaning.py` first!

**Problem:** Power BI shows error when loading
- **Solution:** Check if the CSV file is actually in the `data/processed/` folder

**Problem:** Too few rows
- **Solution:** Make sure you're loading `netflix_cleaned.csv`, NOT the raw `netflix_titles.csv`!

---

**Good luck! 🚀**

