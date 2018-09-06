From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 20/23] mtd: rawnand: Pass a nand_chip object to
 chip->setup_read_retry()
Date: Thu,  6 Sep 2018 14:05:32 +0200
Message-ID: <20180906120535.21255-21-boris.brezillon@bootlin.com>
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

Let's tackle the chip->setup_read_retry() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c   | 12 +++++-------
 drivers/mtd/nand/raw/nand_hynix.c  |  3 +--
 drivers/mtd/nand/raw/nand_micron.c |  3 +--
 include/linux/mtd/rawnand.h        |  2 +-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0ae597ced5b4..a7575aa68c48 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3475,17 +3475,15 @@ static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
 
 /**
  * nand_setup_read_retry - [INTERN] Set the READ RETRY mode
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @retry_mode: the retry mode to use
  *
  * Some vendors supply a special command to shift the Vt threshold, to be used
  * when there are too many bitflips in a page (i.e., ECC error). After setting
  * a new threshold, the host should retry reading the page.
  */
-static int nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	pr_debug("setting READ RETRY mode %d\n", retry_mode);
 
 	if (retry_mode >= chip->read_retries)
@@ -3494,7 +3492,7 @@ static int nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
 	if (!chip->setup_read_retry)
 		return -EOPNOTSUPP;
 
-	return chip->setup_read_retry(mtd, retry_mode);
+	return chip->setup_read_retry(chip, retry_mode);
 }
 
 static void nand_wait_readrdy(struct nand_chip *chip)
@@ -3619,7 +3617,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 			if (mtd->ecc_stats.failed - ecc_failures) {
 				if (retry_mode + 1 < chip->read_retries) {
 					retry_mode++;
-					ret = nand_setup_read_retry(mtd,
+					ret = nand_setup_read_retry(chip,
 							retry_mode);
 					if (ret < 0)
 						break;
@@ -3646,7 +3644,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 
 		/* Reset to retry mode 0 */
 		if (retry_mode) {
-			ret = nand_setup_read_retry(mtd, 0);
+			ret = nand_setup_read_retry(chip, 0);
 			if (ret < 0)
 				break;
 			retry_mode = 0;
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index fa873e517131..bb1c4f8ce785 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -113,9 +113,8 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 	return 0;
 }
 
-static int hynix_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int hynix_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hynix_nand *hynix = nand_get_manufacturer_data(chip);
 	const u8 *values;
 	int i, ret;
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 2f26dbeb5428..1a5505ccbe54 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -74,9 +74,8 @@ struct micron_nand {
 	struct micron_on_die_ecc ecc;
 };
 
-static int micron_nand_setup_read_retry(struct mtd_info *mtd, int retry_mode)
+static int micron_nand_setup_read_retry(struct nand_chip *chip, int retry_mode)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {retry_mode};
 
 	return nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 7c639070c512..14ce2b078206 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1303,7 +1303,7 @@ struct nand_chip {
 			    uint8_t *subfeature_para);
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
 			    uint8_t *subfeature_para);
-	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
+	int (*setup_read_retry)(struct nand_chip *chip, int retry_mode);
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
 
-- 
2.14.1
