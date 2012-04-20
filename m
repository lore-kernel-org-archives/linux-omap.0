From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: [PATCH] mtd: nand: omap: add support for hardware BCH ecc
Date: Fri, 20 Apr 2012 11:48:48 +0200
Message-ID: <1334915328-10673-1-git-send-email-ivan.djelic@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63271 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab2DTJuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 05:50:06 -0400
Received: by wibhq7 with SMTP id hq7so513312wib.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 02:50:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: Jan Weitzel <J.Weitzel@phytec.de>, linux-omap@vger.kernel.org, Ivan Djelic <ivan.djelic@parrot.com>

Hello,
This patch provides hardware NAND BCH ecc support for OMAP3 boards.
It depends on the following patches:

new GPMC BCH api (linux-omap):
http://lists.infradead.org/pipermail/linux-mtd/2012-April/040757.html

race condition fix in OMAP mtd driver:
http://lists.infradead.org/pipermail/linux-mtd/2012-April/040724.html

I was able to run low-level mtd stress tests on a BeagleBoard, but I
would be interested if someone could test this patch with UBI/UBIFS.
BR,

Ivan

--
Two modes are supported: 4-bit and 8-bit error correction.
The OMAP3 GPMC hardware BCH engine computes remainder polynomials,
it does not provide automatic error location and correction: this
step is implemented using the BCH library.

Error concealment thresholds are implemented in order to avoid
over-scrubbing blocks with sticky bitflips (which are common on
4-bit nand devices).

This implementation only protects page data, there is no support
for protecting user-defined spare area bytes (this could be added
with a few modifications); therefore, it cannot be used with YAFFS2
or other similar filesystems that depend on oob storage.

Before being stored to nand flash, hardware BCH ecc is adjusted
so that an erased page has a valid ecc; thus allowing correction of
bitflips in blank pages (also common on 4-bit devices).

BCH correction mode is selected at runtime by setting platform data
parameter 'ecc_opt' to value OMAP_ECC_BCH4_CODE_HW or
OMAP_ECC_BCH8_CODE_HW.

This code has been tested on a BeagleBoard revC3
(OMAP3530 ES3.0 + Micron NAND 256MiB 1,8V 16-bit).

Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>
---
 drivers/mtd/nand/Kconfig |   40 +++++++
 drivers/mtd/nand/omap2.c |  262 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 302 insertions(+)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 0ea7084..0b4ce93 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -115,6 +115,46 @@ config MTD_NAND_OMAP2
           Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
 	  platforms.
 
+config MTD_NAND_OMAP_BCH
+	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
+	bool "Enable support for hardware BCH error correction"
+	default n
+	select BCH
+	select BCH_CONST_PARAMS
+	help
+	 Support for hardware BCH error correction.
+
+choice
+	prompt "BCH error correction capability"
+	depends on MTD_NAND_OMAP_BCH
+
+config MTD_NAND_OMAP_BCH8
+	bool "8 bits / 512 bytes (recommended)"
+	help
+	 Support correcting up to 8 bitflips per 512-byte block.
+	 This will use 13 bytes of spare area per 512 bytes of page data.
+	 This is the recommended mode, as 4-bit mode does not work
+	 on some OMAP3 revisions, due to a hardware bug.
+
+config MTD_NAND_OMAP_BCH4
+	bool "4 bits / 512 bytes"
+	help
+	 Support correcting up to 4 bitflips per 512-byte block.
+	 This will use 7 bytes of spare area per 512 bytes of page data.
+	 Note that this mode does not work on some OMAP3 revisions, due to a
+	 hardware bug. Please check your OMAP datasheet before selecting this
+	 mode.
+
+endchoice
+
+if MTD_NAND_OMAP_BCH
+config BCH_CONST_M
+	default 13
+config BCH_CONST_T
+	default 4 if MTD_NAND_OMAP_BCH4
+	default 8 if MTD_NAND_OMAP_BCH8
+endif
+
 config MTD_NAND_IDS
 	tristate
 
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 45c6205..d03ef5f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -21,6 +21,10 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+#include <linux/bch.h>
+#endif
+
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
@@ -127,6 +131,12 @@ struct omap_nand_info {
 	} iomode;
 	u_char				*buf;
 	int					buf_len;
+
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	struct bch_control             *bch;
+	struct nand_ecclayout           ecclayout;
+	int                             error_threshold;
+#endif
 };
 
 /**
@@ -927,6 +937,236 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	return 1;
 }
 
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+
+/**
+ * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correction
+ * @mtd: MTD device structure
+ * @mode: Read/Write mode
+ */
+static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
+{
+	int nerrors;
+	unsigned int dev_width;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	struct nand_chip *chip = mtd->priv;
+
+	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
+	dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
+	/*
+	 * Program GPMC to perform correction on one 512-byte sector at a time.
+	 * Using 4 sectors at a time (i.e. ecc.size = 2048) is also possible and
+	 * gives a slight (5%) performance gain (but requires additional code).
+	 */
+	(void)gpmc_enable_hwecc_bch(info->gpmc_cs, mode, dev_width, 1, nerrors);
+}
+
+/**
+ * omap3_calculate_ecc_bch4 - Generate 7 bytes of ECC bytes
+ * @mtd: MTD device structure
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc_code: The ecc_code buffer
+ */
+static int omap3_calculate_ecc_bch4(struct mtd_info *mtd, const u_char *dat,
+				    u_char *ecc_code)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	return gpmc_calculate_ecc_bch4(info->gpmc_cs, dat, ecc_code);
+}
+
+/**
+ * omap3_calculate_ecc_bch8 - Generate 13 bytes of ECC bytes
+ * @mtd: MTD device structure
+ * @dat: The pointer to data on which ecc is computed
+ * @ecc_code: The ecc_code buffer
+ */
+static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
+				    u_char *ecc_code)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	return gpmc_calculate_ecc_bch8(info->gpmc_cs, dat, ecc_code);
+}
+
+/**
+ * omap3_correct_data_bch - Decode received data and correct errors
+ * @mtd: MTD device structure
+ * @data: page data
+ * @read_ecc: ecc read from nand flash
+ * @calc_ecc: ecc read from HW ECC registers
+ */
+static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
+				  u_char *read_ecc, u_char *calc_ecc)
+{
+	int i, count;
+	/* cannot correct more than 8 errors */
+	unsigned int errloc[8];
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+
+	count = decode_bch(info->bch, NULL, 512, read_ecc, calc_ecc, NULL,
+			   errloc);
+	if (count > 0) {
+		/* correct errors */
+		for (i = 0; i < count; i++) {
+			/* correct data only, not ecc bytes */
+			if (errloc[i] < 8*512)
+				data[errloc[i]/8] ^= 1 << (errloc[i] & 7);
+			pr_debug("corrected bitflip %u\n", errloc[i]);
+		}
+		/*
+		 * FIXME: in order to prevent upper layers (such as UBI) from
+		 * torturing and marking a block as bad as soon as 1 bitflip
+		 * is persistent, we implement a threshold below which errors
+		 * are corrected but not reported. Instead, mtd should provide
+		 * a generic way to handle this situation.
+		 */
+		if (count < info->error_threshold)
+			count = 0;
+
+	} else if (count < 0) {
+		pr_err("ecc unrecoverable error\n");
+	}
+	return count;
+}
+
+/**
+ * omap3_free_bch - Release BCH ecc resources
+ * @mtd: MTD device structure
+ */
+static void omap3_free_bch(struct mtd_info *mtd)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	if (info->bch) {
+		free_bch(info->bch);
+		info->bch = NULL;
+	}
+}
+/**
+ * omap3_init_bch - Initialize BCH ECC
+ * @mtd: MTD device structure
+ * @ecc_opt: OMAP ECC mode (OMAP_ECC_BCH4_CODE_HW or OMAP_ECC_BCH8_CODE_HW)
+ */
+static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
+{
+	int max_errors;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	/*
+	 * Define conservative default error concealment thresholds.
+	 * Errors are concealed to avoid over-scrubbing blocks with sticky
+	 * bitflips. These thresholds should probably be provided by platform
+	 * data or mtd.
+	 */
+
+#ifdef CONFIG_MTD_NAND_OMAP_BCH8
+	/* correct up to 8 errors, but conceal 1-bit and 2-bit errors (< 3) */
+	const int hw_errors = 8, error_threshold = 3;
+#else
+	/* correct up to 4 errors, but conceal 1-bit errors (< 2) */
+	const int hw_errors = 4, error_threshold = 2;
+#endif
+	info->bch = NULL;
+
+	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ? 8 : 4;
+	if (max_errors != hw_errors) {
+		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
+		       max_errors, hw_errors);
+		goto fail;
+	}
+	info->error_threshold = error_threshold;
+
+	/* software bch library is only used to detect and locate errors */
+	info->bch = init_bch(13, max_errors, 0x201b /* hw polynomial */);
+	if (!info->bch)
+		goto fail;
+
+	info->nand.ecc.size    = 512;
+	info->nand.ecc.hwctl   = omap3_enable_hwecc_bch;
+	info->nand.ecc.correct = omap3_correct_data_bch;
+	info->nand.ecc.mode    = NAND_ECC_HW;
+
+	if (max_errors == 8) {
+		info->nand.ecc.strength  = 8;
+		info->nand.ecc.bytes     = 13;
+		info->nand.ecc.calculate = omap3_calculate_ecc_bch8;
+	} else {
+		info->nand.ecc.strength  = 4;
+		info->nand.ecc.bytes     = 7;
+		info->nand.ecc.calculate = omap3_calculate_ecc_bch4;
+	}
+
+	pr_info("enabling hardware NAND BCH ECC, %d errors max, threshold %d\n",
+		max_errors, error_threshold);
+
+	return 0;
+fail:
+	omap3_free_bch(mtd);
+	return -1;
+}
+
+/**
+ * omap3_init_bch_tail - Build an oob layout for BCH ECC correction.
+ * @mtd: MTD device structure
+ */
+static int omap3_init_bch_tail(struct mtd_info *mtd)
+{
+	int i, steps;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	struct nand_ecclayout *layout = &info->ecclayout;
+
+	/* build oob layout */
+	steps = mtd->writesize/info->nand.ecc.size;
+	layout->eccbytes = steps*info->nand.ecc.bytes;
+
+	/* do not bother creating special oob layouts for small page devices */
+	if (mtd->oobsize < 64) {
+		pr_err("BCH ecc is not supported on small page devices\n");
+		goto fail;
+	}
+
+	/* reserve 2 bytes for bad block marker */
+	if (layout->eccbytes+2 > mtd->oobsize) {
+		pr_err("no oob layout available for oobsize %d eccbytes %u\n",
+		       mtd->oobsize, layout->eccbytes);
+		goto fail;
+	}
+
+	/* put ecc bytes at oob tail */
+	for (i = 0; i < layout->eccbytes; i++)
+		layout->eccpos[i] = mtd->oobsize-layout->eccbytes+i;
+
+	layout->oobfree[0].offset = 2;
+	layout->oobfree[0].length = mtd->oobsize-2-layout->eccbytes;
+	info->nand.ecc.layout = layout;
+
+	if (!(info->nand.options & NAND_BUSWIDTH_16))
+		info->nand.badblock_pattern = &bb_descrip_flashbased;
+	return 0;
+fail:
+	omap3_free_bch(mtd);
+	return -1;
+}
+
+#else
+static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
+{
+	pr_err("CONFIG_MTD_NAND_OMAP_BCH is not enabled\n");
+	return -1;
+}
+static int omap3_init_bch_tail(struct mtd_info *mtd)
+{
+	return -1;
+}
+static void omap3_free_bch(struct mtd_info *mtd)
+{
+}
+#endif /* CONFIG_MTD_NAND_OMAP_BCH */
+
 static int __devinit omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
@@ -1065,6 +1305,13 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.hwctl            = omap_enable_hwecc;
 		info->nand.ecc.correct          = omap_correct_data;
 		info->nand.ecc.mode             = NAND_ECC_HW;
+	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
+		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
+		err = omap3_init_bch(&info->mtd, pdata->ecc_opt);
+		if (err) {
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
 	}
 
 	/* DIP switches on some boards change between 8 and 16 bit
@@ -1096,6 +1343,14 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 					(offset + omap_oobinfo.eccbytes);
 
 		info->nand.ecc.layout = &omap_oobinfo;
+	} else if ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
+		   (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW)) {
+		/* build OOB layout for BCH ECC correction */
+		err = omap3_init_bch_tail(&info->mtd);
+		if (err) {
+			err = -EINVAL;
+			goto out_release_mem_region;
+		}
 	}
 
 	/* second phase scan */
@@ -1121,9 +1376,16 @@ out_free_info:
 
 static int omap_nand_remove(struct platform_device *pdev)
 {
+	struct omap_nand_platform_data *pdata;
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
+	pdata = pdev->dev.platform_data;
+	if (pdata &&
+	    ((pdata->ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
+	     (pdata->ecc_opt == OMAP_ECC_BCH8_CODE_HW))) {
+		omap3_free_bch(&info->mtd);
+	}
 
 	platform_set_drvdata(pdev, NULL);
 	if (info->dma_ch != -1)
-- 
1.7.10

