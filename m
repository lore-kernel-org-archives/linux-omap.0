From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v2 3/4] omap: nand: ecc layout select from board file
Date: Thu,  1 Jul 2010 16:12:14 +0530
Message-ID: <1277980935-24070-4-git-send-email-s-ghorai@ti.com>
References: <1277980935-24070-1-git-send-email-s-ghorai@ti.com>
 <1277980935-24070-2-git-send-email-s-ghorai@ti.com>
 <1277980935-24070-3-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60343 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab0GAKmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:42:24 -0400
In-Reply-To: <1277980935-24070-3-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

    This patch makes it possible to select sw or hw (different layout options)
    ecc scheme supported by omap nand driver.  And hw ecc layout selected for
    sdp and zoom boards, by default.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-flash.c      |    3 ++-
 arch/arm/plat-omap/include/plat/nand.h |    6 ++++++
 drivers/mtd/nand/omap2.c               |   29 +++++++++++++----------------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index c6a07dd..ab31e7f 100755
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -143,7 +143,8 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 {
 	board_nand_data.cs		= cs;
 	board_nand_data.parts		= nand_parts;
-	board_nand_data.nr_parts		= nr_parts;
+	board_nand_data.nr_parts	= nr_parts;
+	board_nand_data.ecc_opt		= OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
 
 	gpmc_nand_init(&board_nand_data);
 }
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 5e69463..2e026e4 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -23,6 +23,12 @@ struct omap_nand_platform_data {
 	int			gpmc_irq;
 	unsigned long		phys_base;
 	int			devsize;
+	enum {
+		OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT = 0,
+		/* 1-bit s/w ecc and layout different from romcode */
+		OMAP_ECC_HAMMING_CODE_HW,/* 1-bit ecc, romcode layout */
+		OMAP_ECC_HAMMING_CODE_SW,/* 1-bit ecc, romcode layout */
+	} ecc_opt;
 };
 
 /* minimum size for IO mapping */
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 00f88d6..d696026 100755
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,7 +7,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define CONFIG_MTD_NAND_OMAP_HWECC
 
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -670,8 +669,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-
 /**
  * gen_true_ecc - This function will generate true ECC value
  * @ecc_buf: buffer to store ecc code
@@ -891,8 +888,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 	gpmc_enable_hwecc(info->gpmc_cs, mode, dev_width, info->nand.ecc.size);
 }
 
-#endif
-
 /**
  * omap_wait - wait until the command is done
  * @mtd: MTD device structure
@@ -1073,17 +1068,19 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
