# fgwas Analysis Pipeline

## Overview
This repository contains a **functional GWAS (fgwas) pipeline** for integrating **genome-wide association studies (GWAS)** with **functional genomic annotations**. The pipeline is inspired by the approach in Pickrell et al. (2014), which uses **hierarchical modeling** to identify enriched genomic elements influencing traits.

## Features
- **Enrichment Analysis**: Identifies genomic regions (e.g., enhancers, promoters, open chromatin) that are enriched for trait-associated SNPs.
- **Hierarchical Modeling**: Uses **fgwas** to estimate SNP enrichment probabilities.
- **Trait-Specific Prioritization**: Re-weights GWAS signals based on functional annotations.
- **Visualization**: Generates enrichment plots, P-value distributions, and posterior probability estimates.

## Dependencies
Ensure you have the following tools and libraries installed:

- **fgwas** ([Source](https://github.com/joepickrell/fgwas))
- Python (for data preprocessing)
- R (for statistical analysis & visualization)
- PLINK (for GWAS file conversion)

## Installation
```bash
git clone https://github.com/your-username/fgwas-pipeline.git
cd fgwas-pipeline
```

## Input Files
1. **GWAS Summary Statistics** (`gwas.txt`)
   - Tab-delimited file with columns: `SNP`, `CHR`, `BP`, `P`, `BETA`, `SE`
2. **Genomic Annotations** (`annotations.txt`)
   - Preprocessed functional annotation file with SNP-level annotations
3. **Reference Panel** (`1000G.ref`) 
   - LD reference file from 1000 Genomes or other sources

## Running the Pipeline
### 1. Preprocessing GWAS Data
```bash
python preprocess_gwas.py --input gwas.txt --output gwas_clean.txt
```

### 2. Running fgwas
```bash
fgwas -i gwas_clean.txt -a annotations.txt -o results/fgwas_output
```

### 3. Visualizing Results
```r
Rscript plot_enrichment.R results/fgwas_output
```

## Output Files
- `fgwas_output.param` → Estimated enrichment parameters for annotations
- `fgwas_output.pp` → Posterior probabilities for SNP-trait associations
- `fgwas_output.model` → Best-fit model including multiple annotations
- `plots/enrichment.png` → Visualization of SNP enrichment across functional elements

## Example Use Cases
- **Fine-mapping GWAS signals using functional annotations**
- **Prioritizing SNPs in regulatory elements**
- **Comparing different annotation datasets for GWAS**

## References
- **Pickrell et al. (2014)** Joint analysis of functional genomic data and GWAS of 18 human traits. [bioRxiv](https://doi.org/10.1101/000752)

## License
This project is open-source and available under the **MIT License**.

## Contact
For questions or contributions, reach out at **your-email@example.com** or open an issue in the repository.
