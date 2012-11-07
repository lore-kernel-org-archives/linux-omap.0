From: Tony Lindgren <ton@atomide.com>
Subject: [GIT PULL 1/1] omap plat header removal for v3.8 merge window, part4
Date: Wed, 7 Nov 2012 10:27:35 -0800
Message-ID: <29888.8668804013$1352312874@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753714Ab2KGS1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 13:27:40 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit a0212796b58061a9716178d261f318925c246643:

  Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3-signed

for you to fetch changes up to 6ba54ab4a49bbad736b0254aa6bdf0cb83013815:

  ARM: OMAP: Remove omap_init_consistent_dma_size() (2012-11-06 16:01:19 -0800)

----------------------------------------------------------------
These changes deal with the issues of relative includes
introduced by the earlier clean-up and clean up few more
things for enabling multiplatform support.

The multiplatform kernel has been booted on omaps on
top of this branch with the work-in-progress patches
applied manually.

We cannot yet enable the multiplatform support though.
We still need the common clock framework patches, some
solution for dma-omap.h, and serial-omap.h moved before
we can enable it.

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP1: usb: fix sparse warnings

Tomi Valkeinen (1):
      ARM: OMAP: Remove omap_init_consistent_dma_size()

Tony Lindgren (15):
      ARM: OMAP: Split sram.h to local headers and minimal shared header
      ARM: OMAP: Introduce common omap_map_sram() and omap_sram_reset()
      ARM: OMAP: Move omap1 specific code to local sram.c
      ARM: OMAP: Move omap2+ specific parts of sram.c to mach-omap2
      ARM: OMAP: Make plat-omap/i2c.c port checks local
      ARM: OMAP: Fix relative includes for shared i2c.h file
      ARM: OMAP: Move omap-pm-noop.c local to mach-omap2
      ARM: OMAP: Remove plat-omap/common.h
      ARM: OMAP: Fix relative includes for debug-devices.h
      ARM: OMAP: Remove cpu_is_omap usage from plat-omap/dma.c
      ARM: OMAP1: Remove relative includes
      ARM: OMAP: Fix relative includes for fpga.h
      ARM: OMAP2+: Fix relative includes for serial.h
      ARM: OMAP: Remove unnecessary mach and plat includes
      ARM: OMAP: Remove NEED_MACH_GPIO_H

 arch/arm/Kconfig                                   |   1 -
 arch/arm/mach-omap1/Makefile                       |   3 +-
 arch/arm/mach-omap1/board-fsample.c                |   2 +-
 arch/arm/mach-omap1/board-innovator.c              |   1 -
 arch/arm/mach-omap1/board-perseus2.c               |   2 +-
 arch/arm/mach-omap1/clock.c                        |   3 +-
 arch/arm/mach-omap1/clock_data.c                   |   3 +-
 arch/arm/mach-omap1/common.h                       |   3 +-
 arch/arm/mach-omap1/devices.c                      |   3 +-
 arch/arm/mach-omap1/dma.c                          |   3 +
 arch/arm/mach-omap1/fpga.c                         |   3 +-
 arch/arm/{plat-omap => mach-omap1}/fpga.h          |  22 --
 arch/arm/mach-omap1/gpio15xx.c                     |   2 +
 arch/arm/mach-omap1/gpio16xx.c                     |   2 +
 arch/arm/mach-omap1/gpio7xx.c                      |   2 +
 arch/arm/mach-omap1/i2c.c                          |   5 +-
 arch/arm/mach-omap1/include/mach/entry-macro.S     |   2 -
 arch/arm/mach-omap1/include/mach/gpio.h            |   3 -
 arch/arm/mach-omap1/include/mach/hardware.h        |   5 +-
 arch/arm/mach-omap1/include/mach/memory.h          |   2 +-
 arch/arm/mach-omap1/include/mach/soc.h             | 229 +++++++++++++
 arch/arm/mach-omap1/io.c                           |   1 -
 arch/arm/mach-omap1/iomap.h                        |   3 -
 arch/arm/mach-omap1/pm.c                           |   4 +-
 arch/arm/mach-omap1/sleep.S                        |   2 +
 arch/arm/mach-omap1/soc.h                          | 229 +------------
 arch/arm/mach-omap1/sram-init.c                    |  76 +++++
 arch/arm/mach-omap1/sram.h                         |   7 +
 arch/arm/mach-omap1/timer32k.c                     |   1 +
 arch/arm/mach-omap1/usb.c                          |   6 +-
 arch/arm/mach-omap2/Makefile                       |   3 +-
 arch/arm/mach-omap2/board-2430sdp.c                |   1 -
 arch/arm/mach-omap2/board-cm-t35.c                 |   2 -
 arch/arm/mach-omap2/board-h4.c                     |   2 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |   3 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |   3 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |   3 +-
 arch/arm/mach-omap2/cm33xx.c                       |   2 -
 arch/arm/mach-omap2/common.h                       |   5 +-
 arch/arm/mach-omap2/dma.c                          |   3 +
 arch/arm/mach-omap2/hsmmc.c                        |   1 -
 arch/arm/mach-omap2/i2c.c                          |  16 +
 arch/arm/mach-omap2/i2c.h                          |   2 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |   2 +-
 arch/arm/mach-omap2/include/mach/gpio.h            |   3 -
 arch/arm/mach-omap2/include/mach/serial.h          | 103 ++++++
 arch/arm/mach-omap2/include/mach/uncompress.h      |   2 +-
 arch/arm/mach-omap2/io.c                           |  15 +-
 arch/arm/{plat-omap => mach-omap2}/omap-pm-noop.c  |   4 +-
 arch/arm/mach-omap2/omap4-common.c                 |   3 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   2 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 -
 arch/arm/mach-omap2/pm24xx.c                       |   5 +-
 arch/arm/mach-omap2/pm34xx.c                       |   4 +-
 arch/arm/mach-omap2/prm33xx.c                      |   2 -
 arch/arm/mach-omap2/prm_common.c                   |   1 -
 arch/arm/mach-omap2/sdrc.c                         |   2 -
 arch/arm/mach-omap2/sdrc2xxx.c                     |   3 +-
 arch/arm/mach-omap2/serial.h                       | 113 +------
 arch/arm/mach-omap2/sleep34xx.S                    |   3 +-
 arch/arm/mach-omap2/sram.c                         | 305 +++++++++++++++++
 arch/arm/{plat-omap => mach-omap2}/sram.h          |  26 +-
 arch/arm/mach-omap2/timer.c                        |   3 +
 arch/arm/plat-omap/Makefile                        |   3 +-
 arch/arm/plat-omap/common.c                        |  27 --
 arch/arm/plat-omap/common.h                        |  36 --
 arch/arm/plat-omap/counter_32k.c                   |   2 -
 arch/arm/plat-omap/debug-devices.c                 |   3 +-
 arch/arm/plat-omap/debug-leds.c                    |  23 +-
 arch/arm/plat-omap/dma.c                           | 108 +++---
 arch/arm/plat-omap/dmtimer.c                       |  21 +-
 arch/arm/plat-omap/fb.c                            |   1 -
 arch/arm/plat-omap/i2c.c                           |  30 +-
 arch/arm/plat-omap/include/plat-omap/dma-omap.h    |  20 +-
 arch/arm/plat-omap/include/plat/counter-32k.h      |   1 +
 arch/arm/plat-omap/include/plat/cpu.h              |   2 +-
 .../include/plat}/debug-devices.h                  |   7 -
 arch/arm/plat-omap/include/plat/dmtimer.h          |   2 +
 arch/arm/plat-omap/{ => include/plat}/i2c.h        |   0
 arch/arm/plat-omap/include/plat/sram.h             |  16 +
 arch/arm/plat-omap/sram.c                          | 366 ++-------------------
 drivers/dma/omap-dma.c                             |   6 -
 drivers/media/platform/omap3isp/ispvideo.c         |   1 -
 include/linux/platform_data/gpio-omap.h            |   1 -
 sound/soc/omap/am3517evm.c                         |   2 -
 sound/soc/omap/n810.c                              |   1 -
 sound/soc/omap/osk5912.c                           |   1 -
 sound/soc/omap/sdp3430.c                           |   2 -
 sound/soc/omap/zoom2.c                             |   3 -
 89 files changed, 956 insertions(+), 1008 deletions(-)
 rename arch/arm/{plat-omap => mach-omap1}/fpga.h (83%)
 delete mode 100644 arch/arm/mach-omap1/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap1/include/mach/soc.h
 create mode 100644 arch/arm/mach-omap1/sram-init.c
 create mode 100644 arch/arm/mach-omap1/sram.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/gpio.h
 create mode 100644 arch/arm/mach-omap2/include/mach/serial.h
 rename arch/arm/{plat-omap => mach-omap2}/omap-pm-noop.c (99%)
 create mode 100644 arch/arm/mach-omap2/sram.c
 rename arch/arm/{plat-omap => mach-omap2}/sram.h (79%)
 delete mode 100644 arch/arm/plat-omap/common.c
 delete mode 100644 arch/arm/plat-omap/common.h
 create mode 100644 arch/arm/plat-omap/include/plat/counter-32k.h
 rename arch/arm/{mach-omap2 => plat-omap/include/plat}/debug-devices.h (54%)
 rename arch/arm/plat-omap/{ => include/plat}/i2c.h (100%)
 create mode 100644 arch/arm/plat-omap/include/plat/sram.h
