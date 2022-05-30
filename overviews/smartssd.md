# Samsung SmartSSD CSD

## Overview
This SmartSSD is the industry’s first adaptable computational storage platform. The SmartSSD dramatically accelerates data intensive applications by 10X or more by pushing compute to where the data lives. This CSD is a partnership between Xilinx and Samsung and combines a 4 TB Samsung SSD with a Xilinx FPGA. With this FPGA, you can load an accelerator onto the CSD. 

The Xilinx Adaptive Platform is also available, a toolkit for creating customized, scalable applications to solve a broad range of data center problems.

## Hardware
Combines a Samsung Enterprise SSD and an acceleration-dedicated Xilinx Kintex Ultrascale+ FPGA with a fast private data path between them and a 4GB DRAM accelerator memory. Unlocks linear scalability while freeing CPU for other tasks as it removes the PCI-Express bottlenecks.

The FPGA provides logic elements and CPU cores for acceleration. The SSD controller provides the NAND media interface and management while a private, high-speed peer-to-peer link connects the SSD controller to the FPGA and transfers data between them.

![[Screenshot 2022-03-23 at 18.58.58.png]]

## Environment
- Xilinx Vitis environment : 
	 A unified software toolkit that enables development in C, C++, or OpenCL. The Vitis platform plugs into common software developer tools and utilizes a set of optimized open source libraries.
-  Xilinx Run Time environment :
	Allows development in hardware description languages (HDLs), including Verilog and VHDL. Also simplifies the re-use of existing accelerator IP designed in HDL for ASICs or FPGAs.

## Target Applications
*Best for data-intesive applications.*
AI/ML Inference, Big Data Analytics, Business Intelligence, Data Lake/DB Acceleration, Data Warehousing, Encryption/Decryption, Financial Services, Genomics, Search Queries, Storage & Virtualization, Transparent Compression, Video Analytics, Video File Transcoding

## Solutions 
#### 1. XSS:dm-crypt Acceleration
XSS turns this platform into turnkey accelerated offloads for existing Linux storage software.

XSS:dm-crypt is an AES-XTS encryption and decryption accelerator for data read from or written to the SmartSSD. You can use the Linux kernel module DMCrypt which maps block IO requests through a transparent encryption function between the IO requestor and the block storage device.

#### 2. Other solutions
- **Bigstream** : Big Data Analytics
	-   10X faster time-to-insight
	-   Seamless acceleration of Spark
	-   Scale-up server performance
- **Eideticom** : Transparent Compression
	-   Up to 10X more storage capacity
	-   Works with every application
	-   Line rate compression performance
- **Lewis Rhodes** : Search-In-Storage
	-   Up to 100X acceleration
	-   Accelerated regular expression processing (RegEx)
	-   Searches petabytes in minutes
- **CTAccel** : Video File Transcoding
	-   60% reduction in video transcoding costs
	-   Accelerate transcoding for VoD
	-   Scale-up server performance

## Notes
- CSD : Computational Storage Drive
- XSS : Xilinx Storage Services
