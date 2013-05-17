From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 3/4 v2] mtd:nand:omap2: updated support for BCH4 ECC scheme
Date: Fri, 17 May 2013 17:20:17 +0530
Message-ID: <1368791418-14330-4-git-send-email-pekon@ti.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58642 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab3EQLv0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:51:26 -0400
In-Reply-To: <1368791418-14330-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

From: "Gupta, Pekon" <pekon@ti.com>

This patch adds following two flavours of BCH4 ECC scheme in omap2-nand driver
- OMAP_ECC_BCH4_CODE_HW_DETECTION_SW
	- uses GPMC H/W engine for calculating ECC.
	- uses software library (lib/bch.h & nand_bch.h) for error correction.

- OMAP_ECC_BCH4_CODE_HW
	- uses GPMC H/W engine for calculating ECC.
	- uses ELM H/W engine for error correction.

With this patch omap2-nand driver supports following ECC schemes:
+---------------------------------------+---------------+---------------+
| ECC scheme				|ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
|OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
|OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
|OMAP_ECC_BCH4_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W (lib/bch.h)|
|OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+
Important:
- Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
	Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH ECC algorithm.

- Selection of OMAP_ECC_BCHx_CODE_HW requires,
	Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W module.

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 drivers/mtd/nand/Kconfig                     |   1 -
 drivers/mtd/nand/omap2.c                     | 159 +++++++++++----------------
 include/linux/platform_data/mtd-nand-omap2.h |  10 +-
 3 files changed, 70 insertions(+), 100 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 81bf5e5..b8196a1 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -112,7 +112,6 @@ config MTD_NAND_OMAP_BCH
 	bool "Enable support for hardware BCH error correction"
 	default n
 	select BCH
-	select BCH_CONST_PARAMS
 	help
 	 Support for hardware BCH error correction.
 
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 167f8d4..43e4dd4 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -27,6 +27,7 @@
 
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 #include <linux/bch.h>
+#include <linux/mtd/nand_bch.h>
 #endif
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 #include <linux/platform_data/elm.h>
@@ -185,10 +186,9 @@ struct omap_nand_info {
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
@@ -1227,58 +1227,6 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
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
 
 
@@ -1735,6 +1683,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
+	info->nand.ecc.priv			= NULL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -1882,27 +1831,36 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.hwctl            = omap_enable_hwecc;
 		info->nand.ecc.correct          = omap_correct_data;
 		info->nand.ecc.mode             = NAND_ECC_HW;
-		info->bch			= NULL;
 		break;
-
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.bytes		= 7;
+		info->nand.ecc.strength		= 4;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch4;
+		break;
+#endif
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
-	case OMAP_ECC_BCH8_CODE_HW:
+	case OMAP_ECC_BCH4_CODE_HW:
 		/* check if ELM module is present on SoC */
-		if (is_elm_present(info, ECC_TYPE_BCH8) < 0) {
+		if (is_elm_present(info, ECC_TYPE_BCH4) < 0) {
 			pr_err("ELM module not detected, required for ECC\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
 		info->nand.ecc.mode		= NAND_ECC_HW;
 		info->nand.ecc.size		= 512;
-		info->nand.ecc.bytes		= 14;
-		info->nand.ecc.strength		= 8;
+		/* 8th bit is kept reserved for ROM-code compatibility */
+		info->nand.ecc.bytes		= 7 + 1;
+		info->nand.ecc.strength		= 4;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
 		info->nand.ecc.correct		= omap_elm_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
 		info->nand.ecc.read_page	= omap_read_page_bch;
 		info->nand.ecc.write_page	= omap_write_page_bch;
-		info->bch			= NULL;
 		break;
 #endif
 #ifdef CONFIG_MTD_NAND_ECC_BCH
@@ -1912,36 +1870,28 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.bytes		= 13;
 		info->nand.ecc.strength		= 8;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
-		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch8;
-		/* software bch library is used for locating errors */
-		info->bch = init_bch(info->nand.ecc.bytes,
-					info->nand.ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
-			pr_err("unable initialize S/W BCH logic\n");
+		break;
+#endif
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	case OMAP_ECC_BCH8_CODE_HW:
+		/* check if ELM module is present on SoC */
+		if (is_elm_present(info, ECC_TYPE_BCH8) < 0) {
+			pr_err("ELM module not detected, required for ECC\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
-		break;
-
-	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
 		info->nand.ecc.mode		= NAND_ECC_HW;
 		info->nand.ecc.size		= 512;
-		info->nand.ecc.bytes		= 7;
-		info->nand.ecc.strength		= 4;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		info->nand.ecc.bytes		= 13 + 1;
+		info->nand.ecc.strength		= 8;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
-		info->nand.ecc.correct		= omap3_correct_data_bch;
-		info->nand.ecc.calculate	= omap3_calculate_ecc_bch4;
-		/* software bch library is used for locating errors */
-		info->bch = init_bch(info->nand.ecc.bytes,
-					info->nand.ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
-			pr_err("unable initialize S/W BCH logic\n");
-			err = -EINVAL;
-			goto out_release_mem_region;
-		}
+		info->nand.ecc.correct		= omap_elm_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
+		info->nand.ecc.read_page	= omap_read_page_bch;
+		info->nand.ecc.write_page	= omap_write_page_bch;
 		break;
 #endif
 	default:
@@ -1964,7 +1914,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	/* check if NAND OOBSIZE meets ECC scheme requirement */
 	omap_oobinfo.eccbytes = eccsteps * info->nand.ecc.bytes;
-
 	if (info->mtd.oobsize < (omap_oobinfo.eccbytes +
 					BADBLOCK_MARKER_LENGTH)) {
 		pr_err("not enough OOB bytes required = %d, available=%d",
@@ -1983,6 +1932,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
 		break;
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 	case OMAP_ECC_BCH4_CODE_HW:
 	case OMAP_ECC_BCH8_CODE_HW:
 		/* check for small page devices */
@@ -1996,7 +1946,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		omap_oobinfo.oobfree->offset = BADBLOCK_MARKER_LENGTH +
 						omap_oobinfo.eccbytes;
 		break;
-
+#endif
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
 		/* check for small page devices */
@@ -2005,16 +1956,26 @@ static int omap_nand_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
-		offset = info->mtd.oobsize - omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->offset = BADBLOCK_MARKER_LENGTH;
+		/* software bch library is used for locating errors */
+		info->nand.ecc.priv = nand_bch_init(&info->mtd,
+						info->nand.ecc.size,
+						info->nand.ecc.bytes,
+						&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
+			pr_err("unable initialize S/W BCH logic\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		pr_info("using default ecc layout in nand_bch_init");
+		goto scan_tail;
 		break;
-
+#endif
 	default:
-		pr_info("using default ecc layout for NAND device");
+		pr_info("using default ecc layout in generic driver");
 		goto scan_tail;
 	}
 
-	/* populate other ecc_layout information based on ECC scheme */
+	/* populate other information for custom ecc layout */
 	if (!(info->nand.options & NAND_BUSWIDTH_16))
 		info->nand.badblock_pattern = &bb_descrip_flashbased;
 
@@ -2049,8 +2010,14 @@ out_release_mem_region:
 	if (info->gpmc_irq_fifo > 0)
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
+
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
@@ -2062,8 +2029,12 @@ static int omap_nand_remove(struct platform_device *pdev)
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
 	platform_set_drvdata(pdev, NULL);
 	if (info->dma)
 		dma_release_channel(info->dma);
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index ce74576..9fcee61 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -30,14 +30,14 @@ enum omap_ecc {
 	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
 	/* ECC layout compatible to legacy ROMCODE. */
 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE,
-	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
-	OMAP_ECC_BCH4_CODE_HW,
 	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
 	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
-	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
-	OMAP_ECC_BCH8_CODE_HW,
+	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH4_CODE_HW,
 	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
-	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
+	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH8_CODE_HW
 };
 
 struct gpmc_nand_regs {
-- 
1.8.1

