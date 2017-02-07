#PBS -N zzzz
#PBS -l mppwidth=72
#PBS -q debug
#PBS -l mpplabels=DEBUG



source /opt/modules/default/init/bash
module switch PrgEnv-cray PrgEnv-intel

cd /work/fukushigers/nonlte2/getspectrum
make -f makefile_spect clean
make -f makefile_spect

time aprun  ./getspectrum144 >& fuku.log
#time aprun  ./getspectrum143 >& fuku.log
