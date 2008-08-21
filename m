From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] Enable TWL4030 BCI for LDP platform
Date: Thu, 21 Aug 2008 21:45:02 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870229E813B9@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870229E813AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35577 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYHUQUe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 12:20:34 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7LGF804030242
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 11:15:14 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870229E813AB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Add TWL4030 BCI Battery for 3430 LDP platform

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/Makefile                |    1 +
 arch/arm/mach-omap2/board-ldp.c             |    2 ++
 arch/arm/plat-omap/include/mach/board-ldp.h |    2 ++
 drivers/power/Kconfig                       |    2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

Index: base-tony/arch/arm/mach-omap2/Makefile
===================================================================
--- base-tony.orig/arch/arm/mach-omap2/Makefile	2008-08-21 15:06:23.000000000 +0530
+++ base-tony/arch/arm/mach-omap2/Makefile	2008-08-21 21:22:15.000000000 +0530
@@ -66,6 +66,7 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= boar
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 					   hsmmc.o \
+					   bci.o \
 					   usb-musb.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
Index: base-tony/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- base-tony.orig/arch/arm/mach-omap2/board-ldp.c	2008-08-21 21:08:31.000000000 +0530
+++ base-tony/arch/arm/mach-omap2/board-ldp.c	2008-08-21 21:20:37.000000000 +0530
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <mach/board-ldp.h>
 #include <mach/mcspi.h>
 #include <mach/gpio.h>
 #include <mach/board.h>
@@ -230,6 +231,7 @@ static void __init omap_ldp_init(void)
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	ads7846_dev_init();
+	twl4030_bci_battery_init();
 	omap_serial_init();
 	usb_musb_init();
 	hsmmc_init();
Index: base-tony/arch/arm/plat-omap/include/mach/board-ldp.h
===================================================================
--- base-tony.orig/arch/arm/plat-omap/include/mach/board-ldp.h	2008-08-21 15:06:24.000000000 +0530
+++ base-tony/arch/arm/plat-omap/include/mach/board-ldp.h	2008-08-21 21:12:52.000000000 +0530
@@ -29,6 +29,8 @@
 #ifndef __ASM_ARCH_OMAP_LDP_H
 #define __ASM_ARCH_OMAP_LDP_H
 
+extern void twl4030_bci_battery_init(void);
+
 #define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
 
 #endif /* __ASM_ARCH_OMAP_LDP_H */
Index: base-tony/drivers/power/Kconfig
===================================================================
--- base-tony.orig/drivers/power/Kconfig	2008-08-21 21:08:31.000000000 +0530
+++ base-tony/drivers/power/Kconfig	2008-08-21 21:09:17.000000000 +0530
@@ -72,7 +72,7 @@ config BATTERY_BQ27200
 
 config TWL4030_BCI_BATTERY
 	tristate "OMAP TWL4030 BCI Battery driver"
-	depends on (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP) && TWL4030_MADC
+	depends on (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP || MACH_OMAP_LDP) && TWL4030_MADC
 	default y
 	help
 	  Support for OMAP TWL4030 BCI Battery driver.
