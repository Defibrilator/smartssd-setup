# 1. Environment 

- **OS:** Ubuntu 20.04
- **Kernel:** GA kernel -> 5.4.0-109-generic
- **XRT:** version 2022.1
- **Platforms:** version 2021.2, path /opt/xilinx/platforms/xilinx_u2_gen3x4_xdma_gc_2_202110_1
- **Modules:** path /lib/modules/5.4.0-109-generic/updates/dkms/
- **Environment variables:** `source /opt/xilinx/xrt/setup.sh`
- **BDF:** 0000:04:00.0 -> find with `xbmgmt examine`

# 2. Pre-requisites

1. Install XRT and Platform packages by following guides/setup_card.md
2. Build the Xilinx AES-XTS Encryption/Decryption HW Kernel Binary (xclbin)
   1. > TODO

# 3. Installation

1. Install the libs
   - `$ sudo apt install dmsetup cryptsetup`
2. Setup the environment variables
   - `$ bash scripts/setup_env.sh`
3. Build XSS
   1. `$ cd xss/`
   2. `$ tar -xzvf xss_2.0.2.tar.gz`
   3. `$ cd xss/build`
   4. `$ ./build.sh -app dm-crypt`
   5. `$ sudo dpkg -i ./xss-2.0.2-amd64.deb`
4. List available devices and note FPGA PCI Address
   - `$ xss_util list-devices`
5. Update /etc/xss.conf by inserting line at the end
   - `<PCI Address> <path to repo>/SmartSSD/fa_aes_xts2_rtl_enc_dec.xclbin`
6. Reload xocl driver as ks_mode=1
   1. `$ sudo rmmod xocl`
   2. `$ sudo modprobe xocl kds_mode=1`
   