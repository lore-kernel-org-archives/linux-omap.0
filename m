From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 3/5] omap3: add support for NAND on zoom3 board
Date: Fri,  9 Jul 2010 19:57:49 +0530
Message-ID: <1278685671-12036-4-git-send-email-s-ghorai@ti.com>
References: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-2-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-3-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52054 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756946Ab0GIO2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 10:28:04 -0400
In-Reply-To: <1278685671-12036-3-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

patch adds NAND support to zoom3 board.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/board-zoom3.c |   43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 81c3b08..cbd3458 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
+					   board-flash.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 0c6858b..84f49da 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -28,6 +28,47 @@
 static struct omap_board_config_kernel zoom_config[] __initdata = {
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
+		.name		= "system",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
+		.size		= 3328 * (64 * 2048),	/* 416M, 0x1A000000 */
+	},
+	{
+		.name		= "userdata",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1C000000*/
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+	{
+		.name		= "cache",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1E000000*/
+		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
+	},
+};
+
 static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
@@ -75,6 +116,8 @@ static void __init omap_zoom_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
+	board_nand_init(zoom_nand_partitions,
+			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
