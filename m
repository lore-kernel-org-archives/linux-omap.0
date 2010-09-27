From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Mon, 27 Sep 2010 19:41:49 +0530
Message-ID: <1285596710-25658-5-git-send-email-s-ghorai@ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49511 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758899Ab0I0OME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 10:12:04 -0400
In-Reply-To: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
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
 drivers/mtd/nand/omap2.c               |   29 +++++++++++++----------------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 2355e4a..ecd41ae 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -144,6 +144,7 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 	board_nand_data.cs		= cs;
 	board_nand_data.parts		= nand_parts;
 	board_nand_data.nr_parts	= nr_parts;
+	board_nand_data.ecc_opt		= OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
 
 	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index fb82335..54902d8 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -86,6 +86,13 @@
 #define PREFETCH_FIFOTHRESHOLD_MAX	0x40
 #define PREFETCH_FIFOTHRESHOLD(val)	(val << 8)
 
+enum omap_ecc{
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
index 5e69463..d5b6fc6 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/gpmc.h>
 #include <linux/mtd/partitions.h>
 
 struct omap_nand_platform_data {
@@ -23,6 +24,7 @@ struct omap_nand_platform_data {
 	int			gpmc_irq;
 	unsigned long		phys_base;
 	int			devsize;
+	enum omap_ecc           ecc_opt;
 };
 
 /* minimum size for IO mapping */
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5ac7f7c..3fd9ee0 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define CONFIG_MTD_NAND_OMAP_HWECC
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -659,8 +658,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-
 /**
  * gen_true_ecc - This function will generate true ECC value
  * @ecc_buf: buffer to store ecc code
@@ -880,8 +877,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
 }
 
-#endif
-
 /**
  * omap_wait - wait until the command is done
  * @mtd: MTD device structure
@@ -1059,17 +1054,19 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	}
 	info->nand.verify_buf = omap_verify_buf;
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-	info->nand.ecc.bytes		= 3;
-	info->nand.ecc.size		= 512;
-	info->nand.ecc.calculate	= omap_calculate_ecc;
-	info->nand.ecc.hwctl		= omap_enable_hwecc;
-	info->nand.ecc.correct		= omap_correct_data;
-	info->nand.ecc.mode		= NAND_ECC_HW;
-
-#else
-	info->nand.ecc.mode = NAND_ECC_SOFT;
-#endif
+	/* selsect the ecc type */
+	if ((pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT) ||
+		(pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW)) {
+		info->nand.ecc.bytes		= 3;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.calculate	= omap_calculate_ecc;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
+		info->nand.ecc.correct		= omap_correct_data;
+		info->nand.ecc.mode		= NAND_ECC_HW;
+
+	} else if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_SW) {
+		info->nand.ecc.mode = NAND_ECC_SOFT;
+	}
 
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
-- 
1.7.0.4

