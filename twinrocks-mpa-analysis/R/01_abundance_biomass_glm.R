
# Twin Rocks Marine Sanctuary analysis — R skeleton
# Replicates core steps described in the paper: GLM/LM for abundance/biomass,
# diagnostics with DHARMa, and community structure with vegan.

# ---- Setup ----
packages <- c('lme4', 'DHARMa', 'vegan', 'ggplot2', 'readr', 'dplyr')
installed <- rownames(installed.packages())
for (p in packages) if (!p %in% installed) install.packages(p)

library(readr); library(dplyr); library(ggplot2)
library(lme4); library(DHARMa); library(vegan)

root <- normalizePath('..', winslash = '/')
raw_dir <- file.path(root, 'data', 'raw')
proc_dir <- file.path(root, 'data', 'processed')
fig_dir <- file.path(root, 'reports', 'figures')

if (!dir.exists(proc_dir)) dir.create(proc_dir, recursive = TRUE)
if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)

# ---- Load data ----
# Expect a tidy CSV with columns similar to: Year, Station, Replicate, Family,
# Length_cm, Count, Biomass_kgper500sqm

csv <- file.path(raw_dir, 'Combinedtarget_abundance.csv')
if (!file.exists(csv)) stop('Place Combinedtarget_abundance.csv in data/raw/')

abun <- read_csv(csv, show_col_types = FALSE)

# Ensure factors
abun <- abun %>% mutate(
  Year = factor(Year),
  Station = factor(Station),
  YrStn = interaction(Year, Station, drop = TRUE)
)

# ---- Model: Grand.Total ~ Station * Year ----
stopifnot('Grand.Total' %in% names(abun))

m <- lm(Grand.Total ~ Station * Year, data = abun)
print(summary(m))

# Diagnostics (DHARMa for GLM-like residual simulation)
res <- DHARMa::simulateResiduals(m)
png(file.path(fig_dir, 'lm_diagnostics.png'), width = 800, height = 600)
plot(res)
dev.off()

# ---- Community structure (optional) ----
# If you have a family-by-sample biomass table, run NMDS + PERMANOVA
# fam_mat <- ...  # samples x families
# ord <- vegan::metaMDS(fam_mat, k = 2)
# adonis <- vegan::adonis2(fam_mat ~ Station * Year, method = 'bray')

# ---- Save ----
readr::write_csv(abun, file.path(proc_dir, 'abundance_input_copy.csv'))
cat('Saved outputs to', proc_dir, 'and figures to', fig_dir, '
')
