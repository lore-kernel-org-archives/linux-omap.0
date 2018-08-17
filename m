From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 22/23] mtd: rawnand: Pass a nand_chip object to all
 nand_xxx_bbt() helpers
Date: Fri, 17 Aug 2018 18:09:21 +0200
Message-ID: <20180817160922.6224-23-boris.brezillon@bootlin.com>
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

Let's tackle the nand_xxx_bbt() helpers.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c |  6 +++---
 drivers/mtd/nand/raw/nand_bbt.c  | 16 +++++++---------
 include/linux/mtd/rawnand.h      |  6 +++---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0a89ab663728..074de0c8c9dc 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -515,7 +515,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 
 	/* Mark block bad in BBT */
 	if (chip->bbt) {
-		res = nand_markbad_bbt(mtd, ofs);
+		res = nand_markbad_bbt(chip, ofs);
 		if (!ret)
 			ret = res;
 	}
@@ -565,7 +565,7 @@ static int nand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 	if (!chip->bbt)
 		return 0;
 	/* Return info from the table */
-	return nand_isreserved_bbt(mtd, ofs);
+	return nand_isreserved_bbt(chip, ofs);
 }
 
 /**
@@ -585,7 +585,7 @@ static int nand_block_checkbad(struct mtd_info *mtd, loff_t ofs, int allowbbt)
 		return chip->block_bad(chip, ofs);
 
 	/* Return info from the table */
-	return nand_isbad_bbt(mtd, ofs, allowbbt);
+	return nand_isbad_bbt(chip, ofs, allowbbt);
 }
 
 /**
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 76849a441518..7424be0547f8 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1387,12 +1387,11 @@ EXPORT_SYMBOL(nand_create_bbt);
 
 /**
  * nand_isreserved_bbt - [NAND Interface] Check if a block is reserved
- * @mtd: MTD device structure
+ * @this: NAND chip object
  * @offs: offset in the device
  */
-int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs)
+int nand_isreserved_bbt(struct nand_chip *this, loff_t offs)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	int block;
 
 	block = (int)(offs >> this->bbt_erase_shift);
@@ -1401,13 +1400,12 @@ int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs)
 
 /**
  * nand_isbad_bbt - [NAND Interface] Check if a block is bad
- * @mtd: MTD device structure
+ * @this: NAND chip object
  * @offs: offset in the device
  * @allowbbt: allow access to bad block table region
  */
-int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
+int nand_isbad_bbt(struct nand_chip *this, loff_t offs, int allowbbt)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	int block, res;
 
 	block = (int)(offs >> this->bbt_erase_shift);
@@ -1429,12 +1427,12 @@ int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
 
 /**
  * nand_markbad_bbt - [NAND Interface] Mark a block bad in the BBT
- * @mtd: MTD device structure
+ * @this: NAND chip object
  * @offs: offset of the bad block
  */
-int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs)
+int nand_markbad_bbt(struct nand_chip *this, loff_t offs)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(this);
 	int block, ret = 0;
 
 	block = (int)(offs >> this->bbt_erase_shift);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 7df3e29a1f83..eaf3d48032ed 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1545,9 +1545,9 @@ extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
 
 int nand_create_bbt(struct nand_chip *chip);
-int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
-int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs);
-int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt);
+int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
+int nand_isreserved_bbt(struct nand_chip *chip, loff_t offs);
+int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
 int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		    int allowbbt);
 
-- 
2.14.1
