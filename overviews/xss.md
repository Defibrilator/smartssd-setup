# Overview of XSS 

The in-kernel XSS library (xss-driver) simplifies the access to the Xilinx HW encryption (AES-XTS) services by providing easy-to-use, software-equivalent APIs for other Linux kernel components. It uses the Xilinx RunTime(XRT) driver to communicate and manage U.2 SmartSSD. The XSS package also contains modified versions of dm-crypt sources which demonstrate the use of XSS APIs for offloading encryption/decryption. The various components of XSS are described below

1. xss_util
   This is Linux command-line application for configuration of XSS services on the Xilinx SmartSSD U.2
   This utility has following sub commands and functionality:
    1. list-devices: This displays list of all Xilinx Acceleration devices, each with its BDF Address, shell name, and PCI-Peer NVME controller (if any). It also shows xclbins (if loaded) kernel-names details on those devices.
    2. list-kernels: This takes path of a xclbin as argument and list all the FPGA kernel names available in the xclbin.
    3. load-config: This reads /etc/xss.conf and loads xclbin to the respective devices and inform xss driver about kernels loaded on to the device.
2. xss.conf
   This exists as /etc/xss.conf after xss installation. Users should fill this configuration file for each Xilinx SmartSSD U.2 device that user intends to use with dm-crypt or VDO. Each line in the config file contains config for one device and specifies which xclbins (HW-services) needs to be loaded for that device. 
   The format of the configuration is as below:
   `<Device-BDF>	<Path-to-xclbin> <comma-separated-hw-kernel-names>`
   The PCI address (BDF) of the device file can be found with “xss_util list-devices” command described above. The second field specifies the path to xclbin that contains the acceleration kernels. The third field is optional and needs to be used if the xclbin contains some hw-kernels that XSS need not claim and another application is expected to use them. In this case, user needs to specify only hw-kernel instances that are be to be used with XSS.
3. xss-driver
   This is the core XSS component which implements the APIs for XSS. Once XSS is installed, this kernel module will be auto loaded at boot time. If this behavior is not required, users can disable this setting by commenting this module from /etc/modules.
4. xcrypt module
   The xcrypt module is a crypto driver in the Linux Kernels’s Crypto-Framework. This exposes the Xilinx HW AES-XTS crypto functionality to Linux kernel. It must be loaded before creating a dm-crypt Volume with Xilinx HW crypto service.
5. xrt-driver
   The xrt-driver (Xilinx RunTime driver) is used by xss-driver to move the data in/out of SmartSSD and to trigger hw-kernel executions. It must be loaded prior to loading XSS for proper functioning. 
6. dm-crypt
   dm-crypt is the Linux kernel’s open source device-mapper “crypt” target that provides transparent encryption of block devices using the kernel crypto API. The XSS package contains modified version of dm-crypt source.:
    1. To use P2P (Peer-to-Peer) memory from Xilinx Acceleration Cards for buffers which are used for data transfers to and from the SSD device. This replaces the intermediate host buffers that dm-crypt creates to store encryption or decryption output. 
    2. To not offload writes to one dm-crypt thread, if xcrypt driver is used. This gives better performance for SSDs. 