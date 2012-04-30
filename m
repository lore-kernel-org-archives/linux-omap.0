From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: [PATCH v2] mtd: nand: omap: add support for hardware BCH ecc
Date: Mon, 30 Apr 2012 12:17:18 +0200
Message-ID: <1335781038-27641-1-git-send-email-ivan.djelic@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43637 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab2D3KRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 06:17:45 -0400
Received: by wgbdr13 with SMTP id dr13so398004wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 03:17:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ivan.djelic@parrot.com

Hello,
This patch provides hardware NAND BCH ecc support for OMAP3 boards.
It depends on the following patch:

new GPMC BCH api v3 (linux-omap):
http://lists.infradead.org/pipermail/linux-mtd/2012-April/040965.html

This v2 leverages on Mike Dunn's MTD bitflip threshold feature
(5568eb3) in order to drop error concealment code. It also uses the
updated GPMC BCH api provided in aforementioned patch.

--
Ivan

Two modes are supported: 4-bit and 8-bit error correction.
Note that 4-bit mode is only confirmed to work on OMAP3630 ES 1.x,
x >= 1. The OMAP3 GPMC hardware BCH engine computes remainder
polynomials, it does not provide automatic error location and
correction: this step is implemented using the BCH library.

This implementation only protects page data, there is no support
for protecting user-defined spare area bytes (this could be added
with few modifications); therefore, it cannot be used with YAFFS2
or other similar filesystems that depend on oob storage.

Before being stored to nand flash, hardware BCH ecc is adjusted
so that an erased page has a valid ecc; thus allowing correction of
bitflips in blank pages (also common on 4-bit devices).

BCH correction mode is selected at runtime by setting platform data
parameter 'ecc_opt' to value OMAP_ECC_BCH4_CODE_HW or
OMAP_ECC_BCH8_CODE_HW.

This code has been tested with mtd test modules, UBI and UBIFS on a
BeagleBoard revC3 (OMAP3530 ES3.0 + Micron NAND 256MiB 1,8V 16-bit).

Signed-off-by: Ivan Djelic <ivan.djelic@parrot.com>
---
 v2 changelog:
 - drop error concealment code in favour of generic MTD support
 - use GMPC BCH api init to check CPU compatibility

 drivers/mtd/nand/Kconfig |   40 ++++++++
 drivers/mtd/nand/omap2.c |  245 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7d17cec..da61f85 100644
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
index 05d3562..d7f681d 100644
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
@@ -127,6 +131,11 @@ struct omap_nand_info {
 	} iomode;
 	u_char				*buf;
 	int					buf_len;
+
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
+	struct bch_control             *bch;
+	struct nand_ecclayout           ecclayout;
+#endif
 };
 
 /**
@@ -929,6 +938,226 @@ static int omap_dev_ready(struct mtd_info *mtd)
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
+
+/**
+ * omap3_init_bch - Initialize BCH ECC
+ * @mtd: MTD device structure
+ * @ecc_opt: OMAP ECC mode (OMAP_ECC_BCH4_CODE_HW or OMAP_ECC_BCH8_CODE_HW)
+ */
+static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
+{
+	int ret, max_errors;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+#ifdef CONFIG_MTD_NAND_OMAP_BCH8
+	const int hw_errors = 8;
+#else
+	const int hw_errors = 4;
+#endif
+	info->bch = NULL;
+
+	max_errors = (ecc_opt == OMAP_ECC_BCH8_CODE_HW) ? 8 : 4;
+	if (max_errors != hw_errors) {
+		pr_err("cannot configure %d-bit BCH ecc, only %d-bit supported",
+		       max_errors, hw_errors);
+		goto fail;
+	}
+
+	/* initialize GPMC BCH engine */
+	ret = gpmc_init_hwecc_bch(info->gpmc_cs, 1, max_errors);
+	if (ret)
+		goto fail;
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
+	/*
+	 * The number of corrected errors in an ecc block that will trigger
+	 * block scrubbing defaults to the ecc strength (4 or 8).
+	 * Set mtd->bitflip_threshold here to define a custom threshold.
+	 */
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
+	pr_info("enabling NAND BCH ecc with %d-bit correction\n", max_errors);
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
@@ -1067,6 +1296,13 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
@@ -1098,6 +1334,14 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
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
@@ -1126,6 +1370,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
+	omap3_free_bch(&info->mtd);
 
 	platform_set_drvdata(pdev, NULL);
 	if (info->dma_ch != -1)
-- 
1.7.10

