From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
Date: Fri, 12 Mar 2010 14:00:02 -0600
Message-ID: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55076 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757190Ab0CLT6u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 14:58:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

Hi,

This series contains fixes for omap2/3/4 serial code, and are
fixing:
 - Avoid doing ioremapp of a zero-based physical address.
   (causing a kernel panic during early init on 3630boards)
 - Unproper omap_revision check during uart globals setup.
   (omap_revision is not yet filled at that point)
 - Don't try to enable all uarts generically for zoom2/3
   and 3630sdp.
 - Make zoom2/3 just register one serial port (ttyS0).

This is a subset of the original series found here: [1]

Thanks to:
 - Vikram Pandita
 - Paul Walmsley
 - Kevin Hilman
 - Manjunath Kondaiah
 - Felipe Balbi
 - Tony Lindgreen

For all the feedback recieved so far.

Regards,
Sergio

Sergio Aguirre (7):
  OMAP3: serial: Check for zero-based physical addr
  OMAP3: serial: Use dev_* macros instead of printk
  omap2/3/4: serial: Remove condition for getting uart4_phys
  omap3: zoom2/3 / 3630sdp: Don't init always all uarts
  omap3: 3630sdp: Explicitly enable all UARTs
  omap3: zoom 2/3: Change debugboard serial port id
  omap3: zoom2/3: Register only 1 8250 port

 arch/arm/configs/omap_zoom2_defconfig        |    2 +-
 arch/arm/configs/omap_zoom3_defconfig        |    2 +-
 arch/arm/mach-omap2/board-3630sdp.c          |    1 +
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
 arch/arm/mach-omap2/serial.c                 |   35 +++++++++++++------------
 6 files changed, 22 insertions(+), 21 deletions(-)

[1] http://marc.info/?l=linux-omap&m=126826639903105&w=2

