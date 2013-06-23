From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 3/4] mtd:nand:omap2: updated support for BCH4 ECC scheme
Date: Sun, 23 Jun 2013 23:28:18 +0530
Message-ID: <1372010299-30141-4-git-send-email-pekon@ti.com>
References: <1372010299-30141-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38429 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3FWR7r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Jun 2013 13:59:47 -0400
In-Reply-To: <1372010299-30141-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, b-cousson@ti.com
Cc: arnd@arndb.de, avinashphilip@ti.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, jp.francois@cynove.com, Pekon Gupta <pekon@ti.com>

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

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  27 +++-
 drivers/mtd/nand/Kconfig                           |   7 +-
 drivers/mtd/nand/omap2.c                           | 166 +++++++++------------
 include/linux/platform_data/mtd-nand-omap2.h       |  10 +-
 4 files changed, 100 insertions(+), 110 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 690070e..b3f23df 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -28,26 +28,43 @@ Optional properties:
 	"hamming_code_sw"		1-bit Hamming ECC
 					- ECC calculation in software
 					- Error detection in software
+					- ECC layout compatible with S/W scheme
 
 	"hamming_code_hw"		1-bit Hamming ECC
 					- ECC calculation in hardware
 					- Error detection in software
+					- ECC layout compatible with S/W scheme
 
 	"hamming_code_hw_romcode"	1-bit Hamming ECC
 					- ECC calculation in hardware
 					- Error detection in software
-					- ECC layout compatible to ROM code
+					- ECC layout compatible with ROM code
 
-	"bch8_hw_code_detection_sw"	8-bit BCH ECC
+	"bch4_code_hw_detection_sw"	4-bit BCH ECC
 					- ECC calculation in hardware
 					- Error detection in software
-					- depends on CONFIG_MTD_NAND_ECC_BCH
+					- ECC layout compatible with S/W scheme
+					* depends on CONFIG_MTD_NAND_ECC_BCH
+
+	"bch4_code_hw"             	4-bit BCH ECC
+					- ECC calculation in hardware
+					- Error detection in hardware
+					- ECC layout compatible with ROM code
+					* depends on CONFIG_MTD_NAND_OMAP_BCH
+					* requires <elm_id> to be specified
+
+	"bch8_code_hw_detection_sw"	8-bit BCH ECC
+					- ECC calculation in hardware
+					- Error detection in software
+					- ECC layout compatible with S/W scheme
+					* depends on CONFIG_MTD_NAND_ECC_BCH
 
 	"bch8_code_hw"             	8-bit BCH ECC
 					- ECC calculation in hardware
 					- Error detection in hardware
-					- depends on CONFIG_MTD_NAND_OMAP_BCH
-					- requires <elm_id> to be specified
+					- ECC layout compatible with ROM code
+					* depends on CONFIG_MTD_NAND_OMAP_BCH
+					* requires <elm_id> to be specified
 
 
  - elm_id:			Specifies elm device node. This is required to
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index a60f6c1..623a707 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -95,16 +95,15 @@ config MTD_NAND_OMAP2
 
 config MTD_NAND_OMAP_BCH
 	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
-	bool "Enable support for hardware BCH error correction"
+	bool "Support hardware based BCH error correction"
 	default n
 	select BCH
-	select BCH_CONST_PARAMS
 	help
 	 Support for hardware BCH error correction.
 
 choice
-	prompt "BCH error correction capability"
-	depends on MTD_NAND_OMAP_BCH
+	prompt "BCH error correction capability selection (for non-DT kernel)"
+	depends on !OF_MTD && MTD_NAND_OMAP_BCH
 
 config MTD_NAND_OMAP_BCH8
 	bool "8 bits / 512 bytes (recommended)"
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index b525060..be4350f 100644
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
 
 
@@ -1730,13 +1677,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
-	info->bch		= NULL;
 
 	info->nand.options	= NAND_BUSWIDTH_AUTO;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
+	info->nand.ecc.priv			= NULL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -1933,19 +1880,42 @@ static int omap_nand_probe(struct platform_device *pdev)
 							omap_oobinfo.eccbytes;
 		goto custom_ecc_layout;
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		pr_info("using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW ECC scheme");
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.bytes		= 7;
+		info->nand.ecc.strength		= 4;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch4;
+		/* software bch library is used for locating errors */
+		info->nand.ecc.priv		= nand_bch_init(mtd,
+						info->nand.ecc.size,
+						info->nand.ecc.bytes,
+						&info->nand.ecc.layout);
+		if (!info->nand.ecc.priv) {
+			pr_err("unable initialize S/W BCH logic\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		goto generic_ecc_layout;
+#endif
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
-	case OMAP_ECC_BCH8_CODE_HW:
-		pr_info("using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
-		if (is_elm_present(info, ECC_TYPE_BCH8) < 0) {
+	case OMAP_ECC_BCH4_CODE_HW:
+		pr_info("using OMAP_ECC_BCH4_CODE_HW ECC scheme");
+		/* check if ELM module is present on SoC */
+		if (is_elm_present(info, ECC_TYPE_BCH4) < 0) {
 			pr_err("ELM module not detected, required for ECC\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
 		info->nand.ecc.mode		= NAND_ECC_HW;
 		info->nand.ecc.size		= 512;
-		/* 14th bit is kept reserved for ROM-code compatibility */
-		info->nand.ecc.bytes		= 13 + 1;
-		info->nand.ecc.strength		= 8;
+		/* 8th bit is kept reserved for ROM-code compatibility */
+		info->nand.ecc.bytes		= 7 + 1;
+		info->nand.ecc.strength		= 4;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
 		info->nand.ecc.correct		= omap_elm_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
@@ -1968,51 +1938,45 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.bytes		= 13;
 		info->nand.ecc.strength		= 8;
 		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
-		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap3_calculate_ecc_bch8;
-		/* define custom ECC layout */
-		omap_oobinfo.eccbytes		= info->nand.ecc.bytes *
-							(mtd->writesize /
-							info->nand.ecc.size);
-		omap_oobinfo.eccpos[0]		= info->mtd.oobsize -
-							omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->offset	= BADBLOCK_MARKER_LENGTH;
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
 			pr_err("unable initialize S/W BCH logic\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
-		goto custom_ecc_layout;
-
-	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-		pr_info("using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW ECC\n");
+		goto generic_ecc_layout;
+#endif
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	case OMAP_ECC_BCH8_CODE_HW:
+		pr_info("using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
+		if (is_elm_present(info, ECC_TYPE_BCH8) < 0) {
+			pr_err("ELM module not detected, required for ECC\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
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
+		info->nand.ecc.correct		= omap_elm_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
+		info->nand.ecc.read_page	= omap_read_page_bch;
+		info->nand.ecc.write_page	= omap_write_page_bch;
 		/* define custom ECC layout */
 		omap_oobinfo.eccbytes		= info->nand.ecc.bytes *
 							(mtd->writesize /
 							info->nand.ecc.size);
-		omap_oobinfo.eccpos[0]		= info->mtd.oobsize -
+		omap_oobinfo.eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		omap_oobinfo.oobfree->offset	= omap_oobinfo.eccpos[0] +
 							omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->offset	= BADBLOCK_MARKER_LENGTH;
-		/* software bch library is used for locating errors */
-		info->bch = init_bch(info->nand.ecc.bytes,
-					info->nand.ecc.strength,
-					OMAP_ECC_BCH8_POLYNOMIAL);
-		if (!info->bch) {
-			pr_err("unable initialize S/W BCH logic\n");
-			err = -EINVAL;
-			goto out_release_mem_region;
-		}
 		goto custom_ecc_layout;
 #endif
 	default:
@@ -2064,8 +2028,14 @@ out_release_mem_region:
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
@@ -2077,8 +2047,12 @@ static int omap_nand_remove(struct platform_device *pdev)
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

