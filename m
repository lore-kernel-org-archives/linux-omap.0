From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 07/23] mtd: rawnand: Pass a nand_chip object to
 ecc->correct()
Date: Thu,  6 Sep 2018 14:05:19 +0200
Message-ID: <20180906120535.21255-8-boris.brezillon@bootlin.com>
References: <20180906120535.21255-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906120535.21255-1-boris.brezillon@bootlin.com>
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

Now is ecc->correct()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c |  9 ++++-----
 drivers/mtd/nand/raw/diskonchip.c   |  3 +--
 drivers/mtd/nand/raw/fsmc_nand.c    |  9 ++++-----
 drivers/mtd/nand/raw/jz4740_nand.c  |  6 +++---
 drivers/mtd/nand/raw/jz4780_nand.c  |  4 ++--
 drivers/mtd/nand/raw/lpc32xx_slc.c  |  2 +-
 drivers/mtd/nand/raw/nand_base.c    | 10 +++++-----
 drivers/mtd/nand/raw/nand_bch.c     |  5 ++---
 drivers/mtd/nand/raw/nand_ecc.c     |  7 +++----
 drivers/mtd/nand/raw/omap2.c        | 18 +++++++++---------
 drivers/mtd/nand/raw/r852.c         |  6 +++---
 drivers/mtd/nand/raw/s3c2410.c      |  3 ++-
 drivers/mtd/nand/raw/tmio_nand.c    |  5 +++--
 drivers/mtd/nand/raw/txx9ndfmc.c    |  6 +++---
 include/linux/mtd/nand_bch.h        |  6 +++---
 include/linux/mtd/nand_ecc.h        |  4 ++--
 include/linux/mtd/rawnand.h         |  4 ++--
 17 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index af221e1c8a87..c80b6c6da4aa 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -185,10 +185,9 @@ static int nand_davinci_calculate_1bit(struct nand_chip *chip,
 	return 0;
 }
 
-static int nand_davinci_correct_1bit(struct mtd_info *mtd, u_char *dat,
+static int nand_davinci_correct_1bit(struct nand_chip *chip, u_char *dat,
 				     u_char *read_ecc, u_char *calc_ecc)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	uint32_t eccNand = read_ecc[0] | (read_ecc[1] << 8) |
 					  (read_ecc[2] << 16);
 	uint32_t eccCalc = calc_ecc[0] | (calc_ecc[1] << 8) |
@@ -303,11 +302,11 @@ static int nand_davinci_calculate_4bit(struct nand_chip *chip,
 /* Correct up to 4 bits in data we just read, using state left in the
  * hardware plus the ecc_code computed when it was first written.
  */
-static int nand_davinci_correct_4bit(struct mtd_info *mtd,
-		u_char *data, u_char *ecc_code, u_char *null)
+static int nand_davinci_correct_4bit(struct nand_chip *chip, u_char *data,
+				     u_char *ecc_code, u_char *null)
 {
 	int i;
-	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
 	unsigned short ecc10[8];
 	unsigned short *ecc16;
 	u32 syndrome[4];
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 942a5ee83fbd..142d21be874e 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -893,11 +893,10 @@ static int doc200x_calculate_ecc(struct nand_chip *this, const u_char *dat,
 	return 0;
 }
 
-static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
+static int doc200x_correct_data(struct nand_chip *this, u_char *dat,
 				u_char *read_ecc, u_char *isnull)
 {
 	int i, ret = 0;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	uint8_t calc_ecc[6];
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index d4e91465042c..b41fd09fa389 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -769,7 +769,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		memcpy(&ecc_code[i], oob, chip->ecc.bytes);
 		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		stat = chip->ecc.correct(chip, p, &ecc_code[i], &ecc_calc[i]);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -791,11 +791,10 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * calc_ecc is a 104 bit information containing maximum of 8 error
  * offset informations of 13 bits each in 512 bytes of read data.
  */
-static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
-			     uint8_t *read_ecc, uint8_t *calc_ecc)
+static int fsmc_bch8_correct_data(struct nand_chip *chip, uint8_t *dat,
+				  uint8_t *read_ecc, uint8_t *calc_ecc)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(nand_to_mtd(chip));
 	uint32_t err_idx[8];
 	uint32_t num_err, i;
 	uint32_t ecc1, ecc2, ecc3, ecc4;
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 98ea5172ac74..e926ed6ed296 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -215,10 +215,10 @@ static void jz_nand_correct_data(uint8_t *dat, int index, int mask)
 	dat[index+1] = (data >> 8) & 0xff;
 }
 
-static int jz_nand_correct_ecc_rs(struct mtd_info *mtd, uint8_t *dat,
-	uint8_t *read_ecc, uint8_t *calc_ecc)
+static int jz_nand_correct_ecc_rs(struct nand_chip *chip, uint8_t *dat,
+				  uint8_t *read_ecc, uint8_t *calc_ecc)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	int i, error_count, index;
 	uint32_t reg, status, error;
 	unsigned int timeout = 1000;
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index e53a2bdfc263..42c5dcdea4a9 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -144,10 +144,10 @@ static int jz4780_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
 	return jz4780_bch_calculate(nfc->bch, &params, dat, ecc_code);
 }
 
-static int jz4780_nand_ecc_correct(struct mtd_info *mtd, u8 *dat,
+static int jz4780_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
 				   u8 *read_ecc, u8 *calc_ecc)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
 	struct jz4780_bch_params params;
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index c35a61c453da..d5cb1b40a235 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -639,7 +639,7 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
 	oobecc = chip->oob_poi + oobregion.offset;
 
 	for (i = 0; i < chip->ecc.steps; i++) {
-		stat = chip->ecc.correct(mtd, buf, oobecc,
+		stat = chip->ecc.correct(chip, buf, oobecc,
 					 &tmpecc[i * chip->ecc.bytes]);
 		if (stat < 0)
 			mtd->ecc_stats.failed++;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f147b7948e64..0444bd23c84b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3123,7 +3123,7 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		stat = chip->ecc.correct(chip, p, &ecc_code[i], &ecc_calc[i]);
 		if (stat < 0) {
 			mtd->ecc_stats.failed++;
 		} else {
@@ -3224,7 +3224,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < eccfrag_len ; i += chip->ecc.bytes, p += chip->ecc.size) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p, &chip->ecc.code_buf[i],
+		stat = chip->ecc.correct(chip, p, &chip->ecc.code_buf[i],
 					 &chip->ecc.calc_buf[i]);
 		if (stat == -EBADMSG &&
 		    (chip->ecc.options & NAND_ECC_GENERIC_ERASED_CHECK)) {
@@ -3296,7 +3296,7 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
 		int stat;
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
+		stat = chip->ecc.correct(chip, p, &ecc_code[i], &ecc_calc[i]);
 		if (stat == -EBADMSG &&
 		    (chip->ecc.options & NAND_ECC_GENERIC_ERASED_CHECK)) {
 			/* check for empty pages with bitflips */
@@ -3366,7 +3366,7 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 
 		chip->ecc.calculate(chip, p, &ecc_calc[i]);
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], NULL);
+		stat = chip->ecc.correct(chip, p, &ecc_code[i], NULL);
 		if (stat == -EBADMSG &&
 		    (chip->ecc.options & NAND_ECC_GENERIC_ERASED_CHECK)) {
 			/* check for empty pages with bitflips */
@@ -3436,7 +3436,7 @@ static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 		if (ret)
 			return ret;
 
-		stat = chip->ecc.correct(mtd, p, oob, NULL);
+		stat = chip->ecc.correct(chip, p, oob, NULL);
 
 		oob += eccbytes;
 
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index 9e3c2da0f3b1..574c0ca16160 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -66,17 +66,16 @@ EXPORT_SYMBOL(nand_bch_calculate_ecc);
 
 /**
  * nand_bch_correct_data - [NAND Interface] Detect and correct bit error(s)
- * @mtd:	MTD block structure
+ * @chip:	NAND chip object
  * @buf:	raw data read from the chip
  * @read_ecc:	ECC from the chip
  * @calc_ecc:	the ECC calculated from raw data
  *
  * Detect and correct bit errors for a data byte block
  */
-int nand_bch_correct_data(struct mtd_info *mtd, unsigned char *buf,
+int nand_bch_correct_data(struct nand_chip *chip, unsigned char *buf,
 			  unsigned char *read_ecc, unsigned char *calc_ecc)
 {
-	const struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_bch_control *nbc = chip->ecc.priv;
 	unsigned int *errloc = nbc->errloc;
 	int i, count;
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 1dbfcaecf8c5..8f86eed40b70 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -490,18 +490,17 @@ EXPORT_SYMBOL(__nand_correct_data);
 
 /**
  * nand_correct_data - [NAND Interface] Detect and correct bit error(s)
- * @mtd:	MTD block structure
+ * @chip:	NAND chip object
  * @buf:	raw data read from the chip
  * @read_ecc:	ECC from the chip
  * @calc_ecc:	the ECC calculated from raw data
  *
  * Detect and correct a 1 bit error for 256/512 byte block
  */
-int nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
+int nand_correct_data(struct nand_chip *chip, unsigned char *buf,
 		      unsigned char *read_ecc, unsigned char *calc_ecc)
 {
-	return __nand_correct_data(buf, read_ecc, calc_ecc,
-				   mtd_to_nand(mtd)->ecc.size);
+	return __nand_correct_data(buf, read_ecc, calc_ecc, chip->ecc.size);
 }
 EXPORT_SYMBOL(nand_correct_data);
 
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index adc300b6d243..4e0bc2da63fd 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -857,7 +857,7 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
 
 /**
  * omap_correct_data - Compares the ECC read with HW generated ECC
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @dat: page data
  * @read_ecc: ecc read from nand flash
  * @calc_ecc: ecc read from HW ECC registers
@@ -869,10 +869,10 @@ static int omap_compare_ecc(u8 *ecc_data1,	/* read from NAND memory */
  * corrected errors is returned. If uncorrectable errors exist, %-1 is
  * returned.
  */
-static int omap_correct_data(struct mtd_info *mtd, u_char *dat,
-				u_char *read_ecc, u_char *calc_ecc)
+static int omap_correct_data(struct nand_chip *chip, u_char *dat,
+			     u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	int blockCnt = 0, i = 0, ret = 0;
 	int stat = 0;
 
@@ -1338,7 +1338,7 @@ static int erased_sector_bitflips(u_char *data, u_char *oob,
 
 /**
  * omap_elm_correct_data - corrects page data area in case error reported
- * @mtd:	MTD device structure
+ * @chip:	NAND chip object
  * @data:	page data
  * @read_ecc:	ecc read from nand flash
  * @calc_ecc:	ecc read from HW ECC registers
@@ -1347,10 +1347,10 @@ static int erased_sector_bitflips(u_char *data, u_char *oob,
  * In case of non-zero ecc vector, first filter out erased-pages, and
  * then process data via ELM to detect bit-flips.
  */
-static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
-				u_char *read_ecc, u_char *calc_ecc)
+static int omap_elm_correct_data(struct nand_chip *chip, u_char *data,
+				 u_char *read_ecc, u_char *calc_ecc)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
 	int eccsteps = info->nand.ecc.steps;
 	int i , j, stat = 0;
@@ -1659,7 +1659,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 	if (ret)
 		return ret;
 
-	stat = chip->ecc.correct(mtd, buf, ecc_code, ecc_calc);
+	stat = chip->ecc.correct(chip, buf, ecc_code, ecc_calc);
 
 	if (stat < 0) {
 		mtd->ecc_stats.failed++;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index f58d633ec062..7673aa140009 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -465,14 +465,14 @@ static int r852_ecc_calculate(struct nand_chip *chip, const uint8_t *dat,
  * Correct the data using ECC, hw did almost everything for us
  */
 
-static int r852_ecc_correct(struct mtd_info *mtd, uint8_t *dat,
-				uint8_t *read_ecc, uint8_t *calc_ecc)
+static int r852_ecc_correct(struct nand_chip *chip, uint8_t *dat,
+			    uint8_t *read_ecc, uint8_t *calc_ecc)
 {
 	uint32_t ecc_reg;
 	uint8_t ecc_status, err_byte;
 	int i, error = 0;
 
-	struct r852_device *dev = r852_get_dev(mtd);
+	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
 
 	if (dev->card_unstable)
 		return 0;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index c94e1f62362f..d57201d118d8 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -512,9 +512,10 @@ static int s3c2412_nand_devready(struct mtd_info *mtd)
 
 /* ECC handling functions */
 
-static int s3c2410_nand_correct_data(struct mtd_info *mtd, u_char *dat,
+static int s3c2410_nand_correct_data(struct nand_chip *chip, u_char *dat,
 				     u_char *read_ecc, u_char *calc_ecc)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
 	unsigned int diff0, diff1, diff2;
 	unsigned int bit, byte;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 03d6428589c8..734ff29705ce 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -290,8 +290,9 @@ static int tmio_nand_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 	return 0;
 }
 
-static int tmio_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
-		unsigned char *read_ecc, unsigned char *calc_ecc)
+static int tmio_nand_correct_data(struct nand_chip *chip, unsigned char *buf,
+				  unsigned char *read_ecc,
+				  unsigned char *calc_ecc)
 {
 	int r0, r1;
 
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 55a5c4d42a81..3c69d834de62 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -190,10 +190,10 @@ static int txx9ndfmc_calculate_ecc(struct nand_chip *chip, const uint8_t *dat,
 	return 0;
 }
 
-static int txx9ndfmc_correct_data(struct mtd_info *mtd, unsigned char *buf,
-		unsigned char *read_ecc, unsigned char *calc_ecc)
+static int txx9ndfmc_correct_data(struct nand_chip *chip, unsigned char *buf,
+				  unsigned char *read_ecc,
+				  unsigned char *calc_ecc)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	int eccsize;
 	int corrected = 0;
 	int stat;
diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
index 6db133508960..b8106651f807 100644
--- a/include/linux/mtd/nand_bch.h
+++ b/include/linux/mtd/nand_bch.h
@@ -28,8 +28,8 @@ int nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 /*
  * Detect and correct bit errors
  */
-int nand_bch_correct_data(struct mtd_info *mtd, u_char *dat, u_char *read_ecc,
-			  u_char *calc_ecc);
+int nand_bch_correct_data(struct nand_chip *chip, u_char *dat,
+			  u_char *read_ecc, u_char *calc_ecc);
 /*
  * Initialize BCH encoder/decoder
  */
@@ -51,7 +51,7 @@ nand_bch_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 }
 
 static inline int
-nand_bch_correct_data(struct mtd_info *mtd, unsigned char *buf,
+nand_bch_correct_data(struct nand_chip *chip, unsigned char *buf,
 		      unsigned char *read_ecc, unsigned char *calc_ecc)
 {
 	return -ENOTSUPP;
diff --git a/include/linux/mtd/nand_ecc.h b/include/linux/mtd/nand_ecc.h
index a514e62ff54f..b81fecd5e719 100644
--- a/include/linux/mtd/nand_ecc.h
+++ b/include/linux/mtd/nand_ecc.h
@@ -13,7 +13,6 @@
 #ifndef __MTD_NAND_ECC_H__
 #define __MTD_NAND_ECC_H__
 
-struct mtd_info;
 struct nand_chip;
 
 /*
@@ -37,6 +36,7 @@ int __nand_correct_data(u_char *dat, u_char *read_ecc, u_char *calc_ecc,
 /*
  * Detect and correct a 1 bit error for 256/512 byte block
  */
-int nand_correct_data(struct mtd_info *mtd, u_char *dat, u_char *read_ecc, u_char *calc_ecc);
+int nand_correct_data(struct nand_chip *chip, u_char *dat, u_char *read_ecc,
+		      u_char *calc_ecc);
 
 #endif /* __MTD_NAND_ECC_H__ */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b2f51b2fb110..24434310d126 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -650,8 +650,8 @@ struct nand_ecc_ctrl {
 	void (*hwctl)(struct nand_chip *chip, int mode);
 	int (*calculate)(struct nand_chip *chip, const uint8_t *dat,
 			 uint8_t *ecc_code);
-	int (*correct)(struct mtd_info *mtd, uint8_t *dat, uint8_t *read_ecc,
-			uint8_t *calc_ecc);
+	int (*correct)(struct nand_chip *chip, uint8_t *dat, uint8_t *read_ecc,
+		       uint8_t *calc_ecc);
 	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint8_t *buf, int oob_required, int page);
 	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
