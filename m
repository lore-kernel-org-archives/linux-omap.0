From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v6 6/7] omap: nand: ecc layout select from board file
Date: Fri, 26 Nov 2010 21:04:36 +0530
Message-ID: <1290785677-16005-7-git-send-email-s-ghorai@ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56001 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0KZPev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 10:34:51 -0500
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

This patch makes it possible to select sw or hw (different layout options)
ecc scheme supported by omap nand driver.  And hw ecc layout selected for
sdp and zoom boards, by default.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-flash.c      |    1 +
 arch/arm/plat-omap/include/plat/gpmc.h |    7 +++++++
 arch/arm/plat-omap/include/plat/nand.h |    2 ++
 drivers/mtd/nand/omap2.c               |    5 +----
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 78abcd9..3340427 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -150,6 +150,7 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 	if (cpu_is_omap3630())
 		board_nand_data.devsize = 1;
 
+	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
 	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index fb82335..ca6e8db 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -86,6 +86,13 @@
 #define PREFETCH_FIFOTHRESHOLD_MAX	0x40
 #define PREFETCH_FIFOTHRESHOLD(val)	(val << 8)
 
+enum omap_ecc {
+	OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT = 0,
+		/* 1-bit s/w ecc and layout different from romcode */
+	OMAP_ECC_HAMMING_CODE_HW,/* 1-bit ecc, romcode layout */
+	OMAP_ECC_HAMMING_CODE_SW,/* 1-bit ecc, romcode layout */
+};
+
 /*
  * Note that all values in this struct are in nanoseconds, while
  * the register values are in gpmc_fck cycles.
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index ae5e053..d86d1ec 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/gpmc.h>
 #include <linux/mtd/partitions.h>
 
 enum nand_io {
@@ -31,6 +32,7 @@ struct omap_nand_platform_data {
 	enum nand_io		xfer_type;
 	unsigned long		phys_base;
 	int			devsize;
+	enum omap_ecc           ecc_opt;
 };
 
 /* minimum size for IO mapping */
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index fea9f59..0937001 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define CONFIG_MTD_NAND_OMAP_HWECC
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -618,8 +619,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-
 /**
  * gen_true_ecc - This function will generate true ECC value
  * @ecc_buf: buffer to store ecc code
@@ -839,8 +838,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
 }
 
-#endif
-
 /**
  * omap_wait - wait until the command is done
  * @mtd: MTD device structure
-- 
1.7.0.4

