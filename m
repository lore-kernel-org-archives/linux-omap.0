From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2][PATCH 00/11] omap2/3/4: uart4 fixes + zoom2/3 changes
Date: Mon,  8 Mar 2010 11:20:43 -0600
Message-ID: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39542 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab0CHRUB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 12:20:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

Hi,

This is v2 of my serial work series merge found here: [1]

And it's meant to be applied on top of Thomas's patch: [2]

Changelog compared to previous version:
 - Replaced hardcoded IRQ for UART4 in 3630 by newly created
   INT_36XX_UART4_IRQ define. (Thanks Kevin)

Please let me know your comments and thoughts.

Thanks to:
 - Vikram Pandita
 - Paul Walmsley
 - Kevin Hilman
 - Manjunath Kondaiah

For the feedback recieved so far. I really appreciate it.

Regards,
Sergio

Detailed changelog:

Sergio Aguirre (11):
  OMAP3: serial: Check for zero-based physical addr
  omap2/3/4: serial: Remove condition for getting uart4_phys
  ARM: OMAP3630: PRCM: Add UART4 control bits
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  OMAP3: Add UART4 IRQ for 36xx chips
  omap3: serial: Fix uart4 handling for 3630
  omap3: zoom2/3 / 3630sdp: Don't init always all uarts
  omap3: 3630sdp: Explicitly enable all UARTs
  omap3: zoom 2/3: Change debugboard serial port id
  omap3: zoom2/3: Register only 1 8250 port

 arch/arm/configs/omap_zoom2_defconfig        |    2 +-
 arch/arm/configs/omap_zoom3_defconfig        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c          |    1 +
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 arch/arm/mach-omap2/clock3xxx_data.c         |   22 +++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h        |    2 +
 arch/arm/mach-omap2/pm34xx.c                 |    8 ++++-
 arch/arm/mach-omap2/prcm-common.h            |    4 +++
 arch/arm/mach-omap2/serial.c                 |   33 +++++++++++++++-----------
 arch/arm/plat-omap/include/plat/irqs.h       |    2 +
 11 files changed, 59 insertions(+), 20 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c

[1] http://marc.info/?l=linux-omap&m=126762591626792&w=2
[2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2

