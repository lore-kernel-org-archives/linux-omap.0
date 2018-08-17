From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 19/23] mtd: rawnand: Pass a nand_chip object to chip->{get,
 set}_features()
Date: Fri, 17 Aug 2018 18:09:18 +0200
Message-ID: <20180817160922.6224-20-boris.brezillon@bootlin.com>
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

Let's tackle the chip->{get,set}_features() hooks.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/mxc_nand.c  | 16 ++++++++--------
 drivers/mtd/nand/raw/nand_base.c | 21 ++++++---------------
 include/linux/mtd/rawnand.h      | 12 ++++++------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index a03a33656cf4..ec150e19a368 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1393,11 +1393,11 @@ static void mxc_nand_command(struct nand_chip *nand_chip, unsigned command,
 	}
 }
 
-static int mxc_nand_set_features(struct mtd_info *mtd, struct nand_chip *chip,
-				 int addr, u8 *subfeature_param)
+static int mxc_nand_set_features(struct nand_chip *chip, int addr,
+				 u8 *subfeature_param)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int i;
 
 	host->buf_start = 0;
@@ -1413,11 +1413,11 @@ static int mxc_nand_set_features(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static int mxc_nand_get_features(struct mtd_info *mtd, struct nand_chip *chip,
-				 int addr, u8 *subfeature_param)
+static int mxc_nand_get_features(struct nand_chip *chip, int addr,
+				 u8 *subfeature_param)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
-	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	int i;
 
 	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 26be436eb8f1..0ae597ced5b4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1163,12 +1163,10 @@ static bool nand_supports_set_features(struct nand_chip *chip, int addr)
 int nand_get_features(struct nand_chip *chip, int addr,
 		      u8 *subfeature_param)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!nand_supports_get_features(chip, addr))
 		return -ENOTSUPP;
 
-	return chip->get_features(mtd, chip, addr, subfeature_param);
+	return chip->get_features(chip, addr, subfeature_param);
 }
 EXPORT_SYMBOL_GPL(nand_get_features);
 
@@ -1184,12 +1182,10 @@ EXPORT_SYMBOL_GPL(nand_get_features);
 int nand_set_features(struct nand_chip *chip, int addr,
 		      u8 *subfeature_param)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-
 	if (!nand_supports_set_features(chip, addr))
 		return -ENOTSUPP;
 
-	return chip->set_features(mtd, chip, addr, subfeature_param);
+	return chip->set_features(chip, addr, subfeature_param);
 }
 EXPORT_SYMBOL_GPL(nand_set_features);
 
@@ -4846,13 +4842,11 @@ static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
 
 /**
  * nand_default_set_features- [REPLACEABLE] set NAND chip features
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
  */
-static int nand_default_set_features(struct mtd_info *mtd,
-				     struct nand_chip *chip, int addr,
+static int nand_default_set_features(struct nand_chip *chip, int addr,
 				     uint8_t *subfeature_param)
 {
 	return nand_set_features_op(chip, addr, subfeature_param);
@@ -4860,13 +4854,11 @@ static int nand_default_set_features(struct mtd_info *mtd,
 
 /**
  * nand_default_get_features- [REPLACEABLE] get NAND chip features
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
  */
-static int nand_default_get_features(struct mtd_info *mtd,
-				     struct nand_chip *chip, int addr,
+static int nand_default_get_features(struct nand_chip *chip, int addr,
 				     uint8_t *subfeature_param)
 {
 	return nand_get_features_op(chip, addr, subfeature_param);
@@ -4874,7 +4866,6 @@ static int nand_default_get_features(struct mtd_info *mtd,
 
 /**
  * nand_get_set_features_notsupp - set/get features stub returning -ENOTSUPP
- * @mtd: MTD device structure
  * @chip: nand chip info structure
  * @addr: feature address.
  * @subfeature_param: the subfeature parameters, a four bytes array.
@@ -4882,8 +4873,8 @@ static int nand_default_get_features(struct mtd_info *mtd,
  * Should be used by NAND controller drivers that do not support the SET/GET
  * FEATURES operations.
  */
-int nand_get_set_features_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				  int addr, u8 *subfeature_param)
+int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
+				  u8 *subfeature_param)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 469008740e89..471ad78d27a5 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1299,10 +1299,10 @@ struct nand_chip {
 		       const struct nand_operation *op,
 		       bool check_only);
 	int (*erase)(struct nand_chip *chip, int page);
-	int (*set_features)(struct mtd_info *mtd, struct nand_chip *chip,
-			    int feature_addr, uint8_t *subfeature_para);
-	int (*get_features)(struct mtd_info *mtd, struct nand_chip *chip,
-			    int feature_addr, uint8_t *subfeature_para);
+	int (*set_features)(struct nand_chip *chip, int feature_addr,
+			    uint8_t *subfeature_para);
+	int (*get_features)(struct nand_chip *chip, int feature_addr,
+			    uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
 	int (*setup_data_interface)(struct mtd_info *mtd, int chipnr,
 				    const struct nand_data_interface *conf);
@@ -1681,8 +1681,8 @@ int nand_read_oob_syndrome(struct nand_chip *chip, int page);
 int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
 int nand_set_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
 /* Stub used by drivers that do not support GET/SET FEATURES operations */
-int nand_get_set_features_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				  int addr, u8 *subfeature_param);
+int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
+				  u8 *subfeature_param);
 
 /* Default read_page_raw implementation */
 int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
-- 
2.14.1
