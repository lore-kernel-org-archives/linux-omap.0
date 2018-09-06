From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 18/23] mtd: rawnand: Pass a nand_chip object to
 chip->erase()
Date: Thu,  6 Sep 2018 14:05:30 +0200
Message-ID: <20180906120535.21255-19-boris.brezillon@bootlin.com>
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
hooks to take a nand_chip object instead of an mtd_info one or
remove the mtd_info object when both are passed.

Let's tackle the chip->erase() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/denali.c    | 4 ++--
 drivers/mtd/nand/raw/docg4.c     | 4 ++--
 drivers/mtd/nand/raw/nand_base.c | 7 +++----
 include/linux/mtd/rawnand.h      | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 0c3fff9d65af..bb4ad3b822ad 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -915,9 +915,9 @@ static int denali_waitfunc(struct nand_chip *chip)
 	return irq_status & INTR__INT_ACT ? 0 : NAND_STATUS_FAIL;
 }
 
-static int denali_erase(struct mtd_info *mtd, int page)
+static int denali_erase(struct nand_chip *chip, int page)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 	uint32_t irq_status;
 
 	denali_reset_irq(denali);
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index ae20172f1b60..49500cae3d2f 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -892,9 +892,9 @@ static int docg4_read_oob(struct nand_chip *nand, int page)
 	return 0;
 }
 
-static int docg4_erase_block(struct mtd_info *mtd, int page)
+static int docg4_erase_block(struct nand_chip *nand, int page)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t g4_page;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9be0f98c1244..26be436eb8f1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4623,14 +4623,13 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 
 /**
  * single_erase - [GENERIC] NAND standard block erase command function
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @page: the page address of the block which will be erased
  *
  * Standard erase command for NAND chips. Returns NAND status.
  */
-static int single_erase(struct mtd_info *mtd, int page)
+static int single_erase(struct nand_chip *chip, int page)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	unsigned int eraseblock;
 
 	/* Send commands to erase a block */
@@ -4715,7 +4714,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		    (page + pages_per_block))
 			chip->pagebuf = -1;
 
-		status = chip->erase(mtd, page & chip->pagemask);
+		status = chip->erase(chip, page & chip->pagemask);
 
 		/* See if block erase succeeded */
 		if (status) {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index c00e571d09ca..8c8315d977de 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1298,7 +1298,7 @@ struct nand_chip {
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-	int (*erase)(struct mtd_info *mtd, int page);
+	int (*erase)(struct nand_chip *chip, int page);
 	int (*set_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			    int feature_addr, uint8_t *subfeature_para);
 	int (*get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
