From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v6 3/4] mtd:nand:omap2: updated support for BCH4 ECC scheme
Date: Thu, 12 Sep 2013 17:20:18 +0530
Message-ID: <1378986619-26765-4-git-send-email-pekon@ti.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37860 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab3ILLvR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Sep 2013 07:51:17 -0400
In-Reply-To: <1378986619-26765-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, olof@lixom.net, computersforpeace@gmail.com
Cc: dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

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
|OMAP_ECC_HAMMING_CODE_DEFAULT          |S/W            |S/W            |
|OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
|OMAP_ECC_HAMMING_CODE_HW_ROMCODE       |H/W (GPMC)     |S/W            |
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
 drivers/mtd/nand/omap2.c | 136 ++++++++++++++++++++++-------------------------
 2 files changed, 68 insertions(+), 98 deletions(-)

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
index 420078f..6f4596c 100644
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
 
 #define BADBLOCK_MARKER_LENGTH		0x2
-#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
 
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
@@ -185,10 +185,9 @@ struct omap_nand_info {
 		OMAP_NAND_IO_WRITE,	/* write */
 	} iomode;
 	u_char				*buf;
-	int					buf_len;
+	int				buf_len;
 	struct gpmc_nand_regs		reg;
 	/* fields specific for BCHx_HW ECC scheme */
-	struct bch_control              *bch;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1227,58 +1226,6 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
 	return 0;
 }
 
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
-
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
-
 #endif /* CONFIG_MTD_NAND_ECC_BCH */
 
 
@@ -1725,16 +1672,17 @@ static int omap_nand_probe(struct platform_device *pdev)
 	mtd->owner		= THIS_MODULE;
 	mtd->priv		= &info->nand;
 	chip			= mtd->priv;
+	chip->ecc.priv		= NULL;
 
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
-	info->bch		= NULL;
 
 	info->nand.options	= NAND_BUSWIDTH_AUTO;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 	info->of_node		= pdata->of_node;
 
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		err = -EINVAL;
@@ -1924,20 +1872,21 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.bytes		= 7;
 		info->nand.ecc.strength		= 4;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
-		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch4;
 		/* define custom ECC layout */
 		ecclayout->eccbytes		= info->nand.ecc.bytes *
-						(mtd->writesize /
-						info->nand.ecc.size);
+							(mtd->writesize /
+							info->nand.ecc.size);
 		ecclayout->eccpos[0]		= info->mtd.oobsize -
-						ecclayout->eccbytes;
+							ecclayout->eccbytes;
 		ecclayout->oobfree->offset	= BADBLOCK_MARKER_LENGTH;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(info->nand.ecc.bytes,
-					info->nand.ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		info->nand.ecc.priv		= nand_bch_init(mtd,
+						info->nand.ecc.size,
+						info->nand.ecc.bytes,
+						&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -1949,6 +1898,39 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 #endif
 		break;
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
+		/* define custom ECC layout */
+		ecclayout->eccbytes		= info->nand.ecc.bytes *
+							(mtd->writesize /
+							info->nand.ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
+		goto custom_ecc_layout;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
+		break;
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
@@ -1957,7 +1939,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.bytes		= 13;
 		info->nand.ecc.strength		= 8;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
-		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch8;
 		/* define custom ECC layout */
 		ecclayout->eccbytes		= info->nand.ecc.bytes *
@@ -1967,10 +1949,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 							ecclayout->eccbytes;
 		ecclayout->oobfree->offset	= BADBLOCK_MARKER_LENGTH;
 		/* software bch library is used for locating errors */
-		info->bch = init_bch(info->nand.ecc.bytes,
-					info->nand.ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
+		info->nand.ecc.priv		= nand_bch_init(mtd,
+						info->nand.ecc.size,
+						info->nand.ecc.bytes,
+						&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -2062,7 +2045,12 @@ out_release_mem_region:
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
@@ -2073,8 +2061,12 @@ static int omap_nand_remove(struct platform_device *pdev)
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

