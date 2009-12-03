From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 4/4]: OMAP3: Add support for NAND on LDP board
Date: Thu, 3 Dec 2009 19:48:44 +0530
Message-ID: <ce9ab5790912030618i72fbcicddd08fd6cccc00d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45893 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZLCOTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:19:03 -0500
Received: by bwz27 with SMTP id 27so1115018bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:19:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 1786a05d3331850ff5c49e4edafe68a411597173 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 3 Dec 2009 18:26:45 +0530
Subject: [PATCH] OMAP3: Add support for NAND on LDP board

This patch adds NAND support to LDP board.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    1 +
 arch/arm/mach-omap2/board-ldp.c |   41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4848ab0..f730ddc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
+ 					   board-zoom-flash.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index c062238..25bbb4f 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,6 +38,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
+#include <mach/board-zoom.h>

 #include <asm/delay.h>
 #include <plat/control.h>
@@ -374,6 +375,45 @@ static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
 };

+static struct mtd_partition zoom_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),	/* 512KB, 0x80000 */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 10 * (64 * 2048),	/* 1.25MB, 0x140000 */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+		.offset		= MTDPART_OFS_APPEND,   /* Offset = 0x1c0000 */
+		.size		= 2 * (64 * 2048),	/* 256KB, 0x40000 */
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x0200000*/
+		.size		= 240 * (64 * 2048),	/* 30M, 0x1E00000 */
+	},
+	{
+		.name		= "File System - NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size		= MTDPART_SIZ_FULL,	/* 96MB, 0x6000000 */
+	},
+
+};
+
+static struct flash_partitions zoom_flash_partitions[] = {
+	{
+		.parts = zoom_nand_partitions,
+		.nr_parts = ARRAY_SIZE(zoom_nand_partitions),
+	},
+};
+
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();
@@ -385,6 +425,7 @@ static void __init omap_ldp_init(void)
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
+	zoom_flash_init(zoom_flash_partitions, ZOOM_NAND_CS);

 	twl4030_mmc_init(mmc);
 	/* link regulators to MMC adapters */
-- 
1.5.5
