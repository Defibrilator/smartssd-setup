#!/bin/bash

dpkg -i res/xrt_202210.2.13.466_20.04-amd64-xrt.deb
dpkg -i res/xilinx-u2-gen3x4-xdma-gc-2-202110-1-dev_1-3311104_all.deb
dpkg -i res/xilinx-u2-gen3x4-xdma-gc-validate_2-3311104_all.deb
dpkg -i res/xilinx-u2-gen3x4-xdma-gc-base_2-3311104_all.deb

echo "Finished"
