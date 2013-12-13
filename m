From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 1/2] mtd: nand: omap: fix ecclayout->oobfree->offset
Date: Fri, 13 Dec 2013 14:42:57 +0530
Message-ID: <1386925978-23705-2-git-send-email-pekon@ti.com>
References: <1386925978-23705-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54348 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab3LMJOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 04:14:31 -0500
In-Reply-To: <1386925978-23705-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Artem Bityutskiy <dedekind1@gmail.com>, Scott Wood <scottwood@freescale.com>, Tom Rini <trini@ti.com>
Cc: u-boot@lists.denx.de, linux-mtd@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Enric Balletbo Serra <eballetbo@iseebcn.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Igor Grinberg <grinberg@compulab.co.il>, Michael Trimarchi <michael@amarulasolutions.com>, r.meier@siemens.com, r-woodruff2@ti.com, Nikita Kiryanov <nikita@compulab.co.il>, jp.francois@cynove.com, ivan.djelic@parrot.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, avinashphilipk@gmail.com, balbi@ti.com, Pekon Gupta <pekon@ti.com>

This patch updates starting offset for free bytes in OOB which can be used by
file-systems to store their metadata (like clean-marker in case of JFFS2).

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f777250..bbdb5e8 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1835,8 +1835,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 			ecclayout->eccpos[0]	= BADBLOCK_MARKER_LENGTH;
 		else
 			ecclayout->eccpos[0]	= 1;
-		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
-							ecclayout->eccbytes;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -1854,8 +1852,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 							(mtd->writesize /
 							nand_chip->ecc.size);
 		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
-							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd,
 							nand_chip->ecc.size,
@@ -1890,8 +1886,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 							(mtd->writesize /
 							nand_chip->ecc.size);
 		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
-							ecclayout->eccbytes;
 		/* This ECC scheme requires ELM H/W block */
 		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
 			pr_err("nand: error: could not initialize ELM\n");
@@ -1920,8 +1914,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 							(mtd->writesize /
 							nand_chip->ecc.size);
 		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
-							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd,
 							nand_chip->ecc.size,
@@ -1963,8 +1955,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 							(mtd->writesize /
 							nand_chip->ecc.size);
 		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
-		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
-							ecclayout->eccbytes;
 		break;
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
@@ -1978,9 +1968,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	/* populate remaining ECC layout data */
-	ecclayout->oobfree->length = mtd->oobsize - (BADBLOCK_MARKER_LENGTH +
-							ecclayout->eccbytes);
 	for (i = 1; i < ecclayout->eccbytes; i++)
 		ecclayout->eccpos[i] = ecclayout->eccpos[0] + i;
 	/* check if NAND device's OOB is enough to store ECC signatures */
@@ -1990,6 +1977,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 		err = -EINVAL;
 		goto return_error;
 	}
+	/* populate remaining ECC layout data */
+	ecclayout->oobfree->offset = ecclayout->eccpos[ecclayout->eccbytes] + 1;
+	ecclayout->oobfree->length = mtd->oobsize - (BADBLOCK_MARKER_LENGTH +
+							ecclayout->eccbytes);
 
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
-- 
1.8.1

