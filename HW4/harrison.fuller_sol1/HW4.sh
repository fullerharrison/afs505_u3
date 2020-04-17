#!/bin/bash
#SBATCH --account=ficklin_class
#SBATCH --partition=ficklin_class 
#SBATCH --job-name=assignment4_hostnames.txt 
#SBATCH --output=assignment4_hostnames.out
#SBATCH --error=assignment4_hostnames.err
#SBATCH --mail-user=harrison.fuller@wsu.edu
#SBATCH --nodes=1-6
#SBATCH --ntasks=60
#SBATCH --ntasks-per-node=10
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL  
srun hostname > assignment4_hostnames.txt
