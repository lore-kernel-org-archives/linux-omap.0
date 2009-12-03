From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 3/4]: OMAP3: Add support for NAND on ZOOM3 board
Date: Thu, 3 Dec 2009 19:48:03 +0530
Message-ID: <ce9ab5790912030618j531cf9feidca4078d45386557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61788 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZLCOSR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 09:18:17 -0500
Received: by bwz27 with SMTP id 27so1114166bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 06:18:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 4259c6ae2e6d9b5e316fa8289a9fca729fc6bc83 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Thu, 3 Dec 2009 18:23:37 +0530
Subject: [PATCH] OMAP3: Add support for NAND on ZOOM3 board

This patch adds NAND support to ZOOM3 board.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/board-zoom3.c |   49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a277d38..4848ab0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+ 					   board-zoom-flash.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
diff --git a/arch/arm/mach-omap2/board-zoom3.c
b/arch/arm/mach-omap2/board-zoom3.c
index 8d965a6..49090da 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -42,9 +42,58 @@ static void __init omap_zoom_init_irq(void)
 	omap_gpio_init();
 }

+static struct mtd_partition zoom_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),	/* 512KB, 0x80000 */
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+},
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
+		.name		= "system",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size           = 1280 * (64 * 2048),	/* 160M, 0xA000000 */
+	},
+	{
+		.name		= "userdata",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0xC000000 */
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+	{
+		.name		= "cache",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0xE000000 */
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+};
+
+static struct flash_partitions zoom_flash_partitions[] = {
+	{
+		.parts = zoom_nand_partitions,
+		.nr_parts = ARRAY_SIZE(zoom_nand_partitions),
+	},
+};
+
 static void __init omap_zoom_init(void)
 {
 	zoom_peripherals_init();
+	zoom_flash_init(zoom_flash_partitions, ZOOM_NAND_CS);
 	zoom_debugboard_init();
 }

-- 
1.5.5
