# SmartSSD Setup

This repository contains all links, packages and information needed to setup a Xilinx SmartSSD and use the XSS library to run an AES-XTS encryption/decryption kernel on it. 

The setup flow is :
1. [Setup the Card](setup-guides/setup_card.md)
2. (Optional) [Setup Vitis IDE](setup-guides/setup_vitis.md)
3. [Setup XSS](setup-guides/setup_xss.md)

These guides are based on the official userguides with wrong/outdated information updated. [setup_card.md](setup-guides/setup_card.md) is based on the [userguide](setup-guides/ug1382-smartssd-csd.pdf), the [setup_vitis.md](setup-guides/setup_vitis.md) is based on the [Vitis Documentation](https://docs.xilinx.com/r/en-US/ug1393-vitis-application-acceleration/), and [setupd_xss.md](setup-guides/setup_xss.md) is based on the READMEs inside the [xss package](xss/xss_2.0.2.tar.gz).

You need to use the GA kernel of an LTS version <= 20.04 of Ubuntu for the setup to work. Here we use the kernel 5.4.0-109-generic on Ubuntu 20.04.

You can find different overviews inside the overview directory, useful scripts for the setup guides inside the scripts directory as well as some documentation in the documentation directory.

## Cooling 

As this card uses passive cooling and is supposed to be used in a server with an active cooling air flow, the cooling in a computer is not enough.

The cooling was reworked and improved to be below the temperature limit of 70°C. 

Thermal paste was added on the DYI contact, an additional radiator was added on the other side and an additional fan in the box blowing the assembly, see photos in /res/cooling. With the box closed, we were able to pass the card validation tests while remaining in a thermal envelope between 50°C and 60°C.

## Links
- SmartSSD
  - [Overview page](https://www.xilinx.com/applications/data-center/computational-storage/smartssd.html)

- XRT
  - [Alveo Packages Download page](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/alveo/smartssd.html)
  - [XRT Documentation](https://xilinx.github.io/XRT/2022.1/html/index.html)

- Vitis
  - [Vitis Download page](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis.html)
  - [Vitis Documentation](https://docs.xilinx.com/r/en-US/ug1393-vitis-application-acceleration/Getting-Started-with-Vitis)
  - [Vitis Tutorials](https://github.com/Xilinx/Vitis-Tutorials)

- XSS
  - [XSS page](https://www.xilinx.com/products/intellectual-property/xss.html)
  - [AES-XTS](https://www.xilinx.com/products/intellectual-property/1-ysk5hh.html#overview)

Author : Maxime Germano