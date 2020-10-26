#!/bin/bash
#
# atasnap_init.sh - A wrapper around hpguppi_init.sh for running
# hpguppi_daq when using hte ATA SNAP F engines.

destdir=/mnt/buf0
fenchan=4096
nants=1
nstrm=2
pktntime=16
pktnchan=256
schan=2304
chan_bw="0.25"
obsbw="128"
obsfreq="1420"
obsnchan=$((pktnchan * nstrm * nants))

perf=
if [ "$1" = 'perf' ]
then
  perf=perf
  shift
fi

$(dirname $0)/hpguppi_init.sh $perf atasnap 0 \
  -o DESTIP="0.0.0.0" \
  -o DESTDIR=${destdir} \
  -o FENCHAN=${fenchan} \
  -o NANTS=${nants} \
  -o NSTRM=${nstrm} \
  -o PKTNTIME=${hntime} \
  -o PKTNCHAN=${hnchan} \
  -o SCHAN=${schan} \
  -o CHAN_BW=${chan_bw} \
  -o OBSBW=${obsbw} \
  -o OBSFREQ=${obsfreq} \
  -o OBSNCHAN=${obsnchan} \
  "${@}"

sleep 1

hashpipe_check_status -k NDROP -i 0

hashpipe_redis_gateway.rb -s ${REDISHOST:-redishost} -D atasnap -g `hostname -s` -i 0
