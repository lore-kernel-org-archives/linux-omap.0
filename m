From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Wed, 19 Nov 2014 14:22:23 +0200
Message-ID: <546C8B7F.6030600@ti.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58803 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbaKSMWy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2014 07:22:54 -0500
In-Reply-To: <1415185258-11747-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
Cc: ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, pekon@pek-sem.com, "Rini, Tom" <trini@ti.com>

3430LDP has NAND flash with 32 bytes OOB size which is sufficient to hold
BCH8 codes but the small page check introduced in
commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
considers anything below 64 bytes unsuitable for BCH4/8/16. There is another
bug in that code where it doesn't skip the check for OMAP_ECC_HAM1_CODE_SW.

Get rid of that small page check code as it is insufficient and redundant
because we are checking for OOB available bytes vs ecc layout before calling
nand_scan_tail().

Fixes: b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 3b357e9..10d07dd 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1741,13 +1741,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	/* check for small page devices */
-	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
-		dev_err(&info->pdev->dev, "small page devices are not supported\n");
-		err = -EINVAL;
-		goto return_error;
-	}
-
 	/* re-populate low-level callbacks based on xfer modes */
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
-- 
1.8.3.2


