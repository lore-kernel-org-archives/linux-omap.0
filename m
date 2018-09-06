From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 09/23] mtd: rawnand: Pass a nand_chip object to
 ecc->write_xxx() hooks
Date: Thu,  6 Sep 2018 14:05:21 +0200
Message-ID: <20180906120535.21255-10-boris.brezillon@bootlin.com>
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

Let's tackle all ecc->write_xxx() hooks at once.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c  | 12 ++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c      | 21 ++++----
 drivers/mtd/nand/raw/cafe_nand.c              | 13 ++---
 drivers/mtd/nand/raw/denali.c                 | 14 ++---
 drivers/mtd/nand/raw/docg4.c                  | 17 +++---
 drivers/mtd/nand/raw/fsl_elbc_nand.c          | 14 +++--
 drivers/mtd/nand/raw/fsl_ifc_nand.c           |  6 ++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    | 21 ++++----
 drivers/mtd/nand/raw/hisi504_nand.c           |  8 +--
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |  7 ++-
 drivers/mtd/nand/raw/lpc32xx_slc.c            | 14 ++---
 drivers/mtd/nand/raw/marvell_nand.c           | 32 ++++++------
 drivers/mtd/nand/raw/mtk_nand.c               | 19 ++++---
 drivers/mtd/nand/raw/mxc_nand.c               | 13 +++--
 drivers/mtd/nand/raw/nand_base.c              | 74 ++++++++++++---------------
 drivers/mtd/nand/raw/nand_ecc.c               |  2 +-
 drivers/mtd/nand/raw/nand_micron.c            |  7 ++-
 drivers/mtd/nand/raw/omap2.c                  | 11 ++--
 drivers/mtd/nand/raw/qcom_nandc.c             | 15 +++---
 drivers/mtd/nand/raw/sh_flctl.c               |  7 +--
 drivers/mtd/nand/raw/sunxi_nand.c             | 21 ++++----
 drivers/mtd/nand/raw/tango_nand.c             | 12 ++---
 drivers/mtd/nand/raw/tegra_nand.c             | 13 ++---
 drivers/mtd/nand/raw/vf610_nfc.c              | 13 ++---
 drivers/staging/mt29f_spinand/mt29f_spinand.c |  3 +-
 include/linux/mtd/rawnand.h                   | 33 ++++++------
 26 files changed, 208 insertions(+), 214 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 45061b591346..3ebe9b727315 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -858,15 +858,13 @@ static int atmel_nand_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
 	return nand_prog_page_end_op(chip);
 }
 
-static int atmel_nand_pmecc_write_page(struct mtd_info *mtd,
-				       struct nand_chip *chip, const u8 *buf,
+static int atmel_nand_pmecc_write_page(struct nand_chip *chip, const u8 *buf,
 				       int oob_required, int page)
 {
 	return atmel_nand_pmecc_write_pg(chip, buf, oob_required, page, false);
 }
 
-static int atmel_nand_pmecc_write_page_raw(struct mtd_info *mtd,
-					   struct nand_chip *chip,
+static int atmel_nand_pmecc_write_page_raw(struct nand_chip *chip,
 					   const u8 *buf, int oob_required,
 					   int page)
 {
@@ -963,8 +961,7 @@ static int atmel_hsmc_nand_pmecc_write_pg(struct nand_chip *chip,
 	return ret;
 }
 
-static int atmel_hsmc_nand_pmecc_write_page(struct mtd_info *mtd,
-					    struct nand_chip *chip,
+static int atmel_hsmc_nand_pmecc_write_page(struct nand_chip *chip,
 					    const u8 *buf, int oob_required,
 					    int page)
 {
@@ -972,8 +969,7 @@ static int atmel_hsmc_nand_pmecc_write_page(struct mtd_info *mtd,
 					      false);
 }
 
-static int atmel_hsmc_nand_pmecc_write_page_raw(struct mtd_info *mtd,
-						struct nand_chip *chip,
+static int atmel_hsmc_nand_pmecc_write_page_raw(struct nand_chip *chip,
 						const u8 *buf,
 						int oob_required, int page)
 {
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index a17ae692aee9..d8fb2b5c19c9 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1909,9 +1909,10 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	return ret;
 }
 
-static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required, int page)
+static int brcmnand_write_page(struct nand_chip *chip, const uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
@@ -1921,10 +1922,10 @@ static int brcmnand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int brcmnand_write_page_raw(struct mtd_info *mtd,
-				   struct nand_chip *chip, const uint8_t *buf,
+static int brcmnand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 				   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	void *oob = oob_required ? chip->oob_poi : NULL;
 
@@ -1936,16 +1937,16 @@ static int brcmnand_write_page_raw(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 }
 
-static int brcmnand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-				  int page)
+static int brcmnand_write_oob(struct nand_chip *chip, int page)
 {
-	return brcmnand_write(mtd, chip, (u64)page << chip->page_shift,
-				  NULL, chip->oob_poi);
+	return brcmnand_write(nand_to_mtd(chip), chip,
+			      (u64)page << chip->page_shift, NULL,
+			      chip->oob_poi);
 }
 
-static int brcmnand_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				  int page)
+static int brcmnand_write_oob_raw(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	int ret;
 
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index c6071d71cc1b..fe7c7db3cfe7 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -346,9 +346,10 @@ static irqreturn_t cafe_nand_interrupt(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-static int cafe_nand_write_oob(struct mtd_info *mtd,
-			       struct nand_chip *chip, int page)
+static int cafe_nand_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
 				 mtd->oobsize);
 }
@@ -533,11 +534,11 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_512 = {
 };
 
 
-static int cafe_nand_write_page_lowlevel(struct mtd_info *mtd,
-					  struct nand_chip *chip,
-					  const uint8_t *buf, int oob_required,
-					  int page)
+static int cafe_nand_write_page_lowlevel(struct nand_chip *chip,
+					 const uint8_t *buf, int oob_required,
+					 int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 994921814d76..52fe5115ed6e 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -761,9 +761,9 @@ static int denali_read_oob(struct nand_chip *chip, int page)
 	return 0;
 }
 
-static int denali_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page)
+static int denali_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 
 	denali_reset_irq(denali);
@@ -806,9 +806,10 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	return stat;
 }
 
-static int denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				 const uint8_t *buf, int oob_required, int page)
+static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int writesize = mtd->writesize;
 	int oobsize = mtd->oobsize;
@@ -884,9 +885,10 @@ static int denali_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	return denali_data_xfer(denali, tmp_buf, size, page, 1, 1);
 }
 
-static int denali_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			     const uint8_t *buf, int oob_required, int page)
+static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
+			     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
 
 	return denali_data_xfer(denali, (void *)buf, mtd->writesize,
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index ebaa479ffcb2..37935fd04020 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1007,20 +1007,19 @@ static int write_page(struct mtd_info *mtd, struct nand_chip *nand,
 	return nand_prog_page_end_op(nand);
 }
 
-static int docg4_write_page_raw(struct mtd_info *mtd, struct nand_chip *nand,
-				const uint8_t *buf, int oob_required, int page)
+static int docg4_write_page_raw(struct nand_chip *nand, const uint8_t *buf,
+				int oob_required, int page)
 {
-	return write_page(mtd, nand, buf, page, false);
+	return write_page(nand_to_mtd(nand), nand, buf, page, false);
 }
 
-static int docg4_write_page(struct mtd_info *mtd, struct nand_chip *nand,
-			     const uint8_t *buf, int oob_required, int page)
+static int docg4_write_page(struct nand_chip *nand, const uint8_t *buf,
+			    int oob_required, int page)
 {
-	return write_page(mtd, nand, buf, page, true);
+	return write_page(nand_to_mtd(nand), nand, buf, page, true);
 }
 
-static int docg4_write_oob(struct mtd_info *mtd, struct nand_chip *nand,
-			   int page)
+static int docg4_write_oob(struct nand_chip *nand, int page)
 {
 	/*
 	 * Writing oob-only is not really supported, because MLC nand must write
@@ -1144,7 +1143,7 @@ static int docg4_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 	/* write first page of block */
 	write_page_prologue(mtd, g4_addr);
-	docg4_write_page(mtd, nand, buf, 1, page);
+	docg4_write_page(nand, buf, 1, page);
 	ret = pageprog(mtd);
 
 	kfree(buf);
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 26fcb8ea0c2e..c992d7ad39d9 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -731,9 +731,11 @@ static int fsl_elbc_read_page(struct nand_chip *chip, uint8_t *buf,
 /* ECC will be calculated automatically, and errors will be detected in
  * waitfunc.
  */
-static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required, int page)
+static int fsl_elbc_write_page(struct nand_chip *chip, const uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
@@ -743,10 +745,12 @@ static int fsl_elbc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 /* ECC will be calculated automatically, and errors will be detected in
  * waitfunc.
  */
-static int fsl_elbc_write_subpage(struct mtd_info *mtd, struct nand_chip *chip,
-				uint32_t offset, uint32_t data_len,
-				const uint8_t *buf, int oob_required, int page)
+static int fsl_elbc_write_subpage(struct nand_chip *chip, uint32_t offset,
+				  uint32_t data_len, const uint8_t *buf,
+				  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	fsl_elbc_write_buf(mtd, buf, mtd->writesize);
 	fsl_elbc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 8c6016932aaa..945f3dab7ebf 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -707,9 +707,11 @@ static int fsl_ifc_read_page(struct nand_chip *chip, uint8_t *buf,
 /* ECC will be calculated automatically, and errors will be detected in
  * waitfunc.
  */
-static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required, int page)
+static int fsl_ifc_write_page(struct nand_chip *chip, const uint8_t *buf,
+			      int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	fsl_ifc_write_buf(mtd, chip->oob_poi, mtd->oobsize);
 
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 5650ebf28903..09f33f6006a3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1182,9 +1182,10 @@ static int gpmi_ecc_read_subpage(struct nand_chip *chip, uint32_t offs,
 	return max_bitflips;
 }
 
-static int gpmi_ecc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required, int page)
+static int gpmi_ecc_write_page(struct nand_chip *chip, const uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	const void *payload_virt;
@@ -1351,9 +1352,9 @@ static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 	return 0;
 }
 
-static int
-gpmi_ecc_write_oob(struct mtd_info *mtd, struct nand_chip *chip, int page)
+static int gpmi_ecc_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtd_oob_region of = { };
 
 	/* Do we have available oob area? */
@@ -1464,11 +1465,10 @@ static int gpmi_ecc_read_page_raw(struct nand_chip *chip, uint8_t *buf,
  * See set_geometry_by_ecc_info inline comments to have a full description
  * of the layout used by the GPMI controller.
  */
-static int gpmi_ecc_write_page_raw(struct mtd_info *mtd,
-				   struct nand_chip *chip,
-				   const uint8_t *buf,
+static int gpmi_ecc_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 				   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	struct bch_geometry *nfc_geo = &this->bch_geometry;
 	int eccsize = nfc_geo->ecc_chunk_size;
@@ -1541,10 +1541,9 @@ static int gpmi_ecc_read_oob_raw(struct nand_chip *chip, int page)
 	return gpmi_ecc_read_page_raw(chip, NULL, 1, page);
 }
 
-static int gpmi_ecc_write_oob_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				 int page)
+static int gpmi_ecc_write_oob_raw(struct nand_chip *chip, int page)
 {
-	return gpmi_ecc_write_page_raw(mtd, chip, NULL, 1, page);
+	return gpmi_ecc_write_page_raw(chip, NULL, 1, page);
 }
 
 static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
@@ -1715,7 +1714,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 		/* Write the first page of the current stride. */
 		dev_dbg(dev, "Writing an NCB fingerprint in page 0x%x\n", page);
 
-		status = chip->ecc.write_page_raw(mtd, chip, buffer, 0, page);
+		status = chip->ecc.write_page_raw(chip, buffer, 0, page);
 		if (status)
 			dev_err(dev, "[%s] Write failed.\n", __func__);
 	}
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index f4078086c14c..fab3c7fcf77b 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -577,10 +577,12 @@ static int hisi_nand_read_oob(struct nand_chip *chip, int page)
 	return 0;
 }
 
-static int hisi_nand_write_page_hwecc(struct mtd_info *mtd,
-		struct nand_chip *chip, const uint8_t *buf, int oob_required,
-		int page)
+static int hisi_nand_write_page_hwecc(struct nand_chip *chip,
+				      const uint8_t *buf, int oob_required,
+				      int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
 		chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 1849e9858d45..79a02acb0517 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -508,11 +508,11 @@ static int lpc32xx_read_page(struct nand_chip *chip, uint8_t *buf,
 	return 0;
 }
 
-static int lpc32xx_write_page_lowlevel(struct mtd_info *mtd,
-				       struct nand_chip *chip,
+static int lpc32xx_write_page_lowlevel(struct nand_chip *chip,
 				       const uint8_t *buf, int oob_required,
 				       int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	const uint8_t *oobbuf = chip->oob_poi;
 	uint8_t *dma_buf = (uint8_t *)buf;
@@ -568,8 +568,7 @@ static int lpc32xx_read_oob(struct nand_chip *chip, int page)
 	return 0;
 }
 
-static int lpc32xx_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			      int page)
+static int lpc32xx_write_oob(struct nand_chip *chip, int page)
 {
 	/* None, write_oob conflicts with the automatic LPC MLC ECC decoder! */
 	return 0;
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index a9cb089923be..6e4017ddacad 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -406,9 +406,10 @@ static int lpc32xx_nand_read_oob_syndrome(struct nand_chip *chip, int page)
 /*
  * Write the OOB data to the device without ECC using FIFO method
  */
-static int lpc32xx_nand_write_oob_syndrome(struct mtd_info *mtd,
-	struct nand_chip *chip, int page)
+static int lpc32xx_nand_write_oob_syndrome(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
 				 mtd->oobsize);
 }
@@ -678,11 +679,11 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct nand_chip *chip,
  * Write the data and OOB data to the device, use ECC with the data,
  * disable ECC for the OOB data
  */
-static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
-					    struct nand_chip *chip,
+static int lpc32xx_nand_write_page_syndrome(struct nand_chip *chip,
 					    const uint8_t *buf,
 					    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
 	struct mtd_oob_region oobregion = { };
 	uint8_t *pb;
@@ -716,11 +717,12 @@ static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
  * Write the data and OOB data to the device, no ECC correction with the
  * data or OOB data
  */
-static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
-						struct nand_chip *chip,
+static int lpc32xx_nand_write_page_raw_syndrome(struct nand_chip *chip,
 						const uint8_t *buf,
 						int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	/* Raw writes can just use the FIFO interface */
 	nand_prog_page_begin_op(chip, page, 0, buf,
 				chip->ecc.size * chip->ecc.steps);
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index a81018f3a2f4..5f5709c2e58e 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -1136,8 +1136,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
 	return ret;
 }
 
-static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct mtd_info *mtd,
-						 struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct nand_chip *chip,
 						 const u8 *buf,
 						 int oob_required, int page)
 {
@@ -1145,8 +1144,7 @@ static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct mtd_info *mtd,
 						    true, page);
 }
 
-static int marvell_nfc_hw_ecc_hmg_write_page(struct mtd_info *mtd,
-					     struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_hmg_write_page(struct nand_chip *chip,
 					     const u8 *buf,
 					     int oob_required, int page)
 {
@@ -1165,10 +1163,11 @@ static int marvell_nfc_hw_ecc_hmg_write_page(struct mtd_info *mtd,
  * it appears before the ECC bytes when reading), the ->write_oob_raw() function
  * also stands for ->write_oob().
  */
-static int marvell_nfc_hw_ecc_hmg_write_oob_raw(struct mtd_info *mtd,
-						struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_hmg_write_oob_raw(struct nand_chip *chip,
 						int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
 
@@ -1405,8 +1404,7 @@ static int marvell_nfc_hw_ecc_bch_read_oob(struct nand_chip *chip, int page)
 }
 
 /* BCH write helpers */
-static int marvell_nfc_hw_ecc_bch_write_page_raw(struct mtd_info *mtd,
-						 struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_bch_write_page_raw(struct nand_chip *chip,
 						 const u8 *buf,
 						 int oob_required, int page)
 {
@@ -1519,11 +1517,11 @@ marvell_nfc_hw_ecc_bch_write_chunk(struct nand_chip *chip, int chunk,
 	return 0;
 }
 
-static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
-					     struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
 					     const u8 *buf,
 					     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct marvell_hw_ecc_layout *lt = to_marvell_nand(chip)->layout;
 	const u8 *data = buf;
 	const u8 *spare = chip->oob_poi;
@@ -1568,27 +1566,29 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct mtd_info *mtd,
 	return 0;
 }
 
-static int marvell_nfc_hw_ecc_bch_write_oob_raw(struct mtd_info *mtd,
-						struct nand_chip *chip,
+static int marvell_nfc_hw_ecc_bch_write_oob_raw(struct nand_chip *chip,
 						int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
 
 	memset(chip->data_buf, 0xFF, mtd->writesize);
 
-	return chip->ecc.write_page_raw(mtd, chip, chip->data_buf, true, page);
+	return chip->ecc.write_page_raw(chip, chip->data_buf, true, page);
 }
 
-static int marvell_nfc_hw_ecc_bch_write_oob(struct mtd_info *mtd,
-					    struct nand_chip *chip, int page)
+static int marvell_nfc_hw_ecc_bch_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	/* Invalidate page cache */
 	chip->pagebuf = -1;
 
 	memset(chip->data_buf, 0xFF, mtd->writesize);
 
-	return chip->ecc.write_page(mtd, chip, chip->data_buf, true, page);
+	return chip->ecc.write_page(chip, chip->data_buf, true, page);
 }
 
 /* NAND framework ->exec_op() hooks and related helpers */
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 32d5b59eb879..c338a9646433 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -807,27 +807,27 @@ static int mtk_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return nand_prog_page_end_op(chip);
 }
 
-static int mtk_nfc_write_page_hwecc(struct mtd_info *mtd,
-				    struct nand_chip *chip, const u8 *buf,
+static int mtk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 				    int oob_on, int page)
 {
-	return mtk_nfc_write_page(mtd, chip, buf, page, 0);
+	return mtk_nfc_write_page(nand_to_mtd(chip), chip, buf, page, 0);
 }
 
-static int mtk_nfc_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				  const u8 *buf, int oob_on, int pg)
+static int mtk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
+				  int oob_on, int pg)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 
 	mtk_nfc_format_page(mtd, buf);
 	return mtk_nfc_write_page(mtd, chip, nfc->buffer, pg, 1);
 }
 
-static int mtk_nfc_write_subpage_hwecc(struct mtd_info *mtd,
-				       struct nand_chip *chip, u32 offset,
+static int mtk_nfc_write_subpage_hwecc(struct nand_chip *chip, u32 offset,
 				       u32 data_len, const u8 *buf,
 				       int oob_on, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mtk_nfc *nfc = nand_get_controller_data(chip);
 	int ret;
 
@@ -839,10 +839,9 @@ static int mtk_nfc_write_subpage_hwecc(struct mtd_info *mtd,
 	return mtk_nfc_write_page(mtd, chip, nfc->buffer, page, 1);
 }
 
-static int mtk_nfc_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip,
-				 int page)
+static int mtk_nfc_write_oob_std(struct nand_chip *chip, int page)
 {
-	return mtk_nfc_write_page_raw(mtd, chip, NULL, 1, page);
+	return mtk_nfc_write_page_raw(chip, NULL, 1, page);
 }
 
 static int mtk_nfc_update_ecc_stats(struct mtd_info *mtd, u8 *buf, u32 sectors)
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 35fcec595c3e..597c74ea7e5e 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -873,22 +873,21 @@ static int mxc_nand_write_page(struct nand_chip *chip, const uint8_t *buf,
 	return 0;
 }
 
-static int mxc_nand_write_page_ecc(struct mtd_info *mtd, struct nand_chip *chip,
-				   const uint8_t *buf, int oob_required,
-				   int page)
+static int mxc_nand_write_page_ecc(struct nand_chip *chip, const uint8_t *buf,
+				   int oob_required, int page)
 {
 	return mxc_nand_write_page(chip, buf, true, page);
 }
 
-static int mxc_nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				   const uint8_t *buf, int oob_required, int page)
+static int mxc_nand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+				   int oob_required, int page)
 {
 	return mxc_nand_write_page(chip, buf, false, page);
 }
 
-static int mxc_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			      int page)
+static int mxc_nand_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 
 	memset(host->data_buf, 0xff, mtd->writesize);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e1f60c841348..cc386ee64a1b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3787,12 +3787,13 @@ EXPORT_SYMBOL(nand_read_oob_syndrome);
 
 /**
  * nand_write_oob_std - [REPLACEABLE] the most common OOB data write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @page: page number to write
  */
-int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page)
+int nand_write_oob_std(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return nand_prog_page_op(chip, page, mtd->writesize, chip->oob_poi,
 				 mtd->oobsize);
 }
@@ -3801,13 +3802,12 @@ EXPORT_SYMBOL(nand_write_oob_std);
 /**
  * nand_write_oob_syndrome - [REPLACEABLE] OOB data write function for HW ECC
  *			     with syndrome - only for large page flash
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @page: page number to write
  */
-int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page)
+int nand_write_oob_syndrome(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
 	int eccsize = chip->ecc.size, length = mtd->oobsize;
 	int ret, i, len, pos, sndcmd = 0, steps = chip->ecc.steps;
@@ -3984,7 +3984,6 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 
 /**
  * nand_write_page_raw_notsupp - dummy raw page write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
@@ -3992,8 +3991,8 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
  *
  * Returns -ENOTSUPP unconditionally.
  */
-int nand_write_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				const u8 *buf, int oob_required, int page)
+int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
+				int oob_required, int page)
 {
 	return -ENOTSUPP;
 }
@@ -4001,7 +4000,6 @@ EXPORT_SYMBOL(nand_write_page_raw_notsupp);
 
 /**
  * nand_write_page_raw - [INTERN] raw page write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
@@ -4009,9 +4007,10 @@ EXPORT_SYMBOL(nand_write_page_raw_notsupp);
  *
  * Not for syndrome calculating ECC controllers, which use a special oob layout.
  */
-int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required, int page)
+int nand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+			int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	ret = nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
@@ -4031,7 +4030,6 @@ EXPORT_SYMBOL(nand_write_page_raw);
 
 /**
  * nand_write_page_raw_syndrome - [INTERN] raw page write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
@@ -4039,11 +4037,11 @@ EXPORT_SYMBOL(nand_write_page_raw);
  *
  * We need a special oob layout and handling even when ECC isn't checked.
  */
-static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
-					struct nand_chip *chip,
+static int nand_write_page_raw_syndrome(struct nand_chip *chip,
 					const uint8_t *buf, int oob_required,
 					int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	uint8_t *oob = chip->oob_poi;
@@ -4096,16 +4094,15 @@ static int nand_write_page_raw_syndrome(struct mtd_info *mtd,
 }
 /**
  * nand_write_page_swecc - [REPLACEABLE] software ECC based page write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
  * @page: page number to write
  */
-static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
-				 const uint8_t *buf, int oob_required,
-				 int page)
+static int nand_write_page_swecc(struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -4121,21 +4118,20 @@ static int nand_write_page_swecc(struct mtd_info *mtd, struct nand_chip *chip,
 	if (ret)
 		return ret;
 
-	return chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
+	return chip->ecc.write_page_raw(chip, buf, 1, page);
 }
 
 /**
  * nand_write_page_hwecc - [REPLACEABLE] hardware ECC based page write function
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
  * @page: page number to write
  */
-static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required,
-				  int page)
+static int nand_write_page_hwecc(struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size, ret;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -4171,7 +4167,6 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * nand_write_subpage_hwecc - [REPLACEABLE] hardware ECC based subpage write
- * @mtd:	mtd info structure
  * @chip:	nand chip info structure
  * @offset:	column address of subpage within the page
  * @data_len:	data length
@@ -4179,11 +4174,11 @@ static int nand_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
  * @oob_required: must write chip->oob_poi to OOB
  * @page: page number to write
  */
-static int nand_write_subpage_hwecc(struct mtd_info *mtd,
-				struct nand_chip *chip, uint32_t offset,
-				uint32_t data_len, const uint8_t *buf,
-				int oob_required, int page)
+static int nand_write_subpage_hwecc(struct nand_chip *chip, uint32_t offset,
+				    uint32_t data_len, const uint8_t *buf,
+				    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	uint8_t *oob_buf  = chip->oob_poi;
 	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	int ecc_size      = chip->ecc.size;
@@ -4242,7 +4237,6 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
 
 /**
  * nand_write_page_syndrome - [REPLACEABLE] hardware ECC syndrome based page write
- * @mtd: mtd info structure
  * @chip: nand chip info structure
  * @buf: data buffer
  * @oob_required: must write chip->oob_poi to OOB
@@ -4251,11 +4245,10 @@ static int nand_write_subpage_hwecc(struct mtd_info *mtd,
  * The hw generator calculates the error syndrome automatically. Therefore we
  * need a special oob layout and handling.
  */
-static int nand_write_page_syndrome(struct mtd_info *mtd,
-				    struct nand_chip *chip,
-				    const uint8_t *buf, int oob_required,
-				    int page)
+static int nand_write_page_syndrome(struct nand_chip *chip, const uint8_t *buf,
+				    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int i, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
@@ -4336,14 +4329,13 @@ static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 		subpage = 0;
 
 	if (unlikely(raw))
-		status = chip->ecc.write_page_raw(mtd, chip, buf,
-						  oob_required, page);
+		status = chip->ecc.write_page_raw(chip, buf, oob_required,
+						  page);
 	else if (subpage)
-		status = chip->ecc.write_subpage(mtd, chip, offset, data_len,
-						 buf, oob_required, page);
+		status = chip->ecc.write_subpage(chip, offset, data_len, buf,
+						 oob_required, page);
 	else
-		status = chip->ecc.write_page(mtd, chip, buf, oob_required,
-					      page);
+		status = chip->ecc.write_page(chip, buf, oob_required, page);
 
 	if (status < 0)
 		return status;
@@ -4610,9 +4602,9 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	nand_fill_oob(mtd, ops->oobbuf, ops->ooblen, ops);
 
 	if (ops->mode == MTD_OPS_RAW)
-		status = chip->ecc.write_oob_raw(mtd, chip, page & chip->pagemask);
+		status = chip->ecc.write_oob_raw(chip, page & chip->pagemask);
 	else
-		status = chip->ecc.write_oob(mtd, chip, page & chip->pagemask);
+		status = chip->ecc.write_oob(chip, page & chip->pagemask);
 
 	chip->select_chip(mtd, -1);
 
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 8f86eed40b70..93df8e73f577 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -394,7 +394,7 @@ EXPORT_SYMBOL(__nand_calculate_ecc);
 /**
  * nand_calculate_ecc - [NAND Interface] Calculate 3-byte ECC for 256/512-byte
  *			 block
- * @mtd:	MTD block structure
+ * @chip:	NAND chip object
  * @buf:	input buffer with raw data
  * @code:	output buffer with ECC
  */
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index d83a86ba9d09..2f26dbeb5428 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -332,9 +332,8 @@ micron_nand_read_page_on_die_ecc(struct nand_chip *chip, uint8_t *buf,
 }
 
 static int
-micron_nand_write_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required,
-				  int page)
+micron_nand_write_page_on_die_ecc(struct nand_chip *chip, const uint8_t *buf,
+				  int oob_required, int page)
 {
 	int ret;
 
@@ -342,7 +341,7 @@ micron_nand_write_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
 	if (ret)
 		return ret;
 
-	ret = nand_write_page_raw(mtd, chip, buf, oob_required, page);
+	ret = nand_write_page_raw(chip, buf, oob_required, page);
 	micron_nand_on_die_ecc_setup(chip, false);
 
 	return ret;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index dfe96098f3f6..f1f8b6c1d654 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1511,7 +1511,6 @@ static int omap_elm_correct_data(struct nand_chip *chip, u_char *data,
 
 /**
  * omap_write_page_bch - BCH ecc based write page function for entire page
- * @mtd:		mtd info structure
  * @chip:		nand chip info structure
  * @buf:		data buffer
  * @oob_required:	must write chip->oob_poi to OOB
@@ -1519,9 +1518,10 @@ static int omap_elm_correct_data(struct nand_chip *chip, u_char *data,
  *
  * Custom write page method evolved to support multi sector writing in one shot
  */
-static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
-			       const uint8_t *buf, int oob_required, int page)
+static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
+			       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 	uint8_t *ecc_calc = chip->ecc.calc_buf;
 
@@ -1549,7 +1549,6 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
 
 /**
  * omap_write_subpage_bch - BCH hardware ECC based subpage write
- * @mtd:	mtd info structure
  * @chip:	nand chip info structure
  * @offset:	column address of subpage within the page
  * @data_len:	data length
@@ -1559,11 +1558,11 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
  *
  * OMAP optimized subpage write method.
  */
-static int omap_write_subpage_bch(struct mtd_info *mtd,
-				  struct nand_chip *chip, u32 offset,
+static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 				  u32 data_len, const u8 *buf,
 				  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	u8 *ecc_calc = chip->ecc.calc_buf;
 	int ecc_size      = chip->ecc.size;
 	int ecc_bytes     = chip->ecc.bytes;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 49113d4cee10..e0cec027572c 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2005,8 +2005,8 @@ static int qcom_nandc_read_oob(struct nand_chip *chip, int page)
 }
 
 /* implements ecc->write_page() */
-static int qcom_nandc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				 const uint8_t *buf, int oob_required, int page)
+static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
+				 int oob_required, int page)
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
@@ -2075,10 +2075,11 @@ static int qcom_nandc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 }
 
 /* implements ecc->write_page_raw() */
-static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
-				     struct nand_chip *chip, const uint8_t *buf,
-				     int oob_required, int page)
+static int qcom_nandc_write_page_raw(struct nand_chip *chip,
+				     const uint8_t *buf, int oob_required,
+				     int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -2153,9 +2154,9 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
  * since ECC is calculated for the combined codeword. So update the OOB from
  * chip->oob_poi, and pad the data area with OxFF before writing.
  */
-static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-				int page)
+static int qcom_nandc_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index fb5df6099d7b..bb58edd2bdf0 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -622,10 +622,11 @@ static int flctl_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 	return 0;
 }
 
-static int flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
-				  const uint8_t *buf, int oob_required,
-				  int page)
+static int flctl_write_page_hwecc(struct nand_chip *chip, const uint8_t *buf,
+				  int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return nand_prog_page_end_op(chip);
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 26d5c6c41c49..86d666c0c03c 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1297,11 +1297,11 @@ static int sunxi_nfc_hw_ecc_read_subpage_dma(struct nand_chip *chip,
 					     buf, page);
 }
 
-static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
-				       struct nand_chip *chip,
+static int sunxi_nfc_hw_ecc_write_page(struct nand_chip *chip,
 				       const uint8_t *buf, int oob_required,
 				       int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
@@ -1331,12 +1331,12 @@ static int sunxi_nfc_hw_ecc_write_page(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 }
 
-static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
-					  struct nand_chip *chip,
+static int sunxi_nfc_hw_ecc_write_subpage(struct nand_chip *chip,
 					  u32 data_offs, u32 data_len,
 					  const u8 *buf, int oob_required,
 					  int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int ret, i, cur_off = 0;
 
@@ -1363,12 +1363,12 @@ static int sunxi_nfc_hw_ecc_write_subpage(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 }
 
-static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
-					   struct nand_chip *chip,
+static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *chip,
 					   const u8 *buf,
 					   int oob_required,
 					   int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
 	struct nand_ecc_ctrl *ecc = &nand->ecc;
@@ -1425,7 +1425,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 	return nand_prog_page_end_op(chip);
 
 pio_fallback:
-	return sunxi_nfc_hw_ecc_write_page(mtd, chip, buf, oob_required, page);
+	return sunxi_nfc_hw_ecc_write_page(chip, buf, oob_required, page);
 }
 
 static int sunxi_nfc_hw_ecc_read_oob(struct nand_chip *chip, int page)
@@ -1435,16 +1435,15 @@ static int sunxi_nfc_hw_ecc_read_oob(struct nand_chip *chip, int page)
 	return chip->ecc.read_page(chip, chip->data_buf, 1, page);
 }
 
-static int sunxi_nfc_hw_ecc_write_oob(struct mtd_info *mtd,
-				      struct nand_chip *chip,
-				      int page)
+static int sunxi_nfc_hw_ecc_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	chip->pagebuf = -1;
 
 	memset(chip->data_buf, 0xff, mtd->writesize);
-	ret = chip->ecc.write_page(mtd, chip, chip->data_buf, 1, page);
+	ret = chip->ecc.write_page(chip, chip->data_buf, 1, page);
 	if (ret)
 		return ret;
 
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index c53d47159195..7c8f47546002 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -300,9 +300,10 @@ static int tango_read_page(struct nand_chip *chip, u8 *buf,
 	return res;
 }
 
-static int tango_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-			    const u8 *buf, int oob_required, int page)
+static int tango_write_page(struct nand_chip *chip, const u8 *buf,
+			    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct tango_nfc *nfc = to_tango_nfc(chip->controller);
 	int err, status, len = mtd->writesize;
 
@@ -433,8 +434,8 @@ static int tango_read_page_raw(struct nand_chip *chip, u8 *buf,
 	return 0;
 }
 
-static int tango_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-				const u8 *buf, int oob_required, int page)
+static int tango_write_page_raw(struct nand_chip *chip, const u8 *buf,
+				int oob_required, int page)
 {
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	raw_write(chip, buf, chip->oob_poi);
@@ -448,8 +449,7 @@ static int tango_read_oob(struct nand_chip *chip, int page)
 	return 0;
 }
 
-static int tango_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			   int page)
+static int tango_write_oob(struct nand_chip *chip, int page)
 {
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 	raw_write(chip, NULL, chip->oob_poi);
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index bcc3a2888c4f..df8e78814a08 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -625,10 +625,10 @@ static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
 				    mtd->oobsize, page, true);
 }
 
-static int tegra_nand_write_page_raw(struct mtd_info *mtd,
-				     struct nand_chip *chip, const u8 *buf,
+static int tegra_nand_write_page_raw(struct nand_chip *chip, const u8 *buf,
 				     int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	void *oob_buf = oob_required ? chip->oob_poi : NULL;
 
 	return tegra_nand_page_xfer(mtd, chip, (void *)buf, oob_buf,
@@ -643,9 +643,10 @@ static int tegra_nand_read_oob(struct nand_chip *chip, int page)
 				    mtd->oobsize, page, true);
 }
 
-static int tegra_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-				int page)
+static int tegra_nand_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	return tegra_nand_page_xfer(mtd, chip, NULL, chip->oob_poi,
 				    mtd->oobsize, page, false);
 }
@@ -760,10 +761,10 @@ static int tegra_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
 	}
 }
 
-static int tegra_nand_write_page_hwecc(struct mtd_info *mtd,
-				       struct nand_chip *chip, const u8 *buf,
+static int tegra_nand_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
 				       int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 	void *oob_buf = oob_required ? chip->oob_poi : NULL;
 	int ret;
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 7cbcc41cea95..bce6f6769cd6 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -603,9 +603,10 @@ static int vf610_nfc_read_page(struct nand_chip *chip, uint8_t *buf,
 	}
 }
 
-static int vf610_nfc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
-				const uint8_t *buf, int oob_required, int page)
+static int vf610_nfc_write_page(struct nand_chip *chip, const uint8_t *buf,
+				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 	int trfr_sz = mtd->writesize + mtd->oobsize;
 	u32 row = 0, cmd1 = 0, cmd2 = 0, code = 0;
@@ -658,10 +659,10 @@ static int vf610_nfc_read_page_raw(struct nand_chip *chip, u8 *buf,
 	return ret;
 }
 
-static int vf610_nfc_write_page_raw(struct mtd_info *mtd,
-				    struct nand_chip *chip, const u8 *buf,
+static int vf610_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
 				    int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 	int ret;
 
@@ -690,9 +691,9 @@ static int vf610_nfc_read_oob(struct nand_chip *chip, int page)
 	return ret;
 }
 
-static int vf610_nfc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
-			       int page)
+static int vf610_nfc_write_oob(struct nand_chip *chip, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 	int ret;
 
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 0776d38d4498..2b2f98efdb54 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -630,8 +630,7 @@ static int spinand_erase_block(struct spi_device *spi_nand, u16 block_id)
 }
 
 #ifdef CONFIG_MTD_SPINAND_ONDIEECC
-static int spinand_write_page_hwecc(struct mtd_info *mtd,
-				    struct nand_chip *chip,
+static int spinand_write_page_hwecc(struct nand_chip *chip,
 				    const u8 *buf, int oob_required,
 				    int page)
 {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a5f4a585f749..527947e81447 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -654,23 +654,21 @@ struct nand_ecc_ctrl {
 		       uint8_t *calc_ecc);
 	int (*read_page_raw)(struct nand_chip *chip, uint8_t *buf,
 			     int oob_required, int page);
-	int (*write_page_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required, int page);
+	int (*write_page_raw)(struct nand_chip *chip, const uint8_t *buf,
+			      int oob_required, int page);
 	int (*read_page)(struct nand_chip *chip, uint8_t *buf,
 			 int oob_required, int page);
 	int (*read_subpage)(struct nand_chip *chip, uint32_t offs,
 			    uint32_t len, uint8_t *buf, int page);
-	int (*write_subpage)(struct mtd_info *mtd, struct nand_chip *chip,
-			uint32_t offset, uint32_t data_len,
-			const uint8_t *data_buf, int oob_required, int page);
-	int (*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required, int page);
-	int (*write_oob_raw)(struct mtd_info *mtd, struct nand_chip *chip,
-			int page);
+	int (*write_subpage)(struct nand_chip *chip, uint32_t offset,
+			     uint32_t data_len, const uint8_t *data_buf,
+			     int oob_required, int page);
+	int (*write_page)(struct nand_chip *chip, const uint8_t *buf,
+			  int oob_required, int page);
+	int (*write_oob_raw)(struct nand_chip *chip, int page);
 	int (*read_oob_raw)(struct nand_chip *chip, int page);
 	int (*read_oob)(struct nand_chip *chip, int page);
-	int (*write_oob)(struct mtd_info *mtd, struct nand_chip *chip,
-			int page);
+	int (*write_oob)(struct nand_chip *chip, int page);
 };
 
 /**
@@ -1668,11 +1666,10 @@ int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail);
 
 /* Default write_oob implementation */
-int nand_write_oob_std(struct mtd_info *mtd, struct nand_chip *chip, int page);
+int nand_write_oob_std(struct nand_chip *chip, int page);
 
 /* Default write_oob syndrome implementation */
-int nand_write_oob_syndrome(struct mtd_info *mtd, struct nand_chip *chip,
-			    int page);
+int nand_write_oob_syndrome(struct nand_chip *chip, int page);
 
 /* Default read_oob implementation */
 int nand_read_oob_std(struct nand_chip *chip, int page);
@@ -1694,10 +1691,10 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
 			       int oob_required, int page);
 
 /* Default write_page_raw implementation */
-int nand_write_page_raw(struct mtd_info *mtd, struct nand_chip *chip,
-			const uint8_t *buf, int oob_required, int page);
-int nand_write_page_raw_notsupp(struct mtd_info *mtd, struct nand_chip *chip,
-				const u8 *buf, int oob_required, int page);
+int nand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
+			int oob_required, int page);
+int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
+				int oob_required, int page);
 
 /* Reset and initialize a NAND device */
 int nand_reset(struct nand_chip *chip, int chipnr);
-- 
2.14.1
