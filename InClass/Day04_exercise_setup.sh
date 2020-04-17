#!/bin/bash

mkdir -p samples

for i in {1..10}
do
  echo "Creating $i"
  touch samples/sample-${i}_1.fastq 
  touch samples/sample-${i}_2.fastq 
done

for i in {11..20}
do
  echo "Creating $i"
  touch samples/sample-${i}_1.fastq 
done
