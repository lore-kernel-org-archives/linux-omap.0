From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/17] Resend of mach-omap2 sparse IRQ and hardware.h cleanup
Date: Mon, 10 Sep 2012 22:30:40 -0700
Message-ID: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47896 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751251Ab2IKFam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:30:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's a resend of the changes needed to make sparse IRQ work
for mach-omap2, and to make hardware.h local. I noticed several
places where make randconfig was failing that I fixed, and
also split up the patches a bit more.

I also dropped the dependency to Arnd's "ARM: omap: move
platform_data definitions" as that has not yet been posted
for review, and has only been applied into a test branch.

Merging with Arnd's patch will cause trivial merge conflicts
in several places, but that should not be too bad actually;
I've left out extra moving of includes from this series where
to the core omap code where there should not be any merge
conflicts.

These are based on v3.6-rc5 and the following patches:

- Igor's series "ARM: OMAP: cleanup plat/board.h file"
- Afzal's series "Prepare for GPMC driver conversion (w.r.t MTD)"
- Patch "ARM: OMAP4: Fix array size for irq_target_cpu"

The earlier patches were posted at [1] and [2] below.

Regards,

Tony

[1] http://www.spinics.net/lists/arm-kernel/msg191845.html
[2] http://www.spinics.net/lists/arm-kernel/msg192065.html

---

Tony Lindgren (17):
      ARM: OMAP1: Move define of OMAP_LCD_DMA to dma.h
      ARM: OMAP1: Define OMAP1_INT_I2C locally
      ARM: OMAP2+: Make INTCPS_NR_IRQS local for mach-omap2/irq.c
      ARM: OMAP2+: Remove unused nand_irq for GPMC
      ARM: OMAP2+: Remove hardcoded twl4030 gpio_base, irq_base and irq_end
      ARM: OMAP: Move gpio.h to include/linux/platform_data
      Input: omap-keypad: Remove dependencies to mach includes
      W1: OMAP HDQ1W: Remove dependencies to mach/hardware.h
      serial/8250: Limit the omap workarounds to omap1
      staging: tidspbridge: Prepare for irqs.h removal
      ARM: OMAP2+: Prepare for irqs.h removal
      ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ
      ARM: OMAP1: Move plat/irqs.h to mach/irqs.h
      ARM: OMAP: Remove unused old gpio-switch.h
      ARM: OMAP: Split plat/hardware.h, use local soc.h for omap2+
      ARM: OMAP2+ Move SoC specific headers to be local to mach-omap2
      ARM: OMAP1: Move SoC specific headers from plat to mach for omap1


 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    1 
 arch/arm/mach-omap1/board-ams-delta.c              |    1 
 arch/arm/mach-omap1/board-htcherald.c              |    2 
 arch/arm/mach-omap1/board-osk.c                    |    1 
 arch/arm/mach-omap1/devices.c                      |    2 
 arch/arm/mach-omap1/dma.c                          |    3 
 arch/arm/mach-omap1/gpio15xx.c                     |    1 
 arch/arm/mach-omap1/gpio16xx.c                     |    1 
 arch/arm/mach-omap1/gpio7xx.c                      |    1 
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h   |    2 
 arch/arm/mach-omap1/include/mach/gpio.h            |    2 
 arch/arm/mach-omap1/include/mach/hardware.h        |  285 ++++++++++++-
 arch/arm/mach-omap1/include/mach/irqs.h            |  267 ++++++++++++
 arch/arm/mach-omap1/include/mach/omap1510.h        |    3 
 arch/arm/mach-omap1/include/mach/omap16xx.h        |    3 
 arch/arm/mach-omap1/include/mach/omap7xx.h         |    3 
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    1 
 arch/arm/mach-omap1/leds.c                         |    1 
 arch/arm/mach-omap2/am33xx.h                       |    0 
 arch/arm/mach-omap2/board-2430sdp.c                |    5 
 arch/arm/mach-omap2/board-3430sdp.c                |    4 
 arch/arm/mach-omap2/board-4430sdp.c                |    5 
 arch/arm/mach-omap2/board-am3517crane.c            |    1 
 arch/arm/mach-omap2/board-am3517evm.c              |    5 
 arch/arm/mach-omap2/board-apollon.c                |    1 
 arch/arm/mach-omap2/board-cm-t35.c                 |    4 
 arch/arm/mach-omap2/board-cm-t3517.c               |    3 
 arch/arm/mach-omap2/board-devkit8000.c             |    6 
 arch/arm/mach-omap2/board-flash.c                  |    4 
 arch/arm/mach-omap2/board-generic.c                |    1 
 arch/arm/mach-omap2/board-h4.c                     |    3 
 arch/arm/mach-omap2/board-igep0020.c               |    4 
 arch/arm/mach-omap2/board-ldp.c                    |    6 
 arch/arm/mach-omap2/board-n8x0.c                   |    4 
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 
 arch/arm/mach-omap2/board-omap3evm.c               |    4 
 arch/arm/mach-omap2/board-omap3logic.c             |   17 -
 arch/arm/mach-omap2/board-omap3pandora.c           |    4 
 arch/arm/mach-omap2/board-omap3stalker.c           |    9 
 arch/arm/mach-omap2/board-omap3touchbook.c         |    4 
 arch/arm/mach-omap2/board-omap4panda.c             |    5 
 arch/arm/mach-omap2/board-overo.c                  |    5 
 arch/arm/mach-omap2/board-rm680.c                  |    6 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    5 
 arch/arm/mach-omap2/board-rx51.c                   |    1 
 arch/arm/mach-omap2/board-ti8168evm.c              |    2 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    3 
 arch/arm/mach-omap2/board-zoom-display.c           |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    6 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    2 
 arch/arm/mach-omap2/clkt_dpll.c                    |    2 
 arch/arm/mach-omap2/clock.c                        |    8 
 arch/arm/mach-omap2/clock2420_data.c               |    2 
 arch/arm/mach-omap2/clock2430.c                    |    2 
 arch/arm/mach-omap2/clock2430_data.c               |    2 
 arch/arm/mach-omap2/clock2xxx.c                    |    2 
 arch/arm/mach-omap2/clock33xx_data.c               |    2 
 arch/arm/mach-omap2/clock3xxx.c                    |    2 
 arch/arm/mach-omap2/clock3xxx_data.c               |    2 
 arch/arm/mach-omap2/clock44xx_data.c               |    2 
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    3 
 arch/arm/mach-omap2/common-board-devices.c         |    1 
 arch/arm/mach-omap2/common.c                       |    2 
 arch/arm/mach-omap2/common.h                       |    9 
 arch/arm/mach-omap2/control.c                      |    2 
 arch/arm/mach-omap2/control.h                      |    2 
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 
 arch/arm/mach-omap2/devices.c                      |   18 -
 arch/arm/mach-omap2/dpll3xxx.c                     |    2 
 arch/arm/mach-omap2/dpll44xx.c                     |    2 
 arch/arm/mach-omap2/emu.c                          |    3 
 arch/arm/mach-omap2/gpio.c                         |    1 
 arch/arm/mach-omap2/gpmc-nand.c                    |    3 
 arch/arm/mach-omap2/gpmc-onenand.c                 |    3 
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    2 
 arch/arm/mach-omap2/gpmc.c                         |   11 
 arch/arm/mach-omap2/hsmmc.c                        |    2 
 arch/arm/mach-omap2/i2c.c                          |    1 
 arch/arm/mach-omap2/id.c                           |    2 
 arch/arm/mach-omap2/include/mach/gpio.h            |    2 
 arch/arm/mach-omap2/include/mach/hardware.h        |    2 
 arch/arm/mach-omap2/include/mach/irqs.h            |    2 
 arch/arm/mach-omap2/io.c                           |    1 
 arch/arm/mach-omap2/irq.c                          |    5 
 arch/arm/mach-omap2/mailbox.c                      |    4 
 arch/arm/mach-omap2/mcbsp.c                        |    2 
 arch/arm/mach-omap2/msdi.c                         |    1 
 arch/arm/mach-omap2/omap-iommu.c                   |   12 -
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    3 
 arch/arm/mach-omap2/omap-smp.c                     |    2 
 arch/arm/mach-omap2/omap-wakeupgen.c               |    1 
 arch/arm/mach-omap2/omap24xx.h                     |    2 
 arch/arm/mach-omap2/omap34xx.h                     |    2 
 arch/arm/mach-omap2/omap4-common.c                 |    9 
 arch/arm/mach-omap2/omap44xx.h                     |    2 
 arch/arm/mach-omap2/omap54xx.h                     |    0 
 arch/arm/mach-omap2/omap_hwmod.c                   |    8 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   25 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   73 ++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  108 ++---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    8 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  152 +++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    3 
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 
 arch/arm/mach-omap2/omap_l3_noc.c                  |    5 
 arch/arm/mach-omap2/omap_phy_internal.c            |    2 
 arch/arm/mach-omap2/opp2420_data.c                 |    2 
 arch/arm/mach-omap2/opp2430_data.c                 |    2 
 arch/arm/mach-omap2/opp3xxx_data.c                 |    2 
 arch/arm/mach-omap2/opp4xxx_data.c                 |    3 
 arch/arm/mach-omap2/pm24xx.c                       |    3 
 arch/arm/mach-omap2/pm34xx.c                       |    2 
 arch/arm/mach-omap2/powerdomain.c                  |    6 
 arch/arm/mach-omap2/powerdomains3xxx_data.c        |    4 
 arch/arm/mach-omap2/prcm.c                         |    1 
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    7 
 arch/arm/mach-omap2/prm44xx.c                      |    5 
 arch/arm/mach-omap2/prm_common.c                   |    1 
 arch/arm/mach-omap2/sdrc2xxx.c                     |    2 
 arch/arm/mach-omap2/serial.c                       |    1 
 arch/arm/mach-omap2/sleep24xx.S                    |    3 
 arch/arm/mach-omap2/sleep34xx.S                    |    2 
 arch/arm/mach-omap2/sleep44xx.S                    |    2 
 arch/arm/mach-omap2/soc.h                          |    7 
 arch/arm/mach-omap2/sram242x.S                     |    3 
 arch/arm/mach-omap2/sram243x.S                     |    3 
 arch/arm/mach-omap2/sram34xx.S                     |    3 
 arch/arm/mach-omap2/ti81xx.h                       |    0 
 arch/arm/mach-omap2/timer.c                        |    9 
 arch/arm/mach-omap2/twl-common.c                   |    3 
 arch/arm/mach-omap2/twl-common.h                   |    6 
 arch/arm/mach-omap2/usb-host.c                     |    2 
 arch/arm/mach-omap2/usb-musb.c                     |    7 
 arch/arm/mach-omap2/vc.c                           |    3 
 arch/arm/mach-omap2/voltagedomains3xxx_data.c      |    3 
 arch/arm/plat-omap/Kconfig                         |    1 
 arch/arm/plat-omap/Makefile                        |    3 
 arch/arm/plat-omap/counter_32k.c                   |    2 
 arch/arm/plat-omap/debug-leds.c                    |    1 
 arch/arm/plat-omap/devices.c                       |   91 ----
 arch/arm/plat-omap/dma.c                           |    3 
 arch/arm/plat-omap/i2c.c                           |    3 
 arch/arm/plat-omap/include/plat/cpu.h              |    3 
 arch/arm/plat-omap/include/plat/dma.h              |    2 
 arch/arm/plat-omap/include/plat/gpio-switch.h      |   54 --
 arch/arm/plat-omap/include/plat/hardware.h         |  293 -------------
 arch/arm/plat-omap/include/plat/irqs-44xx.h        |  144 ------
 arch/arm/plat-omap/include/plat/irqs.h             |  453 --------------------
 arch/arm/plat-omap/include/plat/nand.h             |    1 
 arch/arm/plat-omap/include/plat/omap4-keypad.h     |    2 
 drivers/dma/omap-dma.c                             |    2 
 drivers/gpio/gpio-omap.c                           |   15 -
 drivers/gpio/gpio-twl4030.c                        |   15 -
 drivers/input/keyboard/omap-keypad.c               |   34 +-
 drivers/media/video/omap/omap_vout.c               |    1 
 drivers/media/video/omap3isp/isp.c                 |    2 
 drivers/mfd/twl-core.c                             |    2 
 drivers/mtd/nand/ams-delta.c                       |    8 
 drivers/mtd/onenand/omap2.c                        |    1 
 drivers/power/avs/smartreflex.c                    |    2 
 drivers/spi/spi-omap-uwire.c                       |    3 
 drivers/staging/tidspbridge/core/dsp-clock.c       |    2 
 drivers/staging/tidspbridge/core/tiomap3430.c      |    4 
 drivers/staging/tidspbridge/core/wdt.c             |    3 
 drivers/tty/serial/8250/8250.c                     |    4 
 drivers/video/omap2/dss/dispc.c                    |    1 
 drivers/video/omap2/omapfb/omapfb-main.c           |    1 
 drivers/w1/masters/omap_hdq.c                      |    3 
 drivers/watchdog/omap_wdt.c                        |    5 
 include/linux/i2c/twl.h                            |    3 
 include/linux/mfd/twl6040.h                        |    1 
 include/linux/platform_data/gpio-omap.h            |   15 -
 sound/soc/omap/mcbsp.c                             |    2 
 sound/soc/omap/omap-abe-twl6040.c                  |    4 
 sound/soc/omap/omap-mcbsp.c                        |    1 
 sound/soc/omap/omap-mcpdm.c                        |    2 
 sound/soc/omap/omap-pcm.c                          |    1 
 sound/soc/omap/sdp3430.c                           |    1 
 178 files changed, 1003 insertions(+), 1536 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap1510.h => mach-omap1/include/mach/omap1510.h} (97%)
 rename arch/arm/{plat-omap/include/plat/omap16xx.h => mach-omap1/include/mach/omap16xx.h} (99%)
 rename arch/arm/{plat-omap/include/plat/omap7xx.h => mach-omap1/include/mach/omap7xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/am33xx.h => mach-omap2/am33xx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/omap24xx.h => mach-omap2/omap24xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap34xx.h => mach-omap2/omap34xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap44xx.h => mach-omap2/omap44xx.h} (97%)
 rename arch/arm/{plat-omap/include/plat/omap54xx.h => mach-omap2/omap54xx.h} (100%)
 create mode 100644 arch/arm/mach-omap2/soc.h
 rename arch/arm/{plat-omap/include/plat/ti81xx.h => mach-omap2/ti81xx.h} (100%)
 delete mode 100644 arch/arm/plat-omap/devices.c
 delete mode 100644 arch/arm/plat-omap/include/plat/gpio-switch.h
 delete mode 100644 arch/arm/plat-omap/include/plat/hardware.h
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs.h
 rename arch/arm/plat-omap/include/plat/gpio.h => include/linux/platform_data/gpio-omap.h (94%)

-- 
Signature
