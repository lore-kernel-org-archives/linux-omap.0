From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 12/15] mtd: nand: omap: handle gpmc bch[48]
Date: Fri, 5 Oct 2012 21:24:38 +0530
Message-ID: <dc678b08468e16200bef05e8927526916fb4459e.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab2JEPyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:54:50 -0400
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

gpmc-nand bch registers are now available in driver,
make use of it to handle bch[48] instead of relying
on gpmc exported functions.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 95 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f0a1b1d..e3fc8d7 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -106,6 +106,7 @@
 #define	CS_MASK				0x7
 #define	ENABLE_PREFETCH			(0x1 << 7)
 #define	DMA_MPU_MODE_SHIFT		2
+#define	ECCSIZE0_SHIFT			12
 #define	ECCSIZE1_SHIFT			22
 #define	ECC1RESULTSIZE			0x1
 #define	ECCCLEAR			0x100
@@ -1034,19 +1035,45 @@ static int omap_dev_ready(struct mtd_info *mtd)
 static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
 {
 	int nerrors;
-	unsigned int dev_width;
+	unsigned int dev_width, nsectors;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
 	struct nand_chip *chip = mtd->priv;
+	u32 val;
 
 	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
 	dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
+	nsectors = 1;
 	/*
 	 * Program GPMC to perform correction on one 512-byte sector at a time.
 	 * Using 4 sectors at a time (i.e. ecc.size = 2048) is also possible and
 	 * gives a slight (5%) performance gain (but requires additional code).
 	 */
-	(void)gpmc_enable_hwecc_bch(info->gpmc_cs, mode, dev_width, 1, nerrors);
+
+	writel(ECC1, info->reg.gpmc_ecc_control);
+
+	/*
+	 * When using BCH, sector size is hardcoded to 512 bytes.
+	 * Here we are using wrapping mode 6 both for reading and writing, with:
+	 *  size0 = 0  (no additional protected byte in spare area)
+	 *  size1 = 32 (skip 32 nibbles = 16 bytes per sector in spare area)
+	 */
+	val = (32 << ECCSIZE1_SHIFT) | (0 << ECCSIZE0_SHIFT);
+	writel(val, info->reg.gpmc_ecc_size_config);
+
+	/* BCH configuration */
+	val = ((1                        << 16) | /* enable BCH */
+	       (((nerrors == 8) ? 1 : 0) << 12) | /* 8 or 4 bits */
+	       (0x06                     <<  8) | /* wrap mode = 6 */
+	       (dev_width                <<  7) | /* bus width */
+	       (((nsectors-1) & 0x7)     <<  4) | /* number of sectors */
+	       (info->gpmc_cs            <<  1) | /* ECC CS */
+	       (0x1));                            /* enable ECC */
+
+	writel(val, info->reg.gpmc_ecc_config);
+
+	/* clear ecc and enable bits */
+	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
 }
 
 /**
@@ -1060,7 +1087,31 @@ static int omap3_calculate_ecc_bch4(struct mtd_info *mtd, const u_char *dat,
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
-	return gpmc_calculate_ecc_bch4(info->gpmc_cs, dat, ecc_code);
+	unsigned long nsectors, val1, val2;
+
+	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
+
+	for (i = 0; i < nsectors; i++) {
+
+		/* Read hw-computed remainder */
+		val1 = readl(info->reg.gpmc_bch_result0[i]);
+		val2 = readl(info->reg.gpmc_bch_result1[i]);
+
+		/*
+		 * Add constant polynomial to remainder, in order to get an ecc
+		 * sequence of 0xFFs for a buffer filled with 0xFFs; and
+		 * left-justify the resulting polynomial.
+		 */
+		*ecc++ = 0x28 ^ ((val2 >> 12) & 0xFF);
+		*ecc++ = 0x13 ^ ((val2 >>  4) & 0xFF);
+		*ecc++ = 0xcc ^ (((val2 & 0xF) << 4)|((val1 >> 28) & 0xF));
+		*ecc++ = 0x39 ^ ((val1 >> 20) & 0xFF);
+		*ecc++ = 0x96 ^ ((val1 >> 12) & 0xFF);
+		*ecc++ = 0xac ^ ((val1 >> 4) & 0xFF);
+		*ecc++ = 0x7f ^ ((val1 & 0xF) << 4);
+	}
+
+	return 0;
 }
 
 /**
@@ -1074,7 +1125,38 @@ static int omap3_calculate_ecc_bch8(struct mtd_info *mtd, const u_char *dat,
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
-	return gpmc_calculate_ecc_bch8(info->gpmc_cs, dat, ecc_code);
+	unsigned long nsectors, reg, val1, val2, val3, val4;
+
+	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
+
+	for (i = 0; i < nsectors; i++) {
+
+		/* Read hw-computed remainder */
+		val1 = readl(info->reg.gpmc_bch_result0[i]);
+		val2 = readl(info->reg.gpmc_bch_result1[i]);
+		val3 = readl(info->reg.gpmc_bch_result2[i]);
+		val4 = readl(info->reg.gpmc_bch_result3[i]);
+
+		/*
+		 * Add constant polynomial to remainder, in order to get an ecc
+		 * sequence of 0xFFs for a buffer filled with 0xFFs.
+		 */
+		*ecc++ = 0xef ^ (val4 & 0xFF);
+		*ecc++ = 0x51 ^ ((val3 >> 24) & 0xFF);
+		*ecc++ = 0x2e ^ ((val3 >> 16) & 0xFF);
+		*ecc++ = 0x09 ^ ((val3 >> 8) & 0xFF);
+		*ecc++ = 0xed ^ (val3 & 0xFF);
+		*ecc++ = 0x93 ^ ((val2 >> 24) & 0xFF);
+		*ecc++ = 0x9a ^ ((val2 >> 16) & 0xFF);
+		*ecc++ = 0xc2 ^ ((val2 >> 8) & 0xFF);
+		*ecc++ = 0x97 ^ (val2 & 0xFF);
+		*ecc++ = 0x79 ^ ((val1 >> 24) & 0xFF);
+		*ecc++ = 0xe5 ^ ((val1 >> 16) & 0xFF);
+		*ecc++ = 0x24 ^ ((val1 >> 8) & 0xFF);
+		*ecc++ = 0xb5 ^ (val1 & 0xFF);
+	}
+
+	return 0;
 }
 
 /**
@@ -1147,11 +1229,6 @@ static int omap3_init_bch(struct mtd_info *mtd, int ecc_opt)
 		goto fail;
 	}
 
-	/* initialize GPMC BCH engine */
-	ret = gpmc_init_hwecc_bch(info->gpmc_cs, 1, max_errors);
-	if (ret)
-		goto fail;
-
 	/* software bch library is only used to detect and locate errors */
 	info->bch = init_bch(13, max_errors, 0x201b /* hw polynomial */);
 	if (!info->bch)
-- 
1.7.12

