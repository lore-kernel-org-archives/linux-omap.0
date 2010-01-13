From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 2/3] OMAP3: Add support for NAND on ZOOM2 board
Date: Wed, 13 Jan 2010 12:33:13 +0530
Message-ID: <ce9ab5791001122303gebaa54g3744a350b1e7d59e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45169 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab0AMHDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 02:03:34 -0500
Received: by bwz27 with SMTP id 27so1718874bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 23:03:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

>From 0dcf09f753601c9f7d08f65cb9b887e93998f7c5 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 12 Jan 2010 17:30:12 +0530
Subject: [PATCH] OMAP3: Add support for NAND on ZOOM2 board

This patch adds NAND support to ZOOM2 board.
This uses 'board-zoom-flash.c' for NAND initialization.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/board-zoom2.c |   49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c74437c..434310e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+ 					   board-zoom-flash.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
diff --git a/arch/arm/mach-omap2/board-zoom2.c
b/arch/arm/mach-omap2/board-zoom2.c
index bb87cf7..9fa8bcf 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -77,10 +77,59 @@ static struct omap_board_mux board_mux[]
 #define board_mux	NULL
 #endif

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
 static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
+	zoom_flash_init(zoom_flash_partitions, ZOOM_NAND_CS);
 	zoom_debugboard_init();
 }

-- 
1.5.5
