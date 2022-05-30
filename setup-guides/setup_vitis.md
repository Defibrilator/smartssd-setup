
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