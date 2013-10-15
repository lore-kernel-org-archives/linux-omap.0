From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 5/9] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in device_probe
Date: Tue, 15 Oct 2013 11:19:53 +0530
Message-ID: <1381816197-20477-6-git-send-email-pekon@ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512Ab3JOFv3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:29 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

current implementation in omap3_init_bch() has some redundant code like:
(1) omap3_init_bch() re-probes the DT-binding to detect presence of ELM h/w
    engine on SoC. And based on that it selects implemetation of ecc-scheme.
    However, this is already done as part of GPMC DT parsing.
(2) As omap3_init_bch() serves as common function for configuring all types of
    BCHx ecc-schemes, so there are multiple levels of redudant if..then..else
    checks while populating nand_chip->ecc.

This patch make following changes to OMAP NAND driver:
(1) removes omap3_init_bch(): each ecc-scheme is individually configured in
    omap_nand_probe() there by removing redundant if..then..else checks.
(2) adds is_elm_present(): re-probing of ELM device via DT is not required as
    it's done in GPMC driver probe. Thus is_elm_present() just initializes ELM
    driver with NAND probe data, when ecc-scheme with h/w based error-detection
    is used.
(3) separates out configuration of different flavours of "BCH4" and "BCH8"
    ecc-schemes as given in below table
(4) conditionally compiles callbacks implementations of ecc.hwctl(),
    ecc.calculate(), ecc.correct() to avoid warning of un-used functions.

+---------------------------------------+---------------+---------------+
| ECC scheme                            |ECC calculation|Error detection|
+---------------------------------------+---------------+---------------+
|OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
| (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
|                                       |               |               |
|OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
| (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
|        ti,elm-id)                     |               |               |
+---------------------------------------+---------------+---------------+
|OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
| (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
|                                       |               |               |
|OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
| (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
|        ti,elm-id)                     |               |               |
+---------------------------------------+---------------+---------------+

- 'CONFIG_MTD_NAND_ECC_BCH' is generic KConfig required to build lib/bch.c
    which is required for ECC error detection done in software.
    (mainly used for legacy platforms which do not have on-chip ELM engine)

- 'CONFIG_MTD_NAND_OMAP_BCH' is OMAP specific Kconfig to detemine presence
    on ELM h/w engine on SoC.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 281 ++++++++++++++++++++++++++---------------------
 1 file changed, 158 insertions(+), 123 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 57a3f51..09ce85c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -25,10 +25,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 #include <linux/bch.h>
 #include <linux/platform_data/elm.h>
-#endif
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 
@@ -141,6 +139,8 @@
 #define BCH_ECC_SIZE0		0x0	/* ecc_size0 = 0, no oob protection */
 #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
+#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
+
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
 	0xac, 0x6b, 0xff, 0x99, 0x7b};
@@ -182,14 +182,12 @@ struct omap_nand_info {
 	u_char				*buf;
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
-
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	/* fields specific for BCHx_HW ECC scheme */
 	struct bch_control             *bch;
 	struct nand_ecclayout           ecclayout;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
-#endif
 };
 
 /**
@@ -1058,8 +1056,7 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	}
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
-
+#if defined(CONFIG_MTD_NAND_ECC_BCH) || defined(CONFIG_MTD_NAND_OMAP_BCH)
 /**
  * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correction
  * @mtd: MTD device structure
@@ -1140,7 +1137,9 @@ static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 	/* Clear ecc and enable bits */
 	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
 }
+#endif
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
  * omap3_calculate_ecc_bch4 - Generate 7 bytes of ECC bytes
  * @mtd: MTD device structure
@@ -1225,7 +1224,9 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
 
 	return 0;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap3_calculate_ecc_bch - Generate bytes of ECC bytes
  * @mtd:	MTD device structure
@@ -1517,7 +1518,9 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 
 	return stat;
 }
+#endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
  * omap3_correct_data_bch - Decode received data and correct errors
  * @mtd: MTD device structure
@@ -1549,7 +1552,9 @@ static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
 	}
 	return count;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap_write_page_bch - BCH ecc based write page function for entire page
  * @mtd:		mtd info structure
@@ -1637,118 +1642,48 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
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
+	struct platform_device *pdev;
+	info->is_elm_used = false;
+	/* check whether elm-id is passed via DT */
+	if (!elm_node) {
+		pr_err("nand: error: ELM DT node not found\n");
+		return -ENODEV;
+	}
+	pdev = of_find_device_by_node(elm_node);
+	/* check whether ELM device is registered */
+	if (!pdev) {
+		pr_err("nand: error: ELM device not found\n");
+		return -ENODEV;
 	}
+	/* ELM module available, now configure it */
+	info->elm_dev = &pdev->dev;
+	if (elm_config(info->elm_dev, bch_type))
+		return -ENODEV;
+	info->is_elm_used = true;
+	return 0;
 }
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
+#ifdef CONFIG_MTD_NAND_ECC_BCH
 /**
- * omap3_init_bch - Initialize BCH ECC
+ * omap3_free_bch - Release BCH ecc resources
  * @mtd: MTD device structure
- * @ecc_opt: OMAP ECC mode (OMAP_ECC_BCH4_CODE_HW or OMAP_ECC_BCH8_CODE_HW)
  */
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
+static void omap3_free_bch(struct mtd_info *mtd)
 {
-	int max_errors;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
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
-	}
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
+	if (info->bch) {
+		free_bch(info->bch);
+		info->bch = NULL;
 	}
-
-	pr_info("enabling NAND BCH ecc with %d-bit correction\n", max_errors);
-	return 0;
-fail:
-	omap3_free_bch(mtd);
-	return -1;
 }
 
 /**
@@ -1806,11 +1741,6 @@ fail:
 }
 
 #else
-static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
-{
-	pr_err("CONFIG_MTD_NAND_OMAP_BCH is not enabled\n");
-	return -1;
-}
 static int omap3_init_bch_tail(struct mtd_info *mtd)
 {
 	return -1;
@@ -1818,7 +1748,7 @@ static int omap3_init_bch_tail(struct mtd_info *mtd)
 static void omap3_free_bch(struct mtd_info *mtd)
 {
 }
-#endif /* CONFIG_MTD_NAND_OMAP_BCH */
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
 static int omap_nand_probe(struct platform_device *pdev)
 {
@@ -1851,15 +1781,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
+	info->bch		= NULL;
+	info->of_node		= pdata->of_node;
 	mtd			= &info->mtd;
 	mtd->priv		= &info->nand;
 	mtd->name		= dev_name(&pdev->dev);
 	mtd->owner		= THIS_MODULE;
 	nand_chip		= &info->nand;
 	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
-	info->of_node		= pdata->of_node;
-#endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -2007,22 +1936,125 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	/* select the ecc type */
-	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
+	/* populate MTD interface based on ECC scheme */
+	switch (pdata->ecc_opt) {
+	case OMAP_ECC_HAM1_CODE_HW:
+		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
+		nand_chip->ecc.mode             = NAND_ECC_HW;
 		nand_chip->ecc.bytes            = 3;
 		nand_chip->ecc.size             = 512;
 		nand_chip->ecc.strength         = 1;
 		nand_chip->ecc.calculate        = omap_calculate_ecc;
 		nand_chip->ecc.hwctl            = omap_enable_hwecc;
 		nand_chip->ecc.correct          = omap_correct_data;
-		nand_chip->ecc.mode             = NAND_ECC_HW;
-	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		err = omap3_init_bch(mtd, pdata->ecc_opt);
-		if (err) {
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
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(nand_chip->ecc.bytes,
+					nand_chip->ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
+		}
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
+
+	case OMAP_ECC_BCH4_CODE_HW:
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
+		nand_chip->ecc.mode		= NAND_ECC_HW;
+		nand_chip->ecc.size		= 512;
+		/* 14th bit is kept reserved for ROM-code compatibility */
+		nand_chip->ecc.bytes		= 7 + 1;
+		nand_chip->ecc.strength		= 4;
+		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
+		nand_chip->ecc.correct		= omap_elm_correct_data;
+		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch;
+		nand_chip->ecc.read_page	= omap_read_page_bch;
+		nand_chip->ecc.write_page	= omap_write_page_bch;
+		/* This ECC scheme requires ELM H/W block */
+		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
+			pr_err("nand: error: could not initialize ELM\n");
+			err = -ENODEV;
 			goto out_release_mem_region;
 		}
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
+
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
+		/* software bch library is used for locating errors */
+		info->bch = init_bch(nand_chip->ecc.bytes,
+					nand_chip->ecc.strength,
+					OMAP_ECC_BCH8_POLYNOMIAL);
+		if (!info->bch) {
+			pr_err("nand: error: unable to use s/w BCH library\n");
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
+		break;
+#else
+		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+#endif
+
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
+			goto out_release_mem_region;
+		}
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
 	}
 
 	/* rom code layout */
@@ -2044,6 +2076,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 		nand_chip->ecc.layout = &omap_oobinfo;
 	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
+		   (pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) ||
+		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW) ||
 		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
 		/* build OOB layout for BCH ECC correction */
 		err = omap3_init_bch_tail(mtd);
@@ -2076,6 +2110,7 @@ out_release_mem_region:
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
 out_free_info:
+	omap3_free_bch(mtd);
 	kfree(info);
 
 	return err;
-- 
1.8.1

