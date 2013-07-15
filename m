From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 3/5] mtd: nand: omap: optimize chip->ecc.hwctl() for H/W ECC schemes
Date: Mon, 15 Jul 2013 20:25:50 +0530
Message-ID: <1373900152-26885-4-git-send-email-pekon@ti.com>
References: <1373900152-26885-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51179 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334Ab3GOO4l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 10:56:41 -0400
In-Reply-To: <1373900152-26885-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com, dwmw2@infradead.org
Cc: arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Pekon Gupta <pekon@ti.com>

chip->ecc.hwctl() is used for preparing the H/W controller before read/write
NAND accesses (like assigning data-buf, enabling ECC scheme configs, etc.)

Though all ECC schemes in OMAP NAND driver use GPMC controller for generating
ECC syndrome (for both Read/Write accesses). But but in current code
HAM1_ECC and BCHx_ECC schemes implement individual function to achieve this.
This patch merges the GPMC configuration code for all ECC schemes into
single omap_enable_hwecc(), thus adding scalability for future ECC schemes.

 omap_enable_hwecc() + omap3_enable_hwecc_bch() -> omap_enable_hwecc()

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/nand/omap2.c | 216 +++++++++++++++++------------------------------
 1 file changed, 79 insertions(+), 137 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 7f7a2ee..a259761 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -38,6 +38,10 @@
 #define	DRIVER_NAME	"omap2-nand"
 #define	OMAP_NAND_TIMEOUT_MS	5000
 
+#define GPMC_ECC_READ		0 /* Reset Hardware ECC for read */
+#define GPMC_ECC_WRITE		1 /* Reset Hardware ECC for write */
+#define GPMC_ECC_READSYN	2 /* Reset before syndrom is read back */
+
 #define NAND_Ecc_P1e		(1 << 0)
 #define NAND_Ecc_P2e		(1 << 1)
 #define NAND_Ecc_P4e		(1 << 2)
@@ -106,13 +110,9 @@
 #define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)
 
 #define	PREFETCH_CONFIG1_CS_SHIFT	24
-#define	ECC_CONFIG_CS_SHIFT		1
 #define	CS_MASK				0x7
 #define	ENABLE_PREFETCH			(0x1 << 7)
 #define	DMA_MPU_MODE_SHIFT		2
-#define	ECCSIZE0_SHIFT			12
-#define	ECCSIZE1_SHIFT			22
-#define	ECC1RESULTSIZE			0x1
 #define	ECCCLEAR			0x100
 #define	ECC1				0x1
 #define	PREFETCH_FIFOTHRESHOLD_MAX	0x40
@@ -123,26 +123,9 @@
 
 #define OMAP24XX_DMA_GPMC		4
 
-#define BCH8_MAX_ERROR		8	/* upto 8 bit correctable */
-#define BCH4_MAX_ERROR		4	/* upto 4 bit correctable */
-
 #define SECTOR_BYTES		512
 /* 4 bit padding to make byte aligned, 56 = 52 + 4 */
 #define BCH4_BIT_PAD		4
-#define BCH8_ECC_MAX		((SECTOR_BYTES + BCH8_ECC_OOB_BYTES) * 8)
-#define BCH4_ECC_MAX		((SECTOR_BYTES + BCH4_ECC_OOB_BYTES) * 8)
-
-/* GPMC ecc engine settings for read */
-#define BCH_WRAPMODE_1		1	/* BCH wrap mode 1 */
-#define BCH8R_ECC_SIZE0		0x1a	/* ecc_size0 = 26 */
-#define BCH8R_ECC_SIZE1		0x2	/* ecc_size1 = 2 */
-#define BCH4R_ECC_SIZE0		0xd	/* ecc_size0 = 13 */
-#define BCH4R_ECC_SIZE1		0x3	/* ecc_size1 = 3 */
-
-/* GPMC ecc engine settings for write */
-#define BCH_WRAPMODE_6		6	/* BCH wrap mode 6 */
-#define BCH_ECC_SIZE0		0x0	/* ecc_size0 = 0, no oob protection */
-#define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
 
 #define BADBLOCK_MARKER_LENGTH		0x2
 
@@ -191,7 +174,6 @@ struct omap_nand_info {
 	int				buf_len;
 	struct gpmc_nand_regs		reg;
 	/* fields specific for BCHx_HW ECC scheme */
-	bool				is_elm_used;
 	struct device			*elm_dev;
 	struct device_node		*of_node;
 };
@@ -952,7 +934,7 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 	u32 val;
 
 	val = readl(info->reg.gpmc_ecc_config);
-	if (((val >> 1) & 0x07) != info->gpmc_cs) {
+	if (((val >> 1) & 0x7) != info->gpmc_cs) {
 		pr_err("%s: invalid ECC configuration for chip-select=%d",
 				DRIVER_NAME, info->gpmc_cs);
 		return -EINVAL;
@@ -968,47 +950,6 @@ static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 }
 
 /**
- * omap_enable_hwecc - This function enables the hardware ecc functionality
- * @mtd: MTD device structure
- * @mode: Read/Write mode
- */
-static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
-{
-	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
-							mtd);
-	struct nand_chip *chip = mtd->priv;
-	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
-	u32 val;
-
-	/* clear ecc and enable bits */
-	val = ECCCLEAR | ECC1;
-	writel(val, info->reg.gpmc_ecc_control);
-
-	/* program ecc and result sizes */
-	val = ((((info->nand.ecc.size >> 1) - 1) << ECCSIZE1_SHIFT) |
-			 ECC1RESULTSIZE);
-	writel(val, info->reg.gpmc_ecc_size_config);
-
-	switch (mode) {
-	case NAND_ECC_READ:
-	case NAND_ECC_WRITE:
-		writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
-		break;
-	case NAND_ECC_READSYN:
-		writel(ECCCLEAR, info->reg.gpmc_ecc_control);
-		break;
-	default:
-		dev_info(&info->pdev->dev,
-			"error: unrecognized Mode[%d]!\n", mode);
-		break;
-	}
-
-	/* (ECC 16 or 8 bit col) | ( CS  )  | ECC Enable */
-	val = (dev_width << 7) | (info->gpmc_cs << 1) | (0x1);
-	writel(val, info->reg.gpmc_ecc_config);
-}
-
-/**
  * omap_wait - wait until the command is done
  * @mtd: MTD device structure
  * @chip: NAND Chip structure
@@ -1065,84 +1006,87 @@ static int omap_dev_ready(struct mtd_info *mtd)
 }
 
 /**
- * omap3_enable_hwecc_bch - Program OMAP3 GPMC to perform BCH ECC correction
+ * omap_enable_hwecc - Configure OMAP GPMC to perform ECC calculation
  * @mtd: MTD device structure
  * @mode: Read/Write mode
- *
- * When using BCH, sector size is hardcoded to 512 bytes.
- * Using wrapping mode 6 both for reading and writing if ELM module not uses
- * for error correction.
- * On writing,
- * eccsize0 = 0  (no additional protected byte in spare area)
- * eccsize1 = 32 (skip 32 nibbles = 16 bytes per sector in spare area)
+ * Configurations for eccsize0, eccsize1, and bch_wrapmode are based on
+ * GPMC function spec:
+ * Section 4.6.3.2.3: Supported NAND page mappings and ECC schemes
  */
-static void omap3_enable_hwecc_bch(struct mtd_info *mtd, int mode)
+static void omap_enable_hwecc(struct mtd_info *mtd, int mode)
 {
-	int nerrors;
-	unsigned int dev_width, nsectors;
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
 	struct nand_chip *chip = mtd->priv;
-	u32 val, wr_mode;
-	unsigned int ecc_size1, ecc_size0;
-
-	/* Using wrapping mode 6 for writing */
-	wr_mode = BCH_WRAPMODE_6;
-
-	/*
-	 * ECC engine enabled for valid ecc_size0 nibbles
-	 * and disabled for ecc_size1 nibbles.
-	 */
-	ecc_size0 = BCH_ECC_SIZE0;
-	ecc_size1 = BCH_ECC_SIZE1;
-
-	/* Perform ecc calculation on 512-byte sector */
-	nsectors = 1;
-
-	/* Update number of error correction */
-	nerrors = info->nand.ecc.strength;
-
-	/* Multi sector reading/writing for NAND flash with page size < 4096 */
-	if (info->is_elm_used && (mtd->writesize <= 4096)) {
-		if (mode == NAND_ECC_READ) {
-			/* Using wrapping mode 1 for reading */
-			wr_mode = BCH_WRAPMODE_1;
-
-			/*
-			 * ECC engine enabled for ecc_size0 nibbles
-			 * and disabled for ecc_size1 nibbles.
-			 */
-			ecc_size0 = (nerrors == 8) ?
-				BCH8R_ECC_SIZE0 : BCH4R_ECC_SIZE0;
-			ecc_size1 = (nerrors == 8) ?
-				BCH8R_ECC_SIZE1 : BCH4R_ECC_SIZE1;
+	unsigned int dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
+	unsigned int nsectors = (mtd->writesize / SECTOR_BYTES);
+	unsigned int ecc_algo = 0;
+	unsigned int bch_type = 0;
+	unsigned int eccsize1 = 0x00, eccsize0 = 0x00, bch_wrapmode = 0x00;
+	u32 ecc_size_config_val = 0;
+	u32 ecc_config_val = 0;
+
+	switch (info->ecc_opt) {
+	case OMAP_ECC_HAMMING_CODE_DEFAULT:
+		pr_err("%s: invalid driver configuration", DRIVER_NAME);
+		break;
+	case OMAP_ECC_HAMMING_CODE_HW:
+	case OMAP_ECC_HAMMING_CODE_HW_ROMCODE:
+		ecc_algo = 0x0;
+		bch_wrapmode = 0x00;
+		eccsize0 = (chip->ecc.size >> 1) - 1;
+		eccsize1 = 0;
+		nsectors = 0;
+		break;
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH4_CODE_HW:
+		ecc_algo = 0x1;
+		bch_type = 0x0;
+		if (mode == GPMC_ECC_READ) {
+			bch_wrapmode = 0x01;
+			eccsize0 = 13; /* ECC bits in nibbles per sector */
+			eccsize1 = 3;  /* non-ECC bits in nibbles per sector */
+		} else if (mode == GPMC_ECC_WRITE) {
+			eccsize0 = 0;  /* extra bits in nibbles per sector */
+			eccsize1 = 32; /* OOB bits in nibbles per sector */
+			bch_wrapmode = 0x06;
 		}
-
-		/* Perform ecc calculation for one page (< 4096) */
-		nsectors = info->nand.ecc.steps;
+		break;
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH8_CODE_HW:
+		ecc_algo = 0x1;
+		bch_type = 0x1;
+		if (mode == GPMC_ECC_READ) {
+			bch_wrapmode = 0x01;
+			eccsize0 = 26; /* ECC bits in nibbles per sector */
+			eccsize1 = 2;  /* non-ECC bits in nibbles per sector */
+		} else if (mode == GPMC_ECC_WRITE) {
+			bch_wrapmode = 0x01;
+			eccsize0 = 0;  /* extra bits in nibbles per sector */
+			eccsize1 = 28; /* OOB bits in nibbles per sector */
+		}
+		break;
+	default:
+		pr_err("selected ECC scheme not supported or not enabled\n");
 	}
-
-	writel(ECC1, info->reg.gpmc_ecc_control);
-
-	/* Configure ecc size for BCH */
-	val = (ecc_size1 << ECCSIZE1_SHIFT) | (ecc_size0 << ECCSIZE0_SHIFT);
-	writel(val, info->reg.gpmc_ecc_size_config);
-
-	dev_width = (chip->options & NAND_BUSWIDTH_16) ? 1 : 0;
-
-	/* BCH configuration */
-	val = ((1                        << 16) | /* enable BCH */
-	       (((nerrors == 8) ? 1 : 0) << 12) | /* 8 or 4 bits */
-	       (wr_mode                  <<  8) | /* wrap mode */
-	       (dev_width                <<  7) | /* bus width */
-	       (((nsectors-1) & 0x7)     <<  4) | /* number of sectors */
-	       (info->gpmc_cs            <<  1) | /* ECC CS */
-	       (0x1));                            /* enable ECC */
-
-	writel(val, info->reg.gpmc_ecc_config);
-
 	/* Clear ecc and enable bits */
 	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
+	/* Configure ecc size for BCH */
+	ecc_size_config_val = (eccsize1 << 22) | (eccsize0 << 12);
+	writel(ecc_size_config_val, info->reg.gpmc_ecc_size_config);
+	/* Configure device details for BCH engine */
+	ecc_config_val = ((ecc_algo << 16)	| /* HAM1 | BCHx */
+			(bch_type << 12)	| /* BCH4/BCH8/BCH16 */
+			(bch_wrapmode << 8)	| /* wrap mode */
+			(dev_width << 7)	| /* bus width */
+			(((nsectors-1) & 0x7) << 4) | /* number of sectors */
+			(info->gpmc_cs <<  1)	| /* ECC CS */
+			(0x0));			/* disable ECC */
+	writel(ecc_config_val, info->reg.gpmc_ecc_config);
+	/* enable ECC engine */
+	writel(ecc_config_val | 0x1, info->reg.gpmc_ecc_config);
+	/* Clear ECC and enable bits */
+	writel(ECCCLEAR | ECC1, info->reg.gpmc_ecc_control);
 }
 
 /**
@@ -1460,7 +1404,6 @@ static int is_elm_present(struct omap_nand_info *info, enum bch_ecc bch_type)
 	int lenp;
 	struct device_node *elm_node;
 	struct platform_device *pdev;
-	info->is_elm_used = false;
 
 	/* Detect availability of ELM module */
 	parp = of_get_property(info->of_node, "elm_id", &lenp);
@@ -1472,7 +1415,6 @@ static int is_elm_present(struct omap_nand_info *info, enum bch_ecc bch_type)
 		info->elm_dev = &pdev->dev;
 		/* ELM module available, now configure it */
 		elm_config(info->elm_dev, bch_type);
-		info->is_elm_used = true;
 		return 0;
 	}
 
@@ -1729,7 +1671,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.size		= 512;
 		info->nand.ecc.bytes		= 7;
 		info->nand.ecc.strength		= 4;
-		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
 		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
 		/* software bch library is used for locating errors */
@@ -1752,7 +1694,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		/* 8th bit is kept reserved for ROM-code compatibility */
 		info->nand.ecc.bytes		= 7 + 1;
 		info->nand.ecc.strength		= 4;
-		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
 		info->nand.ecc.correct		= omap_elm_correct_data;
 		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
 		info->nand.ecc.read_page	= omap_read_page_bch;
@@ -1779,7 +1721,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.size		= 512;
 		info->nand.ecc.bytes		= 13;
 		info->nand.ecc.strength		= 8;
-		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
 		info->nand.ecc.correct		= nand_bch_correct_data;
 		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
 		/* software bch library is used for locating errors */
@@ -1802,7 +1744,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		/* 14th bit is kept reserved for ROM-code compatibility */
 		info->nand.ecc.bytes		= 13 + 1;
 		info->nand.ecc.strength		= 8;
-		info->nand.ecc.hwctl		= omap3_enable_hwecc_bch;
+		info->nand.ecc.hwctl		= omap_enable_hwecc;
 		info->nand.ecc.correct		= omap_elm_correct_data;
 		info->nand.ecc.calculate	= omap_calculate_ecc_bch;
 		info->nand.ecc.read_page	= omap_read_page_bch;
-- 
1.8.1

