From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
Date: Thu,  6 Sep 2018 14:05:20 +0200
Message-ID: <20180906120535.21255-9-boris.brezillon@bootlin.com>
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

Let's tackle all ecc->read_xxx() hooks at once.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Add Stefan A-b
- Patched the Toshiba driver
---
 drivers/mtd/nand/raw/atmel/nand-controller.c  | 12 ++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 21 ++++----
 drivers/mtd/nand/raw/cafe_nand.c              | 10 ++--
 drivers/mtd/nand/raw/denali.c                 | 17 +++---
 drivers/mtd/nand/raw/docg4.c                  | 20 ++++----
 drivers/mtd/nand/raw/fsl_elbc_nand.c          |  5 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c           |  5 +-
 drivers/mtd/nand/raw/fsmc_nand.c              |  6 +--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    | 23 ++++-----
 drivers/mtd/nand/raw/hisi504_nand.c           |  9 ++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c            | 10 ++--
 drivers/mtd/nand/raw/lpc32xx_slc.c            | 14 ++---
 drivers/mtd/nand/raw/marvell_nand.c           | 30 +++++------
 drivers/mtd/nand/raw/mtk_nand.c               | 23 +++++----
 drivers/mtd/nand/raw/mxc_nand.c               | 11 ++--
 drivers/mtd/nand/raw/nand_base.c              | 74 +++++++++++++--------------
 drivers/mtd/nand/raw/nand_micron.c            |  6 +--
 drivers/mtd/nand/raw/nand_toshiba.c           | 10 ++--
 drivers/mtd/nand/raw/omap2.c                  |  6 +--
 drivers/mtd/nand/raw/qcom_nandc.c             | 11 ++--
 drivers/mtd/nand/raw/r852.c                   |  5 +-
 drivers/mtd/nand/raw/sh_flctl.c               |  6 ++-
 drivers/mtd/nand/raw/sunxi_nand.c             | 26 +++++-----
 drivers/mtd/nand/raw/tango_nand.c             | 16 +++---
 drivers/mtd/nand/raw/tegra_nand.c             | 15 +++---
 drivers/mtd/nand/raw/vf610_nfc.c              | 18 +++----
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  5 +-
 include/linux/mtd/rawnand.h                   | 30 +++++------
 28 files changed, 221 insertions(+), 223 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index cef22a79f3a6..45061b591346 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -895,15 +895,13 @@ static int atmel_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	return ret;
 }
 
-static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
-				      struct nand_chip *chip, u8 *buf,
+static int atmel_nand_pmecc_read_page(struct nand_chip *chip, u8 *buf,
 				      int oob_required, int page)
 {
 	return atmel_nand_pmecc_read_pg(chip, buf, oob_required, page, false);
 }
 
-static int atmel_nand_pmecc_read_page_raw(struct mtd_info *mtd,
-					  struct nand_chip *chip, u8 *buf,
+static int atmel_nand_pmecc_read_page_raw(struct nand_chip *chip, u8 *buf,
 					  int oob_required, int page)
 {
 	return atmel_nand_pmecc_read_pg(chip, buf, oob_required, page, true);
@@ -1037,16 +1035,14 @@ static int atmel_hsmc_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	return ret;
 }
 
-static int atmel_hsmc_nand_pmecc_read_page(struct mtd_info *mtd,
-					   struct nand_chip *chip, u8 *buf,
+static int atmel_hsmc_nand_pmecc_read_page(struct nand_chip *chip, u8 *buf,
 					   int oob_required, int page)
 {
 	return atmel_hsmc_nand_pmecc_read_pg(chip, buf, oob_required, page,
 					     false);
 }
 
-static int atmel_hsmc_nand_pmecc_read_page_raw(struct mtd_info *mtd,
-					       struct nand_chip *chip,
+static int atmel_hsmc_nand_pmecc_read_page_raw(struct nand_chip *chip,
 					       u8 *buf, int oob_required,
 					       int page)
 {
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 19e6e918f896..a17ae692aee9 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1689,7 +1689,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	sas = mtd->oobsize / chip->ecc.steps;
 
 	/* read without ecc for verification */
-	ret = chip->ecc.read_page_raw(mtd, chip, buf, true, page);
+	ret = chip->ecc.read_page_raw(chip, buf, true, page);
 	if (ret)
 		return ret;
 
@@ -1786,9 +1786,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static int brcmnand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			      uint8_t *buf, int oob_required, int page)
+static int brcmnand_read_page(struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 
@@ -1798,10 +1799,11 @@ static int brcmnand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 			mtd->writesize >> FC_SHIFT, (u32 *)buf, oob);
 }
 
-static int brcmnand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				  uint8_t *buf, int oob_required, int page)
+static int brcmnand_read_page_raw(struct nand_chip *chip, uint8_t *buf,
+				  int oob_required, int page)
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 *oob = oob_required ? (u8 *)chip->oob_poi : NULL;
 	int ret;
 
@@ -1814,17 +1816,18 @@ static int brcmnand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return ret;
 }
 
-static int brcmnand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			     int page)
+static int brcmnand_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return brcmnand_read(mtd, chip, (u64)page << chip->page_shift,
 			mtd->writesize >> FC_SHIFT,
 			NULL, (u8 *)chip->oob_poi);
 }
 
-static int brcmnand_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				 int page)
+static int brcmnand_read_oob_raw(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 
 	brcmnand_set_ecc_enabled(host, 0);
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 94e5f7a56084..c6071d71cc1b 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -354,9 +354,10 @@ static int cafe_nand_write_oob(struct mtd_info *mtd,
 }
 
 /* Don't use -- use nand_read_oob_std for now */
-static int cafe_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			      int page)
+static int cafe_nand_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 /**
@@ -369,9 +370,10 @@ static int cafe_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
  * The hw generator calculates the error syndrome automatically. Therefore
  * we need a special oob layout and handling.
  */
-static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       uint8_t *buf, int oob_required, int page)
+static int cafe_nand_read_page(struct nand_chip *chip, uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 	unsigned int max_bitflips = 0;
 
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 958619fd4d1b..994921814d76 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -676,9 +676,10 @@ static void denali_oob_xfer(struct mtd_info *mtd, struct nand_chip *chip,
 					   false);
 }
 
-static int denali_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int writesize = mtd->writesize;
 	int oobsize = mtd->oobsize;
@@ -751,9 +752,10 @@ static int denali_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static int denali_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			   int page)
+static int denali_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	denali_oob_xfer(mtd, chip, page, 0);
 
 	return 0;
@@ -771,9 +773,10 @@ static int denali_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			    uint8_t *buf, int oob_required, int page)
+static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
+			    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	unsigned long uncor_ecc_flags = 0;
 	int stat = 0;
@@ -792,7 +795,7 @@ static int denali_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		return stat;
 
 	if (uncor_ecc_flags) {
-		ret = denali_read_oob(mtd, chip, page);
+		ret = denali_read_oob(chip, page);
 		if (ret)
 			return ret;
 
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 2d86bc5a886d..ebaa479ffcb2 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -845,21 +845,21 @@ static int read_page(struct mtd_info *mtd, struct nand_chip *nand,
 }
 
 
-static int docg4_read_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
-			       uint8_t *buf, int oob_required, int page)
+static int docg4_read_page_raw(struct nand_chip *nand, uint8_t *buf,
+			       int oob_required, int page)
 {
-	return read_page(mtd, nand, buf, page, false);
+	return read_page(nand_to_mtd(nand), nand, buf, page, false);
 }
 
-static int docg4_read_page(struct mtd_info *mtd, struct nand_chip *nand,
-			   uint8_t *buf, int oob_required, int page)
+static int docg4_read_page(struct nand_chip *nand, uint8_t *buf,
+			   int oob_required, int page)
 {
-	return read_page(mtd, nand, buf, page, true);
+	return read_page(nand_to_mtd(nand), nand, buf, page, true);
 }
 
-static int docg4_read_oob(struct mtd_info *mtd, struct nand_chip *nand,
-			  int page)
+static int docg4_read_oob(struct nand_chip *nand, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 	uint16_t status;
@@ -1059,7 +1059,7 @@ static int __init read_factory_bbt(struct mtd_info *mtd)
 		return -ENOMEM;
 
 	read_page_prologue(mtd, g4_addr);
-	docg4_read_page(mtd, nand, buf, 0, DOCG4_FACTORY_BBT_PAGE);
+	docg4_read_page(nand, buf, 0, DOCG4_FACTORY_BBT_PAGE);
 
 	/*
 	 * If no memory-based bbt was created, exit.  This will happen if module
@@ -1077,7 +1077,7 @@ static int __init read_factory_bbt(struct mtd_info *mtd)
 		 * It is stored redundantly, so we get another chance.
 		 */
 		eccfailed_stats = mtd->ecc_stats.failed;
-		docg4_read_page(mtd, nand, buf, 0, DOCG4_REDUNDANT_BBT_PAGE);
+		docg4_read_page(nand, buf, 0, DOCG4_REDUNDANT_BBT_PAGE);
 		if (mtd->ecc_stats.failed > eccfailed_stats) {
 			dev_warn(doc->dev,
 				 "The factory bbt could not be read!\n");
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 22bcd64a66c8..26fcb8ea0c2e 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -710,9 +710,10 @@ static const struct nand_controller_ops fsl_elbc_controller_ops = {
 	.attach_chip = fsl_elbc_attach_chip,
 };
 
-static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			      uint8_t *buf, int oob_required, int page)
+static int fsl_elbc_read_page(struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = ctrl->nand;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 70bf8e1552a5..8c6016932aaa 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -679,9 +679,10 @@ static int check_erased_page(struct nand_chip *chip, u8 *buf)
 	return bitflips;
 }
 
-static int fsl_ifc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			     uint8_t *buf, int oob_required, int page)
+static int fsl_ifc_read_page(struct nand_chip *chip, uint8_t *buf,
+			     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_nand_ctrl *nctrl = ifc_nand_ctrl;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index b41fd09fa389..5fc036c89cc8 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -707,7 +707,6 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
 
 /*
  * fsmc_read_page_hwecc
- * @mtd:	mtd info structure
  * @chip:	nand chip info structure
  * @buf:	buffer to store read data
  * @oob_required:	caller expects OOB data read to chip->oob_poi
@@ -719,9 +718,10 @@ static int fsmc_exec_op(struct nand_chip *chip, const struct nand_operation *op,
  * After this read, fsmc hardware generates and reports error data bits(up to a
  * max of 8 bits)
  */
-static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				 uint8_t *buf, int oob_required, int page)
+static int fsmc_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, j, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index fe99d9323d4a..5650ebf28903 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1085,8 +1085,8 @@ static int gpmi_ecc_read_page_data(struct nand_chip *chip,
 	return max_bitflips;
 }
 
-static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			      uint8_t *buf, int oob_required, int page)
+static int gpmi_ecc_read_page(struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
 {
 	nand_read_page_op(chip, page, 0, NULL, 0);
 
@@ -1094,8 +1094,8 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /* Fake a virtual small page for the subpage read */
-static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t offs, uint32_t len, uint8_t *buf, int page)
+static int gpmi_ecc_read_subpage(struct nand_chip *chip, uint32_t offs,
+				 uint32_t len, uint8_t *buf, int page)
 {
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	void __iomem *bch_regs = this->resources.bch_regs;
@@ -1130,7 +1130,7 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 			dev_dbg(this->dev,
 				"page:%d, first:%d, last:%d, marker at:%d\n",
 				page, first, last, marker_pos);
-			return gpmi_ecc_read_page(mtd, chip, buf, 0, page);
+			return gpmi_ecc_read_page(chip, buf, 0, page);
 		}
 	}
 
@@ -1324,9 +1324,9 @@ static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
  * ECC-based or raw view of the page is implicit in which function it calls
  * (there is a similar pair of ECC-based/raw functions for writing).
  */
-static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-				int page)
+static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 
 	dev_dbg(this->dev, "page number is %d\n", page);
@@ -1380,10 +1380,10 @@ gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
  * See set_geometry_by_ecc_info inline comments to have a full description
  * of the layout used by the GPMI controller.
  */
-static int gpmi_ecc_read_page_raw(struct mtd_info *mtd,
-				  struct nand_chip *chip, uint8_t *buf,
+static int gpmi_ecc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 				  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	int eccsize = nfc_geo->ecc_chunk_size;
@@ -1536,10 +1536,9 @@ static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
 				 mtd->writesize + mtd->oobsize);
 }
 
-static int gpmi_ecc_read_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				 int page)
+static int gpmi_ecc_read_oob_raw(struct nand_chip *chip, int page)
 {
-	return gpmi_ecc_read_page_raw(mtd, chip, NULL, 1, page);
+	return gpmi_ecc_read_page_raw(chip, NULL, 1, page);
 }
 
 static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 9106a1d60bca..f4078086c14c 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -528,9 +528,10 @@ static irqreturn_t hinfc_irq_handle(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int hisi_nand_read_page_hwecc(struct mtd_info *mtd,
-	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
+static int hisi_nand_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
+				     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 	int max_bitflips = 0, stat = 0, stat_max = 0, status_ecc;
 	int stat_1, stat_2;
@@ -560,9 +561,9 @@ static int hisi_nand_read_page_hwecc(struct mtd_info *mtd,
 	return max_bitflips;
 }
 
-static int hisi_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-				int page)
+static int hisi_nand_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 84e421710297..1849e9858d45 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -442,9 +442,10 @@ static int lpc32xx_xmit_dma(struct mtd_info *mtd, void *mem, int len,
 	return -ENXIO;
 }
 
-static int lpc32xx_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			     uint8_t *buf, int oob_required, int page)
+static int lpc32xx_read_page(struct nand_chip *chip, uint8_t *buf,
+			     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	int i, j;
 	uint8_t *oobbuf = chip->oob_poi;
@@ -557,13 +558,12 @@ static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 }
 
-static int lpc32xx_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page)
+static int lpc32xx_read_oob(struct nand_chip *chip, int page)
 {
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 
 	/* Read whole page - necessary with MLC controller! */
-	lpc32xx_read_page(mtd, chip, host->dummy_buf, 1, page);
+	lpc32xx_read_page(chip, host->dummy_buf, 1, page);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index d5cb1b40a235..a9cb089923be 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -396,9 +396,10 @@ static void lpc32xx_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
 /*
  * Read the OOB data from the device without ECC using FIFO method
  */
-static int lpc32xx_nand_read_oob_syndrome(struct mtd_info *mtd,
-					  struct nand_chip *chip, int page)
+static int lpc32xx_nand_read_oob_syndrome(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 
@@ -610,10 +611,10 @@ static int lpc32xx_xfer(struct mtd_info *mtd, uint8_t *buf, int eccsubpages,
  * Read the data and OOB data from the device, use ECC correction with the
  * data, disable ECC for the OOB data
  */
-static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
-					   struct nand_chip *chip, uint8_t *buf,
+static int lpc32xx_nand_read_page_syndrome(struct nand_chip *chip, uint8_t *buf,
 					   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	struct mtd_oob_region oobregion = { };
 	int stat, i, status, error;
@@ -657,11 +658,12 @@ static int lpc32xx_nand_read_page_syndrome(struct mtd_info *mtd,
  * Read the data and OOB data from the device, no ECC correction with the
  * data or OOB data
  */
-static int lpc32xx_nand_read_page_raw_syndrome(struct mtd_info *mtd,
-					       struct nand_chip *chip,
+static int lpc32xx_nand_read_page_raw_syndrome(struct nand_chip *chip,
 					       uint8_t *buf, int oob_required,
 					       int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	/* Issue read command */
 	nand_read_page_op(chip, page, 0, NULL, 0);
 
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 5a9836c5093c..a81018f3a2f4 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1026,18 +1026,15 @@ static int marvell_nfc_hw_ecc_hmg_do_read_page(struct nand_chip *chip,
 	return ret;
 }
 
-static int marvell_nfc_hw_ecc_hmg_read_page_raw(struct mtd_info *mtd,
-						struct nand_chip *chip, u8 *buf,
+static int marvell_nfc_hw_ecc_hmg_read_page_raw(struct nand_chip *chip, u8 *buf,
 						int oob_required, int page)
 {
 	return marvell_nfc_hw_ecc_hmg_do_read_page(chip, buf, chip->oob_poi,
 						   true, page);
 }
 
-static int marvell_nfc_hw_ecc_hmg_read_page(struct mtd_info *mtd,
-					    struct nand_chip *chip,
-					    u8 *buf, int oob_required,
-					    int page)
+static int marvell_nfc_hw_ecc_hmg_read_page(struct nand_chip *chip, u8 *buf,
+					    int oob_required, int page)
 {
 	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
 	unsigned int full_sz = lt->data_bytes + lt->spare_bytes + lt->ecc_bytes;
@@ -1075,8 +1072,7 @@ static int marvell_nfc_hw_ecc_hmg_read_page(struct mtd_info *mtd,
  * it appears before the ECC bytes when reading), the ->read_oob_raw() function
  * also stands for ->read_oob().
  */
-static int marvell_nfc_hw_ecc_hmg_read_oob_raw(struct mtd_info *mtd,
-					       struct nand_chip *chip, int page)
+static int marvell_nfc_hw_ecc_hmg_read_oob_raw(struct nand_chip *chip, int page)
 {
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
@@ -1183,10 +1179,10 @@ static int marvell_nfc_hw_ecc_hmg_write_oob_raw(struct mtd_info *mtd,
 }
 
 /* BCH read helpers */
-static int marvell_nfc_hw_ecc_bch_read_page_raw(struct mtd_info *mtd,
-						struct nand_chip *chip, u8 *buf,
+static int marvell_nfc_hw_ecc_bch_read_page_raw(struct nand_chip *chip, u8 *buf,
 						int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
 	u8 *oob = chip->oob_poi;
 	int chunk_size = lt->data_bytes + lt->spare_bytes + lt->ecc_bytes;
@@ -1295,11 +1291,11 @@ static void marvell_nfc_hw_ecc_bch_read_chunk(struct nand_chip *chip, int chunk,
 	}
 }
 
-static int marvell_nfc_hw_ecc_bch_read_page(struct mtd_info *mtd,
-					    struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_bch_read_page(struct nand_chip *chip,
 					    u8 *buf, int oob_required,
 					    int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
 	int data_len = lt->data_bytes, spare_len = lt->spare_bytes, ecc_len;
 	u8 *data = buf, *spare = chip->oob_poi, *ecc;
@@ -1392,22 +1388,20 @@ static int marvell_nfc_hw_ecc_bch_read_page(struct mtd_info *mtd,
 	return max_bitflips;
 }
 
-static int marvell_nfc_hw_ecc_bch_read_oob_raw(struct mtd_info *mtd,
-					       struct nand_chip *chip, int page)
+static int marvell_nfc_hw_ecc_bch_read_oob_raw(struct nand_chip *chip, int page)
 {
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
 
-	return chip->ecc.read_page_raw(mtd, chip, chip->data_buf, true, page);
+	return chip->ecc.read_page_raw(chip, chip->data_buf, true, page);
 }
 
-static int marvell_nfc_hw_ecc_bch_read_oob(struct mtd_info *mtd,
-					   struct nand_chip *chip, int page)
+static int marvell_nfc_hw_ecc_bch_read_oob(struct nand_chip *chip, int page)
 {
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
 
-	return chip->ecc.read_page(mtd, chip, chip->data_buf, true, page);
+	return chip->ecc.read_page(chip, chip->data_buf, true, page);
 }
 
 /* BCH write helpers */
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 46d447f148f1..32d5b59eb879 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -969,23 +969,25 @@ static int mtk_nfc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	return bitflips;
 }
 
-static int mtk_nfc_read_subpage_hwecc(struct mtd_info *mtd,
-				      struct nand_chip *chip, u32 off,
+static int mtk_nfc_read_subpage_hwecc(struct nand_chip *chip, u32 off,
 				      u32 len, u8 *p, int pg)
 {
-	return mtk_nfc_read_subpage(mtd, chip, off, len, p, pg, 0);
+	return mtk_nfc_read_subpage(nand_to_mtd(chip), chip, off, len, p, pg,
+				    0);
 }
 
-static int mtk_nfc_read_page_hwecc(struct mtd_info *mtd,
-				   struct nand_chip *chip, u8 *p,
-				   int oob_on, int pg)
+static int mtk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *p, int oob_on,
+				   int pg)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return mtk_nfc_read_subpage(mtd, chip, 0, mtd->writesize, p, pg, 0);
 }
 
-static int mtk_nfc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				 u8 *buf, int oob_on, int page)
+static int mtk_nfc_read_page_raw(struct nand_chip *chip, u8 *buf, int oob_on,
+				 int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtk_nfc_nand_chip *mtk_nand = to_mtk_nand(chip);
 	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 	struct mtk_nfc_fdm *fdm = &mtk_nand->fdm;
@@ -1011,10 +1013,9 @@ static int mtk_nfc_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return ret;
 }
 
-static int mtk_nfc_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
-				int page)
+static int mtk_nfc_read_oob_std(struct nand_chip *chip, int page)
 {
-	return mtk_nfc_read_page_raw(mtd, chip, NULL, 1, page);
+	return mtk_nfc_read_page_raw(chip, NULL, 1, page);
 }
 
 static inline void mtk_nfc_hw_init(struct mtk_nfc *nfc)
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 3c57e14e1c7c..35fcec595c3e 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -816,8 +816,8 @@ static int mxc_nand_read_page_v2_v3(struct nand_chip *chip, void *buf,
 	return max_bitflips;
 }
 
-static int mxc_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			      uint8_t *buf, int oob_required, int page)
+static int mxc_nand_read_page(struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
 {
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	void *oob_buf;
@@ -830,8 +830,8 @@ static int mxc_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return host->devtype_data->read_page(chip, buf, oob_buf, 1, page);
 }
 
-static int mxc_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				  uint8_t *buf, int oob_required, int page)
+static int mxc_nand_read_page_raw(struct nand_chip *chip, uint8_t *buf,
+				  int oob_required, int page)
 {
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	void *oob_buf;
@@ -844,8 +844,7 @@ static int mxc_nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return host->devtype_data->read_page(chip, buf, oob_buf, 0, page);
 }
 
-static int mxc_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			     int page)
+static int mxc_nand_read_oob(struct nand_chip *chip, int page)
 {
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0444bd23c84b..e1f60c841348 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -427,7 +427,7 @@ static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
 	page_end = page + (chip->bbt_options & NAND_BBT_SCAN2NDPAGE ? 2 : 1);
 
 	for (; page < page_end; page++) {
-		res = chip->ecc.read_oob(mtd, chip, page);
+		res = chip->ecc.read_oob(chip, page);
 		if (res < 0)
 			return res;
 
@@ -2978,7 +2978,6 @@ EXPORT_SYMBOL(nand_check_erased_ecc_chunk);
 
 /**
  * nand_read_page_raw_notsupp - dummy read raw page function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -2986,8 +2985,8 @@ EXPORT_SYMBOL(nand_check_erased_ecc_chunk);
  *
  * Returns -ENOTSUPP unconditionally.
  */
-int nand_read_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-			       u8 *buf, int oob_required, int page)
+int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
+			       int oob_required, int page)
 {
 	return -ENOTSUPP;
 }
@@ -2995,7 +2994,6 @@ EXPORT_SYMBOL(nand_read_page_raw_notsupp);
 
 /**
  * nand_read_page_raw - [INTERN] read raw page data without ecc
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -3003,9 +3001,10 @@ EXPORT_SYMBOL(nand_read_page_raw_notsupp);
  *
  * Not for syndrome calculating ECC controllers, which use a special oob layout.
  */
-int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-		       uint8_t *buf, int oob_required, int page)
+int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
+		       int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	ret = nand_read_page_op(chip, page, 0, buf, mtd->writesize);
@@ -3025,7 +3024,6 @@ EXPORT_SYMBOL(nand_read_page_raw);
 
 /**
  * nand_read_page_raw_syndrome - [INTERN] read raw page data without ecc
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -3033,10 +3031,10 @@ EXPORT_SYMBOL(nand_read_page_raw);
  *
  * We need a special oob layout and handling even when OOB isn't used.
  */
-static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
-				       struct nand_chip *chip, uint8_t *buf,
+static int nand_read_page_raw_syndrome(struct nand_chip *chip, uint8_t *buf,
 				       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	uint8_t *oob = chip->oob_poi;
@@ -3090,15 +3088,15 @@ static int nand_read_page_raw_syndrome(struct mtd_info *mtd,
 
 /**
  * nand_read_page_swecc - [REPLACEABLE] software ECC based page read function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
  * @page: page number to read
  */
-static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int nand_read_page_swecc(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -3107,7 +3105,7 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	uint8_t *ecc_code = chip->ecc.code_buf;
 	unsigned int max_bitflips = 0;
 
-	chip->ecc.read_page_raw(mtd, chip, buf, 1, page);
+	chip->ecc.read_page_raw(chip, buf, 1, page);
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->ecc.calculate(chip, p, &ecc_calc[i]);
@@ -3136,17 +3134,16 @@ static int nand_read_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * nand_read_subpage - [REPLACEABLE] ECC based sub-page read function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @data_offs: offset of requested data within the page
  * @readlen: data length
  * @bufpoi: buffer to store read data
  * @page: page number to read
  */
-static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t data_offs, uint32_t readlen, uint8_t *bufpoi,
-			int page)
+static int nand_read_subpage(struct nand_chip *chip, uint32_t data_offs,
+			     uint32_t readlen, uint8_t *bufpoi, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int start_step, end_step, num_steps, ret;
 	uint8_t *p;
 	int data_col_addr, i, gaps = 0;
@@ -3248,7 +3245,6 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * nand_read_page_hwecc - [REPLACEABLE] hardware ECC based page read function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -3256,9 +3252,10 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
  *
  * Not for syndrome calculating ECC controllers which need a special oob layout.
  */
-static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int nand_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -3318,7 +3315,6 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * nand_read_page_hwecc_oob_first - [REPLACEABLE] hw ecc, read oob first
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -3330,9 +3326,10 @@ static int nand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * multiple ECC steps, follows the "infix ECC" scheme and reads/writes ECC from
  * the data area, by overwriting the NAND manufacturer bad block markings.
  */
-static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
-	struct nand_chip *chip, uint8_t *buf, int oob_required, int page)
+static int nand_read_page_hwecc_oob_first(struct nand_chip *chip, uint8_t *buf,
+					  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -3388,7 +3385,6 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
 
 /**
  * nand_read_page_syndrome - [REPLACEABLE] hardware ECC syndrome based page read
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: buffer to store read data
  * @oob_required: caller requires OOB data read to chip->oob_poi
@@ -3397,9 +3393,10 @@ static int nand_read_page_hwecc_oob_first(struct mtd_info *mtd,
  * The hw generator calculates the error syndrome automatically. Therefore we
  * need a special oob layout and handling.
  */
-static int nand_read_page_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-				   uint8_t *buf, int oob_required, int page)
+static int nand_read_page_syndrome(struct nand_chip *chip, uint8_t *buf,
+				   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret, i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -3610,16 +3607,15 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 			 * the read methods return max bitflips per ecc step.
 			 */
 			if (unlikely(ops->mode == MTD_OPS_RAW))
-				ret = chip->ecc.read_page_raw(mtd, chip, bufpoi,
+				ret = chip->ecc.read_page_raw(chip, bufpoi,
 							      oob_required,
 							      page);
 			else if (!aligned && NAND_HAS_SUBPAGE_READ(chip) &&
 				 !oob)
-				ret = chip->ecc.read_subpage(mtd, chip,
-							col, bytes, bufpoi,
-							page);
+				ret = chip->ecc.read_subpage(chip, col, bytes,
+							     bufpoi, page);
 			else
-				ret = chip->ecc.read_page(mtd, chip, bufpoi,
+				ret = chip->ecc.read_page(chip, bufpoi,
 							  oob_required, page);
 			if (ret < 0) {
 				if (use_bufpoi)
@@ -3723,12 +3719,13 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 
 /**
  * nand_read_oob_std - [REPLACEABLE] the most common OOB data read function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @page: page number to read
  */
-int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
+int nand_read_oob_std(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 EXPORT_SYMBOL(nand_read_oob_std);
@@ -3736,13 +3733,12 @@ EXPORT_SYMBOL(nand_read_oob_std);
 /**
  * nand_read_oob_syndrome - [REPLACEABLE] OOB data read function for HW ECC
  *			    with syndromes
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @page: page number to read
  */
-int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-			   int page)
+int nand_read_oob_syndrome(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int length = mtd->oobsize;
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
 	int eccsize = chip->ecc.size;
@@ -3913,9 +3909,9 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 
 	while (1) {
 		if (ops->mode == MTD_OPS_RAW)
-			ret = chip->ecc.read_oob_raw(mtd, chip, page);
+			ret = chip->ecc.read_oob_raw(chip, page);
 		else
-			ret = chip->ecc.read_oob(mtd, chip, page);
+			ret = chip->ecc.read_oob(chip, page);
 
 		if (ret < 0)
 			break;
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index f5dc0a7a2456..d83a86ba9d09 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -290,10 +290,10 @@ static int micron_nand_on_die_ecc_status_8(struct nand_chip *chip, u8 status)
 }
 
 static int
-micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
-				 uint8_t *buf, int oob_required,
-				 int page)
+micron_nand_read_page_on_die_ecc(struct nand_chip *chip, uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 status;
 	int ret, max_bitflips = 0;
 
diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index 8aec3fa6c5d9..952fe9e62ab4 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -48,13 +48,13 @@ static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
 }
 
 static int
-toshiba_nand_read_page_benand(struct mtd_info *mtd,
-			      struct nand_chip *chip, uint8_t *buf,
+toshiba_nand_read_page_benand(struct nand_chip *chip, uint8_t *buf,
 			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
-	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
+	ret = nand_read_page_raw(chip, buf, oob_required, page);
 	if (ret)
 		return ret;
 
@@ -62,10 +62,10 @@ toshiba_nand_read_page_benand(struct mtd_info *mtd,
 }
 
 static int
-toshiba_nand_read_subpage_benand(struct mtd_info *mtd,
-				 struct nand_chip *chip, uint32_t data_offs,
+toshiba_nand_read_subpage_benand(struct nand_chip *chip, uint32_t data_offs,
 				 uint32_t readlen, uint8_t *bufpoi, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	ret = nand_read_page_op(chip, page, data_offs,
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 4e0bc2da63fd..dfe96098f3f6 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1616,7 +1616,6 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
 
 /**
  * omap_read_page_bch - BCH ecc based page read function for entire page
- * @mtd:		mtd info structure
  * @chip:		nand chip info structure
  * @buf:		buffer to store read data
  * @oob_required:	caller requires OOB data read to chip->oob_poi
@@ -1629,9 +1628,10 @@ static int omap_write_subpage_bch(struct mtd_info *mtd,
  * ecc engine enabled. ecc vector updated after read of OOB data.
  * For non error pages ecc vector reported as zero.
  */
-static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int omap_read_page_bch(struct nand_chip *chip, uint8_t *buf,
+			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	uint8_t *ecc_code = chip->ecc.code_buf;
 	int stat, ret;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 312cfd786b0f..49113d4cee10 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1948,8 +1948,8 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 }
 
 /* implements ecc->read_page() */
-static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
+				int oob_required, int page)
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
@@ -1965,10 +1965,10 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /* implements ecc->read_page_raw() */
-static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
-				    struct nand_chip *chip, uint8_t *buf,
+static int qcom_nandc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 				    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int cw, ret;
@@ -1988,8 +1988,7 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 }
 
 /* implements ecc->read_oob() */
-static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			       int page)
+static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 7673aa140009..aa5516b3b45f 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -521,9 +521,10 @@ static int r852_ecc_correct(struct nand_chip *chip, uint8_t *dat,
  * This is copy of nand_read_oob_std
  * nand_read_oob_syndrome assumes we can send column address - we can't
  */
-static int r852_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			     int page)
+static int r852_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
 }
 
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 2580fd981077..fb5df6099d7b 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -611,9 +611,11 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 	writel(flcmcdr_val, FLCMCDR(flctl));
 }
 
-static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int flctl_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index e31ab86bebee..26d5c6c41c49 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1189,10 +1189,10 @@ static void sunxi_nfc_hw_ecc_write_extra_oob(struct mtd_info *mtd,
 		*cur_off = mtd->oobsize + mtd->writesize;
 }
 
-static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
-				      struct nand_chip *chip, uint8_t *buf,
+static int sunxi_nfc_hw_ecc_read_page(struct nand_chip *chip, uint8_t *buf,
 				      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	int ret, i, cur_off = 0;
@@ -1227,10 +1227,10 @@ static int sunxi_nfc_hw_ecc_read_page(struct mtd_info *mtd,
 	return max_bitflips;
 }
 
-static int sunxi_nfc_hw_ecc_read_page_dma(struct mtd_info *mtd,
-					  struct nand_chip *chip, u8 *buf,
+static int sunxi_nfc_hw_ecc_read_page_dma(struct nand_chip *chip, u8 *buf,
 					  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
@@ -1241,14 +1241,14 @@ static int sunxi_nfc_hw_ecc_read_page_dma(struct mtd_info *mtd,
 		return ret;
 
 	/* Fallback to PIO mode */
-	return sunxi_nfc_hw_ecc_read_page(mtd, chip, buf, oob_required, page);
+	return sunxi_nfc_hw_ecc_read_page(chip, buf, oob_required, page);
 }
 
-static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
-					 struct nand_chip *chip,
+static int sunxi_nfc_hw_ecc_read_subpage(struct nand_chip *chip,
 					 u32 data_offs, u32 readlen,
 					 u8 *bufpoi, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 	unsigned int max_bitflips = 0;
@@ -1278,11 +1278,11 @@ static int sunxi_nfc_hw_ecc_read_subpage(struct mtd_info *mtd,
 	return max_bitflips;
 }
 
-static int sunxi_nfc_hw_ecc_read_subpage_dma(struct mtd_info *mtd,
-					     struct nand_chip *chip,
+static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *chip,
 					     u32 data_offs, u32 readlen,
 					     u8 *buf, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int nchunks = DIV_ROUND_UP(data_offs + readlen, chip->ecc.size);
 	int ret;
 
@@ -1293,7 +1293,7 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct mtd_info *mtd,
 		return ret;
 
 	/* Fallback to PIO mode */
-	return sunxi_nfc_hw_ecc_read_subpage(mtd, chip, data_offs, readlen,
+	return sunxi_nfc_hw_ecc_read_subpage(chip, data_offs, readlen,
 					     buf, page);
 }
 
@@ -1428,13 +1428,11 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 	return sunxi_nfc_hw_ecc_write_page(mtd, chip, buf, oob_required, page);
 }
 
-static int sunxi_nfc_hw_ecc_read_oob(struct mtd_info *mtd,
-				     struct nand_chip *chip,
-				     int page)
+static int sunxi_nfc_hw_ecc_read_oob(struct nand_chip *chip, int page)
 {
 	chip->pagebuf = -1;
 
-	return chip->ecc.read_page(mtd, chip, chip->data_buf, 1, page);
+	return chip->ecc.read_page(chip, chip->data_buf, 1, page);
 }
 
 static int sunxi_nfc_hw_ecc_write_oob(struct mtd_info *mtd,
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 1061eb60ee60..c53d47159195 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -277,14 +277,15 @@ static int do_dma(struct tango_nfc *nfc, enum dma_data_direction dir, int cmd,
 	return err;
 }
 
-static int tango_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-			   u8 *buf, int oob_required, int page)
+static int tango_read_page(struct nand_chip *chip, u8 *buf,
+			   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct tango_nfc *nfc = to_tango_nfc(chip->controller);
 	int err, res, len = mtd->writesize;
 
 	if (oob_required)
-		chip->ecc.read_oob(mtd, chip, page);
+		chip->ecc.read_oob(chip, page);
 
 	err = do_dma(nfc, DMA_FROM_DEVICE, NFC_READ, buf, len, page);
 	if (err)
@@ -292,7 +293,7 @@ static int tango_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	res = decode_error_report(chip);
 	if (res < 0) {
-		chip->ecc.read_oob_raw(mtd, chip, page);
+		chip->ecc.read_oob_raw(chip, page);
 		res = check_erased_page(chip, buf);
 	}
 
@@ -424,8 +425,8 @@ static void raw_write(struct nand_chip *chip, const u8 *buf, const u8 *oob)
 	aux_write(chip, &oob, ecc_size, &pos);
 }
 
-static int tango_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-			       u8 *buf, int oob_required, int page)
+static int tango_read_page_raw(struct nand_chip *chip, u8 *buf,
+			       int oob_required, int page)
 {
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	raw_read(chip, buf, chip->oob_poi);
@@ -440,8 +441,7 @@ static int tango_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int tango_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			  int page)
+static int tango_read_oob(struct nand_chip *chip, int page)
 {
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	raw_read(chip, NULL, chip->oob_poi);
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 5dcee20e2a8c..bcc3a2888c4f 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info *mtd, struct nand_chip *chip,
 	return ret;
 }
 
-static int tegra_nand_read_page_raw(struct mtd_info *mtd,
-				    struct nand_chip *chip, u8 *buf,
+static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
 				    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	void *oob_buf = oob_required ? chip->oob_poi : NULL;
 
 	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,
@@ -635,9 +635,10 @@ static int tegra_nand_write_page_raw(struct mtd_info *mtd,
 				     mtd->oobsize, page, false);
 }
 
-static int tegra_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			       int page)
+static int tegra_nand_read_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return tegra_nand_page_xfer(mtd, chip, NULL, chip->oob_poi,
 				    mtd->oobsize, page, true);
 }
@@ -649,10 +650,10 @@ static int tegra_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				    mtd->oobsize, page, false);
 }
 
-static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
-				      struct nand_chip *chip, u8 *buf,
+static int tegra_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
 				      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 	struct tegra_nand_chip *nand = to_tegra_chip(chip);
 	void *oob_buf = oob_required ? chip->oob_poi : NULL;
@@ -716,7 +717,7 @@ static int tegra_nand_read_page_hwecc(struct mtd_info *mtd,
 		 * erased or if error correction just failed for all sub-
 		 * pages.
 		 */
-		ret = tegra_nand_read_oob(mtd, chip, page);
+		ret = tegra_nand_read_oob(chip, page);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index a73213c835a5..7cbcc41cea95 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -557,9 +557,10 @@ static void vf610_nfc_fill_row(struct nand_chip *chip, int page, u32 *code,
 	}
 }
 
-static int vf610_nfc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
-				uint8_t *buf, int oob_required, int page)
+static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 	int trfr_sz = mtd->writesize + mtd->oobsize;
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
@@ -643,15 +644,15 @@ static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return 0;
 }
 
-static int vf610_nfc_read_page_raw(struct mtd_info *mtd,
-				   struct nand_chip *chip, u8 *buf,
+static int vf610_nfc_read_page_raw(struct nand_chip *chip, u8 *buf,
 				   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 	int ret;
 
 	nfc->data_access = true;
-	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
+	ret = nand_read_page_raw(chip, buf, oob_required, page);
 	nfc->data_access = false;
 
 	return ret;
@@ -677,14 +678,13 @@ static int vf610_nfc_write_page_raw(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 }
 
-static int vf610_nfc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			      int page)
+static int vf610_nfc_read_oob(struct nand_chip *chip, int page)
 {
-	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	struct vf610_nfc *nfc = mtd_to_nfc(nand_to_mtd(chip));
 	int ret;
 
 	nfc->data_access = true;
-	ret = nand_read_oob_std(mtd, chip, page);
+	ret = nand_read_oob_std(chip, page);
 	nfc->data_access = false;
 
 	return ret;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index b50788b2d1d9..0776d38d4498 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -643,14 +643,15 @@ static int spinand_write_page_hwecc(struct mtd_info *mtd,
 	return nand_prog_page_op(chip, page, 0, p, eccsize * eccsteps);
 }
 
-static int spinand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				   u8 *buf, int oob_required, int page)
+static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
+				   int oob_required, int page)
 {
 	int retval;
 	u8 status;
 	u8 *p = buf;
 	int eccsize = chip->ecc.size;
 	int eccsteps = chip->ecc.steps;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct spinand_info *info = nand_get_controller_data(chip);
 
 	enable_read_hw_ecc = 1;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 24434310d126..a5f4a585f749 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -652,14 +652,14 @@ struct nand_ecc_ctrl {
 			 uint8_t *ecc_code);
 	int (*correct)(struct nand_chip *chip, uint8_t *dat, uint8_t *read_ecc,
 		       uint8_t *calc_ecc);
-	int (*read_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint8_t *buf, int oob_required, int page);
+	int (*read_page_raw)(struct nand_chip *chip, uint8_t *buf,
+			     int oob_required, int page);
 	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			const uint8_t *buf, int oob_required, int page);
-	int (*read_page)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint8_t *buf, int oob_required, int page);
-	int (*read_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t offs, uint32_t len, uint8_t *buf, int page);
+	int (*read_page)(struct nand_chip *chip, uint8_t *buf,
+			 int oob_required, int page);
+	int (*read_subpage)(struct nand_chip *chip, uint32_t offs,
+			    uint32_t len, uint8_t *buf, int page);
 	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
 			uint32_t offset, uint32_t data_len,
 			const uint8_t *data_buf, int oob_required, int page);
@@ -667,9 +667,8 @@ struct nand_ecc_ctrl {
 			const uint8_t *buf, int oob_required, int page);
 	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
 			int page);
-	int (*read_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-			int page);
-	int (*read_oob)(struct mtd_info *mtd, struct nand_chip *chip, int page);
+	int (*read_oob_raw)(struct nand_chip *chip, int page);
+	int (*read_oob)(struct nand_chip *chip, int page);
 	int (*write_oob)(struct mtd_info *mtd, struct nand_chip *chip,
 			int page);
 };
@@ -1676,11 +1675,10 @@ int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
 			    int page);
 
 /* Default read_oob implementation */
-int nand_read_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
+int nand_read_oob_std(struct nand_chip *chip, int page);
 
 /* Default read_oob syndrome implementation */
-int nand_read_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-			   int page);
+int nand_read_oob_syndrome(struct nand_chip *chip, int page);
 
 /* Wrapper to use in order for controllers/vendors to GET/SET FEATURES */
 int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
@@ -1690,10 +1688,10 @@ int nand_get_set_features_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
 				  int addr, u8 *subfeature_param);
 
 /* Default read_page_raw implementation */
-int nand_read_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-		       uint8_t *buf, int oob_required, int page);
-int nand_read_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-			       u8 *buf, int oob_required, int page);
+int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
+		       int page);
+int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
+			       int oob_required, int page);
 
 /* Default write_page_raw implementation */
 int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-- 
2.14.1
