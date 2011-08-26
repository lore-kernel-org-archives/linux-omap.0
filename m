From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/6] TI81XX: musb support
Date: Fri, 26 Aug 2011 16:41:42 +0530
Message-ID: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
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

Ajay Kumar Gupta (1):
  omap: musb: ti81xx: Add phy power function

Ravi B (5):
  omap: musb: Adding hwmod data for ti81xx
  omap: musb: Adding support for ti816x
  ti816evm: Add support for musb interface
  ti814evm: Add support for musb interface
  usb: musb: Add support for ti81xx platform

 arch/arm/mach-omap2/board-ti8148evm.c      |   15 +
 arch/arm/mach-omap2/board-ti8168evm.c      |   15 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |   74 ++++
 arch/arm/mach-omap2/omap_phy_internal.c    |   24 +
 arch/arm/mach-omap2/usb-musb.c             |    3 +
 arch/arm/plat-omap/include/plat/usb.h      |   32 ++
 drivers/usb/musb/Kconfig                   |    6 +
 drivers/usb/musb/Makefile                  |    1 +
 drivers/usb/musb/musb_core.c               |    4 +-
 drivers/usb/musb/ti81xx.c                  |  637 ++++++++++++++++++++++++++++
 10 files changed, 810 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/musb/ti81xx.c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
