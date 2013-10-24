From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v11 07/10] mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH ECC instead of lib/bch.c
Date: Thu, 24 Oct 2013 18:20:23 +0530
Message-ID: <1382619026-4182-8-git-send-email-pekon@ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60627 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab3JXMv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 08:51:56 -0400
In-Reply-To: <1382619026-4182-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

generic frame-work in mtd/nand/nand_bch.c is a wrapper above lib/bch.h which
encapsulates all control information specific to BCH ecc algorithm in software.
Thus this patch:
(1) replace omap specific implementations with equivalent wrapper in nand_bch.c
    so that generic code from nand_bch.c is re-used. like;
        omap3_correct_data_bch() -> nand_bch_correct_data()
        omap3_free_bch() -> nand_bch_free()
(2) replace direct calls to lib/bch.c with wrapper functions defined in nand_bch.c
	init_bch() -> nand_bch_init()

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 96 +++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index b6a08b2..93aa35c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -25,7 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <linux/bch.h>
+#include <linux/mtd/nand_bch.h>
 #include <linux/platform_data/elm.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
@@ -140,7 +140,6 @@
 #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
 #define BADBLOCK_MARKER_LENGTH		2
-#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
 
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
@@ -173,7 +172,6 @@ struct omap_nand_info {
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
 	/* fields specific for BCHx_HW ECC scheme */
-	struct bch_control             *bch;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1507,43 +1505,7 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 
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
@@ -1660,28 +1622,6 @@ static int is_elm_present(struct omap_nand_info *info,
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
@@ -1714,13 +1654,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
-	info->bch		= NULL;
 	info->of_node		= pdata->of_node;
 	mtd			= &info->mtd;
 	mtd->priv		= &info->nand;
 	mtd->name		= dev_name(&pdev->dev);
 	mtd->owner		= THIS_MODULE;
 	nand_chip		= &info->nand;
+	nand_chip->ecc.priv	= NULL;
 	nand_chip->options	|= NAND_SKIP_BBTSCAN;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1903,7 +1843,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.bytes		= 7;
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
@@ -1913,10 +1853,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
 							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(nand_chip->ecc.bytes,
-					nand_chip->ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		nand_chip->ecc.priv		= nand_bch_init(mtd,
+							nand_chip->ecc.size,
+							nand_chip->ecc.bytes,
+							&nand_chip->ecc.layout);
+		if (!nand_chip->ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 		}
@@ -1968,7 +1909,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.bytes		= 13;
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
-		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch8;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
@@ -1978,10 +1919,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
 							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(nand_chip->ecc.bytes,
-					nand_chip->ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		nand_chip->ecc.priv		= nand_bch_init(mtd,
+							nand_chip->ecc.size,
+							nand_chip->ecc.bytes,
+							&nand_chip->ecc.layout);
+		if (!nand_chip->ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -2067,7 +2009,10 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
-	omap3_free_bch(mtd);
+	if (nand_chip->ecc.priv) {
+		nand_bch_free(nand_chip->ecc.priv);
+		nand_chip->ecc.priv = NULL;
+	}
 	kfree(info);
 
 	return err;
@@ -2079,7 +2024,10 @@ static int omap_nand_remove(struct platform_device *pdev)
 	struct nand_chip *nand_chip = mtd->priv;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	omap3_free_bch(mtd);
+	if (nand_chip->ecc.priv) {
+		nand_bch_free(nand_chip->ecc.priv);
+		nand_chip->ecc.priv = NULL;
+	}
 
 	if (info->dma)
 		dma_release_channel(info->dma);
-- 
1.8.1

