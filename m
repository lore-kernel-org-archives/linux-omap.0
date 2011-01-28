From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v9 6/7] omap3: nand: ecc layout select from board file
Date: Fri, 28 Jan 2011 15:42:08 +0530
Message-ID: <1296209529-22696-7-git-send-email-s-ghorai@ti.com>
References: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40165 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab1A1KMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 05:12:23 -0500
In-Reply-To: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

This patch makes it possible to select sw or hw (different layout options)
ecc scheme supported by omap nand driver.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/mach-omap2/board-flash.c      |    1 +
 arch/arm/plat-omap/include/plat/gpmc.h |    6 ++++++
 arch/arm/plat-omap/include/plat/nand.h |    2 ++
 drivers/mtd/nand/omap2.c               |   26 +++++++++++---------------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 1964509..a768198 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -148,6 +148,7 @@ __init board_nand_init(struct mtd_partition *nand_parts,
 	board_nand_data.nr_parts	= nr_parts;
 	board_nand_data.devsize		= nand_type;
 
+	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DEFAULT;
 	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index a243463..773351b 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -86,6 +86,12 @@
 #define PREFETCH_FIFOTHRESHOLD_MAX	0x40
 #define PREFETCH_FIFOTHRESHOLD(val)	((val) << 8)
 
+enum omap_ecc {
+		/* 1-bit ecc: stored at end of spare area */
+	OMAP_ECC_HAMMING_CODE_DEFAULT = 0, /* Default, s/w method */
+	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
+};
+
 /*
  * Note that all values in this struct are in nanoseconds except sync_clk
  * (which is in picoseconds), while the register values are in gpmc_fck cycles.
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
index f1648fd..6d4a42e 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -626,8 +626,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-
 /**
  * gen_true_ecc - This function will generate true ECC value
  * @ecc_buf: buffer to store ecc code
@@ -847,8 +845,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
 }
 
-#endif
-
 /**
  * omap_wait - wait until the command is done
  * @mtd: MTD device structure
@@ -1038,17 +1034,17 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 
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
+	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DEFAULT)
+		info->nand.ecc.mode = NAND_ECC_SOFT;
+	else if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW) {
+		info->nand.ecc.bytes            = 3;
+		info->nand.ecc.size             = 512;
+		info->nand.ecc.calculate        = omap_calculate_ecc;
+		info->nand.ecc.hwctl            = omap_enable_hwecc;
+		info->nand.ecc.correct          = omap_correct_data;
+		info->nand.ecc.mode             = NAND_ECC_HW;
+	}
 
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
-- 
1.7.0.4

