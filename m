From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 06/19] mtd: rawnand: Deprecate ->block_{bad,markbad}() hooks
Date: Fri,  7 Sep 2018 00:38:38 +0200
Message-ID: <20180906223851.6964-7-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Ryan Mallon <rmallon@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Those hooks have been overloaded by some drivers for bad reasons:
either the driver was not fitting in the NAND framework and should
have been an MTD driver (docg4), or it was not properly implementing
the OOB read/write request or had a weird layout where BBM are trashed.
In any case, we should discourage people from overloading those
methods and encourage them to fix their driver instead.

Move the ->block_{bad,markbad}() hooks to the nand_legacy struct to
make it clear.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/cafe_nand.c           |  2 +-
 drivers/mtd/nand/raw/diskonchip.c          |  2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c |  4 ++--
 drivers/mtd/nand/raw/nand_base.c           | 37 ++++++++++++++++++++++--------
 drivers/mtd/nand/raw/nand_bbt.c            |  2 +-
 drivers/mtd/nand/raw/qcom_nandc.c          |  4 ++--
 drivers/mtd/nand/raw/sm_common.c           |  2 +-
 include/linux/mtd/rawnand.h                |  9 ++++----
 8 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 738af0f0a48d..db62b12800d3 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -719,7 +719,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	if (skipbbt) {
 		cafe->nand.options |= NAND_SKIP_BBTSCAN;
-		cafe->nand.block_bad = cafe_nand_block_bad;
+		cafe->nand.legacy.block_bad = cafe_nand_block_bad;
 	}
 
 	if (numtimings && numtimings != 3) {
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index c3a79369fbed..16fdfd06ef25 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1572,7 +1572,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->legacy.cmd_ctrl		= doc200x_hwcontrol;
 	nand->legacy.dev_ready	= doc200x_dev_ready;
 	nand->legacy.waitfunc	= doc200x_wait;
-	nand->block_bad		= doc200x_block_bad;
+	nand->legacy.block_bad	= doc200x_block_bad;
 	nand->ecc.hwctl		= doc200x_enable_hwecc;
 	nand->ecc.calculate	= doc200x_calculate_ecc;
 	nand->ecc.correct	= doc200x_correct_data;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index dc6291902acf..94c2b7525c85 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1774,7 +1774,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 		 */
 		if (block_mark != 0xff) {
 			dev_dbg(dev, "Transcribing mark in block %u\n", block);
-			ret = chip->block_markbad(chip, byte);
+			ret = chip->legacy.block_markbad(chip, byte);
 			if (ret)
 				dev_err(dev,
 					"Failed to mark block bad with ret %d\n",
@@ -1908,7 +1908,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	chip->legacy.read_buf	= gpmi_read_buf;
 	chip->legacy.write_buf	= gpmi_write_buf;
 	chip->badblock_pattern	= &gpmi_bbt_descr;
-	chip->block_markbad	= gpmi_block_markbad;
+	chip->legacy.block_markbad = gpmi_block_markbad;
 	chip->options		|= NAND_NO_SUBPAGE_WRITE;
 
 	/* Set up swap_block_mark, must be set before the gpmi_set_geometry() */
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 30b55a4677f9..d71a3d303903 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -475,6 +475,27 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
 	return ret;
 }
 
+/**
+ * nand_markbad_bbm - mark a block by updating the BBM
+ * @chip: NAND chip object
+ * @ofs: offset of the block to mark bad
+ */
+int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs)
+{
+	if (chip->legacy.block_markbad)
+		return chip->legacy.block_markbad(chip, ofs);
+
+	return nand_default_block_markbad(chip, ofs);
+}
+
+static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
+{
+	if (chip->legacy.block_bad)
+		return chip->legacy.block_bad(chip, ofs);
+
+	return nand_block_bad(chip, ofs);
+}
+
 /**
  * nand_block_markbad_lowlevel - mark a block bad
  * @mtd: MTD device structure
@@ -482,7 +503,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
  *
  * This function performs the generic NAND bad block marking steps (i.e., bad
  * block table(s) and/or marker(s)). We only allow the hardware driver to
- * specify how to write bad block markers to OOB (chip->block_markbad).
+ * specify how to write bad block markers to OOB (chip->legacy.block_markbad).
  *
  * We try operations in the following order:
  *
@@ -510,7 +531,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 
 		/* Write bad block marker to OOB */
 		nand_get_device(mtd, FL_WRITING);
-		ret = chip->block_markbad(chip, ofs);
+		ret = nand_markbad_bbm(chip, ofs);
 		nand_release_device(mtd);
 	}
 
@@ -582,11 +603,11 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 
-	if (!chip->bbt)
-		return chip->block_bad(chip, ofs);
-
 	/* Return info from the table */
-	return nand_isbad_bbt(chip, ofs, allowbbt);
+	if (chip->bbt)
+		return nand_isbad_bbt(chip, ofs, allowbbt);
+
+	return nand_isbad_bbm(chip, ofs);
 }
 
 /**
@@ -4942,10 +4963,6 @@ static void nand_set_defaults(struct nand_chip *chip)
 	/* If called twice, pointers that depend on busw may need to be reset */
 	if (!chip->legacy.read_byte || chip->legacy.read_byte == nand_read_byte)
 		chip->legacy.read_byte = busw ? nand_read_byte16 : nand_read_byte;
-	if (!chip->block_bad)
-		chip->block_bad = nand_block_bad;
-	if (!chip->block_markbad)
-		chip->block_markbad = nand_default_block_markbad;
 	if (!chip->legacy.write_buf || chip->legacy.write_buf == nand_write_buf)
 		chip->legacy.write_buf = busw ? nand_write_buf16 : nand_write_buf;
 	if (!chip->legacy.write_byte || chip->legacy.write_byte == nand_write_byte)
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 9d73e086c5de..b838ecdde8fb 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -689,7 +689,7 @@ static void mark_bbt_block_bad(struct nand_chip *this,
 	bbt_mark_entry(this, block, BBT_BLOCK_WORN);
 
 	to = (loff_t)block << this->bbt_erase_shift;
-	res = this->block_markbad(this, to);
+	res = nand_markbad_bbm(this, to);
 	if (res)
 		pr_warn("nand_bbt: error %d while marking block %d bad\n",
 			res, block);
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index bd187139416f..79342e24ed81 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2819,8 +2819,8 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	 * and block_markbad helpers until we permanently switch to using
 	 * MTD_OPS_RAW for all drivers (with the help of badblockbits)
 	 */
-	chip->block_bad		= qcom_nandc_block_bad;
-	chip->block_markbad	= qcom_nandc_block_markbad;
+	chip->legacy.block_bad		= qcom_nandc_block_bad;
+	chip->legacy.block_markbad	= qcom_nandc_block_markbad;
 
 	chip->controller = &nandc->controller;
 	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER |
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index bf143e0db787..6f063ef57640 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -168,7 +168,7 @@ static int sm_attach_chip(struct nand_chip *chip)
 	/* Bad block marker position */
 	chip->badblockpos = 0x05;
 	chip->badblockbits = 7;
-	chip->block_markbad = sm_block_markbad;
+	chip->legacy.block_markbad = sm_block_markbad;
 
 	/* ECC layout */
 	if (mtd->writesize == SM_SECTOR_SIZE)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 15642c028da2..aa3e931d0206 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1187,6 +1187,8 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  *	       If set to NULL no access to ready/busy is available and the
  *	       ready/busy information is read from the chip status register.
  * @waitfunc: hardware specific function for wait on ready.
+ * @block_bad: check if a block is bad, using OOB markers
+ * @block_markbad: mark a block bad
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1203,6 +1205,8 @@ struct nand_legacy {
 			int page_addr);
 	int (*dev_ready)(struct nand_chip *chip);
 	int (*waitfunc)(struct nand_chip *chip);
+	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
+	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 };
 
 /**
@@ -1214,8 +1218,6 @@ struct nand_legacy {
  *			fields/hooks, you should consider reworking the driver
  *			avoid using them.
  * @select_chip:	[REPLACEABLE] select chip nr
- * @block_bad:		[REPLACEABLE] check if a block is bad, using OOB markers
- * @block_markbad:	[REPLACEABLE] mark a block bad
  * @exec_op:		controller specific method to execute NAND operations.
  *			This method replaces ->cmdfunc(),
  *			->legacy.{read,write}_{buf,byte,word}(),
@@ -1303,8 +1305,6 @@ struct nand_chip {
 	struct nand_legacy legacy;
 
 	void (*select_chip)(struct nand_chip *chip, int cs);
-	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
-	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
@@ -1556,6 +1556,7 @@ extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
 
 int nand_create_bbt(struct nand_chip *chip);
 int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
+int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
 int nand_isreserved_bbt(struct nand_chip *chip, loff_t offs);
 int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
-- 
2.14.1
