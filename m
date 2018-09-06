From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 05/19] mtd: rawnand: Deprecate ->dev_ready() and ->waitfunc()
Date: Fri,  7 Sep 2018 00:38:37 +0200
Message-ID: <20180906223851.6964-6-boris.brezillon@bootlin.com>
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
 Documentation/driver-api/mtdnand.rst             |  4 +--
 drivers/mtd/nand/raw/ams-delta.c                 |  4 +--
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  8 +++---
 drivers/mtd/nand/raw/au1550nd.c                  |  7 +++--
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c         |  2 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  2 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |  2 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  2 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  2 +-
 drivers/mtd/nand/raw/denali.c                    |  7 +++--
 drivers/mtd/nand/raw/diskonchip.c                | 10 +++----
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  2 +-
 drivers/mtd/nand/raw/fsl_upm.c                   |  2 +-
 drivers/mtd/nand/raw/gpio.c                      |  2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c       |  2 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  2 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |  2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  4 +--
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  2 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c               |  2 +-
 drivers/mtd/nand/raw/mtk_nand.c                  |  2 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 36 ++++++++++++------------
 drivers/mtd/nand/raw/nandsim.c                   |  2 +-
 drivers/mtd/nand/raw/ndfc.c                      |  2 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  8 +++---
 drivers/mtd/nand/raw/omap2.c                     |  4 +--
 drivers/mtd/nand/raw/pasemi_nand.c               |  2 +-
 drivers/mtd/nand/raw/plat_nand.c                 |  2 +-
 drivers/mtd/nand/raw/r852.c                      |  6 ++--
 drivers/mtd/nand/raw/s3c2410.c                   |  6 ++--
 drivers/mtd/nand/raw/sharpsl.c                   |  2 +-
 drivers/mtd/nand/raw/socrates_nand.c             |  2 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |  4 +--
 drivers/mtd/nand/raw/tango_nand.c                |  4 +--
 drivers/mtd/nand/raw/tmio_nand.c                 |  4 +--
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  2 +-
 drivers/mtd/nand/raw/xway_nand.c                 |  2 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c    |  2 +-
 include/linux/mtd/rawnand.h                      | 18 ++++++------
 42 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index 1d2403f1d8c5..0d3fa4d6576d 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -197,7 +197,7 @@ to read back the state of the pin. The function has no arguments and
 should return 0, if the device is busy (R/B pin is low) and 1, if the
 device is ready (R/B pin is high). If the hardware interface does not
 give access to the ready busy pin, then the function must not be defined
-and the function pointer this->dev_ready is set to NULL.
+and the function pointer this->legacy.dev_ready is set to NULL.
 
 Init function
 -------------
@@ -242,7 +242,7 @@ necessary information about the device.
         /* Set command delay time, see datasheet for correct value */
         this->chip_delay = CHIP_DEPENDEND_COMMAND_DELAY;
         /* Assign the device ready function, if available */
-        this->dev_ready = board_dev_ready;
+        this->legacy.dev_ready = board_dev_ready;
         this->eccmode = NAND_ECC_SOFT;
 
         /* Scan to find existence of the device */
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 756f6339d457..2fa6fa3c7464 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -215,9 +215,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	this->legacy.read_buf = ams_delta_read_buf;
 	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
 	if (gpio_request(AMS_DELTA_GPIO_PIN_NAND_RB, "nand_rdy") == 0) {
-		this->dev_ready = ams_delta_nand_ready;
+		this->legacy.dev_ready = ams_delta_nand_ready;
 	} else {
-		this->dev_ready = NULL;
+		this->legacy.dev_ready = NULL;
 		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
 	}
 	/* 25 us command delay time */
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 37f617ec178e..dd022080442d 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -488,14 +488,14 @@ static void atmel_nand_select_chip(struct nand_chip *chip, int cs)
 
 	if (cs < 0 || cs >= nand->numcs) {
 		nand->activecs = NULL;
-		chip->dev_ready = NULL;
+		chip->legacy.dev_ready = NULL;
 		return;
 	}
 
 	nand->activecs = &nand->cs[cs];
 
 	if (nand->activecs->rb.type == ATMEL_NAND_GPIO_RB)
-		chip->dev_ready = atmel_nand_dev_ready;
+		chip->legacy.dev_ready = atmel_nand_dev_ready;
 }
 
 static int atmel_hsmc_nand_dev_ready(struct nand_chip *chip)
@@ -528,7 +528,7 @@ static void atmel_hsmc_nand_select_chip(struct nand_chip *chip, int cs)
 	}
 
 	if (nand->activecs->rb.type == ATMEL_NAND_NATIVE_RB)
-		chip->dev_ready = atmel_hsmc_nand_dev_ready;
+		chip->legacy.dev_ready = atmel_hsmc_nand_dev_ready;
 
 	regmap_update_bits(nc->base.smc, ATMEL_HSMC_NFC_CFG,
 			   ATMEL_HSMC_NFC_CFG_PAGESIZE_MASK |
@@ -945,7 +945,7 @@ static int atmel_hsmc_nand_pmecc_write_pg(struct nand_chip *chip,
 		dev_err(nc->base.dev, "Failed to program NAND page (err = %d)\n",
 			ret);
 
-	status = chip->waitfunc(chip);
+	status = chip->legacy.waitfunc(chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 5d45f13288fc..81bba469c0e4 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -342,7 +342,8 @@ static void au1550_command(struct nand_chip *this, unsigned command,
 		/* Apply a short delay always to ensure that we do wait tWB. */
 		ndelay(100);
 		/* Wait for a chip to become ready... */
-		for (i = this->chip_delay; !this->dev_ready(this) && i > 0; --i)
+		for (i = this->chip_delay;
+		     !this->legacy.dev_ready(this) && i > 0; --i)
 			udelay(1);
 
 		/* Release -CE and re-enable interrupts. */
@@ -353,7 +354,7 @@ static void au1550_command(struct nand_chip *this, unsigned command,
 	/* Apply this short delay always to ensure that we do wait tWB. */
 	ndelay(100);
 
-	while(!this->dev_ready(this));
+	while(!this->legacy.dev_ready(this));
 }
 
 static int find_nand_cs(unsigned long nand_base)
@@ -428,7 +429,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 	}
 	ctx->cs = cs;
 
-	this->dev_ready = au1550_device_ready;
+	this->legacy.dev_ready = au1550_device_ready;
 	this->select_chip = au1550_select_chip;
 	this->legacy.cmdfunc = au1550_command;
 
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 2bd389b49b4a..925d4cd4401e 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -385,7 +385,7 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 
 	b47n->nand_chip.select_chip = bcm47xxnflash_ops_bcm4706_select_chip;
 	nand_chip->legacy.cmd_ctrl = bcm47xxnflash_ops_bcm4706_cmd_ctrl;
-	nand_chip->dev_ready = bcm47xxnflash_ops_bcm4706_dev_ready;
+	nand_chip->legacy.dev_ready = bcm47xxnflash_ops_bcm4706_dev_ready;
 	b47n->nand_chip.legacy.cmdfunc = bcm47xxnflash_ops_bcm4706_cmdfunc;
 	b47n->nand_chip.legacy.read_byte = bcm47xxnflash_ops_bcm4706_read_byte;
 	b47n->nand_chip.legacy.read_buf = bcm47xxnflash_ops_bcm4706_read_buf;
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 162ec11ab251..482c6f093f99 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2272,7 +2272,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
 	chip->legacy.cmd_ctrl = brcmnand_cmd_ctrl;
 	chip->legacy.cmdfunc = brcmnand_cmdfunc;
-	chip->waitfunc = brcmnand_waitfunc;
+	chip->legacy.waitfunc = brcmnand_waitfunc;
 	chip->legacy.read_byte = brcmnand_read_byte;
 	chip->legacy.read_buf = brcmnand_read_buf;
 	chip->legacy.write_buf = brcmnand_write_buf;
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index 0f734442fd3d..738af0f0a48d 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -704,7 +704,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	}
 
 	cafe->nand.legacy.cmdfunc = cafe_nand_cmdfunc;
-	cafe->nand.dev_ready = cafe_device_ready;
+	cafe->nand.legacy.dev_ready = cafe_device_ready;
 	cafe->nand.legacy.read_byte = cafe_read_byte;
 	cafe->nand.legacy.read_buf = cafe_read_buf;
 	cafe->nand.legacy.write_buf = cafe_write_buf;
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index c543f073d971..585dbd51d8b1 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -176,7 +176,7 @@ static int __init cmx270_init(void)
 	this->legacy.IO_ADDR_R = cmx270_nand_io;
 	this->legacy.IO_ADDR_W = cmx270_nand_io;
 	this->legacy.cmd_ctrl = cmx270_hwcontrol;
-	this->dev_ready = cmx270_device_ready;
+	this->legacy.dev_ready = cmx270_device_ready;
 
 	/* 15 us command delay time */
 	this->chip_delay = 20;
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index bd75ec4e5508..61ae9e60bf0d 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -207,7 +207,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	}
 
 	this->legacy.cmd_ctrl = cs553x_hwcontrol;
-	this->dev_ready = cs553x_device_ready;
+	this->legacy.dev_ready = cs553x_device_ready;
 	this->legacy.read_byte = cs553x_read_byte;
 	this->legacy.read_buf = cs553x_read_buf;
 	this->legacy.write_buf = cs553x_write_buf;
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 5fcd8c30293a..bae568d68432 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -782,7 +782,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	/* Set address of hardware control function */
 	info->chip.legacy.cmd_ctrl	= nand_davinci_hwcontrol;
-	info->chip.dev_ready	= nand_davinci_dev_ready;
+	info->chip.legacy.dev_ready	= nand_davinci_dev_ready;
 
 	/* Speed up buffer I/O */
 	info->chip.legacy.read_buf     = nand_davinci_read_buf;
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index c11547bfb2e7..c14493ef6126 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -287,7 +287,8 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 		return;
 
 	/*
-	 * Some commands are followed by chip->dev_ready or chip->waitfunc.
+	 * Some commands are followed by chip->legacy.dev_ready or
+	 * chip->legacy.waitfunc.
 	 * irq_status must be cleared here to catch the R/B# interrupt later.
 	 */
 	if (ctrl & NAND_CTRL_CHANGE)
@@ -1346,8 +1347,8 @@ int denali_init(struct denali_nand_info *denali)
 	chip->legacy.read_byte = denali_read_byte;
 	chip->legacy.write_byte = denali_write_byte;
 	chip->legacy.cmd_ctrl = denali_cmd_ctrl;
-	chip->dev_ready = denali_dev_ready;
-	chip->waitfunc = denali_waitfunc;
+	chip->legacy.dev_ready = denali_dev_ready;
+	chip->legacy.waitfunc = denali_waitfunc;
 
 	if (features & FEATURES__INDEX_ADDR) {
 		denali->host_read = denali_indexed_read;
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 2604e80b5475..c3a79369fbed 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -715,7 +715,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 		return;
 
 	case NAND_CMD_RESET:
-		if (this->dev_ready)
+		if (this->legacy.dev_ready)
 			break;
 		udelay(this->chip_delay);
 		WriteDOC(NAND_CMD_STATUS, docptr, Mplus_FlashCmd);
@@ -730,7 +730,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 		 * If we don't have access to the busy pin, we apply the given
 		 * command delay
 		 */
-		if (!this->dev_ready) {
+		if (!this->legacy.dev_ready) {
 			udelay(this->chip_delay);
 			return;
 		}
@@ -740,7 +740,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 	 * any case on any machine. */
 	ndelay(100);
 	/* wait until command is processed */
-	while (!this->dev_ready(this)) ;
+	while (!this->legacy.dev_ready(this)) ;
 }
 
 static int doc200x_dev_ready(struct nand_chip *this)
@@ -1570,8 +1570,8 @@ static int __init doc_probe(unsigned long physadr)
 	nand_set_controller_data(nand, doc);
 	nand->select_chip	= doc200x_select_chip;
 	nand->legacy.cmd_ctrl		= doc200x_hwcontrol;
-	nand->dev_ready		= doc200x_dev_ready;
-	nand->waitfunc		= doc200x_wait;
+	nand->legacy.dev_ready	= doc200x_dev_ready;
+	nand->legacy.waitfunc	= doc200x_wait;
 	nand->block_bad		= doc200x_block_bad;
 	nand->ecc.hwctl		= doc200x_enable_hwecc;
 	nand->ecc.calculate	= doc200x_calculate_ecc;
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index fa21d00c3443..29f0832de39b 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -781,7 +781,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	chip->legacy.read_buf = fsl_elbc_read_buf;
 	chip->select_chip = fsl_elbc_select_chip;
 	chip->legacy.cmdfunc = fsl_elbc_cmdfunc;
-	chip->waitfunc = fsl_elbc_wait;
+	chip->legacy.waitfunc = fsl_elbc_wait;
 	chip->set_features = nand_get_set_features_notsupp;
 	chip->get_features = nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 20c86b6503a8..682ae383c3e9 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -866,7 +866,7 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	chip->legacy.read_buf = fsl_ifc_read_buf;
 	chip->select_chip = fsl_ifc_select_chip;
 	chip->legacy.cmdfunc = fsl_ifc_cmdfunc;
-	chip->waitfunc = fsl_ifc_wait;
+	chip->legacy.waitfunc = fsl_ifc_wait;
 	chip->set_features = nand_get_set_features_notsupp;
 	chip->get_features = nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 23baef375bfb..fcb79718b6c3 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -173,7 +173,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 		fun->chip.select_chip = fun_select_chip;
 
 	if (fun->rnb_gpio[0] >= 0)
-		fun->chip.dev_ready = fun_chip_ready;
+		fun->chip.legacy.dev_ready = fun_chip_ready;
 
 	mtd->dev.parent = fun->dev;
 
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 1e6e81047978..c4f19067702e 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -271,7 +271,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	}
 	/* Using RDY pin */
 	if (gpiomtd->rdy)
-		chip->dev_ready = gpio_nand_devready;
+		chip->legacy.dev_ready = gpio_nand_devready;
 
 	nand_set_flash_node(chip, pdev->dev.of_node);
 	chip->legacy.IO_ADDR_W	= chip->legacy.IO_ADDR_R;
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index fa37d21e5f16..dc6291902acf 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1903,7 +1903,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	chip->select_chip	= gpmi_select_chip;
 	chip->setup_data_interface = gpmi_setup_data_interface;
 	chip->legacy.cmd_ctrl	= gpmi_cmd_ctrl;
-	chip->dev_ready		= gpmi_dev_ready;
+	chip->legacy.dev_ready	= gpmi_dev_ready;
 	chip->legacy.read_byte	= gpmi_read_byte;
 	chip->legacy.read_buf	= gpmi_read_buf;
 	chip->legacy.write_buf	= gpmi_write_buf;
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index ae0c268a5cb6..7a1b4c3ff6fd 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -431,7 +431,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->dummy_controller.ops = &jz_nand_controller_ops;
 
 	if (nand->busy_gpio)
-		chip->dev_ready = jz_nand_dev_ready;
+		chip->legacy.dev_ready = jz_nand_dev_ready;
 
 	platform_set_drvdata(pdev, nand);
 
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 7faf5da6f5ea..2a960211b97d 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -256,7 +256,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 		dev_err(dev, "failed to request busy GPIO: %d\n", ret);
 		return ret;
 	} else if (nand->busy_gpio) {
-		nand->chip.dev_ready = jz4780_nand_dev_ready;
+		nand->chip.legacy.dev_ready = jz4780_nand_dev_ready;
 	}
 
 	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index bf3b7aa8a401..8a1dfb7ee885 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -740,7 +740,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto put_clk;
 
 	nand_chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
-	nand_chip->dev_ready = lpc32xx_nand_device_ready;
+	nand_chip->legacy.dev_ready = lpc32xx_nand_device_ready;
 	nand_chip->chip_delay = 25; /* us */
 	nand_chip->legacy.IO_ADDR_R = MLC_DATA(host->io_base);
 	nand_chip->legacy.IO_ADDR_W = MLC_DATA(host->io_base);
@@ -760,7 +760,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	nand_chip->ecc.read_oob = lpc32xx_read_oob;
 	nand_chip->ecc.strength = 4;
 	nand_chip->ecc.bytes = 10;
-	nand_chip->waitfunc = lpc32xx_waitfunc;
+	nand_chip->legacy.waitfunc = lpc32xx_waitfunc;
 
 	nand_chip->options = NAND_NO_SUBPAGE_WRITE;
 	nand_chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 1c3f437c42a1..75d62d6bed7b 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -881,7 +881,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	chip->legacy.IO_ADDR_R = SLC_DATA(host->io_base);
 	chip->legacy.IO_ADDR_W = SLC_DATA(host->io_base);
 	chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
-	chip->dev_ready = lpc32xx_nand_device_ready;
+	chip->legacy.dev_ready = lpc32xx_nand_device_ready;
 	chip->chip_delay = 20; /* 20us command delay time */
 
 	/* Init NAND controller */
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index 1af4c777f887..9a6dc783689e 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -692,7 +692,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	}
 
 	mtd->name = "MPC5121 NAND";
-	chip->dev_ready = mpc5121_nfc_dev_ready;
+	chip->legacy.dev_ready = mpc5121_nfc_dev_ready;
 	chip->legacy.cmdfunc = mpc5121_nfc_command;
 	chip->legacy.read_byte = mpc5121_nfc_read_byte;
 	chip->legacy.read_buf = mpc5121_nfc_read_buf;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 0cfdca39a269..2bb0df1b7244 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1332,7 +1332,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	nand_set_controller_data(nand, nfc);
 
 	nand->options |= NAND_USE_BOUNCE_BUFFER | NAND_SUBPAGE_READ;
-	nand->dev_ready = mtk_nfc_dev_ready;
+	nand->legacy.dev_ready = mtk_nfc_dev_ready;
 	nand->select_chip = mtk_nfc_select_chip;
 	nand->legacy.write_byte = mtk_nfc_write_byte;
 	nand->legacy.write_buf = mtk_nfc_write_buf;
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 146e95153289..ca074c955147 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1773,7 +1773,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 
 	nand_set_controller_data(this, host);
 	nand_set_flash_node(this, pdev->dev.of_node),
-	this->dev_ready = mxc_nand_dev_ready;
+	this->legacy.dev_ready = mxc_nand_dev_ready;
 	this->legacy.cmdfunc = mxc_nand_command;
 	this->legacy.read_byte = mxc_nand_read_byte;
 	this->legacy.write_buf = mxc_nand_write_buf;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f3d6cd52f7eb..30b55a4677f9 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -604,7 +604,7 @@ static void panic_nand_wait_ready(struct mtd_info *mtd, unsigned long timeo)
 
 	/* Wait for the device to get ready */
 	for (i = 0; i < timeo; i++) {
-		if (chip->dev_ready(chip))
+		if (chip->legacy.dev_ready(chip))
 			break;
 		touch_softlockup_watchdog();
 		mdelay(1);
@@ -628,12 +628,12 @@ void nand_wait_ready(struct nand_chip *chip)
 	/* Wait until command is processed or timeout occurs */
 	timeo = jiffies + msecs_to_jiffies(timeo);
 	do {
-		if (chip->dev_ready(chip))
+		if (chip->legacy.dev_ready(chip))
 			return;
 		cond_resched();
 	} while (time_before(jiffies, timeo));
 
-	if (!chip->dev_ready(chip))
+	if (!chip->legacy.dev_ready(chip))
 		pr_warn_ratelimited("timeout while waiting for chip to become ready\n");
 }
 EXPORT_SYMBOL_GPL(nand_wait_ready);
@@ -804,7 +804,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		return;
 
 	case NAND_CMD_RESET:
-		if (chip->dev_ready)
+		if (chip->legacy.dev_ready)
 			break;
 		udelay(chip->chip_delay);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
@@ -831,7 +831,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		 * If we don't have access to the busy pin, we apply the given
 		 * command delay
 		 */
-		if (!chip->dev_ready) {
+		if (!chip->legacy.dev_ready) {
 			udelay(chip->chip_delay);
 			return;
 		}
@@ -941,7 +941,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		return;
 
 	case NAND_CMD_RESET:
-		if (chip->dev_ready)
+		if (chip->legacy.dev_ready)
 			break;
 		udelay(chip->chip_delay);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
@@ -983,7 +983,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		 * If we don't have access to the busy pin, we apply the given
 		 * command delay.
 		 */
-		if (!chip->dev_ready) {
+		if (!chip->legacy.dev_ready) {
 			udelay(chip->chip_delay);
 			return;
 		}
@@ -1069,8 +1069,8 @@ static void panic_nand_wait(struct nand_chip *chip, unsigned long timeo)
 {
 	int i;
 	for (i = 0; i < timeo; i++) {
-		if (chip->dev_ready) {
-			if (chip->dev_ready(chip))
+		if (chip->legacy.dev_ready) {
+			if (chip->legacy.dev_ready(chip))
 				break;
 		} else {
 			int ret;
@@ -1117,8 +1117,8 @@ static int nand_wait(struct nand_chip *chip)
 	else {
 		timeo = jiffies + msecs_to_jiffies(timeo);
 		do {
-			if (chip->dev_ready) {
-				if (chip->dev_ready(chip))
+			if (chip->legacy.dev_ready) {
+				if (chip->legacy.dev_ready(chip))
 					break;
 			} else {
 				ret = nand_read_data_op(chip, &status,
@@ -1827,7 +1827,7 @@ int nand_prog_page_end_op(struct nand_chip *chip)
 			return ret;
 	} else {
 		chip->legacy.cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
-		ret = chip->waitfunc(chip);
+		ret = chip->legacy.waitfunc(chip);
 		if (ret < 0)
 			return ret;
 
@@ -1875,7 +1875,7 @@ int nand_prog_page_op(struct nand_chip *chip, unsigned int page,
 				     page);
 		chip->legacy.write_buf(chip, buf, len);
 		chip->legacy.cmdfunc(chip, NAND_CMD_PAGEPROG, -1, -1);
-		status = chip->waitfunc(chip);
+		status = chip->legacy.waitfunc(chip);
 	}
 
 	if (status & NAND_STATUS_FAIL)
@@ -2106,7 +2106,7 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
 		chip->legacy.cmdfunc(chip, NAND_CMD_ERASE1, -1, page);
 		chip->legacy.cmdfunc(chip, NAND_CMD_ERASE2, -1, -1);
 
-		ret = chip->waitfunc(chip);
+		ret = chip->legacy.waitfunc(chip);
 		if (ret < 0)
 			return ret;
 
@@ -2157,7 +2157,7 @@ static int nand_set_features_op(struct nand_chip *chip, u8 feature,
 	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
 		chip->legacy.write_byte(chip, params[i]);
 
-	ret = chip->waitfunc(chip);
+	ret = chip->legacy.waitfunc(chip);
 	if (ret < 0)
 		return ret;
 
@@ -2222,7 +2222,7 @@ static int nand_wait_rdy_op(struct nand_chip *chip, unsigned int timeout_ms,
 	}
 
 	/* Apply delay or wait for ready/busy pin */
-	if (!chip->dev_ready)
+	if (!chip->legacy.dev_ready)
 		udelay(chip->chip_delay);
 	else
 		nand_wait_ready(chip);
@@ -4927,8 +4927,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 		chip->legacy.cmdfunc = nand_command;
 
 	/* check, if a user supplied wait function given */
-	if (chip->waitfunc == NULL)
-		chip->waitfunc = nand_wait;
+	if (chip->legacy.waitfunc == NULL)
+		chip->legacy.waitfunc = nand_wait;
 
 	if (!chip->select_chip)
 		chip->select_chip = nand_select_chip;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 360c3a7c69d7..ff0c372ee288 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2251,7 +2251,7 @@ static int __init ns_init_module(void)
 	 */
 	chip->legacy.cmd_ctrl	 = ns_hwcontrol;
 	chip->legacy.read_byte  = ns_nand_read_byte;
-	chip->dev_ready  = ns_device_ready;
+	chip->legacy.dev_ready  = ns_device_ready;
 	chip->legacy.write_buf  = ns_nand_write_buf;
 	chip->legacy.read_buf   = ns_nand_read_buf;
 	chip->ecc.mode   = NAND_ECC_SOFT;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 4e58b64ac690..19b4cb2d1c6e 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -145,7 +145,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->legacy.IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
 	chip->legacy.IO_ADDR_W = ndfc->ndfcbase + NDFC_DATA;
 	chip->legacy.cmd_ctrl = ndfc_hwcontrol;
-	chip->dev_ready = ndfc_ready;
+	chip->legacy.dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
 	chip->chip_delay = 50;
 	chip->controller = &ndfc->ndfc_control;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 32946dc5c4b8..208b6de67510 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -175,7 +175,7 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 		return;
 
 	case NAND_CMD_RESET:
-		if (chip->dev_ready)
+		if (chip->legacy.dev_ready)
 			break;
 		udelay(chip->chip_delay);
 
@@ -196,7 +196,7 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 		write_cmd_reg(nand, NAND_CMD_READSTART);
 	default:
 
-		if (!chip->dev_ready) {
+		if (!chip->legacy.dev_ready) {
 			udelay(chip->chip_delay);
 			return;
 		}
@@ -206,7 +206,7 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 	 * any case on any machine. */
 	ndelay(100);
 
-	while (!chip->dev_ready(chip))
+	while (!chip->legacy.dev_ready(chip))
 		;
 }
 
@@ -255,7 +255,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	clk_enable(nuc900_nand->clk);
 
 	chip->legacy.cmdfunc	= nuc900_nand_command_lp;
-	chip->dev_ready		= nuc900_nand_devready;
+	chip->legacy.dev_ready	= nuc900_nand_devready;
 	chip->legacy.read_byte	= nuc900_nand_read_byte;
 	chip->legacy.write_buf	= nuc900_nand_write_buf;
 	chip->legacy.read_buf	= nuc900_nand_read_buf;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index af427a72c7ca..5e1e7ced0d9e 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2247,10 +2247,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 * device and read status register until you get a failure or success
 	 */
 	if (info->ready_gpiod) {
-		nand_chip->dev_ready = omap_dev_ready;
+		nand_chip->legacy.dev_ready = omap_dev_ready;
 		nand_chip->chip_delay = 0;
 	} else {
-		nand_chip->waitfunc = omap_wait;
+		nand_chip->legacy.waitfunc = omap_wait;
 		nand_chip->chip_delay = 50;
 	}
 
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index d99d7b63e545..e9a4e82bfb34 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -140,7 +140,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	}
 
 	chip->legacy.cmd_ctrl = pasemi_hwcontrol;
-	chip->dev_ready = pasemi_device_ready;
+	chip->legacy.dev_ready = pasemi_device_ready;
 	chip->legacy.read_buf = pasemi_read_buf;
 	chip->legacy.write_buf = pasemi_write_buf;
 	chip->chip_delay = 0;
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index c66c7f942179..6cce01d09364 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -63,7 +63,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.legacy.IO_ADDR_R = data->io_base;
 	data->chip.legacy.IO_ADDR_W = data->io_base;
 	data->chip.legacy.cmd_ctrl = pdata->ctrl.cmd_ctrl;
-	data->chip.dev_ready = pdata->ctrl.dev_ready;
+	data->chip.legacy.dev_ready = pdata->ctrl.dev_ready;
 	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.legacy.write_buf = pdata->ctrl.write_buf;
 	data->chip.legacy.read_buf = pdata->ctrl.read_buf;
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 6e602586cb14..b08aa0a5a074 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -373,7 +373,7 @@ static int r852_wait(struct nand_chip *chip)
 		msecs_to_jiffies(400) : msecs_to_jiffies(20));
 
 	while (time_before(jiffies, timeout))
-		if (chip->dev_ready(chip))
+		if (chip->legacy.dev_ready(chip))
 			break;
 
 	nand_status_op(chip, &status);
@@ -854,8 +854,8 @@ static int  r852_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 
 	/* commands */
 	chip->legacy.cmd_ctrl = r852_cmdctl;
-	chip->waitfunc = r852_wait;
-	chip->dev_ready = r852_ready;
+	chip->legacy.waitfunc = r852_wait;
+	chip->legacy.dev_ready = r852_ready;
 
 	/* I/O */
 	chip->legacy.read_byte = r852_read_byte;
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index f232d683f32d..87b5162857f8 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -885,7 +885,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		info->sel_reg   = regs + S3C2410_NFCONF;
 		info->sel_bit	= S3C2410_NFCONF_nFCE;
 		chip->legacy.cmd_ctrl  = s3c2410_nand_hwcontrol;
-		chip->dev_ready = s3c2410_nand_devready;
+		chip->legacy.dev_ready = s3c2410_nand_devready;
 		break;
 
 	case TYPE_S3C2440:
@@ -893,7 +893,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2440_NFCONT_nFCE;
 		chip->legacy.cmd_ctrl  = s3c2440_nand_hwcontrol;
-		chip->dev_ready = s3c2440_nand_devready;
+		chip->legacy.dev_ready = s3c2440_nand_devready;
 		chip->legacy.read_buf  = s3c2440_nand_read_buf;
 		chip->legacy.write_buf	= s3c2440_nand_write_buf;
 		break;
@@ -903,7 +903,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 		info->sel_reg   = regs + S3C2440_NFCONT;
 		info->sel_bit	= S3C2412_NFCONT_nFCE0;
 		chip->legacy.cmd_ctrl  = s3c2440_nand_hwcontrol;
-		chip->dev_ready = s3c2412_nand_devready;
+		chip->legacy.dev_ready = s3c2412_nand_devready;
 
 		if (readl(regs + S3C2410_NFCONF) & S3C2412_NFCONF_NANDBOOT)
 			dev_info(info->device, "System booted from NAND\n");
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index a626fb7af8d1..3d14408cbbce 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -157,7 +157,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->legacy.IO_ADDR_W = sharpsl->io + FLASHIO;
 	/* Set address of hardware control function */
 	this->legacy.cmd_ctrl = sharpsl_nand_hwcontrol;
-	this->dev_ready = sharpsl_nand_dev_ready;
+	this->legacy.dev_ready = sharpsl_nand_dev_ready;
 	/* 15 us command delay time */
 	this->chip_delay = 15;
 	/* set eccmode using hardware ECC */
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 0ca81fa956b9..604ef7508f14 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -156,7 +156,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	nand_chip->legacy.read_byte = socrates_nand_read_byte;
 	nand_chip->legacy.write_buf = socrates_nand_write_buf;
 	nand_chip->legacy.read_buf = socrates_nand_read_buf;
-	nand_chip->dev_ready = socrates_nand_device_ready;
+	nand_chip->legacy.dev_ready = socrates_nand_device_ready;
 
 	nand_chip->ecc.mode = NAND_ECC_SOFT;	/* enable ECC */
 	nand_chip->ecc.algo = NAND_ECC_HAMMING;
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 48bb28872298..37e23aec4bce 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -442,9 +442,9 @@ static void sunxi_nfc_select_chip(struct nand_chip *nand, int chip)
 		ctl |= NFC_CE_SEL(sel->cs) | NFC_EN |
 		       NFC_PAGE_SHIFT(nand->page_shift);
 		if (sel->rb < 0) {
-			nand->dev_ready = NULL;
+			nand->legacy.dev_ready = NULL;
 		} else {
-			nand->dev_ready = sunxi_nfc_dev_ready;
+			nand->legacy.dev_ready = sunxi_nfc_dev_ready;
 			ctl |= NFC_RB_SEL(sel->rb);
 		}
 
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index f0285c0b3089..8818f893f300 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -314,7 +314,7 @@ static int tango_write_page(struct nand_chip *chip, const u8 *buf,
 	if (err)
 		return err;
 
-	status = chip->waitfunc(chip);
+	status = chip->legacy.waitfunc(chip);
 	if (status & NAND_STATUS_FAIL)
 		return -EIO;
 
@@ -569,7 +569,7 @@ static int chip_init(struct device *dev, struct device_node *np)
 	chip->legacy.read_buf = tango_read_buf;
 	chip->select_chip = tango_select_chip;
 	chip->legacy.cmd_ctrl = tango_cmd_ctrl;
-	chip->dev_ready = tango_dev_ready;
+	chip->legacy.dev_ready = tango_dev_ready;
 	chip->setup_data_interface = tango_set_timings;
 	chip->options = NAND_USE_BOUNCE_BUFFER |
 			NAND_NO_SUBPAGE_WRITE |
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 5037359754eb..7e49272ecef6 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -404,7 +404,7 @@ static int tmio_probe(struct platform_device *dev)
 
 	/* Set address of hardware control function */
 	nand_chip->legacy.cmd_ctrl = tmio_nand_hwcontrol;
-	nand_chip->dev_ready = tmio_nand_dev_ready;
+	nand_chip->legacy.dev_ready = tmio_nand_dev_ready;
 	nand_chip->legacy.read_byte = tmio_nand_read_byte;
 	nand_chip->legacy.write_buf = tmio_nand_write_buf;
 	nand_chip->legacy.read_buf = tmio_nand_read_buf;
@@ -432,7 +432,7 @@ static int tmio_probe(struct platform_device *dev)
 	}
 
 	tmio->irq = irq;
-	nand_chip->waitfunc = tmio_nand_wait;
+	nand_chip->legacy.waitfunc = tmio_nand_wait;
 
 	/* Scan to find existence of the device */
 	retval = nand_scan(nand_chip, 1);
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 9eab56a45a5e..46cfb11c5502 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -328,7 +328,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		chip->legacy.read_buf = txx9ndfmc_read_buf;
 		chip->legacy.write_buf = txx9ndfmc_write_buf;
 		chip->legacy.cmd_ctrl = txx9ndfmc_cmd_ctrl;
-		chip->dev_ready = txx9ndfmc_dev_ready;
+		chip->legacy.dev_ready = txx9ndfmc_dev_ready;
 		chip->ecc.calculate = txx9ndfmc_calculate_ecc;
 		chip->ecc.correct = txx9ndfmc_correct_data;
 		chip->ecc.hwctl = txx9ndfmc_enable_hwecc;
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index ef351a4c507f..dcce487f6517 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -175,7 +175,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 	mtd->dev.parent = &pdev->dev;
 
 	data->chip.legacy.cmd_ctrl = xway_cmd_ctrl;
-	data->chip.dev_ready = xway_dev_ready;
+	data->chip.legacy.dev_ready = xway_dev_ready;
 	data->chip.select_chip = xway_select_chip;
 	data->chip.legacy.write_buf = xway_write_buf;
 	data->chip.legacy.read_buf = xway_read_buf;
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index fbfa024f683d..fb28cc6331f2 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -919,7 +919,7 @@ static int spinand_probe(struct spi_device *spi_nand)
 	chip->legacy.write_buf	= spinand_write_buf;
 	chip->legacy.read_byte	= spinand_read_byte;
 	chip->legacy.cmdfunc	= spinand_cmdfunc;
-	chip->waitfunc	= spinand_wait;
+	chip->legacy.waitfunc	= spinand_wait;
 	chip->options	|= NAND_CACHEPRG;
 	chip->select_chip = spinand_select_chip;
 	chip->set_features = nand_get_set_features_notsupp;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5ef2004a37a2..15642c028da2 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1183,6 +1183,10 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * @cmd_ctrl: hardware specific function for controlling ALE/CLE/nCE. Also used
  *	      to write command and address
  * @cmdfunc: hardware specific function for writing commands to the chip.
+ * @dev_ready: hardware specific function for accessing device ready/busy line.
+ *	       If set to NULL no access to ready/busy is available and the
+ *	       ready/busy information is read from the chip status register.
+ * @waitfunc: hardware specific function for wait on ready.
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1197,6 +1201,8 @@ struct nand_legacy {
 	void (*cmd_ctrl)(struct nand_chip *chip, int dat, unsigned int ctrl);
 	void (*cmdfunc)(struct nand_chip *chip, unsigned command, int column,
 			int page_addr);
+	int (*dev_ready)(struct nand_chip *chip);
+	int (*waitfunc)(struct nand_chip *chip);
 };
 
 /**
@@ -1210,16 +1216,10 @@ struct nand_legacy {
  * @select_chip:	[REPLACEABLE] select chip nr
  * @block_bad:		[REPLACEABLE] check if a block is bad, using OOB markers
  * @block_markbad:	[REPLACEABLE] mark a block bad
- * @dev_ready:		[BOARDSPECIFIC] hardwarespecific function for accessing
- *			device ready/busy line. If set to NULL no access to
- *			ready/busy is available and the ready/busy information
- *			is read from the chip status register.
- * @waitfunc:		[REPLACEABLE] hardwarespecific function for wait on
- *			ready.
  * @exec_op:		controller specific method to execute NAND operations.
  *			This method replaces ->cmdfunc(),
- *			->legacy.{read,write}_{buf,byte,word}(), ->dev_ready()
- *			and ->waifunc().
+ *			->legacy.{read,write}_{buf,byte,word}(),
+ *			->legacy.dev_ready() and ->waifunc().
  * @setup_read_retry:	[FLASHSPECIFIC] flash (vendor) specific function for
  *			setting the read-retry mode. Mostly needed for MLC NAND.
  * @ecc:		[BOARDSPECIFIC] ECC control structure
@@ -1305,8 +1305,6 @@ struct nand_chip {
 	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
-	int (*dev_ready)(struct nand_chip *chip);
-	int (*waitfunc)(struct nand_chip *chip);
 	int (*exec_op)(struct nand_chip *chip,
 		       const struct nand_operation *op,
 		       bool check_only);
-- 
2.14.1
