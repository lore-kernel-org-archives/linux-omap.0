From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 03/19] mtd: rawnand: Deprecate ->{read, write}_{byte,
 buf}() hooks
Date: Fri,  7 Sep 2018 00:38:35 +0200
Message-ID: <20180906223851.6964-4-boris.brezillon@bootlin.com>
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

All those hooks have been replaced by ->exec_op(). Move them to the
nand_legacy struct.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |  6 +--
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  8 ++--
 drivers/mtd/nand/raw/au1550nd.c                  |  6 +--
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  6 +--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  6 +--
 drivers/mtd/nand/raw/cafe_nand.c                 | 10 ++---
 drivers/mtd/nand/raw/cmx270_nand.c               |  6 +--
 drivers/mtd/nand/raw/cs553x_nand.c               |  6 +--
 drivers/mtd/nand/raw/davinci_nand.c              |  4 +-
 drivers/mtd/nand/raw/denali.c                    | 12 +++---
 drivers/mtd/nand/raw/diskonchip.c                | 28 ++++++-------
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  6 +--
 drivers/mtd/nand/raw/fsl_ifc_nand.c              | 12 +++---
 drivers/mtd/nand/raw/fsl_upm.c                   |  6 +--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       | 14 +++----
 drivers/mtd/nand/raw/hisi504_nand.c              | 10 ++---
 drivers/mtd/nand/raw/lpc32xx_slc.c               | 16 ++++----
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  6 +--
 drivers/mtd/nand/raw/mtk_nand.c                  |  8 ++--
 drivers/mtd/nand/raw/mxc_nand.c                  | 10 ++---
 drivers/mtd/nand/raw/nand_base.c                 | 50 ++++++++++++------------
 drivers/mtd/nand/raw/nand_hynix.c                |  2 +-
 drivers/mtd/nand/raw/nandsim.c                   |  8 ++--
 drivers/mtd/nand/raw/ndfc.c                      |  4 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  6 +--
 drivers/mtd/nand/raw/omap2.c                     | 22 +++++------
 drivers/mtd/nand/raw/orion_nand.c                |  2 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  6 +--
 drivers/mtd/nand/raw/pasemi_nand.c               |  4 +-
 drivers/mtd/nand/raw/plat_nand.c                 |  4 +-
 drivers/mtd/nand/raw/qcom_nandc.c                | 17 ++++----
 drivers/mtd/nand/raw/r852.c                      |  6 +--
 drivers/mtd/nand/raw/s3c2410.c                   |  8 ++--
 drivers/mtd/nand/raw/sh_flctl.c                  | 10 ++---
 drivers/mtd/nand/raw/socrates_nand.c             |  6 +--
 drivers/mtd/nand/raw/sunxi_nand.c                |  6 +--
 drivers/mtd/nand/raw/tango_nand.c                |  6 +--
 drivers/mtd/nand/raw/tmio_nand.c                 |  6 +--
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  6 +--
 drivers/mtd/nand/raw/xway_nand.c                 |  6 +--
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  8 ++--
 include/linux/mtd/rawnand.h                      | 21 +++++-----
 42 files changed, 200 insertions(+), 200 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 5bc8b29faf6d..6616f473aeb2 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -210,9 +210,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	/* Set address of NAND IO lines */
 	this->legacy.IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
 	this->legacy.IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
-	this->read_byte = ams_delta_read_byte;
-	this->write_buf = ams_delta_write_buf;
-	this->read_buf = ams_delta_read_buf;
+	this->legacy.read_byte = ams_delta_read_byte;
+	this->legacy.write_buf = ams_delta_write_buf;
+	this->legacy.read_buf = ams_delta_read_buf;
 	this->cmd_ctrl = ams_delta_hwcontrol;
 	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
 		this->dev_ready = ams_delta_nand_ready;
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a38633a67ead..9b2876b5a9c2 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1473,10 +1473,10 @@ static void atmel_nand_init(struct atmel_nand_controller *nc,
 	nand->base.controller = &nc->base;
 
 	chip->cmd_ctrl = atmel_nand_cmd_ctrl;
-	chip->read_byte = atmel_nand_read_byte;
-	chip->write_byte = atmel_nand_write_byte;
-	chip->read_buf = atmel_nand_read_buf;
-	chip->write_buf = atmel_nand_write_buf;
+	chip->legacy.read_byte = atmel_nand_read_byte;
+	chip->legacy.write_byte = atmel_nand_write_byte;
+	chip->legacy.read_buf = atmel_nand_read_buf;
+	chip->legacy.write_buf = atmel_nand_write_buf;
 	chip->select_chip = atmel_nand_select_chip;
 
 	if (nc->mck && nc->caps->ops->setup_data_interface)
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index b7bb2b2af4ef..0db5dc61b155 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -440,10 +440,10 @@ static int au1550nd_probe(struct platform_device *pdev)
 	if (pd->devwidth)
 		this->options |= NAND_BUSWIDTH_16;
 
-	this->read_byte = (pd->devwidth) ? au_read_byte16 : au_read_byte;
+	this->legacy.read_byte = (pd->devwidth) ? au_read_byte16 : au_read_byte;
 	ctx->write_byte = (pd->devwidth) ? au_write_byte16 : au_write_byte;
-	this->write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
-	this->read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
+	this->legacy.write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
+	this->legacy.read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
 
 	ret = nand_scan(this, 1);
 	if (ret) {
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 59e1b88aae38..ea41d1b95c81 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -387,9 +387,9 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 	nand_chip->cmd_ctrl = bcm47xxnflash_ops_bcm4706_cmd_ctrl;
 	nand_chip->dev_ready = bcm47xxnflash_ops_bcm4706_dev_ready;
 	b47n->nand_chip.cmdfunc = bcm47xxnflash_ops_bcm4706_cmdfunc;
-	b47n->nand_chip.read_byte = bcm47xxnflash_ops_bcm4706_read_byte;
-	b47n->nand_chip.read_buf = bcm47xxnflash_ops_bcm4706_read_buf;
-	b47n->nand_chip.write_buf = bcm47xxnflash_ops_bcm4706_write_buf;
+	b47n->nand_chip.legacy.read_byte = bcm47xxnflash_ops_bcm4706_read_byte;
+	b47n->nand_chip.legacy.read_buf = bcm47xxnflash_ops_bcm4706_read_buf;
+	b47n->nand_chip.legacy.write_buf = bcm47xxnflash_ops_bcm4706_write_buf;
 	b47n->nand_chip.set_features = nand_get_set_features_notsupp;
 	b47n->nand_chip.get_features = nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 851db4a7d3e4..4eb9244cc108 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2273,9 +2273,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	chip->cmd_ctrl = brcmnand_cmd_ctrl;
 	chip->cmdfunc = brcmnand_cmdfunc;
 	chip->waitfunc = brcmnand_waitfunc;
-	chip->read_byte = brcmnand_read_byte;
-	chip->read_buf = brcmnand_read_buf;
-	chip->write_buf = brcmnand_write_buf;
+	chip->legacy.read_byte = brcmnand_read_byte;
+	chip->legacy.read_buf = brcmnand_read_buf;
+	chip->legacy.write_buf = brcmnand_write_buf;
 
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->ecc.read_page = brcmnand_read_page;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 801045d77872..95754d1f12b8 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -378,7 +378,7 @@ static int cafe_nand_read_page(struct nand_chip *chip, uint8_t *buf,
 		     cafe_readl(cafe, NAND_ECC_SYN01));
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
-	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	if (checkecc && cafe_readl(cafe, NAND_ECC_RESULT) & (1<<18)) {
 		unsigned short syn[8], pat[4];
@@ -537,7 +537,7 @@ static int cafe_nand_write_page_lowlevel(struct nand_chip *chip,
 	struct cafe_priv *cafe = nand_get_controller_data(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* Set up ECC autogeneration */
 	cafe->ctl2 |= (1<<30);
@@ -705,9 +705,9 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	cafe->nand.cmdfunc = cafe_nand_cmdfunc;
 	cafe->nand.dev_ready = cafe_device_ready;
-	cafe->nand.read_byte = cafe_read_byte;
-	cafe->nand.read_buf = cafe_read_buf;
-	cafe->nand.write_buf = cafe_write_buf;
+	cafe->nand.legacy.read_byte = cafe_read_byte;
+	cafe->nand.legacy.read_buf = cafe_read_buf;
+	cafe->nand.legacy.write_buf = cafe_write_buf;
 	cafe->nand.select_chip = cafe_select_chip;
 	cafe->nand.set_features = nand_get_set_features_notsupp;
 	cafe->nand.get_features = nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index b4ed69815bed..18f10ae92dfc 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -184,9 +184,9 @@ static int __init cmx270_init(void)
 	this->ecc.algo = NAND_ECC_HAMMING;
 
 	/* read/write functions */
-	this->read_byte = cmx270_read_byte;
-	this->read_buf = cmx270_read_buf;
-	this->write_buf = cmx270_write_buf;
+	this->legacy.read_byte = cmx270_read_byte;
+	this->legacy.read_buf = cmx270_read_buf;
+	this->legacy.write_buf = cmx270_write_buf;
 
 	/* Scan to find existence of the device */
 	ret = nand_scan(this, 1);
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index b03fb36e9e69..8a3230041678 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -208,9 +208,9 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 
 	this->cmd_ctrl = cs553x_hwcontrol;
 	this->dev_ready = cs553x_device_ready;
-	this->read_byte = cs553x_read_byte;
-	this->read_buf = cs553x_read_buf;
-	this->write_buf = cs553x_write_buf;
+	this->legacy.read_byte = cs553x_read_byte;
+	this->legacy.read_buf = cs553x_read_buf;
+	this->legacy.write_buf = cs553x_write_buf;
 
 	this->chip_delay = 0;
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 1204b5120176..b7701caa5f94 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -785,8 +785,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->chip.dev_ready	= nand_davinci_dev_ready;
 
 	/* Speed up buffer I/O */
-	info->chip.read_buf     = nand_davinci_read_buf;
-	info->chip.write_buf    = nand_davinci_write_buf;
+	info->chip.legacy.read_buf     = nand_davinci_read_buf;
+	info->chip.legacy.write_buf    = nand_davinci_write_buf;
 
 	/* Use board-specific ECC config */
 	info->chip.ecc.mode	= pdata->ecc_mode;
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index c5e35461d6b3..2d963ed6643c 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1262,11 +1262,11 @@ static int denali_attach_chip(struct nand_chip *chip)
 	mtd_set_ooblayout(mtd, &denali_ooblayout_ops);
 
 	if (chip->options & NAND_BUSWIDTH_16) {
-		chip->read_buf = denali_read_buf16;
-		chip->write_buf = denali_write_buf16;
+		chip->legacy.read_buf = denali_read_buf16;
+		chip->legacy.write_buf = denali_write_buf16;
 	} else {
-		chip->read_buf = denali_read_buf;
-		chip->write_buf = denali_write_buf;
+		chip->legacy.read_buf = denali_read_buf;
+		chip->legacy.write_buf = denali_write_buf;
 	}
 	chip->ecc.read_page = denali_read_page;
 	chip->ecc.read_page_raw = denali_read_page_raw;
@@ -1343,8 +1343,8 @@ int denali_init(struct denali_nand_info *denali)
 		mtd->name = "denali-nand";
 
 	chip->select_chip = denali_select_chip;
-	chip->read_byte = denali_read_byte;
-	chip->write_byte = denali_write_byte;
+	chip->legacy.read_byte = denali_read_byte;
+	chip->legacy.write_byte = denali_write_byte;
 	chip->cmd_ctrl = denali_cmd_ctrl;
 	chip->dev_ready = denali_dev_ready;
 	chip->waitfunc = denali_waitfunc;
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 0b305c19a9a3..ec3336f071e7 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -382,8 +382,8 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 	 */
 	udelay(50);
 
-	ret = this->read_byte(this) << 8;
-	ret |= this->read_byte(this);
+	ret = this->legacy.read_byte(this) << 8;
+	ret |= this->legacy.read_byte(this);
 
 	if (doc->ChipID == DOC_ChipID_Doc2k && try_dword && !nr) {
 		/* First chip probe. See if we get same results by 32-bit access */
@@ -404,7 +404,7 @@ static uint16_t __init doc200x_ident_chip(struct mtd_info *mtd, int nr)
 		ident.dword = readl(docptr + DoC_2k_CDSN_IO);
 		if (((ident.byte[0] << 8) | ident.byte[1]) == ret) {
 			pr_info("DiskOnChip 2000 responds to DWORD access\n");
-			this->read_buf = &doc2000_readbuf_dword;
+			this->legacy.read_buf = &doc2000_readbuf_dword;
 		}
 	}
 
@@ -442,7 +442,7 @@ static int doc200x_wait(struct nand_chip *this)
 	DoC_WaitReady(doc);
 	nand_status_op(this, NULL);
 	DoC_WaitReady(doc);
-	status = (int)this->read_byte(this);
+	status = (int)this->legacy.read_byte(this);
 
 	return status;
 }
@@ -721,7 +721,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 		WriteDOC(NAND_CMD_STATUS, docptr, Mplus_FlashCmd);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
-		while (!(this->read_byte(this) & 0x40)) ;
+		while (!(this->legacy.read_byte(this) & 0x40)) ;
 		return;
 
 		/* This applies to read commands */
@@ -1339,9 +1339,9 @@ static inline int __init doc2000_init(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 
-	this->read_byte = doc2000_read_byte;
-	this->write_buf = doc2000_writebuf;
-	this->read_buf = doc2000_readbuf;
+	this->legacy.read_byte = doc2000_read_byte;
+	this->legacy.write_buf = doc2000_writebuf;
+	this->legacy.read_buf = doc2000_readbuf;
 	doc->late_init = nftl_scan_bbt;
 
 	doc->CDSNControl = CDSN_CTRL_FLASH_IO | CDSN_CTRL_ECC_IO;
@@ -1355,9 +1355,9 @@ static inline int __init doc2001_init(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 
-	this->read_byte = doc2001_read_byte;
-	this->write_buf = doc2001_writebuf;
-	this->read_buf = doc2001_readbuf;
+	this->legacy.read_byte = doc2001_read_byte;
+	this->legacy.write_buf = doc2001_writebuf;
+	this->legacy.read_buf = doc2001_readbuf;
 
 	ReadDOC(doc->virtadr, ChipID);
 	ReadDOC(doc->virtadr, ChipID);
@@ -1385,9 +1385,9 @@ static inline int __init doc2001plus_init(struct mtd_info *mtd)
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct doc_priv *doc = nand_get_controller_data(this);
 
-	this->read_byte = doc2001plus_read_byte;
-	this->write_buf = doc2001plus_writebuf;
-	this->read_buf = doc2001plus_readbuf;
+	this->legacy.read_byte = doc2001plus_read_byte;
+	this->legacy.write_buf = doc2001plus_writebuf;
+	this->legacy.read_buf = doc2001plus_readbuf;
 	doc->late_init = inftl_scan_bbt;
 	this->cmd_ctrl = NULL;
 	this->select_chip = doc2001plus_select_chip;
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 98da5f9f04ac..5e7b912f63b3 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -776,9 +776,9 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 
 	/* fill in nand_chip structure */
 	/* set up function call table */
-	chip->read_byte = fsl_elbc_read_byte;
-	chip->write_buf = fsl_elbc_write_buf;
-	chip->read_buf = fsl_elbc_read_buf;
+	chip->legacy.read_byte = fsl_elbc_read_byte;
+	chip->legacy.write_buf = fsl_elbc_write_buf;
+	chip->legacy.read_buf = fsl_elbc_read_buf;
 	chip->select_chip = fsl_elbc_select_chip;
 	chip->cmdfunc = fsl_elbc_cmdfunc;
 	chip->waitfunc = fsl_elbc_wait;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index cdcd82d1f8bc..ed3b90f2fb50 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -858,12 +858,12 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	/* set up function call table */
 	if ((ifc_in32(&ifc_global->cspr_cs[priv->bank].cspr))
 		& CSPR_PORT_SIZE_16)
-		chip->read_byte = fsl_ifc_read_byte16;
+		chip->legacy.read_byte = fsl_ifc_read_byte16;
 	else
-		chip->read_byte = fsl_ifc_read_byte;
+		chip->legacy.read_byte = fsl_ifc_read_byte;
 
-	chip->write_buf = fsl_ifc_write_buf;
-	chip->read_buf = fsl_ifc_read_buf;
+	chip->legacy.write_buf = fsl_ifc_write_buf;
+	chip->legacy.read_buf = fsl_ifc_read_buf;
 	chip->select_chip = fsl_ifc_select_chip;
 	chip->cmdfunc = fsl_ifc_cmdfunc;
 	chip->waitfunc = fsl_ifc_wait;
@@ -881,10 +881,10 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 
 	if (ifc_in32(&ifc_global->cspr_cs[priv->bank].cspr)
 		& CSPR_PORT_SIZE_16) {
-		chip->read_byte = fsl_ifc_read_byte16;
+		chip->legacy.read_byte = fsl_ifc_read_byte16;
 		chip->options |= NAND_BUSWIDTH_16;
 	} else {
-		chip->read_byte = fsl_ifc_read_byte;
+		chip->legacy.read_byte = fsl_ifc_read_byte;
 	}
 
 	chip->controller = &ifc_nand_ctrl->controller;
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index f59fd57fc529..db194ad12074 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -164,9 +164,9 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	fun->chip.legacy.IO_ADDR_W = fun->io_base;
 	fun->chip.cmd_ctrl = fun_cmd_ctrl;
 	fun->chip.chip_delay = fun->chip_delay;
-	fun->chip.read_byte = fun_read_byte;
-	fun->chip.read_buf = fun_read_buf;
-	fun->chip.write_buf = fun_write_buf;
+	fun->chip.legacy.read_byte = fun_read_byte;
+	fun->chip.legacy.read_buf = fun_read_buf;
+	fun->chip.legacy.write_buf = fun_write_buf;
 	fun->chip.ecc.mode = NAND_ECC_SOFT;
 	fun->chip.ecc.algo = NAND_ECC_HAMMING;
 	if (fun->mchip_count > 1)
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 1ed594a155ed..54f1a84c6520 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1330,7 +1330,7 @@ static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 
 	/* Read out the conventional OOB. */
 	nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
-	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/*
 	 * Now, we want to make sure the block mark is correct. In the
@@ -1340,7 +1340,7 @@ static int gpmi_ecc_read_oob(struct nand_chip *chip, int page)
 	if (GPMI_IS_MX23(this)) {
 		/* Read the block mark into the first byte of the OOB buffer. */
 		nand_read_page_op(chip, page, 0, NULL, 0);
-		chip->oob_poi[0] = chip->read_byte(chip);
+		chip->oob_poi[0] = chip->legacy.read_byte(chip);
 	}
 
 	return 0;
@@ -1628,7 +1628,7 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 		 * and starts in the 12th byte of the page.
 		 */
 		nand_read_page_op(chip, page, 12, NULL, 0);
-		chip->read_buf(chip, buffer, strlen(fingerprint));
+		chip->legacy.read_buf(chip, buffer, strlen(fingerprint));
 
 		/* Look for the fingerprint. */
 		if (!memcmp(buffer, fingerprint, strlen(fingerprint))) {
@@ -1764,7 +1764,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 		/* Send the command to read the conventional block mark. */
 		chip->select_chip(chip, chipnr);
 		nand_read_page_op(chip, page, mtd->writesize, NULL, 0);
-		block_mark = chip->read_byte(chip);
+		block_mark = chip->legacy.read_byte(chip);
 		chip->select_chip(chip, -1);
 
 		/*
@@ -1904,9 +1904,9 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	chip->setup_data_interface = gpmi_setup_data_interface;
 	chip->cmd_ctrl		= gpmi_cmd_ctrl;
 	chip->dev_ready		= gpmi_dev_ready;
-	chip->read_byte		= gpmi_read_byte;
-	chip->read_buf		= gpmi_read_buf;
-	chip->write_buf		= gpmi_write_buf;
+	chip->legacy.read_byte	= gpmi_read_byte;
+	chip->legacy.read_buf	= gpmi_read_buf;
+	chip->legacy.write_buf	= gpmi_write_buf;
 	chip->badblock_pattern	= &gpmi_bbt_descr;
 	chip->block_markbad	= gpmi_block_markbad;
 	chip->options		|= NAND_NO_SUBPAGE_WRITE;
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 928a320c8517..1046f51bbcd2 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -533,7 +533,7 @@ static int hisi_nand_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 	int stat_1, stat_2;
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
-	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* errors which can not be corrected by ECC */
 	if (host->irq_status & HINFC504_INTS_UE) {
@@ -581,7 +581,7 @@ static int hisi_nand_write_page_hwecc(struct nand_chip *chip,
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+		chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -784,9 +784,9 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	nand_set_flash_node(chip, np);
 	chip->cmdfunc		= hisi_nfc_cmdfunc;
 	chip->select_chip	= hisi_nfc_select_chip;
-	chip->read_byte		= hisi_nfc_read_byte;
-	chip->write_buf		= hisi_nfc_write_buf;
-	chip->read_buf		= hisi_nfc_read_buf;
+	chip->legacy.read_byte	= hisi_nfc_read_byte;
+	chip->legacy.write_buf	= hisi_nfc_write_buf;
+	chip->legacy.read_buf	= hisi_nfc_read_buf;
 	chip->chip_delay	= HINFC504_CHIP_DELAY;
 	chip->set_features	= nand_get_set_features_notsupp;
 	chip->get_features	= nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 8a6f109c43af..6dd5348b8f03 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -624,7 +624,7 @@ static int lpc32xx_nand_read_page_syndrome(struct nand_chip *chip, uint8_t *buf,
 	status = lpc32xx_xfer(mtd, buf, chip->ecc.steps, 1);
 
 	/* Get OOB data */
-	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	/* Convert to stored ECC format */
 	lpc32xx_slc_ecc_copy(tmpecc, (uint32_t *) host->ecc_buf, chip->ecc.steps);
@@ -665,8 +665,8 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct nand_chip *chip,
 	nand_read_page_op(chip, page, 0, NULL, 0);
 
 	/* Raw reads can just use the FIFO interface */
-	chip->read_buf(chip, buf, chip->ecc.size * chip->ecc.steps);
-	chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.read_buf(chip, buf, chip->ecc.size * chip->ecc.steps);
+	chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return 0;
 }
@@ -704,7 +704,7 @@ static int lpc32xx_nand_write_page_syndrome(struct nand_chip *chip,
 	lpc32xx_slc_ecc_copy(pb, (uint32_t *)host->ecc_buf, chip->ecc.steps);
 
 	/* Write ECC data to device */
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -722,7 +722,7 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct nand_chip *chip,
 	/* Raw writes can just use the FIFO interface */
 	nand_prog_page_begin_op(chip, page, 0, buf,
 				chip->ecc.size * chip->ecc.steps);
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -891,9 +891,9 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	/* NAND callbacks for LPC32xx SLC hardware */
 	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
-	chip->read_byte = lpc32xx_nand_read_byte;
-	chip->read_buf = lpc32xx_nand_read_buf;
-	chip->write_buf = lpc32xx_nand_write_buf;
+	chip->legacy.read_byte = lpc32xx_nand_read_byte;
+	chip->legacy.read_buf = lpc32xx_nand_read_buf;
+	chip->legacy.write_buf = lpc32xx_nand_write_buf;
 	chip->ecc.read_page_raw = lpc32xx_nand_read_page_raw_syndrome;
 	chip->ecc.read_page = lpc32xx_nand_read_page_syndrome;
 	chip->ecc.write_page_raw = lpc32xx_nand_write_page_raw_syndrome;
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index bd027674898d..4c2925e819f1 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -694,9 +694,9 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	mtd->name = "MPC5121 NAND";
 	chip->dev_ready = mpc5121_nfc_dev_ready;
 	chip->cmdfunc = mpc5121_nfc_command;
-	chip->read_byte = mpc5121_nfc_read_byte;
-	chip->read_buf = mpc5121_nfc_read_buf;
-	chip->write_buf = mpc5121_nfc_write_buf;
+	chip->legacy.read_byte = mpc5121_nfc_read_byte;
+	chip->legacy.read_buf = mpc5121_nfc_read_buf;
+	chip->legacy.write_buf = mpc5121_nfc_write_buf;
 	chip->select_chip = mpc5121_nfc_select_chip;
 	chip->set_features	= nand_get_set_features_notsupp;
 	chip->get_features	= nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 42f9dc2cd172..fe150e993acf 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1334,10 +1334,10 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	nand->options |= NAND_USE_BOUNCE_BUFFER | NAND_SUBPAGE_READ;
 	nand->dev_ready = mtk_nfc_dev_ready;
 	nand->select_chip = mtk_nfc_select_chip;
-	nand->write_byte = mtk_nfc_write_byte;
-	nand->write_buf = mtk_nfc_write_buf;
-	nand->read_byte = mtk_nfc_read_byte;
-	nand->read_buf = mtk_nfc_read_buf;
+	nand->legacy.write_byte = mtk_nfc_write_byte;
+	nand->legacy.write_buf = mtk_nfc_write_buf;
+	nand->legacy.read_byte = mtk_nfc_read_byte;
+	nand->legacy.read_buf = mtk_nfc_read_buf;
 	nand->cmd_ctrl = mtk_nfc_cmd_ctrl;
 	nand->setup_data_interface = mtk_nfc_setup_data_interface;
 
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 895f85ee29db..f7e439f578da 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1402,7 +1402,7 @@ static int mxc_nand_set_features(struct nand_chip *chip, int addr,
 	host->buf_start = 0;
 
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(chip, subfeature_param[i]);
+		chip->legacy.write_byte(chip, subfeature_param[i]);
 
 	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
 	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
@@ -1426,7 +1426,7 @@ static int mxc_nand_get_features(struct nand_chip *chip, int addr,
 	host->buf_start = 0;
 
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		*subfeature_param++ = chip->read_byte(chip);
+		*subfeature_param++ = chip->legacy.read_byte(chip);
 
 	return 0;
 }
@@ -1775,9 +1775,9 @@ static int mxcnd_probe(struct platform_device *pdev)
 	nand_set_flash_node(this, pdev->dev.of_node),
 	this->dev_ready = mxc_nand_dev_ready;
 	this->cmdfunc = mxc_nand_command;
-	this->read_byte = mxc_nand_read_byte;
-	this->write_buf = mxc_nand_write_buf;
-	this->read_buf = mxc_nand_read_buf;
+	this->legacy.read_byte = mxc_nand_read_byte;
+	this->legacy.write_buf = mxc_nand_write_buf;
+	this->legacy.read_buf = mxc_nand_read_buf;
 	this->set_features = mxc_nand_set_features;
 	this->get_features = mxc_nand_get_features;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 1edaa9fdbce9..016ef405474c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -305,7 +305,7 @@ static void nand_select_chip(struct nand_chip *chip, int chipnr)
  */
 static void nand_write_byte(struct nand_chip *chip, uint8_t byte)
 {
-	chip->write_buf(chip, &byte, 1);
+	chip->legacy.write_buf(chip, &byte, 1);
 }
 
 /**
@@ -335,7 +335,7 @@ static void nand_write_byte16(struct nand_chip *chip, uint8_t byte)
 	 * neither an address nor a command transfer. Let's assume a 0 on the
 	 * upper I/O lines is OK.
 	 */
-	chip->write_buf(chip, (uint8_t *)&word, 2);
+	chip->legacy.write_buf(chip, (uint8_t *)&word, 2);
 }
 
 /**
@@ -1524,7 +1524,7 @@ int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 
 	chip->cmdfunc(chip, NAND_CMD_READ0, offset_in_page, page);
 	if (len)
-		chip->read_buf(chip, buf, len);
+		chip->legacy.read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1572,7 +1572,7 @@ static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 
 	chip->cmdfunc(chip, NAND_CMD_PARAM, page, -1);
 	for (i = 0; i < len; i++)
-		p[i] = chip->read_byte(chip);
+		p[i] = chip->legacy.read_byte(chip);
 
 	return 0;
 }
@@ -1635,7 +1635,7 @@ int nand_change_read_column_op(struct nand_chip *chip,
 
 	chip->cmdfunc(chip, NAND_CMD_RNDOUT, offset_in_page, -1);
 	if (len)
-		chip->read_buf(chip, buf, len);
+		chip->legacy.read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1672,7 +1672,7 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 
 	chip->cmdfunc(chip, NAND_CMD_READOOB, offset_in_oob, page);
 	if (len)
-		chip->read_buf(chip, buf, len);
+		chip->legacy.read_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1785,7 +1785,7 @@ int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
 	chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
 
 	if (buf)
-		chip->write_buf(chip, buf, len);
+		chip->legacy.write_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1869,7 +1869,7 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 						len, true);
 	} else {
 		chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
-		chip->write_buf(chip, buf, len);
+		chip->legacy.write_buf(chip, buf, len);
 		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
 		status = chip->waitfunc(chip);
 	}
@@ -1938,7 +1938,7 @@ int nand_change_write_column_op(struct nand_chip *chip,
 
 	chip->cmdfunc(chip, NAND_CMD_RNDIN, offset_in_page, -1);
 	if (len)
-		chip->write_buf(chip, buf, len);
+		chip->legacy.write_buf(chip, buf, len);
 
 	return 0;
 }
@@ -1986,7 +1986,7 @@ int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 	chip->cmdfunc(chip, NAND_CMD_READID, addr, -1);
 
 	for (i = 0; i < len; i++)
-		id[i] = chip->read_byte(chip);
+		id[i] = chip->legacy.read_byte(chip);
 
 	return 0;
 }
@@ -2023,7 +2023,7 @@ int nand_status_op(struct nand_chip *chip, u8 *status)
 
 	chip->cmdfunc(chip, NAND_CMD_STATUS, -1, -1);
 	if (status)
-		*status = chip->read_byte(chip);
+		*status = chip->legacy.read_byte(chip);
 
 	return 0;
 }
@@ -2151,7 +2151,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 
 	chip->cmdfunc(chip, NAND_CMD_SET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		chip->write_byte(chip, params[i]);
+		chip->legacy.write_byte(chip, params[i]);
 
 	ret = chip->waitfunc(chip);
 	if (ret < 0)
@@ -2199,7 +2199,7 @@ static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 
 	chip->cmdfunc(chip, NAND_CMD_GET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
-		params[i] = chip->read_byte(chip);
+		params[i] = chip->legacy.read_byte(chip);
 
 	return 0;
 }
@@ -2291,9 +2291,9 @@ int nand_read_data_op(struct nand_chip *chip, void *buf, unsigned int len,
 		unsigned int i;
 
 		for (i = 0; i < len; i++)
-			p[i] = chip->read_byte(chip);
+			p[i] = chip->legacy.read_byte(chip);
 	} else {
-		chip->read_buf(chip, buf, len);
+		chip->legacy.read_buf(chip, buf, len);
 	}
 
 	return 0;
@@ -2335,9 +2335,9 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
 		unsigned int i;
 
 		for (i = 0; i < len; i++)
-			chip->write_byte(chip, p[i]);
+			chip->legacy.write_byte(chip, p[i]);
 	} else {
-		chip->write_buf(chip, buf, len);
+		chip->legacy.write_buf(chip, buf, len);
 	}
 
 	return 0;
@@ -4936,18 +4936,18 @@ static void nand_set_defaults(struct nand_chip *chip)
 		chip->get_features = nand_default_get_features;
 
 	/* If called twice, pointers that depend on busw may need to be reset */
-	if (!chip->read_byte || chip->read_byte == nand_read_byte)
-		chip->read_byte = busw ? nand_read_byte16 : nand_read_byte;
+	if (!chip->legacy.read_byte || chip->legacy.read_byte == nand_read_byte)
+		chip->legacy.read_byte = busw ? nand_read_byte16 : nand_read_byte;
 	if (!chip->block_bad)
 		chip->block_bad = nand_block_bad;
 	if (!chip->block_markbad)
 		chip->block_markbad = nand_default_block_markbad;
-	if (!chip->write_buf || chip->write_buf == nand_write_buf)
-		chip->write_buf = busw ? nand_write_buf16 : nand_write_buf;
-	if (!chip->write_byte || chip->write_byte == nand_write_byte)
-		chip->write_byte = busw ? nand_write_byte16 : nand_write_byte;
-	if (!chip->read_buf || chip->read_buf == nand_read_buf)
-		chip->read_buf = busw ? nand_read_buf16 : nand_read_buf;
+	if (!chip->legacy.write_buf || chip->legacy.write_buf == nand_write_buf)
+		chip->legacy.write_buf = busw ? nand_write_buf16 : nand_write_buf;
+	if (!chip->legacy.write_byte || chip->legacy.write_byte == nand_write_byte)
+		chip->legacy.write_byte = busw ? nand_write_byte16 : nand_write_byte;
+	if (!chip->legacy.read_buf || chip->legacy.read_buf == nand_read_buf)
+		chip->legacy.read_buf = busw ? nand_read_buf16 : nand_read_buf;
 
 	if (!chip->controller) {
 		chip->controller = &chip->dummy_controller;
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index bb1c4f8ce785..6a2f3efad153 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -108,7 +108,7 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 	}
 
 	chip->cmdfunc(chip, NAND_CMD_NONE, column, -1);
-	chip->write_byte(chip, val);
+	chip->legacy.write_byte(chip, val);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index f750783d5d6a..f3219122e311 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2156,7 +2156,7 @@ static void ns_nand_read_buf(struct nand_chip *chip, u_char *buf, int len)
 		int i;
 
 		for (i = 0; i < len; i++)
-			buf[i] = chip->read_byte(chip);
+			buf[i] = chip->legacy.read_byte(chip);
 
 		return;
 	}
@@ -2250,10 +2250,10 @@ static int __init ns_init_module(void)
 	 * Register simulator's callbacks.
 	 */
 	chip->cmd_ctrl	 = ns_hwcontrol;
-	chip->read_byte  = ns_nand_read_byte;
+	chip->legacy.read_byte  = ns_nand_read_byte;
 	chip->dev_ready  = ns_device_ready;
-	chip->write_buf  = ns_nand_write_buf;
-	chip->read_buf   = ns_nand_read_buf;
+	chip->legacy.write_buf  = ns_nand_write_buf;
+	chip->legacy.read_buf   = ns_nand_read_buf;
 	chip->ecc.mode   = NAND_ECC_SOFT;
 	chip->ecc.algo   = NAND_ECC_HAMMING;
 	/* The NAND_SKIP_BBTSCAN option is necessary for 'overridesize' */
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index adc4060c65ad..7377dc752431 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -149,8 +149,8 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->select_chip = ndfc_select_chip;
 	chip->chip_delay = 50;
 	chip->controller = &ndfc->ndfc_control;
-	chip->read_buf = ndfc_read_buf;
-	chip->write_buf = ndfc_write_buf;
+	chip->legacy.read_buf = ndfc_read_buf;
+	chip->legacy.write_buf = ndfc_write_buf;
 	chip->ecc.correct = nand_correct_data;
 	chip->ecc.hwctl = ndfc_enable_hwecc;
 	chip->ecc.calculate = ndfc_calculate_ecc;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 3aae5fda5399..71b0a41bc497 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -256,9 +256,9 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 
 	chip->cmdfunc		= nuc900_nand_command_lp;
 	chip->dev_ready		= nuc900_nand_devready;
-	chip->read_byte		= nuc900_nand_read_byte;
-	chip->write_buf		= nuc900_nand_write_buf;
-	chip->read_buf		= nuc900_nand_read_buf;
+	chip->legacy.read_byte	= nuc900_nand_read_byte;
+	chip->legacy.write_buf	= nuc900_nand_write_buf;
+	chip->legacy.read_buf	= nuc900_nand_read_buf;
 	chip->chip_delay	= 50;
 	chip->options		= 0;
 	chip->ecc.mode		= NAND_ECC_SOFT;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 627048886c95..3ab4a2c5fc2d 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1539,7 +1539,7 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
-	chip->write_buf(chip, buf, mtd->writesize);
+	chip->legacy.write_buf(chip, buf, mtd->writesize);
 
 	/* Update ecc vector from GPMC result registers */
 	omap_calculate_ecc_bch_multi(mtd, buf, &ecc_calc[0]);
@@ -1550,7 +1550,7 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 		return ret;
 
 	/* Write ecc vector to OOB area */
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -1591,7 +1591,7 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 	chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 	/* Write data */
-	chip->write_buf(chip, buf, mtd->writesize);
+	chip->legacy.write_buf(chip, buf, mtd->writesize);
 
 	for (step = 0; step < ecc_steps; step++) {
 		/* mask ECC of un-touched subpages by padding 0xFF */
@@ -1616,7 +1616,7 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 		return ret;
 
 	/* write OOB buffer to NAND device */
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -1650,7 +1650,7 @@ static int omap_read_page_bch(struct nand_chip *chip, uint8_t *buf,
 	chip->ecc.hwctl(chip, NAND_ECC_READ);
 
 	/* Read data */
-	chip->read_buf(chip, buf, mtd->writesize);
+	chip->legacy.read_buf(chip, buf, mtd->writesize);
 
 	/* Read oob bytes */
 	nand_change_read_column_op(chip,
@@ -1933,8 +1933,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 	/* Re-populate low-level callbacks based on xfer modes */
 	switch (info->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
-		chip->read_buf = omap_read_buf_pref;
-		chip->write_buf = omap_write_buf_pref;
+		chip->legacy.read_buf = omap_read_buf_pref;
+		chip->legacy.write_buf = omap_write_buf_pref;
 		break;
 
 	case NAND_OMAP_POLLED:
@@ -1966,8 +1966,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 					err);
 				return err;
 			}
-			chip->read_buf = omap_read_buf_dma_pref;
-			chip->write_buf = omap_write_buf_dma_pref;
+			chip->legacy.read_buf = omap_read_buf_dma_pref;
+			chip->legacy.write_buf = omap_write_buf_dma_pref;
 		}
 		break;
 
@@ -2002,8 +2002,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 			return err;
 		}
 
-		chip->read_buf = omap_read_buf_irq_pref;
-		chip->write_buf = omap_write_buf_irq_pref;
+		chip->legacy.read_buf = omap_read_buf_irq_pref;
+		chip->legacy.write_buf = omap_write_buf_irq_pref;
 
 		break;
 
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index d73e3c7a3f3a..f0d0054b4a7a 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -138,7 +138,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	nand_set_flash_node(nc, pdev->dev.of_node);
 	nc->legacy.IO_ADDR_R = nc->legacy.IO_ADDR_W = io_base;
 	nc->cmd_ctrl = orion_nand_cmd_ctrl;
-	nc->read_buf = orion_nand_read_buf;
+	nc->legacy.read_buf = orion_nand_read_buf;
 	nc->ecc.mode = NAND_ECC_SOFT;
 	nc->ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index ab32df146505..16df274f4cd6 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -133,9 +133,9 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 		mtd->priv = chip;
 
 		chip->cmd_ctrl = oxnas_nand_cmd_ctrl;
-		chip->read_buf = oxnas_nand_read_buf;
-		chip->read_byte = oxnas_nand_read_byte;
-		chip->write_buf = oxnas_nand_write_buf;
+		chip->legacy.read_buf = oxnas_nand_read_buf;
+		chip->legacy.read_byte = oxnas_nand_read_byte;
+		chip->legacy.write_buf = oxnas_nand_write_buf;
 		chip->chip_delay = 30;
 
 		/* Scan to find existence of the device */
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index 1b367bf9ef53..ca158dabe8b9 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -141,8 +141,8 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 
 	chip->cmd_ctrl = pasemi_hwcontrol;
 	chip->dev_ready = pasemi_device_ready;
-	chip->read_buf = pasemi_read_buf;
-	chip->write_buf = pasemi_write_buf;
+	chip->legacy.read_buf = pasemi_read_buf;
+	chip->legacy.write_buf = pasemi_write_buf;
 	chip->chip_delay = 0;
 	chip->ecc.mode = NAND_ECC_SOFT;
 	chip->ecc.algo = NAND_ECC_HAMMING;
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index c06347531d26..971e387a8a75 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -65,8 +65,8 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 	data->chip.dev_ready = pdata->ctrl.dev_ready;
 	data->chip.select_chip = pdata->ctrl.select_chip;
-	data->chip.write_buf = pdata->ctrl.write_buf;
-	data->chip.read_buf = pdata->ctrl.read_buf;
+	data->chip.legacy.write_buf = pdata->ctrl.write_buf;
+	data->chip.legacy.read_buf = pdata->ctrl.read_buf;
 	data->chip.chip_delay = pdata->chip.chip_delay;
 	data->chip.options |= pdata->chip.options;
 	data->chip.bbt_options |= pdata->chip.bbt_options;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 9037dddff99a..7b487a2ffa8e 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -349,7 +349,8 @@ struct nandc_regs {
  * @data_buffer:		our local DMA buffer for page read/writes,
  *				used when we can't use the buffer provided
  *				by upper layers directly
- * @buf_size/count/start:	markers for chip->read_buf/write_buf functions
+ * @buf_size/count/start:	markers for chip->legacy.read_buf/write_buf
+ *				functions
  * @reg_read_buf:		local buffer for reading back registers via DMA
  * @reg_read_dma:		contains dma address for register read buffer
  * @reg_read_pos:		marker for data read in reg_read_buf
@@ -2275,10 +2276,10 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 }
 
 /*
- * the three functions below implement chip->read_byte(), chip->read_buf()
- * and chip->write_buf() respectively. these aren't used for
- * reading/writing page data, they are used for smaller data like reading
- * id, status etc
+ * the three functions below implement chip->legacy.read_byte(),
+ * chip->legacy.read_buf() and chip->legacy.write_buf() respectively. these
+ * aren't used for reading/writing page data, they are used for smaller data
+ * like reading	id, status etc
  */
 static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
 {
@@ -2804,9 +2805,9 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 
 	chip->cmdfunc		= qcom_nandc_command;
 	chip->select_chip	= qcom_nandc_select_chip;
-	chip->read_byte		= qcom_nandc_read_byte;
-	chip->read_buf		= qcom_nandc_read_buf;
-	chip->write_buf		= qcom_nandc_write_buf;
+	chip->legacy.read_byte	= qcom_nandc_read_byte;
+	chip->legacy.read_buf	= qcom_nandc_read_buf;
+	chip->legacy.write_buf	= qcom_nandc_write_buf;
 	chip->set_features	= nand_get_set_features_notsupp;
 	chip->get_features	= nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 2c30e97ab2a4..05b669d34cec 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -858,9 +858,9 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 	chip->dev_ready = r852_ready;
 
 	/* I/O */
-	chip->read_byte = r852_read_byte;
-	chip->read_buf = r852_read_buf;
-	chip->write_buf = r852_write_buf;
+	chip->legacy.read_byte = r852_read_byte;
+	chip->legacy.read_buf = r852_read_buf;
+	chip->legacy.write_buf = r852_write_buf;
 
 	/* ecc */
 	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 473abf10eeec..d0670ebd5b68 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -864,8 +864,8 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 
 	nand_set_flash_node(chip, set->of_node);
 
-	chip->write_buf    = s3c2410_nand_write_buf;
-	chip->read_buf     = s3c2410_nand_read_buf;
+	chip->legacy.write_buf    = s3c2410_nand_write_buf;
+	chip->legacy.read_buf     = s3c2410_nand_read_buf;
 	chip->select_chip  = s3c2410_nand_select_chip;
 	chip->chip_delay   = 50;
 	nand_set_controller_data(chip, nmtd);
@@ -894,8 +894,8 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		info->sel_bit	= S3C2440_NFCONT_nFCE;
 		chip->cmd_ctrl  = s3c2440_nand_hwcontrol;
 		chip->dev_ready = s3c2440_nand_devready;
-		chip->read_buf  = s3c2440_nand_read_buf;
-		chip->write_buf	= s3c2440_nand_write_buf;
+		chip->legacy.read_buf  = s3c2440_nand_read_buf;
+		chip->legacy.write_buf	= s3c2440_nand_write_buf;
 		break;
 
 	case TYPE_S3C2412:
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 4b1c7e435937..d83d53810590 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -618,7 +618,7 @@ static int flctl_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 
 	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
 	if (oob_required)
-		chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+		chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 	return 0;
 }
 
@@ -628,7 +628,7 @@ static int flctl_write_page_hwecc(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
-	chip->write_buf(chip, chip->oob_poi, mtd->oobsize);
+	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
 	return nand_prog_page_end_op(chip);
 }
 
@@ -1180,9 +1180,9 @@ static int flctl_probe(struct platform_device *pdev)
 	/* 20 us command delay time */
 	nand->chip_delay = 20;
 
-	nand->read_byte = flctl_read_byte;
-	nand->write_buf = flctl_write_buf;
-	nand->read_buf = flctl_read_buf;
+	nand->legacy.read_byte = flctl_read_byte;
+	nand->legacy.write_buf = flctl_write_buf;
+	nand->legacy.read_buf = flctl_read_buf;
 	nand->select_chip = flctl_select_chip;
 	nand->cmdfunc = flctl_cmdfunc;
 	nand->set_features = nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index aa42b4ea4d23..006224a40f3b 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -153,9 +153,9 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	mtd->dev.parent = &ofdev->dev;
 
 	nand_chip->cmd_ctrl = socrates_nand_cmd_ctrl;
-	nand_chip->read_byte = socrates_nand_read_byte;
-	nand_chip->write_buf = socrates_nand_write_buf;
-	nand_chip->read_buf = socrates_nand_read_buf;
+	nand_chip->legacy.read_byte = socrates_nand_read_byte;
+	nand_chip->legacy.write_buf = socrates_nand_write_buf;
+	nand_chip->legacy.read_buf = socrates_nand_read_buf;
 	nand_chip->dev_ready = socrates_nand_device_ready;
 
 	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* enable ECC */
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index a3700b79bdeb..6e1317bde1b3 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1924,9 +1924,9 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	nand_set_flash_node(nand, np);
 	nand->select_chip = sunxi_nfc_select_chip;
 	nand->cmd_ctrl = sunxi_nfc_cmd_ctrl;
-	nand->read_buf = sunxi_nfc_read_buf;
-	nand->write_buf = sunxi_nfc_write_buf;
-	nand->read_byte = sunxi_nfc_read_byte;
+	nand->legacy.read_buf = sunxi_nfc_read_buf;
+	nand->legacy.write_buf = sunxi_nfc_write_buf;
+	nand->legacy.read_byte = sunxi_nfc_read_byte;
 	nand->setup_data_interface = sunxi_nfc_setup_data_interface;
 
 	mtd = nand_to_mtd(nand);
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index bf7012099790..379f2ed284cb 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -564,9 +564,9 @@ static int chip_init(struct device *dev, struct device_node *np)
 	ecc = &chip->ecc;
 	mtd = nand_to_mtd(chip);
 
-	chip->read_byte = tango_read_byte;
-	chip->write_buf = tango_write_buf;
-	chip->read_buf = tango_read_buf;
+	chip->legacy.read_byte = tango_read_byte;
+	chip->legacy.write_buf = tango_write_buf;
+	chip->legacy.read_buf = tango_read_buf;
 	chip->select_chip = tango_select_chip;
 	chip->cmd_ctrl = tango_cmd_ctrl;
 	chip->dev_ready = tango_dev_ready;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 0b23587bf47c..94e659158f16 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -405,9 +405,9 @@ static int tmio_probe(struct platform_device *dev)
 	/* Set address of hardware control function */
 	nand_chip->cmd_ctrl = tmio_nand_hwcontrol;
 	nand_chip->dev_ready = tmio_nand_dev_ready;
-	nand_chip->read_byte = tmio_nand_read_byte;
-	nand_chip->write_buf = tmio_nand_write_buf;
-	nand_chip->read_buf = tmio_nand_read_buf;
+	nand_chip->legacy.read_byte = tmio_nand_read_byte;
+	nand_chip->legacy.write_buf = tmio_nand_write_buf;
+	nand_chip->legacy.read_buf = tmio_nand_read_buf;
 
 	/* set eccmode using hardware ECC */
 	nand_chip->ecc.mode = NAND_ECC_HW;
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index c84b2ad84cf7..7fb1575c6e2b 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -324,9 +324,9 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		mtd = nand_to_mtd(chip);
 		mtd->dev.parent = &dev->dev;
 
-		chip->read_byte = txx9ndfmc_read_byte;
-		chip->read_buf = txx9ndfmc_read_buf;
-		chip->write_buf = txx9ndfmc_write_buf;
+		chip->legacy.read_byte = txx9ndfmc_read_byte;
+		chip->legacy.read_buf = txx9ndfmc_read_buf;
+		chip->legacy.write_buf = txx9ndfmc_write_buf;
 		chip->cmd_ctrl = txx9ndfmc_cmd_ctrl;
 		chip->dev_ready = txx9ndfmc_dev_ready;
 		chip->ecc.calculate = txx9ndfmc_calculate_ecc;
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 3d91e98df5a8..87ec034bdd3e 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -177,9 +177,9 @@ static int xway_nand_probe(struct platform_device *pdev)
 	data->chip.cmd_ctrl = xway_cmd_ctrl;
 	data->chip.dev_ready = xway_dev_ready;
 	data->chip.select_chip = xway_select_chip;
-	data->chip.write_buf = xway_write_buf;
-	data->chip.read_buf = xway_read_buf;
-	data->chip.read_byte = xway_read_byte;
+	data->chip.legacy.write_buf = xway_write_buf;
+	data->chip.legacy.read_buf = xway_read_buf;
+	data->chip.legacy.read_byte = xway_read_byte;
 	data->chip.chip_delay = 30;
 
 	data->chip.ecc.mode = NAND_ECC_SOFT;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index f2e14f972319..4856593b626e 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -657,7 +657,7 @@ static int spinand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
 
 	nand_read_page_op(chip, page, 0, p, eccsize * eccsteps);
 	if (oob_required)
-		chip->read_buf(chip, chip->oob_poi, mtd->oobsize);
+		chip->legacy.read_buf(chip, chip->oob_poi, mtd->oobsize);
 
 	while (1) {
 		retval = spinand_read_status(info->spi, &status);
@@ -915,9 +915,9 @@ static int spinand_probe(struct spi_device *spi_nand)
 
 	nand_set_flash_node(chip, spi_nand->dev.of_node);
 	nand_set_controller_data(chip, info);
-	chip->read_buf	= spinand_read_buf;
-	chip->write_buf	= spinand_write_buf;
-	chip->read_byte	= spinand_read_byte;
+	chip->legacy.read_buf	= spinand_read_buf;
+	chip->legacy.write_buf	= spinand_write_buf;
+	chip->legacy.read_byte	= spinand_read_byte;
 	chip->cmdfunc	= spinand_cmdfunc;
 	chip->waitfunc	= spinand_wait;
 	chip->options	|= NAND_CACHEPRG;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6b1dc8fef89d..f961efd2eacc 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1176,6 +1176,10 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * struct nand_legacy - NAND chip legacy fields/hooks
  * @IO_ADDR_R: address to read the 8 I/O lines of the flash device
  * @IO_ADDR_W: address to write the 8 I/O lines of the flash device
+ * @read_byte: read one byte from the chip
+ * @write_byte: write a single byte to the chip on the low 8 I/O lines
+ * @write_buf: write data from the buffer to the chip
+ * @read_buf: read data from the chip into the buffer
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1183,6 +1187,10 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
 struct nand_legacy {
 	void __iomem *IO_ADDR_R;
 	void __iomem *IO_ADDR_W;
+	u8 (*read_byte)(struct nand_chip *chip);
+	void (*write_byte)(struct nand_chip *chip, u8 byte);
+	void (*write_buf)(struct nand_chip *chip, const u8 *buf, int len);
+	void (*read_buf)(struct nand_chip *chip, u8 *buf, int len);
 };
 
 /**
@@ -1193,11 +1201,6 @@ struct nand_legacy {
  *			you're modifying an existing driver that is using those
  *			fields/hooks, you should consider reworking the driver
  *			avoid using them.
- * @read_byte:		[REPLACEABLE] read one byte from the chip
- * @write_byte:		[REPLACEABLE] write a single byte to the chip on the
- *			low 8 I/O lines
- * @write_buf:		[REPLACEABLE] write data from the buffer to the chip
- * @read_buf:		[REPLACEABLE] read data from the chip into the buffer
  * @select_chip:	[REPLACEABLE] select chip nr
  * @block_bad:		[REPLACEABLE] check if a block is bad, using OOB markers
  * @block_markbad:	[REPLACEABLE] mark a block bad
@@ -1213,8 +1216,8 @@ struct nand_legacy {
  *			ready.
  * @exec_op:		controller specific method to execute NAND operations.
  *			This method replaces ->cmdfunc(),
- *			->{read,write}_{buf,byte,word}(), ->dev_ready() and
- *			->waifunc().
+ *			->legacy.{read,write}_{buf,byte,word}(), ->dev_ready()
+ *			and ->waifunc().
  * @setup_read_retry:	[FLASHSPECIFIC] flash (vendor) specific function for
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @ecc:		[BOARDSPECIFIC] ECC control structure
@@ -1297,10 +1300,6 @@ struct nand_chip {
 
 	struct nand_legacy legacy;
 
-	uint8_t (*read_byte)(struct nand_chip *chip);
-	void (*write_byte)(struct nand_chip *chip, uint8_t byte);
-	void (*write_buf)(struct nand_chip *chip, const uint8_t *buf, int len);
-	void (*read_buf)(struct nand_chip *chip, uint8_t *buf, int len);
 	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
-- 
2.14.1
