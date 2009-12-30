From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 2/2] ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file
Date: Wed, 30 Dec 2009 19:56:38 +0530
Message-ID: <1262183198-14854-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbZL3O1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 09:27:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Greg Kroah-Hartman <gregkh@suse.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

ARM : OMAP4 : Add USB support to 4430 SDP board file

This patch adds support for Mentor USB to 4430 SDP board file.

It also defines the base address for HS USB OTG controller in OMAP4.

Also updates platform specfic structure with base address and IRQ details.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <david-b@pacbell.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Index: felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- felipe_musb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ felipe_musb/arch/arm/mach-omap2/board-4430sdp.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -27,6 +28,7 @@
 #include <plat/common.h>
 #include <plat/control.h>
 #include <plat/timer-gp.h>
+#include <plat/usb.h>
 #include <asm/hardware/gic.h>
 
 static struct platform_device sdp4430_lcd_device = {
@@ -73,11 +75,21 @@ static void __init omap_4430sdp_init_irq
 	omap_gpio_init();
 }
 
+static struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_UTMI,
+	.mode			= MUSB_PERIPHERAL,
+	.power			= 100,
+};
 
 static void __init omap_4430sdp_init(void)
 {
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
+#ifdef CONFIG_NOP_USB_XCEIV
+	/* OMAP4 SDP uses Internal transceiver so register nop transceiver */
+	usb_nop_xceiv_register();
+#endif
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init omap_4430sdp_map_io(void)
Index: felipe_musb/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- felipe_musb.orig/arch/arm/mach-omap2/usb-musb.c
+++ felipe_musb/arch/arm/mach-omap2/usb-musb.c
@@ -79,8 +79,13 @@ void __init usb_musb_init(struct omap_mu
 {
 	if (cpu_is_omap243x())
 		musb_resources[0].start = OMAP243X_HS_BASE;
-	else
+	else if (cpu_is_omap34xx())
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+	else if (cpu_is_omap44xx()) {
+		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
+		musb_resources[1].start = INT_44XX_HS_USB_MC;
+		musb_resources[2].start = INT_44XX_HS_USB_DMA;
+	}
 	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
Index: felipe_musb/arch/arm/plat-omap/include/plat/omap44xx.h
===================================================================
--- felipe_musb.orig/arch/arm/plat-omap/include/plat/omap44xx.h
+++ felipe_musb/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -43,6 +43,7 @@
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
+#define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
