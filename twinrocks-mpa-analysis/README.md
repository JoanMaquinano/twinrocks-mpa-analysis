
# Twin Rocks Marine Sanctuary — Long-term Monitoring (2009–2018)

This repository turns the published analysis **"Fewer but bigger fish? Examining the long-term effects of protection in a marine sanctuary in Verde Island Passage"** into a reproducible, portfolio‑ready Git project. It contains a clean structure, R and Python starter code, and instructions to reproduce core results with your own (or permitted) data.

> Study site: **Twin Rocks Marine Sanctuary (TRMS), Mabini, Batangas, Philippines**; control site: **Bebot’s Rock**. Years analyzed: **2009, 2015, 2018**. Methods included **UVC 50×10 m belt transects (500 m²)**, biomass from **FishBase** LWR parameters, and statistics in **R** (lme4, DHARMa, vegan). See the paper for details.

## 📄 Reference
- Maquinano JK, Aurellado ME*, Samaniego B, Hilomen V, Bacabac MM, Sorgon KE, Simon AN, Montebon AR, Ticzon V (2024). *Fewer but bigger fish? Examining the long‑term effects of protection in a marine sanctuary in Verde Island Passage*. **IRJIEST 10(1):31–39**.  
  ➤ Please link to the publisher page or your ResearchGate page rather than redistributing the PDF.

## 🔍 Key results (from the paper)
- **2009 (inside TRMS):** Highest abundance (~1097 ± 318 ind/500 m²) and biomass (~246.4 ± 171.9 kg/500 m²).  
- **2015/2018 (inside TRMS):** Lower abundance (117–183 ind/500 m²) and biomass (27.2–33.0 kg/500 m²), driven by declines in **schooling transients** (jacks, fusiliers, barracudas) and some reef‑associated families.  
- **Size structure:** Modal sizes **increased** for most targeted families (e.g., surgeonfishes, parrotfishes) both inside and outside TRMS; **transient schooling** fishes were **smaller in 2018** vs. 2009.  
- **Habitat context:** Coral cover declined (2005→2018), algal/abiotic cover increased; small MPA area (~22.91 ha) limits protection for mobile species.  

## 📁 Repository structure
```
├── CITATION.cff
├── LICENSE
├── README.md
├── requirements.txt
├── environment.yml
├── src/
│   └── analysis_skeleton.py          # Python starter for EDA/plots
├── R/
│   └── 01_abundance_biomass_glm.R    # R starter (GLM, DHARMa, vegan)
├── notebooks/
│   └── TwinRocks-longterm-monitoring.html  # Provided HTML notebook
├── data/
│   ├── raw/        # place Combinedtargets.csv and other raw files here (not tracked)
│   └── processed/  # outputs (not tracked)
└── reports/
    └── figures/    # exported figures (not tracked)
```

> **Data are not included.** Place your CSVs in `data/raw/` (e.g., `Combinedtargets.csv`, `Combinedtarget_abundance.csv`). The repo is configured to ignore raw/processed data.

## 🚀 Getting started

### Option A — Python (for EDA & visualization)
```bash
# Create environment (Conda)
conda env create -f environment.yml
conda activate twinrocks
# or: python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt

# Open Jupyter and start exploring
jupyter notebook
```

### Option B — R (to mirror the paper’s workflow)
1. Install R (≥4.3) and RStudio (optional).  
2. Install packages in R:
```r
install.packages(c("lme4", "DHARMa", "vegan", "ggplot2", "readr", "dplyr"))
```
3. Put `Combinedtargets.csv` and `Combinedtarget_abundance.csv` into `data/raw/`.  
4. Run `R/01_abundance_biomass_glm.R`.

## 🧪 Reproduce core statistics
- Compare **Grand.Total** abundance and biomass across **Station × Year** (GLM / LM).  
- Inspect residuals with **DHARMa**; perform **PERMANOVA**/**NMDS** on family biomass using **vegan**.  
- Save figures to `reports/figures/` and export summary tables to `data/processed/`.

## 🧭 Roadmap (portfolio-friendly)
- [ ] Publish Tableau/Power BI dashboards for abundance/biomass and size distributions.  
- [ ] Add `Makefile` with `make reproduce` for one‑command runs.  
- [ ] Add unit tests for data validation rules.  
- [ ] Expand to 2020+ if data available.

## ⚖️ Licensing & ethics
- **Code** is MIT‑licensed.  
- **Data & paper** may be restricted—link/cite rather than redistribute unless you have rights.  
- Anonymize sensitive coordinates or protected species if sharing openly.
```
