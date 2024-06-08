#!/usr/bin/env bash
set -xe

OUTDIR="out"
DEVICE="GW2AR-LV18QN88C8/I7"
BOARD="tangnano20k"
FAMILY="GW2A-18C"

yosys -p "read_verilog src/main.v; synth_gowin -json $OUTDIR/main.json"

nextpnr-himbaechel --json $OUTDIR/main.json \
                   --write $OUTDIR/pnrmain.json \
                   --device $DEVICE \
                   --vopt family=$FAMILY --vopt cst=$BOARD.cst

gowin_pack -d $FAMILY -o $OUTDIR/pack.fs $OUTDIR/pnrmain.json

set +x

if [ "$1" == "flash" ]; then
    echo "Flashing bitstream..."
    openFPGALoader -b $BOARD -f $OUTDIR/pack.fs
else
    echo "Compiled succesfully. To flash run ./build.sh flash"
fi