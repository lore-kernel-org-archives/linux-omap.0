From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/4] ARM: OMAP2+: AM33XX/AM43XX: Add suspend-resume support
Date: Fri, 16 Feb 2018 15:39:58 -0600
Message-ID: <20180216214002.6209-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This series contains the remaining code to enable suspend to mem and standby
on am335x and am437x platforms. All dependencies have been merged and this
is just a rebase on v4.16-rc1. For this to work on am437x-gp-evm this
bug fix patch [1] is required but suspend works fine on am335x platforms
without it. V3 of this series can be found here [2].

This code also depends on firmware for the wkup_m3 that is available here [3]
that can either be placed in /lib/firmware or built in to the kernel.

For testing the drivers required are:

CONFIG_MAILBOX
CONFIG_OMAP2PLUS_MBOX
CONFIG_WKUP_M3_RPROC
CONFIG_SOC_TI
CONFIG_WKUP_M3_IPC
CONFIG_TI_EMIF_SRAM
CONFIG_AMX3_PM

There is a device tree patch series to follow immediately after this that will
completely enable suspend, all patches pushed here [4] for convenience
including the aforementioned [1] regulator bug fix if anyone is testing.

Regards,
Dave

[1] https://www.spinics.net/lists/linux-omap/msg141626.html
[2] https://www.spinics.net/lists/arm-kernel/msg595931.html
[3] https://git.ti.com/processor-firmware/ti-amx3-cm3-pm-firmware/blobs/7eb9c0856a9e8b3b42bf64f761da135852b8eea7/bin/am335x-pm-firmware.elf
[4] https://github.com/dgerlach/linux-pm/tree/upstream/v4.16/amx3-suspend-v4

Dave Gerlach (4):
  ARM: OMAP2+: Introduce low-level suspend code for AM33XX
  ARM: OMAP2+: Introduce low-level suspend code for AM43XX
  ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
  soc: ti: Add pm33xx driver for basic suspend support

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  16 +
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |  16 +
 arch/arm/mach-omap2/common.h                       |   7 +
 arch/arm/mach-omap2/io.c                           |   2 +
 arch/arm/mach-omap2/pm-asm-offsets.c               |  38 ++
 arch/arm/mach-omap2/pm.h                           |   3 +
 arch/arm/mach-omap2/pm33xx-core.c                  | 197 ++++++++++
 arch/arm/mach-omap2/sleep33xx.S                    | 222 ++++++++++++
 arch/arm/mach-omap2/sleep43xx.S                    | 395 +++++++++++++++++++++
 drivers/soc/ti/Kconfig                             |   9 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pm33xx.c                            | 357 +++++++++++++++++++
 include/linux/platform_data/pm33xx.h               |  50 +++
 14 files changed, 1314 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm-asm-offsets.c
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h

-- 
2.16.1
