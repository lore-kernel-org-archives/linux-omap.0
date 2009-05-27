From: Tony Lindgren <tony@atomide.com>
Subject: Git pull request for omap patches for merge window after 2.6.30
Date: Wed, 27 May 2009 16:40:57 -0700
Message-ID: <20090527234056.GJ6267@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+JUInw4efm7IfTNU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54975 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZE0XlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 19:41:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

Assuming you have had a chance to look at all the patches posted,
please pull them from the request below. Will refresh the patches
as needed if you have more comments.

I've merged all the omap patches, except Santosh' omap4 SMP
set, and Paul's second clock updates. This should remove any
dependencies for Santosh' SMP series.

Merging this will cause a trivial merge conflict in
arch/arm/Makefile with the omap4 line, so let me know if you want
me to rebase on something else other than v2.6.30-rc7.

Regards,

Tony


Summary of patch sets merged:

[PATCH 0/5] More omap header clean-up for the merge window after 2.6.30
http://article.gmane.org/gmane.linux.ports.arm.omap/19727

[PATCH 0/4] OMAP: Cleanup series
http://lists.arm.linux.org.uk/lurker/message/20090519.131647.c2c471ef.en.html

[PATCH 00/10] OMAP clock/SDRC patches on v2.6.30-rc5
http://article.gmane.org/gmane.linux.ports.arm.omap/19589

[PATCH v2 00/13] OMAP2/3: PM sync-up
http://article.gmane.org/gmane.linux.ports.arm.omap/20073

[PATCH 00/10] Omap updates for merge window after 2.6.30
http://article.gmane.org/gmane.linux.ports.arm.omap/19979

[PATCH 0/6] Updates for omap3 for merge window after 2.6.30
http://article.gmane.org/gmane.linux.ports.arm.omap/20123

PATCH 0/8] omap3 board updates for merge window after 2.6.30
http://article.gmane.org/gmane.linux.ports.arm.omap/20188

[PATCH 1/4] ARM: OMAP4: Add minimal support for omap4
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12819.html

Pull request:



--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit 59a3759d0fe8d969888c741bb33f4946e4d3750d:
  Linus Torvalds (1):
        Linux 2.6.30-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git for-next

Adrian Hunter (1):
      ARM: OMAP3: RX51: Connect VAUX3 to MMC2

Artem Bityutskiy (1):
      OMAP3 clock: lessen amount of noisy messages

David Brownell (2):
      ARM: OMAP3: mmc-twl4030 uses regulator framework
      ARM: OMAP3: Initialize regulators for Beagle and Overo

Eero Nurkkala (1):
      ARM: OMAP: McBSP: Fix legacy interrupts to clear their status

Grazvydas Ignotas (2):
      ARM: OMAP3: pandora: setup regulator framework for MMC
      ARM: OMAP3: pandora: add support for mode devices

Imre Deak (2):
      ARM: OMAP2: 2430SDP: Add FB support to board file
      ARM: OMAP3: ZOOM MDK: Add FB support to board file

Jarkko Nikula (1):
      ARM: OMAP: Update contact address of I2C registration helper

Jouni Hogander (2):
      OMAP: Add new function to check wether there is irq pending
      OMAP: UART: Add sysfs interface for adjusting UART sleep timeout

Juha Yrjola (1):
      ARM: OMAP2/3: Add generic onenand support when connected to GPMC

Kevin Hilman (11):
      Revert "ARM: OMAP: Mask interrupts when disabling interrupts, v2"
      OMAP2/3: PM: push core PM code from linux-omap
      OMAP3: PM: Force IVA2 into idle during bootup
      OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
      OMAP3: PM: UART: disable clocks when idle and off-mode support
      OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
      OMAP3: PM: D2D clockdomain supports SW supervised transitions
      OMAP3: PM: Ensure PRCM interrupts are cleared at boot
      OMAP3: PM: Clear pending PRCM reset flags on init
      OMAP3: PM: prevent module wakeups from waking IVA2
      OMAP1: PM: update and decouple from OMAP2/3 PM core

Mans Rullgard (1):
      ARM: OMAP: Increase VMALLOC_END to allow 256MB RAM

Paul Walmsley (11):
      OMAP3 SRAM: mark OCM RAM as Non-cacheable Normal memory
      OMAP3 SRAM: add ARM barriers to omap3_sram_configure_core_dpll
      OMAP3 clock: add interconnect barriers to CORE DPLL M2 change
      OMAP3 SRAM: clear the SDRC PWRENA bit during SDRC frequency change
      OMAP3 SDRC: initialize SDRC_POWER at boot
      OMAP3 SRAM: renumber registers to make space for argument passing
      OMAP3 clock: only unlock SDRC DLL if SDRC clk < 83MHz
      OMAP3 clock: use pr_debug() rather than pr_info() in some clock change code
      OMAP2xxx clock: rename clk_init_one() to clk_preinit()
      ARM: OMAP3: SDRC: add timing data for Micron MT46H32M32LF-6, v2
      ARM: OMAP3: SDRC: add timing data for Qimonda HYB18M512160AF-6

Peter 'p2' De Schrijver (1):
      OMAP3: PM: Ensure MUSB block can idle when driver not loaded

Santosh Shilimkar (11):
      ARM: OMAP: Remove unwanted type casts and fix the compiler warning.
      ARM: OMAP: Remove useless omap_sram_error function.
      ARM: OMAP: Remove unnecessary omap2_globals.
      ARM: OMAP2/3: sDMA: Correct omap_request_dma_chain(), v2
      ARM: OMAP: Remove unwanted type casts and fix the compiler warning.
      ARM: OMAP: Remove useless omap_sram_error function.
      ARM: OMAP: Remove unnecessary omap2_globals.
      ARM: OMAP4: Add minimal support for omap4
      ARM: OMAP4: Clock stubs since CLKDEV not in yet.
      ARM: OMAP4: Add support for 4430 SDP
      ARM: OMAP4: Add defconfig for 4430 SDP

Syed Mohammed Khasim (2):
      ARM: OMAP3: Add omap3 EVM support
      ARM: OMAP3: Add omap3 EVM defconfig

Tomi Valkeinen (1):
      ARM: OMAP2/3: DMA: implement trans copy and const fill

Tony Lindgren (23):
      ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE
      ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
      ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be local to entry-macro.S
      ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
      ARM: OMAP2/3: Remove OMAP_CM_REGADDR
      ARM: OMAP2/3: Reorganize Makefile to add omap4 support
      ARM: OMAP1: Misc clean-up
      ARM: OMAP1: Make 770 LCD work
      ARM: OMAP2/3: Add generic smc91x support when connected to GPMC
      ARM: OMAP: Add some entries to MAINTAINERS
      ARM: OMAP2/3: Remove L4_WK_OMAP_BASE, L4_PER_OMAP_BASE, L4_EMU_BASE, L3_OMAP_BASE
      ARM: OMAP3: Initialize more devices for LDP
      ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE
      ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
      ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be local to entry-macro.S
      ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
      ARM: OMAP2/3: Remove OMAP_CM_REGADDR
      ARM: OMAP2/3: Reorganize Makefile to add omap4 support
      Merge branch 'omap-clock-upstream' of git://git.pwsan.com/linux-2.6 into for-next
      Merge branch 'omap-upstream' into for-next
      Merge branch 'omap3-upstream' into for-next
      Merge branch 'omap3-boards' into for-next
      Merge branch 'omap4' into for-next

Vikram Pandita (3):
      ARM: OMAP2/3: Serial: Remove arch_initcall dependency
      ARM: OMAP3: Add support for OMAP3 Zoom2 board
      ARM: OMAP3: Defconfig for Zoom2 board

 MAINTAINERS                                        |   77 +-
 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/omap3_evm_defconfig               | 1528 ++++++++++++++++++++
 arch/arm/configs/omap_4430sdp_defconfig            |  806 +++++++++++
 arch/arm/configs/omap_zoom2_defconfig              | 1211 ++++++++++++++++
 arch/arm/configs/rx51_defconfig                    |    2 +-
 arch/arm/mach-omap1/Kconfig                        |    1 -
 arch/arm/mach-omap1/Makefile                       |    4 +
 arch/arm/mach-omap1/board-nokia770.c               |   17 +
 arch/arm/mach-omap1/clock.c                        |    2 +-
 arch/arm/mach-omap1/pm.c                           |   11 +-
 .../{plat-omap/include/mach => mach-omap1}/pm.h    |   85 +-
 arch/arm/mach-omap1/serial.c                       |    3 -
 arch/arm/mach-omap1/sleep.S                        |    2 +-
 arch/arm/mach-omap2/Kconfig                        |   14 +-
 arch/arm/mach-omap2/Makefile                       |   29 +-
 arch/arm/mach-omap2/board-2430sdp.c                |  114 +-
 arch/arm/mach-omap2/board-3430sdp.c                |   87 +-
 arch/arm/mach-omap2/board-4430sdp.c                |   94 ++
 arch/arm/mach-omap2/board-ldp.c                    |  219 +++-
 arch/arm/mach-omap2/board-omap3beagle.c            |  108 ++-
 arch/arm/mach-omap2/board-omap3evm.c               |  329 +++++
 arch/arm/mach-omap2/board-omap3pandora.c           |  197 +++-
 arch/arm/mach-omap2/board-overo.c                  |   79 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  232 ++--
 arch/arm/mach-omap2/board-zoom-debugboard.c        |  160 ++
 arch/arm/mach-omap2/board-zoom2.c                  |  110 ++
 arch/arm/mach-omap2/clock.c                        |   18 +-
 arch/arm/mach-omap2/clock24xx.c                    |   23 +-
 arch/arm/mach-omap2/clock24xx.h                    |   11 +
 arch/arm/mach-omap2/clock34xx.c                    |   23 +-
 arch/arm/mach-omap2/clock34xx.h                    |   35 +-
 arch/arm/mach-omap2/clockdomains.h                 |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |   14 +
 arch/arm/mach-omap2/cm.h                           |    6 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  330 +++++
 arch/arm/mach-omap2/gpmc-smc91x.c                  |  189 +++
 arch/arm/mach-omap2/gpmc.c                         |    6 +
 arch/arm/mach-omap2/id.c                           |    8 +-
 arch/arm/mach-omap2/io.c                           |   52 +-
 arch/arm/mach-omap2/irq.c                          |   18 +-
 arch/arm/mach-omap2/mmc-twl4030.c                  |  280 ++---
 arch/arm/mach-omap2/mmc-twl4030.h                  |    3 +-
 arch/arm/mach-omap2/pm-debug.c                     |  152 ++
 arch/arm/mach-omap2/pm.c                           |  114 +--
 arch/arm/mach-omap2/pm.h                           |   38 +
 arch/arm/mach-omap2/pm24xx.c                       |  544 +++++++
 arch/arm/mach-omap2/pm34xx.c                       |  705 +++++++++
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 arch/arm/mach-omap2/prm.h                          |  207 ++-
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   55 +
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   54 +
 arch/arm/mach-omap2/sdrc.c                         |   24 +-
 arch/arm/mach-omap2/sdrc2xxx.c                     |    5 +-
 arch/arm/mach-omap2/serial.c                       |  465 ++++++-
 arch/arm/mach-omap2/sleep24xx.S                    |    1 -
 arch/arm/mach-omap2/sleep34xx.S                    |  436 ++++++
 arch/arm/mach-omap2/sram242x.S                     |   10 +-
 arch/arm/mach-omap2/sram243x.S                     |   10 +-
 arch/arm/mach-omap2/sram34xx.S                     |  129 +-
 arch/arm/mach-omap2/timer-gp.c                     |    9 +-
 arch/arm/mach-omap2/usb-musb.c                     |   21 +-
 arch/arm/plat-omap/Kconfig                         |   13 +-
 arch/arm/plat-omap/clock.c                         |   37 +-
 arch/arm/plat-omap/common.c                        |  114 ++-
 arch/arm/plat-omap/devices.c                       |    2 +
 arch/arm/plat-omap/dma.c                           |  102 +-
 arch/arm/plat-omap/dmtimer.c                       |   73 +-
 arch/arm/plat-omap/gpio.c                          |  134 ++-
 arch/arm/plat-omap/i2c.c                           |    2 +-
 arch/arm/plat-omap/include/mach/clock.h            |   10 +-
 arch/arm/plat-omap/include/mach/common.h           |    3 +-
 arch/arm/plat-omap/include/mach/control.h          |   20 +-
 arch/arm/plat-omap/include/mach/cpu.h              |   21 +-
 arch/arm/plat-omap/include/mach/debug-macro.S      |    2 +-
 arch/arm/plat-omap/include/mach/dma.h              |    4 +-
 arch/arm/plat-omap/include/mach/entry-macro.S      |   55 +-
 arch/arm/plat-omap/include/mach/gpmc-smc91x.h      |   42 +
 arch/arm/plat-omap/include/mach/hardware.h         |    1 +
 arch/arm/plat-omap/include/mach/hwa742.h           |    5 +-
 arch/arm/plat-omap/include/mach/io.h               |   37 +
 arch/arm/plat-omap/include/mach/irqs.h             |   90 ++
 arch/arm/plat-omap/include/mach/keypad.h           |    4 +
 arch/arm/plat-omap/include/mach/memory.h           |    3 +-
 arch/arm/plat-omap/include/mach/omap24xx.h         |   18 -
 arch/arm/plat-omap/include/mach/omap34xx.h         |   13 -
 arch/arm/plat-omap/include/mach/omap44xx.h         |   46 +
 arch/arm/plat-omap/include/mach/onenand.h          |   22 +-
 arch/arm/plat-omap/include/mach/serial.h           |   25 +-
 arch/arm/plat-omap/include/mach/sram.h             |    6 +-
 arch/arm/plat-omap/include/mach/usb.h              |    6 -
 arch/arm/plat-omap/include/mach/vmalloc.h          |    2 +-
 arch/arm/plat-omap/io.c                            |   29 +-
 arch/arm/plat-omap/mcbsp.c                         |   34 +-
 arch/arm/plat-omap/mux.c                           |    3 +
 arch/arm/plat-omap/sram.c                          |   66 +-
 drivers/mmc/host/omap_hsmmc.c                      |    6 +-
 drivers/mtd/onenand/omap2.c                        |    1 -
 drivers/video/omap/hwa742.c                        |   26 +-
 99 files changed, 9486 insertions(+), 1112 deletions(-)
 create mode 100644 arch/arm/configs/omap3_evm_defconfig
 create mode 100644 arch/arm/configs/omap_4430sdp_defconfig
 create mode 100644 arch/arm/configs/omap_zoom2_defconfig
 rename arch/arm/{plat-omap/include/mach => mach-omap1}/pm.h (76%)
 create mode 100644 arch/arm/mach-omap2/board-4430sdp.c
 create mode 100644 arch/arm/mach-omap2/board-omap3evm.c
 create mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 create mode 100644 arch/arm/mach-omap2/board-zoom2.c
 create mode 100644 arch/arm/mach-omap2/gpmc-onenand.c
 create mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
 create mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S
 create mode 100644 arch/arm/plat-omap/include/mach/gpmc-smc91x.h
 create mode 100644 arch/arm/plat-omap/include/mach/omap44xx.h

--+JUInw4efm7IfTNU--
