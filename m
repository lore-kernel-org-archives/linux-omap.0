From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/9] Clean up hardcoded IRQs for mach-omap2,
 enable SPARSE_IRQ, plaform_data/gpio-omap.h
Date: Thu, 30 Aug 2012 17:52:19 -0700
Message-ID: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753058Ab2HaAwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's the first set of omap header clean-up patches needed for single
zImage support. This series is based v3.6-rc3 and the following patches
to avoid merge conflicts with the includes:

- Arnd's patch "ARM: omap: move platform_data definitions"
- Igor's series "ARM: OMAP: cleanup plat/board.h file"
- Afzal's series "Prepare for GPMC driver conversion (w.r.t MTD)"

Regards,

Tony

---

Tony Lindgren (9):
      ARM: OMAP1: Move define of OMAP_LCD_DMA to dma.h
      ARM: OMAP1: Define OMAP1_INT_I2C locally
      ARM: OMAP2+: Make INTCPS_NR_IRQS local for mach-omap2/irq.c
      ARM: OMAP2+: Remove unused nand_irq for GPMC
      ARM: OMAP2+: Remove hardcoded twl4030 gpio_base, irq_base and irq_end
      ARM: OMAP: Move gpio.h to include/linux/platform_data
      ARM: OMAP2+: Prepare for irqs.h removal
      ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ
      ARM: OMAP1: Move plat/irqs.h to mach/irqs.h


 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    1 
 arch/arm/mach-omap1/board-ams-delta.c              |    3 
 arch/arm/mach-omap1/board-osk.c                    |    1 
 arch/arm/mach-omap1/dma.c                          |    3 
 arch/arm/mach-omap1/gpio15xx.c                     |    1 
 arch/arm/mach-omap1/gpio16xx.c                     |    1 
 arch/arm/mach-omap1/gpio7xx.c                      |    1 
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h   |    2 
 arch/arm/mach-omap1/include/mach/gpio.h            |    2 
 arch/arm/mach-omap1/include/mach/irqs.h            |  267 ++++++++++++
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    4 
 arch/arm/mach-omap1/leds.c                         |    1 
 arch/arm/mach-omap2/board-2430sdp.c                |   10 
 arch/arm/mach-omap2/board-3430sdp.c                |    3 
 arch/arm/mach-omap2/board-4430sdp.c                |    3 
 arch/arm/mach-omap2/board-am3517evm.c              |   12 -
 arch/arm/mach-omap2/board-cm-t35.c                 |   15 -
 arch/arm/mach-omap2/board-cm-t3517.c               |    6 
 arch/arm/mach-omap2/board-devkit8000.c             |    3 
 arch/arm/mach-omap2/board-flash.c                  |    3 
 arch/arm/mach-omap2/board-igep0020.c               |   10 
 arch/arm/mach-omap2/board-ldp.c                    |    3 
 arch/arm/mach-omap2/board-n8x0.c                   |    3 
 arch/arm/mach-omap2/board-omap3beagle.c            |    3 
 arch/arm/mach-omap2/board-omap3evm.c               |    3 
 arch/arm/mach-omap2/board-omap3logic.c             |    3 
 arch/arm/mach-omap2/board-omap3pandora.c           |    3 
 arch/arm/mach-omap2/board-omap3stalker.c           |    3 
 arch/arm/mach-omap2/board-omap3touchbook.c         |    3 
 arch/arm/mach-omap2/board-omap4panda.c             |    3 
 arch/arm/mach-omap2/board-overo.c                  |    3 
 arch/arm/mach-omap2/board-rm680.c                  |    9 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    5 
 arch/arm/mach-omap2/board-ti8168evm.c              |    3 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    1 
 arch/arm/mach-omap2/board-zoom-display.c           |    6 
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    9 
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 
 arch/arm/mach-omap2/devices.c                      |    7 
 arch/arm/mach-omap2/gpio.c                         |    1 
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    1 
 arch/arm/mach-omap2/gpmc.c                         |   11 
 arch/arm/mach-omap2/hsmmc.c                        |    5 
 arch/arm/mach-omap2/include/mach/gpio.h            |    2 
 arch/arm/mach-omap2/include/mach/irqs.h            |    2 
 arch/arm/mach-omap2/io.c                           |    2 
 arch/arm/mach-omap2/irq.c                          |    2 
 arch/arm/mach-omap2/mailbox.c                      |    3 
 arch/arm/mach-omap2/mcbsp.c                        |    1 
 arch/arm/mach-omap2/msdi.c                         |    1 
 arch/arm/mach-omap2/omap-iommu.c                   |    1 
 arch/arm/mach-omap2/omap-wakeupgen.c               |    1 
 arch/arm/mach-omap2/omap4-common.c                 |    7 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    9 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   12 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    4 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   33 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 
 arch/arm/mach-omap2/omap_l3_noc.c                  |    6 
 arch/arm/mach-omap2/omap_phy_internal.c            |    2 
 arch/arm/mach-omap2/pm24xx.c                       |    3 
 arch/arm/mach-omap2/pm34xx.c                       |    2 
 arch/arm/mach-omap2/prcm.c                         |    1 
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    3 
 arch/arm/mach-omap2/prm44xx.c                      |    4 
 arch/arm/mach-omap2/prm_common.c                   |    1 
 arch/arm/mach-omap2/serial.c                       |    1 
 arch/arm/mach-omap2/timer.c                        |   10 
 arch/arm/mach-omap2/twl-common.c                   |    3 
 arch/arm/mach-omap2/twl-common.h                   |    6 
 arch/arm/mach-omap2/usb-host.c                     |    1 
 arch/arm/mach-omap2/usb-musb.c                     |    1 
 arch/arm/plat-omap/Kconfig                         |    1 
 arch/arm/plat-omap/i2c.c                           |    3 
 arch/arm/plat-omap/include/plat/dma.h              |    2 
 arch/arm/plat-omap/include/plat/irqs-44xx.h        |  144 ------
 arch/arm/plat-omap/include/plat/irqs.h             |  453 --------------------
 arch/arm/plat-omap/include/plat/omap44xx.h         |    1 
 drivers/dma/omap-dma.c                             |    2 
 drivers/gpio/gpio-omap.c                           |   15 -
 drivers/gpio/gpio-twl4030.c                        |   15 -
 drivers/mfd/twl-core.c                             |    2 
 drivers/mtd/nand/ams-delta.c                       |    8 
 drivers/mtd/onenand/omap2.c                        |    8 
 drivers/tty/serial/8250/8250.c                     |    4 
 drivers/video/omap2/dss/dispc.c                    |    1 
 drivers/video/omap2/omapfb/omapfb-main.c           |    4 
 include/linux/i2c/twl.h                            |    3 
 include/linux/mfd/twl6040.h                        |    2 
 include/linux/platform_data/gpio-omap.h            |   15 -
 include/linux/platform_data/mtd-nand-omap2.h       |    1 
 sound/soc/omap/mcbsp.c                             |    3 
 sound/soc/omap/omap-mcbsp.c                        |    1 
 sound/soc/omap/omap-pcm.c                          |    1 
 sound/soc/omap/sdp3430.c                           |    1 
 96 files changed, 455 insertions(+), 808 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs.h
 rename arch/arm/plat-omap/include/plat/gpio.h => include/linux/platform_data/gpio-omap.h (94%)

-- 
Signature
