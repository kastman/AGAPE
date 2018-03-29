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

    conda env create -n agape -f environment.yaml
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

Finally, SGA includes some extra scripts that are not installed via conda.
To use them, you need to download the SGA release manually.
These commands download the version of SGA in the environment.yaml, but can be updated.

    mkdir programs; cd programs
    # # n.b. v0.10.15 has been half-updated for samtools 1, which
    # # means that it's unusable. Use version 0.10.14 or lower
    # wget https://github.com/jts/sga/archive/v0.10.15.tar.gz
    # tar -xzf v0.10.15.tar.gz && rm v0.10.15.tar.gz

    wget https://github.com/jts/sga/archive/v0.10.14.tar.gz
    tar -xzf v0.10.14.tar.gz && rm v0.10.14.tar.gz

Then edit configs.cf to set:

    SGA_src=$AGAPE_DIR/programs/sga-0.10.14/src/bin/

USAGE
------

    # Setup Environment Variables
    AGAPE_DIR=/Users/kastman/Desktop/AGAPE
    PROJDIR=/Users/kastman/Desktop/SourdoughYeasts/
    GENOMEDIR=$PROJDIR/Genomes
    SAMP=4_Y1

    # Assembly
    $AGAPE_DIR/agape_assembly.sh $PROJDIR/AGAPE_out/$SAMP $SAMP "$AGAPE_DIR" $GENOMEDIR/${SAMP}*.R1.fastq $GENOMEDIR/${SAMP}*.R2.fastq

    # Annotation
    $AGAPE_DIR/agape_annot.sh  $PROJDIR/AGAPE_out/$SAMP $SAMP $PROJDIR/AGAPE_out/$SAMP/${SAMP}.scf.fasta "$AGAPE_DIR" 

Reference
=========
Song G, Dickins B, Demeter J, Engel S, Gallagher J, Choe K, Dunn B, Snyder M, Cherry J (2015) AGAPE (Automated Genome Analysis PipelinE) for pan-genome analysis of Saccharomyces cerevisiae. PLoS ONE, 10(3): e0120671.
