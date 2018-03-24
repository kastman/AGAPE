#!/bin/sh
set -exuo pipefail

# --- input file in $out_dir/$out_name.scf.fasta ---

#SCRIPTS=/srv/gs1/projects/cherry/giltae/AGAPE # AGAPE main directory path
#SCRIPT=`echo $0 | sed -e 's;.*/;;'` # script name from command line; path removed for msgs

#fastq_dir=/srv/gs1/projects/cherry/giltae/AGAPE/output/fastq

if [ $# -ne 4 ]
then
  echo "Usage: agape_annot.sh output_directory output_name sequence_fasta_file AGAPE_main_path"
  exit 1
fi

out_dir=$1
out_name=$2
seq=$3
SCRIPTS=$4

. $SCRIPTS/configs.cf

if [ ! -e "$REF_FASTA" ]
then
  echo "No reference sequence data: annotation based on homology skipped"
else
  if [ ! -e "$out_dir"/"$out_name".scf.fasta ]
  then
    ln -s $seq $out_dir/$out_name.scf.fasta
  fi
  if [ ! -e "$out_dir"/annot/"$out_name".codex ]; then
    $SCRIPTS/homology_annot.sh $out_dir $out_name $SCRIPTS # results place in $out_dir/annot/$out_name.codex
  fi
fi

snap_dir=$out_dir/snap_files
if [ ! -d $snap_dir ]; then
  mkdir -p $snap_dir;
  ln -s $REF_FASTA $snap_dir/$REF_NAME.dna
  $SCRIPTS/prep_maker.sh $snap_dir $SCRIPTS
fi

maker_dir=$out_dir/maker
if [ ! -e "$maker_dir"/genes.gff ]; then
  rm -rf $out_dir/maker
  mkdir -p $maker_dir
  $SCRIPTS/run_maker.sh $out_dir $out_name $maker_dir $snap_dir $SCRIPTS # results in $maker_dir/genes.gff
fi

comb_annot=$out_dir/comb_annot
# rm -rf $comb_annot
if [ ! -d $comb_annot ]; then
  mkdir -p $comb_annot
fi

cd $comb_annot
BLAST='unused'  # Unused
if [ ! -e $comb_annot/gff/$out_name.genes.gff ]; then
  $SCRIPTS/run_comb_annot.sh $comb_annot $BLAST $out_name $maker_dir $out_dir $snap_dir $SCRIPTS
fi

$SCRIPTS/final_annot.sh $out_dir/maker/seq.fasta $comb_annot/gff/$out_name.genes.gff $comb_annot $out_name $SCRIPTS

# The results are $comb_annot/$out_name.gff
# BLASTX output file is $comb_annot/blast_out/$out_name.blastx.out
