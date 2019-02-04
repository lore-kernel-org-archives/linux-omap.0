From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 00/14] Add support for TI PRU ICSS
Date: Mon, 4 Feb 2019 16:22:33 +0200
Message-ID: <1549290167-876-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

The Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS) is present on various TI SoCs such as AM335x, AM437x, AM57x,
Keystone 66AK2G, etc. A PRUSS consists of dual 32-bit RISC cores (Programmable
Real-Time Units, or PRUs), with instruction and data memories.

The programmable nature of the PRUs provide flexibility to implement
custom peripheral interfaces, fast real-time responses, or
specialized data handling. The common peripheral modules include
the following,
  - Enhanced GPIO with async capture and serial support
  - an Ethernet MII_RT module with two MII ports
  - an MDIO port to control external Ethernet PHYs
  - an Industrial Ethernet Peripheral (IEP) to manage/generate Industrial
    Ethernet functions
  - an Enhanced Capture Module (eCAP)
  - a 16550-compatible UART to support PROFIBUS
  - Interrupt controller with 64 input events and 10 Host interrupts.

A typical usage scenario would be to load the application firmware into
one or more of the PRU cores, initialize one or more of the peripherals
and perform I/O through shared RAM (or MSMC RAM) from either a Kernel driver
or directly from userspace.

With this series we should be able to use the kernel RPMSG driver along with
firmware and user-space examples in the pru-software-support-package [1].

We will also be able to get Dual Ethernet functionality using a kernel driver
which will be posted later.

This series contains
1) soc: pruss: This is the parent driver for the entire ICSS. Its main
purpose is to populate the different modules and manage memories.
(i.e. DRAM0, DRAM1 and SharedRAM) It will also kernel APIs to
manage the common CFG module.

2) irqchip: pruss-intc: This driver supports the INTC module on the ICSS.

3) remoteproc: pru: This provides a remoteproc interface for the PRU cores.
With this we can load firmware, start/stop PRU from kernel or userspace.
It adds support for virtio RPMSG. It also provides some kernel APIs
(e.g. pru_rproc_set_ctable()) that are PRU specific and required for
in-kernel applications (e.g. ethernet)

4) rpmsg: pru: An RPMsg driver that exposes interfaces to user space, to
allow applications to communicate with the PRU processors.

Platform data and device tree files for AM33xx and other SoCs
will be sent as a separate series.

Testing:
All kernel patches along with AM335x (beaglebone) and AM57xx (IDK) platform
support are at [3]

To test the code with example firmware you can try the LAB5 tutorial
http://processors.wiki.ti.com/index.php/PRU_Training:_Hands-on_Labs#LAB_5:_RPMsg_Communication_between_ARM_and_PRU
with the pru-software-support package at [2] and the sample rpmsg-client driver.
NOTE: you no longer need to build and run PRU_Halt example as shown in the tutorial.

[1] https://git.ti.com/pru-software-support-package
	NOTE: The repo needs update to the INTC resource data structures
	The updates that are required are listed in the below repo with one example fixed.
[2] https://github.com/rogerq/pru-software-support-package/commits/upstream/pruss

[3] https://github.com/rogerq/linux/commits/for-v5.1/pruss-2.0

Changelog:
v2:
- use IS_ERR() instead of IS_ERR_OR_NULL().
- sqashed related patches to reduce patch count.
- fixed build error at patch 11 "soc: ti: pruss: add pruss_get()/put() API".
- incorporated rproc_da_to_va patches from David Lechner.
- got rid of enum pruss_pru_id.
- got rid of pre & post loaders in device specific resource handler.
- get/set gpmux operation is now private to pru_rproc.c
- changed pruss_cfg_gpimode() to pru_rproc_set_gpimode(struct rproc *rproc, enum pruss_gpi_mode mode).
- moved pruss_intc.c to driver/irqchip/irq-pruss-intc.c. INTC APIs moved to include/irqchip/irq-pruss-intc.h.
  Decoupled struct pruss from INTC code. Any device who's interrupt-parent is pruss-intc can call the INTC APIs.
- removed device_name from pruss_private_data. use dt property for .has_no_sharedram.
- moved DRAM0, DRAM1 and SHARED_RAM memories into PRUSS node.

cheers,
-roger

Andrew F. Davis (2):
  dt-binding: irqchip: Add pruss-intc-irq driver for PRUSS interrupts
  irqchip: pruss: Add a PRUSS irqchip driver for PRUSS interrupts

David Lechner (2):
  remoteproc: add map parameter to da_to_va
  remoteproc: add page lookup for TI PRU to ELF loader

Jason Reeder (1):
  rpmsg: pru: add a PRU RPMsg driver

Roger Quadros (1):
  remoteproc/pru: Add pru_rproc_set_ctable() and pru_rproc_set_gpimode()

Suman Anna (8):
  dt-bindings: remoteproc: Add TI PRUSS bindings
  soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
  remoteproc: Add a rproc_set_firmware() API
  remoteproc: Add support to handle device specific resource types
  dt-binding: remoteproc: Add binding doc for PRU Cores in the PRU-ICSS
  remoteproc/pru: Add PRU remoteproc driver
  remoteproc/pru: Add support for virtio rpmsg stack
  rpmsg: virtio_rpmsg_bus: move back rpmsg_hdr into a public header

 .../interrupt-controller/ti,pruss-intc-irq.txt     |   51 +
 .../bindings/remoteproc/ti,pru-rproc.txt           |   56 +
 .../devicetree/bindings/soc/ti/ti,pruss.txt        |  212 ++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-pruss-intc.c                   |  630 +++++++++++
 drivers/remoteproc/Kconfig                         |   16 +
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/imx_rproc.c                     |    2 +-
 drivers/remoteproc/keystone_remoteproc.c           |    3 +-
 drivers/remoteproc/pru_rproc.c                     | 1141 ++++++++++++++++++++
 drivers/remoteproc/pru_rproc.h                     |   54 +
 drivers/remoteproc/qcom_q6v5_mss.c                 |    2 +-
 drivers/remoteproc/qcom_wcnss.c                    |    2 +-
 drivers/remoteproc/remoteproc_core.c               |  108 +-
 drivers/remoteproc/remoteproc_debugfs.c            |    3 +
 drivers/remoteproc/remoteproc_elf_loader.c         |  117 +-
 drivers/remoteproc/remoteproc_internal.h           |    2 +-
 drivers/remoteproc/remoteproc_sysfs.c              |   33 +-
 drivers/remoteproc/st_slim_rproc.c                 |    2 +-
 drivers/remoteproc/wkup_m3_rproc.c                 |    3 +-
 drivers/rpmsg/Kconfig                              |   14 +
 drivers/rpmsg/Makefile                             |    1 +
 drivers/rpmsg/rpmsg_pru.c                          |  360 ++++++
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   21 +-
 drivers/soc/ti/Kconfig                             |   12 +
 drivers/soc/ti/Makefile                            |    1 +
 drivers/soc/ti/pruss.c                             |  347 ++++++
 include/linux/irqchip/irq-pruss-intc.h             |   94 ++
 include/linux/pruss.h                              |  211 ++++
 include/linux/remoteproc.h                         |   20 +-
 include/linux/remoteproc/pru_rproc.h               |   57 +
 include/linux/rpmsg/virtio_rpmsg.h                 |   26 +
 include/uapi/linux/elf-em.h                        |    1 +
 33 files changed, 3533 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
 create mode 100644 drivers/irqchip/irq-pruss-intc.c
 create mode 100644 drivers/remoteproc/pru_rproc.c
 create mode 100644 drivers/remoteproc/pru_rproc.h
 create mode 100644 drivers/rpmsg/rpmsg_pru.c
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 include/linux/irqchip/irq-pruss-intc.h
 create mode 100644 include/linux/pruss.h
 create mode 100644 include/linux/remoteproc/pru_rproc.h
 create mode 100644 include/linux/rpmsg/virtio_rpmsg.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
