From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap updates for 2.6.32
Date: Wed, 16 Sep 2009 11:30:34 -0700
Message-ID: <20090916183033.GB12297@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZIPSao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Sep 2009 14:30:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm@vger.kernel.org, linux-omap@vger.kernel.org

Linus,

Please pull the omap updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus

As discussed earlier in this thread:

http://lkml.org/lkml/2009/8/24/161

Regards,

Tony


The following changes since commit 326ba5010a5429a5a528b268b36a5900d4ab0eba:
  Linus Torvalds (1):
        Linux 2.6.31-rc8

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus

Anand Gadiyar (1):
      MUSB: Remove usb_musb_pm_init() call

Eero Nurkkala (1):
      OMAP: GPIO: Avoid generating extra IRQs

Felipe Balbi (1):
      OMAP3: beagle: add missing twl4030 usb platform_data

Hiroshi DOYU (3):
      OMAP: iommu: fix wrong argument in flush_cache_vmap()
      OMAP: iommu: add initial debugfs support
      OMAP clock: use debugfs_remove_recursive() for rewinding

Janusz Krzysztofik (1):
      OMAP1: AMS_DELTA: add modem support

Kalle Valo (5):
      OMAP: remove OMAP_TAG_SERIAL_CONSOLE
      OMAP: UART: drop OMAP_TAG_UART, enable all UARTs, auto-disabled on idle
      OMAP2: compile usb-tusb6010.c
      OMAP2: add board file for Nokia N800 and N810
      OMAP2: n8x0: add n8x0_defconfig

Ming Lei (1):
      OMAP3: PM: fix lockdep warning caused by omap3_pm_init

Paul Walmsley (10):
      OMAP3: update OMAP3 Beagle defconfig
      OMAP: powerdomain: Fix overflow when doing powerdomain deps lookups.
      OMAP clock: associate MPU clocks with the mpu_clkdm
      OMAP3 clock: remove superfluous calls to omap2_init_clk_clkdm
      OMAP2/3 PM: create the OMAP PM interface and add a default OMAP PM no-op layer
      OMAP2/3/4 PRCM: add module IDLEST wait code
      OMAP2/3 board-*.c files: read bootloader configuration earlier
      OMAP2/3/4: create omap_hwmod layer
      OMAP: omap_hwmod: call omap_hwmod init at boot; create interconnects
      OMAP2/3/4 core: create omap_device layer

Peter 'p2' De Schrijver (5):
      OMAP: PM counter infrastructure.
      OMAP: PM: Hook into PM counters
      OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
      OMAP: PM: Add pm-debug counters
      OMAP: PM debug: make powerdomains use PM-debug counters

Reddy, Teerth (1):
      OMAP3: PM: add T2 interrupt line mux setting, and enable on 3430SDP

Roger Quadros (1):
      OMAP: Remove omap boot parsing code

Sanjeev Premi (1):
      OMAP3 clock: Fixed processing of bootarg 'mpurate'

Santosh Shilimkar (2):
      ARM: OMAP4: Fix NULL pointer dereference crash.
      ARM: OMAP4: Bypass the clock check.

Sergio Aguirre (1):
      OMAP3: 3430SDP: Fix defconfig

Tero Kristo (3):
      OMAP: PM debug: Add PRCM register dump support
      OMAP: PM: Added suspend target state control to debugfs for OMAP3
      OMAP: SDRC: Add several new register definitions

Timo Kokkonen (1):
      OMAP3: rx51_defconfig: add twl4030 to rx51 default configuration

Tony Lindgren (5):
      OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead
      OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
      OMAP: Remove ifdefs for io.h
      Merge branch 'pm-upstream/debug' of git://git.kernel.org/.../khilman/linux-omap-pm into for-next
      Merge branch '2_6_32_for_next' of git://git.pwsan.com/linux-2.6 into for-next

Vikram Pandita (6):
      OMAP2/3: Pass irqflags to 8250 driver
      OMAP3: MMC: Add mux for pins
      OMAP3: Zoom2: Add TWL4030 support
      OMAP3: Zoom2: Update board defconfig
      OMAP: Zoom2: update serial platform_data id for external UART
      OMAP: Zoom2: release debug board detect gpio line

 Documentation/arm/OMAP/omap_pm                |  129 ++
 arch/arm/configs/n8x0_defconfig               | 1104 ++++++++++++++++++
 arch/arm/configs/omap3_beagle_defconfig       |   41 +-
 arch/arm/configs/omap_3430sdp_defconfig       |   20 +-
 arch/arm/configs/omap_zoom2_defconfig         |  484 +++++++--
 arch/arm/configs/rx51_defconfig               |    1 +
 arch/arm/mach-omap1/board-ams-delta.c         |   43 +-
 arch/arm/mach-omap1/board-fsample.c           |    5 -
 arch/arm/mach-omap1/board-generic.c           |    5 -
 arch/arm/mach-omap1/board-h2.c                |    5 -
 arch/arm/mach-omap1/board-h3.c                |    5 -
 arch/arm/mach-omap1/board-innovator.c         |    5 -
 arch/arm/mach-omap1/board-osk.c               |    5 -
 arch/arm/mach-omap1/board-palmte.c            |    5 -
 arch/arm/mach-omap1/board-palmtt.c            |    5 -
 arch/arm/mach-omap1/board-palmz71.c           |    5 -
 arch/arm/mach-omap1/board-perseus2.c          |    5 -
 arch/arm/mach-omap1/board-sx1.c               |    5 -
 arch/arm/mach-omap1/board-voiceblue.c         |    5 -
 arch/arm/mach-omap1/devices.c                 |    2 +-
 arch/arm/mach-omap1/io.c                      |    6 +-
 arch/arm/mach-omap1/pm.h                      |    4 +-
 arch/arm/mach-omap1/serial.c                  |   17 +-
 arch/arm/mach-omap1/sram.S                    |   12 +-
 arch/arm/mach-omap1/time.c                    |    4 +-
 arch/arm/mach-omap2/Kconfig                   |    9 +
 arch/arm/mach-omap2/Makefile                  |   10 +-
 arch/arm/mach-omap2/board-2430sdp.c           |   18 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   29 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    5 +-
 arch/arm/mach-omap2/board-apollon.c           |   25 +-
 arch/arm/mach-omap2/board-generic.c           |   15 +-
 arch/arm/mach-omap2/board-h4.c                |   25 +-
 arch/arm/mach-omap2/board-ldp.c               |   25 +-
 arch/arm/mach-omap2/board-n8x0.c              |  150 +++
 arch/arm/mach-omap2/board-omap3beagle.c       |   36 +-
 arch/arm/mach-omap2/board-omap3evm.c          |   17 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |   25 +-
 arch/arm/mach-omap2/board-overo.c             |   24 +-
 arch/arm/mach-omap2/board-rx51.c              |    9 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c   |   11 +-
 arch/arm/mach-omap2/board-zoom2.c             |  218 ++++-
 arch/arm/mach-omap2/clock.c                   |    2 +
 arch/arm/mach-omap2/clock34xx.c               |   17 +-
 arch/arm/mach-omap2/clock34xx.h               |   21 +-
 arch/arm/mach-omap2/clockdomain.c             |   10 +-
 arch/arm/mach-omap2/cm.c                      |   70 ++
 arch/arm/mach-omap2/cm.h                      |   10 +-
 arch/arm/mach-omap2/cm4xxx.c                  |   68 ++
 arch/arm/mach-omap2/devices.c                 |   41 +
 arch/arm/mach-omap2/io.c                      |   23 +-
 arch/arm/mach-omap2/iommu2.c                  |   19 +-
 arch/arm/mach-omap2/mux.c                     |   55 +
 arch/arm/mach-omap2/omap-smp.c                |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c              | 1554 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420.h         |  141 +++
 arch/arm/mach-omap2/omap_hwmod_2430.h         |  143 +++
 arch/arm/mach-omap2/omap_hwmod_34xx.h         |  168 +++
 arch/arm/mach-omap2/pm-debug.c                |  431 +++++++-
 arch/arm/mach-omap2/pm.h                      |   11 +
 arch/arm/mach-omap2/pm24xx.c                  |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |   40 +-
 arch/arm/mach-omap2/powerdomain.c             |  114 ++-
 arch/arm/mach-omap2/prm.h                     |    6 +-
 arch/arm/mach-omap2/sdrc.h                    |    6 +-
 arch/arm/mach-omap2/serial.c                  |   67 +-
 arch/arm/mach-omap2/sram242x.S                |    4 +-
 arch/arm/mach-omap2/sram243x.S                |    4 +-
 arch/arm/mach-omap2/timer-gp.c                |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |   12 -
 arch/arm/plat-omap/Kconfig                    |   17 +
 arch/arm/plat-omap/Makefile                   |    6 +
 arch/arm/plat-omap/clock.c                    |    2 +-
 arch/arm/plat-omap/common.c                   |   88 --
 arch/arm/plat-omap/dma.c                      |    8 +-
 arch/arm/plat-omap/dmtimer.c                  |    5 +-
 arch/arm/plat-omap/gpio.c                     |  115 ++-
 arch/arm/plat-omap/include/mach/board.h       |    2 -
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/control.h     |   12 +-
 arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
 arch/arm/plat-omap/include/mach/gpio.h        |    2 +-
 arch/arm/plat-omap/include/mach/io.h          |   97 +-
 arch/arm/plat-omap/include/mach/iommu.h       |    6 +-
 arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 +-
 arch/arm/plat-omap/include/mach/mux.h         |   31 +
 arch/arm/plat-omap/include/mach/omap-pm.h     |  301 +++++
 arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
 arch/arm/plat-omap/include/mach/omap_device.h |  141 +++
 arch/arm/plat-omap/include/mach/omap_hwmod.h  |  447 +++++++
 arch/arm/plat-omap/include/mach/powerdomain.h |   15 +-
 arch/arm/plat-omap/include/mach/sdrc.h        |   15 +-
 arch/arm/plat-omap/include/mach/serial.h      |    3 +
 arch/arm/plat-omap/io.c                       |   62 +-
 arch/arm/plat-omap/iommu-debug.c              |  415 +++++++
 arch/arm/plat-omap/iommu.c                    |   23 +-
 arch/arm/plat-omap/iovmm.c                    |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |  296 +++++
 arch/arm/plat-omap/omap_device.c              |  687 +++++++++++
 arch/arm/plat-omap/sram.c                     |   18 +-
 drivers/input/keyboard/omap-keypad.c          |   22 +-
 drivers/mtd/nand/ams-delta.c                  |    8 +-
 drivers/video/omap/dispc.c                    |    6 +-
 103 files changed, 7777 insertions(+), 719 deletions(-)
 create mode 100644 Documentation/arm/OMAP/omap_pm
 create mode 100644 arch/arm/configs/n8x0_defconfig
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c
 create mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2420.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2430.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_34xx.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap-pm.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap_device.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap_hwmod.h
 create mode 100644 arch/arm/plat-omap/iommu-debug.c
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c
 create mode 100644 arch/arm/plat-omap/omap_device.c
