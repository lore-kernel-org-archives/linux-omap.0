From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v9 6/9] mtd: nand: omap: clean-up ecc layout for BCH ecc schemes
Date: Tue, 15 Oct 2013 11:19:54 +0530
Message-ID: <1381816197-20477-7-git-send-email-pekon@ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57130 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933164Ab3JOFvf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 01:51:35 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mark.rutland@arm.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com
Cc: robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Pekon Gupta <pekon@ti.com>

In current implementation omap3_init_bch_tail() is a common function to
define ecc layout for different BCHx ecc schemes.This patch:
(1) removes omap3_init_bch_tail() and defines ecc layout for individual
    ecc-schemes along with populating their nand_chip->ecc data in
    omap_nand_probe(). This improves the readability and scalability of
    code for add new ecc schemes in future.
(2) removes 'struct nand_bbt_descr bb_descrip_flashbased' because default
    nand_bbt_descr in nand_bbt.c matches the same (.len=1 for x8 devices).
(3) add the check to see if NAND device has enough OOB/Spare bytes to
    store ECC signature of whole page, as defined by ecc-scheme.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 162 ++++++++++++++++++-----------------------------
 1 file changed, 63 insertions(+), 99 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 09ce85c..5f6e621 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -139,6 +139,7 @@
 #define BCH_ECC_SIZE0		0x0	/* ecc_size0 = 0, no oob protection */
 #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
+#define BADBLOCK_MARKER_LENGTH		2
 #define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
 
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
@@ -149,17 +150,6 @@ static u_char bch4_vector[] = {0x00, 0x6b, 0x31, 0xdd, 0x41, 0xbc, 0x10};
 
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
-/* Define some generic bad / good block scan pattern which are used
- * while scanning a device for factory marked good / bad blocks
- */
-static uint8_t scan_ff_pattern[] = { 0xff };
-static struct nand_bbt_descr bb_descrip_flashbased = {
-	.options = NAND_BBT_SCANALLPAGES,
-	.offs = 0,
-	.len = 1,
-	.pattern = scan_ff_pattern,
-};
-
 
 struct omap_nand_info {
 	struct nand_hw_control		controller;
@@ -184,7 +174,6 @@ struct omap_nand_info {
 	struct gpmc_nand_regs		reg;
 	/* fields specific for BCHx_HW ECC scheme */
 	struct bch_control             *bch;
-	struct nand_ecclayout           ecclayout;
 	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1686,65 +1675,8 @@ static void omap3_free_bch(struct mtd_info *mtd)
 	}
 }
 
-/**
- * omap3_init_bch_tail - Build an oob layout for BCH ECC correction.
- * @mtd: MTD device structure
- */
-static int omap3_init_bch_tail(struct mtd_info *mtd)
-{
-	int i, steps, offset;
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-						   mtd);
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
-	}
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
-}
-
 #else
-static int omap3_init_bch_tail(struct mtd_info *mtd)
-{
-	return -1;
-}
+
 static void omap3_free_bch(struct mtd_info *mtd)
 {
 }
@@ -1756,8 +1688,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_platform_data	*pdata;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
+	struct nand_ecclayout		*ecclayout;
 	int				err;
-	int				i, offset;
+	int				i;
 	dma_cap_mask_t			mask;
 	unsigned			sig;
 	struct resource			*res;
@@ -1847,6 +1780,14 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
+	/* check for small page devices */
+	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
+		pr_err("small page devices are not supported\n");
+		err = -EINVAL;
+		goto out_release_mem_region;
+	}
+
+	/* populate read & write API based on xfer_type selected */
 	switch (pdata->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
 		nand_chip->read_buf   = omap_read_buf_pref;
@@ -1937,6 +1878,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* populate MTD interface based on ECC scheme */
+	nand_chip->ecc.layout	= &omap_oobinfo;
+	ecclayout		= &omap_oobinfo;
 	switch (pdata->ecc_opt) {
 	case OMAP_ECC_HAM1_CODE_HW:
 		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
@@ -1947,6 +1890,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate        = omap_calculate_ecc;
 		nand_chip->ecc.hwctl            = omap_enable_hwecc;
 		nand_chip->ecc.correct          = omap_correct_data;
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		if (nand_chip->options & NAND_BUSWIDTH_16)
+			ecclayout->eccpos[0]	= BADBLOCK_MARKER_LENGTH;
+		else
+			ecclayout->eccpos[0]	= 1;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -1959,6 +1912,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap3_correct_data_bch;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
 		info->bch = init_bch(nand_chip->ecc.bytes,
 					nand_chip->ecc.strength,
@@ -1987,6 +1947,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
 		/* This ECC scheme requires ELM H/W block */
 		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
 			pr_err("nand: error: could not initialize ELM\n");
@@ -2010,6 +1977,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap3_correct_data_bch;
 		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch8;
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
 		/* software bch library is used for locating errors */
 		info->bch = init_bch(nand_chip->ecc.bytes,
 					nand_chip->ecc.strength,
@@ -2044,6 +2018,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 			pr_err("nand: error: could not initialize ELM\n");
 			goto out_release_mem_region;
 		}
+		/* define ECC layout */
+		ecclayout->eccbytes		= nand_chip->ecc.bytes *
+							(mtd->writesize /
+							nand_chip->ecc.size);
+		ecclayout->eccpos[0]		= BADBLOCK_MARKER_LENGTH;
+		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
+							ecclayout->eccbytes;
 		break;
 #else
 		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
@@ -2057,34 +2038,17 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	/* rom code layout */
-	if (pdata->ecc_opt == OMAP_ECC_HAM1_CODE_HW) {
-
-		if (nand_chip->options & NAND_BUSWIDTH_16) {
-			offset = 2;
-		} else {
-			offset = 1;
-			nand_chip->badblock_pattern = &bb_descrip_flashbased;
-		}
-		omap_oobinfo.eccbytes = 3 * (mtd->writesize / 512);
-		for (i = 0; i < omap_oobinfo.eccbytes; i++)
-			omap_oobinfo.eccpos[i] = i+offset;
-
-		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
-		omap_oobinfo.oobfree->length = mtd->oobsize -
-					(offset + omap_oobinfo.eccbytes);
-
-		nand_chip->ecc.layout = &omap_oobinfo;
-	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW) ||
-		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
-		/* build OOB layout for BCH ECC correction */
-		err = omap3_init_bch_tail(mtd);
-		if (err) {
-			err = -EINVAL;
-			goto out_release_mem_region;
-		}
+	/* populate remaining ECC layout data */
+	ecclayout->oobfree->length = mtd->oobsize - (BADBLOCK_MARKER_LENGTH +
+							ecclayout->eccbytes);
+	for (i = 1; i < ecclayout->eccbytes; i++)
+		ecclayout->eccpos[i] = ecclayout->eccpos[0] + i;
+	/* check if NAND device's OOB is enough to store ECC signatures */
+	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
+		pr_err("not enough OOB bytes required = %d, available=%d\n",
+					   ecclayout->eccbytes, mtd->oobsize);
+		err = -EINVAL;
+		goto out_release_mem_region;
 	}
 
 	/* second phase scan */
-- 
1.8.1

