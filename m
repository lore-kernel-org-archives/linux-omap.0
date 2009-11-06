From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 1/2] OMAP: update mach/usb.h to allow ehci driver to build
Date: Sat,  7 Nov 2009 01:15:59 +0530
Message-ID: <1257536759-15242-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40944 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759568AbZKFTqF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Nov 2009 14:46:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

OMAP: update mach/usb.h to allow ehci driver to build

Add missing declarations to allow the recently introduced
ehci-omap driver to build on OMAP3

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Tony says he's okay with this patch going through the linux-usb list.

This patch and the next one are required to build this driver.

I've based these patches on current Linus' tree plus your usb
patch queue (gregkh-07-usb-2.6.32-rc6.patch).

 arch/arm/plat-omap/include/mach/usb.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux-2.6/arch/arm/plat-omap/include/mach/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/mach/usb.h	2009-11-06 04:38:40.000000000 -0800
+++ linux-2.6/arch/arm/plat-omap/include/mach/usb.h	2009-11-06 04:38:47.000000000 -0800
@@ -5,6 +5,21 @@
 
 #include <mach/board.h>
 
+#define OMAP3_HS_USB_PORTS	3
+enum ehci_hcd_omap_mode {
+	EHCI_HCD_OMAP_MODE_UNKNOWN,
+	EHCI_HCD_OMAP_MODE_PHY,
+	EHCI_HCD_OMAP_MODE_TLL,
+};
+
+struct ehci_hcd_omap_platform_data {
+	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
+	unsigned			phy_reset:1;
+
+	/* have to be valid if phy_reset is true and portx is in phy mode */
+	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
+};
+
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -29,6 +44,8 @@
 
 extern void usb_musb_init(void);
 
+extern void usb_ehci_init(struct ehci_hcd_omap_platform_data *pdata);
+
 #endif
 
 void omap_usb_init(struct omap_usb_config *pdata);
