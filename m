From: David Lechner <david@lechnology.com>
Subject: (unknown)
Date: Sat, 23 Jun 2018 16:08:02 -0500
Message-ID: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Subject: 
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Date: Sat, 23 Jun 2018 15:43:59 -0500
Subject: [PATCH 0/8] New remoteproc driver for TI PRU

This series adds a new remoteproc driver for the TI Programmable Runtime Unit
(PRU) that is present in some TI Sitara processors. This code has been tested
working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).

There are a couple of quirks that had to be worked around in order to get this
working. The PRU units have multiple memory maps. Notably, both the instruction
RAM and data RAM are at address 0x0. This caused the da_to_va callback to not
work because the same address could refer to two different locations. To work
around this, the first two patches add a "map" parameter to the da_to_va
callbacks so that we have an extra bit of information to make this distinction.

Also, on AM38xx we have to use pdata for accessing a reset since there is not
a reset controller. There are several other devices doing this, so the seems
the best way for now.

For anyone else who would like to test, I used the rpmsg-client-sample driver.
Just enable it in your kernel config. Then grab the appropriate firmware[1]
and put in in /lib/firmware/. Use sysfs to start and stop the PRU:

        echo start > /sys/class/remoteproc<n>/state
        echo stop > /sys/class/remoteproc<n>/state

[1]: firmware downloads:

AM18XX: https://github.com/ev3dev/ev3dev-pru-firmware/releases/download/mainline-kernel-testing/AM18xx-PRU-rpmsg-client-sample.zip
AM335X: https://github.com/ev3dev/ev3dev-pru-firmware/releases/download/mainline-kernel-testing/AM335x-PRU-rpmsg-client-sample.zip

David Lechner (8):
  remoteproc: add map parameter to da_to_va
  remoteproc: add page lookup for TI PRU to ELF loader
  ARM: OMAP2+: add pdata quirks for PRUSS reset
  dt-bindings: add bindings for TI PRU as remoteproc
  remoteproc: new driver for TI PRU
  ARM: davinci_all_defconfig: enable PRU remoteproc module
  ARM: dts: da850: add node for PRUSS
  ARM: dts: am33xx: add node for PRU remoteproc

 .../bindings/remoteproc/ti_pru_rproc.txt      |  51 ++
 MAINTAINERS                                   |   5 +
 arch/arm/boot/dts/am33xx.dtsi                 |   9 +
 arch/arm/boot/dts/da850.dtsi                  |   8 +
 arch/arm/configs/davinci_all_defconfig        |   2 +
 arch/arm/mach-omap2/pdata-quirks.c            |   9 +
 drivers/remoteproc/Kconfig                    |   7 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/imx_rproc.c                |   2 +-
 drivers/remoteproc/keystone_remoteproc.c      |   3 +-
 drivers/remoteproc/qcom_adsp_pil.c            |   2 +-
 drivers/remoteproc/qcom_q6v5_pil.c            |   2 +-
 drivers/remoteproc/qcom_wcnss.c               |   2 +-
 drivers/remoteproc/remoteproc_core.c          |  10 +-
 drivers/remoteproc/remoteproc_elf_loader.c    | 117 +++-
 drivers/remoteproc/remoteproc_internal.h      |   2 +-
 drivers/remoteproc/st_slim_rproc.c            |   2 +-
 drivers/remoteproc/ti_pru_rproc.c             | 660 ++++++++++++++++++
 drivers/remoteproc/wkup_m3_rproc.c            |   3 +-
 include/linux/platform_data/ti-pruss.h        |  18 +
 include/linux/remoteproc.h                    |   2 +-
 include/uapi/linux/elf-em.h                   |   1 +
 22 files changed, 899 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
 create mode 100644 drivers/remoteproc/ti_pru_rproc.c
 create mode 100644 include/linux/platform_data/ti-pruss.h

-- 
2.17.1
