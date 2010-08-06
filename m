From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/8] usb: musb: Remove board_data parameter from musb_platform_init()
Date: Fri,  6 Aug 2010 21:26:19 +0530
Message-ID: <1281110179-3793-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36387 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab0HFP43 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 11:56:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Hema HK  <hemahk@ti.com>

Removed the board_data parameter being passed to musb_platform_init function 
as board data can be extracted from device structure which is already member of 
musb structure.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---

 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    2 +-
 drivers/usb/musb/musb_core.h |    2 +-
 drivers/usb/musb/omap2430.c  |    6 ++++--
 drivers/usb/musb/tusb6010.c  |    2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-omap-pm/drivers/usb/musb/blackfin.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/blackfin.c	2010-08-06 09:01:19.805863959 -0400
+++ linux-omap-pm/drivers/usb/musb/blackfin.c	2010-08-06 09:01:30.721863471 -0400
@@ -323,7 +323,7 @@
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 
 	/*
Index: linux-omap-pm/drivers/usb/musb/davinci.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/davinci.c	2010-08-06 09:01:19.821862599 -0400
+++ linux-omap-pm/drivers/usb/musb/davinci.c	2010-08-06 09:01:30.721863471 -0400
@@ -376,7 +376,7 @@
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	2010-08-06 09:01:25.530112841 -0400
+++ linux-omap-pm/drivers/usb/musb/musb_core.c	2010-08-06 09:01:30.721863471 -0400
@@ -2023,7 +2023,7 @@
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
 	musb->isr = generic_interrupt;
-	status = musb_platform_init(musb, plat->board_data);
+	status = musb_platform_init(musb);
 	if (status < 0)
 		goto fail2;
 
Index: linux-omap-pm/drivers/usb/musb/musb_core.h
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.h	2010-08-06 09:01:19.785863497 -0400
+++ linux-omap-pm/drivers/usb/musb/musb_core.h	2010-08-06 09:01:30.721863471 -0400
@@ -612,7 +612,7 @@
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __init musb_platform_init(struct musb *musb, void *board_data);
+extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
 #endif	/* __MUSB_CORE_H__ */
Index: linux-omap-pm/drivers/usb/musb/omap2430.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c	2010-08-06 09:01:19.793863369 -0400
+++ linux-omap-pm/drivers/usb/musb/omap2430.c	2010-08-06 09:01:30.721863471 -0400
@@ -189,10 +189,12 @@
 	return 0;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	u32 l;
-	struct omap_musb_board_data *data = board_data;
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
Index: linux-omap-pm/drivers/usb/musb/tusb6010.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/tusb6010.c	2010-08-06 09:01:19.813862848 -0400
+++ linux-omap-pm/drivers/usb/musb/tusb6010.c	2010-08-06 09:01:30.721863471 -0400
@@ -1091,7 +1091,7 @@
 	return -ENODEV;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
