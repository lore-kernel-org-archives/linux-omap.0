From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] MUSB: Remove usb_musb_pm_init() call
Date: Mon, 24 Aug 2009 17:36:37 +0530
Message-ID: <1251115597-23096-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57516 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbZHXMGo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 08:06:44 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7OC6d0H006773
	for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 07:06:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

MUSB: Remove usb_musb_pm_init() call

In usb_musb_pm_init, we attempt to access an MUSB register
when the i-clock may not be on, or the module is otherwise
not accessible.

We need to either:
- enable the clock before this access, or
- remove this code and move it to the bootloader, or
- enable the clock in the bootloader

If we enable the clock in the bootloader, we might as well
add the workaround in the bootloader itself. This code will
anyway be changed once hwmod is in place, so remove it for now

This allows us to boot the kernel on certain OMAP3 boards with
a bootloader that doesn't enable this clock. Without this, we
will need to upgrade the bootloaders on these boards.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   12 ------------
 1 files changed, 12 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
@@ -31,15 +31,6 @@
 #include <mach/mux.h>
 #include <mach/usb.h>
 
-#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
-
-static void __init usb_musb_pm_init(void)
-{
-	/* Ensure force-idle mode for OTG controller */
-	if (cpu_is_omap34xx())
-		omap_writel(0, OTG_SYSCONFIG);
-}
-
 #ifdef CONFIG_USB_MUSB_SOC
 
 static struct resource musb_resources[] = {
@@ -194,13 +185,10 @@ void __init usb_musb_init(void)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
 	}
-
-	usb_musb_pm_init();
 }
 
 #else
 void __init usb_musb_init(void)
 {
-	usb_musb_pm_init();
 }
 #endif /* CONFIG_USB_MUSB_SOC */
