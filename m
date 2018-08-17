From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 17/23] mtd: rawnand: Pass a nand_chip object to
 chip->waitfunc()
Date: Fri, 17 Aug 2018 18:09:16 +0200
Message-ID: <20180817160922.6224-18-boris.brezillon@bootlin.com>
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
hooks to take a nand_chip object instead of an mtd_info one or
remove the mtd_info object when both are passed.

Let's tackle the chip->waitfunc() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c  |  2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 12 +++++------
 drivers/mtd/nand/raw/denali.c                 |  4 ++--
 drivers/mtd/nand/raw/diskonchip.c             |  2 +-
 drivers/mtd/nand/raw/docg4.c                  |  4 ++--
 drivers/mtd/nand/raw/fsl_elbc_nand.c          |  4 ++--
 drivers/mtd/nand/raw/fsl_ifc_nand.c           |  3 ++-
 drivers/mtd/nand/raw/lpc32xx_mlc.c            | 17 ++++++++--------
 drivers/mtd/nand/raw/nand_base.c              | 29 ++++++++-------------------
 drivers/mtd/nand/raw/omap2.c                  |  8 +++-----
 drivers/mtd/nand/raw/r852.c                   |  2 +-
 drivers/mtd/nand/raw/tango_nand.c             |  2 +-
 drivers/mtd/nand/raw/tmio_nand.c              |  5 ++---
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  3 ++-
 include/linux/mtd/rawnand.h                   |  2 +-
 15 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 4bcdefb73659..f964914cbcf0 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -945,7 +945,7 @@ static int atmel_hsmc_nand_pmecc_write_pg(struct nand_chip *chip,
 		dev_err(nc->base.dev, "Failed to program NAND page (err = %d)\n",
 			ret);
 
-	status = chip->waitfunc(mtd, chip);
+	status = chip->waitfunc(chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 4b814a39b24f..fee40a3ce5d2 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1237,9 +1237,8 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
 	/* intentionally left blank */
 }
 
-static int brcmnand_waitfunc(struct mtd_info *mtd, struct nand_chip *this)
+static int brcmnand_waitfunc(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	unsigned long timeo = msecs_to_jiffies(100);
@@ -1274,7 +1273,6 @@ static int brcmnand_low_level_op(struct brcmnand_host *host,
 				 enum brcmnand_llop_type type, u32 data,
 				 bool last_op)
 {
-	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 	struct nand_chip *chip = &host->chip;
 	struct brcmnand_controller *ctrl = host->ctrl;
 	u32 tmp;
@@ -1307,7 +1305,7 @@ static int brcmnand_low_level_op(struct brcmnand_host *host,
 	(void)brcmnand_read_reg(ctrl, BRCMNAND_LL_OP);
 
 	brcmnand_send_cmd(host, CMD_LOW_LEVEL_OP);
-	return brcmnand_waitfunc(mtd, chip);
+	return brcmnand_waitfunc(chip);
 }
 
 static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
@@ -1383,7 +1381,7 @@ static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
 	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
 
 	brcmnand_send_cmd(host, native_cmd);
-	brcmnand_waitfunc(mtd, chip);
+	brcmnand_waitfunc(chip);
 
 	if (native_cmd == CMD_PARAMETER_READ ||
 			native_cmd == CMD_PARAMETER_CHANGE_COL) {
@@ -1615,7 +1613,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 		(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
 		/* SPARE_AREA_READ does not use ECC, so just use PAGE_READ */
 		brcmnand_send_cmd(host, CMD_PAGE_READ);
-		brcmnand_waitfunc(mtd, chip);
+		brcmnand_waitfunc(chip);
 
 		if (likely(buf)) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
@@ -1893,7 +1891,7 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 
 		/* we cannot use SPARE_AREA_PROGRAM when PARTIAL_PAGE_EN=0 */
 		brcmnand_send_cmd(host, CMD_PROGRAM_PAGE);
-		status = brcmnand_waitfunc(mtd, chip);
+		status = brcmnand_waitfunc(chip);
 
 		if (status & NAND_STATUS_FAIL) {
 			dev_info(ctrl->dev, "program failed at %llx\n",
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 612b3072b0f1..87ca07c8a1b6 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -911,9 +911,9 @@ static void denali_select_chip(struct nand_chip *chip, int cs)
 	denali->active_bank = cs;
 }
 
-static int denali_waitfunc(struct mtd_info *mtd, struct nand_chip *chip)
+static int denali_waitfunc(struct nand_chip *chip)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	uint32_t irq_status;
 
 	/* R/B# pin transitioned from low to high? */
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 64bf0624343d..0b305c19a9a3 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -433,7 +433,7 @@ static void __init doc2000_count_chips(struct mtd_info *mtd)
 	pr_debug("Detected %d chips per floor.\n", i);
 }
 
-static int doc200x_wait(struct mtd_info *mtd, struct nand_chip *this)
+static int doc200x_wait(struct nand_chip *this)
 {
 	struct doc_priv *doc = nand_get_controller_data(this);
 
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index c76d765bb1aa..1a39e9701191 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -315,7 +315,7 @@ static int poll_status(struct docg4_priv *doc)
 }
 
 
-static int docg4_wait(struct mtd_info *mtd, struct nand_chip *nand)
+static int docg4_wait(struct nand_chip *nand)
 {
 
 	struct docg4_priv *doc = nand_get_controller_data(nand);
@@ -938,7 +938,7 @@ static int docg4_erase_block(struct mtd_info *mtd, int page)
 	poll_status(doc);
 	write_nop(docptr);
 
-	status = nand->waitfunc(mtd, nand);
+	status = nand->waitfunc(nand);
 	if (status < 0)
 		return status;
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 93b82af3e518..98da5f9f04ac 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -621,7 +621,7 @@ static void fsl_elbc_read_buf(struct nand_chip *chip, u8 *buf, int len)
 /* This function is called after Program and Erase Operations to
  * check for success or failure.
  */
-static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int fsl_elbc_wait(struct nand_chip *chip)
 {
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = priv->ctrl->nand;
@@ -720,7 +720,7 @@ static int fsl_elbc_read_page(struct nand_chip *chip, uint8_t *buf,
 	if (oob_required)
 		fsl_elbc_read_buf(chip, chip->oob_poi, mtd->oobsize);
 
-	if (fsl_elbc_wait(mtd, chip) & NAND_STATUS_FAIL)
+	if (fsl_elbc_wait(chip) & NAND_STATUS_FAIL)
 		mtd->ecc_stats.failed++;
 
 	return elbc_fcm_ctrl->max_bitflips;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 26f06d0594e6..bdbc5bdb1289 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -613,8 +613,9 @@ static void fsl_ifc_read_buf(struct nand_chip *chip, u8 *buf, int len)
  * This function is called after Program and Erase Operations to
  * check for success or failure.
  */
-static int fsl_ifc_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int fsl_ifc_wait(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_runtime __iomem *ifc = ctrl->rregs;
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 726cd8868ac3..ae31f6ccbeb3 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -328,8 +328,9 @@ static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
 	return IRQ_HANDLED;
 }
 
-static int lpc32xx_waitfunc_nand(struct mtd_info *mtd, struct nand_chip *chip)
+static int lpc32xx_waitfunc_nand(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	if (readb(MLC_ISR(host->io_base)) & MLCISR_NAND_READY)
@@ -347,9 +348,9 @@ static int lpc32xx_waitfunc_nand(struct mtd_info *mtd, struct nand_chip *chip)
 	return NAND_STATUS_READY;
 }
 
-static int lpc32xx_waitfunc_controller(struct mtd_info *mtd,
-				       struct nand_chip *chip)
+static int lpc32xx_waitfunc_controller(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	if (readb(MLC_ISR(host->io_base)) & MLCISR_CONTROLLER_READY)
@@ -367,10 +368,10 @@ static int lpc32xx_waitfunc_controller(struct mtd_info *mtd,
 	return NAND_STATUS_READY;
 }
 
-static int lpc32xx_waitfunc(struct mtd_info *mtd, struct nand_chip *chip)
+static int lpc32xx_waitfunc(struct nand_chip *chip)
 {
-	lpc32xx_waitfunc_nand(mtd, chip);
-	lpc32xx_waitfunc_controller(mtd, chip);
+	lpc32xx_waitfunc_nand(chip);
+	lpc32xx_waitfunc_controller(chip);
 
 	return NAND_STATUS_READY;
 }
@@ -469,7 +470,7 @@ static int lpc32xx_read_page(struct nand_chip *chip, uint8_t *buf,
 		writeb(0x00, MLC_ECC_AUTO_DEC_REG(host->io_base));
 
 		/* Wait for Controller Ready */
-		lpc32xx_waitfunc_controller(mtd, chip);
+		lpc32xx_waitfunc_controller(chip);
 
 		/* Check ECC Error status */
 		mlc_isr = readl(MLC_ISR(host->io_base));
@@ -550,7 +551,7 @@ static int lpc32xx_write_page_lowlevel(struct nand_chip *chip,
 		writeb(0x00, MLC_ECC_AUTO_ENC_REG(host->io_base));
 
 		/* Wait for Controller Ready */
-		lpc32xx_waitfunc_controller(mtd, chip);
+		lpc32xx_waitfunc_controller(chip);
 	}
 
 	return nand_prog_page_end_op(chip);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a74264f36a70..9be0f98c1244 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1062,8 +1062,7 @@ nand_get_device(struct mtd_info *mtd, int new_state)
  * we are in interrupt context. May happen when in panic and trying to write
  * an oops through mtdoops.
  */
-static void panic_nand_wait(struct mtd_info *mtd, struct nand_chip *chip,
-			    unsigned long timeo)
+static void panic_nand_wait(struct nand_chip *chip, unsigned long timeo)
 {
 	int i;
 	for (i = 0; i < timeo; i++) {
@@ -1093,7 +1092,7 @@ static void panic_nand_wait(struct mtd_info *mtd, struct nand_chip *chip,
  *
  * Wait for command done. This applies to erase and program only.
  */
-static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int nand_wait(struct nand_chip *chip)
 {
 
 	unsigned long timeo = 400;
@@ -1111,7 +1110,7 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 		return ret;
 
 	if (in_interrupt() || oops_in_progress)
-		panic_nand_wait(mtd, chip, timeo);
+		panic_nand_wait(chip, timeo);
 	else {
 		timeo = jiffies + msecs_to_jiffies(timeo);
 		do {
@@ -1553,7 +1552,6 @@ EXPORT_SYMBOL_GPL(nand_read_page_op);
 static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 				   unsigned int len)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int i;
 	u8 *p = buf;
 
@@ -1811,7 +1809,6 @@ EXPORT_SYMBOL_GPL(nand_prog_page_begin_op);
  */
 int nand_prog_page_end_op(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 	u8 status;
 
@@ -1834,7 +1831,7 @@ int nand_prog_page_end_op(struct nand_chip *chip)
 			return ret;
 	} else {
 		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
-		ret = chip->waitfunc(mtd, chip);
+		ret = chip->waitfunc(chip);
 		if (ret < 0)
 			return ret;
 
@@ -1881,7 +1878,7 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 		chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
 		chip->write_buf(chip, buf, len);
 		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
-		status = chip->waitfunc(mtd, chip);
+		status = chip->waitfunc(chip);
 	}
 
 	if (status & NAND_STATUS_FAIL)
@@ -1970,7 +1967,6 @@ EXPORT_SYMBOL_GPL(nand_change_write_column_op);
 int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 		   unsigned int len)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int i;
 	u8 *id = buf;
 
@@ -2016,8 +2012,6 @@ EXPORT_SYMBOL_GPL(nand_readid_op);
  */
 int nand_status_op(struct nand_chip *chip, u8 *status)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (chip->exec_op) {
 		const struct nand_sdr_timings *sdr =
 			nand_get_sdr_timings(&chip->data_interface);
@@ -2055,8 +2049,6 @@ EXPORT_SYMBOL_GPL(nand_status_op);
  */
 int nand_exit_status_op(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (chip->exec_op) {
 		struct nand_op_instr instrs[] = {
 			NAND_OP_CMD(NAND_CMD_READ0, 0),
@@ -2085,7 +2077,6 @@ EXPORT_SYMBOL_GPL(nand_exit_status_op);
  */
 int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int page = eraseblock <<
 			    (chip->phys_erase_shift - chip->page_shift);
 	int ret;
@@ -2118,7 +2109,7 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 		chip->cmdfunc(chip, NAND_CMD_ERASE1, -1, page);
 		chip->cmdfunc(chip, NAND_CMD_ERASE2, -1, -1);
 
-		ret = chip->waitfunc(mtd, chip);
+		ret = chip->waitfunc(chip);
 		if (ret < 0)
 			return ret;
 
@@ -2147,7 +2138,6 @@ EXPORT_SYMBOL_GPL(nand_erase_op);
 static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 				const void *data)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	const u8 *params = data;
 	int i, ret;
 
@@ -2170,7 +2160,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		chip->write_byte(chip, params[i]);
 
-	ret = chip->waitfunc(mtd, chip);
+	ret = chip->waitfunc(chip);
 	if (ret < 0)
 		return ret;
 
@@ -2195,7 +2185,6 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 				void *data)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 *params = data;
 	int i;
 
@@ -2256,8 +2245,6 @@ static int nand_wait_rdy_op(struct nand_chip *chip, unsigned int timeout_ms,
  */
 int nand_reset_op(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (chip->exec_op) {
 		const struct nand_sdr_timings *sdr =
 			nand_get_sdr_timings(&chip->data_interface);
@@ -4518,7 +4505,7 @@ static int panic_nand_write(struct mtd_info *mtd, loff_t to, size_t len,
 	chip->select_chip(chip, chipnr);
 
 	/* Wait for the device to get ready */
-	panic_nand_wait(mtd, chip, 400);
+	panic_nand_wait(chip, 400);
 
 	memset(&ops, 0, sizeof(ops));
 	ops.len = len;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index eef9cbadd3c4..6f0fec3596cc 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -981,8 +981,7 @@ static void omap_enable_hwecc(struct nand_chip *chip, int mode)
 
 /**
  * omap_wait - wait until the command is done
- * @mtd: MTD device structure
- * @chip: NAND Chip structure
+ * @this: NAND Chip structure
  *
  * Wait function is called during Program and erase operations and
  * the way it is called from MTD layer, we should wait till the NAND
@@ -991,10 +990,9 @@ static void omap_enable_hwecc(struct nand_chip *chip, int mode)
  * Erase can take up to 400ms and program up to 20ms according to
  * general NAND and SmartMedia specs
  */
-static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int omap_wait(struct nand_chip *this)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(this));
 	unsigned long timeo = jiffies;
 	int status, state = this->state;
 
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 4331ff856fa5..2c30e97ab2a4 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -362,7 +362,7 @@ static void r852_cmdctl(struct nand_chip *chip, int dat, unsigned int ctrl)
  * Wait till card is ready.
  * based on nand_wait, but returns errors on DMA error
  */
-static int r852_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int r852_wait(struct nand_chip *chip)
 {
 	struct r852_device *dev = nand_get_controller_data(chip);
 
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index cc719bc49b68..c21a0f2d26fc 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -314,7 +314,7 @@ static int tango_write_page(struct nand_chip *chip, const u8 *buf,
 	if (err)
 		return err;
 
-	status = chip->waitfunc(mtd, chip);
+	status = chip->waitfunc(chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 7096fa3d50ab..f44621672779 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -186,10 +186,9 @@ static irqreturn_t tmio_irq(int irq, void *__tmio)
   *erase and write, we enable it to wake us up.  The irq handler
   *disables the interrupt.
  */
-static int
-tmio_nand_wait(struct mtd_info *mtd, struct nand_chip *nand_chip)
+static int tmio_nand_wait(struct nand_chip *nand_chip)
 {
-	struct tmio_nand *tmio = mtd_to_tmio(mtd);
+	struct tmio_nand *tmio = mtd_to_tmio(nand_to_mtd(nand_chip));
 	long timeout;
 	u8 status;
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 724e66c92fd2..f2e14f972319 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -695,8 +695,9 @@ static u8 spinand_read_byte(struct nand_chip *chip)
 	return data;
 }
 
-static int spinand_wait(struct mtd_info *mtd, struct nand_chip *chip)
+static int spinand_wait(struct nand_chip *chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct spinand_info *info = nand_get_controller_data(chip);
 
 	unsigned long timeo = jiffies;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 2a74de9012c4..520c0932d15a 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1294,7 +1294,7 @@ struct nand_chip {
 	int (*dev_ready)(struct nand_chip *chip);
 	void (*cmdfunc)(struct nand_chip *chip, unsigned command, int column,
 			int page_addr);
-	int(*waitfunc)(struct mtd_info *mtd, struct nand_chip *this);
+	int(*waitfunc)(struct nand_chip *chip);
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-- 
2.14.1
