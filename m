From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap: NAND: ecc layout select from board file
Date: Tue, 13 Apr 2010 23:07:25 +0530
Message-ID: <1271180246-31779-14-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-3-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-5-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-7-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-9-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-11-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-12-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-13-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46824 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab0DMRhf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Apr 2010 13:37:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHbWiJ030512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:37:34 -0500
In-Reply-To: <1271180246-31779-13-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

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
index 663c9c2..29e0768 
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
index 8ba2e3e..b2ccd68 100644
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
index 5b49c84..b42d058
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
@@ -679,7 +677,6 @@ static int omap_verify_buf(struct mtd_info *mtd, const u_char * buf, int len)
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_HWECC
 /**
  * omap_hwecc_init - Initialize the HW ECC for NAND flash in GPMC controller
  * @mtd: MTD device structure
@@ -957,7 +954,6 @@ static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 
 	__raw_writel(val, info->gpmc_baseaddr + GPMC_ECC_CONFIG);
 }
-#endif
 
 /**
  * omap_wait - wait until the command is done
@@ -1145,19 +1141,19 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
-- 
1.5.4.7

