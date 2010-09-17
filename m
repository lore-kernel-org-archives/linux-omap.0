From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform
     support
Date: Fri, 17 Sep 2010 21:35:47 +0530 (IST)
Message-ID: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
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

This patch series is tested on mainline 2.6.36-rc4
and has dependencies on:

1) https://patchwork.kernel.org/patch/117148/
	This patch to support all hwmod data with proper structure name.

2) https://patchwork.kernel.org/patch/117347/
	This patch is needed to apply omap4 uart hwmods.

3) http://marc.info/?l=linux-omap&m=128403141221947&w=2
	This patch series is needed for omap4430SDP ES2.0 validation.


Benoit Cousson (1):
  OMAP4: UART: Add uart1-4 hwmods data for omap4

Govindraj.R (6):
  OMAP2: UART: remove set_uart_globals.
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  OMAP3: PM: Add prepare idle and resume idle call for uart4
  serial: Add OMAP high-speed UART driver
  OMAP: SERIAL: Enable omap-serial driver in Kconfig.

Kevin Hilman (4):
  OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
  OMAP: UART: omap_device converions, remove implicit 8520 assumptions
  OMAP: UART: don't do automatic bus-level suspend/resume
  OMAP: UART: use non-locking versions of hwmod enable/idle functions

 arch/arm/mach-omap2/Kconfig                   |   11 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |   22 +
 arch/arm/mach-omap2/cm-regbits-34xx.h         |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  193 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  193 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  253 +++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  235 +++++
 arch/arm/mach-omap2/pm34xx.c                  |   17 +-
 arch/arm/mach-omap2/prcm-common.h             |    5 +
 arch/arm/mach-omap2/prm-regbits-34xx.h        |    1 +
 arch/arm/mach-omap2/serial.c                  |  548 +++++-----
 arch/arm/plat-omap/common.c                   |   16 -
 arch/arm/plat-omap/include/plat/common.h      |    1 -
 arch/arm/plat-omap/include/plat/dma.h         |    2 +
 arch/arm/plat-omap/include/plat/irqs.h        |    2 +
 arch/arm/plat-omap/include/plat/omap-serial.h |  129 +++
 drivers/serial/Kconfig                        |   27 +
 drivers/serial/Makefile                       |    1 +
 drivers/serial/omap-serial.c                  | 1332 +++++++++++++++++++++++++
 include/linux/serial_core.h                   |    3 +
 20 files changed, 2699 insertions(+), 294 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
 create mode 100644 drivers/serial/omap-serial.c




