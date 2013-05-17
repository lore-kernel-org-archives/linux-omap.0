From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH 1/4 v2] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in device_probe
Date: Fri, 17 May 2013 17:20:15 +0530
Message-ID: <1368791418-14330-2-git-send-email-pekon@ti.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58644 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab3EQLv2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 07:51:28 -0400
In-Reply-To: <1368791418-14330-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: "Gupta, Pekon" <pekon@ti.com>, avinashphilip@ti.com, arnd@arndb.de, tony@atomide.com, balbi@ti.com, jp.francois@cynove.com

From: "Gupta, Pekon" <pekon@ti.com>

ECC scheme on NAND devices can be implemented in multiple ways.Some using
Software algorithm, while others using in-build Hardware engines.
omap2-nand driver currently supports following flavours of ECC schemes.

+---------------------------------------+---------------+---------------+
| ECC scheme				|ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAMMING_CODE_DEFAULT		|S/W		|S/W		|
|OMAP_ECC_HAMMING_CODE_HW		|H/W (GPMC)	|S/W		|
|OMAP_ECC_HAMMING_CODE_HW_ROMCODE	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|(requires CONFIG_MTD_NAND_ECC_BCH)	|		|		|
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW	|H/W (GPMC)	|S/W		|
+---------------------------------------+---------------+---------------+
|(requires CONFIG_MTD_NAND_OMAP_BCH)	|		|		|
|OMAP_ECC_BCH8_CODE_HW			|H/W (GPMC)	|H/W (ELM)	|
+---------------------------------------+---------------+---------------+

This patch
- separates the configurations for various ECC schemes.
- fixes dependency issues based on Kconfig options.
- cleans up redundant code

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c                     | 432 +++++++++++++--------------
 include/linux/platform_data/elm.h            |   4 +
 include/linux/platform_data/mtd-nand-omap2.h |  22 +-
 3 files changed, 224 insertions(+), 234 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 8e820dd..167f8d4 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -25,8 +25,10 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 #include <linux/bch.h>
+#endif
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 #include <linux/platform_data/elm.h>
 #endif
 
@@ -141,6 +143,9 @@
 #define BCH_ECC_SIZE0		0x0	/* ecc_size0 = 0, no oob protection */
 #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
+#define BADBLOCK_MARKER_LENGTH		0x2
+#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
+
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
 	0xac, 0x6b, 0xff, 0x99, 0x7b};
@@ -182,14 +187,11 @@ struct omap_nand_info {
 	u_char				*buf;
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
-
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
-	struct bch_control             *bch;
-	struct nand_ecclayout           ecclayout;
+	/* fields specific for BCHx_HW ECC scheme */
+	struct bch_control              *bch;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
-#endif
 };
 
 /**
@@ -1058,8 +1060,6 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	}
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
-
 /**
  * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correction
  * @mtd: MTD device structure
@@ -1141,6 +1141,7 @@ static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
 }
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
  * omap3_calculate_ecc_bch4 - Generate 7 bytes of ECC bytes
  * @mtd: MTD device structure
@@ -1227,6 +1228,62 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
 }
 
 /**
+ * omap3_correct_data_bch - Decode received data and correct errors
+ * @mtd: MTD device structure
+ * @data: page data
+ * @read_ecc: ecc read from nand flash
+ * @calc_ecc: ecc read from HW ECC registers
+ */
+static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
+				  u_char *read_ecc, u_char *calc_ecc)
+{
+	int i, count;
+	/* cannot correct more than 8 errors */
+	unsigned int errloc[8];
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+
+	count = decode_bch(info->bch, NULL, 512, read_ecc, calc_ecc, NULL,
+			   errloc);
+	if (count > 0) {
+		/* correct errors */
+		for (i = 0; i < count; i++) {
+			/* correct data only, not ecc bytes */
+			if (errloc[i] < 8*512)
+				data[errloc[i]/8] ^= 1 << (errloc[i] & 7);
+			pr_debug("corrected bitflip %u\n", errloc[i]);
+		}
+	} else if (count < 0) {
+		pr_err("ecc unrecoverable error\n");
+	}
+	return count;
+}
+
+/**
+ * omap3_free_bch - Release BCH ecc resources
+ * @mtd: MTD device structure
+ */
+static void omap3_free_bch(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	if (info->bch) {
+		free_bch(info->bch);
+		info->bch = NULL;
+	}
+}
+
+#else
+
+static void omap3_free_bch(struct mtd_info *mtd)
+{
+}
+
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
+
+
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+/**
  * omap3_calculate_ecc_bch - Generate bytes of ECC bytes
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
@@ -1519,38 +1576,6 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 }
 
 /**
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
  * omap_write_page_bch - BCH ecc based write page function for entire page
  * @mtd:		mtd info structure
  * @chip:		nand chip info structure
@@ -1637,194 +1662,45 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /**
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
-/**
- * omap3_init_bch - Initialize BCH ECC
- * @mtd: MTD device structure
- * @ecc_opt: OMAP ECC mode (OMAP_ECC_BCH4_CODE_HW or OMAP_ECC_BCH8_CODE_HW)
+ * is_elm_present - checks for presence of ELM module by scanning DT nodes
+ * @omap_nand_info: NAND device structure containing platform data
+ * @bch_type: 0x0=BCH4, 0x1=BCH8, 0x2=BCH16
  */
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
+static int is_elm_present(struct omap_nand_info *info, int bch_type)
 {
-	int max_errors;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-#ifdef CONFIG_MTD_NAND_OMAP_BCH8
-	const int hw_errors = BCH8_MAX_ERROR;
-#else
-	const int hw_errors = BCH4_MAX_ERROR;
-#endif
-	enum bch_ecc bch_type;
 	const __be32 *parp;
 	int lenp;
 	struct device_node *elm_node;
-
-	info->bch = NULL;
-
-	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ?
-		BCH8_MAX_ERROR : BCH4_MAX_ERROR;
-	if (max_errors != hw_errors) {
-		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
-		       max_errors, hw_errors);
-		goto fail;
-	}
-
-	info->nand.ecc.size = 512;
-	info->nand.ecc.hwctl = omap3_enable_hwecc_bch;
-	info->nand.ecc.mode = NAND_ECC_HW;
-	info->nand.ecc.strength = max_errors;
-
-	if (hw_errors == BCH8_MAX_ERROR)
-		bch_type = BCH8_ECC;
-	else
-		bch_type = BCH4_ECC;
+	struct platform_device *pdev;
+	info->is_elm_used = false;
 
 	/* Detect availability of ELM module */
 	parp = of_get_property(info->of_node, "elm_id", &lenp);
 	if ((parp == NULL) && (lenp != (sizeof(void *) * 2))) {
 		pr_err("Missing elm_id property, fall back to Software BCH\n");
-		info->is_elm_used = false;
 	} else {
-		struct platform_device *pdev;
-
 		elm_node = of_find_node_by_phandle(be32_to_cpup(parp));
 		pdev = of_find_device_by_node(elm_node);
 		info->elm_dev = &pdev->dev;
+		/* ELM module available, now configure it */
 		elm_config(info->elm_dev, bch_type);
 		info->is_elm_used = true;
+		return 0;
 	}
 
-	if (info->is_elm_used && (mtd->writesize <= 4096)) {
-
-		if (hw_errors == BCH8_MAX_ERROR)
-			info->nand.ecc.bytes = BCH8_SIZE;
-		else
-			info->nand.ecc.bytes = BCH4_SIZE;
-
-		info->nand.ecc.correct = omap_elm_correct_data;
-		info->nand.ecc.calculate = omap3_calculate_ecc_bch;
-		info->nand.ecc.read_page = omap_read_page_bch;
-		info->nand.ecc.write_page = omap_write_page_bch;
-	} else {
-		/*
-		 * software bch library is only used to detect and
-		 * locate errors
-		 */
-		info->bch = init_bch(13, max_errors,
-				0x201b /* hw polynomial */);
-		if (!info->bch)
-			goto fail;
-
-		info->nand.ecc.correct = omap3_correct_data_bch;
-
-		/*
-		 * The number of corrected errors in an ecc block that will
-		 * trigger block scrubbing defaults to the ecc strength (4 or 8)
-		 * Set mtd->bitflip_threshold here to define a custom threshold.
-		 */
-
-		if (max_errors == 8) {
-			info->nand.ecc.bytes = 13;
-			info->nand.ecc.calculate = omap3_calculate_ecc_bch8;
-		} else {
-			info->nand.ecc.bytes = 7;
-			info->nand.ecc.calculate = omap3_calculate_ecc_bch4;
-		}
-	}
-
-	pr_info("enabling NAND BCH ecc with %d-bit correction\n", max_errors);
-	return 0;
-fail:
-	omap3_free_bch(mtd);
-	return -1;
-}
-
-/**
- * omap3_init_bch_tail - Build an oob layout for BCH ECC correction.
- * @mtd: MTD device structure
- */
-static int omap3_init_bch_tail(struct mtd_info *mtd)
-{
-	int i, steps, offset;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-	struct nand_ecclayout *layout = &info->ecclayout;
-
-	/* build oob layout */
-	steps = mtd->writesize/info->nand.ecc.size;
-	layout->eccbytes = steps*info->nand.ecc.bytes;
-
-	/* do not bother creating special oob layouts for small page devices */
-	if (mtd->oobsize < 64) {
-		pr_err("BCH ecc is not supported on small page devices\n");
-		goto fail;
-	}
-
-	/* reserve 2 bytes for bad block marker */
-	if (layout->eccbytes+2 > mtd->oobsize) {
-		pr_err("no oob layout available for oobsize %d eccbytes %u\n",
-		       mtd->oobsize, layout->eccbytes);
-		goto fail;
-	}
-
-	/* ECC layout compatible with RBL for BCH8 */
-	if (info->is_elm_used && (info->nand.ecc.bytes == BCH8_SIZE))
-		offset = 2;
-	else
-		offset = mtd->oobsize - layout->eccbytes;
-
-	/* put ecc bytes at oob tail */
-	for (i = 0; i < layout->eccbytes; i++)
-		layout->eccpos[i] = offset + i;
-
-	if (info->is_elm_used && (info->nand.ecc.bytes == BCH8_SIZE))
-		layout->oobfree[0].offset = 2 + layout->eccbytes * steps;
-	else
-		layout->oobfree[0].offset = 2;
-
-	layout->oobfree[0].length = mtd->oobsize-2-layout->eccbytes;
-	info->nand.ecc.layout = layout;
-
-	if (!(info->nand.options & NAND_BUSWIDTH_16))
-		info->nand.badblock_pattern = &bb_descrip_flashbased;
-	return 0;
-fail:
-	omap3_free_bch(mtd);
-	return -1;
-}
-
-#else
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
-{
-	pr_err("CONFIG_MTD_NAND_OMAP_BCH is not enabled\n");
-	return -1;
-}
-static int omap3_init_bch_tail(struct mtd_info *mtd)
-{
-	return -1;
-}
-static void omap3_free_bch(struct mtd_info *mtd)
-{
+	return -ENODEV;
 }
 #endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	int				err;
-	int				i, offset;
+	int				i;
+	int				offset = BADBLOCK_MARKER_LENGTH;
+	unsigned int			eccsteps;
 	dma_cap_mask_t mask;
 	unsigned sig;
 	struct resource			*res;
@@ -1991,11 +1867,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	/* select the ecc type */
-	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_DEFAULT)
+	/* populate MTD interface based on ECC scheme */
+	switch (pdata->ecc_opt) {
+	case OMAP_ECC_HAMMING_CODE_DEFAULT:
 		info->nand.ecc.mode = NAND_ECC_SOFT;
-	else if ((pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW) ||
-		(pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE)) {
+		break;
+
+	case OMAP_ECC_HAMMING_CODE_HW:
+	case OMAP_ECC_HAMMING_CODE_HW_ROMCODE:
 		info->nand.ecc.bytes            = 3;
 		info->nand.ecc.size             = 512;
 		info->nand.ecc.strength         = 1;
@@ -2003,13 +1882,72 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.hwctl            = omap_enable_hwecc;
 		info->nand.ecc.correct          = omap_correct_data;
 		info->nand.ecc.mode             = NAND_ECC_HW;
-	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		err = omap3_init_bch(&info->mtd, pdata->ecc_opt);
-		if (err) {
+		info->bch			= NULL;
+		break;
+
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	case OMAP_ECC_BCH8_CODE_HW:
+		/* check if ELM module is present on SoC */
+		if (is_elm_present(info, ECC_TYPE_BCH8) < 0) {
+			pr_err("ELM module not detected, required for ECC\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.bytes		= 14;
+		info->nand.ecc.strength		= 8;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= omap_elm_correct_data;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch;
+		info->nand.ecc.read_page	= omap_read_page_bch;
+		info->nand.ecc.write_page	= omap_write_page_bch;
+		info->bch			= NULL;
+		break;
+#endif
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.bytes		= 13;
+		info->nand.ecc.strength		= 8;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch8;
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(info->nand.ecc.bytes,
+					info->nand.ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("unable initialize S/W BCH logic\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		break;
+
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		info->nand.ecc.mode		= NAND_ECC_HW;
+		info->nand.ecc.size		= 512;
+		info->nand.ecc.bytes		= 7;
+		info->nand.ecc.strength		= 4;
+		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.correct		= omap3_correct_data_bch;
+		info->nand.ecc.calculate	= omap3_calculate_ecc_bch4;
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(info->nand.ecc.bytes,
+					info->nand.ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("unable initialize S/W BCH logic\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		break;
+#endif
+	default:
+		pr_err("selected ECC scheme not supported or not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
 	}
 
 	/* DIP switches on some boards change between 8 and 16 bit
@@ -2022,35 +1960,73 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		}
 	}
+	eccsteps = info->mtd.writesize / info->nand.ecc.size;
+
+	/* check if NAND OOBSIZE meets ECC scheme requirement */
+	omap_oobinfo.eccbytes = eccsteps * info->nand.ecc.bytes;
 
-	/* rom code layout */
-	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE) {
+	if (info->mtd.oobsize < (omap_oobinfo.eccbytes +
+					BADBLOCK_MARKER_LENGTH)) {
+		pr_err("not enough OOB bytes required = %d, available=%d",
+		       info->mtd.oobsize, omap_oobinfo.eccbytes);
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
 
+	/* populate ECC layout information based on ECC scheme */
+	switch (pdata->ecc_opt) {
+	case OMAP_ECC_HAMMING_CODE_HW_ROMCODE:
 		if (info->nand.options & NAND_BUSWIDTH_16)
 			offset = 2;
-		else {
+		else
 			offset = 1;
-			info->nand.badblock_pattern = &bb_descrip_flashbased;
+		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
+		break;
+
+	case OMAP_ECC_BCH4_CODE_HW:
+	case OMAP_ECC_BCH8_CODE_HW:
+		/* check for small page devices */
+		if (info->mtd.oobsize < 64) {
+			pr_err("small page devices are not supported\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
 		}
-		omap_oobinfo.eccbytes = 3 * (info->mtd.oobsize/16);
-		for (i = 0; i < omap_oobinfo.eccbytes; i++)
-			omap_oobinfo.eccpos[i] = i+offset;
+		/* ECC layout compatible with RBL for BCH8 */
+		offset = BADBLOCK_MARKER_LENGTH;
+		omap_oobinfo.oobfree->offset = BADBLOCK_MARKER_LENGTH +
+						omap_oobinfo.eccbytes;
+		break;
 
-		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->length = info->mtd.oobsize -
-					(offset + omap_oobinfo.eccbytes);
-
-		info->nand.ecc.layout = &omap_oobinfo;
-	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		/* build OOB layout for BCH ECC correction */
-		err = omap3_init_bch_tail(&info->mtd);
-		if (err) {
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		/* check for small page devices */
+		if (info->mtd.oobsize < 64) {
+			pr_err("small page devices are not supported\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
 		}
+		offset = info->mtd.oobsize - omap_oobinfo.eccbytes;
+		omap_oobinfo.oobfree->offset = BADBLOCK_MARKER_LENGTH;
+		break;
+
+	default:
+		pr_info("using default ecc layout for NAND device");
+		goto scan_tail;
 	}
 
+	/* populate other ecc_layout information based on ECC scheme */
+	if (!(info->nand.options & NAND_BUSWIDTH_16))
+		info->nand.badblock_pattern = &bb_descrip_flashbased;
+
+	omap_oobinfo.oobfree->length = info->mtd.oobsize -
+			(BADBLOCK_MARKER_LENGTH + omap_oobinfo.eccbytes);
+
+	for (i = 0; i < omap_oobinfo.eccbytes; i++)
+		omap_oobinfo.eccpos[i] = offset + i;
+
+	info->nand.ecc.layout = &omap_oobinfo;
+
+scan_tail:
 	/* second phase scan */
 	if (nand_scan_tail(&info->mtd)) {
 		err = -ENXIO;
@@ -2074,11 +2050,13 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
+	omap3_free_bch(&info->mtd);
 	kfree(info);
 
 	return err;
 }
 
+
 static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index 1bd5244..9dfb2ed 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -23,6 +23,10 @@ enum bch_ecc {
 	BCH8_ECC,
 };
 
+#define ECC_TYPE_BCH4                (0x0 << 0)
+#define ECC_TYPE_BCH8                (0x1 << 0)
+#define ECC_TYPE_BCH16               (0x2 << 0)
+
 /* ELM support 8 error syndrome process */
 #define ERROR_VECTOR_MAX		8
 
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 6bf9ef4..ce74576 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -23,13 +23,21 @@ enum nand_io {
 };
 
 enum omap_ecc {
-		/* 1-bit ecc: stored at end of spare area */
-	OMAP_ECC_HAMMING_CODE_DEFAULT = 0, /* Default, s/w method */
-	OMAP_ECC_HAMMING_CODE_HW, /* gpmc to detect the error */
-		/* 1-bit ecc: stored at beginning of spare area as romcode */
-	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
-	OMAP_ECC_BCH4_CODE_HW, /* 4-bit BCH ecc code */
-	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
+	/* 1-bit  ECC calculation by Software, Error detection by Software */
+	OMAP_ECC_HAMMING_CODE_DEFAULT = 0,
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_HAMMING_CODE_HW,
+	/* 1-bit  ECC calculation by GPMC, Error detection by Software */
+	/* ECC layout compatible to legacy ROMCODE. */
+	OMAP_ECC_HAMMING_CODE_HW_ROMCODE,
+	/* 4-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH4_CODE_HW,
+	/* 4-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH4_CODE_HW_DETECTION_SW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by ELM */
+	OMAP_ECC_BCH8_CODE_HW,
+	/* 8-bit  ECC calculation by GPMC, Error detection by Software */
+	OMAP_ECC_BCH8_CODE_HW_DETECTION_SW
 };
 
 struct gpmc_nand_regs {
-- 
1.8.1

