From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v3 3/3] nand: omap2: Replace pr_err with dev_err
Date: Thu, 11 Sep 2014 12:02:10 -0300
Message-ID: <1410447730-16087-4-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:37809 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaIKPE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 11:04:27 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so2560849qaj.39
        for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2014 08:04:26 -0700 (PDT)
In-Reply-To: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Usage of pr_err is frowned upon, so replace it with dev_err.
Aditionally, the message on nand_bch_init() error is redundant,
since proper error is showed if the function fails.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mtd/nand/omap2.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f97a4ff..3b357e9 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1375,7 +1375,7 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 		erased_ecc_vec = bch16_vector;
 		break;
 	default:
-		pr_err("invalid driver configuration\n");
+		dev_err(&info->pdev->dev, "invalid driver configuration\n");
 		return -EINVAL;
 	}
 
@@ -1446,7 +1446,8 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 	err = 0;
 	for (i = 0; i < eccsteps; i++) {
 		if (err_vec[i].error_uncorrectable) {
-			pr_err("nand: uncorrectable bit-flips found\n");
+			dev_err(&info->pdev->dev,
+				"uncorrectable bit-flips found\n");
 			err = -EBADMSG;
 		} else if (err_vec[i].error_reported) {
 			for (j = 0; j < err_vec[i].error_count; j++) {
@@ -1483,8 +1484,9 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
 							1 << bit_pos;
 					}
 				} else {
-					pr_err("invalid bit-flip @ %d:%d\n",
-							 byte_pos, bit_pos);
+					dev_err(&info->pdev->dev,
+						"invalid bit-flip @ %d:%d\n",
+						byte_pos, bit_pos);
 					err = -EBADMSG;
 				}
 			}
@@ -1598,13 +1600,13 @@ static bool is_elm_present(struct omap_nand_info *info,
 
 	/* check whether elm-id is passed via DT */
 	if (!elm_node) {
-		pr_err("nand: error: ELM DT node not found\n");
+		dev_err(&info->pdev->dev, "ELM devicetree node not found\n");
 		return false;
 	}
 	pdev = of_find_device_by_node(elm_node);
 	/* check whether ELM device is registered */
 	if (!pdev) {
-		pr_err("nand: error: ELM device not found\n");
+		dev_err(&info->pdev->dev, "ELM device not found\n");
 		return false;
 	}
 	/* ELM module available, now configure it */
@@ -1734,14 +1736,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 	/* scan NAND device connected to chip controller */
 	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
 	if (nand_scan_ident(mtd, 1, NULL)) {
-		pr_err("nand device scan failed, may be bus-width mismatch\n");
+		dev_err(&info->pdev->dev, "scan failed, may be bus-width mismatch\n");
 		err = -ENXIO;
 		goto return_error;
 	}
 
 	/* check for small page devices */
 	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
-		pr_err("small page devices are not supported\n");
+		dev_err(&info->pdev->dev, "small page devices are not supported\n");
 		err = -EINVAL;
 		goto return_error;
 	}
@@ -1896,8 +1898,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 							nand_chip->ecc.bytes,
 							&ecclayout);
 		if (!nand_chip->ecc.priv) {
-			pr_err("nand: error: unable to use s/w BCH library\n");
+			dev_err(&info->pdev->dev, "unable to use BCH library\n");
 			err = -EINVAL;
+			goto return_error;
 		}
 		break;
 
@@ -1959,7 +1962,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 							nand_chip->ecc.bytes,
 							&ecclayout);
 		if (!nand_chip->ecc.priv) {
-			pr_err("nand: error: unable to use s/w BCH library\n");
+			dev_err(&info->pdev->dev, "unable to use BCH library\n");
 			err = -EINVAL;
 			goto return_error;
 		}
@@ -2026,7 +2029,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
 	default:
-		pr_err("nand: error: invalid or unsupported ECC scheme\n");
+		dev_err(&info->pdev->dev, "invalid or unsupported ECC scheme\n");
 		err = -EINVAL;
 		goto return_error;
 	}
@@ -2038,8 +2041,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
 	/* check if NAND device's OOB is enough to store ECC signatures */
 	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
-		pr_err("not enough OOB bytes required = %d, available=%d\n",
-					   ecclayout->eccbytes, mtd->oobsize);
+		dev_err(&info->pdev->dev,
+			"not enough OOB bytes required = %d, available=%d\n",
+			ecclayout->eccbytes, mtd->oobsize);
 		err = -EINVAL;
 		goto return_error;
 	}
-- 
2.1.0

