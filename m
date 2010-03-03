From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge][PATCH 00/10] omap2/3/4: uart4 fixes + zoom2/3 changes
Date: Wed,  3 Mar 2010 08:18:35 -0600
Message-ID: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab0CCOSd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 09:18:33 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23EIX4p009658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:18:33 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Hi,

This is a merge of my previously posted RFC series [1] and [2],
and is meant to be applied on top of Thomas's Patch [3].

Changelog compared to previous versions:
 - Series merged, as mentioned above.
 - Dropped omap_serial_init rename.
 - Added patch for zoom2/3 defconfig to init only one port.

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

Sergio Aguirre (10):
  OMAP3: serial: Check for zero-based physical addr
  omap2/3/4: serial: Remove condition for getting uart4_phys
  ARM: OMAP3630: PRCM: Add UART4 control bits
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
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
 arch/arm/mach-omap2/clock3xxx_data.c         |   22 ++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h        |    2 +
 arch/arm/mach-omap2/pm34xx.c                 |    8 ++++-
 arch/arm/mach-omap2/prcm-common.h            |    4 +++
 arch/arm/mach-omap2/serial.c                 |   34 +++++++++++++++----------
 10 files changed, 58 insertions(+), 20 deletions(-)
 mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c
 mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c

[1] http://marc.info/?l=linux-omap&m=126730356232287&w=2
[2] http://marc.info/?l=linux-omap&m=126746974103007&w=2
[3] http://marc.info/?l=linux-kernel&m=126709078514087&w=2

