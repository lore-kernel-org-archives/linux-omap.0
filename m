From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 4/9] mtd: nand: omap: enable auto-detection of bus-width for omap-nand drivers
Date: Tue, 15 Oct 2013 11:19:52 +0530
Message-ID: <1381816197-20477-5-git-send-email-pekon@ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43988 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617Ab3JOFvR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:17 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

Autodetection of NAND device bus-width was added in generic NAND driver as
part of following commit
	commit 64b37b2a63eb2f80b65c7185f0013f8ffc637ae3
	Author:     Matthieu CASTET <matthieu.castet@parrot.com>
	AuthorDate: 2012-11-06
	mtd: nand: add NAND_BUSWIDTH_AUTO to autodetect bus width
This patch enables this feature for OMAP2 NAND driver

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5596368..57a3f51 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1856,8 +1856,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	mtd->name		= dev_name(&pdev->dev);
 	mtd->owner		= THIS_MODULE;
 	nand_chip		= &info->nand;
-	nand_chip->options	= pdata->devsize;
-	nand_chip->options	|= NAND_SKIP_BBTSCAN;
+	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
@@ -1904,6 +1903,21 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->chip_delay = 50;
 	}
 
+	/* scan for NAND device connected to chip controller */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		err = -ENXIO;
+		goto out_release_mem_region;
+	}
+	if ((nand_chip->options & NAND_BUSWIDTH_16) !=
+			(pdata->devsize & NAND_BUSWIDTH_16)) {
+		pr_err("%s: detected %s device but driver configured for %s\n",
+			DRIVER_NAME,
+			(nand_chip->options & NAND_BUSWIDTH_16) ? "x16" : "x8",
+			(pdata->devsize & NAND_BUSWIDTH_16) ? "x16" : "x8");
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
+
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		nand_chip->read_buf   = omap_read_buf_pref;
@@ -2011,17 +2025,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* DIP switches on some boards change between 8 and 16 bit
-	 * bus widths for flash.  Try the other width if the first try fails.
-	 */
-	if (nand_scan_ident(mtd, 1, NULL)) {
-		nand_chip->options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(mtd, 1, NULL)) {
-			err = -ENXIO;
-			goto out_release_mem_region;
-		}
-	}
-
 	/* rom code layout */
 	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
 
-- 
1.8.1

