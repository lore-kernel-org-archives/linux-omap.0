From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 4/6] mtd:nand:omap2: updated support for BCH4 ECC scheme
Date: Fri, 11 Oct 2013 19:06:41 +0530
Message-ID: <1381498603-15715-5-git-send-email-pekon@ti.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46653 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953Ab3JKNhz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 09:37:55 -0400
In-Reply-To: <1381498603-15715-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

This patch adds following two flavours of BCH4 ECC scheme in omap2-nand driver
- OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
	- uses GPMC H/W engine for calculating ECC.
	- uses software library (lib/bch.h & nand_bch.h) for error correction.

- OMAP_ECC_BCH4_CODE_HW
	- uses GPMC H/W engine for calculating ECC.
	- uses ELM H/W engine for error correction.

With this patch omap2-nand driver supports following ECC schemes:
+---------------------------------------+---------------+---------------+
| ECC scheme                            |ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
|OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
+---------------------------------------+---------------+---------------+
Important:
- Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
	Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH ECC algorithm.

- Selection of OMAP_ECC_BCHx_CODE_HW requires,
	Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W module.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/Kconfig |  30 ++---------
 drivers/mtd/nand/omap2.c | 134 +++++++++++++++++++++--------------------------
 2 files changed, 63 insertions(+), 101 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index d885298..5836039 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -96,35 +96,13 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
-	tristate "Enable support for hardware BCH error correction"
+	tristate "Support hardware based BCH error correction"
 	default n
 	select BCH
-	select BCH_CONST_PARAMS
 	help
-	 Support for hardware BCH error correction.
-
-choice
-	prompt "BCH error correction capability"
-	depends on MTD_NAND_OMAP_BCH
-
-config MTD_NAND_OMAP_BCH8
-	bool "8 bits / 512 bytes (recommended)"
-	help
-	 Support correcting up to 8 bitflips per 512-byte block.
-	 This will use 13 bytes of spare area per 512 bytes of page data.
-	 This is the recommended mode, as 4-bit mode does not work
-	 on some OMAP3 revisions, due to a hardware bug.
-
-config MTD_NAND_OMAP_BCH4
-	bool "4 bits / 512 bytes"
-	help
-	 Support correcting up to 4 bitflips per 512-byte block.
-	 This will use 7 bytes of spare area per 512 bytes of page data.
-	 Note that this mode does not work on some OMAP3 revisions, due to a
-	 hardware bug. Please check your OMAP datasheet before selecting this
-	 mode.
-
-endchoice
+	  Some devices have built-in ELM hardware engine, which can be used to
+	  locate and correct errors when using BCH ECC scheme. This enables the
+	  driver support for same.
 
 if MTD_NAND_OMAP_BCH
 config BCH_CONST_M
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index fb96251..a783dae 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -27,6 +27,7 @@
 
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 #include <linux/bch.h>
+#include <linux/mtd/nand_bch.h>
 #endif
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 #include <linux/platform_data/elm.h>
@@ -144,7 +145,6 @@
 #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
 #define BADBLOCK_MARKER_LENGTH		2
-#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
 
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
@@ -188,7 +188,6 @@ struct omap_nand_info {
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
 	/* fields specific for BCHx_HW ECC scheme */
-	struct bch_control              *bch;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1522,43 +1521,7 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 
 	return stat;
 }
-#endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
-#ifdef CONFIG_MTD_NAND_ECC_BCH
-/**
- * omap3_correct_data_bch - Decode received data and correct errors
- * @mtd: MTD device structure
- * @data: page data
- * @read_ecc: ecc read from nand flash
- * @calc_ecc: ecc read from HW ECC registers
- */
-static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
-				  u_char *read_ecc, u_char *calc_ecc)
-{
-	int i, count;
-	/* cannot correct more than 8 errors */
-	unsigned int errloc[8];
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-
-	count = decode_bch(info->bch, NULL, 512, read_ecc, calc_ecc, NULL,
-			   errloc);
-	if (count > 0) {
-		/* correct errors */
-		for (i = 0; i < count; i++) {
-			/* correct data only, not ecc bytes */
-			if (errloc[i] < 8*512)
-				data[errloc[i]/8] ^= 1 << (errloc[i] & 7);
-			pr_debug("corrected bitflip %u\n", errloc[i]);
-		}
-	} else if (count < 0) {
-		pr_err("ecc unrecoverable error\n");
-	}
-	return count;
-}
-#endif /* CONFIG_MTD_NAND_ECC_BCH */
-
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap_write_page_bch - BCH ecc based write page function for entire page
  * @mtd:		mtd info structure
@@ -1675,28 +1638,6 @@ static int is_elm_present(struct omap_nand_info *info,
 }
 #endif /* CONFIG_MTD_NAND_ECC_BCH */
 
-#ifdef CONFIG_MTD_NAND_ECC_BCH
-/**
- * omap3_free_bch - Release BCH ecc resources
- * @mtd: MTD device structure
- */
-static void omap3_free_bch(struct mtd_info *mtd)
-{
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-	if (info->bch) {
-		free_bch(info->bch);
-		info->bch = NULL;
-	}
-}
-
-#else
-
-static void omap3_free_bch(struct mtd_info *mtd)
-{
-}
-#endif /* CONFIG_MTD_NAND_ECC_BCH */
-
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
@@ -1731,10 +1672,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 	mtd->owner		= THIS_MODULE;
 	mtd->priv		= &info->nand;
 	nand_chip		= &info->nand;
+	nand_chip->ecc.priv	= NULL;
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
-	info->bch		= NULL;
 
 	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
 	info->of_node		= pdata->of_node;
@@ -1927,7 +1868,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.bytes		= 7;
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
 		/* define custom ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
@@ -1937,10 +1878,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
 							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(nand_chip->ecc.bytes,
-					nand_chip->ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		info->nand.ecc.priv		= nand_bch_init(mtd,
+							info->nand.ecc.size,
+							info->nand.ecc.bytes,
+							&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 		}
@@ -1951,6 +1893,39 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 #endif
 
+	case OMAP_ECC_BCH4_CODE_HW:
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		info->nand.ecc.bytes		= 7 + 1;
+		info->nand.ecc.strength		= 4;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= omap_elm_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
+		info->nand.ecc.read_page	= omap_read_page_bch;
+		info->nand.ecc.write_page	= omap_write_page_bch;
+		/* This ECC scheme requires ELM H/W block */
+		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
+			pr_err("nand: error: could not initialize ELM\n");
+			err = -ENODEV;
+			goto out_release_mem_region;
+		}
+		/* define ECC layout */
+		ecclayout->eccbytes		= info->nand.ecc.bytes *
+							(mtd->writesize /
+							info->nand.ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
+
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
@@ -1959,7 +1934,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.bytes		= 13;
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch8;
 		/* define custom ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
@@ -1969,10 +1944,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
 							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(nand_chip->ecc.bytes,
-					nand_chip->ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		info->nand.ecc.priv		= nand_bch_init(mtd,
+							info->nand.ecc.size,
+							info->nand.ecc.bytes,
+							&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -2023,7 +1999,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* populate remaining info for custom ecc layout */
-	pr_info("%s: using custom ecc layout\n", DRIVER_NAME);
 	ecclayout->oobfree->length = mtd->oobsize - BADBLOCK_MARKER_LENGTH
 						- ecclayout->eccbytes;
 	if (!(nand_chip->options & NAND_BUSWIDTH_16))
@@ -2061,7 +2036,12 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
-	omap3_free_bch(&info->mtd);
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+	if (info->nand.ecc.priv) {
+		nand_bch_free(info->nand.ecc.priv);
+		info->nand.ecc.priv = NULL;
+	}
+#endif
 	kfree(info);
 
 	return err;
@@ -2072,8 +2052,12 @@ static int omap_nand_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	omap3_free_bch(&info->mtd);
-
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+	if (info->nand.ecc.priv) {
+		nand_bch_free(info->nand.ecc.priv);
+		info->nand.ecc.priv = NULL;
+	}
+#endif
 	if (info->dma)
 		dma_release_channel(info->dma);
 
-- 
1.8.1

