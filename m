From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 04/19] mtd: rawnand: Deprecate ->cmd_ctrl() and ->cmdfunc()
Date: Fri,  7 Sep 2018 00:38:36 +0200
Message-ID: <20180906223851.6964-5-boris.brezillon@bootlin.com>
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

Those hooks have been replaced by ->exec_op(). Move them to the
nand_legacy struct.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c                 |   2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |   4 +-
 drivers/mtd/nand/raw/au1550nd.c                  |   2 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |   6 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |   4 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |   2 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |   2 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |   2 +-
 drivers/mtd/nand/raw/davinci_nand.c              |   2 +-
 drivers/mtd/nand/raw/denali.c                    |   2 +-
 drivers/mtd/nand/raw/diskonchip.c                |   6 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |   2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |   2 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |   4 +-
 drivers/mtd/nand/raw/gpio.c                      |   2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |   2 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |   2 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |   2 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |   2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |   2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |   2 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |   2 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |   2 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |   2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 138 ++++++++++++-----------
 drivers/mtd/nand/raw/nand_hynix.c                |   4 +-
 drivers/mtd/nand/raw/nandsim.c                   |   2 +-
 drivers/mtd/nand/raw/ndfc.c                      |   2 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |   2 +-
 drivers/mtd/nand/raw/omap2.c                     |   2 +-
 drivers/mtd/nand/raw/orion_nand.c                |   2 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |   2 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |   2 +-
 drivers/mtd/nand/raw/plat_nand.c                 |   2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                |  14 +--
 drivers/mtd/nand/raw/r852.c                      |   2 +-
 drivers/mtd/nand/raw/s3c2410.c                   |   6 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |   2 +-
 drivers/mtd/nand/raw/sharpsl.c                   |   2 +-
 drivers/mtd/nand/raw/socrates_nand.c             |   2 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |   2 +-
 drivers/mtd/nand/raw/tango_nand.c                |   2 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |   2 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                 |   2 +-
 drivers/mtd/nand/raw/xway_nand.c                 |   2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |   2 +-
 include/linux/mtd/rawnand.h                      |  21 ++--
 47 files changed, 144 insertions(+), 137 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 6616f473aeb2..756f6339d457 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -213,7 +213,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->legacy.read_byte = ams_delta_read_byte;
 	this->legacy.write_buf = ams_delta_write_buf;
 	this->legacy.read_buf = ams_delta_read_buf;
-	this->cmd_ctrl = ams_delta_hwcontrol;
+	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
 	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
 		this->dev_ready = ams_delta_nand_ready;
 	} else {
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 9b2876b5a9c2..37f617ec178e 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1472,7 +1472,7 @@ static void atmel_nand_init(struct atmel_nand_controller *nc,
 	mtd->dev.parent = nc->dev;
 	nand->base.controller = &nc->base;
 
-	chip->cmd_ctrl = atmel_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl = atmel_nand_cmd_ctrl;
 	chip->legacy.read_byte = atmel_nand_read_byte;
 	chip->legacy.write_byte = atmel_nand_write_byte;
 	chip->legacy.read_buf = atmel_nand_read_buf;
@@ -1524,7 +1524,7 @@ static void atmel_hsmc_nand_init(struct atmel_nand_controller *nc,
 	atmel_nand_init(nc, nand);
 
 	/* Overload some methods for the HSMC controller. */
-	chip->cmd_ctrl = atmel_hsmc_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl = atmel_hsmc_nand_cmd_ctrl;
 	chip->select_chip = atmel_hsmc_nand_select_chip;
 }
 
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 0db5dc61b155..5d45f13288fc 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -430,7 +430,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 
 	this->dev_ready = au1550_device_ready;
 	this->select_chip = au1550_select_chip;
-	this->cmdfunc = au1550_command;
+	this->legacy.cmdfunc = au1550_command;
 
 	/* 30 us command delay time */
 	this->chip_delay = 30;
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index ea41d1b95c81..2bd389b49b4a 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -227,7 +227,7 @@ static void bcm47xxnflash_ops_bcm4706_cmdfunc(struct nand_chip *nand_chip,
 
 	switch (command) {
 	case NAND_CMD_RESET:
-		nand_chip->cmd_ctrl(nand_chip, command, NAND_CTRL_CLE);
+		nand_chip->legacy.cmd_ctrl(nand_chip, command, NAND_CTRL_CLE);
 
 		ndelay(100);
 		nand_wait_ready(nand_chip);
@@ -384,9 +384,9 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 	u32 val;
 
 	b47n->nand_chip.select_chip = bcm47xxnflash_ops_bcm4706_select_chip;
-	nand_chip->cmd_ctrl = bcm47xxnflash_ops_bcm4706_cmd_ctrl;
+	nand_chip->legacy.cmd_ctrl = bcm47xxnflash_ops_bcm4706_cmd_ctrl;
 	nand_chip->dev_ready = bcm47xxnflash_ops_bcm4706_dev_ready;
-	b47n->nand_chip.cmdfunc = bcm47xxnflash_ops_bcm4706_cmdfunc;
+	b47n->nand_chip.legacy.cmdfunc = bcm47xxnflash_ops_bcm4706_cmdfunc;
 	b47n->nand_chip.legacy.read_byte = bcm47xxnflash_ops_bcm4706_read_byte;
 	b47n->nand_chip.legacy.read_buf = bcm47xxnflash_ops_bcm4706_read_buf;
 	b47n->nand_chip.legacy.write_buf = bcm47xxnflash_ops_bcm4706_write_buf;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 4eb9244cc108..162ec11ab251 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2270,8 +2270,8 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = &pdev->dev;
 
-	chip->cmd_ctrl = brcmnand_cmd_ctrl;
-	chip->cmdfunc = brcmnand_cmdfunc;
+	chip->legacy.cmd_ctrl = brcmnand_cmd_ctrl;
+	chip->legacy.cmdfunc = brcmnand_cmdfunc;
 	chip->waitfunc = brcmnand_waitfunc;
 	chip->legacy.read_byte = brcmnand_read_byte;
 	chip->legacy.read_buf = brcmnand_read_buf;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 95754d1f12b8..0f734442fd3d 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -703,7 +703,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		goto out_ior;
 	}
 
-	cafe->nand.cmdfunc = cafe_nand_cmdfunc;
+	cafe->nand.legacy.cmdfunc = cafe_nand_cmdfunc;
 	cafe->nand.dev_ready = cafe_device_ready;
 	cafe->nand.legacy.read_byte = cafe_read_byte;
 	cafe->nand.legacy.read_buf = cafe_read_buf;
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 18f10ae92dfc..c543f073d971 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -175,7 +175,7 @@ static int __init cmx270_init(void)
 	/* insert callbacks */
 	this->legacy.IO_ADDR_R = cmx270_nand_io;
 	this->legacy.IO_ADDR_W = cmx270_nand_io;
-	this->cmd_ctrl = cmx270_hwcontrol;
+	this->legacy.cmd_ctrl = cmx270_hwcontrol;
 	this->dev_ready = cmx270_device_ready;
 
 	/* 15 us command delay time */
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 8a3230041678..bd75ec4e5508 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -206,7 +206,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 		goto out_mtd;
 	}
 
-	this->cmd_ctrl = cs553x_hwcontrol;
+	this->legacy.cmd_ctrl = cs553x_hwcontrol;
 	this->dev_ready = cs553x_device_ready;
 	this->legacy.read_byte = cs553x_read_byte;
 	this->legacy.read_buf = cs553x_read_buf;
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index b7701caa5f94..5fcd8c30293a 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -781,7 +781,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->mask_cle		= pdata->mask_cle ? : MASK_CLE;
 
 	/* Set address of hardware control function */
-	info->chip.cmd_ctrl	= nand_davinci_hwcontrol;
+	info->chip.legacy.cmd_ctrl	= nand_davinci_hwcontrol;
 	info->chip.dev_ready	= nand_davinci_dev_ready;
 
 	/* Speed up buffer I/O */
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 2d963ed6643c..c11547bfb2e7 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1345,7 +1345,7 @@ int denali_init(struct denali_nand_info *denali)
 	chip->select_chip = denali_select_chip;
 	chip->legacy.read_byte = denali_read_byte;
 	chip->legacy.write_byte = denali_write_byte;
-	chip->cmd_ctrl = denali_cmd_ctrl;
+	chip->legacy.cmd_ctrl = denali_cmd_ctrl;
 	chip->dev_ready = denali_dev_ready;
 	chip->waitfunc = denali_waitfunc;
 
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index ec3336f071e7..2604e80b5475 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1389,9 +1389,9 @@ static inline int __init doc2001plus_init(struct mtd_info *mtd)
 	this->legacy.write_buf = doc2001plus_writebuf;
 	this->legacy.read_buf = doc2001plus_readbuf;
 	doc->late_init = inftl_scan_bbt;
-	this->cmd_ctrl = NULL;
+	this->legacy.cmd_ctrl = NULL;
 	this->select_chip = doc2001plus_select_chip;
-	this->cmdfunc = doc2001plus_command;
+	this->legacy.cmdfunc = doc2001plus_command;
 	this->ecc.hwctl = doc2001plus_enable_hwecc;
 
 	doc->chips_per_floor = 1;
@@ -1569,7 +1569,7 @@ static int __init doc_probe(unsigned long physadr)
 
 	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
-	nand->cmd_ctrl		= doc200x_hwcontrol;
+	nand->legacy.cmd_ctrl		= doc200x_hwcontrol;
 	nand->dev_ready		= doc200x_dev_ready;
 	nand->waitfunc		= doc200x_wait;
 	nand->block_bad		= doc200x_block_bad;
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 5e7b912f63b3..fa21d00c3443 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -780,7 +780,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->legacy.write_buf = fsl_elbc_write_buf;
 	chip->legacy.read_buf = fsl_elbc_read_buf;
 	chip->select_chip = fsl_elbc_select_chip;
-	chip->cmdfunc = fsl_elbc_cmdfunc;
+	chip->legacy.cmdfunc = fsl_elbc_cmdfunc;
 	chip->waitfunc = fsl_elbc_wait;
 	chip->set_features = nand_get_set_features_notsupp;
 	chip->get_features = nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index ed3b90f2fb50..20c86b6503a8 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -865,7 +865,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	chip->legacy.write_buf = fsl_ifc_write_buf;
 	chip->legacy.read_buf = fsl_ifc_read_buf;
 	chip->select_chip = fsl_ifc_select_chip;
-	chip->cmdfunc = fsl_ifc_cmdfunc;
+	chip->legacy.cmdfunc = fsl_ifc_cmdfunc;
 	chip->waitfunc = fsl_ifc_wait;
 	chip->set_features = nand_get_set_features_notsupp;
 	chip->get_features = nand_get_set_features_notsupp;
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index db194ad12074..23baef375bfb 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -112,7 +112,7 @@ static void fun_select_chip(struct nand_chip *chip, int mchip_nr)
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(nand_to_mtd(chip));
 
 	if (mchip_nr == -1) {
-		chip->cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
 	} else if (mchip_nr >= 0 && mchip_nr < NAND_MAX_CHIPS) {
 		fun->mchip_number = mchip_nr;
 		chip->legacy.IO_ADDR_R = fun->io_base + fun->mchip_offsets[mchip_nr];
@@ -162,7 +162,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 
 	fun->chip.legacy.IO_ADDR_R = fun->io_base;
 	fun->chip.legacy.IO_ADDR_W = fun->io_base;
-	fun->chip.cmd_ctrl = fun_cmd_ctrl;
+	fun->chip.legacy.cmd_ctrl = fun_cmd_ctrl;
 	fun->chip.chip_delay = fun->chip_delay;
 	fun->chip.legacy.read_byte = fun_read_byte;
 	fun->chip.legacy.read_buf = fun_read_buf;
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index bb43fad65362..1e6e81047978 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -279,7 +279,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip->ecc.algo		= NAND_ECC_HAMMING;
 	chip->options		= gpiomtd->plat.options;
 	chip->chip_delay	= gpiomtd->plat.chip_delay;
-	chip->cmd_ctrl		= gpio_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl	= gpio_nand_cmd_ctrl;
 
 	mtd			= nand_to_mtd(chip);
 	mtd->dev.parent		= dev;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 54f1a84c6520..fa37d21e5f16 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1902,7 +1902,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	nand_set_flash_node(chip, this->pdev->dev.of_node);
 	chip->select_chip	= gpmi_select_chip;
 	chip->setup_data_interface = gpmi_setup_data_interface;
-	chip->cmd_ctrl		= gpmi_cmd_ctrl;
+	chip->legacy.cmd_ctrl	= gpmi_cmd_ctrl;
 	chip->dev_ready		= gpmi_dev_ready;
 	chip->legacy.read_byte	= gpmi_read_byte;
 	chip->legacy.read_buf	= gpmi_read_buf;
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 1046f51bbcd2..6e17239983db 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -782,7 +782,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 
 	nand_set_controller_data(chip, host);
 	nand_set_flash_node(chip, np);
-	chip->cmdfunc		= hisi_nfc_cmdfunc;
+	chip->legacy.cmdfunc	= hisi_nfc_cmdfunc;
 	chip->select_chip	= hisi_nfc_select_chip;
 	chip->legacy.read_byte	= hisi_nfc_read_byte;
 	chip->legacy.write_buf	= hisi_nfc_write_buf;
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 449180de92e2..ae0c268a5cb6 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -426,7 +426,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->ecc.options	= NAND_ECC_GENERIC_ERASED_CHECK;
 
 	chip->chip_delay = 50;
-	chip->cmd_ctrl = jz_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl = jz_nand_cmd_ctrl;
 	chip->select_chip = jz_nand_select_chip;
 	chip->dummy_controller.ops = &jz_nand_controller_ops;
 
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 89909a17242d..7faf5da6f5ea 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -280,7 +280,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	chip->chip_delay = RB_DELAY_US;
 	chip->options = NAND_NO_SUBPAGE_WRITE;
 	chip->select_chip = jz4780_nand_select_chip;
-	chip->cmd_ctrl = jz4780_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl = jz4780_nand_cmd_ctrl;
 	chip->ecc.mode = NAND_ECC_HW;
 	chip->controller = &nfc->controller;
 	nand_set_flash_node(chip, np);
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index cc1c6e6c59e1..bf3b7aa8a401 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -739,7 +739,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (res)
 		goto put_clk;
 
-	nand_chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
+	nand_chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	nand_chip->dev_ready = lpc32xx_nand_device_ready;
 	nand_chip->chip_delay = 25; /* us */
 	nand_chip->legacy.IO_ADDR_R = MLC_DATA(host->io_base);
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 6dd5348b8f03..1c3f437c42a1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -880,7 +880,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	/* Set NAND IO addresses and command/ready functions */
 	chip->legacy.IO_ADDR_R = SLC_DATA(host->io_base);
 	chip->legacy.IO_ADDR_W = SLC_DATA(host->io_base);
-	chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
+	chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	chip->dev_ready = lpc32xx_nand_device_ready;
 	chip->chip_delay = 20; /* 20us command delay time */
 
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index 4c2925e819f1..1af4c777f887 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -693,7 +693,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 
 	mtd->name = "MPC5121 NAND";
 	chip->dev_ready = mpc5121_nfc_dev_ready;
-	chip->cmdfunc = mpc5121_nfc_command;
+	chip->legacy.cmdfunc = mpc5121_nfc_command;
 	chip->legacy.read_byte = mpc5121_nfc_read_byte;
 	chip->legacy.read_buf = mpc5121_nfc_read_buf;
 	chip->legacy.write_buf = mpc5121_nfc_write_buf;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index fe150e993acf..0cfdca39a269 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1338,7 +1338,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	nand->legacy.write_buf = mtk_nfc_write_buf;
 	nand->legacy.read_byte = mtk_nfc_read_byte;
 	nand->legacy.read_buf = mtk_nfc_read_buf;
-	nand->cmd_ctrl = mtk_nfc_cmd_ctrl;
+	nand->legacy.cmd_ctrl = mtk_nfc_cmd_ctrl;
 	nand->setup_data_interface = mtk_nfc_setup_data_interface;
 
 	/* set default mode in case dt entry is missing */
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index f7e439f578da..146e95153289 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1774,7 +1774,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	nand_set_controller_data(this, host);
 	nand_set_flash_node(this, pdev->dev.of_node),
 	this->dev_ready = mxc_nand_dev_ready;
-	this->cmdfunc = mxc_nand_command;
+	this->legacy.cmdfunc = mxc_nand_command;
 	this->legacy.read_byte = mxc_nand_read_byte;
 	this->legacy.write_buf = mxc_nand_write_buf;
 	this->legacy.read_buf = mxc_nand_read_buf;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 016ef405474c..f3d6cd52f7eb 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -286,7 +286,8 @@ static void nand_select_chip(struct nand_chip *chip, int chipnr)
 {
 	switch (chipnr) {
 	case -1:
-		chip->cmd_ctrl(chip, NAND_CMD_NONE, 0 | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+				      0 | NAND_CTRL_CHANGE);
 		break;
 	case 0:
 		break;
@@ -759,11 +760,11 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 			column -= 256;
 			readcmd = NAND_CMD_READ1;
 		}
-		chip->cmd_ctrl(chip, readcmd, ctrl);
+		chip->legacy.cmd_ctrl(chip, readcmd, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
 	if (command != NAND_CMD_NONE)
-		chip->cmd_ctrl(chip, command, ctrl);
+		chip->legacy.cmd_ctrl(chip, command, ctrl);
 
 	/* Address cycle, when necessary */
 	ctrl = NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -773,17 +774,18 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		if (chip->options & NAND_BUSWIDTH_16 &&
 				!nand_opcode_8bits(command))
 			column >>= 1;
-		chip->cmd_ctrl(chip, column, ctrl);
+		chip->legacy.cmd_ctrl(chip, column, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
 	}
 	if (page_addr != -1) {
-		chip->cmd_ctrl(chip, page_addr, ctrl);
+		chip->legacy.cmd_ctrl(chip, page_addr, ctrl);
 		ctrl &= ~NAND_CTRL_CHANGE;
-		chip->cmd_ctrl(chip, page_addr >> 8, ctrl);
+		chip->legacy.cmd_ctrl(chip, page_addr >> 8, ctrl);
 		if (chip->options & NAND_ROW_ADDR_3)
-			chip->cmd_ctrl(chip, page_addr >> 16, ctrl);
+			chip->legacy.cmd_ctrl(chip, page_addr >> 16, ctrl);
 	}
-	chip->cmd_ctrl(chip, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+			      NAND_NCE | NAND_CTRL_CHANGE);
 
 	/*
 	 * Program and erase have their own busy handlers status and sequential
@@ -805,10 +807,10 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		if (chip->dev_ready)
 			break;
 		udelay(chip->chip_delay);
-		chip->cmd_ctrl(chip, NAND_CMD_STATUS,
-			       NAND_CTRL_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(chip,
-			       NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
+				      NAND_CTRL_CLE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+				      NAND_NCE | NAND_CTRL_CHANGE);
 		/* EZ-NAND can take upto 250ms as per ONFi v4.0 */
 		nand_wait_status_ready(mtd, 250);
 		return;
@@ -886,8 +888,8 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 
 	/* Command latch cycle */
 	if (command != NAND_CMD_NONE)
-		chip->cmd_ctrl(chip, command,
-			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, command,
+				      NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 
 	if (column != -1 || page_addr != -1) {
 		int ctrl = NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -898,23 +900,24 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 			if (chip->options & NAND_BUSWIDTH_16 &&
 					!nand_opcode_8bits(command))
 				column >>= 1;
-			chip->cmd_ctrl(chip, column, ctrl);
+			chip->legacy.cmd_ctrl(chip, column, ctrl);
 			ctrl &= ~NAND_CTRL_CHANGE;
 
 			/* Only output a single addr cycle for 8bits opcodes. */
 			if (!nand_opcode_8bits(command))
-				chip->cmd_ctrl(chip, column >> 8, ctrl);
+				chip->legacy.cmd_ctrl(chip, column >> 8, ctrl);
 		}
 		if (page_addr != -1) {
-			chip->cmd_ctrl(chip, page_addr, ctrl);
-			chip->cmd_ctrl(chip, page_addr >> 8,
-				       NAND_NCE | NAND_ALE);
+			chip->legacy.cmd_ctrl(chip, page_addr, ctrl);
+			chip->legacy.cmd_ctrl(chip, page_addr >> 8,
+					     NAND_NCE | NAND_ALE);
 			if (chip->options & NAND_ROW_ADDR_3)
-				chip->cmd_ctrl(chip, page_addr >> 16,
-					       NAND_NCE | NAND_ALE);
+				chip->legacy.cmd_ctrl(chip, page_addr >> 16,
+						      NAND_NCE | NAND_ALE);
 		}
 	}
-	chip->cmd_ctrl(chip, NAND_CMD_NONE, NAND_NCE | NAND_CTRL_CHANGE);
+	chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+			      NAND_NCE | NAND_CTRL_CHANGE);
 
 	/*
 	 * Program and erase have their own busy handlers status, sequential
@@ -941,20 +944,20 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		if (chip->dev_ready)
 			break;
 		udelay(chip->chip_delay);
-		chip->cmd_ctrl(chip, NAND_CMD_STATUS,
-			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(chip, NAND_CMD_NONE,
-			       NAND_NCE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
+				      NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+				      NAND_NCE | NAND_CTRL_CHANGE);
 		/* EZ-NAND can take upto 250ms as per ONFi v4.0 */
 		nand_wait_status_ready(mtd, 250);
 		return;
 
 	case NAND_CMD_RNDOUT:
 		/* No ready / busy check necessary */
-		chip->cmd_ctrl(chip, NAND_CMD_RNDOUTSTART,
-			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(chip, NAND_CMD_NONE,
-			       NAND_NCE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_RNDOUTSTART,
+				      NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+				      NAND_NCE | NAND_CTRL_CHANGE);
 
 		nand_ccs_delay(chip);
 		return;
@@ -969,10 +972,10 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		if (column == -1 && page_addr == -1)
 			return;
 
-		chip->cmd_ctrl(chip, NAND_CMD_READSTART,
-			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
-		chip->cmd_ctrl(chip, NAND_CMD_NONE,
-			       NAND_NCE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_READSTART,
+				      NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
+				      NAND_NCE | NAND_CTRL_CHANGE);
 
 		/* This applies to read commands */
 	default:
@@ -1522,7 +1525,7 @@ int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 						 buf, len);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_READ0, offset_in_page, page);
+	chip->legacy.cmdfunc(chip, NAND_CMD_READ0, offset_in_page, page);
 	if (len)
 		chip->legacy.read_buf(chip, buf, len);
 
@@ -1570,7 +1573,7 @@ static int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_PARAM, page, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_PARAM, page, -1);
 	for (i = 0; i < len; i++)
 		p[i] = chip->legacy.read_byte(chip);
 
@@ -1633,7 +1636,7 @@ int nand_change_read_column_op(struct nand_chip *chip,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_RNDOUT, offset_in_page, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_RNDOUT, offset_in_page, -1);
 	if (len)
 		chip->legacy.read_buf(chip, buf, len);
 
@@ -1670,7 +1673,7 @@ int nand_read_oob_op(struct nand_chip *chip, unsigned int page,
 					 mtd->writesize + offset_in_oob,
 					 buf, len);
 
-	chip->cmdfunc(chip, NAND_CMD_READOOB, offset_in_oob, page);
+	chip->legacy.cmdfunc(chip, NAND_CMD_READOOB, offset_in_oob, page);
 	if (len)
 		chip->legacy.read_buf(chip, buf, len);
 
@@ -1782,7 +1785,7 @@ int nand_prog_page_begin_op(struct nand_chip *chip, unsigned int page,
 		return nand_exec_prog_page_op(chip, page, offset_in_page, buf,
 					      len, false);
 
-	chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
+	chip->legacy.cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
 
 	if (buf)
 		chip->legacy.write_buf(chip, buf, len);
@@ -1823,7 +1826,7 @@ int nand_prog_page_end_op(struct nand_chip *chip)
 		if (ret)
 			return ret;
 	} else {
-		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
+		chip->legacy.cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
 		ret = chip->waitfunc(chip);
 		if (ret < 0)
 			return ret;
@@ -1868,9 +1871,10 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 		status = nand_exec_prog_page_op(chip, page, offset_in_page, buf,
 						len, true);
 	} else {
-		chip->cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page, page);
+		chip->legacy.cmdfunc(chip, NAND_CMD_SEQIN, offset_in_page,
+				     page);
 		chip->legacy.write_buf(chip, buf, len);
-		chip->cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
+		chip->legacy.cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
 		status = chip->waitfunc(chip);
 	}
 
@@ -1936,7 +1940,7 @@ int nand_change_write_column_op(struct nand_chip *chip,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_RNDIN, offset_in_page, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_RNDIN, offset_in_page, -1);
 	if (len)
 		chip->legacy.write_buf(chip, buf, len);
 
@@ -1983,7 +1987,7 @@ int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_READID, addr, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_READID, addr, -1);
 
 	for (i = 0; i < len; i++)
 		id[i] = chip->legacy.read_byte(chip);
@@ -2021,7 +2025,7 @@ int nand_status_op(struct nand_chip *chip, u8 *status)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_STATUS, -1, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_STATUS, -1, -1);
 	if (status)
 		*status = chip->legacy.read_byte(chip);
 
@@ -2051,7 +2055,7 @@ int nand_exit_status_op(struct nand_chip *chip)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_READ0, -1, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_READ0, -1, -1);
 
 	return 0;
 }
@@ -2099,8 +2103,8 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 		if (ret)
 			return ret;
 	} else {
-		chip->cmdfunc(chip, NAND_CMD_ERASE1, -1, page);
-		chip->cmdfunc(chip, NAND_CMD_ERASE2, -1, -1);
+		chip->legacy.cmdfunc(chip, NAND_CMD_ERASE1, -1, page);
+		chip->legacy.cmdfunc(chip, NAND_CMD_ERASE2, -1, -1);
 
 		ret = chip->waitfunc(chip);
 		if (ret < 0)
@@ -2149,7 +2153,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_SET_FEATURES, feature, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_SET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		chip->legacy.write_byte(chip, params[i]);
 
@@ -2197,7 +2201,7 @@ static int nand_get_features_op(struct nand_chip *chip, u8 feature,
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_GET_FEATURES, feature, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_GET_FEATURES, feature, -1);
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		params[i] = chip->legacy.read_byte(chip);
 
@@ -2250,7 +2254,7 @@ int nand_reset_op(struct nand_chip *chip)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_RESET, -1, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_RESET, -1, -1);
 
 	return 0;
 }
@@ -4919,8 +4923,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 		chip->chip_delay = 20;
 
 	/* check, if a user supplied command function given */
-	if (!chip->cmdfunc && !chip->exec_op)
-		chip->cmdfunc = nand_command;
+	if (!chip->legacy.cmdfunc && !chip->exec_op)
+		chip->legacy.cmdfunc = nand_command;
 
 	/* check, if a user supplied wait function given */
 	if (chip->waitfunc == NULL)
@@ -5213,11 +5217,13 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		/*
 		 * The nand_flash_detect_ext_param_page() uses the
 		 * Change Read Column command which maybe not supported
-		 * by the chip->cmdfunc. So try to update the chip->cmdfunc
-		 * now. We do not replace user supplied command function.
+		 * by the chip->legacy.cmdfunc. So try to update the
+		 * chip->legacy.cmdfunc now. We do not replace user supplied
+		 * command function.
 		 */
-		if (mtd->writesize > 512 && chip->cmdfunc == nand_command)
-			chip->cmdfunc = nand_command_lp;
+		if (mtd->writesize > 512 &&
+		    chip->legacy.cmdfunc == nand_command)
+			chip->legacy.cmdfunc = nand_command_lp;
 
 		/* The Extended Parameter Page is supported since ONFI 2.1. */
 		if (nand_flash_detect_ext_param_page(chip, p))
@@ -5736,8 +5742,8 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	chip->erase = single_erase;
 
 	/* Do not replace user supplied command function! */
-	if (mtd->writesize > 512 && chip->cmdfunc == nand_command)
-		chip->cmdfunc = nand_command_lp;
+	if (mtd->writesize > 512 && chip->legacy.cmdfunc == nand_command)
+		chip->legacy.cmdfunc = nand_command_lp;
 
 	pr_info("device found, Manufacturer ID: 0x%02x, Chip ID: 0x%02x\n",
 		maf_id, dev_id);
@@ -5934,16 +5940,18 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
 		mtd->name = dev_name(mtd->dev.parent);
 
 	/*
-	 * ->cmdfunc() is legacy and will only be used if ->exec_op() is not
-	 * populated.
+	 * ->legacy.cmdfunc() is legacy and will only be used if ->exec_op() is
+	 * not populated.
 	 */
 	if (!chip->exec_op) {
 		/*
-		 * Default functions assigned for ->cmdfunc() and
-		 * ->select_chip() both expect ->cmd_ctrl() to be populated.
+		 * Default functions assigned for ->legacy.cmdfunc() and
+		 * ->select_chip() both expect ->legacy.cmd_ctrl() to be
+		 *  populated.
 		 */
-		if ((!chip->cmdfunc || !chip->select_chip) && !chip->cmd_ctrl) {
-			pr_err("->cmd_ctrl() should be provided\n");
+		if ((!chip->legacy.cmdfunc || !chip->select_chip) &&
+		    !chip->legacy.cmd_ctrl) {
+			pr_err("->legacy.cmd_ctrl() should be provided\n");
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 6a2f3efad153..7eec0d96909a 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -88,7 +88,7 @@ static int hynix_nand_cmd_op(struct nand_chip *chip, u8 cmd)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, cmd, -1, -1);
+	chip->legacy.cmdfunc(chip, cmd, -1, -1);
 
 	return 0;
 }
@@ -107,7 +107,7 @@ static int hynix_nand_reg_write_op(struct nand_chip *chip, u8 addr, u8 val)
 		return nand_exec_op(chip, &op);
 	}
 
-	chip->cmdfunc(chip, NAND_CMD_NONE, column, -1);
+	chip->legacy.cmdfunc(chip, NAND_CMD_NONE, column, -1);
 	chip->legacy.write_byte(chip, val);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index f3219122e311..360c3a7c69d7 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2249,7 +2249,7 @@ static int __init ns_init_module(void)
 	/*
 	 * Register simulator's callbacks.
 	 */
-	chip->cmd_ctrl	 = ns_hwcontrol;
+	chip->legacy.cmd_ctrl	 = ns_hwcontrol;
 	chip->legacy.read_byte  = ns_nand_read_byte;
 	chip->dev_ready  = ns_device_ready;
 	chip->legacy.write_buf  = ns_nand_write_buf;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 7377dc752431..4e58b64ac690 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -144,7 +144,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 
 	chip->legacy.IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
 	chip->legacy.IO_ADDR_W = ndfc->ndfcbase + NDFC_DATA;
-	chip->cmd_ctrl = ndfc_hwcontrol;
+	chip->legacy.cmd_ctrl = ndfc_hwcontrol;
 	chip->dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
 	chip->chip_delay = 50;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 71b0a41bc497..32946dc5c4b8 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -254,7 +254,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 		return -ENOENT;
 	clk_enable(nuc900_nand->clk);
 
-	chip->cmdfunc		= nuc900_nand_command_lp;
+	chip->legacy.cmdfunc	= nuc900_nand_command_lp;
 	chip->dev_ready		= nuc900_nand_devready;
 	chip->legacy.read_byte	= nuc900_nand_read_byte;
 	chip->legacy.write_buf	= nuc900_nand_write_buf;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 3ab4a2c5fc2d..af427a72c7ca 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2230,7 +2230,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	nand_chip->controller = &omap_gpmc_controller;
 
 	nand_chip->legacy.IO_ADDR_W = nand_chip->legacy.IO_ADDR_R;
-	nand_chip->cmd_ctrl  = omap_hwcontrol;
+	nand_chip->legacy.cmd_ctrl  = omap_hwcontrol;
 
 	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "rb",
 						    GPIOD_IN);
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index f0d0054b4a7a..bf288c3c930b 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -137,7 +137,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	nand_set_controller_data(nc, board);
 	nand_set_flash_node(nc, pdev->dev.of_node);
 	nc->legacy.IO_ADDR_R = nc->legacy.IO_ADDR_W = io_base;
-	nc->cmd_ctrl = orion_nand_cmd_ctrl;
+	nc->legacy.cmd_ctrl = orion_nand_cmd_ctrl;
 	nc->legacy.read_buf = orion_nand_read_buf;
 	nc->ecc.mode = NAND_ECC_SOFT;
 	nc->ecc.algo = NAND_ECC_HAMMING;
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 16df274f4cd6..fb0ebb296f6c 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -132,7 +132,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 		mtd->dev.parent = &pdev->dev;
 		mtd->priv = chip;
 
-		chip->cmd_ctrl = oxnas_nand_cmd_ctrl;
+		chip->legacy.cmd_ctrl = oxnas_nand_cmd_ctrl;
 		chip->legacy.read_buf = oxnas_nand_read_buf;
 		chip->legacy.read_byte = oxnas_nand_read_byte;
 		chip->legacy.write_buf = oxnas_nand_write_buf;
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index ca158dabe8b9..d99d7b63e545 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -139,7 +139,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 		goto out_ior;
 	}
 
-	chip->cmd_ctrl = pasemi_hwcontrol;
+	chip->legacy.cmd_ctrl = pasemi_hwcontrol;
 	chip->dev_ready = pasemi_device_ready;
 	chip->legacy.read_buf = pasemi_read_buf;
 	chip->legacy.write_buf = pasemi_write_buf;
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 971e387a8a75..c66c7f942179 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -62,7 +62,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 
 	data->chip.legacy.IO_ADDR_R = data->io_base;
 	data->chip.legacy.IO_ADDR_W = data->io_base;
-	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
+	data->chip.legacy.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 	data->chip.dev_ready = pdata->ctrl.dev_ready;
 	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.legacy.write_buf = pdata->ctrl.write_buf;
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 7b487a2ffa8e..bd187139416f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1155,8 +1155,8 @@ static void config_nand_cw_write(struct qcom_nand_controller *nandc)
 }
 
 /*
- * the following functions are used within chip->cmdfunc() to perform different
- * NAND_CMD_* commands
+ * the following functions are used within chip->legacy.cmdfunc() to
+ * perform different NAND_CMD_* commands
  */
 
 /* sets up descriptors for NAND_CMD_PARAM */
@@ -1436,10 +1436,10 @@ static void post_command(struct qcom_nand_host *host, int command)
 }
 
 /*
- * Implements chip->cmdfunc. It's  only used for a limited set of commands.
- * The rest of the commands wouldn't be called by upper layers. For example,
- * NAND_CMD_READOOB would never be called because we have our own versions
- * of read_oob ops for nand_ecc_ctrl.
+ * Implements chip->legacy.cmdfunc. It's  only used for a limited set of
+ * commands. The rest of the commands wouldn't be called by upper layers.
+ * For example, NAND_CMD_READOOB would never be called because we have our own
+ * versions of read_oob ops for nand_ecc_ctrl.
  */
 static void qcom_nandc_command(struct nand_chip *chip, unsigned int command,
 			       int column, int page_addr)
@@ -2803,7 +2803,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = dev;
 
-	chip->cmdfunc		= qcom_nandc_command;
+	chip->legacy.cmdfunc	= qcom_nandc_command;
 	chip->select_chip	= qcom_nandc_select_chip;
 	chip->legacy.read_byte	= qcom_nandc_read_byte;
 	chip->legacy.read_buf	= qcom_nandc_read_buf;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 05b669d34cec..6e602586cb14 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -853,7 +853,7 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 		goto error4;
 
 	/* commands */
-	chip->cmd_ctrl = r852_cmdctl;
+	chip->legacy.cmd_ctrl = r852_cmdctl;
 	chip->waitfunc = r852_wait;
 	chip->dev_ready = r852_ready;
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index d0670ebd5b68..f232d683f32d 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -884,7 +884,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		chip->legacy.IO_ADDR_W = regs + S3C2410_NFDATA;
 		info->sel_reg   = regs + S3C2410_NFCONF;
 		info->sel_bit	= S3C2410_NFCONF_nFCE;
-		chip->cmd_ctrl  = s3c2410_nand_hwcontrol;
+		chip->legacy.cmd_ctrl  = s3c2410_nand_hwcontrol;
 		chip->dev_ready = s3c2410_nand_devready;
 		break;
 
@@ -892,7 +892,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		chip->legacy.IO_ADDR_W = regs + S3C2440_NFDATA;
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2440_NFCONT_nFCE;
-		chip->cmd_ctrl  = s3c2440_nand_hwcontrol;
+		chip->legacy.cmd_ctrl  = s3c2440_nand_hwcontrol;
 		chip->dev_ready = s3c2440_nand_devready;
 		chip->legacy.read_buf  = s3c2440_nand_read_buf;
 		chip->legacy.write_buf	= s3c2440_nand_write_buf;
@@ -902,7 +902,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		chip->legacy.IO_ADDR_W = regs + S3C2440_NFDATA;
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2412_NFCONT_nFCE0;
-		chip->cmd_ctrl  = s3c2440_nand_hwcontrol;
+		chip->legacy.cmd_ctrl  = s3c2440_nand_hwcontrol;
 		chip->dev_ready = s3c2412_nand_devready;
 
 		if (readl(regs + S3C2410_NFCONF) & S3C2412_NFCONF_NANDBOOT)
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index d83d53810590..71658fbd99a3 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1184,7 +1184,7 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->legacy.write_buf = flctl_write_buf;
 	nand->legacy.read_buf = flctl_read_buf;
 	nand->select_chip = flctl_select_chip;
-	nand->cmdfunc = flctl_cmdfunc;
+	nand->legacy.cmdfunc = flctl_cmdfunc;
 	nand->set_features = nand_get_set_features_notsupp;
 	nand->get_features = nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index d9cdd11fbd3a..a626fb7af8d1 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -156,7 +156,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->legacy.IO_ADDR_R = sharpsl->io + FLASHIO;
 	this->legacy.IO_ADDR_W = sharpsl->io + FLASHIO;
 	/* Set address of hardware control function */
-	this->cmd_ctrl = sharpsl_nand_hwcontrol;
+	this->legacy.cmd_ctrl = sharpsl_nand_hwcontrol;
 	this->dev_ready = sharpsl_nand_dev_ready;
 	/* 15 us command delay time */
 	this->chip_delay = 15;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 006224a40f3b..0ca81fa956b9 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -152,7 +152,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	mtd->name = "socrates_nand";
 	mtd->dev.parent = &ofdev->dev;
 
-	nand_chip->cmd_ctrl = socrates_nand_cmd_ctrl;
+	nand_chip->legacy.cmd_ctrl = socrates_nand_cmd_ctrl;
 	nand_chip->legacy.read_byte = socrates_nand_read_byte;
 	nand_chip->legacy.write_buf = socrates_nand_write_buf;
 	nand_chip->legacy.read_buf = socrates_nand_read_buf;
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 6e1317bde1b3..48bb28872298 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1923,7 +1923,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	nand->ecc.mode = NAND_ECC_HW;
 	nand_set_flash_node(nand, np);
 	nand->select_chip = sunxi_nfc_select_chip;
-	nand->cmd_ctrl = sunxi_nfc_cmd_ctrl;
+	nand->legacy.cmd_ctrl = sunxi_nfc_cmd_ctrl;
 	nand->legacy.read_buf = sunxi_nfc_read_buf;
 	nand->legacy.write_buf = sunxi_nfc_write_buf;
 	nand->legacy.read_byte = sunxi_nfc_read_byte;
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 379f2ed284cb..f0285c0b3089 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -568,7 +568,7 @@ static int chip_init(struct device *dev, struct device_node *np)
 	chip->legacy.write_buf = tango_write_buf;
 	chip->legacy.read_buf = tango_read_buf;
 	chip->select_chip = tango_select_chip;
-	chip->cmd_ctrl = tango_cmd_ctrl;
+	chip->legacy.cmd_ctrl = tango_cmd_ctrl;
 	chip->dev_ready = tango_dev_ready;
 	chip->setup_data_interface = tango_set_timings;
 	chip->options = NAND_USE_BOUNCE_BUFFER |
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 94e659158f16..5037359754eb 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -403,7 +403,7 @@ static int tmio_probe(struct platform_device *dev)
 	nand_chip->legacy.IO_ADDR_W = tmio->fcr;
 
 	/* Set address of hardware control function */
-	nand_chip->cmd_ctrl = tmio_nand_hwcontrol;
+	nand_chip->legacy.cmd_ctrl = tmio_nand_hwcontrol;
 	nand_chip->dev_ready = tmio_nand_dev_ready;
 	nand_chip->legacy.read_byte = tmio_nand_read_byte;
 	nand_chip->legacy.write_buf = tmio_nand_write_buf;
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 7fb1575c6e2b..9eab56a45a5e 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -327,7 +327,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		chip->legacy.read_byte = txx9ndfmc_read_byte;
 		chip->legacy.read_buf = txx9ndfmc_read_buf;
 		chip->legacy.write_buf = txx9ndfmc_write_buf;
-		chip->cmd_ctrl = txx9ndfmc_cmd_ctrl;
+		chip->legacy.cmd_ctrl = txx9ndfmc_cmd_ctrl;
 		chip->dev_ready = txx9ndfmc_dev_ready;
 		chip->ecc.calculate = txx9ndfmc_calculate_ecc;
 		chip->ecc.correct = txx9ndfmc_correct_data;
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 87ec034bdd3e..ef351a4c507f 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -174,7 +174,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 	mtd = nand_to_mtd(&data->chip);
 	mtd->dev.parent = &pdev->dev;
 
-	data->chip.cmd_ctrl = xway_cmd_ctrl;
+	data->chip.legacy.cmd_ctrl = xway_cmd_ctrl;
 	data->chip.dev_ready = xway_dev_ready;
 	data->chip.select_chip = xway_select_chip;
 	data->chip.legacy.write_buf = xway_write_buf;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index 4856593b626e..fbfa024f683d 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -918,7 +918,7 @@ static int spinand_probe(struct spi_device *spi_nand)
 	chip->legacy.read_buf	= spinand_read_buf;
 	chip->legacy.write_buf	= spinand_write_buf;
 	chip->legacy.read_byte	= spinand_read_byte;
-	chip->cmdfunc	= spinand_cmdfunc;
+	chip->legacy.cmdfunc	= spinand_cmdfunc;
 	chip->waitfunc	= spinand_wait;
 	chip->options	|= NAND_CACHEPRG;
 	chip->select_chip = spinand_select_chip;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f961efd2eacc..5ef2004a37a2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -199,10 +199,10 @@ enum nand_ecc_algo {
 #define NAND_USE_BOUNCE_BUFFER	0x00100000
 
 /*
- * In case your controller is implementing ->cmd_ctrl() and is relying on the
- * default ->cmdfunc() implementation, you may want to let the core handle the
- * tCCS delay which is required when a column change (RNDIN or RNDOUT) is
- * requested.
+ * In case your controller is implementing ->legacy.cmd_ctrl() and is relying
+ * on the default ->cmdfunc() implementation, you may want to let the core
+ * handle the tCCS delay which is required when a column change (RNDIN or
+ * RNDOUT) is requested.
  * If your controller already takes care of this delay, you don't need to set
  * this flag.
  */
@@ -1180,6 +1180,9 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * @write_byte: write a single byte to the chip on the low 8 I/O lines
  * @write_buf: write data from the buffer to the chip
  * @read_buf: read data from the chip into the buffer
+ * @cmd_ctrl: hardware specific function for controlling ALE/CLE/nCE. Also used
+ *	      to write command and address
+ * @cmdfunc: hardware specific function for writing commands to the chip.
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1191,6 +1194,9 @@ struct nand_legacy {
 	void (*write_byte)(struct nand_chip *chip, u8 byte);
 	void (*write_buf)(struct nand_chip *chip, const u8 *buf, int len);
 	void (*read_buf)(struct nand_chip *chip, u8 *buf, int len);
+	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
+	void (*cmdfunc)(struct nand_chip *chip, unsigned command, int column,
+			int page_addr);
 };
 
 /**
@@ -1204,14 +1210,10 @@ struct nand_legacy {
  * @select_chip:	[REPLACEABLE] select chip nr
  * @block_bad:		[REPLACEABLE] check if a block is bad, using OOB markers
  * @block_markbad:	[REPLACEABLE] mark a block bad
- * @cmd_ctrl:		[BOARDSPECIFIC] hardwarespecific function for controlling
- *			ALE/CLE/nCE. Also used to write command and address
  * @dev_ready:		[BOARDSPECIFIC] hardwarespecific function for accessing
  *			device ready/busy line. If set to NULL no access to
  *			ready/busy is available and the ready/busy information
  *			is read from the chip status register.
- * @cmdfunc:		[REPLACEABLE] hardwarespecific function for writing
- *			commands to the chip.
  * @waitfunc:		[REPLACEABLE] hardwarespecific function for wait on
  *			ready.
  * @exec_op:		controller specific method to execute NAND operations.
@@ -1303,10 +1305,7 @@ struct nand_chip {
 	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
-	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
 	int (*dev_ready)(struct nand_chip *chip);
-	void (*cmdfunc)(struct nand_chip *chip, unsigned command, int column,
-			int page_addr);
 	int (*waitfunc)(struct nand_chip *chip);
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
-- 
2.14.1
