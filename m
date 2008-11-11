From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 00/59] namespace cleanup patches
Date: Wed, 12 Nov 2008 00:56:19 +0200
Message-ID: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56830 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbYKKW5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 17:57:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of omap_{read,write}[bsl] defines.
Virtual and physical addresses usage was fixed by Russel King and
there's no need anymore for keeping a define to a standard kernel
function. Get rid of those to keep the namespace cleaner.

Build tested with all omap defconfigs.
Depends on my previous "make clk fwk build again on omap1" patch.

Felipe Balbi (59):
  omap: namespace cleanup to arch/arm/mach-omap1/board-fsample.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-h2.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-nokia770.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-osk.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-palmtt.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-palmz71.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-perseus2.c
  omap: namespace cleanup to arch/arm/mach-omap1/board-voiceblue.c
  omap: namespace cleanup to arch/arm/mach-omap1/clock.c
  omap: namespace cleanup to arch/arm/mach-omap1/devices.c
  omap: namespace cleanup to arch/arm/mach-omap1/id.c
  omap: namespace cleanup to arch/arm/mach-omap1/io.c
  omap: namespace cleanup to arch/arm/mach-omap1/irq.c
  omap: namespace cleanup to arch/arm/mach-omap1/mux.c
  omap: namespace cleanup to arch/arm/mach-omap1/pm.c
  omap: namespace cleanup to arch/arm/mach-omap1/timer32k.c
  omap: namespace cleanup to arch/arm/mach-omap2/pm-debug.c
  omap: namespace cleanup to arch/arm/mach-omap2/pm24xx.c
  omap: namespace cleanup to arch/arm/plat-omap/common.c
  omap: namespace cleanup to arch/arm/plat-omap/dma.c
  omap: namespace cleanup to arch/arm/plat-omap/dmtimer.c
  omap: namespace cleanup to arch/arm/plat-omap/gpio.c
  omap: namespace cleanup to arch/arm/plat-omap/ocpi.c
  omap: namespace cleanup to arch/arm/plat-omap/usb.c
  omap: namespace cleanup to drivers/cbus/tahvo-usb.c
  omap: namespace cleanup to drivers/dsp/dspgateway/dsp.h
  omap: namespace cleanup to drivers/dsp/dspgateway/dsp_common.c
  omap: namespace cleanup to drivers/dsp/dspgateway/mmu.h
  omap: namespace cleanup to drivers/i2c/chips/isp1301_omap.c
  omap: namespace cleanup to drivers/i2c/chips/twl4030-usb.c
  omap: namespace cleanup to drivers/input/keyboard/omap-keypad.c
  omap: namespace cleanup to drivers/mtd/maps/omap_nor.c
  omap: namespace cleanup to drivers/mtd/nand/ams-delta.c
  omap: namespace cleanup to drivers/mtd/nand/omap2.c
  omap: namespace cleanup to drivers/net/irda/omap-ir.c
  omap: namespace cleanup to drivers/pcmcia/omap_cf.c
  omap: namespace cleanup to drivers/rtc/rtc-omap.c
  omap: namespace cleanup to drivers/spi/omap_uwire.c
  omap: namespace cleanup to drivers/usb/gadget/omap_udc.c
  omap: namespace cleanup to drivers/usb/gadget/omap_udc.h
  omap: namespace cleanup to drivers/usb/host/ehci-omap.c
  omap: namespace cleanup to drivers/usb/host/ehci-omap.h
  omap: namespace cleanup to drivers/usb/host/ohci-omap.c
  omap: namespace cleanup to drivers/usb/musb/omap2430.c
  omap: namespace cleanup to drivers/video/backlight/omap1_bl.c
  omap: namespace cleanup to drivers/video/omap/dispc.c
  omap: namespace cleanup to drivers/video/omap/lcd_ams_delta.c
  omap: namespace cleanup to drivers/video/omap/lcd_osk.c
  omap: namespace cleanup to drivers/video/omap/lcd_p2.c
  omap: namespace cleanup to drivers/video/omap/lcdc.c
  omap: namespace cleanup to drivers/video/omap/sossi.c
  omap: namespace cleanup to fs/xfs/linux-2.6/xfs_aops.c
  omap: namespace cleanup to fs/xfs/xfs_iomap.c
  omap: namespace cleanup to fs/xfs/xfs_iomap.h
  omap: namespace cleanup to arch/arm/plat-omap/include/mach/mtd-xip.h
  omap: namespace cleanup to arch/arm/plat-omap/include/mach/pm.h
  omap: namespace cleanup to arch/arm/plat-omap/include/mach/system.h
  omap: namespace cleanup to arch/arm/plat-omap/include/mach/tc.h
  omap: namespace cleanup to arch/arm/plat-omap/include/mach/io.h

 arch/arm/mach-omap1/board-fsample.c       |   12 +-
 arch/arm/mach-omap1/board-h2.c            |    2 +-
 arch/arm/mach-omap1/board-nokia770.c      |    4 +-
 arch/arm/mach-omap1/board-osk.c           |   12 +-
 arch/arm/mach-omap1/board-palmtt.c        |    6 +-
 arch/arm/mach-omap1/board-palmz71.c       |    6 +-
 arch/arm/mach-omap1/board-perseus2.c      |   12 +-
 arch/arm/mach-omap1/board-voiceblue.c     |    8 +-
 arch/arm/mach-omap1/clock.c               |   54 ++--
 arch/arm/mach-omap1/devices.c             |    2 +-
 arch/arm/mach-omap1/id.c                  |   30 +-
 arch/arm/mach-omap1/io.c                  |    4 +-
 arch/arm/mach-omap1/irq.c                 |   16 +-
 arch/arm/mach-omap1/mux.c                 |   12 +-
 arch/arm/mach-omap1/pm.c                  |   54 ++--
 arch/arm/mach-omap1/timer32k.c            |    6 +-
 arch/arm/mach-omap2/pm-debug.c            |    2 +-
 arch/arm/mach-omap2/pm24xx.c              |    6 +-
 arch/arm/plat-omap/common.c               |    2 +-
 arch/arm/plat-omap/dma.c                  |   86 +++---
 arch/arm/plat-omap/dmtimer.c              |    6 +-
 arch/arm/plat-omap/gpio.c                 |    6 +-
 arch/arm/plat-omap/include/mach/io.h      |   17 --
 arch/arm/plat-omap/include/mach/mtd-xip.h |    2 +-
 arch/arm/plat-omap/include/mach/pm.h      |   20 +-
 arch/arm/plat-omap/include/mach/system.h  |    6 +-
 arch/arm/plat-omap/include/mach/tc.h      |    4 +-
 arch/arm/plat-omap/ocpi.c                 |    8 +-
 arch/arm/plat-omap/usb.c                  |   82 +++---
 drivers/cbus/tahvo-usb.c                  |   70 +++---
 drivers/dsp/dspgateway/dsp.h              |   12 +-
 drivers/dsp/dspgateway/dsp_common.c       |    2 +-
 drivers/dsp/dspgateway/mmu.h              |    2 +-
 drivers/i2c/chips/isp1301_omap.c          |  118 +++++-----
 drivers/i2c/chips/twl4030-usb.c           |    8 +-
 drivers/input/keyboard/omap-keypad.c      |   24 +-
 drivers/mtd/maps/omap_nor.c               |    8 +-
 drivers/mtd/nand/ams-delta.c              |    8 +-
 drivers/mtd/nand/omap2.c                  |   12 +-
 drivers/net/irda/omap-ir.c                |    8 +-
 drivers/pcmcia/omap_cf.c                  |   20 +-
 drivers/rtc/rtc-omap.c                    |    4 +-
 drivers/spi/omap_uwire.c                  |    4 +-
 drivers/usb/gadget/omap_udc.c             |  406 ++++++++++++++--------------
 drivers/usb/gadget/omap_udc.h             |    4 +-
 drivers/usb/host/ehci-omap.c              |   48 ++--
 drivers/usb/host/ehci-omap.h              |    2 +-
 drivers/usb/host/ohci-omap.c              |   24 +-
 drivers/usb/musb/omap2430.c               |   30 +-
 drivers/video/backlight/omap1_bl.c        |    4 +-
 drivers/video/omap/dispc.c                |    2 +-
 drivers/video/omap/lcd_ams_delta.c        |    4 +-
 drivers/video/omap/lcd_osk.c              |    8 +-
 drivers/video/omap/lcd_p2.c               |    8 +-
 drivers/video/omap/lcdc.c                 |   38 ++--
 drivers/video/omap/sossi.c                |   10 +-
 fs/xfs/linux-2.6/xfs_aops.c               |    2 +-
 fs/xfs/xfs_iomap.c                        |   14 +-
 fs/xfs/xfs_iomap.h                        |    8 +-
 59 files changed, 691 insertions(+), 708 deletions(-)

