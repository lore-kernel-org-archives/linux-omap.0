From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 07/19] mtd: rawnand: Deprecate ->erase()
Date: Fri,  7 Sep 2018 00:38:39 +0200
Message-ID: <20180906223851.6964-8-boris.brezillon@bootlin.com>
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

The ->erase() hook have been overloaded by some drivers for bad reasons:
either the driver was not fitting in the NAND framework and should have
been an MTD driver (docg4), or the driver uses a specific path for the
ERASE operation (denali), instead of implementing it generically.
In any case, we should discourage people from overloading this method
and encourage them to implement ->exec_op() instead.

Move the ->erase() hook to the nand_legacy struct to make it clear.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/denali.c    | 2 +-
 drivers/mtd/nand/raw/nand_base.c | 7 +++++--
 include/linux/mtd/rawnand.h      | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index c14493ef6126..858358027dc9 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1275,7 +1275,7 @@ static int denali_attach_chip(struct nand_chip *chip)
 	chip->ecc.write_page_raw = denali_write_page_raw;
 	chip->ecc.read_oob = denali_read_oob;
 	chip->ecc.write_oob = denali_write_oob;
-	chip->erase = denali_erase;
+	chip->legacy.erase = denali_erase;
 
 	ret = denali_multidev_fixup(denali);
 	if (ret)
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d71a3d303903..57c89e275a3a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4730,7 +4730,11 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    (page + pages_per_block))
 			chip->pagebuf = -1;
 
-		status = chip->erase(chip, page & chip->pagemask);
+		if (chip->legacy.erase)
+			status = chip->legacy.erase(chip,
+						    page & chip->pagemask);
+		else
+			status = single_erase(chip, page & chip->pagemask);
 
 		/* See if block erase succeeded */
 		if (status) {
@@ -5756,7 +5760,6 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 		chip->options |= NAND_ROW_ADDR_3;
 
 	chip->badblockbits = 8;
-	chip->erase = single_erase;
 
 	/* Do not replace user supplied command function! */
 	if (mtd->writesize > 512 && chip->legacy.cmdfunc == nand_command)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index aa3e931d0206..97c6ff7d127e 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1189,6 +1189,7 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * @waitfunc: hardware specific function for wait on ready.
  * @block_bad: check if a block is bad, using OOB markers
  * @block_markbad: mark a block bad
+ * @erase: erase function
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1207,6 +1208,7 @@ struct nand_legacy {
 	int (*waitfunc)(struct nand_chip *chip);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
+	int (*erase)(struct nand_chip *chip, int page);
 };
 
 /**
@@ -1228,7 +1230,6 @@ struct nand_legacy {
  * @buf_align:		minimum buffer alignment required by a platform
  * @dummy_controller:	dummy controller implementation for drivers that can
  *			only control a single chip
- * @erase:		[REPLACEABLE] erase function
  * @chip_delay:		[BOARDSPECIFIC] chip dependent delay for transferring
  *			data from array to read regs (tR).
  * @state:		[INTERN] the current state of the NAND device
@@ -1308,7 +1309,6 @@ struct nand_chip {
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-	int (*erase)(struct nand_chip *chip, int page);
 	int (*set_features)(struct nand_chip *chip, int feature_addr,
 			    uint8_t *subfeature_para);
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
-- 
2.14.1
