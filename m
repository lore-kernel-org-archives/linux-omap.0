From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap header cleanup to make headers local for v3.7
 merge window
Date: Thu, 20 Sep 2012 16:09:36 -0700
Message-ID: <20120920230935.GM28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34004 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932389Ab2ITXJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 19:09:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here's one more branch to take us a bit closer to getting the
single zImage working on omaps. It would be nice to get merged
into arm-soc/next/cleanup before the merge window if still
possible.

I've based it on top of Arnd's 2203747c (ARM: omap: move
platform_data definitions) to avoid more merge conflicts,
and it seems to merge with few trivial include conflicts
with current linux next and arm-soc/for-next.

Regards,

Tony


The following changes since commit 2203747c97712975accc5e69bdaf1ad38a691635:

  ARM: omap: move platform_data definitions (2012-09-19 17:39:52 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-local-headers-for-v3.7

for you to fetch changes up to 0e70156de4c8465bfb8cb45cdc1bbc2fa474ce14:

  ARM: OMAP2+: Make omap4-keypad.h local (2012-09-20 15:04:04 -0700)

----------------------------------------------------------------
This branch contains mostly scripted changes to make omap
header files local where possible to get us closer to supporting
the ARM single zImage. After these changes mach includes are
pretty much out of the way for omap2+, but still lots of manual
work remains to sort through the remaining plat includes.

----------------------------------------------------------------
Tony Lindgren (26):
      ARM: OMAP: Remove unused param.h
      ARM: OMAP: Remove smp.h
      ARM: OMAP1: Make plat/mux.h omap1 only
      ARM: OMAP1: Move board-ams-delta.h from plat to mach
      ARM: OMAP2+: Make id.h local
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

 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |    4 +-
 arch/arm/mach-omap1/board-fsample.c                |    4 +-
 arch/arm/mach-omap1/board-generic.c                |    2 +-
 arch/arm/mach-omap1/board-h2.c                     |    6 +-
 arch/arm/mach-omap1/board-h3.c                     |    4 +-
 arch/arm/mach-omap1/board-innovator.c              |    4 +-
 arch/arm/mach-omap1/board-nokia770.c               |    2 +-
 arch/arm/mach-omap1/board-osk.c                    |    4 +-
 arch/arm/mach-omap1/board-palmte.c                 |    6 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    6 +-
 arch/arm/mach-omap1/board-palmz71.c                |    6 +-
 arch/arm/mach-omap1/board-perseus2.c               |    4 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                |    2 +-
 arch/arm/mach-omap1/board-sx1.c                    |    8 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    6 +-
 arch/arm/mach-omap1/devices.c                      |    2 +-
 arch/arm/mach-omap1/flash.c                        |    2 +-
 arch/arm/mach-omap1/i2c.c                          |    2 +-
 .../include/mach}/board-ams-delta.h                |    0
 .../plat => mach-omap1/include/mach}/board-sx1.h   |    0
 .../include/mach}/board-voiceblue.h                |    0
 .../plat => mach-omap1/include/mach}/flash.h       |    0
 .../plat => mach-omap1/include/mach}/irda.h        |    0
 .../include/plat => mach-omap1/include/mach}/mux.h |    0
 arch/arm/mach-omap1/include/mach/smp.h             |    5 --
 arch/arm/mach-omap1/io.c                           |    2 +-
 arch/arm/mach-omap1/leds.c                         |    2 +-
 arch/arm/mach-omap1/mcbsp.c                        |    2 +-
 arch/arm/mach-omap1/mux.c                          |   58 ++++++++++++-
 arch/arm/mach-omap1/pm.c                           |    2 +-
 arch/arm/mach-omap1/serial.c                       |    2 +-
 arch/arm/mach-omap1/usb.c                          |    2 +-
 arch/arm/mach-omap2/am35xx-emac.c                  |    2 +-
 arch/arm/mach-omap2/{include/mach => }/am35xx.h    |    0
 arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +-
 arch/arm/mach-omap2/board-h4.c                     |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |    2 +-
 arch/arm/mach-omap2/board-ldp.c                    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c             |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +-
 arch/arm/mach-omap2/board-overo.c                  |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    4 +-
 arch/arm/mach-omap2/board-rx51-video.c             |    2 +-
 .../arm/mach-omap2/{include/mach => }/board-rx51.h |    0
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    2 +-
 arch/arm/mach-omap2/common.c                       |    1 -
 arch/arm/mach-omap2/control.h                      |    8 +-
 .../{include/mach => }/ctrl_module_core_44xx.h     |    0
 .../{include/mach => }/ctrl_module_pad_core_44xx.h |    0
 .../{include/mach => }/ctrl_module_pad_wkup_44xx.h |    0
 .../{include/mach => }/ctrl_module_wkup_44xx.h     |    0
 .../include/plat => mach-omap2}/debug-devices.h    |    0
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    2 +-
 .../include/plat => mach-omap2}/gpmc-smc91x.h      |    0
 arch/arm/mach-omap2/gpmc-smsc911x.c                |    2 +-
 .../include/plat => mach-omap2}/gpmc-smsc911x.h    |    0
 arch/arm/mach-omap2/hdq1w.c                        |    2 +-
 .../{plat-omap/include/plat => mach-omap2}/hdq1w.h |    0
 arch/arm/mach-omap2/hsmmc.c                        |    1 -
 arch/arm/mach-omap2/id.c                           |    2 +-
 arch/arm/mach-omap2/{include/mach => }/id.h        |    0
 arch/arm/mach-omap2/include/mach/smp.h             |    5 --
 .../include/plat => mach-omap2}/l3_2xxx.h          |    0
 .../include/plat => mach-omap2}/l3_3xxx.h          |    0
 .../include/plat => mach-omap2}/l4_2xxx.h          |    0
 .../include/plat => mach-omap2}/l4_3xxx.h          |    0
 arch/arm/mach-omap2/omap-hotplug.c                 |    2 +-
 arch/arm/mach-omap2/omap-secure.c                  |    2 +-
 .../mach-omap2/{include/mach => }/omap-secure.h    |    0
 arch/arm/mach-omap2/omap-smp.c                     |    4 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    4 +-
 .../mach-omap2/{include/mach => }/omap-wakeupgen.h |    0
 arch/arm/mach-omap2/omap4-common.c                 |    2 +-
 .../include/plat => mach-omap2}/omap4-keypad.h     |    0
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    4 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    4 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 +-
 arch/arm/mach-omap2/sleep44xx.S                    |    2 +-
 arch/arm/mach-omap2/usb-musb.c                     |    2 +-
 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/i2c.c                           |    1 -
 arch/arm/plat-omap/include/plat/omap-serial.h      |    2 -
 arch/arm/plat-omap/include/plat/param.h            |    8 --
 arch/arm/plat-omap/mux.c                           |   90 --------------------
 drivers/input/serio/ams_delta_serio.c              |    2 +-
 drivers/mmc/host/omap.c                            |    1 -
 drivers/mtd/nand/ams-delta.c                       |    2 +-
 drivers/pcmcia/omap_cf.c                           |    2 +-
 drivers/spi/spi-omap-uwire.c                       |    2 +-
 drivers/usb/host/ohci-omap.c                       |    2 +-
 drivers/usb/musb/tusb6010_omap.c                   |    1 -
 drivers/usb/otg/isp1301_omap.c                     |    2 +-
 drivers/video/backlight/omap1_bl.c                 |    2 +-
 drivers/video/omap/lcd_ams_delta.c                 |    3 +-
 drivers/video/omap/lcd_osk.c                       |    2 +-
 sound/soc/omap/ams-delta.c                         |    2 +-
 109 files changed, 159 insertions(+), 221 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/board-ams-delta.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/board-sx1.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/board-voiceblue.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/flash.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/irda.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/mux.h (100%)
 delete mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 rename arch/arm/mach-omap2/{include/mach => }/am35xx.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/board-rx51.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/ctrl_module_core_44xx.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/ctrl_module_pad_core_44xx.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/ctrl_module_pad_wkup_44xx.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/ctrl_module_wkup_44xx.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/debug-devices.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc-smc91x.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc-smsc911x.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/hdq1w.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/id.h (100%)
 delete mode 100644 arch/arm/mach-omap2/include/mach/smp.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/l3_2xxx.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/l3_3xxx.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/l4_2xxx.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/l4_3xxx.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/omap-secure.h (100%)
 rename arch/arm/mach-omap2/{include/mach => }/omap-wakeupgen.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap4-keypad.h (100%)
 delete mode 100644 arch/arm/plat-omap/include/plat/param.h
 delete mode 100644 arch/arm/plat-omap/mux.c
