From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/8] Split omap plat/io.h into local iomap.h files
Date: Tue, 21 Feb 2012 15:40:32 -0800
Message-ID: <20120221233619.18709.87982.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2BUXke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 18:40:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's a better version of a patch set to cut down mach/io.h down to
minimum to prepare for mach/io.h removal for omap2+.

This is based on v3.3-rc4 + "ARM: OMAP2xxx: PM: remove obsolete timer
disable code in the suspend path" patch.

Regards,

Tony

---

Tony Lindgren (8):
      ARM: OMAP2+: Move DISPC L3 firewall to happen in omap_display_init()
      ARM: OMAP2+: Move SDRC related functions from io.h into local common.h
      ARM: OMAP: Move omap_init_consistent_dma_size() to local common.h
      ARM: OMAP1: Move 16xx GPIO system clock to platform init code
      ARM: OMAP1: Move most of plat/io.h into local iomap.h
      ARM: OMAP2+: Move most of plat/io.h into local iomap.h
      ARM: OMAP: Remove plat/io.h by moving it into mach/io.h
      ARM: OMAP2+: Limit omap_read/write usage to legacy USB drivers


 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |    3 -
 arch/arm/mach-omap1/ams-delta-fiq.c            |    1 
 arch/arm/mach-omap1/board-ams-delta.c          |   10 +-
 arch/arm/mach-omap1/board-fsample.c            |    7 +-
 arch/arm/mach-omap1/board-h2.c                 |    6 +
 arch/arm/mach-omap1/board-h3.c                 |    8 +-
 arch/arm/mach-omap1/board-htcherald.c          |    5 -
 arch/arm/mach-omap1/board-innovator.c          |    7 +-
 arch/arm/mach-omap1/board-nokia770.c           |    6 +
 arch/arm/mach-omap1/board-osk.c                |    7 +-
 arch/arm/mach-omap1/board-palmte.c             |    4 +
 arch/arm/mach-omap1/board-palmtt.c             |    9 +-
 arch/arm/mach-omap1/board-palmz71.c            |    9 +-
 arch/arm/mach-omap1/board-perseus2.c           |    7 +-
 arch/arm/mach-omap1/board-sx1.c                |    6 +
 arch/arm/mach-omap1/board-voiceblue.c          |    6 +
 arch/arm/mach-omap1/clock.c                    |    2 
 arch/arm/mach-omap1/clock_data.c               |    2 
 arch/arm/mach-omap1/common.h                   |    1 
 arch/arm/mach-omap1/devices.c                  |    8 +-
 arch/arm/mach-omap1/dma.c                      |    2 
 arch/arm/mach-omap1/flash.c                    |    2 
 arch/arm/mach-omap1/fpga.c                     |    5 +
 arch/arm/mach-omap1/gpio16xx.c                 |    7 ++
 arch/arm/mach-omap1/id.c                       |    1 
 arch/arm/mach-omap1/include/mach/entry-macro.S |    4 +
 arch/arm/mach-omap1/include/mach/io.h          |   78 +++++++++++++++++++
 arch/arm/mach-omap1/io.c                       |    3 +
 arch/arm/mach-omap1/iomap.h                    |   18 ++++
 arch/arm/mach-omap1/irq.c                      |    4 +
 arch/arm/mach-omap1/lcd_dma.c                  |    3 -
 arch/arm/mach-omap1/mcbsp.c                    |    5 +
 arch/arm/mach-omap1/pm.c                       |    6 +
 arch/arm/mach-omap1/reset.c                    |    3 -
 arch/arm/mach-omap1/sleep.S                    |    4 +
 arch/arm/mach-omap1/sram.S                     |    4 +
 arch/arm/mach-omap1/time.c                     |    3 -
 arch/arm/mach-omap1/timer32k.c                 |    7 +-
 arch/arm/mach-omap2/clock2420_data.c           |    1 
 arch/arm/mach-omap2/clock2430.c                |    1 
 arch/arm/mach-omap2/clock2430_data.c           |    1 
 arch/arm/mach-omap2/clock3xxx_data.c           |    3 -
 arch/arm/mach-omap2/clock44xx_data.c           |    3 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c              |    2 
 arch/arm/mach-omap2/cm44xx.c                   |    2 
 arch/arm/mach-omap2/cminst44xx.c               |    2 
 arch/arm/mach-omap2/common.c                   |    4 -
 arch/arm/mach-omap2/common.h                   |    7 ++
 arch/arm/mach-omap2/control.c                  |    3 -
 arch/arm/mach-omap2/control.h                  |    1 
 arch/arm/mach-omap2/devices.c                  |    2 
 arch/arm/mach-omap2/display.c                  |    4 +
 arch/arm/mach-omap2/include/mach/io.h          |   60 ++++++++++++++-
 arch/arm/mach-omap2/io.c                       |   57 ++------------
 arch/arm/mach-omap2/iomap.h                    |   98 ------------------------
 arch/arm/mach-omap2/irq.c                      |    5 +
 arch/arm/mach-omap2/omap-smp.c                 |    3 -
 arch/arm/mach-omap2/pm24xx.c                   |    5 -
 arch/arm/mach-omap2/prcm_mpu44xx.c             |    2 
 arch/arm/mach-omap2/prm44xx.c                  |    3 -
 arch/arm/mach-omap2/prminst44xx.c              |    2 
 arch/arm/mach-omap2/sdram-nokia.c              |    1 
 arch/arm/mach-omap2/sdrc2xxx.c                 |    5 +
 arch/arm/mach-omap2/sleep24xx.S                |    1 
 arch/arm/mach-omap2/sleep34xx.S                |    4 +
 arch/arm/mach-omap2/sram242x.S                 |    4 +
 arch/arm/mach-omap2/sram243x.S                 |    4 +
 arch/arm/mach-omap2/sram34xx.S                 |    5 +
 arch/arm/plat-omap/dma.c                       |    2 
 arch/arm/plat-omap/include/plat/tc.h           |    4 +
 arch/arm/plat-omap/include/plat/usb.h          |   40 ++++++++++
 arch/arm/plat-omap/sram.c                      |    9 +-
 arch/arm/plat-omap/usb.c                       |    2 
 drivers/gpio/gpio-omap.c                       |    8 --
 drivers/video/omap/Kconfig                     |    2 
 drivers/video/omap2/dss/dispc.c                |    5 -
 76 files changed, 385 insertions(+), 255 deletions(-)
 create mode 100644 arch/arm/mach-omap1/iomap.h
 rename arch/arm/{plat-omap/include/plat/io.h => mach-omap2/iomap.h} (67%)

-- 
Signature
