From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 0/9] ARM: OMAP: cleanup plat/board.h file
Date: Wed, 29 Aug 2012 02:18:48 +0300
Message-ID: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:59119 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021Ab2H1XTQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:19:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

This patch series cleans up the plat/board.h and related files.

Remove confusingly empty struct omap_board_config_kernel structures
and unused omap_get_nr_config() macro along with
unused omap_get_var_config() function.
Those apparently were never used in upstream kernels.

Move OMAP3EVM revision bits to the board file as those are not used
(and never have been used) outside of the board file in upstream kernels.

Remove the tags part of the sti console workaround on OMAP2.
Also remove the crystal type tag parsing code on OMAP1.
Since the tags were never used upstream, the sti console workaround
and the crystal type tag parsing code have never fired.

OMAP custom tags code is not used - remove it.
Finally, move all leftovers from the plat/board.h to include/linux/*
and delete the plat/board.h file.

The series are based on Linus' v3.6-rc3, checkpatch clean,
and have been compile tested with omap1|2plus_defconfig(s).

Igor Grinberg (9):
  ARM: OMAP: cleanup struct omap_board_config_kernel
  ARM: OMAP: omap3evm: cleanup revision bits
  ARM: OMAP: remove the sti console workaround
  ARM: OMAP1: remove the crystal type tag parsing
  ARM: OMAP: remove the omap custom tags
  ARM: OMAP1: move omap1_bl pdata out of arch/arm/*
  ARM: OMAP1: move lcd pdata out of arch/arm/*
  ARM: OMAP: move debug_card_init() function
  ARM: OMAP: remove plat/board.h file

 arch/arm/mach-omap1/board-ams-delta.c           |    1 -
 arch/arm/mach-omap1/board-fsample.c             |    1 -
 arch/arm/mach-omap1/board-generic.c             |    6 -
 arch/arm/mach-omap1/board-htcherald.c           |    1 -
 arch/arm/mach-omap1/board-nokia770.c            |    1 -
 arch/arm/mach-omap1/board-osk.c                 |    1 +
 arch/arm/mach-omap1/board-palmte.c              |    2 +-
 arch/arm/mach-omap1/board-palmtt.c              |    2 +-
 arch/arm/mach-omap1/board-palmz71.c             |    2 +-
 arch/arm/mach-omap1/board-perseus2.c            |    1 -
 arch/arm/mach-omap1/board-sx1.c                 |    1 -
 arch/arm/mach-omap1/board-voiceblue.c           |    6 -
 arch/arm/mach-omap1/clock_data.c                |    8 --
 arch/arm/mach-omap1/devices.c                   |    1 -
 arch/arm/mach-omap1/serial.c                    |    1 -
 arch/arm/mach-omap2/board-2430sdp.c             |    1 -
 arch/arm/mach-omap2/board-3430sdp.c             |    6 -
 arch/arm/mach-omap2/board-3630sdp.c             |    6 -
 arch/arm/mach-omap2/board-4430sdp.c             |    1 -
 arch/arm/mach-omap2/board-am3517crane.c         |    9 --
 arch/arm/mach-omap2/board-am3517evm.c           |    6 -
 arch/arm/mach-omap2/board-apollon.c             |    1 -
 arch/arm/mach-omap2/board-cm-t35.c              |    6 -
 arch/arm/mach-omap2/board-cm-t3517.c            |    6 -
 arch/arm/mach-omap2/board-devkit8000.c          |    1 -
 arch/arm/mach-omap2/board-generic.c             |    1 -
 arch/arm/mach-omap2/board-h4.c                  |    2 +-
 arch/arm/mach-omap2/board-igep0020.c            |    1 -
 arch/arm/mach-omap2/board-ldp.c                 |    1 -
 arch/arm/mach-omap2/board-n8x0.c                |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c         |    1 -
 arch/arm/mach-omap2/board-omap3evm.c            |   19 ++-
 arch/arm/mach-omap2/board-omap3logic.c          |    1 -
 arch/arm/mach-omap2/board-omap3pandora.c        |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c        |    6 -
 arch/arm/mach-omap2/board-omap3touchbook.c      |    1 -
 arch/arm/mach-omap2/board-omap4panda.c          |    1 -
 arch/arm/mach-omap2/board-overo.c               |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c    |    1 -
 arch/arm/mach-omap2/board-rx51.c                |    1 -
 arch/arm/mach-omap2/board-ti8168evm.c           |    6 -
 arch/arm/mach-omap2/board-zoom.c                |    1 -
 arch/arm/mach-omap2/common.c                    |    1 -
 arch/arm/mach-omap2/devices.c                   |    1 -
 arch/arm/mach-omap2/gpmc-nand.c                 |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c              |    1 -
 arch/arm/mach-omap2/gpmc-smc91x.c               |    1 -
 arch/arm/mach-omap2/gpmc-smsc911x.c             |    1 -
 arch/arm/mach-omap2/pm-debug.c                  |    1 -
 arch/arm/mach-omap2/pm24xx.c                    |   11 --
 arch/arm/mach-omap2/serial.c                    |    1 -
 arch/arm/plat-omap/common.c                     |   40 -------
 arch/arm/plat-omap/counter_32k.c                |    1 -
 arch/arm/plat-omap/debug-devices.c              |    3 -
 arch/arm/plat-omap/devices.c                    |    1 -
 arch/arm/plat-omap/fb.c                         |    2 -
 arch/arm/plat-omap/include/plat/board.h         |  138 -----------------------
 arch/arm/plat-omap/include/plat/debug-devices.h |    9 ++
 arch/arm/plat-omap/include/plat/mmc.h           |    1 -
 arch/arm/plat-omap/include/plat/usb.h           |    1 -
 arch/arm/plat-omap/sram.c                       |    1 -
 drivers/mmc/host/omap.c                         |    1 -
 drivers/mmc/host/omap_hsmmc.c                   |    1 -
 drivers/mtd/onenand/omap2.c                     |    2 -
 drivers/video/backlight/omap1_bl.c              |    2 +-
 include/linux/omapfb.h                          |    7 +-
 include/linux/platform_data/omap1_bl.h          |   11 ++
 67 files changed, 44 insertions(+), 320 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/board.h
 create mode 100644 arch/arm/plat-omap/include/plat/debug-devices.h
 create mode 100644 include/linux/platform_data/omap1_bl.h

-- 
1.7.8.6

