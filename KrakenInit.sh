#!/usr/bin/env bash

#create plasmid database
wget http://pima.appliedbinf.com/data/plasmids_and_vectors.fasta
mv plasmids_and_vectors.fasta /home/Data/plasmids_and_vectors.fasta

#create kraken standard database
wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20210517.tar.gz
tar -xvf k2_standard_20210517.tar.gz --directory /kraken2
rm k2_standard_20210517.tar.gz