From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6 v3] usb: musb: Adding support for ti81xx
Date: Fri, 9 Sep 2011 19:17:44 +0530
Message-ID: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch set adds support for musb interface for TI81XX platforms and
are dependent on recent patch series from Hemant Pedanekar at [1] and [2].

TI81XX platform has dual musb instances, uses CPPI4.1 DMA and has built in
usb PHY. The current set of patches supports only the first interface and
in PIO mode.

[1] http://marc.info/?l=linux-omap&m=131247989220300&w=2 
[2] http://marc.info/?l=linux-omap&m=131411961308438&w=2

Changes from v2:
	- Fixed a typo in patch 3/6
	- Used kmemdup for wrapper structure pointer in patch 6/6

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
 drivers/usb/musb/musb_dsps.c               |  693 ++++++++++++++++++++++++++++
 10 files changed, 854 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/musb/musb_dsps.c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
