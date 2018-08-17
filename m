From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 06/23] mtd: rawnand: Pass a nand_chip object to
 ecc->calculate()
Date: Fri, 17 Aug 2018 18:09:05 +0200
Message-ID: <20180817160922.6224-7-boris.brezillon@bootlin.com>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180817160922.6224-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Stefan Agner <stefan@agner.ch>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mans Rullgard <mans@mansr.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Jason Cooper <jason@lakedaemon.net>, devel@driverdev.osuosl.org, Maxime Ripard <maxime.ripard@bootlin.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, Gregory Clement <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Lukasz Majewski <lukma@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Marek Vasut <marek.vasut@gmail.com>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-omap@vger.kernel.org

Let's make the raw NAND API consistent by patching all helpers and
hooks to take a nand_chip object instead of an mtd_info one.

Now is ecc->calculate()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/cs553x_nand.c  |  4 ++--
 drivers/mtd/nand/raw/davinci_nand.c | 12 ++++++------
 drivers/mtd/nand/raw/diskonchip.c   |  4 ++--
 drivers/mtd/nand/raw/fsmc_nand.c    | 10 +++++-----
 drivers/mtd/nand/raw/jz4740_nand.c  |  6 +++---
 drivers/mtd/nand/raw/jz4780_nand.c  |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_slc.c  |  2 +-
 drivers/mtd/nand/raw/nand_base.c    | 16 ++++++++--------
 drivers/mtd/nand/raw/nand_bch.c     |  5 ++---
 drivers/mtd/nand/raw/nand_ecc.c     |  5 ++---
 drivers/mtd/nand/raw/ndfc.c         |  3 +--
 drivers/mtd/nand/raw/omap2.c        | 14 +++++++-------
 drivers/mtd/nand/raw/r852.c         |  6 +++---
 drivers/mtd/nand/raw/s3c2410.c      | 15 +++++++++------
 drivers/mtd/nand/raw/sharpsl.c      |  5 +++--
 drivers/mtd/nand/raw/tmio_nand.c    |  6 +++---
 drivers/mtd/nand/raw/txx9ndfmc.c    |  5 ++---
 include/linux/mtd/nand_bch.h        |  5 +++--
 include/linux/mtd/nand_ecc.h        |  4 +++-
 include/linux/mtd/rawnand.h         |  4 ++--
 20 files changed, 69 insertions(+), 66 deletions(-)

diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 508bcb3d134f..193c3e8fa118 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -164,10 +164,10 @@ static void cs_enable_hwecc(struct nand_chip *this, int mode)
 	writeb(0x07, mmio_base + MM_NAND_ECC_CTL);
 }
 
-static int cs_calculate_ecc(struct mtd_info *mtd, const u_char *dat, u_char *ecc_code)
+static int cs_calculate_ecc(struct nand_chip *this, const u_char *dat,
+			    u_char *ecc_code)
 {
 	uint32_t ecc;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	void __iomem *mmio_base = this->IO_ADDR_R;
 
 	ecc = readl(mmio_base + MM_NAND_STS);
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 329de266c953..af221e1c8a87 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -170,10 +170,10 @@ static void nand_davinci_hwctl_1bit(struct nand_chip *chip, int mode)
 /*
  * Read hardware ECC value and pack into three bytes
  */
-static int nand_davinci_calculate_1bit(struct mtd_info *mtd,
-				      const u_char *dat, u_char *ecc_code)
+static int nand_davinci_calculate_1bit(struct nand_chip *chip,
+				       const u_char *dat, u_char *ecc_code)
 {
-	unsigned int ecc_val = nand_davinci_readecc_1bit(mtd);
+	unsigned int ecc_val = nand_davinci_readecc_1bit(nand_to_mtd(chip));
 	unsigned int ecc24 = (ecc_val & 0x0fff) | ((ecc_val & 0x0fff0000) >> 4);
 
 	/* invert so that erased block ecc is correct */
@@ -266,10 +266,10 @@ nand_davinci_readecc_4bit(struct davinci_nand_info *info, u32 code[4])
 }
 
 /* Terminate read ECC; or return ECC (as bytes) of data written to NAND. */
-static int nand_davinci_calculate_4bit(struct mtd_info *mtd,
-		const u_char *dat, u_char *ecc_code)
+static int nand_davinci_calculate_4bit(struct nand_chip *chip,
+				       const u_char *dat, u_char *ecc_code)
 {
-	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
 	u32 raw_ecc[4], *p;
 	unsigned i;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index d007f0704654..942a5ee83fbd 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -834,9 +834,9 @@ static void doc2001plus_enable_hwecc(struct nand_chip *this, int mode)
 }
 
 /* This code is only called on write */
-static int doc200x_calculate_ecc(struct mtd_info *mtd, const u_char *dat, unsigned char *ecc_code)
+static int doc200x_calculate_ecc(struct nand_chip *this, const u_char *dat,
+				 unsigned char *ecc_code)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 0291a43d9f6e..d4e91465042c 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -385,10 +385,10 @@ static void fsmc_enable_hwecc(struct nand_chip *chip, int mode)
  * FSMC. ECC is 13 bytes for 512 bytes of data (supports error correction up to
  * max of 8-bits)
  */
-static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
+static int fsmc_read_hwecc_ecc4(struct nand_chip *chip, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(nand_to_mtd(chip));
 	uint32_t ecc_tmp;
 	unsigned long deadline = jiffies + FSMC_BUSY_WAIT_TIMEOUT;
 
@@ -433,10 +433,10 @@ static int fsmc_read_hwecc_ecc4(struct mtd_info *mtd, const uint8_t *data,
  * FSMC. ECC is 3 bytes for 512 bytes of data (supports error correction up to
  * max of 1-bit)
  */
-static int fsmc_read_hwecc_ecc1(struct mtd_info *mtd, const uint8_t *data,
+static int fsmc_read_hwecc_ecc1(struct nand_chip *chip, const uint8_t *data,
 				uint8_t *ecc)
 {
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(nand_to_mtd(chip));
 	uint32_t ecc_tmp;
 
 	ecc_tmp = readl_relaxed(host->regs_va + ECC1);
@@ -767,7 +767,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		}
 
 		memcpy(&ecc_code[i], oob, chip->ecc.bytes);
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
 		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
 		if (stat < 0) {
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 0bf5d7b7f185..98ea5172ac74 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -162,10 +162,10 @@ static void jz_nand_hwctl(struct nand_chip *chip, int mode)
 	writel(reg, nand->base + JZ_REG_NAND_ECC_CTRL);
 }
 
-static int jz_nand_calculate_ecc_rs(struct mtd_info *mtd, const uint8_t *dat,
-	uint8_t *ecc_code)
+static int jz_nand_calculate_ecc_rs(struct nand_chip *chip, const uint8_t *dat,
+				    uint8_t *ecc_code)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	uint32_t reg, status;
 	int i;
 	unsigned int timeout = 1000;
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 83077cc434eb..a4df37f6d058 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -123,10 +123,10 @@ static void jz4780_nand_ecc_hwctl(struct nand_chip *chip, int mode)
 	nand->reading = (mode == NAND_ECC_READ);
 }
 
-static int jz4780_nand_ecc_calculate(struct mtd_info *mtd, const u8 *dat,
+static int jz4780_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
 				     u8 *ecc_code)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
 	struct jz4780_bch_params params;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index a6c635053bd5..c35a61c453da 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -345,7 +345,7 @@ static void lpc32xx_nand_ecc_enable(struct nand_chip *chip, int mode)
 /*
  * Calculates the ECC for the data
  */
-static int lpc32xx_nand_ecc_calculate(struct mtd_info *mtd,
+static int lpc32xx_nand_ecc_calculate(struct nand_chip *chip,
 				      const unsigned char *buf,
 				      unsigned char *code)
 {
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index fd0563fc4ad2..f147b7948e64 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3110,7 +3110,7 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
 	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
 					 chip->ecc.total);
@@ -3175,7 +3175,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* Calculate ECC */
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size)
-		chip->ecc.calculate(mtd, p, &chip->ecc.calc_buf[i]);
+		chip->ecc.calculate(chip, p, &chip->ecc.calc_buf[i]);
 
 	/*
 	 * The performance is faster if we position offsets according to
@@ -3278,7 +3278,7 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		if (ret)
 			return ret;
 
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 	}
 
 	ret = nand_read_data_op(chip, chip->oob_poi, mtd->oobsize, false);
@@ -3364,7 +3364,7 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 		if (ret)
 			return ret;
 
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
 		stat = chip->ecc.correct(mtd, p, &ecc_code[i], NULL);
 		if (stat == -EBADMSG &&
@@ -4118,7 +4118,7 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* Software ECC calculation */
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
 	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
 					 chip->ecc.total);
@@ -4157,7 +4157,7 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		if (ret)
 			return ret;
 
-		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
+		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 	}
 
 	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
@@ -4215,7 +4215,7 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 		if ((step < start_step) || (step > end_step))
 			memset(ecc_calc, 0xff, ecc_bytes);
 		else
-			chip->ecc.calculate(mtd, buf, ecc_calc);
+			chip->ecc.calculate(chip, buf, ecc_calc);
 
 		/* mask OOB of un-touched subpages by padding 0xFF */
 		/* if oob_required, preserve OOB metadata of written subpage */
@@ -4287,7 +4287,7 @@ static int nand_write_page_syndrome(struct mtd_info *mtd,
 			oob += chip->ecc.prepad;
 		}
 
-		chip->ecc.calculate(mtd, p, oob);
+		chip->ecc.calculate(chip, p, oob);
 
 		ret = nand_write_data_op(chip, oob, eccbytes, false);
 		if (ret)
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index b7387ace567a..9e3c2da0f3b1 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -43,14 +43,13 @@ struct nand_bch_control {
 
 /**
  * nand_bch_calculate_ecc - [NAND Interface] Calculate ECC for data block
- * @mtd:	MTD block structure
+ * @chip:	NAND chip object
  * @buf:	input buffer with raw data
  * @code:	output buffer with ECC
  */
-int nand_bch_calculate_ecc(struct mtd_info *mtd, const unsigned char *buf,
+int nand_bch_calculate_ecc(struct nand_chip *chip, const unsigned char *buf,
 			   unsigned char *code)
 {
-	const struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_bch_control *nbc = chip->ecc.priv;
 	unsigned int i;
 
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 8e132edbc5ce..1dbfcaecf8c5 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -398,11 +398,10 @@ EXPORT_SYMBOL(__nand_calculate_ecc);
  * @buf:	input buffer with raw data
  * @code:	output buffer with ECC
  */
-int nand_calculate_ecc(struct mtd_info *mtd, const unsigned char *buf,
+int nand_calculate_ecc(struct nand_chip *chip, const unsigned char *buf,
 		       unsigned char *code)
 {
-	__nand_calculate_ecc(buf,
-			mtd_to_nand(mtd)->ecc.size, code);
+	__nand_calculate_ecc(buf, chip->ecc.size, code);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index cf30f04a6b95..de365729c282 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -92,10 +92,9 @@ static void ndfc_enable_hwecc(struct nand_chip *chip, int mode)
 	wmb();
 }
 
-static int ndfc_calculate_ecc(struct mtd_info *mtd,
+static int ndfc_calculate_ecc(struct nand_chip *chip,
 			      const u_char *dat, u_char *ecc_code)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(chip);
 	uint32_t ecc;
 	uint8_t *p = (uint8_t *)&ecc;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index bba403b4e262..adc300b6d243 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -900,7 +900,7 @@ static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
 
 /**
  * omap_calcuate_ecc - Generate non-inverted ECC bytes.
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @dat: The pointer to data on which ecc is computed
  * @ecc_code: The ecc_code buffer
  *
@@ -910,10 +910,10 @@ static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
  * an erased page will produce an ECC mismatch between generated and read
  * ECC bytes that has to be dealt with separately.
  */
-static int omap_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
-				u_char *ecc_code)
+static int omap_calculate_ecc(struct nand_chip *chip, const u_char *dat,
+			      u_char *ecc_code)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	u32 val;
 
 	val = readl(info->reg.gpmc_ecc_config);
@@ -1255,7 +1255,7 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
 
 /**
  * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
- * @mtd:	MTD device structure
+ * @chip:	NAND chip object
  * @dat:	The pointer to data on which ecc is computed
  * @ecc_code:	The ecc_code buffer
  *
@@ -1263,10 +1263,10 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
  * when SW based correction is required as ECC is required for one sector
  * at a time.
  */
-static int omap_calculate_ecc_bch_sw(struct mtd_info *mtd,
+static int omap_calculate_ecc_bch_sw(struct nand_chip *chip,
 				     const u_char *dat, u_char *ecc_calc)
 {
-	return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
+	return _omap_calculate_ecc_bch(nand_to_mtd(chip), dat, ecc_calc, 0);
 }
 
 /**
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index b5e0cc611b14..f58d633ec062 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -433,10 +433,10 @@ static void r852_ecc_hwctl(struct nand_chip *chip, int mode)
  * Calculate ECC, only used for writes
  */
 
-static int r852_ecc_calculate(struct mtd_info *mtd, const uint8_t *dat,
-							uint8_t *ecc_code)
+static int r852_ecc_calculate(struct nand_chip *chip, const uint8_t *dat,
+			      uint8_t *ecc_code)
 {
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 	struct sm_oob *oob = (struct sm_oob *)ecc_code;
 	uint32_t ecc1, ecc2;
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index ca2d006cc846..c94e1f62362f 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -623,9 +623,10 @@ static void s3c2440_nand_enable_hwecc(struct nand_chip *chip, int mode)
 	writel(ctrl | S3C2440_NFCONT_INITECC, info->regs + S3C2440_NFCONT);
 }
 
-static int s3c2410_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
-				      u_char *ecc_code)
+static int s3c2410_nand_calculate_ecc(struct nand_chip *chip,
+				      const u_char *dat, u_char *ecc_code)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 
 	ecc_code[0] = readb(info->regs + S3C2410_NFECC + 0);
@@ -637,9 +638,10 @@ static int s3c2410_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 	return 0;
 }
 
-static int s3c2412_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
-				      u_char *ecc_code)
+static int s3c2412_nand_calculate_ecc(struct nand_chip *chip,
+				      const u_char *dat, u_char *ecc_code)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	unsigned long ecc = readl(info->regs + S3C2412_NFMECC0);
 
@@ -652,9 +654,10 @@ static int s3c2412_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
 	return 0;
 }
 
-static int s3c2440_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
-				      u_char *ecc_code)
+static int s3c2440_nand_calculate_ecc(struct nand_chip *chip,
+				      const u_char *dat, u_char *ecc_code)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	unsigned long ecc = readl(info->regs + S3C2440_NFMECC0);
 
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 37fdaad82f37..4d931ce71af5 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -91,9 +91,10 @@ static void sharpsl_nand_enable_hwecc(struct nand_chip *chip, int mode)
 	writeb(0, sharpsl->io + ECCCLRR);
 }
 
-static int sharpsl_nand_calculate_ecc(struct mtd_info *mtd, const u_char * dat, u_char * ecc_code)
+static int sharpsl_nand_calculate_ecc(struct nand_chip *chip,
+				      const u_char * dat, u_char * ecc_code)
 {
-	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(mtd);
+	struct sharpsl_nand *sharpsl = mtd_to_sharpsl(nand_to_mtd(chip));
 	ecc_code[0] = ~readb(sharpsl->io + ECCLPUB);
 	ecc_code[1] = ~readb(sharpsl->io + ECCLPLB);
 	ecc_code[2] = (~readb(sharpsl->io + ECCCP) << 2) | 0x03;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 2578216ff5c0..03d6428589c8 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -268,10 +268,10 @@ static void tmio_nand_enable_hwecc(struct nand_chip *chip, int mode)
 	tmio_iowrite8(FCR_MODE_HWECC_CALC, tmio->fcr + FCR_MODE);
 }
 
-static int tmio_nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
-							u_char *ecc_code)
+static int tmio_nand_calculate_ecc(struct nand_chip *chip, const u_char *dat,
+				   u_char *ecc_code)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(chip));
 	unsigned int ecc;
 
 	tmio_iowrite8(FCR_MODE_HWECC_RESULT, tmio->fcr + FCR_MODE);
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index fea5bc684aa1..55a5c4d42a81 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -170,11 +170,10 @@ static int txx9ndfmc_dev_ready(struct mtd_info *mtd)
 	return !(txx9ndfmc_read(dev, TXX9_NDFSR) & TXX9_NDFSR_BUSY);
 }
 
-static int txx9ndfmc_calculate_ecc(struct mtd_info *mtd, const uint8_t *dat,
+static int txx9ndfmc_calculate_ecc(struct nand_chip *chip, const uint8_t *dat,
 				   uint8_t *ecc_code)
 {
-	struct platform_device *dev = mtd_to_platdev(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct platform_device *dev = mtd_to_platdev(nand_to_mtd(chip));
 	int eccbytes;
 	u32 mcr = txx9ndfmc_read(dev, TXX9_NDFMCR);
 
diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
index 98f20ef05d60..6db133508960 100644
--- a/include/linux/mtd/nand_bch.h
+++ b/include/linux/mtd/nand_bch.h
@@ -12,6 +12,7 @@
 #define __MTD_NAND_BCH_H__
 
 struct mtd_info;
+struct nand_chip;
 struct nand_bch_control;
 
 #if defined(CONFIG_MTD_NAND_ECC_BCH)
@@ -21,7 +22,7 @@ static inline int mtd_nand_has_bch(void) { return 1; }
 /*
  * Calculate BCH ecc code
  */
-int nand_bch_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+int nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 			   u_char *ecc_code);
 
 /*
@@ -43,7 +44,7 @@ void nand_bch_free(struct nand_bch_control *nbc);
 static inline int mtd_nand_has_bch(void) { return 0; }
 
 static inline int
-nand_bch_calculate_ecc(struct mtd_info *mtd, const u_char *dat,
+nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 		       u_char *ecc_code)
 {
 	return -1;
diff --git a/include/linux/mtd/nand_ecc.h b/include/linux/mtd/nand_ecc.h
index 8a2decf7462c..a514e62ff54f 100644
--- a/include/linux/mtd/nand_ecc.h
+++ b/include/linux/mtd/nand_ecc.h
@@ -14,6 +14,7 @@
 #define __MTD_NAND_ECC_H__
 
 struct mtd_info;
+struct nand_chip;
 
 /*
  * Calculate 3 byte ECC code for eccsize byte block
@@ -24,7 +25,8 @@ void __nand_calculate_ecc(const u_char *dat, unsigned int eccsize,
 /*
  * Calculate 3 byte ECC code for 256/512 byte block
  */
-int nand_calculate_ecc(struct mtd_info *mtd, const u_char *dat, u_char *ecc_code);
+int nand_calculate_ecc(struct nand_chip *chip, const u_char *dat,
+		       u_char *ecc_code);
 
 /*
  * Detect and correct a 1 bit error for eccsize byte block
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 029fef900f33..b2f51b2fb110 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -648,8 +648,8 @@ struct nand_ecc_ctrl {
 	u8 *calc_buf;
 	u8 *code_buf;
 	void (*hwctl)(struct nand_chip *chip, int mode);
-	int (*calculate)(struct mtd_info *mtd, const uint8_t *dat,
-			uint8_t *ecc_code);
+	int (*calculate)(struct nand_chip *chip, const uint8_t *dat,
+			 uint8_t *ecc_code);
 	int (*correct)(struct mtd_info *mtd, uint8_t *dat, uint8_t *read_ecc,
 			uint8_t *calc_ecc);
 	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
