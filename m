From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 00/13 v3] OMAP: Serial: Add omap-serial driver with
     platform support
Date: Mon, 27 Sep 2010 20:19:11 +0530 (IST)
Message-ID: <43448.10.24.255.17.1285598951.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds a serial driver to handle uarts on omap platforms.
Currenlty omap-uarts are handled with 8250 driver, since updating
this driver with omap specific features will over load
the 8250 driver with all omap-specific data thus a new driver
is added to configure and support features like
dma, h/w, s/w flowcontrol for omap-uarts.
Also the patch series updates various low level platform specific
serial data to support omap-uarts with hwmod framework and adds support
for uart4 on OMAP3630.

Patch series applies cleanly on pm-core branch on kevins PM tree.
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;
a=shortlog;h=refs/heads/pm-core

Patch series Testing Status Update:
-----------------------------------
OMAP4:(SDP): Boot tested with ttyO* and ttyS* interfaces using this patch series.

OMAP2(2430SDP): Boot tested with ttyO* and ttyS* interfaces using this patch series.
		(Couldn't test pm functionality here due to board shortage).

OMAP3:(3430/3630SDP, ZOOM2/3):
Boot tested for console with ttyS* and ttyO* interfaces.
PM functionality checked omap3:
1) ret count: debugfs mounted sleep_while_idle enabled, checked for ret count
   values to increment this was done by setting sysfs timeout for all uarts.
   Also checked by unsetting uart sysfs timeout to check ret count
   stopped incrementing.
2) core off count: debugfs mounted sleep_while_idle and enable_off_mode enabled
   checked for core_off count to increment for core/per_pwrdm.
3) Susupend: Done using echo mem > /sys/power/state.
   Ensured no difference in behaviour with and without this patch series.

v2 to v3 changes:
-----------------
1) Minor changes with omap-serial
	https://patchwork.kernel.org/patch/199652/
2) Undo the timeout macro modification done by mistake.
	https://patchwork.kernel.org/patch/199642/
3) update description log for patch:
	OMAP3: SERIAL: Initialize all omap-uarts for zoom boards
	https://patchwork.kernel.org/patch/199672/

v1 to v2 changes:
-----------------
1) Incorporate timeout check
       http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35106.html
2) Add wk_st, padconf etc for uart4
       http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35105.html

Benoit Cousson (1):
  OMAP4: UART: Add uart1-4 hwmods data for omap4

Govindraj.R (8):
  OMAP2: UART: remove set_uart_globals.
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  OMAP3: PM: Add prepare idle and resume idle call for uart4
  OMAP3: serial: Fix uart4 handling for 3630
  serial: Add OMAP high-speed UART driver
  OMAP: SERIAL: Enable omap-serial driver in Kconfig.
  OMAP3: SERIAL: Initialize all omap-uarts for zoom boards

Kevin Hilman (4):
  OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
  OMAP: UART: omap_device converions, remove implicit 8520 assumptions
  OMAP: UART: don't do automatic bus-level suspend/resume
  OMAP: UART: use non-locking versions of hwmod enable/idle functions

 arch/arm/mach-omap2/Kconfig                   |   11 +-
 arch/arm/mach-omap2/board-3630sdp.c           |    1 -
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c          |   22 +
 arch/arm/mach-omap2/cm-regbits-34xx.h         |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  193 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  193 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  253 +++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  235 +++++
 arch/arm/mach-omap2/pm34xx.c                  |   17 +-
 arch/arm/mach-omap2/prcm-common.h             |    5 +
 arch/arm/mach-omap2/prm-regbits-34xx.h        |    1 +
 arch/arm/mach-omap2/serial.c                  |  555 ++++++-----
 arch/arm/plat-omap/common.c                   |   16 -
 arch/arm/plat-omap/include/plat/common.h      |    1 -
 arch/arm/plat-omap/include/plat/dma.h         |    2 +
 arch/arm/plat-omap/include/plat/irqs.h        |    2 +
 arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
 drivers/serial/Kconfig                        |   27 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1333 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 22 files changed, 2707 insertions(+), 296 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c


