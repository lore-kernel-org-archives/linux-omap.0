From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 13/23] mtd: rawnand: Pass a nand_chip object to
 chip->block_xxx() hooks
Date: Fri, 17 Aug 2018 18:09:12 +0200
Message-ID: <20180817160922.6224-14-boris.brezillon@bootlin.com>
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

Let's tackle all chip->block_xxx() hooks at once.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/cafe_nand.c           |  2 +-
 drivers/mtd/nand/raw/diskonchip.c          |  2 +-
 drivers/mtd/nand/raw/docg4.c               |  6 +++---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  6 +++---
 drivers/mtd/nand/raw/nand_base.c           | 16 ++++++++--------
 drivers/mtd/nand/raw/nand_bbt.c            |  3 +--
 drivers/mtd/nand/raw/qcom_nandc.c          |  7 +++----
 drivers/mtd/nand/raw/sm_common.c           |  3 ++-
 include/linux/mtd/rawnand.h                |  4 ++--
 9 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index e70a47aad538..af6870269f9c 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -546,7 +546,7 @@ static int cafe_nand_write_page_lowlevel(struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int cafe_nand_block_bad(struct mtd_info *mtd, loff_t ofs)
+static int cafe_nand_block_bad(struct nand_chip *chip, loff_t ofs)
 {
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 4d7b00d066fe..9cbcf020cabe 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -777,7 +777,7 @@ static int doc200x_dev_ready(struct mtd_info *mtd)
 	}
 }
 
-static int doc200x_block_bad(struct mtd_info *mtd, loff_t ofs)
+static int doc200x_block_bad(struct nand_chip *this, loff_t ofs)
 {
 	/* This is our last resort if we couldn't find or create a BBT.  Just
 	   pretend all blocks are good. */
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 84031b5d1d8e..762ed5599d47 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1102,7 +1102,7 @@ static int __init read_factory_bbt(struct mtd_info *mtd)
 	return 0;
 }
 
-static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
+static int docg4_block_markbad(struct nand_chip *nand, loff_t ofs)
 {
 	/*
 	 * Mark a block as bad.  Bad blocks are marked in the oob area of the
@@ -1115,7 +1115,7 @@ static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 	int ret, i;
 	uint8_t *buf;
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	struct nand_bbt_descr *bbtd = nand->badblock_pattern;
 	int page = (int)(ofs >> nand->page_shift);
@@ -1147,7 +1147,7 @@ static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	return ret;
 }
 
-static int docg4_block_neverbad(struct mtd_info *mtd, loff_t ofs)
+static int docg4_block_neverbad(struct nand_chip *nand, loff_t ofs)
 {
 	/* only called when module_param ignore_badblocks is set */
 	return 0;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index f5f1aebf0d64..2dce9b62ebe7 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1542,9 +1542,9 @@ static int gpmi_ecc_write_oob_raw(struct nand_chip *chip, int page)
 	return gpmi_ecc_write_page_raw(chip, NULL, 1, page);
 }
 
-static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
+static int gpmi_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret = 0;
 	uint8_t *block_mark;
@@ -1776,7 +1776,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 		 */
 		if (block_mark != 0xff) {
 			dev_dbg(dev, "Transcribing mark in block %u\n", block);
-			ret = chip->block_markbad(mtd, byte);
+			ret = chip->block_markbad(chip, byte);
 			if (ret)
 				dev_err(dev,
 					"Failed to mark block bad with ret %d\n",
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3d3e3c704a5a..add85235497e 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -398,15 +398,15 @@ static void nand_read_buf16(struct nand_chip *chip, uint8_t *buf, int len)
 
 /**
  * nand_block_bad - [DEFAULT] Read bad block marker from the chip
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @ofs: offset from device start
  *
  * Check, if the block is bad.
  */
-static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
+static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int page, page_end, res;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u8 bad;
 
 	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
@@ -435,16 +435,16 @@ static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
 
 /**
  * nand_default_block_markbad - [DEFAULT] mark a block bad via bad block marker
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @ofs: offset from device start
  *
  * This is the default implementation, which can be overridden by a hardware
  * specific driver. It provides the details for writing a bad block marker to a
  * block.
  */
-static int nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
+static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtd_oob_ops ops;
 	uint8_t buf[2] = { 0, 0 };
 	int ret = 0, res, i = 0;
@@ -510,7 +510,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 
 		/* Write bad block marker to OOB */
 		nand_get_device(mtd, FL_WRITING);
-		ret = chip->block_markbad(mtd, ofs);
+		ret = chip->block_markbad(chip, ofs);
 		nand_release_device(mtd);
 	}
 
@@ -583,7 +583,7 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
 	if (!chip->bbt)
-		return chip->block_bad(mtd, ofs);
+		return chip->block_bad(chip, ofs);
 
 	/* Return info from the table */
 	return nand_isbad_bbt(mtd, ofs, allowbbt);
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 39db352f8757..76849a441518 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -683,14 +683,13 @@ static void mark_bbt_block_bad(struct nand_chip *this,
 			       struct nand_bbt_descr *td,
 			       int chip, int block)
 {
-	struct mtd_info *mtd = nand_to_mtd(this);
 	loff_t to;
 	int res;
 
 	bbt_mark_entry(this, block, BBT_BLOCK_WORN);
 
 	to = (loff_t)block << this->bbt_erase_shift;
-	res = this->block_markbad(mtd, to);
+	res = this->block_markbad(this, to);
 	if (res)
 		pr_warn("nand_bbt: error %d while marking block %d bad\n",
 			res, block);
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index fd00d9f7bb01..952cb735f4cc 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2197,9 +2197,9 @@ static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 	return nand_prog_page_end_op(chip);
 }
 
-static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
+static int qcom_nandc_block_bad(struct nand_chip *chip, loff_t ofs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -2235,9 +2235,8 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	return bad;
 }
 
-static int qcom_nandc_block_markbad(struct mtd_info *mtd, loff_t ofs)
+static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index 02ac6e9b2d16..bf143e0db787 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -99,8 +99,9 @@ static const struct mtd_ooblayout_ops oob_sm_small_ops = {
 	.free = oob_sm_small_ooblayout_free,
 };
 
-static int sm_block_markbad(struct mtd_info *mtd, loff_t ofs)
+static int sm_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtd_oob_ops ops;
 	struct sm_oob oob;
 	int ret;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 65a25e89b426..0d8e2708e125 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1288,8 +1288,8 @@ struct nand_chip {
 	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
 	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
 	void (*select_chip)(struct nand_chip *chip, int cs);
-	int (*block_bad)(struct mtd_info *mtd, loff_t ofs);
-	int (*block_markbad)(struct mtd_info *mtd, loff_t ofs);
+	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
+	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 	void (*cmd_ctrl)(struct mtd_info *mtd, int dat, unsigned int ctrl);
 	int (*dev_ready)(struct mtd_info *mtd);
 	void (*cmdfunc)(struct mtd_info *mtd, unsigned command, int column,
-- 
2.14.1
