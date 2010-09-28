From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Tue, 28 Sep 2010 11:24:43 -0700
Message-ID: <8762xpenf8.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61977 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab0I1SYp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 14:24:45 -0400
Received: by pxi10 with SMTP id 10so1775191pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 11:24:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha Varadarajan <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj R." <govindraj.raja@ti.com>

Tony,

The following pull request will bring hwmod driver conversions for
watchdog, UART and i2c drivers.  It is based on your omap-for-linus
branch.

The i2c driver is waiting for final signoff/ack from the upstream
subsystem maintainers, but are otherwise ready to go for broader
testing.  After I get the final ack, I will update the branch for a
final pull.

In the meantime, I'd like to get them into l-o master (or omap-testing)
for broader testing.

Note this also depends on a handful of patches from my pm-backports
branch, most of which you have picked into omap-testing, except for the
one I just posted to linux-arm-kernel:

   ARM: add cpu_idle_wait() to support CPUidle on SMP systems.

This one is required now that the default config enables SMP.

Charu, Rajendra, Govindraj, since all of the hwmod data changes touch
the same files, pulling these together meant I had to manually merge
these together.  Please do a sanity check of the resulting merge.
Thanks.

Kevin


The following changes since commit b6a26b4b87d7b030a546e7bdaf390ffc58323f36:

  omap3: cm-t3517: add support for TI HECC (2010-09-27 15:15:35 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-hwmods

Benoit Cousson (3):
      OMAP4: hwmod data: Add watchdog timer
      OMAP4: UART: Add uart1-4 hwmods data for omap4
      OMAP4: hwmod: add I2C hwmods for OMAP4430

Govindraj.R (8):
      OMAP2: UART: remove set_uart_globals
      OMAP clock: Add uart4_ick/fck definitions for 3630
      OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
      OMAP3: PM: Add prepare idle and resume idle call for uart4
      OMAP3: serial: Fix uart4 handling for 3630
      serial: Add OMAP high-speed UART driver
      OMAP: SERIAL: Enable omap-serial driver in Kconfig
      OMAP3: SERIAL: Initialize all omap-uarts for zoom boards

Kevin Hilman (7):
      OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
      OMAP: UART: omap_device conversions, remove implicit 8520 assumptions
      OMAP: UART: don't do automatic bus-level suspend/resume
      OMAP: UART: use non-locking versions of hwmod enable/idle functions
      Merge branch 'pm-hwmod-wdog' into pm-hwmods
      manual merge for pm-hwmod-uart due to conflicts
      manual merge for pm-hwmod-i2c due to conflicts

Paul Walmsley (2):
      OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
      OMAP: I2C: split device registration and convert OMAP2+ to omap_device

Rajendra Nayak (2):
      OMAP3: hwmod: add I2C hwmods for OMAP3430
      OMAP: I2C: Convert i2c driver to use PM runtime api's

Varadarajan, Charulatha (5):
      OMAP3: hwmod data: Add watchdog timer
      OMAP2420: hwmod data: Add watchdog timer
      OMAP2430: hwmod data: Add watchdog timer
      OMAP: WDT: Split OMAP1 and OMAP2PLUS device registration
      OMAP: WDT: Use PM runtime APIs instead of clk FW APIs

 arch/arm/mach-omap1/devices.c                 |   27 +
 arch/arm/mach-omap2/Kconfig                   |   11 +-
 arch/arm/mach-omap2/board-3630sdp.c           |    1 -
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c          |   22 +
 arch/arm/mach-omap2/cm-regbits-24xx.h         |    4 +
 arch/arm/mach-omap2/cm-regbits-34xx.h         |    2 +
 arch/arm/mach-omap2/devices.c                 |   39 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  397 ++++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  410 ++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  549 ++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  605 +++++++++++
 arch/arm/mach-omap2/pm34xx.c                  |   17 +-
 arch/arm/mach-omap2/prcm-common.h             |    5 +
 arch/arm/mach-omap2/prm-regbits-34xx.h        |    4 +
 arch/arm/mach-omap2/serial.c                  |  555 ++++++-----
 arch/arm/plat-omap/common.c                   |   16 -
 arch/arm/plat-omap/devices.c                  |   41 -
 arch/arm/plat-omap/i2c.c                      |  124 +--
 arch/arm/plat-omap/include/plat/common.h      |    1 -
 arch/arm/plat-omap/include/plat/dma.h         |    2 +
 arch/arm/plat-omap/include/plat/i2c.h         |   13 +
 arch/arm/plat-omap/include/plat/irqs.h        |    2 +
 arch/arm/plat-omap/include/plat/l4_3xxx.h     |   24 +
 arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
 drivers/i2c/busses/i2c-omap.c                 |   69 +-
 drivers/serial/Kconfig                        |   27 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1333 +++++++++++++++++++++++++
 drivers/watchdog/omap_wdt.c                   |   42 +-
 include/linux/i2c-omap.h                      |    5 +
 include/linux/serial_core.h                   |    3 +
 32 files changed, 3984 insertions(+), 497 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c
