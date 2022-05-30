# 1. Environment 

- **OS:** Ubuntu 20.04
- **Kernel:** GA kernel -> 5.4.0-109-generic
- **XRT:** version 2022.1
- **Platforms:** version 2021.2, path /opt/xilinx/platforms/xilinx_u2_gen3x4_xdma_gc_2_202110_1
- **Modules:** path /lib/modules/5.4.0-109-generic/updates/dkms/
- **Environment variables:** source /opt/xilinx/xrt/setup.sh
- **BDF:** 0000:04:00.0

# 2. Install packages

1. Download from https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/alveo/smartssd.html the Deployment Target Platform and the Development Target Platform for the version 2021.2 type GEN3X4-XDMA 
2. Download from https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/alveo/u50.html the Xilinx Runtime for the version 2022.1
3. Extract everything inside a new SmartSSD/res dir all packages at the same level
4. Install the packages
   - `$ sudo bash scripts/install_card_pkgs.sh`
5. Set the environment variables
   - `$ source /opt/xilinx/xrt/setup.sh` 
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

# Install Vitis IDE

1. Install the libs
   1. `$ sudo apt-get install ocl-icd-libopencl1`
   2. `$ sudo apt-get install opencl-headers`
   3. `$ sudo apt-get install ocl-icd-opencl-dev`
2. Go to the [Xilinx Downloads Website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis.html).
3. Download the installer for Linux.
4. Run the installer, which opens the Welcome page.
5. Click Next to open the Select Install Type page of the Installer.
6. Enter your Xilinx user account credentials, and then select Download and Install Now.
7. Click Next to open the Accept License Agreements page of the Installer.
8. Accept the terms and conditions by clicking each I Agree check box.
9. Click Next to open the Select Product to Install page of the Installer.
10. Select Vitis and click Next to open the Vitis Unified Software Platform page of the Installer.
11. Customize your installation by selecting design tools and devices (optional).

    The default Design Tools selections are for standard Vitis Unified Software Platform installations, and include Vitis, Vivado, and Vitis HLS. You do not need to separately install Vivado tools. You can also install Model Composer and System Generator if needed.

    You can enable Vitis IP Cache to install cache files for example designs found in the release. This is not required, but when selected the files will be installed at <installdir>/Vitis/<release>/data/cache/xilinx.

    The default Devices selections are for devices used on standard acceleration platforms supported by the Vitis tools. You can disable some devices that may not be of interest in your installation.
    > Important: Do not deselect the following option. It is required for installation.
    > - Devices > Install devices for Alveo and Xilinx Edge acceleration platforms
12. Click Next to open the Accept License Agreements page of the Installer and accept as appropriate.
13. Click Next to open the Select Destination Directory page of the Installer
14. Specify the installation directory, review the location summary, review the disk space required to insure there is enough space, and click Next to open the Installation Summary page of the Installer.
15. Click Install to begin the installation of the software.
16. After a successful installation of the Vitis software, a confirmation message is displayed, with a prompt to run the installLibs.sh script. Locate the script at: <install_dir>/Vitis/<release>/scripts/installLibs.sh, where <install_dir> is the location of your installation, and <release> is the installation version.
17. Run the scripts using sudo privileges as follows:
    - `$ sudo installLibs.sh`
1.  Install the cable drivers inside /tools/Xilinx/Vitis/2022.1/data/xicom/cable_drivers/lin64/install_script/install_drivers
    - `$ sudo ./install_drivers`
