From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Series short description
Date: Fri, 31 Aug 2012 17:26:18 -0700
Message-ID: <20120901002534.23715.28654.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:48528 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754706Ab2IAA0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 20:26:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are the changes needed to make hardware.h local for mach-omap2.
These patches are based on v3.6-rc3 and the following patches:

- Arnd's patch "ARM: omap: move platform_data definitions"
- Igor's series "ARM: OMAP: cleanup plat/board.h file"
- Afzal's series "Prepare for GPMC driver conversion (w.r.t MTD)"
- My series "Clean up hardcoded IRQs for mach-omap2, enable SPARSE_IRQ,
  plaform_data/gpio-omap.h"

Regards,

Tony

---

Tony Lindgren (4):
      ARM: OMAP: Remove unused old gpio-switch.h
      ARM: OMAP: Split plat/hardware.h, introduce local hardware.h and soc.h for omap2+
      ARM: OMAP2+ Move SoC specific headers to be local to mach-omap2
      ARM: OMAP1: Move SoC specific headers from plat to mach for omap1


 arch/arm/mach-omap1/board-htcherald.c          |    4 
 arch/arm/mach-omap1/devices.c                  |    2 
 arch/arm/mach-omap1/include/mach/hardware.h    |  285 +++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/omap1510.h    |    3 
 arch/arm/mach-omap1/include/mach/omap16xx.h    |    3 
 arch/arm/mach-omap1/include/mach/omap7xx.h     |    3 
 arch/arm/mach-omap2/am33xx.h                   |    0 
 arch/arm/mach-omap2/board-2430sdp.c            |    2 
 arch/arm/mach-omap2/board-3430sdp.c            |    9 -
 arch/arm/mach-omap2/board-4430sdp.c            |    9 -
 arch/arm/mach-omap2/board-am3517crane.c        |    1 
 arch/arm/mach-omap2/board-am3517evm.c          |    1 
 arch/arm/mach-omap2/board-apollon.c            |    3 
 arch/arm/mach-omap2/board-cm-t35.c             |    2 
 arch/arm/mach-omap2/board-cm-t3517.c           |    3 
 arch/arm/mach-omap2/board-devkit8000.c         |   22 +-
 arch/arm/mach-omap2/board-flash.c              |    6 
 arch/arm/mach-omap2/board-generic.c            |    1 
 arch/arm/mach-omap2/board-h4.c                 |    3 
 arch/arm/mach-omap2/board-igep0020.c           |    1 
 arch/arm/mach-omap2/board-ldp.c                |   10 -
 arch/arm/mach-omap2/board-n8x0.c               |   10 -
 arch/arm/mach-omap2/board-omap3beagle.c        |   12 -
 arch/arm/mach-omap2/board-omap3evm.c           |   11 -
 arch/arm/mach-omap2/board-omap3logic.c         |   16 -
 arch/arm/mach-omap2/board-omap3pandora.c       |    9 -
 arch/arm/mach-omap2/board-omap3stalker.c       |   20 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    9 -
 arch/arm/mach-omap2/board-omap4panda.c         |    7 -
 arch/arm/mach-omap2/board-overo.c              |   14 -
 arch/arm/mach-omap2/board-rm680.c              |    1 
 arch/arm/mach-omap2/board-rx51.c               |    5 
 arch/arm/mach-omap2/board-ti8168evm.c          |    2 
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    4 
 arch/arm/mach-omap2/board-zoom-display.c       |    4 
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    1 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c   |    2 
 arch/arm/mach-omap2/clkt_dpll.c                |    2 
 arch/arm/mach-omap2/clock.c                    |    8 -
 arch/arm/mach-omap2/clock2420_data.c           |    2 
 arch/arm/mach-omap2/clock2430.c                |    2 
 arch/arm/mach-omap2/clock2430_data.c           |    2 
 arch/arm/mach-omap2/clock2xxx.c                |    2 
 arch/arm/mach-omap2/clock33xx_data.c           |    2 
 arch/arm/mach-omap2/clock3xxx.c                |    2 
 arch/arm/mach-omap2/clock3xxx_data.c           |    3 
 arch/arm/mach-omap2/clock44xx_data.c           |    3 
 arch/arm/mach-omap2/cm2xxx_3xxx.c              |    3 
 arch/arm/mach-omap2/common.c                   |    2 
 arch/arm/mach-omap2/common.h                   |    6 
 arch/arm/mach-omap2/control.c                  |    2 
 arch/arm/mach-omap2/control.h                  |    2 
 arch/arm/mach-omap2/devices.c                  |    1 
 arch/arm/mach-omap2/dpll3xxx.c                 |    2 
 arch/arm/mach-omap2/dpll44xx.c                 |    2 
 arch/arm/mach-omap2/emu.c                      |    2 
 arch/arm/mach-omap2/gpmc-nand.c                |    5 
 arch/arm/mach-omap2/gpmc-onenand.c             |    5 
 arch/arm/mach-omap2/gpmc-smc91x.c              |    3 
 arch/arm/mach-omap2/gpmc.c                     |    4 
 arch/arm/mach-omap2/hardware.h                 |    6 
 arch/arm/mach-omap2/hsmmc.c                    |    2 
 arch/arm/mach-omap2/i2c.c                      |    1 
 arch/arm/mach-omap2/id.c                       |    2 
 arch/arm/mach-omap2/include/mach/hardware.h    |    2 
 arch/arm/mach-omap2/io.c                       |    3 
 arch/arm/mach-omap2/irq.c                      |    3 
 arch/arm/mach-omap2/mailbox.c                  |    3 
 arch/arm/mach-omap2/mcbsp.c                    |    5 
 arch/arm/mach-omap2/omap-mpuss-lowpower.c      |    3 
 arch/arm/mach-omap2/omap-smp.c                 |    2 
 arch/arm/mach-omap2/omap-wakeupgen.c           |    2 
 arch/arm/mach-omap2/omap24xx.h                 |    2 
 arch/arm/mach-omap2/omap34xx.h                 |    2 
 arch/arm/mach-omap2/omap4-common.c             |    2 
 arch/arm/mach-omap2/omap44xx.h                 |    1 
 arch/arm/mach-omap2/omap54xx.h                 |    0 
 arch/arm/mach-omap2/omap_hwmod.c               |    8 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c     |    5 
 arch/arm/mach-omap2/omap_hwmod_2430_data.c     |    5 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c     |    3 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c     |    1 
 arch/arm/mach-omap2/omap_l3_noc.c              |    3 
 arch/arm/mach-omap2/omap_phy_internal.c        |    3 
 arch/arm/mach-omap2/opp2420_data.c             |    2 
 arch/arm/mach-omap2/opp2430_data.c             |    2 
 arch/arm/mach-omap2/opp3xxx_data.c             |    2 
 arch/arm/mach-omap2/opp4xxx_data.c             |    3 
 arch/arm/mach-omap2/powerdomain.c              |    6 
 arch/arm/mach-omap2/powerdomains3xxx_data.c    |    4 
 arch/arm/mach-omap2/prm2xxx_3xxx.c             |    4 
 arch/arm/mach-omap2/prm44xx.c                  |    4 
 arch/arm/mach-omap2/sdrc2xxx.c                 |    2 
 arch/arm/mach-omap2/sleep24xx.S                |    3 
 arch/arm/mach-omap2/sleep34xx.S                |    2 
 arch/arm/mach-omap2/sleep44xx.S                |    2 
 arch/arm/mach-omap2/soc.h                      |    1 
 arch/arm/mach-omap2/sram242x.S                 |    3 
 arch/arm/mach-omap2/sram243x.S                 |    3 
 arch/arm/mach-omap2/sram34xx.S                 |    3 
 arch/arm/mach-omap2/ti81xx.h                   |    0 
 arch/arm/mach-omap2/timer.c                    |    3 
 arch/arm/mach-omap2/twl-common.c               |    2 
 arch/arm/mach-omap2/usb-host.c                 |    1 
 arch/arm/mach-omap2/usb-musb.c                 |    6 
 arch/arm/mach-omap2/vc.c                       |    3 
 arch/arm/mach-omap2/voltagedomains3xxx_data.c  |    3 
 arch/arm/plat-omap/Makefile                    |    3 
 arch/arm/plat-omap/counter_32k.c               |    2 
 arch/arm/plat-omap/devices.c                   |   91 -------
 arch/arm/plat-omap/dma.c                       |    3 
 arch/arm/plat-omap/include/plat/gpio-switch.h  |   54 ----
 arch/arm/plat-omap/include/plat/hardware.h     |  293 ------------------------
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    2 
 drivers/spi/spi-omap-uwire.c                   |    3 
 drivers/watchdog/omap_wdt.c                    |    5 
 sound/soc/omap/omap-abe-twl6040.c              |    4 
 sound/soc/omap/omap-mcpdm.c                    |    2 
 118 files changed, 475 insertions(+), 687 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap1510.h => mach-omap1/include/mach/omap1510.h} (97%)
 rename arch/arm/{plat-omap/include/plat/omap16xx.h => mach-omap1/include/mach/omap16xx.h} (99%)
 rename arch/arm/{plat-omap/include/plat/omap7xx.h => mach-omap1/include/mach/omap7xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/am33xx.h => mach-omap2/am33xx.h} (100%)
 create mode 100644 arch/arm/mach-omap2/hardware.h
 rename arch/arm/{plat-omap/include/plat/omap24xx.h => mach-omap2/omap24xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap34xx.h => mach-omap2/omap34xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap44xx.h => mach-omap2/omap44xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap54xx.h => mach-omap2/omap54xx.h} (100%)
 create mode 100644 arch/arm/mach-omap2/soc.h
 rename arch/arm/{plat-omap/include/plat/ti81xx.h => mach-omap2/ti81xx.h} (100%)
 delete mode 100644 arch/arm/plat-omap/devices.c
 delete mode 100644 arch/arm/plat-omap/include/plat/gpio-switch.h
 delete mode 100644 arch/arm/plat-omap/include/plat/hardware.h

-- 
Signature
