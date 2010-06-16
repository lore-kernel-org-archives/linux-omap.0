From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 2/8] omap3: add support for NAND on zoom2 board
Date: Wed, 16 Jun 2010 17:09:54 +0530
Message-ID: <1276688400-4812-3-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758870Ab0FPLkG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 07:40:06 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GBe3xh009595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 06:40:05 -0500
In-Reply-To: <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

This patch adds NAND support to ZOOM2 board.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-zoom2.c             |   43 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/board-zoom.h |    6 +++
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0d854f1..e7159b0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
+					   board-flash.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..549f274 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -77,10 +77,53 @@ static struct omap_board_mux board_mux[] __initdata = {
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
 static void __init omap_zoom2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
+	board_nand_init(zoom_nand_partitions,
+			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
 }
 
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index c93b29e..3af69d2 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -1,5 +1,11 @@
 /*
  * Defines for zoom boards
  */
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#define ZOOM_NAND_CS    0
+
+extern void __init board_nand_init(struct mtd_partition *, u8 nr_parts, u8 cs);
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
