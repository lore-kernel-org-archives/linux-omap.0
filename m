From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 04/23] mtd: rawnand: Pass a nand_chip object to
 nand_wait_ready()
Date: Thu,  6 Sep 2018 14:05:16 +0200
Message-ID: <20180906120535.21255-5-boris.brezillon@bootlin.com>
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

Let's make the raw NAND API consistent by patching all helpers to
take a nand_chip object instead of an mtd_info one.

Now is nand_wait_ready()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  2 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 12 ++++++------
 include/linux/mtd/rawnand.h                      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 9b62bc2d25a0..7022ffd271ad 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -232,7 +232,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct mtd_info *mtd,
 		nand_chip->cmd_ctrl(mtd, command, NAND_CTRL_CLE);
 
 		ndelay(100);
-		nand_wait_ready(mtd);
+		nand_wait_ready(nand_chip);
 		break;
 	case NAND_CMD_READID:
 		ctlcode = NCTL_CSA | 0x01000000 | NCTL_CMD1W | NCTL_CMD0;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 3304594177c6..94e5f7a56084 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -313,7 +313,7 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		cafe_writel(cafe, cafe->ctl2, NAND_CTRL2);
 		return;
 	}
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 	cafe_writel(cafe, cafe->ctl2, NAND_CTRL2);
 }
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f937efe145af..9d684f1d9e26 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -624,13 +624,13 @@ static void panic_nand_wait_ready(struct mtd_info *mtd, unsigned long timeo)
 
 /**
  * nand_wait_ready - [GENERIC] Wait for the ready pin after commands.
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * Wait for the ready pin after a command, and warn if a timeout occurs.
  */
-void nand_wait_ready(struct mtd_info *mtd)
+void nand_wait_ready(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned long timeo = 400;
 
 	if (in_interrupt() || oops_in_progress)
@@ -852,7 +852,7 @@ static void nand_command(struct mtd_info *mtd, unsigned int command,
 	 */
 	ndelay(100);
 
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 }
 
 static void nand_ccs_delay(struct nand_chip *chip)
@@ -1004,7 +1004,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
 	 */
 	ndelay(100);
 
-	nand_wait_ready(mtd);
+	nand_wait_ready(chip);
 }
 
 /**
@@ -2251,7 +2251,7 @@ static int nand_wait_rdy_op(struct nand_chip *chip, unsigned int timeout_ms,
 	if (!chip->dev_ready)
 		udelay(chip->chip_delay);
 	else
-		nand_wait_ready(nand_to_mtd(chip));
+		nand_wait_ready(chip);
 
 	return 0;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e9c59f0624ad..55014e42912a 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -37,7 +37,7 @@ static inline int nand_scan(struct nand_chip *chip, int max_chips)
 }
 
 /* Internal helper for board drivers which need to override command function */
-void nand_wait_ready(struct mtd_info *mtd);
+void nand_wait_ready(struct nand_chip *chip);
 
 /* The maximum number of NAND chips in an array */
 #define NAND_MAX_CHIPS		8
-- 
2.14.1
