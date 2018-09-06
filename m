From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 12/23] mtd: rawnand: Pass a nand_chip object to
 chip->select_chip()
Date: Thu,  6 Sep 2018 14:05:24 +0200
Message-ID: <20180906120535.21255-13-boris.brezillon@bootlin.com>
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

Let's tackle the chip->select_chip() hook.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  9 ++-
 drivers/mtd/nand/raw/au1550nd.c                  |  4 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  4 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  3 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  4 +-
 drivers/mtd/nand/raw/denali.c                    |  6 +-
 drivers/mtd/nand/raw/diskonchip.c                | 11 ++-
 drivers/mtd/nand/raw/docg4.c                     |  3 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  2 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |  4 +-
 drivers/mtd/nand/raw/fsmc_nand.c                 |  4 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       | 20 +++---
 drivers/mtd/nand/raw/hisi504_nand.c              |  3 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  9 ++-
 drivers/mtd/nand/raw/jz4780_nand.c               |  4 +-
 drivers/mtd/nand/raw/marvell_nand.c              |  3 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               | 12 ++--
 drivers/mtd/nand/raw/mtk_nand.c                  |  5 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |  8 +--
 drivers/mtd/nand/raw/nand_base.c                 | 86 ++++++++++++------------
 drivers/mtd/nand/raw/ndfc.c                      |  3 +-
 drivers/mtd/nand/raw/plat_nand.c                 | 11 +--
 drivers/mtd/nand/raw/qcom_nandc.c                |  3 +-
 drivers/mtd/nand/raw/r852.c                      |  5 +-
 drivers/mtd/nand/raw/s3c2410.c                   |  5 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |  4 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |  4 +-
 drivers/mtd/nand/raw/tango_nand.c                |  3 +-
 drivers/mtd/nand/raw/tegra_nand.c                |  3 +-
 drivers/mtd/nand/raw/vf610_nfc.c                 |  8 +--
 drivers/mtd/nand/raw/xway_nand.c                 |  3 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  2 +-
 include/linux/mtd/rawnand.h                      |  2 +-
 34 files changed, 117 insertions(+), 145 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 84ddede5ede4..5c8ef476ed47 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -483,9 +483,8 @@ static int atmel_nand_dev_ready(struct mtd_info *mtd)
 	return gpiod_get_value(nand->activecs->rb.gpio);
 }
 
-static void atmel_nand_select_chip(struct mtd_info *mtd, int cs)
+static void atmel_nand_select_chip(struct nand_chip *chip, int cs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 
 	if (cs < 0 || cs >= nand->numcs) {
@@ -514,15 +513,15 @@ static int atmel_hsmc_nand_dev_ready(struct mtd_info *mtd)
 	return status & ATMEL_HSMC_NFC_SR_RBEDGE(nand->activecs->rb.id);
 }
 
-static void atmel_hsmc_nand_select_chip(struct mtd_info *mtd, int cs)
+static void atmel_hsmc_nand_select_chip(struct nand_chip *chip, int cs)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct atmel_nand *nand = to_atmel_nand(chip);
 	struct atmel_hsmc_nand_controller *nc;
 
 	nc = to_hsmc_nand_controller(chip->controller);
 
-	atmel_nand_select_chip(mtd, cs);
+	atmel_nand_select_chip(chip, cs);
 
 	if (!nand->activecs) {
 		regmap_write(nc->base.smc, ATMEL_HSMC_NFC_CTRL,
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index f1cc9f672262..1bae3b2779aa 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -227,10 +227,10 @@ int au1550_device_ready(struct mtd_info *mtd)
  *	chip needs it to be asserted during chip not ready time but the NAND
  *	controller keeps it released.
  *
- * @mtd:	MTD device structure
+ * @this:	NAND chip object
  * @chip:	chipnumber to select, -1 for deselect
  */
-static void au1550_select_chip(struct mtd_info *mtd, int chip)
+static void au1550_select_chip(struct nand_chip *this, int chip)
 {
 }
 
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 83eec2812aa0..c8e30b0308bc 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -191,8 +191,8 @@ static void bcm47xxnflash_ops_bcm4706_cmd_ctrl(struct mtd_info *mtd, int cmd,
 }
 
 /* Default nand_select_chip calls cmd_ctrl, which is not used in BCM4706 */
-static void bcm47xxnflash_ops_bcm4706_select_chip(struct mtd_info *mtd,
-						  int chip)
+static void bcm47xxnflash_ops_bcm4706_select_chip(struct nand_chip *chip,
+						  int cs)
 {
 	return;
 }
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index f801333161c9..e70a47aad538 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -314,9 +314,8 @@ static void cafe_nand_cmdfunc(struct mtd_info *mtd, unsigned command,
 	cafe_writel(cafe, cafe->ctl2, NAND_CTRL2);
 }
 
-static void cafe_select_chip(struct mtd_info *mtd, int chipnr)
+static void cafe_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	cafe_dev_dbg(&cafe->pdev->dev, "select_chip %d\n", chipnr);
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 02a2d3b05e34..85bc801424b0 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -118,9 +118,9 @@ static void nand_davinci_hwcontrol(struct mtd_info *mtd, int cmd,
 		iowrite8(cmd, nand->IO_ADDR_W);
 }
 
-static void nand_davinci_select_chip(struct mtd_info *mtd, int chip)
+static void nand_davinci_select_chip(struct nand_chip *nand, int chip)
 {
-	struct davinci_nand_info	*info = to_davinci_nand(mtd);
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(nand));
 
 	info->current_cs = info->vaddr;
 
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 101ffa11b606..e29ec95f24de 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -897,11 +897,11 @@ static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 				page, 0, 1);
 }
 
-static void denali_select_chip(struct mtd_info *mtd, int chip)
+static void denali_select_chip(struct nand_chip *chip, int cs)
 {
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
 
-	denali->active_bank = chip;
+	denali->active_bank = cs;
 }
 
 static int denali_waitfunc(struct mtd_info *mtd, struct nand_chip *chip)
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index a1bc2f7436db..4d7b00d066fe 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -85,7 +85,7 @@ static u_char empty_write_ecc[6] = { 0x4b, 0x00, 0xe2, 0x0e, 0x93, 0xf7 };
 
 static void doc200x_hwcontrol(struct mtd_info *mtd, int cmd,
 			      unsigned int bitmask);
-static void doc200x_select_chip(struct mtd_info *mtd, int chip);
+static void doc200x_select_chip(struct nand_chip *this, int chip);
 
 static int debug = 0;
 module_param(debug, int, 0);
@@ -371,7 +371,7 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 	struct doc_priv *doc = nand_get_controller_data(this);
 	uint16_t ret;
 
-	doc200x_select_chip(mtd, nr);
+	doc200x_select_chip(this, nr);
 	doc200x_hwcontrol(mtd, NAND_CMD_READID,
 			  NAND_CTRL_CLE | NAND_CTRL_CHANGE);
 	doc200x_hwcontrol(mtd, 0, NAND_CTRL_ALE | NAND_CTRL_CHANGE);
@@ -559,9 +559,8 @@ static void doc2001plus_readbuf(struct nand_chip *this, u_char *buf, int len)
 		printk("\n");
 }
 
-static void doc2001plus_select_chip(struct mtd_info *mtd, int chip)
+static void doc2001plus_select_chip(struct nand_chip *this, int chip)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int floor = 0;
@@ -586,9 +585,9 @@ static void doc2001plus_select_chip(struct mtd_info *mtd, int chip)
 	doc->curfloor = floor;
 }
 
-static void doc200x_select_chip(struct mtd_info *mtd, int chip)
+static void doc200x_select_chip(struct nand_chip *this, int chip)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(this);
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int floor = 0;
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 9cbe87448e77..78c1d6fd42b2 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -333,13 +333,12 @@ static int docg4_wait(struct mtd_info *mtd, struct nand_chip *nand)
 	return status;
 }
 
-static void docg4_select_chip(struct mtd_info *mtd, int chip)
+static void docg4_select_chip(struct nand_chip *nand, int chip)
 {
 	/*
 	 * Select among multiple cascaded chips ("floors").  Multiple floors are
 	 * not yet supported, so the only valid non-negative value is 0.
 	 */
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
 	void __iomem *docptr = doc->virtadr;
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 14d246323e94..74b804a61f2d 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -533,7 +533,7 @@ static void fsl_elbc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	}
 }
 
-static void fsl_elbc_select_chip(struct mtd_info *mtd, int chip)
+static void fsl_elbc_select_chip(struct nand_chip *chip, int cs)
 {
 	/* The hardware does not seem to support multiple
 	 * chips per bank.
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 2e032db997a5..da846ffa3e5c 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -509,7 +509,7 @@ static void fsl_ifc_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	}
 }
 
-static void fsl_ifc_select_chip(struct mtd_info *mtd, int chip)
+static void fsl_ifc_select_chip(struct nand_chip *chip, int cs)
 {
 	/* The hardware does not seem to support multiple
 	 * chips per bank.
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index d3d3adcb7282..ec3553cb737a 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -108,9 +108,9 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 		fun_wait_rnb(fun);
 }
 
-static void fun_select_chip(struct mtd_info *mtd, int mchip_nr)
+static void fun_select_chip(struct nand_chip *chip, int mchip_nr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
 
 	if (mchip_nr == -1) {
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 5fc036c89cc8..15bf533c907a 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -610,9 +610,9 @@ static void fsmc_write_buf_dma(struct mtd_info *mtd, const uint8_t *buf,
 }
 
 /* fsmc_select_chip - assert or deassert nCE */
-static void fsmc_select_chip(struct mtd_info *mtd, int chipnr)
+static void fsmc_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+	struct fsmc_nand_data *host = mtd_to_fsmc(nand_to_mtd(chip));
 	u32 pc;
 
 	/* Support only one CS */
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index bd1b8445b358..f5f1aebf0d64 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -825,9 +825,8 @@ static int gpmi_dev_ready(struct mtd_info *mtd)
 	return gpmi_is_ready(this, this->current_chip);
 }
 
-static void gpmi_select_chip(struct mtd_info *mtd, int chipnr)
+static void gpmi_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	int ret;
 
@@ -1552,7 +1551,7 @@ static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	int column, page, chipnr;
 
 	chipnr = (int)(ofs >> chip->chip_shift);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	column = !GPMI_IS_MX23(this) ? mtd->writesize : 0;
 
@@ -1565,7 +1564,7 @@ static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 	ret = nand_prog_page_op(chip, page, column, block_mark, 1);
 
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	return ret;
 }
@@ -1602,7 +1601,6 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	struct boot_rom_geometry *rom_geo = &this->rom_geometry;
 	struct device *dev = this->dev;
 	struct nand_chip *chip = &this->nand;
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
 	unsigned int page;
@@ -1614,7 +1612,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 	search_area_size_in_strides = 1 << rom_geo->search_area_stride_exponent;
 
 	saved_chip_number = this->current_chip;
-	chip->select_chip(mtd, 0);
+	chip->select_chip(chip, 0);
 
 	/*
 	 * Loop through the first search area, looking for the NCB fingerprint.
@@ -1642,7 +1640,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 
 	}
 
-	chip->select_chip(mtd, saved_chip_number);
+	chip->select_chip(chip, saved_chip_number);
 
 	if (found_an_ncb_fingerprint)
 		dev_dbg(dev, "\tFound a fingerprint\n");
@@ -1685,7 +1683,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 
 	/* Select chip 0. */
 	saved_chip_number = this->current_chip;
-	chip->select_chip(mtd, 0);
+	chip->select_chip(chip, 0);
 
 	/* Loop over blocks in the first search area, erasing them. */
 	dev_dbg(dev, "Erasing the search area...\n");
@@ -1717,7 +1715,7 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 	}
 
 	/* Deselect chip 0. */
-	chip->select_chip(mtd, saved_chip_number);
+	chip->select_chip(chip, saved_chip_number);
 	return 0;
 }
 
@@ -1766,10 +1764,10 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 		byte = block <<  chip->phys_erase_shift;
 
 		/* Send the command to read the conventional block mark. */
-		chip->select_chip(mtd, chipnr);
+		chip->select_chip(chip, chipnr);
 		nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
 		block_mark = chip->read_byte(chip);
-		chip->select_chip(mtd, -1);
+		chip->select_chip(chip, -1);
 
 		/*
 		 * Check if the block is marked bad. If so, we need to mark it
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index b4e5bfd30022..86dd7b54159d 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -353,9 +353,8 @@ static int hisi_nfc_send_cmd_reset(struct hinfc_host *host, int chipselect)
 	return 0;
 }
 
-static void hisi_nfc_select_chip(struct mtd_info *mtd, int chipselect)
+static void hisi_nfc_select_chip(struct nand_chip *chip, int chipselect)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct hinfc_host *host = nand_get_controller_data(chip);
 
 	if (chipselect < 0)
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index e926ed6ed296..b6e68048b83d 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -78,10 +78,9 @@ static inline struct jz_nand *mtd_to_jz_nand(struct mtd_info *mtd)
 	return container_of(mtd_to_nand(mtd), struct jz_nand, chip);
 }
 
-static void jz_nand_select_chip(struct mtd_info *mtd, int chipnr)
+static void jz_nand_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct jz_nand *nand = mtd_to_jz_nand(mtd);
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct jz_nand *nand = mtd_to_jz_nand(nand_to_mtd(chip));
 	uint32_t ctrl;
 	int banknr;
 
@@ -336,14 +335,14 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 			goto notfound_id;
 
 		/* Retrieve the IDs from the first chip. */
-		chip->select_chip(mtd, 0);
+		chip->select_chip(chip, 0);
 		nand_reset_op(chip);
 		nand_readid_op(chip, 0, id, sizeof(id));
 		*nand_maf_id = id[0];
 		*nand_dev_id = id[1];
 	} else {
 		/* Detect additional chip. */
-		chip->select_chip(mtd, chipnr);
+		chip->select_chip(chip, chipnr);
 		nand_reset_op(chip);
 		nand_readid_op(chip, 0, id, sizeof(id));
 		if (*nand_maf_id != id[0] || *nand_dev_id != id[1]) {
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 42c5dcdea4a9..29e597b0ca59 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -71,9 +71,9 @@ static inline struct jz4780_nand_controller
 	return container_of(ctrl, struct jz4780_nand_controller, controller);
 }
 
-static void jz4780_nand_select_chip(struct mtd_info *mtd, int chipnr)
+static void jz4780_nand_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(mtd);
+	struct jz4780_nand_chip *nand = to_jz4780_nand_chip(nand_to_mtd(chip));
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(nand->chip.controller);
 	struct jz4780_nand_cs *cs;
 
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 5f5709c2e58e..1f4e75f8fa3e 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -701,9 +701,8 @@ static int marvell_nfc_wait_op(struct nand_chip *chip, unsigned int timeout_ms)
 	return 0;
 }
 
-static void marvell_nfc_select_chip(struct mtd_info *mtd, int die_nr)
+static void marvell_nfc_select_chip(struct nand_chip *chip, int die_nr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
 	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
 	u32 ndcr_generic;
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index dc573a0b5fe1..c2002c4d467b 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -263,8 +263,10 @@ static void mpc5121_nfc_addr_cycle(struct mtd_info *mtd, int column, int page)
 }
 
 /* Control chip select signals */
-static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)
+static void mpc5121_nfc_select_chip(struct nand_chip *nand, int chip)
 {
+	struct mtd_info *mtd = nand_to_mtd(nand);
+
 	if (chip < 0) {
 		nfc_clear(mtd, NFC_CONFIG1, NFC_CE);
 		return;
@@ -299,9 +301,9 @@ static int ads5121_chipselect_init(struct mtd_info *mtd)
 }
 
 /* Control chips select signal on ADS5121 board */
-static void ads5121_select_chip(struct mtd_info *mtd, int chip)
+static void ads5121_select_chip(struct nand_chip *nand, int chip)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct mpc5121_nfc_prv *prv = nand_get_controller_data(nand);
 	u8 v;
 
@@ -309,10 +311,10 @@ static void ads5121_select_chip(struct mtd_info *mtd, int chip)
 	v |= 0x0F;
 
 	if (chip >= 0) {
-		mpc5121_nfc_select_chip(mtd, 0);
+		mpc5121_nfc_select_chip(nand, 0);
 		v &= ~(1 << chip);
 	} else
-		mpc5121_nfc_select_chip(mtd, -1);
+		mpc5121_nfc_select_chip(nand, -1);
 
 	out_8(prv->csreg, v);
 }
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index bd2002a1fabd..6e5d4afd6b1a 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -389,16 +389,15 @@ static int mtk_nfc_hw_runtime_config(struct mtd_info *mtd)
 	return 0;
 }
 
-static void mtk_nfc_select_chip(struct mtd_info *mtd, int chip)
+static void mtk_nfc_select_chip(struct nand_chip *nand, int chip)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct mtk_nfc *nfc = nand_get_controller_data(nand);
 	struct mtk_nfc_nand_chip *mtk_nand = to_mtk_nand(nand);
 
 	if (chip < 0)
 		return;
 
-	mtk_nfc_hw_runtime_config(mtd);
+	mtk_nfc_hw_runtime_config(nand_to_mtd(nand));
 
 	nfi_writel(nfc, mtk_nand->sels[chip], NFI_CSEL);
 }
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index d5d8f8c16b60..d070ce461b69 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -136,7 +136,7 @@ struct mxc_nand_devtype_data {
 	void (*irq_control)(struct mxc_nand_host *, int);
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
 	const struct mtd_ooblayout_ops *ooblayout;
-	void (*select_chip)(struct mtd_info *mtd, int chip);
+	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*setup_data_interface)(struct mtd_info *mtd, int csline,
 				    const struct nand_data_interface *conf);
 	void (*enable_hwecc)(struct nand_chip *chip, bool enable);
@@ -957,9 +957,8 @@ static void mxc_nand_read_buf(struct nand_chip *nand_chip, u_char *buf,
 
 /* This function is used by upper layer for select and
  * deselect of the NAND chip */
-static void mxc_nand_select_chip_v1_v3(struct mtd_info *mtd, int chip)
+static void mxc_nand_select_chip_v1_v3(struct nand_chip *nand_chip, int chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (chip == -1) {
@@ -978,9 +977,8 @@ static void mxc_nand_select_chip_v1_v3(struct mtd_info *mtd, int chip)
 	}
 }
 
-static void mxc_nand_select_chip_v2(struct mtd_info *mtd, int chip)
+static void mxc_nand_select_chip_v2(struct nand_chip *nand_chip, int chip)
 {
-	struct nand_chip *nand_chip = mtd_to_nand(mtd);
 	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
 
 	if (chip == -1) {
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6c20c0b805a3..3d3e3c704a5a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -277,18 +277,17 @@ static uint8_t nand_read_byte16(struct nand_chip *chip)
 
 /**
  * nand_select_chip - [DEFAULT] control CE line
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @chipnr: chipnumber to select, -1 for deselect
  *
  * Default select function for 1 chip devices.
  */
-static void nand_select_chip(struct mtd_info *mtd, int chipnr)
+static void nand_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-
 	switch (chipnr) {
 	case -1:
-		chip->cmd_ctrl(mtd, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+		chip->cmd_ctrl(nand_to_mtd(chip), NAND_CMD_NONE,
+			       0 | NAND_CTRL_CHANGE);
 		break;
 	case 0:
 		break;
@@ -1261,10 +1260,10 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 
 	/* Change the mode on the chip side (if supported by the NAND chip) */
 	if (nand_supports_set_features(chip, ONFI_FEATURE_ADDR_TIMING_MODE)) {
-		chip->select_chip(mtd, chipnr);
+		chip->select_chip(chip, chipnr);
 		ret = nand_set_features(chip, ONFI_FEATURE_ADDR_TIMING_MODE,
 					tmode_param);
-		chip->select_chip(mtd, -1);
+		chip->select_chip(chip, -1);
 		if (ret)
 			return ret;
 	}
@@ -1279,10 +1278,10 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 		return 0;
 
 	memset(tmode_param, 0, ONFI_SUBFEATURE_PARAM_LEN);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 	ret = nand_get_features(chip, ONFI_FEATURE_ADDR_TIMING_MODE,
 				tmode_param);
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	if (ret)
 		goto err_reset_chip;
 
@@ -1300,9 +1299,9 @@ static int nand_setup_data_interface(struct nand_chip *chip, int chipnr)
 	 * timing mode.
 	 */
 	nand_reset_data_interface(chip, chipnr);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 	nand_reset_op(chip);
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	return ret;
 }
@@ -2794,7 +2793,6 @@ EXPORT_SYMBOL_GPL(nand_subop_get_data_len);
  */
 int nand_reset(struct nand_chip *chip, int chipnr)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_data_interface saved_data_intf = chip->data_interface;
 	int ret;
 
@@ -2806,9 +2804,9 @@ int nand_reset(struct nand_chip *chip, int chipnr)
 	 * The CS line has to be released before we can apply the new NAND
 	 * interface settings, hence this weird ->select_chip() dance.
 	 */
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 	ret = nand_reset_op(chip);
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	if (ret)
 		return ret;
 
@@ -3553,7 +3551,7 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 	bool ecc_fail = false;
 
 	chipnr = (int)(from >> chip->chip_shift);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	realpage = (int)(from >> chip->page_shift);
 	page = realpage & chip->pagemask;
@@ -3684,11 +3682,11 @@ static int nand_do_read_ops(struct mtd_info *mtd, loff_t from,
 		/* Check, if we cross a chip boundary */
 		if (!page) {
 			chipnr++;
-			chip->select_chip(mtd, -1);
-			chip->select_chip(mtd, chipnr);
+			chip->select_chip(chip, -1);
+			chip->select_chip(chip, chipnr);
 		}
 	}
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	ops->retlen = ops->len - (size_t) readlen;
 	if (oob)
@@ -3887,7 +3885,7 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 	len = mtd_oobavail(mtd, ops);
 
 	chipnr = (int)(from >> chip->chip_shift);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	/* Shift to get page */
 	realpage = (int)(from >> chip->page_shift);
@@ -3920,11 +3918,11 @@ static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 		/* Check, if we cross a chip boundary */
 		if (!page) {
 			chipnr++;
-			chip->select_chip(mtd, -1);
-			chip->select_chip(mtd, chipnr);
+			chip->select_chip(chip, -1);
+			chip->select_chip(chip, chipnr);
 		}
 	}
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	ops->oobretlen = ops->ooblen - readlen;
 
@@ -4406,7 +4404,7 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 	column = to & (mtd->writesize - 1);
 
 	chipnr = (int)(to >> chip->chip_shift);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
@@ -4482,8 +4480,8 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 		/* Check, if we cross a chip boundary */
 		if (!page) {
 			chipnr++;
-			chip->select_chip(mtd, -1);
-			chip->select_chip(mtd, chipnr);
+			chip->select_chip(chip, -1);
+			chip->select_chip(chip, chipnr);
 		}
 	}
 
@@ -4492,7 +4490,7 @@ static int nand_do_write_ops(struct mtd_info *mtd, loff_t to,
 		ops->oobretlen = ops->ooblen;
 
 err_out:
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	return ret;
 }
 
@@ -4518,7 +4516,7 @@ static int panic_nand_write(struct mtd_info *mtd, loff_t to, size_t len,
 	/* Grab the device */
 	panic_nand_get_device(chip, mtd, FL_WRITING);
 
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	/* Wait for the device to get ready */
 	panic_nand_wait(mtd, chip, 400);
@@ -4570,14 +4568,14 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	 */
 	nand_reset(chip, chipnr);
 
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	/* Shift to get page */
 	page = (int)(to >> chip->page_shift);
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
-		chip->select_chip(mtd, -1);
+		chip->select_chip(chip, -1);
 		return -EROFS;
 	}
 
@@ -4592,7 +4590,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
 	else
 		status = chip->ecc.write_oob(chip, page & chip->pagemask);
 
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	if (status)
 		return status;
@@ -4700,7 +4698,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 	pages_per_block = 1 << (chip->phys_erase_shift - chip->page_shift);
 
 	/* Select the NAND device */
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	/* Check, if it is write protected */
 	if (nand_check_wp(mtd)) {
@@ -4750,8 +4748,8 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		/* Check, if we cross a chip boundary */
 		if (len && !(page & chip->pagemask)) {
 			chipnr++;
-			chip->select_chip(mtd, -1);
-			chip->select_chip(mtd, chipnr);
+			chip->select_chip(chip, -1);
+			chip->select_chip(chip, chipnr);
 		}
 	}
 
@@ -4759,7 +4757,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 erase_exit:
 
 	/* Deselect and wake up anyone waiting on the device */
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	nand_release_device(mtd);
 
 	/* Return more or less happy */
@@ -4795,11 +4793,11 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
 
 	/* Select the NAND device */
 	nand_get_device(mtd, FL_READING);
-	chip->select_chip(mtd, chipnr);
+	chip->select_chip(chip, chipnr);
 
 	ret = nand_block_checkbad(mtd, offs, 0);
 
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	nand_release_device(mtd);
 
 	return ret;
@@ -5626,7 +5624,7 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 		return ret;
 
 	/* Select the device */
-	chip->select_chip(mtd, 0);
+	chip->select_chip(chip, 0);
 
 	/* Send the command for reading device ID */
 	ret = nand_readid_op(chip, 0, id_data, 2);
@@ -5986,14 +5984,14 @@ static int nand_scan_ident(struct nand_chip *chip, int maxchips,
 	if (ret) {
 		if (!(chip->options & NAND_SCAN_SILENT_NODEV))
 			pr_warn("No NAND device found\n");
-		chip->select_chip(mtd, -1);
+		chip->select_chip(chip, -1);
 		return ret;
 	}
 
 	nand_maf_id = chip->id.data[0];
 	nand_dev_id = chip->id.data[1];
 
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 
 	/* Check for a chip array */
 	for (i = 1; i < maxchips; i++) {
@@ -6002,15 +6000,15 @@ static int nand_scan_ident(struct nand_chip *chip, int maxchips,
 		/* See comment in nand_get_flash_type for reset */
 		nand_reset(chip, i);
 
-		chip->select_chip(mtd, i);
+		chip->select_chip(chip, i);
 		/* Send the command for reading device ID */
 		nand_readid_op(chip, 0, id, sizeof(id));
 		/* Read manufacturer and device IDs */
 		if (nand_maf_id != id[0] || nand_dev_id != id[1]) {
-			chip->select_chip(mtd, -1);
+			chip->select_chip(chip, -1);
 			break;
 		}
-		chip->select_chip(mtd, -1);
+		chip->select_chip(chip, -1);
 	}
 	if (i > 1)
 		pr_info("%d chips detected\n", i);
@@ -6432,9 +6430,9 @@ static int nand_scan_tail(struct nand_chip *chip)
 	 * to explictly select the relevant die when interacting with the NAND
 	 * chip.
 	 */
-	chip->select_chip(mtd, 0);
+	chip->select_chip(chip, 0);
 	ret = nand_manufacturer_init(chip);
-	chip->select_chip(mtd, -1);
+	chip->select_chip(chip, -1);
 	if (ret)
 		goto err_free_buf;
 
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 02b102addeb5..addcc736ae1d 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -44,10 +44,9 @@ struct ndfc_controller {
 
 static struct ndfc_controller ndfc_ctrl[NDFC_MAX_CS];
 
-static void ndfc_select_chip(struct mtd_info *mtd, int chip)
+static void ndfc_select_chip(struct nand_chip *nchip, int chip)
 {
 	uint32_t ccr;
-	struct nand_chip *nchip = mtd_to_nand(mtd);
 	struct ndfc_controller *ndfc = nand_get_controller_data(nchip);
 
 	ccr = in_be32(ndfc->ndfcbase + NDFC_CCR);
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index adfc3f50e8d5..dd9e241b7584 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -37,13 +37,6 @@ static int plat_nand_dev_ready(struct mtd_info *mtd)
 	return pdata->ctrl.dev_ready(mtd_to_nand(mtd));
 }
 
-static void plat_nand_select_chip(struct mtd_info *mtd, int cs)
-{
-	struct platform_nand_data *pdata = dev_get_platdata(mtd->dev.parent);
-
-	pdata->ctrl.select_chip(mtd_to_nand(mtd), cs);
-}
-
 /*
  * Probe for the NAND device.
  */
@@ -90,9 +83,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	if (pdata->ctrl.dev_ready)
 		data->chip.dev_ready = plat_nand_dev_ready;
 
-	if (pdata->ctrl.select_chip)
-		data->chip.select_chip = plat_nand_select_chip;
-
+	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.write_buf = pdata->ctrl.write_buf;
 	data->chip.read_buf = pdata->ctrl.read_buf;
 	data->chip.chip_delay = pdata->chip.chip_delay;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index af4908e26766..626c9ab8c8db 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2324,9 +2324,8 @@ static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *buf,
 }
 
 /* we support only one external chip for now */
-static void qcom_nandc_select_chip(struct mtd_info *mtd, int chipnr)
+static void qcom_nandc_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 
 	if (chipnr <= 0)
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 19f49ca1ed5b..312a971aa456 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -1026,7 +1026,6 @@ static int r852_suspend(struct device *device)
 static int r852_resume(struct device *device)
 {
 	struct r852_device *dev = pci_get_drvdata(to_pci_dev(device));
-	struct mtd_info *mtd = nand_to_mtd(dev->chip);
 
 	r852_disable_irqs(dev);
 	r852_card_update_present(dev);
@@ -1046,9 +1045,9 @@ static int r852_resume(struct device *device)
 	/* Otherwise, initialize the card */
 	if (dev->card_registred) {
 		r852_engine_enable(dev);
-		dev->chip->select_chip(mtd, 0);
+		dev->chip->select_chip(dev->chip, 0);
 		nand_reset_op(dev->chip);
-		dev->chip->select_chip(mtd, -1);
+		dev->chip->select_chip(dev->chip, -1);
 	}
 
 	/* Program card detection IRQ */
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index a420a84eaf51..353011e7fb79 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -404,7 +404,7 @@ static int s3c2410_nand_inithw(struct s3c2410_nand_info *info)
 
 /**
  * s3c2410_nand_select_chip - select the given nand chip
- * @mtd: The MTD instance for this chip.
+ * @this: NAND chip object.
  * @chip: The chip number.
  *
  * This is called by the MTD layer to either select a given chip for the
@@ -415,11 +415,10 @@ static int s3c2410_nand_inithw(struct s3c2410_nand_info *info)
  * platform specific selection code is called to route nFCE to the specific
  * chip.
  */
-static void s3c2410_nand_select_chip(struct mtd_info *mtd, int chip)
+static void s3c2410_nand_select_chip(struct nand_chip *this, int chip)
 {
 	struct s3c2410_nand_info *info;
 	struct s3c2410_nand_mtd *nmtd;
-	struct nand_chip *this = mtd_to_nand(mtd);
 	unsigned long cur;
 
 	nmtd = nand_get_controller_data(this);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 742b7eb82ab7..e2a4939971b5 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -926,9 +926,9 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 	return;
 }
 
-static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
+static void flctl_select_chip(struct nand_chip *chip, int chipnr)
 {
-	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct sh_flctl *flctl = mtd_to_flctl(nand_to_mtd(chip));
 	int ret;
 
 	switch (chipnr) {
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 80d9d2f8f5de..97a0666df615 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -420,9 +420,9 @@ static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
 	return !!(readl(nfc->regs + NFC_REG_ST) & mask);
 }
 
-static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
+static void sunxi_nfc_select_chip(struct nand_chip *nand, int chip)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_chip_sel *sel;
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 7fc95c6980a7..5e0bc2993e5d 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -156,9 +156,8 @@ static void tango_write_buf(struct nand_chip *chip, const u8 *buf, int len)
 	iowrite8_rep(tchip->base + PBUS_DATA, buf, len);
 }
 
-static void tango_select_chip(struct mtd_info *mtd, int idx)
+static void tango_select_chip(struct nand_chip *chip, int idx)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct tango_nfc *nfc = to_tango_nfc(chip->controller);
 	struct tango_chip *tchip = to_tango_chip(chip);
 
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index df8e78814a08..1088741eed1d 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -462,9 +462,8 @@ static int tegra_nand_exec_op(struct nand_chip *chip,
 				      check_only);
 }
 
-static void tegra_nand_select_chip(struct mtd_info *mtd, int die_nr)
+static void tegra_nand_select_chip(struct nand_chip *chip, int die_nr)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct tegra_nand_chip *nand = to_tegra_chip(chip);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index bce6f6769cd6..9814fd4a84cf 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -498,9 +498,9 @@ static int vf610_nfc_exec_op(struct nand_chip *chip,
 /*
  * This function supports Vybrid only (MPC5125 would have full RB and four CS)
  */
-static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
+static void vf610_nfc_select_chip(struct nand_chip *chip, int cs)
 {
-	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	struct vf610_nfc *nfc = mtd_to_nfc(nand_to_mtd(chip));
 	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
 
 	/* Vybrid only (MPC5125 would have full RB and four CS) */
@@ -509,9 +509,9 @@ static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
 
 	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
 
-	if (chip >= 0) {
+	if (cs >= 0) {
 		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
-		tmp |= BIT(chip) << ROW_ADDR_CHIP_SEL_SHIFT;
+		tmp |= BIT(cs) << ROW_ADDR_CHIP_SEL_SHIFT;
 	}
 
 	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 77759f27d154..a6388fa1dce7 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -85,9 +85,8 @@ static void xway_writeb(struct mtd_info *mtd, int op, u8 value)
 	writeb(value, data->nandaddr + op);
 }
 
-static void xway_select_chip(struct mtd_info *mtd, int select)
+static void xway_select_chip(struct nand_chip *chip, int select)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct xway_nand_data *data = nand_get_controller_data(chip);
 
 	switch (select) {
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 7e9ee17a389b..c0df8b6ab19b 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -681,7 +681,7 @@ static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
 }
 #endif
 
-static void spinand_select_chip(struct mtd_info *mtd, int dev)
+static void spinand_select_chip(struct nand_chip *chip, int dev)
 {
 }
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index cd94cb3b9c2e..65a25e89b426 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1287,7 +1287,7 @@ struct nand_chip {
 	void (*write_byte)(struct nand_chip *chip, uint8_t byte);
 	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
 	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
-	void (*select_chip)(struct mtd_info *mtd, int chip);
+	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*block_bad)(struct mtd_info *mtd, loff_t ofs);
 	int (*block_markbad)(struct mtd_info *mtd, loff_t ofs);
 	void (*cmd_ctrl)(struct mtd_info *mtd, int dat, unsigned int ctrl);
-- 
2.14.1
