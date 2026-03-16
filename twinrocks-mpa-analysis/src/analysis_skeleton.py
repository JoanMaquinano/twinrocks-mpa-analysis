
"""Twin Rocks Marine Sanctuary (TRMS) analysis — Python skeleton

Place raw data (e.g., Combinedtargets.csv) in data/raw/ and run this script to
perform quick EDA and generate plots. Edit paths and column names to match your files.
"""
from pathlib import Path
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / 'data' / 'raw'
PROC = ROOT / 'data' / 'processed'
FIGS = ROOT / 'reports' / 'figures'

PROC.mkdir(parents=True, exist_ok=True)
FIGS.mkdir(parents=True, exist_ok=True)

# ---- Load data ----
# Example filename; update if different
csv_path = RAW / 'Combinedtargets.csv'
if not csv_path.exists():
    raise SystemExit(f"Missing {csv_path}. Please place your raw CSV in data/raw/")

# Expected minimal columns (adapt as needed):
# Year, Station, Replicate, Family, Genus, Species, Length_cm, Count,
# Biomass_kgper500sqm (or compute from a,b, Length)

df = pd.read_csv(csv_path)

# Basic cleaning
df.columns = [c.strip().replace(' ', '_') for c in df.columns]
df = df.dropna(subset=['Year', 'Station'])

# ---- Quick EDA ----
print(df[['Year', 'Station']].value_counts().sort_index())

# Total abundance per Station x Year
abun = (df.groupby(['Year', 'Station'], observed=True)['Count']
          .sum()
          .reset_index(name='Grand_Total'))

# Plot abundance
sns.set_theme(style='whitegrid')
plt.figure(figsize=(7,4))
sns.barplot(data=abun, x='Year', y='Grand_Total', hue='Station')
plt.title('Total abundance by Year × Station')
plt.tight_layout()
plt.savefig(FIGS / 'abundance_year_station.png', dpi=160)

# Save processed table
abun.to_csv(PROC / 'abundance_by_year_station.csv', index=False)
print('Saved:', PROC / 'abundance_by_year_station.csv')
""
Next suggestions:
- Compute biomass per 500 m² from length-weight (a, b) if needed.
- Build size-frequency distributions by Family and Station.
- Export tidy tables for Tableau/Power BI.
"""
