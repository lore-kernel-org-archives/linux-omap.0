From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/28] omap fixes for v2.6.34-rc5
Date: Fri, 23 Apr 2010 16:10:55 -0700
Message-ID: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56405 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0DWXK5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:10:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review. Mostly trivial stuff.

Sorry for posting these so late in the -rc cycle. Travel,
meetings and ELC sucked up quite a bit of my time over past
month.

Regards,

Tony

---

Aaro Koskinen (2):
      omap: fix clocksource_32k to start from zero
      omap: delete unused bootloader tag variables

Abraham Arce (1):
      OMAP4: Clocks: Change SPI Instance Names

Enric Balletbo i Serra (1):
      omap3: Fix EHCI port for IGEP v2 board

Felipe Balbi (1):
      arm: omap1: remove dead code from timer32k.c

Francisco Alecrim (1):
      n8x0_defconfig: remove CONFIG_NILFS2_FS override

Janusz Krzysztofik (1):
      omap: gpio: fix incorrect matching of IRQ_TYPE_EDGE_BOTH

Jarkko Nikula (2):
      omap: rx51_defconfig: Remove duplicate phonet
      omap: rx51_defconfig: Remove CONFIG_SYSFS_DEPRECATED*=y options

Richard Woodruff (1):
      omap4: Fix build break when used with gcc-4.4.1 (2009-q3)

Santosh Shilimkar (2):
      OMAP4: Fix for CONTROL register Base
      omap4: Fix McBSP4 base address

Thomas Weber (8):
      omap: Devkit8000: Fix wrong usb port on Devkit8000
      omap: board-sdp-flash.c: Fix typos in debug output
      omap: Devkit8000: Fix typo in supplies
      omap: Devkit8000: Add missing package selection
      omap: Devkit8000: Fix typo in pin name
      omap: Devkit8000: Remove unnecessary include file
      omap: Devkit8000: Change position of init calls
      omap: Devkit8000: Remove unused pins

Tony Lindgren (2):
      omap2: Fix ARM processor check for 24xx
      omap: Fix n8x0 mmc_mmc_init compile warnings and typos

kishore kadiyala (1):
      OMAP4-HSMMC: FIX for MMC5 Controller IRQ Base

manjugk manjugk (1):
      omap: DMA: Init CDAC to zero

stanley.miao (4):
      omap: fix the compile error if CONFIG_MTD_NAND_OMAP2 is notenabled
      omap: remove one of the define of INT_34XX_BENCH_MPU_EMUL
      AM3517: initialize i2c subsystem after mux subsystem
      omap: fix a gpmc nand problem


 arch/arm/configs/n8x0_defconfig                |    1 -
 arch/arm/configs/rx51_defconfig                |    3 --
 arch/arm/mach-omap1/timer32k.c                 |   15 ---------
 arch/arm/mach-omap2/Kconfig                    |    6 ++--
 arch/arm/mach-omap2/board-am3517evm.c          |    4 +-
 arch/arm/mach-omap2/board-devkit8000.c         |   39 ++++++------------------
 arch/arm/mach-omap2/board-igep0020.c           |    8 ++---
 arch/arm/mach-omap2/board-n8x0.c               |   18 ++++++-----
 arch/arm/mach-omap2/board-sdp-flash.c          |    8 ++---
 arch/arm/mach-omap2/clock44xx_data.c           |    8 ++---
 arch/arm/mach-omap2/devices.c                  |    2 +
 arch/arm/mach-omap2/gpmc-nand.c                |    3 ++
 arch/arm/mach-omap2/include/mach/entry-macro.S |    2 +
 arch/arm/mach-omap2/omap-headsmp.S             |    6 ++--
 arch/arm/mach-omap2/omap44xx-smc.S             |    2 +
 arch/arm/plat-omap/common.c                    |   22 +++++++++-----
 arch/arm/plat-omap/dma.c                       |    9 ++++++
 arch/arm/plat-omap/gpio.c                      |    6 ++--
 arch/arm/plat-omap/include/plat/irqs.h         |    2 -
 arch/arm/plat-omap/include/plat/mcbsp.h        |    2 +
 arch/arm/plat-omap/include/plat/nand.h         |    7 ++++
 arch/arm/plat-omap/include/plat/omap44xx.h     |    2 +
 22 files changed, 80 insertions(+), 95 deletions(-)

-- 
Signature
