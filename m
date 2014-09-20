From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v4 1/5] nand: omap2: Remove horrible ifdefs to fix module probe
Date: Sat, 20 Sep 2014 17:53:12 +0100
Message-ID: <1411231996-6387-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:57026 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaITQyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2014 12:54:35 -0400
Received: by mail-we0-f178.google.com with SMTP id t60so1061948wes.23
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2014 09:54:34 -0700 (PDT)
In-Reply-To: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

The current code abuses ifdefs to determine if the selected ECC scheme
is supported by the running kernel. As a result the code is hard to read,
and it also fails to load as a module.

This commit removes all the ifdefs and instead introduces a function
omap2_nand_ecc_check() to check if the ECC is supported by using
IS_ENABLED(CONFIG_xxx).

Since IS_ENABLED() is true when a config is =y or =m, this change fixes the
module so it can be loaded with no issues.

Acked-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mtd/nand/omap2.c          | 130 +++++++++++++++++++++-----------------
 include/linux/platform_data/elm.h |  16 +++++
 2 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e1a9b31..f97a4ff 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -136,7 +136,6 @@
 
 #define BADBLOCK_MARKER_LENGTH		2
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 static u_char bch16_vector[] = {0xf5, 0x24, 0x1c, 0xd0, 0x61, 0xb3, 0xf1, 0x55,
 				0x2e, 0x2c, 0x86, 0xa3, 0xed, 0x36, 0x1b, 0x78,
 				0x48, 0x76, 0xa9, 0x3b, 0x97, 0xd1, 0x7a, 0x93,
@@ -144,7 +143,6 @@ static u_char bch16_vector[] = {0xf5, 0x24, 0x1c, 0xd0, 0x61, 0xb3, 0xf1, 0x55,
 static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
 	0xac, 0x6b, 0xff, 0x99, 0x7b};
 static u_char bch4_vector[] = {0x00, 0x6b, 0x31, 0xdd, 0x41, 0xbc, 0x10};
-#endif
 
 /* oob info generated runtime depending on ecc algorithm and layout selected */
 static struct nand_ecclayout omap_oobinfo;
@@ -1292,7 +1290,6 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
 	return 0;
 }
 
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * erased_sector_bitflips - count bit flips
  * @data:	data sector buffer
@@ -1593,33 +1590,71 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 /**
  * is_elm_present - checks for presence of ELM module by scanning DT nodes
  * @omap_nand_info: NAND device structure containing platform data
- * @bch_type: 0x0=BCH4, 0x1=BCH8, 0x2=BCH16
  */
-static int is_elm_present(struct omap_nand_info *info,
-			struct device_node *elm_node, enum bch_ecc bch_type)
+static bool is_elm_present(struct omap_nand_info *info,
+			   struct device_node *elm_node)
 {
 	struct platform_device *pdev;
-	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
-	int err;
+
 	/* check whether elm-id is passed via DT */
 	if (!elm_node) {
 		pr_err("nand: error: ELM DT node not found\n");
-		return -ENODEV;
+		return false;
 	}
 	pdev = of_find_device_by_node(elm_node);
 	/* check whether ELM device is registered */
 	if (!pdev) {
 		pr_err("nand: error: ELM device not found\n");
-		return -ENODEV;
+		return false;
 	}
 	/* ELM module available, now configure it */
 	info->elm_dev = &pdev->dev;
-	err = elm_config(info->elm_dev, bch_type,
-		(info->mtd.writesize / ecc->size), ecc->size, ecc->bytes);
+	return true;
+}
 
-	return err;
+static bool omap2_nand_ecc_check(struct omap_nand_info *info,
+				 struct omap_nand_platform_data	*pdata)
+{
+	bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
+
+	switch (info->ecc_opt) {
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		ecc_needs_omap_bch = false;
+		ecc_needs_bch = true;
+		ecc_needs_elm = false;
+		break;
+	case OMAP_ECC_BCH4_CODE_HW:
+	case OMAP_ECC_BCH8_CODE_HW:
+	case OMAP_ECC_BCH16_CODE_HW:
+		ecc_needs_omap_bch = true;
+		ecc_needs_bch = false;
+		ecc_needs_elm = true;
+		break;
+	default:
+		ecc_needs_omap_bch = false;
+		ecc_needs_bch = false;
+		ecc_needs_elm = false;
+		break;
+	}
+
+	if (ecc_needs_bch && !IS_ENABLED(CONFIG_MTD_NAND_ECC_BCH)) {
+		dev_err(&info->pdev->dev,
+			"CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+		return false;
+	}
+	if (ecc_needs_omap_bch && !IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)) {
+		dev_err(&info->pdev->dev,
+			"CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
+		return false;
+	}
+	if (ecc_needs_elm && !is_elm_present(info, pdata->elm_of_node)) {
+		dev_err(&info->pdev->dev, "ELM not available\n");
+		return false;
+	}
+
+	return true;
 }
-#endif /* CONFIG_MTD_NAND_ECC_BCH */
 
 static int omap_nand_probe(struct platform_device *pdev)
 {
@@ -1797,6 +1832,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
+	if (!omap2_nand_ecc_check(info, pdata)) {
+		err = -EINVAL;
+		goto return_error;
+	}
+
 	/* populate MTD interface based on ECC scheme */
 	ecclayout		= &omap_oobinfo;
 	switch (info->ecc_opt) {
@@ -1829,7 +1869,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-#ifdef CONFIG_MTD_NAND_ECC_BCH
 		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW_DETECTION_SW\n");
 		nand_chip->ecc.mode		= NAND_ECC_HW;
 		nand_chip->ecc.size		= 512;
@@ -1861,14 +1900,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 			err = -EINVAL;
 		}
 		break;
-#else
-		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
-		err = -EINVAL;
-		goto return_error;
-#endif
 
 	case OMAP_ECC_BCH4_CODE_HW:
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 		pr_info("nand: using OMAP_ECC_BCH4_CODE_HW ECC scheme\n");
 		nand_chip->ecc.mode		= NAND_ECC_HW;
 		nand_chip->ecc.size		= 512;
@@ -1890,21 +1923,15 @@ static int omap_nand_probe(struct platform_device *pdev)
 		/* reserved marker already included in ecclayout->eccbytes */
 		ecclayout->oobfree->offset	=
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
-		/* This ECC scheme requires ELM H/W block */
-		if (is_elm_present(info, pdata->elm_of_node, BCH4_ECC) < 0) {
-			pr_err("nand: error: could not initialize ELM\n");
-			err = -ENODEV;
+
+		err = elm_config(info->elm_dev, BCH4_ECC,
+				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_chip->ecc.size, nand_chip->ecc.bytes);
+		if (err < 0)
 			goto return_error;
-		}
 		break;
-#else
-		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
-		err = -EINVAL;
-		goto return_error;
-#endif
 
 	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-#ifdef CONFIG_MTD_NAND_ECC_BCH
 		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW_DETECTION_SW\n");
 		nand_chip->ecc.mode		= NAND_ECC_HW;
 		nand_chip->ecc.size		= 512;
@@ -1937,14 +1964,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 			goto return_error;
 		}
 		break;
-#else
-		pr_err("nand: error: CONFIG_MTD_NAND_ECC_BCH not enabled\n");
-		err = -EINVAL;
-		goto return_error;
-#endif
 
 	case OMAP_ECC_BCH8_CODE_HW:
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 		pr_info("nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme\n");
 		nand_chip->ecc.mode		= NAND_ECC_HW;
 		nand_chip->ecc.size		= 512;
@@ -1956,12 +1977,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		/* This ECC scheme requires ELM H/W block */
-		err = is_elm_present(info, pdata->elm_of_node, BCH8_ECC);
-		if (err < 0) {
-			pr_err("nand: error: could not initialize ELM\n");
+
+		err = elm_config(info->elm_dev, BCH8_ECC,
+				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_chip->ecc.size, nand_chip->ecc.bytes);
+		if (err < 0)
 			goto return_error;
-		}
+
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1973,14 +1995,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	=
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
-#else
-		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
-		err = -EINVAL;
-		goto return_error;
-#endif
 
 	case OMAP_ECC_BCH16_CODE_HW:
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 		pr_info("using OMAP_ECC_BCH16_CODE_HW ECC scheme\n");
 		nand_chip->ecc.mode		= NAND_ECC_HW;
 		nand_chip->ecc.size		= 512;
@@ -1991,12 +2007,13 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		/* This ECC scheme requires ELM H/W block */
-		err = is_elm_present(info, pdata->elm_of_node, BCH16_ECC);
-		if (err < 0) {
-			pr_err("ELM is required for this ECC scheme\n");
+
+		err = elm_config(info->elm_dev, BCH16_ECC,
+				 info->mtd.writesize / nand_chip->ecc.size,
+				 nand_chip->ecc.size, nand_chip->ecc.bytes);
+		if (err < 0)
 			goto return_error;
-		}
+
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -2008,11 +2025,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		ecclayout->oobfree->offset	=
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
-#else
-		pr_err("nand: error: CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
-		err = -EINVAL;
-		goto return_error;
-#endif
 	default:
 		pr_err("nand: error: invalid or unsupported ECC scheme\n");
 		err = -EINVAL;
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index 780d1e9..b8686c0 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -42,8 +42,24 @@ struct elm_errorvec {
 	int error_loc[16];
 };
 
+#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
 void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
 		struct elm_errorvec *err_vec);
 int elm_config(struct device *dev, enum bch_ecc bch_type,
 	int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
+#else
+static inline void
+elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
+			  struct elm_errorvec *err_vec)
+{
+}
+
+static inline int elm_config(struct device *dev, enum bch_ecc bch_type,
+			     int ecc_steps, int ecc_step_size,
+			     int ecc_syndrome_size)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_MTD_NAND_ECC_BCH */
+
 #endif /* __ELM_H */
-- 
2.1.0

