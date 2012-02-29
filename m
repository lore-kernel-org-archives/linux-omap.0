From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/5] Clean-up for omap
Date: Wed, 29 Feb 2012 12:15:06 -0800
Message-ID: <E1S2pwf-0004tL-OY@merlin.infradead.org>
References: <pull-1330546506-268554>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1330546506-268554>
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


This is mostly changes needed for io.h removal, and one
patch to remove unused flag for McSPI. Note that these
are based on RMK's for-armsoc.

Also, these cause a minor merge conflict for mach-omap2/Kconfig
with the fixes-non-critical posted in this series of pull
requests.

Regards,

Tony

The following changes since commit 61b80086a525c8a6081257ae40da5dee2bcaee16:
  Russell King (1):
        Merge branch 'entry-macro-cleanup' of git://sources.calxeda.com/kernel/linux into for-armsoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup

Jarkko Nikula (1):
      ARM: OMAP: McSPI: Remove unused flag from struct omap2_mcspi_device_config

Paul Walmsley (1):
      ARM: OMAP2xxx: PM: remove obsolete timer disable code in the suspend path

Tony Lindgren (10):
      ARM: OMAP2+: Drop DISPC L3 firewall code
      ARM: OMAP2+: Move SDRC related functions from io.h into local common.h
      ARM: OMAP: Move omap_init_consistent_dma_size() to local common.h
      ARM: OMAP1: Move 16xx GPIO system clock to platform init code
      ARM: OMAP1: Move most of plat/io.h into local iomap.h
      ARM: OMAP2+: Move most of plat/io.h into local iomap.h
      ARM: OMAP: Remove plat/io.h by splitting it into mach/io.h and mach/hardware.h
      ARM: OMAP2+: Limit omap_read/write usage to legacy USB drivers
      Merge branch 'iomap' into cleanup
      ARM: OMAP2+: Fix L4_EMU_34XX_BASE error after iomap changes

 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    3 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |    1 +
 arch/arm/mach-omap1/board-ams-delta.c              |   10 ++-
 arch/arm/mach-omap1/board-fsample.c                |    7 +-
 arch/arm/mach-omap1/board-h2.c                     |    6 +-
 arch/arm/mach-omap1/board-h3.c                     |    8 +-
 arch/arm/mach-omap1/board-htcherald.c              |    5 +-
 arch/arm/mach-omap1/board-innovator.c              |    7 +-
 arch/arm/mach-omap1/board-nokia770.c               |    6 +-
 arch/arm/mach-omap1/board-osk.c                    |    7 +-
 arch/arm/mach-omap1/board-palmte.c                 |    4 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    9 +-
 arch/arm/mach-omap1/board-palmz71.c                |    9 +-
 arch/arm/mach-omap1/board-perseus2.c               |    7 +-
 arch/arm/mach-omap1/board-sx1.c                    |    6 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    6 +-
 arch/arm/mach-omap1/clock.c                        |    5 +-
 arch/arm/mach-omap1/clock_data.c                   |    5 +-
 arch/arm/mach-omap1/common.h                       |    1 +
 arch/arm/mach-omap1/devices.c                      |    8 +-
 arch/arm/mach-omap1/dma.c                          |    2 +-
 arch/arm/mach-omap1/flash.c                        |    4 +-
 arch/arm/mach-omap1/fpga.c                         |    5 +-
 arch/arm/mach-omap1/gpio16xx.c                     |    7 ++
 arch/arm/mach-omap1/id.c                           |    3 +
 arch/arm/mach-omap1/include/mach/entry-macro.S     |    4 +-
 arch/arm/mach-omap1/include/mach/hardware.h        |   36 +++++++++
 arch/arm/mach-omap1/include/mach/io.h              |   43 ++++++++++-
 arch/arm/mach-omap1/include/mach/memory.h          |    3 +-
 arch/arm/mach-omap1/io.c                           |    3 +
 arch/arm/mach-omap1/iomap.h                        |   42 ++++++++++
 arch/arm/mach-omap1/irq.c                          |    4 +-
 arch/arm/mach-omap1/lcd_dma.c                      |    3 +-
 arch/arm/mach-omap1/mcbsp.c                        |    5 +-
 arch/arm/mach-omap1/pm.c                           |    4 +-
 arch/arm/mach-omap1/reset.c                        |    3 +-
 arch/arm/mach-omap1/sleep.S                        |    4 +
 arch/arm/mach-omap1/sram.S                         |    4 +
 arch/arm/mach-omap1/time.c                         |    3 +-
 arch/arm/mach-omap1/timer32k.c                     |    7 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    1 -
 arch/arm/mach-omap2/board-n8x0.c                   |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c       |    3 -
 arch/arm/mach-omap2/board-zoom-display.c           |    1 -
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |    1 +
 arch/arm/mach-omap2/clkt_dpll.c                    |    1 +
 arch/arm/mach-omap2/clock2420_data.c               |    3 +
 arch/arm/mach-omap2/clock2430.c                    |    2 +
 arch/arm/mach-omap2/clock2430_data.c               |    2 +
 arch/arm/mach-omap2/clock2xxx.c                    |    1 +
 arch/arm/mach-omap2/clock3xxx.c                    |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c               |    3 +-
 arch/arm/mach-omap2/clock44xx_data.c               |    3 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm44xx.c                       |    2 +-
 arch/arm/mach-omap2/cminst44xx.c                   |    2 +-
 arch/arm/mach-omap2/common-board-devices.c         |    1 -
 arch/arm/mach-omap2/common.c                       |    4 +-
 arch/arm/mach-omap2/common.h                       |    7 ++
 arch/arm/mach-omap2/control.c                      |    3 +-
 arch/arm/mach-omap2/control.h                      |    1 -
 arch/arm/mach-omap2/devices.c                      |    2 +-
 arch/arm/mach-omap2/display.c                      |    1 +
 arch/arm/mach-omap2/emu.c                          |    4 +
 arch/arm/mach-omap2/gpmc-nand.c                    |    1 +
 arch/arm/mach-omap2/gpmc-onenand.c                 |    1 +
 arch/arm/mach-omap2/include/mach/io.h              |   46 +++++++++++-
 arch/arm/mach-omap2/io.c                           |   57 ++------------
 .../include/plat/io.h => mach-omap2/iomap.h}       |   80 +-------------------
 arch/arm/mach-omap2/irq.c                          |    5 +-
 arch/arm/mach-omap2/omap-smp.c                     |    3 +-
 arch/arm/mach-omap2/opp2420_data.c                 |    2 +
 arch/arm/mach-omap2/opp2430_data.c                 |    2 +
 arch/arm/mach-omap2/pm24xx.c                       |   27 +------
 arch/arm/mach-omap2/prcm_mpu44xx.c                 |    2 +-
 arch/arm/mach-omap2/prm44xx.c                      |    3 +-
 arch/arm/mach-omap2/prminst44xx.c                  |    2 +-
 arch/arm/mach-omap2/sdram-nokia.c                  |    1 -
 arch/arm/mach-omap2/sdrc2xxx.c                     |    5 +-
 arch/arm/mach-omap2/sleep24xx.S                    |    1 -
 arch/arm/mach-omap2/sleep34xx.S                    |    5 +-
 arch/arm/mach-omap2/sram242x.S                     |    4 +-
 arch/arm/mach-omap2/sram243x.S                     |    4 +-
 arch/arm/mach-omap2/sram34xx.S                     |    5 +-
 arch/arm/plat-omap/counter_32k.c                   |    1 +
 arch/arm/plat-omap/dma.c                           |    2 +
 arch/arm/plat-omap/dmtimer.c                       |    2 +
 arch/arm/plat-omap/include/plat/hardware.h         |    6 ++
 arch/arm/plat-omap/include/plat/keypad.h           |    2 +
 arch/arm/plat-omap/include/plat/mcspi.h            |    3 -
 arch/arm/plat-omap/include/plat/tc.h               |   17 ----
 arch/arm/plat-omap/include/plat/usb.h              |   41 ++++++++++
 arch/arm/plat-omap/mux.c                           |    5 +-
 arch/arm/plat-omap/sram.c                          |    9 +-
 arch/arm/plat-omap/usb.c                           |    4 +
 drivers/char/hw_random/omap-rng.c                  |    2 +
 drivers/gpio/gpio-omap.c                           |    7 --
 drivers/video/omap2/dss/dispc.c                    |    5 -
 drivers/video/omap2/dss/dss.c                      |    3 +
 99 files changed, 446 insertions(+), 280 deletions(-)
 create mode 100644 arch/arm/mach-omap1/iomap.h
 rename arch/arm/{plat-omap/include/plat/io.h => mach-omap2/iomap.h} (77%)
