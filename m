From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resending - PATCH 1/3] Triton BCI driver device setup for OMAP3430
Date: Thu, 3 Jul 2008 17:35:50 +0530 (IST)
Message-ID: <44944.192.168.10.88.1215086750.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37465 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbYGCMGo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2008 08:06:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, me@felipebalbi.com

Hi Tony,

I am resending the BCI patch series after fixing the comments provided by Filipe.

Regards,
Madhu
-------------------------------------------------------------------------

From: Madhusudhan Chikkature<madhu.cr@ti.com>

Device setup/initialization for the Triton battery charger interface driver for
the OMAP3430 SDP.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    3 +-
 arch/arm/mach-omap2/bci.c                 |   34 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c       |    1
 include/asm-arm/arch-omap/board-3430sdp.h |    1
 4 files changed, 38 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2008-07-03
16:58:02.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2008-07-03 16:58:30.000000000
+0530
@@ -47,7 +47,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= boar
 					   hsmmc.o \
 					   usb-musb.o \
 					   usb-ehci.o \
-					   board-3430sdp-flash.o
+					   board-3430sdp-flash.o \
+					   bci.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   hsmmc.o \
 					   usb-musb.o usb-ehci.o \
Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-07-03
16:58:02.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-07-03
16:58:30.000000000 +0530
@@ -299,6 +299,7 @@ static void __init omap_3430sdp_init(voi
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	sdp3430_flash_init();
+	twl4030_bci_battery_init();
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init();
Index: linux-omap-2.6/include/asm-arm/arch-omap/board-3430sdp.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/board-3430sdp.h	2008-07-03
16:58:02.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/board-3430sdp.h	2008-07-03
16:58:30.000000000 +0530
@@ -31,6 +31,7 @@

 extern void sdp3430_usb_init(void);
 extern void sdp3430_flash_init(void);
+extern void twl4030_bci_battery_init(void);

 #define DEBUG_BASE			0x08000000  /* debug board */

Index: linux-omap-2.6/arch/arm/mach-omap2/bci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/bci.c	2008-07-03 16:59:40.000000000 +0530
@@ -0,0 +1,34 @@
+/*
+ * linux/arch/arm/mach-omap2/board-3430sdp-bci.c
+ *
+ * TWL4030 BCI platform device setup/initialization
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#if defined(CONFIG_TWL4030_BCI_BATTERY) || \
+	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
+
+static struct platform_device twl4030_bci_battery_device = {
+	.name           = "twl4030-bci-battery",
+	.id             = 1,
+	.num_resources  = 0,
+};
+
+void __init twl4030_bci_battery_init(void)
+{
+	(void) platform_device_register(&twl4030_bci_battery_device);
+}
+#else
+void __init twl4030_bci_battery_init(void)
+{
+}
+#endif


