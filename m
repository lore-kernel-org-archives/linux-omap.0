From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resending - PATCH 1/3] Triton BCI driver board/device setup for
     OMAP3430
Date: Tue, 22 Jul 2008 17:25:33 +0530 (IST)
Message-ID: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:57972 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbYGVLzo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2008 07:55:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

From: Madhusudhan Chikkature<madhu.cr@ti.com>

Device setup/board level initialization for the Triton battery charger
interface driver for the OMAP3430 SDP.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 arch/arm/mach-omap2/Makefile              |    3 +
 arch/arm/mach-omap2/bci.c                 |   57 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp.c       |    1
 include/asm-arm/arch-omap/bci.h           |   17 ++++++++
 include/asm-arm/arch-omap/board-3430sdp.h |    1
 5 files changed, 78 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2008-07-22
11:58:54.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2008-07-22 12:01:10.000000000
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
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-07-22
11:58:54.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-07-22
12:01:10.000000000 +0530
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
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/board-3430sdp.h	2008-07-22
11:58:54.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/board-3430sdp.h	2008-07-22
12:01:10.000000000 +0530
@@ -31,6 +31,7 @@

 extern void sdp3430_usb_init(void);
 extern void sdp3430_flash_init(void);
+extern void twl4030_bci_battery_init(void);

 #define DEBUG_BASE			0x08000000  /* debug board */

Index: linux-omap-2.6/arch/arm/mach-omap2/bci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/bci.c	2008-07-22 12:02:39.000000000 +0530
@@ -0,0 +1,57 @@
+/*
+ * linux/arch/arm/mach-omap2/bci.c
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
+#include <asm/arch/bci.h>
+
+#if defined(CONFIG_TWL4030_BCI_BATTERY) || \
+	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
+/*
+ * Thermistor Calibration for Current Source and MADC
+ * Tolerance (for THS05-3H103F)
+ */
+static int sdp3430_batt_table[] = {
+/* 0 C*/
+30800, 29500, 28300, 27100,
+26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
+17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
+11600, 11200, 10800, 10400, 10000, 9630,   9280,   8950,   8620,   8310,
+8020,   7730,   7460,   7200,   6950,   6710,   6470,   6250,   6040,   5830,
+5640,   5450,   5260,   5090,   4920,   4760,   4600,   4450,   4310,   4170,
+4040,   3910,   3790,   3670,   3550
+};
+
+static struct twl4030_bci_platform_data sdp3430_bci_data = {
+      .battery_tmp_tbl = sdp3430_batt_table,
+      .tblsize = ARRAY_SIZE(sdp3430_batt_table),
+};
+
+static struct platform_device twl4030_bci_battery_device = {
+	.name           = "twl4030-bci-battery",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &sdp3430_bci_data,
+	},
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
Index: linux-omap-2.6/include/asm-arm/arch-omap/bci.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/include/asm-arm/arch-omap/bci.h	2008-07-22
12:01:10.000000000 +0530
@@ -0,0 +1,17 @@
+/*
+ *  linux/include/asm-arm/arch-omap/bci.h
+ *
+ *  Copyright (C) 2008 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASMARM_ARCH_BCI_H
+#define ASMARM_ARCH_BCI_H
+struct twl4030_bci_platform_data {
+	int *battery_tmp_tbl;
+	unsigned int tblsize;
+};
+#endif
+


