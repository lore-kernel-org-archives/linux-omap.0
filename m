From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 5/5] omap3: add support for NAND on LDP board
Date: Fri,  9 Jul 2010 19:57:51 +0530
Message-ID: <1278685671-12036-6-git-send-email-s-ghorai@ti.com>
References: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-2-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-3-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-4-git-send-email-s-ghorai@ti.com>
 <1278685671-12036-5-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756911Ab0GIO2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 10:28:04 -0400
In-Reply-To: <1278685671-12036-5-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

patch adds NAND support to LDP board.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    1 +
 arch/arm/mach-omap2/board-ldp.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b55a5d7..fc9133f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o \
                                            hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
+					   board-flash.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   hsmmc.o
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 6e3930e..9845995 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -38,6 +38,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
+#include <mach/board-zoom.h>
 
 #include <asm/delay.h>
 #include <plat/control.h>
@@ -388,6 +389,38 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static struct mtd_partition ldp_nand_partitions[] = {
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
 static void __init omap_ldp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -400,6 +433,8 @@ static void __init omap_ldp_init(void)
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
+	board_nand_init(ldp_nand_partitions,
+		ARRAY_SIZE(ldp_nand_partitions), ZOOM_NAND_CS);
 
 	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
