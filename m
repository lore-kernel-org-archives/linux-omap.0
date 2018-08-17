From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 23/23] mtd: rawnand: Pass a nand_chip object nand_erase_nand()
Date: Fri, 17 Aug 2018 18:09:22 +0200
Message-ID: <20180817160922.6224-24-boris.brezillon@bootlin.com>
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

Let's tackle the nand_erase_nand() helper.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 10 +++++-----
 drivers/mtd/nand/raw/nand_bbt.c  |  2 +-
 include/linux/mtd/rawnand.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 074de0c8c9dc..ef4d90ed896d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -505,7 +505,7 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 		memset(&einfo, 0, sizeof(einfo));
 		einfo.addr = ofs;
 		einfo.len = 1ULL << chip->phys_erase_shift;
-		nand_erase_nand(mtd, &einfo, 0);
+		nand_erase_nand(chip, &einfo, 0);
 
 		/* Write bad block marker to OOB */
 		nand_get_device(mtd, FL_WRITING);
@@ -4638,22 +4638,22 @@ static int single_erase(struct nand_chip *chip, int page)
  */
 static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
-	return nand_erase_nand(mtd, instr, 0);
+	return nand_erase_nand(mtd_to_nand(mtd), instr, 0);
 }
 
 /**
  * nand_erase_nand - [INTERN] erase block(s)
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @instr: erase instruction
  * @allowbbt: allow erasing the bbt area
  *
  * Erase one ore more blocks.
  */
-int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
+int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int page, status, pages_per_block, ret, chipnr;
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	loff_t len;
 
 	pr_debug("%s: start = 0x%012llx, len = %llu\n",
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 7424be0547f8..9d73e086c5de 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -853,7 +853,7 @@ static int write_bbt(struct mtd_info *mtd, uint8_t *buf,
 		memset(&einfo, 0, sizeof(einfo));
 		einfo.addr = to;
 		einfo.len = 1 << this->bbt_erase_shift;
-		res = nand_erase_nand(mtd, &einfo, 1);
+		res = nand_erase_nand(this, &einfo, 1);
 		if (res < 0) {
 			pr_warn("nand_bbt: error while erasing BBT block %d\n",
 				res);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index eaf3d48032ed..5339f5c8307d 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1548,7 +1548,7 @@ int nand_create_bbt(struct nand_chip *chip);
 int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
 int nand_isreserved_bbt(struct nand_chip *chip, loff_t offs);
 int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
-int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
+int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt);
 
 /**
-- 
2.14.1
