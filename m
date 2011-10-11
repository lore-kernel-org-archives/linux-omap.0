From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/8 v4] usb: musb: Adding support for ti81xx and am335x
Date: Tue, 11 Oct 2011 16:56:01 +0530
Message-ID: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch set adds support for musb interface for TI81XX and AM33XX
platforms and are dependent on recent patch series from Hemant Pedanekar
at [1] and [2] and Vaibhav Hiremath at [3]

TI81XX and AM33XX platform has dual musb instances, uses CPPI4.1 DMA and
has built in usb PHY. The current set of patches supports only the first
interface and in PIO mode.

[1] http://marc.info/?l=linux-omap&m=131411961308438&w=2
[2] http://marc.info/?l=linux-omap&m=131821081227729&w=2
[3] http://marc.info/?l=linux-omap&m=131652916305543&w=2

Changes from v3 for TI81xx:
	- Dropped hwmod data patch as that will be submitted along with
	  Hemant's hwmod baseport patches.
	- Added ioremap and iounmap for accessing SCM register
Changes from v1 for AM33xx:
	- Used cpu_is_am33xx() instead of cpu_is_am335x() to cover wider
	  wider range of devices.
	- Removed unneeded parens. 

Ajay Kumar Gupta (4):
  omap: musb: ti81xx: Add phy power function
  arm: omap: am335x: enable phy controls
  usb: musb: enable support for am335x
  am335xevm: Add support for musb interface

Ravi Babu (4):
  omap: musb: Adding support for ti81xx
  ti816evm: Add support for musb interface
  ti814evm: Add support for musb interface
  usb: musb: Add support for ti81xx platform

 arch/arm/mach-omap2/board-am335xevm.c   |    9 +
 arch/arm/mach-omap2/board-ti8148evm.c   |    9 +
 arch/arm/mach-omap2/board-ti8168evm.c   |    9 +
 arch/arm/mach-omap2/omap_phy_internal.c |   42 ++
 arch/arm/mach-omap2/usb-musb.c          |    3 +
 arch/arm/plat-omap/include/plat/usb.h   |   32 ++
 drivers/usb/musb/Kconfig                |    6 +
 drivers/usb/musb/Makefile               |    1 +
 drivers/usb/musb/musb_core.c            |    4 +-
 drivers/usb/musb/musb_dsps.c            |  693 +++++++++++++++++++++++++++++++
 10 files changed, 807 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/musb/musb_dsps.c

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
