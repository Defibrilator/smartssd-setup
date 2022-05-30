# 1. Environment 

- **OS:** Ubuntu 20.04
- **Kernel:** GA kernel -> 5.4.0-109-generic
- **XRT:** version 2022.1
- **Platforms:** version 2021.2, path /opt/xilinx/platforms/xilinx_u2_gen3x4_xdma_gc_2_202110_1
- **Modules:** path /lib/modules/5.4.0-109-generic/updates/dkms/
- **Environment variables:** source /opt/xilinx/xrt/setup.sh
- **BDF:** 0000:04:00.0

# 2. Install packages

1. Download from [Xilinx](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/alveo/smartssd.html) the Deployment Target Platform and the Development Target Platform for the version 2021.2 type GEN3X4-XDMA 
2. Download from [Xilinx](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/alveo/u50.html)(not the same link) the Xilinx Runtime for the version 2022.1
3. Extract everything inside a new SmartSSD/res dir all packages at the same level
4. Install the packages
   - `$ sudo bash scripts/install_card_pkgs.sh`
5. Set the environment variables
   - `$ bash scripts/setup_env.sh` 
6. Find the device's <bdf>
   - `$ sudo xbmgmt examine`
7. Program the device
   1. `$ sudo xbmgmt program -d <bdf> --base --image /opt/xilinx/firmware/u2/gen3x4-xdma-gc/base/partition.xsabin`
   2. Cold boot the computer

# 3. Card Bring-Up and Validation

1. Enter the commands
   1. `$ sudo lspci -vd 10ee:`
   2. `$ sudo lspci -vs <nvme_pcie_dev_id> :`
   3. `$ lsblk`
2. Outputs should match, otherwise check Troubleshooting in guides/ug1382-smartssd-csd.pdf

# 4. Running FIO 

Make sure device is /dev/nme0n1

1. Random-Write command
   - `$ sudo fio --name=rand-write --ioengine=libaio --iodepth=256 --rw=randwrite --bs=4k --direct=1 --size=100% --numjobs=12 --runtime=60 --filename=/dev/nvme0n1 --group_reporting=1`
2. Random-Read command
   - `$ sudo fio --name=rand-read --ioengine=libaio --iodepth=256 --rw=randread --bs=4k --direct=1 --size=100% --numjobs=12 --runtime=60 --filename=/dev/nvme0n1 --group_reporting=1`
3. Seq-Write command :
   - `$ sudo fio --name=seq-write --ioengine=libaio --iodepth=64 --rw=write --bs=1024k --direct=1 --size=100% --numjobs=12 --runtime=60 --filename=/dev/nvme0n1 --group_reporting=1`
4. Seq-Read command :
   - `$ sudo fio --name=seq-read --ioengine=libaio --iodepth=64 --rw=read --bs=1024k --direct=1 --size=100% --numjobs=12 --runtime=60 --filename=/dev/nvme0n1 --group_reporting=1`

# Check everything

1. You can check the temperature of the device
   - `$ sudo nvme smart-log /dev/nvme0n1`
2. Check that device is ready
   - `$ xbmgmt examine --device <bdf> --report platform`

# Validate the Card

The xbutil validate command validates the correct installation by performing the following
set of tests:
1. Validates the device found.
2. Checks PCIe link status.
3. Runs a verify kernel on the module.
4. Performs the following data bandwidth tests:
   1. DMA test - Data transfer between host and FPGA DDR memory through PCIe.
   2. DDR test - Data transfer between kernels and FPGA DDR memory (device memory bandwidth test in the following xbutil command output log).

1. Run the command 
   - `$ sudo xbutil validate -d <bdf>`

