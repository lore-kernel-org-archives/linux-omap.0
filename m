From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 09/19] mtd: rawnand: Deprecate ->chip_delay
Date: Fri,  7 Sep 2018 00:38:41 +0200
Message-ID: <20180906223851.6964-10-boris.brezillon@bootlin.com>
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

The wait timeouts and delays are directly extracted from the NAND
timings and ->chip_delay is only used in legacy path, so let's move it
to the nand_legacy struct to make it clear.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 Documentation/driver-api/mtdnand.rst             |  2 +-
 drivers/mtd/nand/raw/ams-delta.c                 |  2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c     |  2 +-
 drivers/mtd/nand/raw/au1550nd.c                  |  4 ++--
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c |  2 +-
 drivers/mtd/nand/raw/cafe_nand.c                 |  2 +-
 drivers/mtd/nand/raw/cmx270_nand.c               |  2 +-
 drivers/mtd/nand/raw/cs553x_nand.c               |  2 +-
 drivers/mtd/nand/raw/davinci_nand.c              |  2 +-
 drivers/mtd/nand/raw/diskonchip.c                |  4 ++--
 drivers/mtd/nand/raw/fsl_elbc_nand.c             |  4 ++--
 drivers/mtd/nand/raw/fsl_ifc_nand.c              |  4 ++--
 drivers/mtd/nand/raw/fsl_upm.c                   |  2 +-
 drivers/mtd/nand/raw/fsmc_nand.c                 |  1 -
 drivers/mtd/nand/raw/gpio.c                      |  2 +-
 drivers/mtd/nand/raw/hisi504_nand.c              |  2 +-
 drivers/mtd/nand/raw/jz4740_nand.c               |  2 +-
 drivers/mtd/nand/raw/jz4780_nand.c               |  2 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c               |  2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c               |  2 +-
 drivers/mtd/nand/raw/mxc_nand.c                  |  2 +-
 drivers/mtd/nand/raw/nand_base.c                 | 14 +++++++-------
 drivers/mtd/nand/raw/nandsim.c                   |  2 +-
 drivers/mtd/nand/raw/ndfc.c                      |  2 +-
 drivers/mtd/nand/raw/nuc900_nand.c               |  6 +++---
 drivers/mtd/nand/raw/omap2.c                     |  4 ++--
 drivers/mtd/nand/raw/orion_nand.c                |  2 +-
 drivers/mtd/nand/raw/oxnas_nand.c                |  2 +-
 drivers/mtd/nand/raw/pasemi_nand.c               |  2 +-
 drivers/mtd/nand/raw/plat_nand.c                 |  2 +-
 drivers/mtd/nand/raw/s3c2410.c                   |  2 +-
 drivers/mtd/nand/raw/sh_flctl.c                  |  2 +-
 drivers/mtd/nand/raw/sharpsl.c                   |  2 +-
 drivers/mtd/nand/raw/socrates_nand.c             |  2 +-
 drivers/mtd/nand/raw/sunxi_nand.c                |  2 +-
 drivers/mtd/nand/raw/tmio_nand.c                 |  2 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                 |  2 +-
 drivers/mtd/nand/raw/xway_nand.c                 |  2 +-
 include/linux/mtd/rawnand.h                      |  6 +++---
 39 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index 0d3fa4d6576d..55447659b81f 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -240,7 +240,7 @@ necessary information about the device.
         /* Reference hardware control function */
         this->hwcontrol = board_hwcontrol;
         /* Set command delay time, see datasheet for correct value */
-        this->chip_delay = CHIP_DEPENDEND_COMMAND_DELAY;
+        this->legacy.chip_delay = CHIP_DEPENDEND_COMMAND_DELAY;
         /* Assign the device ready function, if available */
         this->legacy.dev_ready = board_dev_ready;
         this->eccmode = NAND_ECC_SOFT;
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 2fa6fa3c7464..3d3786dcc5d1 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -221,7 +221,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
 	}
 	/* 25 us command delay time */
-	this->chip_delay = 30;
+	this->legacy.chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
 	this->ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index dd022080442d..ad0245c66892 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1483,7 +1483,7 @@ static void atmel_nand_init(struct atmel_nand_controller *nc,
 		chip->setup_data_interface = atmel_nand_setup_data_interface;
 
 	/* Some NANDs require a longer delay than the default one (20us). */
-	chip->chip_delay = 40;
+	chip->legacy.chip_delay = 40;
 
 	/*
 	 * Use a bounce buffer when the buffer passed by the MTD user is not
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 81bba469c0e4..9731c1c487f6 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -342,7 +342,7 @@ static void au1550_command(struct nand_chip *this, unsigned command,
 		/* Apply a short delay always to ensure that we do wait tWB. */
 		ndelay(100);
 		/* Wait for a chip to become ready... */
-		for (i = this->chip_delay;
+		for (i = this->legacy.chip_delay;
 		     !this->legacy.dev_ready(this) && i > 0; --i)
 			udelay(1);
 
@@ -434,7 +434,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 	this->legacy.cmdfunc = au1550_command;
 
 	/* 30 us command delay time */
-	this->chip_delay = 30;
+	this->legacy.chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
 	this->ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
index 357bc75948b0..9095a79ebc7d 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c
@@ -393,7 +393,7 @@ int bcm47xxnflash_ops_bcm4706_init(struct bcm47xxnflash *b47n)
 	b47n->nand_chip.legacy.set_features = nand_get_set_features_notsupp;
 	b47n->nand_chip.legacy.get_features = nand_get_set_features_notsupp;
 
-	nand_chip->chip_delay = 50;
+	nand_chip->legacy.chip_delay = 50;
 	b47n->nand_chip.bbt_options = NAND_BBT_USE_FLASH;
 	b47n->nand_chip.ecc.mode = NAND_ECC_NONE; /* TODO: implement ECC */
 
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index e3f702bef549..c1a745940d12 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -712,7 +712,7 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 	cafe->nand.legacy.set_features = nand_get_set_features_notsupp;
 	cafe->nand.legacy.get_features = nand_get_set_features_notsupp;
 
-	cafe->nand.chip_delay = 0;
+	cafe->nand.legacy.chip_delay = 0;
 
 	/* Enable the following for a flash based bad block table */
 	cafe->nand.bbt_options = NAND_BBT_USE_FLASH;
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index 585dbd51d8b1..143e4acacaae 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -179,7 +179,7 @@ static int __init cmx270_init(void)
 	this->legacy.dev_ready = cmx270_device_ready;
 
 	/* 15 us command delay time */
-	this->chip_delay = 20;
+	this->legacy.chip_delay = 20;
 	this->ecc.mode = NAND_ECC_SOFT;
 	this->ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 61ae9e60bf0d..c6f578aff5d9 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -212,7 +212,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	this->legacy.read_buf = cs553x_read_buf;
 	this->legacy.write_buf = cs553x_write_buf;
 
-	this->chip_delay = 0;
+	this->legacy.chip_delay = 0;
 
 	this->ecc.mode = NAND_ECC_HW;
 	this->ecc.size = 256;
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index bae568d68432..80f228d23cd2 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -761,7 +761,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 
 	info->chip.legacy.IO_ADDR_R	= vaddr;
 	info->chip.legacy.IO_ADDR_W	= vaddr;
-	info->chip.chip_delay	= 0;
+	info->chip.legacy.chip_delay	= 0;
 	info->chip.select_chip	= nand_davinci_select_chip;
 
 	/* options such as NAND_BBT_USE_FLASH */
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 16fdfd06ef25..3a4c373affab 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -717,7 +717,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 	case NAND_CMD_RESET:
 		if (this->legacy.dev_ready)
 			break;
-		udelay(this->chip_delay);
+		udelay(this->legacy.chip_delay);
 		WriteDOC(NAND_CMD_STATUS, docptr, Mplus_FlashCmd);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
 		WriteDOC(0, docptr, Mplus_WritePipeTerm);
@@ -731,7 +731,7 @@ static void doc2001plus_command(struct nand_chip *this, unsigned command,
 		 * command delay
 		 */
 		if (!this->legacy.dev_ready) {
-			udelay(this->chip_delay);
+			udelay(this->legacy.chip_delay);
 			return;
 		}
 	}
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index c5f3aa908416..d6ed697fcfe6 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -658,8 +658,8 @@ static int fsl_elbc_attach_chip(struct nand_chip *chip)
 	        chip->chipsize);
 	dev_dbg(priv->dev, "fsl_elbc_init: nand->pagemask = %8x\n",
 	        chip->pagemask);
-	dev_dbg(priv->dev, "fsl_elbc_init: nand->chip_delay = %d\n",
-	        chip->chip_delay);
+	dev_dbg(priv->dev, "fsl_elbc_init: nand->legacy.chip_delay = %d\n",
+	        chip->legacy.chip_delay);
 	dev_dbg(priv->dev, "fsl_elbc_init: nand->badblockpos = %d\n",
 	        chip->badblockpos);
 	dev_dbg(priv->dev, "fsl_elbc_init: nand->chip_shift = %d\n",
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index a303d12079f0..6f4afc44381a 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -727,8 +727,8 @@ static int fsl_ifc_attach_chip(struct nand_chip *chip)
 							chip->chipsize);
 	dev_dbg(priv->dev, "%s: nand->pagemask = %8x\n", __func__,
 							chip->pagemask);
-	dev_dbg(priv->dev, "%s: nand->chip_delay = %d\n", __func__,
-							chip->chip_delay);
+	dev_dbg(priv->dev, "%s: nand->legacy.chip_delay = %d\n", __func__,
+		chip->legacy.chip_delay);
 	dev_dbg(priv->dev, "%s: nand->badblockpos = %d\n", __func__,
 							chip->badblockpos);
 	dev_dbg(priv->dev, "%s: nand->chip_shift = %d\n", __func__,
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index fcb79718b6c3..673c5a0c9345 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -163,7 +163,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	fun->chip.legacy.IO_ADDR_R = fun->io_base;
 	fun->chip.legacy.IO_ADDR_W = fun->io_base;
 	fun->chip.legacy.cmd_ctrl = fun_cmd_ctrl;
-	fun->chip.chip_delay = fun->chip_delay;
+	fun->chip.legacy.chip_delay = fun->chip_delay;
 	fun->chip.legacy.read_byte = fun_read_byte;
 	fun->chip.legacy.read_buf = fun_read_buf;
 	fun->chip.legacy.write_buf = fun_write_buf;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 5e06fce4b295..f9874fc72f30 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1080,7 +1080,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	mtd->dev.parent = &pdev->dev;
 	nand->exec_op = fsmc_exec_op;
 	nand->select_chip = fsmc_select_chip;
-	nand->chip_delay = 30;
 
 	/*
 	 * Setup default ECC mode. nand_dt_init() called from nand_scan_ident()
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index c4f19067702e..a6c9a824a7d4 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -278,7 +278,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip->ecc.mode		= NAND_ECC_SOFT;
 	chip->ecc.algo		= NAND_ECC_HAMMING;
 	chip->options		= gpiomtd->plat.options;
-	chip->chip_delay	= gpiomtd->plat.chip_delay;
+	chip->legacy.chip_delay	= gpiomtd->plat.chip_delay;
 	chip->legacy.cmd_ctrl	= gpio_nand_cmd_ctrl;
 
 	mtd			= nand_to_mtd(chip);
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index fee7d63e8de8..f043938ee36b 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -787,7 +787,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	chip->legacy.read_byte	= hisi_nfc_read_byte;
 	chip->legacy.write_buf	= hisi_nfc_write_buf;
 	chip->legacy.read_buf	= hisi_nfc_read_buf;
-	chip->chip_delay	= HINFC504_CHIP_DELAY;
+	chip->legacy.chip_delay	= HINFC504_CHIP_DELAY;
 	chip->legacy.set_features	= nand_get_set_features_notsupp;
 	chip->legacy.get_features	= nand_get_set_features_notsupp;
 
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 7a1b4c3ff6fd..fb59cfca11a7 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -425,7 +425,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->ecc.strength	= 4;
 	chip->ecc.options	= NAND_ECC_GENERIC_ERASED_CHECK;
 
-	chip->chip_delay = 50;
+	chip->legacy.chip_delay = 50;
 	chip->legacy.cmd_ctrl = jz_nand_cmd_ctrl;
 	chip->select_chip = jz_nand_select_chip;
 	chip->dummy_controller.ops = &jz_nand_controller_ops;
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 2a960211b97d..cdf22100ab77 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -277,7 +277,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 
 	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
 	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
-	chip->chip_delay = RB_DELAY_US;
+	chip->legacy.chip_delay = RB_DELAY_US;
 	chip->options = NAND_NO_SUBPAGE_WRITE;
 	chip->select_chip = jz4780_nand_select_chip;
 	chip->legacy.cmd_ctrl = jz4780_nand_cmd_ctrl;
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 8a1dfb7ee885..abbb655fe154 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -741,7 +741,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	nand_chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	nand_chip->legacy.dev_ready = lpc32xx_nand_device_ready;
-	nand_chip->chip_delay = 25; /* us */
+	nand_chip->legacy.chip_delay = 25; /* us */
 	nand_chip->legacy.IO_ADDR_R = MLC_DATA(host->io_base);
 	nand_chip->legacy.IO_ADDR_W = MLC_DATA(host->io_base);
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 75d62d6bed7b..f2f2cdbb9d04 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -882,7 +882,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	chip->legacy.IO_ADDR_W = SLC_DATA(host->io_base);
 	chip->legacy.cmd_ctrl = lpc32xx_nand_cmd_ctrl;
 	chip->legacy.dev_ready = lpc32xx_nand_device_ready;
-	chip->chip_delay = 20; /* 20us command delay time */
+	chip->legacy.chip_delay = 20; /* 20us command delay time */
 
 	/* Init NAND controller */
 	lpc32xx_nand_setup(host);
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index b8115100a0b8..88bd3f6a499c 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1769,7 +1769,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	mtd->name = DRIVER_NAME;
 
 	/* 50 us command delay time */
-	this->chip_delay = 5;
+	this->legacy.chip_delay = 5;
 
 	nand_set_controller_data(this, host);
 	nand_set_flash_node(this, pdev->dev.of_node),
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d4a84a871fc7..2f8bbc3bca7a 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -827,7 +827,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 	case NAND_CMD_RESET:
 		if (chip->legacy.dev_ready)
 			break;
-		udelay(chip->chip_delay);
+		udelay(chip->legacy.chip_delay);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
 				      NAND_CTRL_CLE | NAND_CTRL_CHANGE);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
@@ -853,7 +853,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		 * command delay
 		 */
 		if (!chip->legacy.dev_ready) {
-			udelay(chip->chip_delay);
+			udelay(chip->legacy.chip_delay);
 			return;
 		}
 	}
@@ -964,7 +964,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 	case NAND_CMD_RESET:
 		if (chip->legacy.dev_ready)
 			break;
-		udelay(chip->chip_delay);
+		udelay(chip->legacy.chip_delay);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_STATUS,
 				      NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
@@ -1005,7 +1005,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		 * command delay.
 		 */
 		if (!chip->legacy.dev_ready) {
-			udelay(chip->chip_delay);
+			udelay(chip->legacy.chip_delay);
 			return;
 		}
 	}
@@ -2206,7 +2206,7 @@ static int nand_wait_rdy_op(struct nand_chip *chip, unsigned int timeout_ms,
 
 	/* Apply delay or wait for ready/busy pin */
 	if (!chip->legacy.dev_ready)
-		udelay(chip->chip_delay);
+		udelay(chip->legacy.chip_delay);
 	else
 		nand_wait_ready(chip);
 
@@ -4926,8 +4926,8 @@ static void nand_set_defaults(struct nand_chip *chip)
 	unsigned int busw = chip->options & NAND_BUSWIDTH_16;
 
 	/* check for proper chip_delay setup, set 20us if not */
-	if (!chip->chip_delay)
-		chip->chip_delay = 20;
+	if (!chip->legacy.chip_delay)
+		chip->legacy.chip_delay = 20;
 
 	/* check, if a user supplied command function given */
 	if (!chip->legacy.cmdfunc && !chip->exec_op)
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index ff0c372ee288..c452819f6123 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -656,7 +656,7 @@ static int __init init_nandsim(struct mtd_info *mtd)
 	}
 
 	/* Force mtd to not do delays */
-	chip->chip_delay = 0;
+	chip->legacy.chip_delay = 0;
 
 	/* Initialize the NAND flash parameters */
 	ns->busw = chip->options & NAND_BUSWIDTH_16 ? 16 : 8;
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 19b4cb2d1c6e..d49a7a17146c 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -147,7 +147,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->legacy.cmd_ctrl = ndfc_hwcontrol;
 	chip->legacy.dev_ready = ndfc_ready;
 	chip->select_chip = ndfc_select_chip;
-	chip->chip_delay = 50;
+	chip->legacy.chip_delay = 50;
 	chip->controller = &ndfc->ndfc_control;
 	chip->legacy.read_buf = ndfc_read_buf;
 	chip->legacy.write_buf = ndfc_write_buf;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 208b6de67510..38b1994e7ed3 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -177,7 +177,7 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 	case NAND_CMD_RESET:
 		if (chip->legacy.dev_ready)
 			break;
-		udelay(chip->chip_delay);
+		udelay(chip->legacy.chip_delay);
 
 		write_cmd_reg(nand, NAND_CMD_STATUS);
 		write_cmd_reg(nand, command);
@@ -197,7 +197,7 @@ static void nuc900_nand_command_lp(struct nand_chip *chip,
 	default:
 
 		if (!chip->legacy.dev_ready) {
-			udelay(chip->chip_delay);
+			udelay(chip->legacy.chip_delay);
 			return;
 		}
 	}
@@ -259,7 +259,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	chip->legacy.read_byte	= nuc900_nand_read_byte;
 	chip->legacy.write_buf	= nuc900_nand_write_buf;
 	chip->legacy.read_buf	= nuc900_nand_read_buf;
-	chip->chip_delay	= 50;
+	chip->legacy.chip_delay	= 50;
 	chip->options		= 0;
 	chip->ecc.mode		= NAND_ECC_SOFT;
 	chip->ecc.algo		= NAND_ECC_HAMMING;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 5e1e7ced0d9e..886d05c391ef 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2248,10 +2248,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 	 */
 	if (info->ready_gpiod) {
 		nand_chip->legacy.dev_ready = omap_dev_ready;
-		nand_chip->chip_delay = 0;
+		nand_chip->legacy.chip_delay = 0;
 	} else {
 		nand_chip->legacy.waitfunc = omap_wait;
-		nand_chip->chip_delay = 50;
+		nand_chip->legacy.chip_delay = 50;
 	}
 
 	if (info->flash_bbt)
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index bf288c3c930b..d27b39a7223c 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -143,7 +143,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	nc->ecc.algo = NAND_ECC_HAMMING;
 
 	if (board->chip_delay)
-		nc->chip_delay = board->chip_delay;
+		nc->legacy.chip_delay = board->chip_delay;
 
 	WARN(board->width > 16,
 		"%d bit bus width out of range",
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index fb0ebb296f6c..0e52dc29141c 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -136,7 +136,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 		chip->legacy.read_buf = oxnas_nand_read_buf;
 		chip->legacy.read_byte = oxnas_nand_read_byte;
 		chip->legacy.write_buf = oxnas_nand_write_buf;
-		chip->chip_delay = 30;
+		chip->legacy.chip_delay = 30;
 
 		/* Scan to find existence of the device */
 		err = nand_scan(chip, 1);
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index e9a4e82bfb34..643cd22af009 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -143,7 +143,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	chip->legacy.dev_ready = pasemi_device_ready;
 	chip->legacy.read_buf = pasemi_read_buf;
 	chip->legacy.write_buf = pasemi_write_buf;
-	chip->chip_delay = 0;
+	chip->legacy.chip_delay = 0;
 	chip->ecc.mode = NAND_ECC_SOFT;
 	chip->ecc.algo = NAND_ECC_HAMMING;
 
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index 6cce01d09364..156c9150fec4 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -67,7 +67,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.select_chip = pdata->ctrl.select_chip;
 	data->chip.legacy.write_buf = pdata->ctrl.write_buf;
 	data->chip.legacy.read_buf = pdata->ctrl.read_buf;
-	data->chip.chip_delay = pdata->chip.chip_delay;
+	data->chip.legacy.chip_delay = pdata->chip.chip_delay;
 	data->chip.options |= pdata->chip.options;
 	data->chip.bbt_options |= pdata->chip.bbt_options;
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 87b5162857f8..d2e42e9d0e8c 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -867,7 +867,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->legacy.write_buf    = s3c2410_nand_write_buf;
 	chip->legacy.read_buf     = s3c2410_nand_read_buf;
 	chip->select_chip  = s3c2410_nand_select_chip;
-	chip->chip_delay   = 50;
+	chip->legacy.chip_delay   = 50;
 	nand_set_controller_data(chip, nmtd);
 	chip->options	   = set->options;
 	chip->controller   = &info->controller;
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 40a4159924a7..c0c0798f268f 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1178,7 +1178,7 @@ static int flctl_probe(struct platform_device *pdev)
 
 	/* Set address of hardware control function */
 	/* 20 us command delay time */
-	nand->chip_delay = 20;
+	nand->legacy.chip_delay = 20;
 
 	nand->legacy.read_byte = flctl_read_byte;
 	nand->legacy.write_buf = flctl_write_buf;
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 3d14408cbbce..c82f26c8b58c 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -159,7 +159,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->legacy.cmd_ctrl = sharpsl_nand_hwcontrol;
 	this->legacy.dev_ready = sharpsl_nand_dev_ready;
 	/* 15 us command delay time */
-	this->chip_delay = 15;
+	this->legacy.chip_delay = 15;
 	/* set eccmode using hardware ECC */
 	this->ecc.mode = NAND_ECC_HW;
 	this->ecc.size = 256;
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index 604ef7508f14..8be9a50c7880 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -162,7 +162,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	nand_chip->ecc.algo = NAND_ECC_HAMMING;
 
 	/* TODO: I have no idea what real delay is. */
-	nand_chip->chip_delay = 20;		/* 20us command delay time */
+	nand_chip->legacy.chip_delay = 20;	/* 20us command delay time */
 
 	dev_set_drvdata(&ofdev->dev, host);
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 37e23aec4bce..51b1a548064b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1912,7 +1912,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 	nand = &chip->nand;
 	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
-	nand->chip_delay = 200;
+	nand->legacy.chip_delay = 200;
 	nand->controller = &nfc->controller;
 	nand->controller->ops = &sunxi_nand_controller_ops;
 
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 7e49272ecef6..3297621241d2 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -422,7 +422,7 @@ static int tmio_probe(struct platform_device *dev)
 		nand_chip->badblock_pattern = data->badblock_pattern;
 
 	/* 15 us command delay time */
-	nand_chip->chip_delay = 15;
+	nand_chip->legacy.chip_delay = 15;
 
 	retval = devm_request_irq(&dev->dev, irq, &tmio_irq, 0,
 				  dev_name(&dev->dev), tmio);
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 46cfb11c5502..3a99c8e3f944 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -334,7 +334,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		chip->ecc.hwctl = txx9ndfmc_enable_hwecc;
 		chip->ecc.mode = NAND_ECC_HW;
 		chip->ecc.strength = 1;
-		chip->chip_delay = 100;
+		chip->legacy.chip_delay = 100;
 		chip->controller = &drvdata->controller;
 
 		nand_set_controller_data(chip, txx9_priv);
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index dcce487f6517..a234a5cb4868 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -180,7 +180,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 	data->chip.legacy.write_buf = xway_write_buf;
 	data->chip.legacy.read_buf = xway_read_buf;
 	data->chip.legacy.read_byte = xway_read_byte;
-	data->chip.chip_delay = 30;
+	data->chip.legacy.chip_delay = 30;
 
 	data->chip.ecc.mode = NAND_ECC_SOFT;
 	data->chip.ecc.algo = NAND_ECC_HAMMING;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 02ac70a30c63..992d78d29674 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1192,6 +1192,8 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
  * @erase: erase function
  * @set_features: set the NAND chip features
  * @get_features: get the NAND chip features
+ * @chip_delay: chip dependent delay for transferring data from array to read
+ *		regs (tR).
  *
  * If you look at this structure you're already wrong. These fields/hooks are
  * all deprecated.
@@ -1215,6 +1217,7 @@ struct nand_legacy {
 			    u8 *subfeature_para);
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
 			    u8 *subfeature_para);
+	int chip_delay;
 };
 
 /**
@@ -1236,8 +1239,6 @@ struct nand_legacy {
  * @buf_align:		minimum buffer alignment required by a platform
  * @dummy_controller:	dummy controller implementation for drivers that can
  *			only control a single chip
- * @chip_delay:		[BOARDSPECIFIC] chip dependent delay for transferring
- *			data from array to read regs (tR).
  * @state:		[INTERN] the current state of the NAND device
  * @oob_poi:		"poison value buffer," used for laying out OOB data
  *			before writing
@@ -1317,7 +1318,6 @@ struct nand_chip {
 	int (*setup_data_interface)(struct nand_chip *chip, int chipnr,
 				    const struct nand_data_interface *conf);
 
-	int chip_delay;
 	unsigned int options;
 	unsigned int bbt_options;
 
-- 
2.14.1
