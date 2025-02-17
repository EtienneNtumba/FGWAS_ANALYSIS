nextflow.enable.dsl=2

process preprocess_data {
    input:
    path gwas_input

    output:
    path "formatted_LDL.txt"

    script:
    """
    awk '{print \$1, \$2, \$3, \$4, \$5, \$6, \$7, \$8}' $gwas_input > formatted_LDL.txt
    """
}

process run_fgwas_base {
    input:
    path formatted_LDL

    output:
    path "fgwas_base_lik.txt"

    script:
    """
    fgwas -i formatted_LDL.txt -o fgwas_base
    """
}

process run_fgwas_annot {
    input:
    path formatted_LDL

    output:
    path "fgwas_annot_lik.txt", path "fgwas_annot_param.txt"

    script:
    """
    fgwas -i formatted_LDL.txt -o fgwas_annot -w hepg2.E+ens_coding_exon
    """
}

process compare_models {
    input:
    path base_lik, path annot_lik

    output:
    path "model_comparison.txt"

    script:
    """
    echo "Baseline AIC: $(cat fgwas_base_lik.txt)" > model_comparison.txt
    echo "Annotated AIC: $(cat fgwas_annot_lik.txt)" >> model_comparison.txt
    """
}

process extract_significant_snps {
    input:
    path snps_file

    output:
    path "significant_snps.txt"

    script:
    """
    awk '$7 > 0.9' fgwas_annot_snps.txt | sort -k7,7nr > significant_snps.txt
    """
}

workflow {
    gwas_input = "test_LDL.fgwas_in.txt"
    
    formatted_LDL = preprocess_data(gwas_input)
    base_lik = run_fgwas_base(formatted_LDL)
    annot_results = run_fgwas_annot(formatted_LDL)
    model_comparison = compare_models(base_lik, annot_results[0])
    extract_significant_snps(annot_results[1])
}
