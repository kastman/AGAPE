AGAPE
=====


AGAPE (Automated Genome Analysis PipelinE) for yeast pan-genome analysis is designed to automate the process of pan-genome analysis and encompasses assembly, annotation, and variation-calling steps. It also includes programs for integrative analysis of novel genes.

INSTALLATION
-------------

The release at github.com/kastman/agape is designed to be installed in conjunction with `conda`.
This allows for the pipelines to be installed a run on machines outside the original SGD environment.
In some cases, variables that may be confusing have been edited (e.g. when the path to a script has been removed) with placeholders like "UNUSED".
This is less than ideal, but is the a balance between clarity and least impact.

To install, cd to the AGAPE directory in terminal and run:

    conda create -n agape -f environment.yaml
    source activate agape

Additionally, you should download the reference sequences for all fungi from the SGD Publication archive and extract them to the standard locations specified by the AGAPE config file:

    # Download Reference Sequences {yeast,fungi,te}_{est,protein}.fasta
    wget https://downloads.yeastgenome.org/published_datasets/Song_2015_PMID_25781462/AGAPE_cfg_files.tar.gz
    tar -xzf AGAPE_cfg_files.tar.gz
    mv AGAPE_cfg_files/* cfg_files/
    rm -r AGAPE_cfg_files.tar.gz AGAPE_cfg_files

    # Download Yeast Reference (Or use your own)
    wget https://downloads.yeastgenome.org/published_datasets/Song_2015_PMID_25781462/yeast_reference_AGAPE_format.tar.gz
    tar -xzf yeast_reference_AGAPE_format.tar.gz
    mv yeast_reference_AGAPE_format/* reference
    rm -r yeast_reference_AGAPE_format yeast_reference_AGAPE_format.tar.gz

USAGE
------

Read "README.txt" file in the package

Reference
=========
Song G, Dickins B, Demeter J, Engel S, Gallagher J, Choe K, Dunn B, Snyder M, Cherry J (2015) AGAPE (Automated Genome Analysis PipelinE) for pan-genome analysis of Saccharomyces cerevisiae. PLoS ONE, 10(3): e0120671.
