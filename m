From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/7] usb: otg: TWL6030: OMAP4430: musb & transceiver driver support for OMAP4
Date: Wed,  8 Dec 2010 21:30:37 +0530
Message-ID: <1291824037-6972-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch series has the support for TWL6030-usb
transceiver driver and changes in the musb driver to make it functional
with OMAP4430.

OMAP4 musb support UTMI and ULPI transceiver interfaces.

In UTMI mode, the transceiver functionality is split between
the TWL6030 PMIC chip and OMAP4 embedded PHY.
The TWL6030 transceiver driver code is under otg folder and
internal UTMI PHY specific code changes are defined under
mach-omap2 directory and functions are passed through platform_data
structure.

This patch series is based on V2.6.37-rc4 + [1]+[2]+[3]+[4]. 

[1] http://www.listware.net/201011/linux-usb/
65625-patch-resend-v3-usb-musb-do-not-use-dma-for-control-transfers.html

[2] http://www.spinics.net/lists/linux-usb/msg37105.html

[3] http://permalink.gmane.org/gmane.linux.usb.general/37123

[4] Felipe's musb-reorg patch series.
	http://gitorious.org/usb/usb/commits/musb-hw

Tested musb device and host mode functionality with OMAP4430SDP
and OMAP3630 ZOOM3.

Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

Hema HK (7):
  mfd: TWL6030: USBOTG VBUS event generation on charger VBUS events.
  usb: otg: Adding twl6030-usb transceiver driver for OMAP4430 musb
  usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
  mfd: TWL6030: OMAP4: Registering the TWL6030-usb device
  usb: musb: TWL6030: Selecting TWL6030_USB transceiver for OMAP4
  usb: musb: Adding musb support for OMAP4430
  arm: OMAP4430: musb: Enable musb device initialization for OMAP4430

 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-4430sdp.c     |   15 +-
 arch/arm/mach-omap2/board-omap4panda.c  |    9 +-
 arch/arm/mach-omap2/omap_phy_internal.c |  123 +++++++
 arch/arm/plat-omap/include/plat/usb.h   |    4 +
 drivers/mfd/twl-core.c                  |   44 +++-
 drivers/mfd/twl6030-irq.c               |    9 +-
 drivers/usb/musb/Kconfig                |    1 +
 drivers/usb/musb/musb_core.c            |    5 +
 drivers/usb/musb/musb_core.h            |    1 +
 drivers/usb/musb/musb_gadget.c          |    1 +
 drivers/usb/musb/omap2430.c             |   85 +++++-
 drivers/usb/otg/Kconfig                 |   11 +
 drivers/usb/otg/Makefile                |    1 +
 drivers/usb/otg/twl6030-usb.c           |  527 +++++++++++++++++++++++++++++++
 include/linux/i2c/twl.h                 |    6 +
 16 files changed, 824 insertions(+), 19 deletions(-)
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
