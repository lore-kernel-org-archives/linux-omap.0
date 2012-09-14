From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/7] omap sparse irq and local hardware.h cleanup for v3.7
 merge window
Date: Thu, 13 Sep 2012 19:34:11 -0700
Message-ID: <E1TCLkk-0006f8-MV@merlin.infradead.org>
References: <pull-1347590052-683636>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1347590052-683636>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit a1e01703bacbadd22eb4aaca0bbba59bcba7d3b3:

  Merge tags 'omap-devel-gpmc-fixed-for-v3.7' and 'cleanup-omap-tags-for-v3.7' into cleanup-sparseirq (2012-09-12 18:05:19 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-sparseirq-for-v3.7

for you to fetch changes up to 68cb700c59fae6cd539c9dc1e9f2584f671935a0:

  ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)

----------------------------------------------------------------
This branch contains changes needed to make omap2+
work properly with sparse IRQ. It also removes
dependencies to mach/hardware.h. These help moving
things towards ARM single zImage support.

This branch is based on a commit in tty-next
branch with omap-devel-gpmc-fixed-for-v3.7 and
cleanup-omap-tags-for-v3.7 merged in to keep things
compiling and sort out some merge conflicts.

----------------------------------------------------------------
Tony Lindgren (15):
      ARM: OMAP1: Move define of OMAP_LCD_DMA to dma.h
      ARM: OMAP1: Define OMAP1_INT_I2C locally
      ARM: OMAP2+: Make INTCPS_NR_IRQS local for mach-omap2/irq.c
      ARM: OMAP2+: Remove unused nand_irq for GPMC
      ARM: OMAP2+: Remove hardcoded twl4030 gpio_base, irq_base and irq_end
      ARM: OMAP: Move gpio.h to include/linux/platform_data
      Input: omap-keypad: Remove dependencies to mach includes
      W1: OMAP HDQ1W: Remove dependencies to mach/hardware.h
      ARM: OMAP2+: Prepare for irqs.h removal
      ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ
      ARM: OMAP1: Move plat/irqs.h to mach/irqs.h
      ARM: OMAP: Remove unused old gpio-switch.h
      ARM: OMAP: Split plat/hardware.h, use local soc.h for omap2+
      ARM: OMAP2+ Move SoC specific headers to be local to mach-omap2
      ARM: OMAP1: Move SoC specific headers from plat to mach for omap1

 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    1 +
 arch/arm/mach-omap1/board-ams-delta.c              |    1 +
 arch/arm/mach-omap1/board-htcherald.c              |    2 +-
 arch/arm/mach-omap1/board-osk.c                    |    1 +
 arch/arm/mach-omap1/devices.c                      |    2 +-
 arch/arm/mach-omap1/dma.c                          |    3 +-
 arch/arm/mach-omap1/gpio15xx.c                     |    1 +
 arch/arm/mach-omap1/gpio16xx.c                     |    1 +
 arch/arm/mach-omap1/gpio7xx.c                      |    1 +
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h   |    2 -
 arch/arm/mach-omap1/include/mach/gpio.h            |    2 -
 arch/arm/mach-omap1/include/mach/hardware.h        |  285 +++++++++++-
 arch/arm/mach-omap1/include/mach/irqs.h            |  267 +++++++++++-
 .../plat => mach-omap1/include/mach}/omap1510.h    |    3 +-
 .../plat => mach-omap1/include/mach}/omap16xx.h    |    3 +-
 .../plat => mach-omap1/include/mach}/omap7xx.h     |    3 +-
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    1 +
 arch/arm/mach-omap1/leds.c                         |    1 +
 .../include/plat => mach-omap2}/am33xx.h           |    0
 arch/arm/mach-omap2/board-2430sdp.c                |    5 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    4 -
 arch/arm/mach-omap2/board-4430sdp.c                |    5 +-
 arch/arm/mach-omap2/board-am3517crane.c            |    1 -
 arch/arm/mach-omap2/board-am3517evm.c              |    5 +-
 arch/arm/mach-omap2/board-apollon.c                |    1 -
 arch/arm/mach-omap2/board-cm-t35.c                 |    4 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    6 -
 arch/arm/mach-omap2/board-flash.c                  |    4 +-
 arch/arm/mach-omap2/board-generic.c                |    1 -
 arch/arm/mach-omap2/board-h4.c                     |    3 +-
 arch/arm/mach-omap2/board-igep0020.c               |    4 +-
 arch/arm/mach-omap2/board-ldp.c                    |    6 -
 arch/arm/mach-omap2/board-n8x0.c                   |    4 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 -
 arch/arm/mach-omap2/board-omap3evm.c               |    4 -
 arch/arm/mach-omap2/board-omap3logic.c             |   17 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    4 -
 arch/arm/mach-omap2/board-omap3stalker.c           |    9 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |    4 -
 arch/arm/mach-omap2/board-omap4panda.c             |    5 +-
 arch/arm/mach-omap2/board-overo.c                  |    5 -
 arch/arm/mach-omap2/board-rm680.c                  |    6 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    5 +-
 arch/arm/mach-omap2/board-rx51.c                   |    1 -
 arch/arm/mach-omap2/board-ti8168evm.c              |    2 -
 arch/arm/mach-omap2/board-zoom-debugboard.c        |    3 +
 arch/arm/mach-omap2/board-zoom-display.c           |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    6 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    2 +-
 arch/arm/mach-omap2/clkt_dpll.c                    |    2 +-
 arch/arm/mach-omap2/clock.c                        |    8 +-
 arch/arm/mach-omap2/clock2420_data.c               |    2 +-
 arch/arm/mach-omap2/clock2430.c                    |    2 +-
 arch/arm/mach-omap2/clock2430_data.c               |    2 +-
 arch/arm/mach-omap2/clock2xxx.c                    |    2 +-
 arch/arm/mach-omap2/clock33xx_data.c               |    2 +-
 arch/arm/mach-omap2/clock3xxx.c                    |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    3 +-
 arch/arm/mach-omap2/common-board-devices.c         |    1 +
 arch/arm/mach-omap2/common.c                       |    2 +-
 arch/arm/mach-omap2/common.h                       |    9 +-
 arch/arm/mach-omap2/control.c                      |    2 +-
 arch/arm/mach-omap2/control.h                      |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |    1 -
 arch/arm/mach-omap2/devices.c                      |   18 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |    2 +-
 arch/arm/mach-omap2/dpll44xx.c                     |    2 +-
 arch/arm/mach-omap2/emu.c                          |    3 +-
 arch/arm/mach-omap2/gpio.c                         |    1 +
 arch/arm/mach-omap2/gpmc-nand.c                    |    3 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |    3 +-
 arch/arm/mach-omap2/gpmc-smc91x.c                  |    2 +
 arch/arm/mach-omap2/gpmc.c                         |   11 +-
 arch/arm/mach-omap2/hsmmc.c                        |    2 +
 arch/arm/mach-omap2/i2c.c                          |    1 -
 arch/arm/mach-omap2/id.c                           |    2 +-
 arch/arm/mach-omap2/include/mach/gpio.h            |    2 -
 arch/arm/mach-omap2/include/mach/hardware.h        |    2 -
 arch/arm/mach-omap2/include/mach/irqs.h            |    2 -
 arch/arm/mach-omap2/io.c                           |    1 +
 arch/arm/mach-omap2/irq.c                          |    5 +-
 arch/arm/mach-omap2/mailbox.c                      |    4 +-
 arch/arm/mach-omap2/mcbsp.c                        |    2 -
 arch/arm/mach-omap2/msdi.c                         |    1 +
 arch/arm/mach-omap2/omap-iommu.c                   |   12 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    3 +-
 arch/arm/mach-omap2/omap-smp.c                     |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c               |    1 +
 .../include/plat => mach-omap2}/omap24xx.h         |    2 -
 .../include/plat => mach-omap2}/omap34xx.h         |    2 -
 arch/arm/mach-omap2/omap4-common.c                 |    9 +-
 .../include/plat => mach-omap2}/omap44xx.h         |    2 +-
 .../include/plat => mach-omap2}/omap54xx.h         |    0
 arch/arm/mach-omap2/omap_hwmod.c                   |    8 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   25 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   73 ++--
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  108 +++--
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    8 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  152 +++----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    3 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/omap_l3_noc.c                  |    5 +-
 arch/arm/mach-omap2/omap_phy_internal.c            |    2 +
 arch/arm/mach-omap2/opp2420_data.c                 |    2 +-
 arch/arm/mach-omap2/opp2430_data.c                 |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c                 |    2 -
 arch/arm/mach-omap2/opp4xxx_data.c                 |    3 +-
 arch/arm/mach-omap2/pm24xx.c                       |    3 +-
 arch/arm/mach-omap2/pm34xx.c                       |    2 +
 arch/arm/mach-omap2/powerdomain.c                  |    6 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c        |    4 +-
 arch/arm/mach-omap2/prcm.c                         |    1 -
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    7 +-
 arch/arm/mach-omap2/prm44xx.c                      |    5 +-
 arch/arm/mach-omap2/prm_common.c                   |    1 -
 arch/arm/mach-omap2/sdrc2xxx.c                     |    2 +-
 arch/arm/mach-omap2/serial.c                       |    1 +
 arch/arm/mach-omap2/sleep24xx.S                    |    3 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    2 +-
 arch/arm/mach-omap2/sleep44xx.S                    |    2 +-
 arch/arm/mach-omap2/soc.h                          |    7 +
 arch/arm/mach-omap2/sram242x.S                     |    3 +-
 arch/arm/mach-omap2/sram243x.S                     |    3 +-
 arch/arm/mach-omap2/sram34xx.S                     |    3 +-
 .../include/plat => mach-omap2}/ti81xx.h           |    0
 arch/arm/mach-omap2/timer.c                        |    9 +-
 arch/arm/mach-omap2/twl-common.c                   |    3 +-
 arch/arm/mach-omap2/twl-common.h                   |    6 +-
 arch/arm/mach-omap2/usb-host.c                     |    2 -
 arch/arm/mach-omap2/usb-musb.c                     |    7 +-
 arch/arm/mach-omap2/vc.c                           |    3 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c      |    3 +-
 arch/arm/plat-omap/Kconfig                         |    1 +
 arch/arm/plat-omap/Makefile                        |    3 +-
 arch/arm/plat-omap/counter_32k.c                   |    2 -
 arch/arm/plat-omap/debug-leds.c                    |    1 +
 arch/arm/plat-omap/devices.c                       |   91 ----
 arch/arm/plat-omap/dma.c                           |    3 +-
 arch/arm/plat-omap/i2c.c                           |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h              |    3 +
 arch/arm/plat-omap/include/plat/dma.h              |    2 +
 arch/arm/plat-omap/include/plat/gpio-switch.h      |   54 ---
 arch/arm/plat-omap/include/plat/hardware.h         |  293 -------------
 arch/arm/plat-omap/include/plat/irqs-44xx.h        |  144 -------
 arch/arm/plat-omap/include/plat/irqs.h             |  453 --------------------
 arch/arm/plat-omap/include/plat/nand.h             |    1 -
 arch/arm/plat-omap/include/plat/omap4-keypad.h     |    2 +
 drivers/dma/omap-dma.c                             |    2 +
 drivers/gpio/gpio-omap.c                           |   15 +-
 drivers/gpio/gpio-twl4030.c                        |   15 +-
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/omap-keypad.c               |  154 ++-----
 drivers/media/video/omap/omap_vout.c               |    1 +
 drivers/media/video/omap3isp/isp.c                 |    2 +
 drivers/mfd/twl-core.c                             |    2 +
 drivers/mtd/nand/ams-delta.c                       |    8 +-
 drivers/mtd/onenand/omap2.c                        |    1 +
 drivers/power/avs/smartreflex.c                    |    2 +
 drivers/spi/spi-omap-uwire.c                       |    3 +-
 drivers/staging/tidspbridge/core/wdt.c             |    2 +-
 drivers/video/omap2/dss/dispc.c                    |    1 +
 drivers/video/omap2/omapfb/omapfb-main.c           |    1 +
 drivers/w1/masters/omap_hdq.c                      |    3 +-
 drivers/watchdog/omap_wdt.c                        |    5 +
 include/linux/i2c/twl.h                            |    3 -
 include/linux/mfd/twl6040.h                        |    1 -
 .../linux/platform_data/gpio-omap.h                |   15 +-
 sound/soc/omap/mcbsp.c                             |    2 +
 sound/soc/omap/omap-abe-twl6040.c                  |    4 -
 sound/soc/omap/omap-mcbsp.c                        |    1 +
 sound/soc/omap/omap-mcpdm.c                        |    2 +
 sound/soc/omap/omap-pcm.c                          |    1 +
 sound/soc/omap/sdp3430.c                           |    1 +
 176 files changed, 1013 insertions(+), 1637 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/omap1510.h (97%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/omap16xx.h (99%)
 rename arch/arm/{plat-omap/include/plat => mach-omap1/include/mach}/omap7xx.h (98%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/am33xx.h (100%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap24xx.h (98%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap34xx.h (98%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap44xx.h (97%)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/omap54xx.h (100%)
 create mode 100644 arch/arm/mach-omap2/soc.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/ti81xx.h (100%)
 delete mode 100644 arch/arm/plat-omap/devices.c
 delete mode 100644 arch/arm/plat-omap/include/plat/gpio-switch.h
 delete mode 100644 arch/arm/plat-omap/include/plat/hardware.h
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs-44xx.h
 delete mode 100644 arch/arm/plat-omap/include/plat/irqs.h
 rename arch/arm/plat-omap/include/plat/gpio.h => include/linux/platform_data/gpio-omap.h (94%)
