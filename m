From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/16] More omap plat header cleanup for v3.8 merge window
Date: Thu, 04 Oct 2012 15:04:31 -0700
Message-ID: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:27446 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099Ab2JDWEd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some more patches for early merging after -rc1 for v3.8
merge window to remove more plat includes for the ARM common
zImage support. These are based on top of current linux next +
kevin's cpufreq fixes. 

More patches to follow, I'll start looking into plat/cpu.h next.

Regards,

Tony

---

Tony Lindgren (16):
      ARM: OMAP2+: Make board-zoom.h local
      ARM: OMAP: Split plat-omap/i2c.c into mach-omap1 and mach-omap2
      ARM: OMAP: Make plat/common.h local to mach-omap1 and mach-omap2
      ARM: OMAP: Make plat/fpga.h local to arch/arm/plat-omap
      ARM: OMAP1: Move plat/tc.h to mach/tc.h for omap1
      ARM: OMAP: Move plat/led.h to include/linux/platform_data
      ARM: OMAP: Make plat/sram.h local to plat-omap
      ARM: OMAP2: Move plat/menelaus.h to linux/mfd/menelaus.h
      ARM: OMAP: Split plat/mmc.h into local headers and platform_data
      ARM: OMAP: Make omap_device local to mach-omap2
      ARM: OMAP: Make plat/omap_hwmod.h local to mach-omap2
      ARM: OMAP: Merge plat/multi.h into plat/cpu.h
      ARM: OMAP: Split uncompress.h to mach-omap1 and mach-omap2
      ARM: OMAP: Split plat/serial.h for omap1 and omap2+
      ARM: OMAP: Move plat/omap-serial.h to linux/platform_data/serial-omap.h
      ARM: OMAP: Make plat/omap-pm.h local to mach-omap2


 arch/arm/mach-omap1/board-fsample.c                |    8 -
 arch/arm/mach-omap1/board-h2-mmc.c                 |    5 
 arch/arm/mach-omap1/board-h2.c                     |    2 
 arch/arm/mach-omap1/board-h3-mmc.c                 |    3 
 arch/arm/mach-omap1/board-h3.c                     |    2 
 arch/arm/mach-omap1/board-htcherald.c              |    2 
 arch/arm/mach-omap1/board-innovator.c              |   30 ++-
 arch/arm/mach-omap1/board-nokia770.c               |    2 
 arch/arm/mach-omap1/board-osk.c                    |    2 
 arch/arm/mach-omap1/board-palmte.c                 |    2 
 arch/arm/mach-omap1/board-palmtt.c                 |    4 
 arch/arm/mach-omap1/board-palmz71.c                |    2 
 arch/arm/mach-omap1/board-perseus2.c               |    8 -
 arch/arm/mach-omap1/board-sx1-mmc.c                |    3 
 arch/arm/mach-omap1/board-sx1.c                    |    2 
 arch/arm/mach-omap1/board-voiceblue.c              |    2 
 arch/arm/mach-omap1/clock.c                        |    3 
 arch/arm/mach-omap1/clock_data.c                   |    3 
 arch/arm/mach-omap1/common.h                       |    6 -
 arch/arm/mach-omap1/devices.c                      |    6 -
 arch/arm/mach-omap1/dma.c                          |    2 
 arch/arm/mach-omap1/flash.c                        |    2 
 arch/arm/mach-omap1/fpga.c                         |    2 
 arch/arm/mach-omap1/i2c.c                          |   59 ++++++
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 
 arch/arm/mach-omap1/include/mach/hardware.h        |    4 
 arch/arm/mach-omap1/include/mach/omap1510.h        |  113 +++++++++++
 arch/arm/mach-omap1/include/mach/serial.h          |   53 +++++
 arch/arm/mach-omap1/include/mach/tc.h              |    0 
 arch/arm/mach-omap1/include/mach/uncompress.h      |  121 ++++++++++++
 arch/arm/mach-omap1/io.c                           |    2 
 arch/arm/mach-omap1/mmc.h                          |   18 ++
 arch/arm/mach-omap1/pm.c                           |    5 
 arch/arm/mach-omap1/pm_bus.c                       |    3 
 arch/arm/mach-omap1/serial.c                       |    1 
 arch/arm/mach-omap2/Makefile                       |    3 
 arch/arm/mach-omap2/am35xx-emac.c                  |    2 
 arch/arm/mach-omap2/board-3630sdp.c                |    2 
 arch/arm/mach-omap2/board-4430sdp.c                |    2 
 arch/arm/mach-omap2/board-apollon.c                |    2 
 arch/arm/mach-omap2/board-flash.c                  |    1 
 arch/arm/mach-omap2/board-h4.c                     |    2 
 arch/arm/mach-omap2/board-ldp.c                    |    2 
 arch/arm/mach-omap2/board-n8x0.c                   |    4 
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 
 arch/arm/mach-omap2/board-omap4panda.c             |    2 
 arch/arm/mach-omap2/board-rm680.c                  |    4 
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    2 
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    2 
 arch/arm/mach-omap2/board-zoom-display.c           |    2 
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    2 
 arch/arm/mach-omap2/board-zoom.c                   |    2 
 arch/arm/mach-omap2/board-zoom.h                   |    0 
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |    3 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    3 
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    3 
 arch/arm/mach-omap2/clockdomain.h                  |    2 
 arch/arm/mach-omap2/cm33xx.c                       |    2 
 arch/arm/mach-omap2/common.h                       |    8 +
 arch/arm/mach-omap2/devices.c                      |    4 
 arch/arm/mach-omap2/display.c                      |    6 -
 arch/arm/mach-omap2/dma.c                          |    4 
 arch/arm/mach-omap2/drm.c                          |    4 
 arch/arm/mach-omap2/dsp.c                          |    2 
 arch/arm/mach-omap2/gpio.c                         |    6 -
 arch/arm/mach-omap2/gpmc.c                         |    2 
 arch/arm/mach-omap2/hdq1w.c                        |    4 
 arch/arm/mach-omap2/hdq1w.h                        |    2 
 arch/arm/mach-omap2/hsmmc.c                        |    6 -
 arch/arm/mach-omap2/hwspinlock.c                   |    4 
 arch/arm/mach-omap2/i2c.c                          |   74 +++++++
 arch/arm/mach-omap2/i2c.h                          |   25 --
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 
 arch/arm/mach-omap2/include/mach/uncompress.h      |  175 +++++++++++++++++
 arch/arm/mach-omap2/io.c                           |   10 -
 arch/arm/mach-omap2/mcbsp.c                        |    2 
 arch/arm/mach-omap2/mmc.h                          |   23 ++
 arch/arm/mach-omap2/msdi.c                         |    6 -
 arch/arm/mach-omap2/mux.c                          |    2 
 arch/arm/mach-omap2/omap-pm.h                      |    0 
 arch/arm/mach-omap2/omap4-common.c                 |    6 -
 arch/arm/mach-omap2/omap_device.c                  |    4 
 arch/arm/mach-omap2/omap_device.h                  |    2 
 arch/arm/mach-omap2/omap_hwmod.c                   |    2 
 arch/arm/mach-omap2/omap_hwmod.h                   |    0 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    9 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    9 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    3 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    4 
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    8 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   10 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    9 -
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    2 
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    2 
 arch/arm/mach-omap2/omap_opp_data.h                |    2 
 arch/arm/mach-omap2/opp.c                          |    2 
 arch/arm/mach-omap2/pm-debug.c                     |    2 
 arch/arm/mach-omap2/pm.c                           |    4 
 arch/arm/mach-omap2/pm24xx.c                       |    3 
 arch/arm/mach-omap2/pm34xx.c                       |    3 
 arch/arm/mach-omap2/pmu.c                          |    4 
 arch/arm/mach-omap2/prm33xx.c                      |    2 
 arch/arm/mach-omap2/prm_common.c                   |    2 
 arch/arm/mach-omap2/sdrc.c                         |    2 
 arch/arm/mach-omap2/sdrc2xxx.c                     |    2 
 arch/arm/mach-omap2/serial.c                       |   13 +
 arch/arm/mach-omap2/serial.h                       |   11 -
 arch/arm/mach-omap2/sleep34xx.S                    |    2 
 arch/arm/mach-omap2/sr_device.c                    |    2 
 arch/arm/mach-omap2/timer.c                        |    6 -
 arch/arm/mach-omap2/twl-common.c                   |    1 
 arch/arm/mach-omap2/usb-host.c                     |    2 
 arch/arm/mach-omap2/usb-musb.c                     |    2 
 arch/arm/mach-omap2/wd_timer.c                     |    2 
 arch/arm/mach-omap2/wd_timer.h                     |    2 
 arch/arm/plat-omap/Makefile                        |    1 
 arch/arm/plat-omap/common.c                        |    2 
 arch/arm/plat-omap/common.h                        |   10 -
 arch/arm/plat-omap/counter_32k.c                   |    2 
 arch/arm/plat-omap/debug-leds.c                    |    2 
 arch/arm/plat-omap/dma.c                           |   24 +-
 arch/arm/plat-omap/dmtimer.c                       |    3 
 arch/arm/plat-omap/fpga.h                          |   74 +++++++
 arch/arm/plat-omap/i2c.c                           |  152 ---------------
 arch/arm/plat-omap/i2c.h                           |   46 +++++
 arch/arm/plat-omap/include/plat/cpu.h              |   96 +++++++++
 arch/arm/plat-omap/include/plat/fpga.h             |  193 -------------------
 arch/arm/plat-omap/include/plat/multi.h            |  120 ------------
 arch/arm/plat-omap/include/plat/sram.h             |  105 ----------
 arch/arm/plat-omap/include/plat/uncompress.h       |  204 --------------------
 arch/arm/plat-omap/omap-pm-noop.c                  |    5 
 arch/arm/plat-omap/sram.c                          |    1 
 arch/arm/plat-omap/sram.h                          |  109 ++++++++++-
 drivers/media/platform/omap3isp/ispvideo.c         |    1 
 drivers/media/rc/ir-rx51.c                         |    1 
 drivers/mfd/menelaus.c                             |    2 
 drivers/mmc/host/omap.c                            |    3 
 drivers/mmc/host/omap_hsmmc.c                      |    2 
 drivers/pcmcia/omap_cf.c                           |    2 
 drivers/tty/serial/omap-serial.c                   |   35 +++
 drivers/usb/host/ohci-omap.c                       |    5 
 drivers/video/omap/lcd_inn1510.c                   |    7 -
 include/linux/mfd/menelaus.h                       |    2 
 include/linux/platform_data/leds-omap.h            |    2 
 include/linux/platform_data/mmc-omap.h             |   45 ----
 include/linux/platform_data/serial-omap.h          |   40 ----
 148 files changed, 1224 insertions(+), 1127 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/serial.h
 rename arch/arm/{plat-omap/include/plat/tc.h => mach-omap1/include/mach/tc.h} (100%)
 create mode 100644 arch/arm/mach-omap1/mmc.h
 rename arch/arm/mach-omap2/{include/mach/board-zoom.h => board-zoom.h} (100%)
 rename arch/arm/{plat-omap/include/plat/i2c.h => mach-omap2/i2c.h} (66%)
 create mode 100644 arch/arm/mach-omap2/mmc.h
 rename arch/arm/{plat-omap/include/plat/omap-pm.h => mach-omap2/omap-pm.h} (100%)
 rename arch/arm/{plat-omap/omap_device.c => mach-omap2/omap_device.c} (99%)
 rename arch/arm/{plat-omap/include/plat/omap_device.h => mach-omap2/omap_device.h} (99%)
 rename arch/arm/{plat-omap/include/plat/omap_hwmod.h => mach-omap2/omap_hwmod.h} (100%)
 rename arch/arm/{plat-omap/include/plat/serial.h => mach-omap2/serial.h} (91%)
 rename arch/arm/plat-omap/{include/plat/common.h => common.h} (89%)
 create mode 100644 arch/arm/plat-omap/fpga.h
 create mode 100644 arch/arm/plat-omap/i2c.h
 delete mode 100644 arch/arm/plat-omap/include/plat/fpga.h
 delete mode 100644 arch/arm/plat-omap/include/plat/multi.h
 delete mode 100644 arch/arm/plat-omap/include/plat/sram.h
 delete mode 100644 arch/arm/plat-omap/include/plat/uncompress.h
 rename arch/arm/plat-omap/include/plat/menelaus.h => include/linux/mfd/menelaus.h (96%)
 rename arch/arm/plat-omap/include/plat/led.h => include/linux/platform_data/leds-omap.h (91%)
 rename arch/arm/plat-omap/include/plat/mmc.h => include/linux/platform_data/mmc-omap.h (80%)
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (67%)

-- 
Signature
