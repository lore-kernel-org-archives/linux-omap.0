From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v3 4/8] omap-3630-sdp : Add support for Flash
Date: Wed, 16 Jun 2010 17:09:56 +0530
Message-ID: <1276688400-4812-5-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1276688400-4812-1-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-2-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-3-git-send-email-s-ghorai@ti.com>
 <1276688400-4812-4-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab0FPLkH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 07:40:07 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5GBe3kt009596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 06:40:06 -0500
In-Reply-To: <1276688400-4812-4-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

add support for NAND, OneNAND, NOR on omap 3630-sdp board.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c |  120 +++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a795eb6..400f9cf
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
+					   board-flash.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   hsmmc.o
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 504d2bd..a3f24cb
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -22,6 +22,7 @@
 #include <plat/usb.h>
 
 #include <mach/board-zoom.h>
+#include <mach/board-flash.h>
 
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
@@ -93,12 +94,131 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+/*
+ * SDP3630 CS organization
+ * See also the Switch S8 settings in the comments.
+ */
+static char chip_sel_sdp[][GPMC_CS_NUM] = {
+	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
+	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
+	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
+};
+
+static struct mtd_partition sdp_nor_partitions[] = {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+		.name		= "Bootloader-NOR",
+		.offset		= 0,
+		.size		= SZ_256K,
+		.mask_flags	= MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+		.name		= "Params-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_256K,
+		.mask_flags	= 0,
+	},
+	/* kernel */
+	{
+		.name		= "Kernel-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_2M,
+		.mask_flags	= 0
+	},
+	/* file system */
+	{
+		.name		= "Filesystem-NOR",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0
+	}
+};
+
+static struct mtd_partition sdp_onenand_partitions[] = {
+	{
+		.name		= "X-Loader-OneNAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 2 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE  /* force read-only */
+	},
+	{
+		.name		= "U-Boot Environment-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 1 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * (64 * 2048),
+	},
+	{
+		.name		= "File System-OneNAND",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct mtd_partition sdp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader-NAND",
+		.offset		= 0,
+		.size		= 4 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 10 * (64 * 2048),
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "Boot Env-NAND",
+
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1c0000 */
+		.size		= 6 * (64 * 2048),
+	},
+	{
+		.name		= "Kernel-NAND",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 40 * (64 * 2048),
+	},
+	{
+		.name		= "File System - NAND",
+		.size		= MTDPART_SIZ_FULL,
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x780000 */
+	},
+};
+
+static struct flash_partitions sdp_flash_partitions[] = {
+	{
+		.parts = sdp_nor_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_nor_partitions),
+	},
+	{
+		.parts = sdp_onenand_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_onenand_partitions),
+	},
+	{
+		.parts = sdp_nand_partitions,
+		.nr_parts = ARRAY_SIZE(sdp_nand_partitions),
+	},
+};
+
 static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	omap_serial_init();
 	zoom_peripherals_init();
 	board_smc91x_init();
+	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
 }
-- 
1.5.4.7

