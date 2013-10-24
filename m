From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 2/5] mtd: nand: omap2: Fix device detection path
Date: Thu, 24 Oct 2013 19:12:14 -0300
Message-ID: <1382652737-20239-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382652737-20239-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52592 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753828Ab3JXWM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 18:12:29 -0400
In-Reply-To: <1382652737-20239-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

From: Pekon Gupta <pekon@ti.com>

Because the device bus can be 8-bit or 16-bit width, yet ONFI detection
cannot work in 16-bit mode, we need to set the NAND_BUSWIDTH_AUTO option
which allows proper initialization configuration.

Once the bus width is detected, nand_scan_ident() updates the nand_chip struct
'option' field to use the appropriate read/write functions and configure
the ECC engine.

Signed-off-by: Pekon Gupta <pekon@ti.com>
[rebased and clean-up a bit pekon's original work]
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/omap2.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4ecf0e5..e01a936 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1855,8 +1855,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->mtd.name		= dev_name(&pdev->dev);
 	info->mtd.owner		= THIS_MODULE;
 
-	info->nand.options	= pdata->devsize;
-	info->nand.options	|= NAND_SKIP_BBTSCAN;
+	info->nand.options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 	info->of_node		= pdata->of_node;
 #endif
@@ -1903,6 +1902,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.chip_delay = 50;
 	}
 
+	err = nand_scan_ident(&info->mtd, 1, NULL);
+	if (err < 0)
+		goto out_release_mem_region;
+
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		info->nand.read_buf   = omap_read_buf_pref;
@@ -2013,17 +2016,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* DIP switches on some boards change between 8 and 16 bit
-	 * bus widths for flash.  Try the other width if the first try fails.
-	 */
-	if (nand_scan_ident(&info->mtd, 1, NULL)) {
-		info->nand.options ^= NAND_BUSWIDTH_16;
-		if (nand_scan_ident(&info->mtd, 1, NULL)) {
-			err = -ENXIO;
-			goto out_release_mem_region;
-		}
-	}
-
 	/* rom code layout */
 	if (pdata->ecc_opt == OMAP_ECC_HAMMING_CODE_HW_ROMCODE) {
 
-- 
1.8.1.5

