From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 00/13 v2] OMAP: Serial: Add omap-serial driver with
     platform support
Date: Wed, 22 Sep 2010 20:43:10 +0530 (IST)
Message-ID: <37596.172.24.137.131.1285168390.squirrel@dbdmail.itg.ti.com>
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

v1 to v2 changes:
----------------
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
 arch/arm/mach-omap2/serial.c                  |  557 ++++++-----
 arch/arm/plat-omap/common.c                   |   16 -
 arch/arm/plat-omap/include/plat/common.h      |    1 -
 arch/arm/plat-omap/include/plat/dma.h         |    2 +
 arch/arm/plat-omap/include/plat/irqs.h        |    2 +
 arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
 drivers/serial/Kconfig                        |   27 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1332 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 22 files changed, 2707 insertions(+), 297 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c



