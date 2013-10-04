From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v7 3/6] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in device_probe
Date: Sat, 5 Oct 2013 01:19:45 +0530
Message-ID: <1380916188-24206-4-git-send-email-pekon@ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39906 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab3JDTvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Oct 2013 15:51:15 -0400
In-Reply-To: <1380916188-24206-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

OMAP NAND driver support multiple ECC scheme, which can used in following
different flavours, depending on in-build Hardware engines supported by SoC.

+---------------------------------------+---------------+---------------+
| ECC scheme                            |ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
|(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
|(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
| ti,elm-id in DT)                      |               |               |
+---------------------------------------+---------------+---------------+
To optimize footprint of omap2-nand driver, selection of some ECC schemes
also require enabling following Kconfigs, in addition to setting appropriate
DT bindings
- Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algorithm
- Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algorithm

This patch
- removes OMAP_ECC_HAMMING_CODE_DEFAULT and OMAP_ECC_HAMMING_CODE_HW_ROMCODE
- separates the configurations for other ECC schemes
- fixes dependency issues based on Kconfig options
- updates ELM device detection in is_elm_present()
- cleans redundant code

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 450 +++++++++++++++++++++++------------------------
 1 file changed, 220 insertions(+), 230 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 8d521aa..fb96251 100644
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
 
+#define BADBLOCK_MARKER_LENGTH		2
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
@@ -1058,8 +1060,7 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	}
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
-
+#if defined(CONFIG_MTD_NAND_ECC_BCH) || defined(CONFIG_MTD_NAND_OMAP_BCH)
 /**
  * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correction
  * @mtd: MTD device structure
@@ -1140,7 +1141,9 @@ static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 	/* Clear ecc and enable bits */
 	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
 }
+#endif
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
  * omap3_calculate_ecc_bch4 - Generate 7 bytes of ECC bytes
  * @mtd: MTD device structure
@@ -1225,7 +1228,9 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
 
 	return 0;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap3_calculate_ecc_bch - Generate bytes of ECC bytes
  * @mtd:	MTD device structure
@@ -1517,7 +1522,9 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 
 	return stat;
 }
+#endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
  * omap3_correct_data_bch - Decode received data and correct errors
  * @mtd: MTD device structure
@@ -1549,7 +1556,9 @@ static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
 	}
 	return count;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap_write_page_bch - BCH ecc based write page function for entire page
  * @mtd:		mtd info structure
@@ -1637,197 +1646,68 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /**
- * omap3_free_bch - Release BCH ecc resources
- * @mtd: MTD device structure
+ * is_elm_present - checks for presence of ELM module by scanning DT nodes
+ * @omap_nand_info: NAND device structure containing platform data
+ * @bch_type: 0x0=BCH4, 0x1=BCH8, 0x2=BCH16
  */
-static void omap3_free_bch(struct mtd_info *mtd)
+static int is_elm_present(struct omap_nand_info *info,
+			struct device_node *elm_node, enum bch_ecc bch_type)
 {
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
- */
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
-{
-	int max_errors;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
-#ifdef CONFIG_MTD_NAND_OMAP_BCH8
-	const int hw_errors = BCH8_MAX_ERROR;
-#else
-	const int hw_errors = BCH4_MAX_ERROR;
-#endif
-	enum bch_ecc bch_type;
-	const __be32 *parp;
-	int lenp;
-	struct device_node *elm_node;
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
-
-	/* Detect availability of ELM module */
-	parp = of_get_property(info->of_node, "elm_id", &lenp);
-	if ((parp == NULL) && (lenp != (sizeof(void *) * 2))) {
-		pr_err("Missing elm_id property, fall back to Software BCH\n");
-		info->is_elm_used = false;
-	} else {
-		struct platform_device *pdev;
-
-		elm_node = of_find_node_by_phandle(be32_to_cpup(parp));
-		pdev = of_find_device_by_node(elm_node);
-		info->elm_dev = &pdev->dev;
-
-		if (elm_config(info->elm_dev, bch_type) == 0)
-			info->is_elm_used = true;
+	struct platform_device *pdev;
+	info->is_elm_used = false;
+	/* check whether elm-id is passed via DT */
+	if (!elm_node) {
+		pr_err("nand: error: ELM DT node not found\n");
+		return -ENODEV;
 	}
-
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
+	pdev = of_find_device_by_node(elm_node);
+	/* check whether ELM device is registered */
+	if (!pdev) {
+		pr_err("nand: error: ELM device not found\n");
+		return -ENODEV;
 	}
-
-	pr_info("enabling NAND BCH ecc with %d-bit correction\n", max_errors);
+	/* ELM module available, now configure it */
+	info->elm_dev = &pdev->dev;
+	if (elm_config(info->elm_dev, bch_type))
+		return -ENODEV;
+	info->is_elm_used = true;
 	return 0;
-fail:
-	omap3_free_bch(mtd);
-	return -1;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
- * omap3_init_bch_tail - Build an oob layout for BCH ECC correction.
+ * omap3_free_bch - Release BCH ecc resources
  * @mtd: MTD device structure
  */
-static int omap3_init_bch_tail(struct mtd_info *mtd)
+static void omap3_free_bch(struct mtd_info *mtd)
 {
-	int i, steps, offset;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
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
+	if (info->bch) {
+		free_bch(info->bch);
+		info->bch = NULL;
 	}
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
 }
 
 #else
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
-{
-	pr_err("CONFIG_MTD_NAND_OMAP_BCH is not enabled\n");
-	return -1;
-}
-static int omap3_init_bch_tail(struct mtd_info *mtd)
-{
-	return -1;
-}
+
 static void omap3_free_bch(struct mtd_info *mtd)
 {
 }
-#endif /* CONFIG_MTD_NAND_OMAP_BCH */
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
+	struct mtd_info			*mtd;
+	struct nand_chip		*nand_chip;
+	struct nand_ecclayout		*ecclayout;
 	int				err;
-	int				i, offset;
-	dma_cap_mask_t mask;
-	unsigned sig;
+	int				i;
+	dma_cap_mask_t			mask;
+	unsigned			sig;
 	struct resource			*res;
 	struct mtd_part_parser_data	ppdata = {};
 
@@ -1846,20 +1726,18 @@ static int omap_nand_probe(struct platform_device *pdev)
 	spin_lock_init(&info->controller.lock);
 	init_waitqueue_head(&info->controller.wq);
 
-	info->pdev = pdev;
-
+	mtd			= &info->mtd;
+	mtd->name		= dev_name(&pdev->dev);
+	mtd->owner		= THIS_MODULE;
+	mtd->priv		= &info->nand;
+	nand_chip		= &info->nand;
+	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
+	info->bch		= NULL;
 
-	info->mtd.priv		= &info->nand;
-	info->mtd.name		= dev_name(&pdev->dev);
-	info->mtd.owner		= THIS_MODULE;
-
-	info->nand.options	= pdata->devsize;
-	info->nand.options	|= NAND_SKIP_BBTSCAN;
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
 	info->of_node		= pdata->of_node;
-#endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -1903,6 +1781,30 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.chip_delay = 50;
 	}
 
+	/* scan NAND device conncted to controller */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		err = -ENXIO;
+		goto out_release_mem_region;
+	}
+	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
+			(nand_chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8");
+	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
+			(pdata->devsize & NAND_BUSWIDTH_16)) {
+		pr_err("%s: but incorrectly configured as %s", DRIVER_NAME,
+			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
+
+	/* check for small page devices */
+	if ((mtd->oobsize < 64) &&
+		(pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
+		pr_err("small page devices are not supported\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
+
+	/* populate read & write API based on xfer_type selected */
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		info->nand.read_buf   = omap_read_buf_pref;
@@ -1992,61 +1894,148 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	/* select the ecc type */
-	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
-		info->nand.ecc.bytes            = 3;
-		info->nand.ecc.size             = 512;
-		info->nand.ecc.strength         = 1;
-		info->nand.ecc.calculate        = omap_calculate_ecc;
-		info->nand.ecc.hwctl            = omap_enable_hwecc;
-		info->nand.ecc.correct          = omap_correct_data;
-		info->nand.ecc.mode             = NAND_ECC_HW;
-	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		err = omap3_init_bch(&info->mtd, pdata->ecc_opt);
-		if (err) {
+	/* populate MTD interface based on ECC scheme */
+	nand_chip->ecc.layout	= &omap_oobinfo;
+	ecclayout		= &omap_oobinfo;
+	switch (pdata->ecc_opt) {
+	case OMAP_ECC_HAM1_CODE_HW:
+		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
+		nand_chip->ecc.mode             = NAND_ECC_HW;
+		nand_chip->ecc.bytes            = 3;
+		nand_chip->ecc.size             = 512;
+		nand_chip->ecc.strength         = 1;
+		nand_chip->ecc.calculate        = omap_calculate_ecc;
+		nand_chip->ecc.hwctl            = omap_enable_hwecc;
+		nand_chip->ecc.correct          = omap_correct_data;
+		/* define custom ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		if (nand_chip->options & NAND_BUSWIDTH_16)
+			ecclayout->eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+		else
+			ecclayout->eccpos[0]	= 1;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
+		break;
+
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW\n");
+		nand_chip->ecc.mode		= NAND_ECC_HW;
+		nand_chip->ecc.size		= 512;
+		nand_chip->ecc.bytes		= 7;
+		nand_chip->ecc.strength		= 4;
+		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
+		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
+		/* define custom ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(nand_chip->ecc.bytes,
+					nand_chip->ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
-			goto out_release_mem_region;
 		}
-	}
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
 
-	/* DIP switches on some boards change between 8 and 16 bit
-	 * bus widths for flash.  Try the other width if the first try fails.
-	 */
-	if (nand_scan_ident(&info->mtd, 1, NULL)) {
-		info->nand.options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(&info->mtd, 1, NULL)) {
-			err = -ENXIO;
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+#ifdef CONFIG_MTD_NAND_ECC_BCH
+		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
+		nand_chip->ecc.mode		= NAND_ECC_HW;
+		nand_chip->ecc.size		= 512;
+		nand_chip->ecc.bytes		= 13;
+		nand_chip->ecc.strength		= 8;
+		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
+		nand_chip->ecc.correct		= omap3_correct_data_bch;
+		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch8;
+		/* define custom ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(nand_chip->ecc.bytes,
+					nand_chip->ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("nand: error: unable to use s/w BCH library\n");
+			err = -EINVAL;
 			goto out_release_mem_region;
 		}
-	}
-
-	/* rom code layout */
-	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
 
-		if (info->nand.options & NAND_BUSWIDTH_16)
-			offset = 2;
-		else {
-			offset = 1;
-			info->nand.badblock_pattern = &bb_descrip_flashbased;
-		}
-		omap_oobinfo.eccbytes = 3 * (info->mtd.writesize / 512);
-		for (i = 0; i < omap_oobinfo.eccbytes; i++)
-			omap_oobinfo.eccpos[i] = i+offset;
-
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
-			err = -EINVAL;
+	case OMAP_ECC_BCH8_CODE_HW:
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
+		nand_chip->ecc.mode		= NAND_ECC_HW;
+		nand_chip->ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		nand_chip->ecc.bytes		= 13 + 1;
+		nand_chip->ecc.strength		= 8;
+		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
+		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch;
+		nand_chip->ecc.read_page	= omap_read_page_bch;
+		nand_chip->ecc.write_page	= omap_write_page_bch;
+		/* This ECC scheme requires ELM H/W block */
+		if (is_elm_present(info, pdata->elm_of_node, BCH8_ECC) < 0) {
+			pr_err("nand: error: could not initialize ELM\n");
 			goto out_release_mem_region;
 		}
+		/* define custom ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
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
+	default:
+		pr_err("nand: error: invalid or unsupported ECC scheme\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
+
+	/* populate remaining info for custom ecc layout */
+	pr_info("%s: using custom ecc layout\n", DRIVER_NAME);
+	ecclayout->oobfree->length = mtd->oobsize - BADBLOCK_MARKER_LENGTH
+						- ecclayout->eccbytes;
+	if (!(nand_chip->options & NAND_BUSWIDTH_16))
+		nand_chip->badblock_pattern = &bb_descrip_flashbased;
+	for (i = 1; i < ecclayout->eccbytes; i++)
+		ecclayout->eccpos[i] = ecclayout->eccpos[0] + i;
+	/* check if NAND OOBSIZE meets ECC scheme requirement */
+	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
+		pr_err("not enough OOB bytes required = %d, available=%d\n",
+			ecclayout->eccbytes, mtd->oobsize);
+		err = -EINVAL;
+		goto out_release_mem_region;
 	}
 
 	/* second phase scan */
@@ -2072,6 +2061,7 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
+	omap3_free_bch(&info->mtd);
 	kfree(info);
 
 	return err;
-- 
1.8.1

