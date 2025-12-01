# What is JSON and requirements.txt?

## What is JSON?

JSON is a data format, similar to a dictionary. It stores information in a structured way.

**Example:**
```json
{
  "name": "Max",
  "age": 25,
  "city": "Berlin"
}
```

**In this project:**
- The Python script automatically creates: `data/processed/data_quality_report.json`
- This file contains statistics about data quality
- You can open it later and see the numbers

**Do you need it?**
- Not strictly necessary, but useful
- Shows that you can export structured data
- Can be read back later

## What is requirements.txt?

`requirements.txt` is a list of Python packages needed for the project.

**Content:**
```
pandas>=1.5.0      # For data analysis (load CSV, manipulate data)
matplotlib>=3.5.0  # For creating charts
```

**What for?**
- Others know which packages need to be installed
- You know it yourself later
- Easy installation with one command: `pip install -r src/requirements.txt`

**Why important?**
- Without these packages, your code won't work
- Shows which tools you use
- Professional project structure

## Summary

- **JSON** = Statistics file with results (optional, but useful)
- **requirements.txt** = List of required Python packages (important!)

Both are part of a professional project structure.



