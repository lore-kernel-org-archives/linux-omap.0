From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 00/16] remoteproc: Add support for TI PRU
Date: Mon, 26 Nov 2018 09:52:33 +0200
Message-ID: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

This is the second part of the series [1] and depends on it.

It adds remoteproc support for the PRU processor cores
present in the PRU-ICSS subsystem on TI SoCs.

The PRU remoteproc driver uses the standard remoteproc core ELF
loader. However, the PRUs do not have a unified address space,
(has an Instruction RAM and a primary Data RAM at both 0x0) and
leverage an added .da_to_va ops to use the standard ELF loader.
This remoteproc driver does not have support for error recovery
and system suspend/resume features. Different compatibles are
used to allow providing scalability for instance-specific device
data if needed. The driver uses a default firmware-name retrieved
from device-tree, and the firmwares are expected to be present
in the standard Linux firmware search paths. They can also be
adjusted by userspace if required through the sysfs interface
provided by the remoteproc core.

The PRU remoteproc driver uses a client-driven boot methodology
- it does _not_ support auto-boot so that the PRU load and boot
is dictated by the corresponding client drivers for achieving
various usecases. This allows flexibility for the client drivers
or applications to set a firmware name (if needed) based on their
desired functionality and boot the PRU.

Finally it adds some helper APIs for client drivers to set
PRU specific settings .e.g Constant Table, GPI mode, etc.

Testing:
To test the code with example firmware you can try the LAB5 tutorial
http://processors.wiki.ti.com/index.php/PRU_Training:_Hands-on_Labs#LAB_5:_RPMsg_Communication_between_ARM_and_PRU
with the pru-software-support package at [2] and the sample rpmsg-client driver.
NOTE: you no longer need to build and run PRU_Halt example as shown in the tutorial.

cheers,
-roger

[1] https://lkml.org/lkml/2018/11/22/948
[2] https://github.com/rogerq/pru-software-support-package/commits/upstream/pruss

Roger Quadros (2):
  remoteproc/pru: Add pru_rproc_set_ctable() function
  remoteproc/pru: Add support for INTC Interrupt map resource

Suman Anna (9):
  remoteproc: Extend rproc_da_to_va() API with a flags parameter
  remoteproc: Add a rproc_set_firmware() API
  remoteproc: Add support to handle device specific resource types
  remoteproc/pru: Add PRU remoteproc driver
  remoteproc/pru: Add pru-specific debugfs support
  dt-bindings: remoteproc: ti-pruss: Update bindings for supporting
    rpmsg
  remoteproc/pru: Add support for virtio rpmsg stack
  remoteproc/pru: add pru_rproc_get_id() API to retrieve the PRU id
  soc: ti: pruss: add helper functions to set GPI mode, MII_RT_event and
    XFR

Tero Kristo (5):
  remoteproc/pru: add APIs to get and put the PRU cores
  dt-bindings: remoteproc: ti-pruss: Document application node bindings
  remoteproc/pru: add support for configuring GPMUX based on client
    setup
  remoteproc/pru: configure firmware based on client setup
  remoteproc/pru: add support for parsing pru interrupt mapping from DT

 .../devicetree/bindings/soc/ti/ti,pruss.txt        |   82 ++
 drivers/remoteproc/Kconfig                         |   16 +
 drivers/remoteproc/Makefile                        |    1 +
 drivers/remoteproc/imx_rproc.c                     |    2 +-
 drivers/remoteproc/keystone_remoteproc.c           |    3 +-
 drivers/remoteproc/pru_rproc.c                     | 1138 ++++++++++++++++++++
 drivers/remoteproc/pru_rproc.h                     |   55 +
 drivers/remoteproc/qcom_q6v5_mss.c                 |    5 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c                |    2 +-
 drivers/remoteproc/qcom_wcnss.c                    |    2 +-
 drivers/remoteproc/remoteproc_core.c               |  112 +-
 drivers/remoteproc/remoteproc_debugfs.c            |    3 +
 drivers/remoteproc/remoteproc_elf_loader.c         |    6 +-
 drivers/remoteproc/remoteproc_internal.h           |    2 +-
 drivers/remoteproc/remoteproc_sysfs.c              |   33 +-
 drivers/remoteproc/st_slim_rproc.c                 |    3 +-
 drivers/remoteproc/wkup_m3_rproc.c                 |    3 +-
 include/linux/pruss.h                              |  168 +++
 include/linux/remoteproc.h                         |   32 +-
 20 files changed, 1620 insertions(+), 50 deletions(-)
 create mode 100644 drivers/remoteproc/pru_rproc.c
 create mode 100644 drivers/remoteproc/pru_rproc.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
