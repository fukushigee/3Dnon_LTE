#PBS -N test
#PBS -l mppwidth=144
##PBS -l mppnppn=1
#PBS -me
#PBS -M leanard838@ezweb.ne.jp


source /opt/modules/default/init/bash
module switch PrgEnv-cray PrgEnv-intel

cd /work/fukushigers/testt
make -f mpi_makefile.7.8 clean
make -f mpi_makefile.7.8
#aprun -n 96 ./fuku.out
time aprun -n 64 ./fuku.out >& fukumain.log

cd /work/fukushigers/testt/getspectrum
make -f makefile_spect clean
make -f makefile_spect

time aprun  ./getspectrum144 >& fuku.log
#time aprun  ./getspectrum143 >& fuku.log

