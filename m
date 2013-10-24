From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v11 03/10] mtd: nand: omap: cleanup: replace local references with generic framework names
Date: Thu, 24 Oct 2013 18:20:19 +0530
Message-ID: <1382619026-4182-4-git-send-email-pekon@ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab3JXMvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 08:51:42 -0400
In-Reply-To: <1382619026-4182-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

This patch updates following in omap_nand_probe() and omap_nand_remove()
- replaces "info->nand" with "nand_chip" (struct nand_chip *nand_chip)
- replaces "info->mtd" with "mtd" (struct mtd_info *mtd)
- white-space and formatting cleanup

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 112 ++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 55 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 8d521aa..5596368 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1824,10 +1824,12 @@ static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
+	struct mtd_info			*mtd;
+	struct nand_chip		*nand_chip;
 	int				err;
 	int				i, offset;
-	dma_cap_mask_t mask;
-	unsigned sig;
+	dma_cap_mask_t			mask;
+	unsigned			sig;
 	struct resource			*res;
 	struct mtd_part_parser_data	ppdata = {};
 
@@ -1846,17 +1848,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 	spin_lock_init(&info->controller.lock);
 	init_waitqueue_head(&info->controller.wq);
 
-	info->pdev = pdev;
-
+	info->pdev		= pdev;
 	info->gpmc_cs		= pdata->cs;
 	info->reg		= pdata->reg;
-
-	info->mtd.priv		= &info->nand;
-	info->mtd.name		= dev_name(&pdev->dev);
-	info->mtd.owner		= THIS_MODULE;
-
-	info->nand.options	= pdata->devsize;
-	info->nand.options	|= NAND_SKIP_BBTSCAN;
+	mtd			= &info->mtd;
+	mtd->priv		= &info->nand;
+	mtd->name		= dev_name(&pdev->dev);
+	mtd->owner		= THIS_MODULE;
+	nand_chip		= &info->nand;
+	nand_chip->options	= pdata->devsize;
+	nand_chip->options	|= NAND_SKIP_BBTSCAN;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
@@ -1877,16 +1878,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_free_info;
 	}
 
-	info->nand.IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
-	if (!info->nand.IO_ADDR_R) {
+	nand_chip->IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
+	if (!nand_chip->IO_ADDR_R) {
 		err = -ENOMEM;
 		goto out_release_mem_region;
 	}
 
-	info->nand.controller = &info->controller;
+	nand_chip->controller = &info->controller;
 
-	info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
-	info->nand.cmd_ctrl  = omap_hwcontrol;
+	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
+	nand_chip->cmd_ctrl  = omap_hwcontrol;
 
 	/*
 	 * If RDY/BSY line is connected to OMAP then use the omap ready
@@ -1896,26 +1897,26 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 * device and read status register until you get a failure or success
 	 */
 	if (pdata->dev_ready) {
-		info->nand.dev_ready = omap_dev_ready;
-		info->nand.chip_delay = 0;
+		nand_chip->dev_ready = omap_dev_ready;
+		nand_chip->chip_delay = 0;
 	} else {
-		info->nand.waitfunc = omap_wait;
-		info->nand.chip_delay = 50;
+		nand_chip->waitfunc = omap_wait;
+		nand_chip->chip_delay = 50;
 	}
 
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
-		info->nand.read_buf   = omap_read_buf_pref;
-		info->nand.write_buf  = omap_write_buf_pref;
+		nand_chip->read_buf   = omap_read_buf_pref;
+		nand_chip->write_buf  = omap_write_buf_pref;
 		break;
 
 	case NAND_OMAP_POLLED:
-		if (info->nand.options & NAND_BUSWIDTH_16) {
-			info->nand.read_buf   = omap_read_buf16;
-			info->nand.write_buf  = omap_write_buf16;
+		if (nand_chip->options & NAND_BUSWIDTH_16) {
+			nand_chip->read_buf   = omap_read_buf16;
+			nand_chip->write_buf  = omap_write_buf16;
 		} else {
-			info->nand.read_buf   = omap_read_buf8;
-			info->nand.write_buf  = omap_write_buf8;
+			nand_chip->read_buf   = omap_read_buf8;
+			nand_chip->write_buf  = omap_write_buf8;
 		}
 		break;
 
@@ -1944,8 +1945,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 					err);
 				goto out_release_mem_region;
 			}
-			info->nand.read_buf   = omap_read_buf_dma_pref;
-			info->nand.write_buf  = omap_write_buf_dma_pref;
+			nand_chip->read_buf   = omap_read_buf_dma_pref;
+			nand_chip->write_buf  = omap_write_buf_dma_pref;
 		}
 		break;
 
@@ -1980,8 +1981,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto out_release_mem_region;
 		}
 
-		info->nand.read_buf  = omap_read_buf_irq_pref;
-		info->nand.write_buf = omap_write_buf_irq_pref;
+		nand_chip->read_buf  = omap_read_buf_irq_pref;
+		nand_chip->write_buf = omap_write_buf_irq_pref;
 
 		break;
 
@@ -1994,16 +1995,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	/* select the ecc type */
 	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
-		info->nand.ecc.bytes            = 3;
-		info->nand.ecc.size             = 512;
-		info->nand.ecc.strength         = 1;
-		info->nand.ecc.calculate        = omap_calculate_ecc;
-		info->nand.ecc.hwctl            = omap_enable_hwecc;
-		info->nand.ecc.correct          = omap_correct_data;
-		info->nand.ecc.mode             = NAND_ECC_HW;
+		nand_chip->ecc.bytes            = 3;
+		nand_chip->ecc.size             = 512;
+		nand_chip->ecc.strength         = 1;
+		nand_chip->ecc.calculate        = omap_calculate_ecc;
+		nand_chip->ecc.hwctl            = omap_enable_hwecc;
+		nand_chip->ecc.correct          = omap_correct_data;
+		nand_chip->ecc.mode             = NAND_ECC_HW;
 	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
 		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		err = omap3_init_bch(&info->mtd, pdata->ecc_opt);
+		err = omap3_init_bch(mtd, pdata->ecc_opt);
 		if (err) {
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -2013,9 +2014,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
 	 */
-	if (nand_scan_ident(&info->mtd, 1, NULL)) {
-		info->nand.options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(&info->mtd, 1, NULL)) {
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		nand_chip->options ^= NAND_BUSWIDTH_16;
+		if (nand_scan_ident(mtd, 1, NULL)) {
 			err = -ENXIO;
 			goto out_release_mem_region;
 		}
@@ -2024,25 +2025,25 @@ static int omap_nand_probe(struct platform_device *pdev)
 	/* rom code layout */
 	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
 
-		if (info->nand.options & NAND_BUSWIDTH_16)
+		if (nand_chip->options & NAND_BUSWIDTH_16) {
 			offset = 2;
-		else {
+		} else {
 			offset = 1;
-			info->nand.badblock_pattern = &bb_descrip_flashbased;
+			nand_chip->badblock_pattern = &bb_descrip_flashbased;
 		}
-		omap_oobinfo.eccbytes = 3 * (info->mtd.writesize / 512);
+		omap_oobinfo.eccbytes = 3 * (mtd->writesize / 512);
 		for (i = 0; i < omap_oobinfo.eccbytes; i++)
 			omap_oobinfo.eccpos[i] = i+offset;
 
 		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->length = info->mtd.oobsize -
+		omap_oobinfo.oobfree->length = mtd->oobsize -
 					(offset + omap_oobinfo.eccbytes);
 
-		info->nand.ecc.layout = &omap_oobinfo;
+		nand_chip->ecc.layout = &omap_oobinfo;
 	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
 		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
 		/* build OOB layout for BCH ECC correction */
-		err = omap3_init_bch_tail(&info->mtd);
+		err = omap3_init_bch_tail(mtd);
 		if (err) {
 			err = -EINVAL;
 			goto out_release_mem_region;
@@ -2050,16 +2051,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
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
 
@@ -2080,9 +2081,10 @@ out_free_info:
 static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
+	struct nand_chip *nand_chip = mtd->priv;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
-	omap3_free_bch(&info->mtd);
+	omap3_free_bch(mtd);
 
 	if (info->dma)
 		dma_release_channel(info->dma);
@@ -2093,8 +2095,8 @@ static int omap_nand_remove(struct platform_device *pdev)
 		free_irq(info->gpmc_irq_fifo, info);
 
 	/* Release NAND device, its internal structures and partitions */
-	nand_release(&info->mtd);
-	iounmap(info->nand.IO_ADDR_R);
+	nand_release(mtd);
+	iounmap(nand_chip->IO_ADDR_R);
 	release_mem_region(info->phys_base, info->mem_size);
 	kfree(info);
 	return 0;
-- 
1.8.1

