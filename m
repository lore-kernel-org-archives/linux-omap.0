From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 2/8] omap3: add support for NAND on zoom2 board
Date: Tue, 13 Apr 2010 23:07:14 +0530
Message-ID: <1271180246-31779-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0DMRhc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 13:37:32 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHbTGW011045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:37:31 -0500
In-Reply-To: <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

This patch adds NAND support to ZOOM2 board.
This uses 'board-zoom-flash.c' for NAND initialization.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    1 +
 arch/arm/mach-omap2/board-zoom2.c |   49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..f8d9a42 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+					   board-zoom-flash.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 9a26f84..e0f4901 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -77,10 +77,59 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
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
+		.size           = 3328 * (64 * 2048),	/* 416M, 0x1A000000 */
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
 
