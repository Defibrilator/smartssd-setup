# 1. Environment 

- **OS:** Ubuntu 20.04
- **Kernel:** GA kernel -> 5.4.0-109-generic
- **XSS:** version 2.0.2
- **Environment variables:** `source /opt/xilinx/xrt/setup.sh`

# 2. Pre-requisites

1. Install XRT and Platform packages by following guides/setup_card.md
2. Build the Xilinx AES-XTS Encryption/Decryption HW Kernel Binary (xclbin)
   1. > TODO
   2. move binary file inside res/

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
4. Install the created package
   - `$ sudo dpkg -i ./xss-2.0.2-amd64.deb`

# 4. XSS dm-crypt setup
1. List available devices and note FPGA PCI Address
   - `$ xss_util list-devices`
2. Update /etc/xss.conf by inserting line at the end
   - `<PCI Address> <path to repo>/xss/fa_aes_xts2_rtl_enc_dec.xclbin`
3. Reload xocl driver as ks_mode=1
   1. `$ sudo rmmod xocl`
   2. `$ sudo modprobe xocl kds_mode=1`
4. Load configuration 
   - `sudo xss_util load-config`
   - Expected output :

> Reading configuration from /etc/xss.conf:
> 
> Configuring device 0000:05:00.1... Loaded xclbin:\<path to repo>/xss/fa_aes_xts2_rtl_enc_dec.xclbin, Added device info to XSS. 

**Note:** steps 3 and 4 should be repeated to setup dm-crypt after each reboot of the system (assuming there is no change in the xss.conf). All commands should run with root privilege.

Once XSS configuration is loaded, dm-crypt volumes can be created as shown in the examples below

### Example 1: 

Creating dm-crypt volume over /dev/nvme0n1 namespace from NVMe SSD. 

Note: Using 4K block size is highly recommended for best performance 

- `$ sudo dmsetup create xss-dev --table "0 $(blockdev --getsz /dev/nvme0n1) crypt capi:xss_aes_xts_async-plain64 <128-byte-key>  0 /dev/nvme0n1 0 1 sector_size:4096"`
- `$ sudo dmsetup remove xss-dev`

### Example 2: 

- `$ sudo cryptsetup --type luks2 --cipher capi:xss_aes_xts_async-plain64 --key-size 512 --sector-size 4096 luksFormat /dev/nvme0n1`
- `$ sudo cryptsetup luksOpen /dev/nvme0n1 xss-dev`

Check the dm-crypt volume created with the above examples
- `$ ls /dev/mapper/xss-dev`

After a dm-crypt volume is created, it can be used to create any filesystem over it and mounted on a desired path for storage use

- `$ sudo mkfs.ext4 /dev/mapper/xss-dev`
- `$ sudo mount /dev/mapper/xss-dev /mnt	`
