#!/bin/bash
#SBATCH --account=ficklin_class
#SBATCH --partition=ficklin_class
#SBATCH --job-name=assignment4_hostnames.txt
#SBATCH --error=%a.err
#SBATCH --output=%a.out
#SBATCH --mail-user=harrison.fuller@wsu.edu
#SBATCH --nodes=1-6
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --array=0-59:1
srun hostname
srun cat *.out > assignment4_hostnames.txt
