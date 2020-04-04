#!/bin/bash

set -e

source /etc/bashrc
source /data1/miniconda3/bin/activate
conda activate hstcal_build_env
export TEST_BIGDATA=https://bytesalad.stsci.edu/artifactory
export OMP_NUM_THREADS=4
cd /srv/hstcal

pytest tests --basetemp=tests_output --junitxml results.xml --bigdata -v
