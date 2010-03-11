From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 1/3] USB: MUSB: Set transceiver interface type
Date: Thu, 11 Mar 2010 17:26:25 +0530
Message-ID: <1268308585-21604-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757614Ab0CKL4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 06:56:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@mvista.com>, Olof Johansson <olof@lixom.net>

Program the OTG_INTERFSEL register based on
transcevier type passed from board file.

Adapt signature of musb_platform_init() function
for davinci, blackfin and tusb6010.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Olof Johansson <olof@lixom.net>
---
 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    2 +-
 drivers/usb/musb/musb_core.h |    2 +-
 drivers/usb/musb/omap2430.c  |   13 +++++++++++--
 drivers/usb/musb/tusb6010.c  |    2 +-
 6 files changed, 16 insertions(+), 7 deletions(-)

Index: mainline/drivers/usb/musb/blackfin.c
===================================================================
--- mainline.orig/drivers/usb/musb/blackfin.c
+++ mainline/drivers/usb/musb/blackfin.c
@@ -277,7 +277,7 @@ int musb_platform_set_mode(struct musb *
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb, void *board_data)
 {
 
 	/*
Index: mainline/drivers/usb/musb/davinci.c
===================================================================
--- mainline.orig/drivers/usb/musb/davinci.c
+++ mainline/drivers/usb/musb/davinci.c
@@ -377,7 +377,7 @@ int musb_platform_set_mode(struct musb *
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb, void *board_data)
 {
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
Index: mainline/drivers/usb/musb/musb_core.c
===================================================================
--- mainline.orig/drivers/usb/musb/musb_core.c
+++ mainline/drivers/usb/musb/musb_core.c
@@ -1948,7 +1948,7 @@ bad_config:
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
 	musb->isr = generic_interrupt;
-	status = musb_platform_init(musb);
+	status = musb_platform_init(musb, plat->board_data);
 
 	if (status < 0)
 		goto fail;
Index: mainline/drivers/usb/musb/musb_core.h
===================================================================
--- mainline.orig/drivers/usb/musb/musb_core.h
+++ mainline/drivers/usb/musb/musb_core.h
@@ -608,7 +608,7 @@ extern int musb_platform_get_vbus_status
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __init musb_platform_init(struct musb *musb);
+extern int __init musb_platform_init(struct musb *musb, void *board_data);
 extern int musb_platform_exit(struct musb *musb);
 
 #endif	/* __MUSB_CORE_H__ */
Index: mainline/drivers/usb/musb/omap2430.c
===================================================================
--- mainline.orig/drivers/usb/musb/omap2430.c
+++ mainline/drivers/usb/musb/omap2430.c
@@ -200,9 +200,10 @@ int musb_platform_set_mode(struct musb *
 	return 0;
 }
 
-int __init musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb, void *board_data)
 {
 	u32 l;
+	struct omap_musb_board_data *data = board_data;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
@@ -236,7 +237,15 @@ int __init musb_platform_init(struct mus
 	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
 
 	l = musb_readl(musb->mregs, OTG_INTERFSEL);
-	l |= ULPI_12PIN;
+
+	if (data->interface_type == MUSB_INTERFACE_UTMI) {
+		/* OMAP4 uses Internal PHY GS70 which uses UTMI interface */
+		l &= ~ULPI_12PIN;       /* Disable ULPI */
+		l |= UTMI_8BIT;         /* Enable UTMI  */
+	} else {
+		l |= ULPI_12PIN;
+	}
+
 	musb_writel(musb->mregs, OTG_INTERFSEL, l);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
Index: mainline/drivers/usb/musb/tusb6010.c
===================================================================
--- mainline.orig/drivers/usb/musb/tusb6010.c
+++ mainline/drivers/usb/musb/tusb6010.c
@@ -1091,7 +1091,7 @@ err:
 	return -ENODEV;
 }
 
-int __init musb_platform_init(struct musb *musb)
+int __init musb_platform_init(struct musb *musb, void *board_data)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
