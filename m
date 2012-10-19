From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap plat header removal for v3.8 merge window, part1
Date: Thu, 18 Oct 2012 19:33:00 -0700
Message-ID: <20121019023300.GN30550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44891 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096Ab2JSCdI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 22:33:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here's the first set of omap plat header removal for v3.8 merge
window. I have at least one more related set coming, but I wanted
to get these into linux next before driver patches add more
things for me to chase down and fix.

Oh, forgot to mention in the tag that the increase in diffstat
is mostly because plat-omap/clock shared clock code is duplicated
as that's also needed for the common clock framework patches
coming up.

Regards,

Tony


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-signed

for you to fetch changes up to e4c060db2c13f10de09101afc564763f9fd0019a:

  ARM: OMAP: Split plat/cpu.h into local soc.h for mach-omap1 and mach-omap2 (2012-10-18 16:23:46 -0700)

----------------------------------------------------------------
This is the first set of omap cleanup patches for v3.8 merge
window to remove most of the remaining plat includes to get us
closer to ARM common zImage support.

To avoid a huge amount of trivial merge conflicts with includes,
this branch is based on several small topic branches coordinated
with the driver subsystem maintainers. These branches are based on
v3.7-rc1 and can also be merged into the related driver subsystem
branches as needed:

omap-for-v3.8/cleanup-headers-prepare   few trivial driver changes
omap-for-v3.8/cleanup-headers-dma       move of the DMA header
omap-for-v3.8/cleanup-headers-gpmc      GPMC and MTD changes
omap-for-v3.8/cleanup-headers-mmc       MMC related changes
omap-for-v3.8/cleanup-headers-dss       DSS related changes
omap-for-v3.8/cleanup-headers-asoc      ASoC related changes

Note that for the dma-omap.h, it was decided that it should be
is completed. For the related discussion, please see:

https://patchwork.kernel.org/patch/1519591/#

After these patches we still have a few plat headers remaining
that will be handled in later pull requests.

----------------------------------------------------------------
Afzal Mohammed (16):
      ARM: OMAP2+: nand: unify init functions
      ARM: OMAP2+: onenand: refactor for clarity
      ARM: OMAP2+: gpmc: remove cs# in sync clk div calc
      mtd: onenand: omap: cleanup gpmc dependency
      mtd: nand: omap: free region as per resource size
      mtd: nand: omap: read nand using register address
      ARM: OMAP2+: onenand: connected soc info in pdata
      mtd: onenand: omap: use pdata info instead of cpu_is
      ARM: OMAP2+: onenand: header cleanup
      ARM: OMAP2+: nand: header cleanup
      mtd: nand: omap: bring in gpmc nand macros
      ARM: OMAP2+: nand: bch capability check
      ARM: OMAP2+: gpmc: nand register helper bch update
      mtd: nand: omap: handle gpmc bch[48]
      ARM: OMAP2+: gpmc: remove exported nand functions
      ARM: OMAP2+: gpmc: localize gpmc header

Jon Hunter (1):
      ARM: OMAP2+: GPMC: Remove unused OneNAND get_freq() platform function

Lokesh Vutla (7):
      ARM: OMAP: DMA: Removing plat/dma-44xx.h
      ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions to mach-omap1
      ARM: OMAP2+: DMA: Moving OMAP2+ DMA channel definitions to mach-omap2
      ARM: OMAP: DMA: Move plat/dma.h to plat-omap/dma-omap.h
      ARM: OMAP1: Remove omap_reserve() callback for all omap1 boards
      ARM: OMAP2+: Move omap_reserve() locally to mach-omap2
      ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2

Paul Walmsley (5):
      staging: tidspbridge: remove unnecessary include of <plat/clock.h>
      ARM: OMAP: move plat-omap/include/plat/sdrc.h into mach-omap2/sdrc.h
      ARM: OMAP: duplicate plat-omap/clock.c into mach-omap[12]/clock.c
      ARM: OMAP: remove plat/clock.h
      ARM: OMAP: clock: split plat/clkdev_omap.h into OMAP1/2 files

Peter Ujfalusi (2):
      ASoC: omap-abe-twl6040: Fix typo of Vibrator
      ASoC: omap-mcpdm: Remove OMAP revision check

Tomi Valkeinen (11):
      OMAPDSS: add omapdss_version
      OMAPDSS: use omapdss_version in dss_features.c
      OMAPDSS: DISPC: use omapdss_version
      OMAPDSS: DSS: use omapdss_version
      OMAPDSS: HDMI: use omapdss_version
      OMAPDSS: remove <plat/cpu.h> includes
      OMAP: VRFB: convert vrfb to platform device
      OMAP: move arch/arm/plat-omap/include/plat/vrfb.h
      OMAP: SDRC: remove VRFB code
      OMAPDSS: VRFB: add omap_vrfb_supported()
      OMAPFB: use omap_vrfb_supported()

Tony Lindgren (23):
      ASoC: Fix wrong include for McPDM
      ARM: OMAP: Split plat/mmc.h into local headers and platform_data
      mmc: omap: Remove cpu_is_omap usage from the driver
      ARM: OMAP: Trivial driver changes to remove include plat/cpu.h
      Merge tag 'gpmc-czimage' of git://gitorious.org/x0148406-public/linux-kernel into omap-for-v3.8/cleanup-headers-gpmc
      Merge remote-tracking branch 'tomi/3.8/vrfb-conversion' into omap-for-v3.8/cleanup-headers-dss
      Merge branch 'omap-for-v3.8/cleanup-headers-dma' into omap-for-v3.8/cleanup-headers
      Merge branch 'omap-for-v3.8/cleanup-headers-gpmc' into omap-for-v3.8/cleanup-headers
      Merge branch 'omap-for-v3.8/cleanup-headers-mmc' into omap-for-v3.8/cleanup-headers
      Merge branch 'omap-for-v3.8/cleanup-headers-dss' into omap-for-v3.8/cleanup-headers
      ARM: OMAP: Make plat/fpga.h local to arch/arm/plat-omap
      ARM: OMAP1: Move plat/tc.h to mach/tc.h for omap1
      ARM: OMAP2+: Make board-zoom.h local
      ARM: OMAP: Split plat-omap/i2c.c into mach-omap1 and mach-omap2
      ARM: OMAP: Make plat/common.h local to mach-omap1 and mach-omap2
      ARM: OMAP: Move plat/led.h to include/linux/platform_data
      ARM: OMAP: Make plat/sram.h local to plat-omap
      ARM: OMAP: Make omap_device local to mach-omap2
      Merge branch 'omap-for-v3.8/cleanup-headers-asoc' into omap-for-v3.8/cleanup-headers
      ARM: OMAP: Make plat/omap_hwmod.h local to mach-omap2
      ARM: OMAP: Merge plat/multi.h into plat/cpu.h
      ARM: OMAP: Make plat/omap-pm.h local to mach-omap2
      ARM: OMAP: Split plat/cpu.h into local soc.h for mach-omap1 and mach-omap2

 arch/arm/mach-omap1/board-ams-delta.c              |    1 -
 arch/arm/mach-omap1/board-fsample.c                |    9 +-
 arch/arm/mach-omap1/board-generic.c                |    1 -
 arch/arm/mach-omap1/board-h2-mmc.c                 |    5 +-
 arch/arm/mach-omap1/board-h2.c                     |    6 +-
 arch/arm/mach-omap1/board-h3-mmc.c                 |    3 +-
 arch/arm/mach-omap1/board-h3.c                     |    5 +-
 arch/arm/mach-omap1/board-htcherald.c              |    3 +-
 arch/arm/mach-omap1/board-innovator.c              |   31 +-
 arch/arm/mach-omap1/board-nokia770.c               |    5 +-
 arch/arm/mach-omap1/board-osk.c                    |    3 +-
 arch/arm/mach-omap1/board-palmte.c                 |    6 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    8 +-
 arch/arm/mach-omap1/board-palmz71.c                |    6 +-
 arch/arm/mach-omap1/board-perseus2.c               |    9 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                |    3 +-
 arch/arm/mach-omap1/board-sx1.c                    |    6 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    3 +-
 arch/arm/mach-omap1/clock.c                        |  506 +++++++++++++++++-
 arch/arm/mach-omap1/clock.h                        |  178 ++++++-
 arch/arm/mach-omap1/clock_data.c                   |   17 +-
 arch/arm/mach-omap1/common.h                       |    6 +-
 arch/arm/mach-omap1/devices.c                      |   15 +-
 arch/arm/mach-omap1/dma.c                          |    6 +-
 arch/arm/mach-omap1/dma.h                          |   83 +++
 arch/arm/mach-omap1/flash.c                        |    2 +-
 arch/arm/mach-omap1/fpga.c                         |    2 +-
 arch/arm/mach-omap1/i2c.c                          |   61 ++-
 arch/arm/mach-omap1/id.c                           |    2 +-
 arch/arm/mach-omap1/include/mach/hardware.h        |    4 +-
 arch/arm/mach-omap1/include/mach/memory.h          |    2 +-
 arch/arm/mach-omap1/include/mach/omap1510.h        |  113 ++++
 .../include/plat => mach-omap1/include/mach}/tc.h  |    0
 arch/arm/mach-omap1/io.c                           |    4 +-
 arch/arm/mach-omap1/irq.c                          |    2 +-
 arch/arm/mach-omap1/lcd_dma.c                      |    4 +-
 arch/arm/mach-omap1/mcbsp.c                        |    5 +-
 arch/arm/mach-omap1/mmc.h                          |   18 +
 arch/arm/mach-omap1/opp_data.c                     |    2 +-
 arch/arm/mach-omap1/pm.c                           |   10 +-
 arch/arm/mach-omap1/pm_bus.c                       |    3 -
 arch/arm/mach-omap1/serial.c                       |    1 -
 arch/arm/mach-omap1/soc.h                          |  229 ++++++++
 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/am35xx-emac.c                  |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    5 +-
 arch/arm/mach-omap2/board-3630sdp.c                |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-apollon.c                |    4 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    5 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    5 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   10 +-
 arch/arm/mach-omap2/board-flash.c                  |   52 +-
 arch/arm/mach-omap2/board-flash.h                  |    8 +-
 arch/arm/mach-omap2/board-h4.c                     |    4 +-
 arch/arm/mach-omap2/board-igep0020.c               |    5 +-
 arch/arm/mach-omap2/board-ldp.c                    |    8 +-
 arch/arm/mach-omap2/board-n8x0.c                   |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   13 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    9 +-
 arch/arm/mach-omap2/board-omap3logic.c             |    5 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    3 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |   10 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    2 +-
 arch/arm/mach-omap2/board-overo.c                  |    9 +-
 arch/arm/mach-omap2/board-rm680.c                  |    6 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    7 +-
 arch/arm/mach-omap2/board-rx51.c                   |    6 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    4 +-
 arch/arm/mach-omap2/board-zoom-display.c           |    3 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    2 +-
 arch/arm/mach-omap2/board-zoom.c                   |    7 +-
 .../arm/mach-omap2/{include/mach => }/board-zoom.h |    0
 arch/arm/mach-omap2/clkt2xxx_apll.c                |    1 -
 arch/arm/mach-omap2/clkt2xxx_dpll.c                |    2 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |    5 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c                 |    2 -
 arch/arm/mach-omap2/clkt2xxx_sys.c                 |    2 -
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    5 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    4 +-
 arch/arm/mach-omap2/clkt_clksel.c                  |    2 -
 arch/arm/mach-omap2/clkt_dpll.c                    |    2 -
 arch/arm/mach-omap2/clkt_iclk.c                    |    1 -
 arch/arm/mach-omap2/clock.c                        |  518 ++++++++++++++++++-
 arch/arm/mach-omap2/clock.h                        |  317 +++++++++++-
 arch/arm/mach-omap2/clock2420_data.c               |    4 -
 arch/arm/mach-omap2/clock2430.c                    |    2 -
 arch/arm/mach-omap2/clock2430_data.c               |    4 -
 arch/arm/mach-omap2/clock2xxx.c                    |    2 -
 arch/arm/mach-omap2/clock33xx_data.c               |    5 +-
 arch/arm/mach-omap2/clock34xx.c                    |    2 -
 arch/arm/mach-omap2/clock3517.c                    |    2 -
 arch/arm/mach-omap2/clock36xx.c                    |    2 -
 arch/arm/mach-omap2/clock3xxx.c                    |    2 -
 arch/arm/mach-omap2/clock3xxx_data.c               |    4 -
 arch/arm/mach-omap2/clock44xx_data.c               |    4 -
 arch/arm/mach-omap2/clockdomain.c                  |    3 +-
 arch/arm/mach-omap2/clockdomain.h                  |    5 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |    2 +
 arch/arm/mach-omap2/clockdomains2420_data.c        |    1 +
 arch/arm/mach-omap2/clockdomains2430_data.c        |    1 +
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    1 +
 arch/arm/mach-omap2/cm33xx.c                       |    2 +-
 arch/arm/mach-omap2/common-board-devices.c         |   46 --
 arch/arm/mach-omap2/common-board-devices.h         |    1 -
 arch/arm/mach-omap2/common.c                       |   22 +-
 arch/arm/mach-omap2/common.h                       |    9 +-
 arch/arm/mach-omap2/control.c                      |    4 +-
 arch/arm/mach-omap2/devices.c                      |    8 +-
 arch/arm/mach-omap2/display.c                      |   45 +-
 arch/arm/mach-omap2/dma.c                          |    8 +-
 arch/arm/mach-omap2/dma.h                          |  131 +++++
 arch/arm/mach-omap2/dpll3xxx.c                     |    2 -
 arch/arm/mach-omap2/dpll44xx.c                     |    2 -
 arch/arm/mach-omap2/drm.c                          |    4 +-
 arch/arm/mach-omap2/dsp.c                          |    2 +-
 arch/arm/mach-omap2/gpio.c                         |    6 +-
 arch/arm/mach-omap2/gpmc-nand.c                    |   85 +--
 arch/arm/mach-omap2/gpmc-nand.h                    |   27 +
 arch/arm/mach-omap2/gpmc-onenand.c                 |  214 ++++----
 arch/arm/mach-omap2/gpmc-onenand.h                 |   24 +
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c                |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |  464 +----------------
 .../{plat-omap/include/plat => mach-omap2}/gpmc.h  |   61 +--
 arch/arm/mach-omap2/hdq1w.c                        |    4 +-
 arch/arm/mach-omap2/hdq1w.h                        |    2 +-
 arch/arm/mach-omap2/hsmmc.c                        |    7 +-
 arch/arm/mach-omap2/hwspinlock.c                   |    4 +-
 arch/arm/mach-omap2/i2c.c                          |   53 +-
 .../{plat-omap/include/plat => mach-omap2}/i2c.h   |   25 +-
 arch/arm/mach-omap2/io.c                           |   12 +-
 arch/arm/mach-omap2/mcbsp.c                        |    7 +-
 arch/arm/mach-omap2/mmc.h                          |   23 +
 arch/arm/mach-omap2/msdi.c                         |    7 +-
 arch/arm/mach-omap2/mux.c                          |    3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    1 +
 .../include/plat => mach-omap2}/omap-pm.h          |    0
 arch/arm/mach-omap2/omap-secure.c                  |    1 -
 arch/arm/mach-omap2/omap-secure.h                  |    7 +
 arch/arm/mach-omap2/omap4-common.c                 |    7 +-
 arch/arm/{plat-omap => mach-omap2}/omap_device.c   |    5 +-
 .../include/plat => mach-omap2}/omap_device.h      |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |    4 +-
 .../include/plat => mach-omap2}/omap_hwmod.h       |    1 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   12 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   12 +-
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    3 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   10 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    5 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   13 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   13 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.c       |    2 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    2 +-
 arch/arm/mach-omap2/omap_opp_data.h                |    2 +-
 arch/arm/mach-omap2/omap_twl.c                     |    1 +
 arch/arm/mach-omap2/opp.c                          |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c                 |    1 +
 arch/arm/mach-omap2/pm-debug.c                     |    5 +-
 arch/arm/mach-omap2/pm.c                           |    5 +-
 arch/arm/mach-omap2/pm24xx.c                       |    8 +-
 arch/arm/mach-omap2/pm34xx.c                       |    9 +-
 arch/arm/mach-omap2/pm44xx.c                       |    1 +
 arch/arm/mach-omap2/pmu.c                          |    5 +-
 arch/arm/mach-omap2/powerdomain.h                  |    2 -
 arch/arm/mach-omap2/powerdomains2xxx_data.c        |    1 +
 arch/arm/mach-omap2/prcm.c                         |    1 +
 arch/arm/mach-omap2/prm33xx.c                      |    2 +-
 arch/arm/mach-omap2/prm_common.c                   |    2 +-
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |    2 +-
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |    2 +-
 arch/arm/mach-omap2/sdram-nokia.c                  |    4 +-
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |    2 +-
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |    2 +-
 arch/arm/mach-omap2/sdrc.c                         |   23 +-
 arch/arm/mach-omap2/sdrc.h                         |  146 +++++-
 arch/arm/mach-omap2/sdrc2xxx.c                     |    4 +-
 arch/arm/mach-omap2/serial.c                       |   11 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
 arch/arm/mach-omap2/soc.h                          |  468 ++++++++++++++++-
 arch/arm/mach-omap2/sr_device.c                    |    4 +-
 arch/arm/mach-omap2/timer.c                        |    6 +-
 arch/arm/mach-omap2/twl-common.c                   |    1 -
 arch/arm/mach-omap2/usb-host.c                     |    3 +-
 arch/arm/mach-omap2/usb-musb.c                     |    5 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |    2 +-
 arch/arm/mach-omap2/wd_timer.c                     |    2 +-
 arch/arm/mach-omap2/wd_timer.h                     |    2 +-
 arch/arm/plat-omap/Makefile                        |    3 +-
 arch/arm/plat-omap/clock.c                         |  544 --------------------
 arch/arm/plat-omap/common.c                        |   25 +-
 arch/arm/plat-omap/{include/plat => }/common.h     |   10 +-
 arch/arm/plat-omap/counter_32k.c                   |    3 +-
 arch/arm/plat-omap/debug-leds.c                    |    2 +-
 arch/arm/plat-omap/dma.c                           |   30 +-
 arch/arm/plat-omap/dmtimer.c                       |    3 +-
 arch/arm/plat-omap/fb.c                            |   61 +++
 arch/arm/plat-omap/fpga.h                          |   74 +++
 arch/arm/plat-omap/i2c.c                           |  133 +----
 arch/arm/plat-omap/i2c.h                           |   47 ++
 .../include/{plat/dma.h => plat-omap/dma-omap.h}   |  181 +------
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |   51 --
 arch/arm/plat-omap/include/plat/clock.h            |  309 -----------
 arch/arm/plat-omap/include/plat/cpu.h              |  468 +----------------
 arch/arm/plat-omap/include/plat/dma-44xx.h         |  147 ------
 arch/arm/plat-omap/include/plat/fpga.h             |  193 -------
 arch/arm/plat-omap/include/plat/multi.h            |  120 -----
 arch/arm/plat-omap/include/plat/omap-secure.h      |   14 -
 arch/arm/plat-omap/include/plat/sdrc.h             |  164 ------
 arch/arm/plat-omap/include/plat/sram.h             |  105 ----
 arch/arm/plat-omap/omap-pm-noop.c                  |    5 +-
 arch/arm/plat-omap/sram.c                          |    4 +-
 arch/arm/plat-omap/sram.h                          |  109 +++-
 drivers/char/hw_random/omap-rng.c                  |    2 -
 drivers/crypto/omap-aes.c                          |    8 +-
 drivers/crypto/omap-sham.c                         |   10 +-
 drivers/dma/omap-dma.c                             |   11 +-
 drivers/media/platform/omap/omap_vout.c            |    4 +-
 drivers/media/platform/omap/omap_vout_vrfb.c       |    6 +-
 drivers/media/platform/omap/omap_voutdef.h         |    2 +-
 drivers/media/platform/omap3isp/isphist.c          |    2 +
 drivers/media/platform/omap3isp/ispstat.h          |    2 +-
 drivers/media/platform/soc_camera/omap1_camera.c   |    3 +-
 drivers/media/rc/ir-rx51.c                         |    1 -
 drivers/mmc/host/omap.c                            |   35 +-
 drivers/mmc/host/omap_hsmmc.c                      |    4 +-
 drivers/mtd/nand/omap2.c                           |  129 ++++-
 drivers/mtd/onenand/omap2.c                        |   11 +-
 drivers/pcmcia/omap_cf.c                           |    2 +-
 .../tidspbridge/include/dspbridge/host_os.h        |    1 -
 drivers/usb/gadget/omap_udc.c                      |    4 +-
 drivers/usb/host/ohci-omap.c                       |    5 +-
 drivers/usb/musb/tusb6010_omap.c                   |    9 +-
 drivers/video/omap/lcd_inn1510.c                   |    7 +-
 drivers/video/omap/lcdc.c                          |    2 +-
 drivers/video/omap/omapfb_main.c                   |    2 +-
 drivers/video/omap/sossi.c                         |    2 +-
 drivers/video/omap2/dss/core.c                     |    2 +-
 drivers/video/omap2/dss/dispc.c                    |   43 +-
 drivers/video/omap2/dss/dss.c                      |   39 +-
 drivers/video/omap2/dss/dss_features.c             |   64 ++-
 drivers/video/omap2/dss/dss_features.h             |    5 +-
 drivers/video/omap2/dss/hdmi.c                     |    3 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c          |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |    8 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |    2 +-
 drivers/video/omap2/vrfb.c                         |  142 ++++-
 .../linux/platform_data/leds-omap.h                |    2 -
 .../linux/platform_data/mmc-omap.h                 |   48 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   46 +-
 include/linux/platform_data/mtd-onenand-omap2.h    |   28 +-
 include/video/omapdss.h                            |   14 +
 .../plat/vrfb.h => include/video/omapvrfb.h        |    2 +
 sound/soc/omap/omap-abe-twl6040.c                  |    2 +-
 sound/soc/omap/omap-mcpdm.c                        |    9 +-
 sound/soc/omap/omap-pcm.c                          |    9 +-
 260 files changed, 4351 insertions(+), 3860 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dma.h
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/tc.h (100%)
 create mode 100644 arch/arm/mach-omap1/mmc.h
 create mode 100644 arch/arm/mach-omap1/soc.h
 rename arch/arm/mach-omap2/{include/mach => }/board-zoom.h (100%)
 create mode 100644 arch/arm/mach-omap2/dma.h
 create mode 100644 arch/arm/mach-omap2/gpmc-nand.h
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/gpmc.h (67%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/i2c.h (66%)
 create mode 100644 arch/arm/mach-omap2/mmc.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap-pm.h (100%)
 rename arch/arm/{plat-omap => mach-omap2}/omap_device.c (99%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap_device.h (99%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap_hwmod.h (99%)
 delete mode 100644 arch/arm/plat-omap/clock.c
 rename arch/arm/plat-omap/{include/plat => }/common.h (89%)
 create mode 100644 arch/arm/plat-omap/fpga.h
 create mode 100644 arch/arm/plat-omap/i2c.h
 rename arch/arm/plat-omap/include/{plat/dma.h => plat-omap/dma-omap.h} (61%)
 delete mode 100644 arch/arm/plat-omap/include/plat/clkdev_omap.h
 delete mode 100644 arch/arm/plat-omap/include/plat/clock.h
 delete mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/fpga.h
 delete mode 100644 arch/arm/plat-omap/include/plat/multi.h
 delete mode 100644 arch/arm/plat-omap/include/plat/omap-secure.h
 delete mode 100644 arch/arm/plat-omap/include/plat/sdrc.h
 delete mode 100644 arch/arm/plat-omap/include/plat/sram.h
 rename arch/arm/plat-omap/include/plat/led.h => include/linux/platform_data/leds-omap.h (91%)
 rename arch/arm/plat-omap/include/plat/mmc.h => include/linux/platform_data/mmc-omap.h (80%)
 rename arch/arm/plat-omap/include/plat/vrfb.h => include/video/omapvrfb.h (95%)
