From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v10 09/10] mtd: nand: omap: updated devm_xx for all resource allocation and free calls
Date: Sat, 19 Oct 2013 14:14:13 +0530
Message-ID: <1382172254-12448-10-git-send-email-pekon@ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab3JSIpw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Oct 2013 04:45:52 -0400
In-Reply-To: <1382172254-12448-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, jp.francois@cynove.com, ivan.djelic@parrot.com, Pekon Gupta <pekon@ti.com>

"Managed Device Resource" or devm_xx calls takes care of automatic freeing
of the resource in case of:
- failure during driver probe
- failure during resource allocation
- detaching or unloading of driver module (rmmod)
Reference: Documentation/driver-model/devres.txt

Though OMAP NAND driver handles freeing of resource allocation in most of
the cases, but using devm_xx provides more clean and effortless approach
to handle all such cases.

- simplifies label for exiting probe during error
  s/out_release_mem_region/return_error

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 89 ++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4f8efe0..45433f4 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1642,7 +1642,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
+				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -1667,22 +1668,23 @@ static int omap_nand_probe(struct platform_device *pdev)
 	if (res == NULL) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "error getting memory resource\n");
-		goto out_free_info;
+		goto return_error;
 	}
 
 	info->phys_base = res->start;
 	info->mem_size = resource_size(res);
 
-	if (!request_mem_region(info->phys_base, info->mem_size,
-				pdev->dev.driver->name)) {
+	if (!devm_request_mem_region(&pdev->dev, info->phys_base,
+				info->mem_size,	pdev->dev.driver->name)) {
 		err = -EBUSY;
-		goto out_free_info;
+		goto return_error;
 	}
 
-	nand_chip->IO_ADDR_R = ioremap(info->phys_base, info->mem_size);
+	nand_chip->IO_ADDR_R = devm_ioremap(&pdev->dev, info->phys_base,
+						info->mem_size);
 	if (!nand_chip->IO_ADDR_R) {
 		err = -ENOMEM;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	nand_chip->controller = &info->controller;
@@ -1718,13 +1720,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 			nand_chip->options |= pdata->devsize;
 			if (nand_scan_ident(mtd, 1, NULL)) {
 				err = -ENXIO;
-				goto out_release_mem_region;
+				goto return_error;
 			}
 		} else {
 			/* some genuine failure, because even platform-data
 			 * (DT binding) says that bus-width is x8 */
 			err = -ENXIO;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 	} else {
 		/* nand_scan_ident passed with x8 mode */
@@ -1733,7 +1735,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 			pr_err("%s: incorrect bus-width config\n", DRIVER_NAME);
 			err = -EINVAL;
 			err = -ENXIO;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 	}
 
@@ -1741,7 +1743,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
 		pr_err("small page devices are not supported\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	/* re-populate low-level callbacks based on xfer modes */
@@ -1769,7 +1771,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (!info->dma) {
 			dev_err(&pdev->dev, "DMA engine request failed\n");
 			err = -ENXIO;
-			goto out_release_mem_region;
+			goto return_error;
 		} else {
 			struct dma_slave_config cfg;
 
@@ -1784,7 +1786,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 			if (err) {
 				dev_err(&pdev->dev, "DMA engine slave config failed: %d\n",
 					err);
-				goto out_release_mem_region;
+				goto return_error;
 			}
 			nand_chip->read_buf   = omap_read_buf_dma_pref;
 			nand_chip->write_buf  = omap_write_buf_dma_pref;
@@ -1796,30 +1798,32 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (info->gpmc_irq_fifo <= 0) {
 			dev_err(&pdev->dev, "error getting fifo irq\n");
 			err = -ENODEV;
-			goto out_release_mem_region;
+			goto return_error;
 		}
-		err = request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
-					IRQF_SHARED, "gpmc-nand-fifo", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
+					omap_nand_irq, IRQF_SHARED,
+					"gpmc-nand-fifo", info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
 						info->gpmc_irq_fifo, err);
 			info->gpmc_irq_fifo = 0;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 
 		info->gpmc_irq_count = platform_get_irq(pdev, 1);
 		if (info->gpmc_irq_count <= 0) {
 			dev_err(&pdev->dev, "error getting count irq\n");
 			err = -ENODEV;
-			goto out_release_mem_region;
+			goto return_error;
 		}
-		err = request_irq(info->gpmc_irq_count,	omap_nand_irq,
-					IRQF_SHARED, "gpmc-nand-count", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
+					omap_nand_irq, IRQF_SHARED,
+					"gpmc-nand-count", info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
 						info->gpmc_irq_count, err);
 			info->gpmc_irq_count = 0;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 
 		nand_chip->read_buf  = omap_read_buf_irq_pref;
@@ -1831,7 +1835,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"xfer_type(%d) not supported!\n", pdata->xfer_type);
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	/* populate MTD interface based on ECC scheme */
@@ -1889,7 +1893,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 #endif
 
 	case OMAP_ECC_BCH4_CODE_HW:
@@ -1916,13 +1920,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
 			pr_err("nand: error: could not initialize ELM\n");
 			err = -ENODEV;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 		break;
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 #endif
 
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
@@ -1950,13 +1954,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (!nand_chip->ecc.priv) {
 			pr_err("nand: error: unable to use s/w BCH library\n");
 			err = -EINVAL;
-			goto out_release_mem_region;
+			goto return_error;
 		}
 		break;
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 #endif
 
 	case OMAP_ECC_BCH8_CODE_HW:
@@ -1975,7 +1979,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		/* This ECC scheme requires ELM H/W block */
 		if (is_elm_present(info, pdata->elm_of_node, BCH8_ECC) < 0) {
 			pr_err("nand: error: could not initialize ELM\n");
-			goto out_release_mem_region;
+			goto return_error;
 		}
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
@@ -1988,13 +1992,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 #endif
 
 	default:
 		pr_err("nand: error: invalid or unsupported ECC scheme\n");
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	/* populate remaining ECC layout data */
@@ -2007,13 +2011,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		pr_err("not enough OOB bytes required = %d, available=%d\n",
 					   ecclayout->eccbytes, mtd->oobsize);
 		err = -EINVAL;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
 		err = -ENXIO;
-		goto out_release_mem_region;
+		goto return_error;
 	}
 
 	ppdata.of_node = pdata->of_node;
@@ -2024,21 +2028,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_release_mem_region:
+return_error:
 	if (info->dma)
 		dma_release_channel(info->dma);
-	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
-	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
-	release_mem_region(info->phys_base, info->mem_size);
-out_free_info:
 	if (nand_chip->ecc.priv) {
 		nand_bch_free(nand_chip->ecc.priv);
 		nand_chip->ecc.priv = NULL;
 	}
-	kfree(info);
-
 	return err;
 }
 
@@ -2052,20 +2048,9 @@ static int omap_nand_remove(struct platform_device *pdev)
 		nand_bch_free(nand_chip->ecc.priv);
 		nand_chip->ecc.priv = NULL;
 	}
-
 	if (info->dma)
 		dma_release_channel(info->dma);
-
-	if (info->gpmc_irq_count > 0)
-		free_irq(info->gpmc_irq_count, info);
-	if (info->gpmc_irq_fifo > 0)
-		free_irq(info->gpmc_irq_fifo, info);
-
-	/* Release NAND device, its internal structures and partitions */
 	nand_release(mtd);
-	iounmap(nand_chip->IO_ADDR_R);
-	release_mem_region(info->phys_base, info->mem_size);
-	kfree(info);
 	return 0;
 }
 
-- 
1.8.1

