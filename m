From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5 v11] mfd: omap: usb: Runtime PM support for EHCI and OHCI drivers
Date: Thu, 22 Sep 2011 17:07:54 +0530
Message-ID: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The Hwmod structures and Runtime PM features are implemented
For EHCI and OHCI drivers of OMAP3 and OMAP4.
The global suspend/resume of EHCI and OHCI
is validated on OMAP3430 sdp board with these patches.

These patches are re-based to Kevin's pm branch :
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

TODO:
   - Adding pad configurations to Hwmods
   - Aggressive clock cutting in usb bus suspends
   - Remote Wakeup implementation using irq-chaining

Benoit Cousson (1):
  arm: omap: usb: ehci and ohci hwmod structures for omap4

Keshava Munegowda (4):
  arm: omap: usb: ehci and ohci hwmod structures for omap3
  arm: omap: usb: register hwmods of usbhs
  arm: omap: usb: device name change for the clk names of usbhs
  mfd: omap: usb: Runtime PM support

 arch/arm/mach-omap2/clock3xxx_data.c       |   26 +-
 arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  271 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  250 ++++++++++-
 arch/arm/mach-omap2/usb-host.c             |  116 ++---
 arch/arm/plat-omap/include/plat/usb.h      |    3 -
 drivers/mfd/omap-usb-host.c                |  733 +++++++++++-----------------
 drivers/usb/host/ehci-omap.c               |   17 +-
 drivers/usb/host/ohci-omap3.c              |   18 +-
 9 files changed, 883 insertions(+), 561 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
