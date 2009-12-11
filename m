From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] Mostly fixes for 2.6.33
Date: Fri, 11 Dec 2009 15:52:15 -0800
Message-ID: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59914 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761661AbZLKXwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:52:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Getting into fixes mode for omap, except for the first two
patches in this series. The first one adds a mux table for
the cm-t35 board, and second one adds a low-level serial
init function that is needed if some serial ports are left for
other drivers, such as dedicated bluetooth driver.

Other than that, the series contains various fixes from the
linux-omap list.

Regards,

Tony

---

Anand Gadiyar (1):
      omap3: zoom2/3: make MMC slot work again

Cory Maccarrone (1):
      omap1: htcherald: Update defconfig to include mux support

Janusz Krzysztofik (1):
      omap1: LCD_DMA: Use some define rather than a hexadecimal

Kalle Valo (1):
      omap3: rx51: Use wl1251 in SPI mode 3

Ladislav Michl (1):
      omap: arch/arm/plat-omap/devices.c - sort alphabetically

Madhusudhan Chikkature (1):
      omap3: Zoom2/3: Update hsmmc board config params

Mika Westerberg (1):
      OMAP3: serial - allow platforms specify which UARTs to initialize

Mike Rapoport (1):
      omap3: cm-t35: add mux initialization

Sanjeev Premi (1):
      omap3: Fix OMAP35XX_REV macros

Sergey Lapin (1):
      omap3: id code detection 3525 vs 3515

Vimal Singh (1):
      omap: Correcting GPMC_CONFIG1_DEVICETYPE_NAND

manjugk manjugk (1):
      omap3 : Enable TWL4030 Keypad for Zoom2 and Zoom3 boards

vikram pandita (2):
      omap: header: remove unused data-type
      omap: serial: fix non-empty uart fifo read abort


 arch/arm/configs/htcherald_defconfig         |    9 ++
 arch/arm/configs/omap_zoom2_defconfig        |    3 +
 arch/arm/configs/omap_zoom3_defconfig        |    3 +
 arch/arm/mach-omap1/include/mach/lcdc.h      |   57 +++++++++++++++
 arch/arm/mach-omap1/lcd_dma.c                |    3 +
 arch/arm/mach-omap2/Kconfig                  |    1 
 arch/arm/mach-omap2/board-cm-t35.c           |   96 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 -
 arch/arm/mach-omap2/board-zoom-peripherals.c |   14 ++--
 arch/arm/mach-omap2/id.c                     |    4 +
 arch/arm/mach-omap2/serial.c                 |   88 ++++++++++++++++++++----
 arch/arm/plat-omap/devices.c                 |   68 +++++++++---------
 arch/arm/plat-omap/include/plat/board.h      |    9 --
 arch/arm/plat-omap/include/plat/cpu.h        |   20 +++--
 arch/arm/plat-omap/include/plat/gpmc.h       |    2 -
 arch/arm/plat-omap/include/plat/serial.h     |    1 
 drivers/video/omap/lcdc.c                    |   33 ---------
 17 files changed, 291 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/lcdc.h

-- 
Signature
