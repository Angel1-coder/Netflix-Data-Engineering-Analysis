"""
Netflix Content Quality Analysis - Data Cleaning
"""

import pandas as pd
import matplotlib.pyplot as plt
import os
import json

print("=" * 60)
print("NETFLIX CONTENT QUALITY ANALYSIS - DATA CLEANING")
print("=" * 60)

print("\n1. Loading raw data...")
df = pd.read_csv('data/netflix_titles.csv')
print(f"   {len(df)} titles loaded, {len(df.columns)} columns found")

print("\n2. Analyzing data quality...")
missing_values = df.isnull().sum()
missing_pct = (missing_values / len(df) * 100).round(2)
total_titles = len(df)
titles_with_full_metadata = len(df[
    df['director'].notna() & 
    df['cast'].notna() & 
    df['country'].notna() &
    df['rating'].notna() &
    df['description'].notna()
])

print(f"\n   Data quality (before cleaning):")
print(f"   - Total: {total_titles} titles")
print(f"   - With complete data: {titles_with_full_metadata} ({titles_with_full_metadata/total_titles*100:.1f}%)")
print(f"   - Total missing values: {missing_values.sum()} ({missing_values.sum()/(len(df)*len(df.columns))*100:.1f}% of all cells)")

print("\n3. Top 5 columns with missing values:")
top_missing = missing_values[missing_values > 0].sort_values(ascending=False).head(5)
for col, count in top_missing.items():
    pct = missing_pct[col]
    print(f"   - {col}: {count} ({pct}%)")

print("\n4. Checking for duplicates...")
duplicates = df.duplicated(subset=['title', 'release_year', 'type']).sum()
print(f"   - Duplicates found: {duplicates}")

print("\n5. Cleaning data...")
df_cleaned = df.drop_duplicates(subset=['title', 'release_year', 'type'], keep='first')
df_cleaned = df_cleaned.replace(r'^\s*$', None, regex=True)

# Remove line breaks in text fields to ensure Power BI compatibility
text_columns = ['title', 'director', 'cast', 'country', 'description', 'listed_in']
for col in text_columns:
    if col in df_cleaned.columns:
        df_cleaned[col] = df_cleaned[col].fillna('').astype(str).str.replace('\n', ' ', regex=False).str.replace('\r', ' ', regex=False)
        # Replace 'nan' strings back to empty string
        df_cleaned[col] = df_cleaned[col].replace('nan', '', regex=False)

if 'date_added' in df_cleaned.columns:
    df_cleaned['date_added'] = pd.to_datetime(df_cleaned['date_added'], errors='coerce')

print(f"   Cleaned data: {len(df_cleaned)} titles ({len(df_cleaned)/total_titles*100:.1f}% retained)")

print("\n6. Creating data quality report...")
quality_report = {
    'before_cleaning': {
        'total_titles': int(total_titles),
        'titles_with_full_metadata': int(titles_with_full_metadata),
        'pct_full_metadata': float(titles_with_full_metadata/total_titles*100),
        'total_missing_values': int(missing_values.sum()),
        'duplicates': int(duplicates)
    },
    'after_cleaning': {
        'total_titles': int(len(df_cleaned)),
        'titles_with_full_metadata': int(len(df_cleaned[
            df_cleaned['director'].notna() & 
            df_cleaned['cast'].notna() & 
            df_cleaned['country'].notna() &
            df_cleaned['rating'].notna() &
            df_cleaned['description'].notna()
        ])),
        'titles_removed': int(total_titles - len(df_cleaned))
    },
    'missing_values_by_column': {
        col: {
            'count': int(count),
            'percentage': float(missing_pct[col])
        }
        for col, count in missing_values[missing_values > 0].sort_values(ascending=False).head(10).items()
    }
}

print("\n7. Creating visualization...")
os.makedirs('data/processed', exist_ok=True)

plt.figure(figsize=(12, 6))
top_10_missing = missing_values[missing_values > 0].sort_values(ascending=False).head(10)
plt.barh(range(len(top_10_missing)), top_10_missing.values, color='#FF6B6B')
plt.yticks(range(len(top_10_missing)), top_10_missing.index)
plt.xlabel('Number of missing values')
plt.title('Top 10 Columns with Missing Values', fontsize=16, fontweight='bold')
plt.grid(axis='x', alpha=0.3)

for i, (col, count) in enumerate(top_10_missing.items()):
    pct = missing_pct[col]
    plt.text(count + 50, i, f'{count:,} ({pct}%)', va='center', fontweight='bold')

plt.tight_layout()
plt.savefig('data/processed/missing_values_visualization.png', dpi=150, bbox_inches='tight')
print("   Chart saved: data/processed/missing_values_visualization.png")

print("\n8. Exporting cleaned data...")
# Export with proper CSV formatting for Power BI compatibility
df_cleaned.to_csv('data/processed/netflix_cleaned.csv', index=False, encoding='utf-8')
print("   CSV exported: data/processed/netflix_cleaned.csv")
print("   Note: Line breaks in text fields have been removed for Power BI compatibility")

with open('data/processed/data_quality_report.json', 'w', encoding='utf-8') as f:
    json.dump(quality_report, f, indent=2, ensure_ascii=False)
print("   Report exported: data/processed/data_quality_report.json")

print("\n" + "=" * 60)
print("DATA CLEANING COMPLETED!")
print("=" * 60)
print(f"\nSummary:")
print(f"   - Raw data: {total_titles} titles")
print(f"   - Cleaned data: {len(df_cleaned)} titles")
print(f"   - Removed: {total_titles - len(df_cleaned)} duplicates/invalid entries")
print(f"   - Complete data: {quality_report['after_cleaning']['titles_with_full_metadata']} titles")
print(f"\nExported files:")
print(f"   - data/processed/netflix_cleaned.csv (for SQL and Power BI)")
print(f"   - data/processed/data_quality_report.json (Quality report)")
print(f"   - data/processed/missing_values_visualization.png (Chart)")
print(f"\nNext steps:")
print(f"   1. Run SQL reports: sql/business_reports.sql")
print(f"   2. Create Power BI Dashboard: dashboards/POWER_BI_SETUP.md")
print("\n" + "=" * 60)
print("PYTHON DATA CLEANING COMPLETE!")
print("=" * 60)

