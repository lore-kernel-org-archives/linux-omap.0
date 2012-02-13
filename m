From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Move most of omap io.h into omap-iomap.h
Date: Mon, 13 Feb 2012 15:53:43 -0800
Message-ID: <20120213235216.26087.66303.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50257 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2BMXxp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 18:53:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

This is intended as clean-up before we apply Rob Herring's series
to remove mach/io.h.

Regards,

Tony

---

Tony Lindgren (3):
      ARM: OMAP2+: Move SDRC related functions from io.h into local common.h
      ARM: OMAP: Introduce omap-iomap.h and convert files depending on current io.h to use it
      ARM: OMAP: Move most of io.h to omap-iomap.h


 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |    1 
 arch/arm/mach-omap1/ams-delta-fiq.c            |    3 
 arch/arm/mach-omap1/board-ams-delta.c          |    7 +
 arch/arm/mach-omap1/board-fsample.c            |    7 +
 arch/arm/mach-omap1/board-h2.c                 |    7 -
 arch/arm/mach-omap1/board-h3.c                 |    9 +
 arch/arm/mach-omap1/board-htcherald.c          |    5 -
 arch/arm/mach-omap1/board-innovator.c          |    7 +
 arch/arm/mach-omap1/board-nokia770.c           |    7 +
 arch/arm/mach-omap1/board-osk.c                |    8 -
 arch/arm/mach-omap1/board-palmte.c             |    5 -
 arch/arm/mach-omap1/board-palmtt.c             |   10 +
 arch/arm/mach-omap1/board-palmz71.c            |   10 +
 arch/arm/mach-omap1/board-perseus2.c           |    7 +
 arch/arm/mach-omap1/board-sx1.c                |    7 +
 arch/arm/mach-omap1/board-voiceblue.c          |    7 +
 arch/arm/mach-omap1/clock.c                    |    1 
 arch/arm/mach-omap1/clock_data.c               |    1 
 arch/arm/mach-omap1/devices.c                  |    8 +
 arch/arm/mach-omap1/dma.c                      |    1 
 arch/arm/mach-omap1/flash.c                    |    1 
 arch/arm/mach-omap1/fpga.c                     |    4 
 arch/arm/mach-omap1/id.c                       |    2 
 arch/arm/mach-omap1/include/mach/entry-macro.S |    4 
 arch/arm/mach-omap1/io.c                       |    2 
 arch/arm/mach-omap1/irq.c                      |    5 -
 arch/arm/mach-omap1/lcd_dma.c                  |    4 
 arch/arm/mach-omap1/mcbsp.c                    |    4 
 arch/arm/mach-omap1/pm.c                       |    6 -
 arch/arm/mach-omap1/reset.c                    |    4 
 arch/arm/mach-omap1/sleep.S                    |    5 +
 arch/arm/mach-omap1/sram.S                     |    4 
 arch/arm/mach-omap1/time.c                     |    4 
 arch/arm/mach-omap1/timer32k.c                 |    8 +
 arch/arm/mach-omap1/usb.c                      |    1 
 arch/arm/mach-omap2/board-flash.c              |    1 
 arch/arm/mach-omap2/clock2420_data.c           |    1 
 arch/arm/mach-omap2/clock2430.c                |    1 
 arch/arm/mach-omap2/clock2430_data.c           |    1 
 arch/arm/mach-omap2/clock3xxx_data.c           |    1 
 arch/arm/mach-omap2/clock44xx_data.c           |    2 
 arch/arm/mach-omap2/cm2xxx_3xxx.c              |    3 
 arch/arm/mach-omap2/cm44xx.c                   |    3 
 arch/arm/mach-omap2/cminst44xx.c               |    3 
 arch/arm/mach-omap2/common.c                   |    3 
 arch/arm/mach-omap2/common.h                   |    5 +
 arch/arm/mach-omap2/control.c                  |    1 
 arch/arm/mach-omap2/devices.c                  |    1 
 arch/arm/mach-omap2/io.c                       |    3 
 arch/arm/mach-omap2/irq.c                      |    5 -
 arch/arm/mach-omap2/omap-smp.c                 |    4 
 arch/arm/mach-omap2/pm24xx.c                   |    4 
 arch/arm/mach-omap2/prcm_mpu44xx.c             |    3 
 arch/arm/mach-omap2/prm44xx.c                  |    3 
 arch/arm/mach-omap2/prminst44xx.c              |    3 
 arch/arm/mach-omap2/sdrc2xxx.c                 |    5 -
 arch/arm/mach-omap2/sleep34xx.S                |    4 
 arch/arm/mach-omap2/sram242x.S                 |    4 
 arch/arm/mach-omap2/sram243x.S                 |    4 
 arch/arm/mach-omap2/sram34xx.S                 |    5 -
 arch/arm/plat-omap/devices.c                   |    4 
 arch/arm/plat-omap/dma.c                       |    6 -
 arch/arm/plat-omap/dmtimer.c                   |    1 
 arch/arm/plat-omap/include/plat/io.h           |  226 ------------------------
 arch/arm/plat-omap/include/plat/omap-iomap.h   |  221 +++++++++++++++++++++++
 arch/arm/plat-omap/ocpi.c                      |    2 
 arch/arm/plat-omap/sram.c                      |    2 
 arch/arm/plat-omap/usb.c                       |    1 
 drivers/gpio/gpio-omap.c                       |    7 +
 drivers/pcmcia/omap_cf.c                       |    4 
 drivers/spi/spi-omap-uwire.c                   |    4 
 drivers/usb/host/ohci-omap.c                   |    6 -
 drivers/usb/otg/isp1301_omap.c                 |    7 -
 drivers/video/omap/lcd_ams_delta.c             |    2 
 drivers/video/omap/lcd_inn1510.c               |    2 
 drivers/video/omap/lcd_osk.c                   |    3 
 drivers/video/omap/lcdc.c                      |    7 -
 drivers/video/omap/sossi.c                     |    1 
 78 files changed, 449 insertions(+), 306 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-iomap.h

-- 
Signature
