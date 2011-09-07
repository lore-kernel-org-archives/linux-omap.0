From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 0/6 v2] usb: musb: Adding support for ti81xx
Date: Wed, 7 Sep 2011 22:32:19 +0530
Message-ID: <1315414945-19829-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55959 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab1IGRCi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 13:02:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

This patch set adds support for musb interface for TI81XX platforms and
are dependent on recent patch series from Hemant Pedanekar at [1] and [2].

TI81XX platform has dual musb instances, uses CPPI4.1 DMA and has built in
usb PHY. The current set of patches supports only the first interface and
in PIO mode.

[1] http://marc.info/?l=linux-omap&m=131247989220300&w=2 
[2] http://marc.info/?l=linux-omap&m=131411961308438&w=2

Changes from v1:
	- cleaned up #ifdefs of CONFIG_USB_MUSB_HDRC_HCD
	  and CONFIG_USB_GADGET_MUSB_HDRC
	- Fixed the full name of author
	- Renamed ti81xx.c to musb_dsps.c
	- Used platform_device_id table
	- created dsps_glue_wrapper structure and used the same

Ajay Kumar Gupta (1):
  omap: musb: ti81xx: Add phy power function

Ravi Babu (5):
  omap: musb: Adding hwmod data for ti81xx
  omap: musb: Adding support for ti81xx
  ti816evm: Add support for musb interface
  ti814evm: Add support for musb interface
  usb: musb: Add support for ti81xx platform

 arch/arm/mach-omap2/board-ti8148evm.c      |    9 +
 arch/arm/mach-omap2/board-ti8168evm.c      |    9 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |   74 +++
 arch/arm/mach-omap2/omap_phy_internal.c    |   24 +
 arch/arm/mach-omap2/usb-musb.c             |    3 +
 arch/arm/plat-omap/include/plat/usb.h      |   32 ++
 drivers/usb/musb/Kconfig                   |    6 +
 drivers/usb/musb/Makefile                  |    1 +
 drivers/usb/musb/musb_core.c               |    4 +-
 drivers/usb/musb/musb_dsps.c               |  684 ++++++++++++++++++++++++++++
 10 files changed, 845 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/musb/musb_dsps.c

