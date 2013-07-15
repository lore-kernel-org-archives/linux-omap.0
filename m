From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 5/5] mtd: nand: omap: code clean-up and white-space fixes
Date: Mon, 15 Jul 2013 20:25:52 +0530
Message-ID: <1373900152-26885-6-git-send-email-pekon@ti.com>
References: <1373900152-26885-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38860 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235Ab3GOO5D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 10:57:03 -0400
In-Reply-To: <1373900152-26885-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, dwmw2@infradead.org
Cc: arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Pekon Gupta <pekon@ti.com>

This patch just clean-up the code and fixes spaces in omap_nand_probe()
s/info->nand./chip->
s/&info->mtd/mtd

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 210 +++++++++++++++++++++++------------------------
 1 file changed, 102 insertions(+), 108 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 7d786d9..c2c3c6bb 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1462,9 +1462,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->reg		= pdata->reg;
 	info->ecc_opt		= pdata->ecc_opt;
 
-	info->nand.options	= NAND_BUSWIDTH_AUTO;
-	info->nand.options	|= NAND_SKIP_BBTSCAN;
-	info->nand.ecc.priv	= NULL;
+	chip->options	= NAND_BUSWIDTH_AUTO;
+	chip->options	|= NAND_SKIP_BBTSCAN;
+	chip->ecc.priv	= NULL;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
@@ -1485,16 +1485,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_free_info;
 	}
 
-	info->nand.IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
-	if (!info->nand.IO_ADDR_R) {
+	chip->IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
+	if (!chip->IO_ADDR_R) {
 		err = -ENOMEM;
 		goto out_release_mem_region;
 	}
 
-	info->nand.controller = &info->controller;
+	chip->controller = &info->controller;
 
-	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
-	info->nand.cmd_ctrl  = omap_hwcontrol;
+	chip->IO_ADDR_W = chip->IO_ADDR_R;
+	chip->cmd_ctrl  = omap_hwcontrol;
 
 	/*
 	 * If RDY/BSY line is connected to OMAP then use the omap ready
@@ -1504,11 +1504,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 * device and read status register until you get a failure or success
 	 */
 	if (pdata->dev_ready) {
-		info->nand.dev_ready = omap_dev_ready;
-		info->nand.chip_delay = 0;
+		chip->dev_ready = omap_dev_ready;
+		chip->chip_delay = 0;
 	} else {
-		info->nand.waitfunc = omap_wait;
-		info->nand.chip_delay = 50;
+		chip->waitfunc = omap_wait;
+		chip->chip_delay = 50;
 	}
 
 	/* scan NAND device conncted to controller */
@@ -1517,8 +1517,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 	pr_info("%s: detected %s NAND flash\n", DRIVER_NAME,
-			(info->nand.options & NAND_BUSWIDTH_16) ? "x16" : "x8");
-	if ((info->nand.options & NAND_BUSWIDTH_16) !=
+			(chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8");
+	if ((chip->options & NAND_BUSWIDTH_16) !=
 			(pdata->devsize & NAND_BUSWIDTH_16)) {
 		pr_err("%s: but incorrectly configured as %s", DRIVER_NAME,
 			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
@@ -1538,17 +1538,17 @@ static int omap_nand_probe(struct platform_device *pdev)
 	/* populate read & write API based on xfer_type selected */
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
-		info->nand.read_buf   = omap_read_buf_pref;
-		info->nand.write_buf  = omap_write_buf_pref;
+		chip->read_buf   = omap_read_buf_pref;
+		chip->write_buf  = omap_write_buf_pref;
 		break;
 
 	case NAND_OMAP_POLLED:
-		if (info->nand.options & NAND_BUSWIDTH_16) {
-			info->nand.read_buf   = omap_read_buf16;
-			info->nand.write_buf  = omap_write_buf16;
+		if (chip->options & NAND_BUSWIDTH_16) {
+			chip->read_buf   = omap_read_buf16;
+			chip->write_buf  = omap_write_buf16;
 		} else {
-			info->nand.read_buf   = omap_read_buf8;
-			info->nand.write_buf  = omap_write_buf8;
+			chip->read_buf   = omap_read_buf8;
+			chip->write_buf  = omap_write_buf8;
 		}
 		break;
 
@@ -1577,8 +1577,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 					err);
 				goto out_release_mem_region;
 			}
-			info->nand.read_buf   = omap_read_buf_dma_pref;
-			info->nand.write_buf  = omap_write_buf_dma_pref;
+			chip->read_buf   = omap_read_buf_dma_pref;
+			chip->write_buf  = omap_write_buf_dma_pref;
 		}
 		break;
 
@@ -1613,8 +1613,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		}
 
-		info->nand.read_buf  = omap_read_buf_irq_pref;
-		info->nand.write_buf = omap_write_buf_irq_pref;
+		chip->read_buf  = omap_read_buf_irq_pref;
+		chip->write_buf = omap_write_buf_irq_pref;
 
 		break;
 
@@ -1629,34 +1629,33 @@ static int omap_nand_probe(struct platform_device *pdev)
 	switch (pdata->ecc_opt) {
 	case OMAP_ECC_HAMMING_CODE_DEFAULT:
 		pr_info("using OMAP_ECC_HAMMING_CODE_DEFAULT ECC scheme\n");
-		info->nand.ecc.mode		= NAND_ECC_SOFT;
+		chip->ecc.mode		= NAND_ECC_SOFT;
 		goto generic_ecc_layout;
 
 	case OMAP_ECC_HAMMING_CODE_HW:
 		pr_info("using OMAP_ECC_HAMMING_CODE_HW ECC scheme\n");
-		info->nand.ecc.mode             = NAND_ECC_HW;
-		info->nand.ecc.bytes            = 3;
-		info->nand.ecc.size             = 512;
-		info->nand.ecc.strength         = 1;
-		info->nand.ecc.calculate        = omap_calculate_ecc;
-		info->nand.ecc.hwctl            = omap_enable_hwecc;
-		info->nand.ecc.correct          = omap_correct_data;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.bytes		= 3;
+		chip->ecc.size		= 512;
+		chip->ecc.strength	= 1;
+		chip->ecc.calculate	= omap_calculate_ecc;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_correct_data;
 		goto generic_ecc_layout;
 
 	case OMAP_ECC_HAMMING_CODE_HW_ROMCODE:
 		pr_info("using OMAP_ECC_HAMMING_CODE_HW_ROMCODE ECC scheme\n");
-		info->nand.ecc.mode             = NAND_ECC_HW;
-		info->nand.ecc.bytes            = 3;
-		info->nand.ecc.size             = 512;
-		info->nand.ecc.strength         = 1;
-		info->nand.ecc.calculate        = omap_calculate_ecc;
-		info->nand.ecc.hwctl            = omap_enable_hwecc;
-		info->nand.ecc.correct          = omap_correct_data;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.bytes		= 3;
+		chip->ecc.size		= 512;
+		chip->ecc.strength	= 1;
+		chip->ecc.calculate	= omap_calculate_ecc;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_correct_data;
 		/* define custom ECC layout */
-		omap_oobinfo.eccbytes		= info->nand.ecc.bytes *
-							(mtd->writesize /
-							info->nand.ecc.size);
-		if (info->nand.options & NAND_BUSWIDTH_16)
+		omap_oobinfo.eccbytes	= chip->ecc.bytes *
+					(mtd->writesize / chip->ecc.size);
+		if (chip->options & NAND_BUSWIDTH_16)
 			omap_oobinfo.eccpos[0]	= BADBLOCK_MARKER_LENGTH;
 		else
 			omap_oobinfo.eccpos[0]	= 1;
@@ -1667,19 +1666,17 @@ static int omap_nand_probe(struct platform_device *pdev)
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
 		pr_info("using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW ECC scheme");
-		info->nand.ecc.mode		= NAND_ECC_HW;
-		info->nand.ecc.size		= 512;
-		info->nand.ecc.bytes		= 7;
-		info->nand.ecc.strength		= 4;
-		info->nand.ecc.hwctl		= omap_enable_hwecc;
-		info->nand.ecc.correct		= nand_bch_correct_data;
-		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		chip->ecc.bytes		= 7;
+		chip->ecc.strength	= 4;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch;
 		/* software bch library is used for locating errors */
-		info->nand.ecc.priv		= nand_bch_init(mtd,
-						info->nand.ecc.size,
-						info->nand.ecc.bytes,
-						&info->nand.ecc.layout);
-		if (!info->nand.ecc.priv) {
+		chip->ecc.priv		= nand_bch_init(mtd, chip->ecc.size,
+					   chip->ecc.bytes, &chip->ecc.layout);
+		if (!chip->ecc.priv) {
 			pr_err("unable initialize S/W BCH logic\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -1689,16 +1686,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	case OMAP_ECC_BCH4_CODE_HW:
 		pr_info("using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
-		info->nand.ecc.mode		= NAND_ECC_HW;
-		info->nand.ecc.size		= 512;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
 		/* 8th bit is kept reserved for ROM-code compatibility */
-		info->nand.ecc.bytes		= 7 + 1;
-		info->nand.ecc.strength		= 4;
-		info->nand.ecc.hwctl		= omap_enable_hwecc;
-		info->nand.ecc.correct		= omap_elm_correct_data;
-		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
-		info->nand.ecc.read_page	= omap_read_page_bch;
-		info->nand.ecc.write_page	= omap_write_page_bch;
+		chip->ecc.bytes		= 7 + 1;
+		chip->ecc.strength	= 4;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
 		/* ELM H/W engine is used for locating errors */
 		if (is_elm_present(info, BCH4_ECC) < 0) {
 			pr_err("ELM module not detected, required for ECC\n");
@@ -1706,30 +1703,27 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		}
 		/* define custom ECC layout */
-		omap_oobinfo.eccbytes		= info->nand.ecc.bytes *
-							(mtd->writesize /
-							info->nand.ecc.size);
-		omap_oobinfo.eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		omap_oobinfo.oobfree->offset	= omap_oobinfo.eccpos[0] +
-							omap_oobinfo.eccbytes;
+		omap_oobinfo.eccbytes	= chip->ecc.bytes *
+					(mtd->writesize / chip->ecc.size);
+		omap_oobinfo.eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+		omap_oobinfo.oobfree->offset = omap_oobinfo.eccpos[0] +
+						omap_oobinfo.eccbytes;
 		goto custom_ecc_layout;
 #endif
 #ifdef CONFIG_MTD_NAND_ECC_BCH
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
 		pr_info("using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW ECC\n");
-		info->nand.ecc.mode		= NAND_ECC_HW;
-		info->nand.ecc.size		= 512;
-		info->nand.ecc.bytes		= 13;
-		info->nand.ecc.strength		= 8;
-		info->nand.ecc.hwctl		= omap_enable_hwecc;
-		info->nand.ecc.correct		= nand_bch_correct_data;
-		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
+		chip->ecc.bytes		= 13;
+		chip->ecc.strength	= 8;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= nand_bch_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch;
 		/* software bch library is used for locating errors */
-		info->nand.ecc.priv		= nand_bch_init(mtd,
-						info->nand.ecc.size,
-						info->nand.ecc.bytes,
-						&info->nand.ecc.layout);
-		if (!info->nand.ecc.priv) {
+		chip->ecc.priv		= nand_bch_init(mtd, chip->ecc.size,
+					   chip->ecc.bytes, &chip->ecc.layout);
+		if (!chip->ecc.priv) {
 			pr_err("unable initialize S/W BCH logic\n");
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -1739,16 +1733,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	case OMAP_ECC_BCH8_CODE_HW:
 		pr_info("using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
-		info->nand.ecc.mode		= NAND_ECC_HW;
-		info->nand.ecc.size		= 512;
+		chip->ecc.mode		= NAND_ECC_HW;
+		chip->ecc.size		= 512;
 		/* 14th bit is kept reserved for ROM-code compatibility */
-		info->nand.ecc.bytes		= 13 + 1;
-		info->nand.ecc.strength		= 8;
-		info->nand.ecc.hwctl		= omap_enable_hwecc;
-		info->nand.ecc.correct		= omap_elm_correct_data;
-		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
-		info->nand.ecc.read_page	= omap_read_page_bch;
-		info->nand.ecc.write_page	= omap_write_page_bch;
+		chip->ecc.bytes		= 13 + 1;
+		chip->ecc.strength	= 8;
+		chip->ecc.hwctl		= omap_enable_hwecc;
+		chip->ecc.correct	= omap_elm_correct_data;
+		chip->ecc.calculate	= omap_calculate_ecc_bch;
+		chip->ecc.read_page	= omap_read_page_bch;
+		chip->ecc.write_page	= omap_write_page_bch;
 		/* ELM H/W engine is used for locating errors */
 		if (is_elm_present(info, BCH8_ECC) < 0) {
 			pr_err("ELM module not detected, required for ECC\n");
@@ -1756,16 +1750,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		}
 		/* define custom ECC layout */
-		omap_oobinfo.eccbytes		= info->nand.ecc.bytes *
-							(mtd->writesize /
-							info->nand.ecc.size);
-		omap_oobinfo.eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		omap_oobinfo.oobfree->offset	= omap_oobinfo.eccpos[0] +
-							omap_oobinfo.eccbytes;
+		omap_oobinfo.eccbytes	= chip->ecc.bytes *
+					   (mtd->writesize / chip->ecc.size);
+		omap_oobinfo.eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+		omap_oobinfo.oobfree->offset = omap_oobinfo.eccpos[0] +
+						omap_oobinfo.eccbytes;
 		goto custom_ecc_layout;
 #endif
 	default:
-		pr_err("selected ECC scheme not supported or not enabled\n");
+		pr_err("%s: selected ECC scheme not supported or not enabled",
+				DRIVER_NAME);
 		err = -EINVAL;
 		goto out_release_mem_region;
 	}
@@ -1775,8 +1769,8 @@ custom_ecc_layout:
 	pr_info("%s: using custom ecc layout\n", DRIVER_NAME);
 	omap_oobinfo.oobfree->length = mtd->oobsize - BADBLOCK_MARKER_LENGTH
 						- omap_oobinfo.eccbytes;
-	if (!(info->nand.options & NAND_BUSWIDTH_16))
-		info->nand.badblock_pattern = &bb_descrip_flashbased;
+	if (!(chip->options & NAND_BUSWIDTH_16))
+		chip->badblock_pattern = &bb_descrip_flashbased;
 	for (i = 1; i < omap_oobinfo.eccbytes; i++)
 		omap_oobinfo.eccpos[i] = omap_oobinfo.eccpos[0] + i;
 
@@ -1788,20 +1782,20 @@ custom_ecc_layout:
 		err = -EINVAL;
 		goto out_release_mem_region;
 	}
-	info->nand.ecc.layout = &omap_oobinfo;
+	chip->ecc.layout = &omap_oobinfo;
 
 generic_ecc_layout:
 	/* second phase scan */
-	if (nand_scan_tail(&info->mtd)) {
+	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
 		goto out_release_mem_region;
 	}
 
 	ppdata.of_node = pdata->of_node;
-	mtd_device_parse_register(&info->mtd, NULL, &ppdata, pdata->parts,
+	mtd_device_parse_register(mtd, NULL, &ppdata, pdata->parts,
 				  pdata->nr_parts);
 
-	platform_set_drvdata(pdev, &info->mtd);
+	platform_set_drvdata(pdev, mtd);
 
 	return 0;
 
@@ -1816,9 +1810,9 @@ out_release_mem_region:
 
 out_free_info:
 #ifdef CONFIG_MTD_NAND_ECC_BCH
-	if (info->nand.ecc.priv) {
-		nand_bch_free(info->nand.ecc.priv);
-		info->nand.ecc.priv = NULL;
+	if (chip->ecc.priv) {
+		nand_bch_free(chip->ecc.priv);
+		chip->ecc.priv = NULL;
 	}
 #endif
 	kfree(info);
-- 
1.8.1

