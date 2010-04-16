From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH 5/6] omap: NAND: ecc layout select from board file
Date: Fri, 16 Apr 2010 17:05:34 +0530
Message-ID: <1271417734-4448-1-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41631 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757804Ab0DPLfm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 07:35:42 -0400
In-Reply-To: <Sukumar Ghorai <s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: sbranden@broadcom.com, leochen@broadcom.com, David.Woodhouse@intel.com, linux-omap@vger.kernel.org, tony@atomide.com, vimal.newwork@gmail.com, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

    This patch makes it possible to select sw or hw (different layout options)
    ecc scheme supported by omap nand driver.  And hw ecc layout selected for
    sdp and zoom boards, by default.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-sdp-flash.c  |    1 +
 arch/arm/mach-omap2/board-zoom-flash.c |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    4 ++++
 drivers/mtd/nand/omap2.c               |   28 ++++++++++++----------------
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-flash.c b/arch/arm/mach-omap2/board-sdp-flash.c
index 81b83ce..437a1a4
--- a/arch/arm/mach-omap2/board-sdp-flash.c
+++ b/arch/arm/mach-omap2/board-sdp-flash.c
@@ -162,6 +162,7 @@ __init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
 	sdp_nand_data.cs		= cs;
 	sdp_nand_data.parts		= sdp_nand_parts.parts;
 	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
+	sdp_nand_data.ecc_opt		= 0x1; /* HW ECC in default layout */
 	if (cpu_is_omap3630())
 		sdp_nand_data.devsize = 1; /* 0: 8-bit, 1: 16-bit device */
 
diff --git a/arch/arm/mach-omap2/board-zoom-flash.c b/arch/arm/mach-omap2/board-zoom-flash.c
index 6a5dcf4..1547bdb
--- a/arch/arm/mach-omap2/board-zoom-flash.c
+++ b/arch/arm/mach-omap2/board-zoom-flash.c
@@ -71,6 +71,7 @@ void __init zoom_flash_init(struct flash_partitions zoom_nand_parts[], int cs)
 	zoom_nand_data.cs		= cs;
 	zoom_nand_data.parts		= zoom_nand_parts[0].parts;
 	zoom_nand_data.nr_parts		= zoom_nand_parts[0].nr_parts;
+	zoom_nand_data.ecc_opt		= 0x1; /* HW ECC in default layout */
 	zoom_nand_data.gpmc_baseaddr	= (void *)(gpmc_base_add);
 	zoom_nand_data.gpmc_cs_baseaddr	= (void *)(gpmc_base_add +
 					GPMC_CS0_BASE +	cs * GPMC_CS_SIZE);
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 8ba2e3e..b2ccd68
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -25,6 +25,10 @@ struct omap_nand_platform_data {
 	void __iomem		*gpmc_cs_baseaddr;
 	void __iomem		*gpmc_baseaddr;
 	int			devsize;
+	int			ecc_opt; /* 0x0 - sw ecc
+					  * 0x1 - hw ecc default ecc layout
+					  * 0x2 - hw ecc in romcode layout
+					  */
 };
 
 /* size (4 KiB) for IO mapping */
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 61c0c01..207fb3c
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -31,7 +31,6 @@
 #define	GPMC_BUF_FULL	0x00000001
 #define	GPMC_BUF_EMPTY	0x00000000
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
 #define NAND_Ecc_P1e		(1 << 0)
 #define NAND_Ecc_P2e		(1 << 1)
 #define NAND_Ecc_P4e		(1 << 2)
@@ -98,7 +97,6 @@
 
 #define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
 #define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
-#endif /* CONFIG_MTD_NAND_OMAP_HWECC */
 
 #ifdef CONFIG_MTD_PARTITIONS
 static const char *part_probes[] = { "cmdlinepart", NULL };
@@ -673,7 +671,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
 /**
  * omap_hwecc_init - Initialize the HW ECC for NAND flash in GPMC controller
  * @mtd: MTD device structure
@@ -951,7 +948,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 
 	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
 }
-#endif
 
 /**
  * omap_wait - wait until the command is done
@@ -1139,19 +1135,19 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	}
 	info->nand.verify_buf = omap_verify_buf;
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
-	info->nand.ecc.bytes		= 3;
-	info->nand.ecc.size		= 512;
-	info->nand.ecc.calculate	= omap_calculate_ecc;
-	info->nand.ecc.hwctl		= omap_enable_hwecc;
-	info->nand.ecc.correct		= omap_correct_data;
-	info->nand.ecc.mode		= NAND_ECC_HW;
+	if (pdata->ecc_opt & 0x3) {
+		info->nand.ecc.bytes		= 3;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.calculate	= omap_calculate_ecc;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
+		info->nand.ecc.correct		= omap_correct_data;
+		info->nand.ecc.mode		= NAND_ECC_HW;
 
-	/* init HW ECC */
-	omap_hwecc_init(&info->mtd);
-#else
-	info->nand.ecc.mode = NAND_ECC_SOFT;
-#endif
+		/* init HW ECC */
+		omap_hwecc_init(&info->mtd);
+	} else {
+		info->nand.ecc.mode = NAND_ECC_SOFT;
+	}
 
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
