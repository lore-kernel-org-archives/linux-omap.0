From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 00/17] Add support for TI PRU ICSS
Date: Thu, 22 Nov 2018 13:38:56 +0200
Message-ID: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

The Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS) is present on various TI SoCs such as AM335x, AM437x, AM57x,
Keystone 66AK2G, etc. A PRUSS consists of dual 32-bit RISC cores (Programmable
Real-Time Units, or PRUs), data and instruction RAMs, shard RAM, and
interrupt controller and some internal peripheral modules to facilitate
industrial communication. The programmable nature of the PRUs provide
flexibility to implement custom peripheral interfaces, fast real-time
responses, or specialized data handling. The common peripheral modules
include the following,
  - an MII_RT module with two MII ports for Ethernet
  - an MDIO port for external Ethernet PHYs
  - an Industrial Ethernet Peripheral (IEP) to manage/generate Industrial
    Ethernet functions
  - an Enhanced Capture Module (eCAP)
  - an Industrial Ethernet Timer with 7/9 capture and 16 compare events
  - a 16550-compatible UART to support PROFIBUS

A typical usage scenario would be to load the application firmware into
one or more of the PRU cores, initialize one or more of the peripherals
and perform I/O through shared RAM (or MSMC RAM) from either a Kernel driver
or directly from userspace.

With this two-part series we should be able to use the kernel RPMSG driver
along with firmware and user-space examples in the
pru-software-support-package [1].

We will also be able to get Dual Ethernet functionality using a kernel driver
which will be posted later.

The kernel code will be split into the following sections

1) soc: pruss_soc_bus: The sole purpose of this driver is to handle platform
specific Power management quirks and allow the child node (i.e entire PRUSS)
to be unbound from the default kernel driver and bound to something else. e.g. uio_pruss,
while allowing to manage PM in the kernel.

2) soc: pruss: This is the driver for the entire ICSS. Its main purpose is
to populate the different modules and handle platform specific quirks.
It will also manage the interrupt controller and provide kernel APIs to
change ICSS specific knobs in the CFG space e.g. GP_MUX.

3) remoteproc: pru: This provides a remoteproc interface for the PRU cores.
With this we can load firmware, start/stop PRU from kernel or userspace.
It adds support for virtio RPMSG. It also provides some kernel APIs
(e.g. pru_rproc_set_ctable()) that are PRU specific and required for
in-kernel applications (e.g. ethernet)

4) ARM: OMAP: DTS:
Platform data and device tree files.

Due to the large number of patches patches are  split this into 2 email threads.
This thread covers (1), (3) and (4).

A second thread will cover the remoteproc driver (3).

The series only adds platform support for AM335x to keep patch count small.
Support for other platforms (AM43x, AM57x, K2G) will be added later.

Testing:
To test the code with example firmware you can try the LAB5 tutorial
http://processors.wiki.ti.com/index.php/PRU_Training:_Hands-on_Labs#LAB_5:_RPMsg_Communication_between_ARM_and_PRU
with the pru-software-support package at [2] and the sample rpmsg-client driver.
NOTE: you no longer need to build and run PRU_Halt example as shown in the tutorial.

cheers,
-roger

[1] https://git.ti.com/pru-software-support-package
	NOTE: The repo needs update to the INTC resource data structures
	The updates that are required are listed in the below repo with one example fixed.
[2] https://github.com/rogerq/pru-software-support-package/commits/upstream/pruss

Andrew F. Davis (1):
  soc: ti: pruss: add pruss_{request,release}_mem_region() API

Roger Quadros (2):
  soc: ti: pruss: add pruss_cfg_read()/update() API
  soc: ti: pruss: export pruss_intc_configure/unconfigure APIs

Suman Anna (13):
  dt-bindings: remoteproc: Add TI PRUSS bindings
  soc: ti: pruss: Define platform data for PRUSS bus driver
  soc: ti: pruss: Add pruss_soc_bus platform driver
  soc: ti: pruss: Fix system suspend/MStandby config issues
  soc: ti: pruss: Configure SYSCFG properly during probe/remove
  soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
  soc: ti: pruss: enable OCP master ports in SYSCFG always
  soc: ti: pruss: Add a PRUSS irqchip driver for PRUSS interrupts
  soc: ti: pruss_intc: Add API to trigger a PRU sysevent
  ARM: OMAP2+: use pdata quirks for PRUSS reset lines on AM335x
  ARM: dts: AM33xx: Add the PRU-ICSS DT nodes
  ARM: dts: AM33xx: Add PRU system events for virtio
  ARM: dts: am335x-*: Enable PRU-ICSS nodes

Tero Kristo (1):
  soc: ti: pruss: add pruss_get()/put() API

 .../devicetree/bindings/soc/ti/ti,pruss.txt        | 360 ++++++++++++
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   8 +
 arch/arm/boot/dts/am335x-evm.dts                   |   8 +
 arch/arm/boot/dts/am335x-evmsk.dts                 |   8 +
 arch/arm/boot/dts/am335x-icev2.dts                 |   8 +
 arch/arm/boot/dts/am33xx.dtsi                      |  78 +++
 arch/arm/mach-omap2/pdata-quirks.c                 |  11 +
 drivers/soc/ti/Kconfig                             |  12 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pruss.c                             | 306 +++++++++++
 drivers/soc/ti/pruss.h                             |  36 ++
 drivers/soc/ti/pruss_intc.c                        | 604 +++++++++++++++++++++
 drivers/soc/ti/pruss_soc_bus.c                     | 279 ++++++++++
 include/linux/platform_data/ti-pruss.h             |  25 +
 include/linux/pruss.h                              | 235 ++++++++
 15 files changed, 1979 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 drivers/soc/ti/pruss.h
 create mode 100644 drivers/soc/ti/pruss_intc.c
 create mode 100644 drivers/soc/ti/pruss_soc_bus.c
 create mode 100644 include/linux/platform_data/ti-pruss.h
 create mode 100644 include/linux/pruss.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
