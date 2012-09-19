From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/29] More omap header moves for common zImage support
Date: Wed, 19 Sep 2012 14:05:31 -0700
Message-ID: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25716 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751884Ab2ISVFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's a series of mostly automated patches to make more
omap headers local for the common zImage support.

I'd like to merge this as a late series via arm-soc
after the other changes are merged to avoid further
merge conflicts. I can easily regenerate this series
on top of the other multiarch changes as needed.

Regards,

Tony

---

Tony Lindgren (29):
      ARM: OMAP: Remove unused param.h
      ARM: OMAP: Remove smp.h
      ARM: OMAP1: Make plat/mux.h omap1 only
      ARM: OMAP1: Move board-ams-delta.h from plat to mach
      ARM: OMAP2+: Make id.h local
      ARM: OMAP1: Move keypad.h from plat to mach
      ARM: OMAP1: Move lcd_mipid.h from plat to mach
      ARM: OMAP2+: Make board-zoom.h local
      ARM: OMAP2+: Make am35xx.h local
      ARM: OMAP2+: Make board-rx51.h local
      ARM: OMAP2+: Make ctrl_module_core_44xx.h local
      ARM: OMAP2+: Make ctrl_module_pad_core_44xx.h local
      ARM: OMAP2+: Make ctrl_module_pad_wkup_44xx.h local
      ARM: OMAP2+: Make ctrl_module_wkup_44xx.h local
      ARM: OMAP2+: Make omap-secure.h local
      ARM: OMAP2+: Make omap-wakeupgen.h local
      ARM: OMAP1: Move board-sx1.h from plat to mach
      ARM: OMAP1: Move board-voiceblue.h from plat to mach
      ARM: OMAP2+: Make debug-devices.h local
      ARM: OMAP1: Move flash.h from plat to mach
      ARM: OMAP2+: Make gpmc-smc91x.h local
      ARM: OMAP2+: Make gpmc-smsc911x.h local
      ARM: OMAP2+: Make hdq1w.h local
      ARM: OMAP1: Move irda.h from plat to mach
      ARM: OMAP2+: Make l3_2xxx.h local
      ARM: OMAP2+: Make l3_3xxx.h local
      ARM: OMAP2+: Make l4_2xxx.h local
      ARM: OMAP2+: Make l4_3xxx.h local
      ARM: OMAP2+: Make omap4-keypad.h local


 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    2 
 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 
 arch/arm/mach-omap1/board-ams-delta.c              |    6 +
 arch/arm/mach-omap1/board-fsample.c                |    6 +
 arch/arm/mach-omap1/board-generic.c                |    2 
 arch/arm/mach-omap1/board-h2.c                     |    8 +-
 arch/arm/mach-omap1/board-h3.c                     |    6 +
 arch/arm/mach-omap1/board-htcherald.c              |    2 
 arch/arm/mach-omap1/board-innovator.c              |    6 +
 arch/arm/mach-omap1/board-nokia770.c               |    6 +
 arch/arm/mach-omap1/board-osk.c                    |    6 +
 arch/arm/mach-omap1/board-palmte.c                 |    8 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    8 +-
 arch/arm/mach-omap1/board-palmz71.c                |    8 +-
 arch/arm/mach-omap1/board-perseus2.c               |    6 +
 arch/arm/mach-omap1/board-sx1-mmc.c                |    2 
 arch/arm/mach-omap1/board-sx1.c                    |   10 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    6 +
 arch/arm/mach-omap1/devices.c                      |    2 
 arch/arm/mach-omap1/flash.c                        |    2 
 arch/arm/mach-omap1/i2c.c                          |    2 
 arch/arm/mach-omap1/include/mach/board-ams-delta.h |    0 
 arch/arm/mach-omap1/include/mach/board-sx1.h       |    0 
 arch/arm/mach-omap1/include/mach/board-voiceblue.h |    0 
 arch/arm/mach-omap1/include/mach/flash.h           |    0 
 arch/arm/mach-omap1/include/mach/irda.h            |    0 
 arch/arm/mach-omap1/include/mach/keypad.h          |    0 
 arch/arm/mach-omap1/include/mach/lcd_mipid.h       |    0 
 arch/arm/mach-omap1/include/mach/mux.h             |    0 
 arch/arm/mach-omap1/include/mach/smp.h             |    5 -
 arch/arm/mach-omap1/io.c                           |    2 
 arch/arm/mach-omap1/mcbsp.c                        |    2 
 arch/arm/mach-omap1/mux.c                          |   58 ++++++++++++-
 arch/arm/mach-omap1/pm.c                           |    2 
 arch/arm/mach-omap1/serial.c                       |    2 
 arch/arm/mach-omap1/usb.c                          |    2 
 arch/arm/mach-omap2/am35xx-emac.c                  |    2 
 arch/arm/mach-omap2/am35xx.h                       |    0 
 arch/arm/mach-omap2/board-2430sdp.c                |    2 
 arch/arm/mach-omap2/board-3430sdp.c                |    2 
 arch/arm/mach-omap2/board-3630sdp.c                |    4 -
 arch/arm/mach-omap2/board-4430sdp.c                |    2 
 arch/arm/mach-omap2/board-am3517evm.c              |    2 
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 
 arch/arm/mach-omap2/board-cm-t3517.c               |    2 
 arch/arm/mach-omap2/board-devkit8000.c             |    2 
 arch/arm/mach-omap2/board-h4.c                     |    2 
 arch/arm/mach-omap2/board-igep0020.c               |    2 
 arch/arm/mach-omap2/board-ldp.c                    |    4 -
 arch/arm/mach-omap2/board-omap3evm.c               |    2 
 arch/arm/mach-omap2/board-omap3logic.c             |    2 
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 
 arch/arm/mach-omap2/board-overo.c                  |    2 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    4 -
 arch/arm/mach-omap2/board-rx51-video.c             |    2 
 arch/arm/mach-omap2/board-rx51.h                   |    0 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    4 -
 arch/arm/mach-omap2/board-zoom-display.c           |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c       |   16 ----
 arch/arm/mach-omap2/board-zoom.c                   |    2 
 arch/arm/mach-omap2/board-zoom.h                   |    0 
 arch/arm/mach-omap2/common.c                       |    1 
 arch/arm/mach-omap2/control.h                      |    8 +-
 arch/arm/mach-omap2/ctrl_module_core_44xx.h        |    0 
 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h    |    0 
 arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h    |    0 
 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h        |    0 
 arch/arm/mach-omap2/debug-devices.h                |    0 
 arch/arm/mach-omap2/devices.c                      |    2 
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    2 
 arch/arm/mach-omap2/gpmc-smc91x.h                  |    0 
 arch/arm/mach-omap2/gpmc-smsc911x.c                |    2 
 arch/arm/mach-omap2/gpmc-smsc911x.h                |    0 
 arch/arm/mach-omap2/hdq1w.c                        |    2 
 arch/arm/mach-omap2/hdq1w.h                        |    0 
 arch/arm/mach-omap2/hsmmc.c                        |    1 
 arch/arm/mach-omap2/id.c                           |    2 
 arch/arm/mach-omap2/id.h                           |    0 
 arch/arm/mach-omap2/include/mach/smp.h             |    5 -
 arch/arm/mach-omap2/l3_2xxx.h                      |    0 
 arch/arm/mach-omap2/l3_3xxx.h                      |    0 
 arch/arm/mach-omap2/l4_2xxx.h                      |    0 
 arch/arm/mach-omap2/l4_3xxx.h                      |    0 
 arch/arm/mach-omap2/omap-hotplug.c                 |    2 
 arch/arm/mach-omap2/omap-secure.c                  |    2 
 arch/arm/mach-omap2/omap-secure.h                  |    0 
 arch/arm/mach-omap2/omap-smp.c                     |    4 -
 arch/arm/mach-omap2/omap-wakeupgen.c               |    4 -
 arch/arm/mach-omap2/omap-wakeupgen.h               |    0 
 arch/arm/mach-omap2/omap4-common.c                 |    2 
 arch/arm/mach-omap2/omap4-keypad.h                 |    0 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    4 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    4 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 +
 arch/arm/mach-omap2/sleep44xx.S                    |    2 
 arch/arm/mach-omap2/usb-musb.c                     |    2 
 arch/arm/plat-omap/Makefile                        |    2 
 arch/arm/plat-omap/i2c.c                           |    1 
 arch/arm/plat-omap/include/plat/omap-serial.h      |    2 
 arch/arm/plat-omap/include/plat/param.h            |    8 --
 arch/arm/plat-omap/mux.c                           |   90 --------------------
 drivers/input/keyboard/omap-keypad.c               |    2 
 drivers/input/serio/ams_delta_serio.c              |    2 
 drivers/mtd/nand/ams-delta.c                       |    2 
 drivers/pcmcia/omap_cf.c                           |    2 
 drivers/spi/spi-omap-uwire.c                       |    2 
 drivers/usb/host/ohci-omap.c                       |    2 
 drivers/usb/musb/tusb6010_omap.c                   |    1 
 drivers/usb/otg/isp1301_omap.c                     |    2 
 drivers/video/backlight/omap1_bl.c                 |    2 
 drivers/video/omap/lcd_ams_delta.c                 |    2 
 drivers/video/omap/lcd_mipid.c                     |    2 
 drivers/video/omap/lcd_osk.c                       |    2 
 sound/soc/omap/ams-delta.c                         |    2 
 sound/soc/omap/zoom2.c                             |    2 
 117 files changed, 181 insertions(+), 255 deletions(-)
 rename arch/arm/{plat-omap/include/plat/board-ams-delta.h => mach-omap1/include/mach/board-ams-delta.h} (100%)
 rename arch/arm/{plat-omap/include/plat/board-sx1.h => mach-omap1/include/mach/board-sx1.h} (100%)
 rename arch/arm/{plat-omap/include/plat/board-voiceblue.h => mach-omap1/include/mach/board-voiceblue.h} (100%)
 rename arch/arm/{plat-omap/include/plat/flash.h => mach-omap1/include/mach/flash.h} (100%)
 rename arch/arm/{plat-omap/include/plat/irda.h => mach-omap1/include/mach/irda.h} (100%)
 rename arch/arm/{plat-omap/include/plat/keypad.h => mach-omap1/include/mach/keypad.h} (100%)
 rename arch/arm/{plat-omap/include/plat/lcd_mipid.h => mach-omap1/include/mach/lcd_mipid.h} (100%)
 rename arch/arm/{plat-omap/include/plat/mux.h => mach-omap1/include/mach/mux.h} (100%)
 delete mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 rename arch/arm/mach-omap2/{include/mach/am35xx.h => am35xx.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/board-rx51.h => board-rx51.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/board-zoom.h => board-zoom.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_core_44xx.h => ctrl_module_core_44xx.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_pad_core_44xx.h => ctrl_module_pad_core_44xx.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_pad_wkup_44xx.h => ctrl_module_pad_wkup_44xx.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_wkup_44xx.h => ctrl_module_wkup_44xx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/debug-devices.h => mach-omap2/debug-devices.h} (100%)
 rename arch/arm/{plat-omap/include/plat/gpmc-smc91x.h => mach-omap2/gpmc-smc91x.h} (100%)
 rename arch/arm/{plat-omap/include/plat/gpmc-smsc911x.h => mach-omap2/gpmc-smsc911x.h} (100%)
 rename arch/arm/{plat-omap/include/plat/hdq1w.h => mach-omap2/hdq1w.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/id.h => id.h} (100%)
 delete mode 100644 arch/arm/mach-omap2/include/mach/smp.h
 rename arch/arm/{plat-omap/include/plat/l3_2xxx.h => mach-omap2/l3_2xxx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/l3_3xxx.h => mach-omap2/l3_3xxx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/l4_2xxx.h => mach-omap2/l4_2xxx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/l4_3xxx.h => mach-omap2/l4_3xxx.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/omap-secure.h => omap-secure.h} (100%)
 rename arch/arm/mach-omap2/{include/mach/omap-wakeupgen.h => omap-wakeupgen.h} (100%)
 rename arch/arm/{plat-omap/include/plat/omap4-keypad.h => mach-omap2/omap4-keypad.h} (100%)
 delete mode 100644 arch/arm/plat-omap/include/plat/param.h
 delete mode 100644 arch/arm/plat-omap/mux.c

-- 
Signature
