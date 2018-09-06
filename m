From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 03/23] mtd: rawnand: Pass a nand_chip object to
 nand_release()
Date: Thu,  6 Sep 2018 14:05:15 +0200
Message-ID: <20180906120535.21255-4-boris.brezillon@bootlin.com>
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

Now is nand_release()'s turn.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 Documentation/driver-api/mtdnand.rst       | 2 +-
 drivers/mtd/nand/raw/ams-delta.c           | 2 +-
 drivers/mtd/nand/raw/au1550nd.c            | 2 +-
 drivers/mtd/nand/raw/bcm47xxnflash/main.c  | 2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c   | 2 +-
 drivers/mtd/nand/raw/cafe_nand.c           | 2 +-
 drivers/mtd/nand/raw/cmx270_nand.c         | 2 +-
 drivers/mtd/nand/raw/cs553x_nand.c         | 2 +-
 drivers/mtd/nand/raw/davinci_nand.c        | 2 +-
 drivers/mtd/nand/raw/denali.c              | 4 +---
 drivers/mtd/nand/raw/diskonchip.c          | 4 ++--
 drivers/mtd/nand/raw/docg4.c               | 2 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c       | 3 +--
 drivers/mtd/nand/raw/fsl_ifc_nand.c        | 3 +--
 drivers/mtd/nand/raw/fsl_upm.c             | 2 +-
 drivers/mtd/nand/raw/fsmc_nand.c           | 2 +-
 drivers/mtd/nand/raw/gpio.c                | 2 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/nand/raw/hisi504_nand.c        | 3 +--
 drivers/mtd/nand/raw/jz4740_nand.c         | 2 +-
 drivers/mtd/nand/raw/jz4780_nand.c         | 4 ++--
 drivers/mtd/nand/raw/lpc32xx_mlc.c         | 3 +--
 drivers/mtd/nand/raw/lpc32xx_slc.c         | 3 +--
 drivers/mtd/nand/raw/marvell_nand.c        | 4 ++--
 drivers/mtd/nand/raw/mpc5121_nfc.c         | 2 +-
 drivers/mtd/nand/raw/mtk_nand.c            | 4 ++--
 drivers/mtd/nand/raw/mxc_nand.c            | 2 +-
 drivers/mtd/nand/raw/nand_base.c           | 8 ++++----
 drivers/mtd/nand/raw/nandsim.c             | 4 ++--
 drivers/mtd/nand/raw/ndfc.c                | 2 +-
 drivers/mtd/nand/raw/nuc900_nand.c         | 2 +-
 drivers/mtd/nand/raw/omap2.c               | 2 +-
 drivers/mtd/nand/raw/orion_nand.c          | 5 ++---
 drivers/mtd/nand/raw/oxnas_nand.c          | 4 ++--
 drivers/mtd/nand/raw/pasemi_nand.c         | 2 +-
 drivers/mtd/nand/raw/plat_nand.c           | 4 ++--
 drivers/mtd/nand/raw/qcom_nandc.c          | 2 +-
 drivers/mtd/nand/raw/r852.c                | 4 ++--
 drivers/mtd/nand/raw/s3c2410.c             | 2 +-
 drivers/mtd/nand/raw/sh_flctl.c            | 2 +-
 drivers/mtd/nand/raw/sharpsl.c             | 4 ++--
 drivers/mtd/nand/raw/socrates_nand.c       | 5 ++---
 drivers/mtd/nand/raw/sunxi_nand.c          | 4 ++--
 drivers/mtd/nand/raw/tango_nand.c          | 2 +-
 drivers/mtd/nand/raw/tmio_nand.c           | 4 ++--
 drivers/mtd/nand/raw/txx9ndfmc.c           | 2 +-
 drivers/mtd/nand/raw/vf610_nfc.c           | 2 +-
 drivers/mtd/nand/raw/xway_nand.c           | 4 ++--
 include/linux/mtd/rawnand.h                | 2 +-
 49 files changed, 66 insertions(+), 75 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index 1ab6f35b6410..5470a3d6bd9e 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -277,7 +277,7 @@ unregisters the partitions in the MTD layer.
     static void __exit board_cleanup (void)
     {
         /* Release resources, unregister device */
-        nand_release (board_mtd);
+        nand_release (mtd_to_nand(board_mtd));
 
         /* unmap physical address */
         iounmap(baseaddr);
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 24ba7296ec08..acf7971e815d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -264,7 +264,7 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	void __iomem *io_base = platform_get_drvdata(pdev);
 
 	/* Release resources, unregister device */
-	nand_release(ams_delta_mtd);
+	nand_release(mtd_to_nand(ams_delta_mtd));
 
 	gpio_free_array(_mandatory_gpio, ARRAY_SIZE(_mandatory_gpio));
 	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index 614f5d447ba5..d277a141c7d3 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -477,7 +477,7 @@ static int au1550nd_remove(struct platform_device *pdev)
 	struct au1550nd_ctx *ctx = platform_get_drvdata(pdev);
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	nand_release(nand_to_mtd(&ctx->chip));
+	nand_release(&ctx->chip);
 	iounmap(ctx->base);
 	release_mem_region(r->start, 0x1000);
 	kfree(ctx);
diff --git a/drivers/mtd/nand/raw/bcm47xxnflash/main.c b/drivers/mtd/nand/raw/bcm47xxnflash/main.c
index fb31429b70a9..d79694160845 100644
--- a/drivers/mtd/nand/raw/bcm47xxnflash/main.c
+++ b/drivers/mtd/nand/raw/bcm47xxnflash/main.c
@@ -65,7 +65,7 @@ static int bcm47xxnflash_remove(struct platform_device *pdev)
 {
 	struct bcm47xxnflash *nflash = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&nflash->nand_chip));
+	nand_release(&nflash->nand_chip);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index a9a94c102654..19e6e918f896 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2616,7 +2616,7 @@ int brcmnand_remove(struct platform_device *pdev)
 	struct brcmnand_host *host;
 
 	list_for_each_entry(host, &ctrl->host_list, node)
-		nand_release(nand_to_mtd(&host->chip));
+		nand_release(&host->chip);
 
 	clk_disable_unprepare(ctrl->clk);
 
diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index e497b95d624e..3304594177c6 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -819,7 +819,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
 	free_irq(pdev->irq, mtd);
-	nand_release(mtd);
+	nand_release(chip);
 	free_rs(cafe->rs);
 	pci_iounmap(pdev, cafe->mmio);
 	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
diff --git a/drivers/mtd/nand/raw/cmx270_nand.c b/drivers/mtd/nand/raw/cmx270_nand.c
index e92c0f113eb3..2eb933a8f99e 100644
--- a/drivers/mtd/nand/raw/cmx270_nand.c
+++ b/drivers/mtd/nand/raw/cmx270_nand.c
@@ -228,7 +228,7 @@ module_init(cmx270_init);
 static void __exit cmx270_cleanup(void)
 {
 	/* Release resources, unregister device */
-	nand_release(cmx270_nand_mtd);
+	nand_release(mtd_to_nand(cmx270_nand_mtd));
 
 	gpio_free(GPIO_NAND_RB);
 	gpio_free(GPIO_NAND_CS);
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 4065bcd12e64..d4be416bb2fa 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -336,7 +336,7 @@ static void __exit cs553x_cleanup(void)
 		mmio_base = this->IO_ADDR_R;
 
 		/* Release resources, unregister device */
-		nand_release(mtd);
+		nand_release(this);
 		kfree(mtd->name);
 		cs553x_mtd[i] = NULL;
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 1021624195f7..66d3d5966013 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -841,7 +841,7 @@ static int nand_davinci_remove(struct platform_device *pdev)
 		ecc4_busy = false;
 	spin_unlock_irq(&davinci_nand_lock);
 
-	nand_release(nand_to_mtd(&info->chip));
+	nand_release(&info->chip);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 2e8a825c740e..958619fd4d1b 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1378,9 +1378,7 @@ EXPORT_SYMBOL(denali_init);
 
 void denali_remove(struct denali_nand_info *denali)
 {
-	struct mtd_info *mtd = nand_to_mtd(&denali->nand);
-
-	nand_release(mtd);
+	nand_release(&denali->nand);
 	denali_disable_irq(denali);
 }
 EXPORT_SYMBOL(denali_remove);
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 9159748a2ef0..43d1e08133ce 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1627,7 +1627,7 @@ static int __init doc_probe(unsigned long physadr)
 		/* nand_release will call mtd_device_unregister, but we
 		   haven't yet added it.  This is handled without incident by
 		   mtd_device_unregister, as far as I can tell. */
-		nand_release(mtd);
+		nand_release(nand);
 		goto fail;
 	}
 
@@ -1662,7 +1662,7 @@ static void release_nanddoc(void)
 		doc = nand_get_controller_data(nand);
 
 		nextmtd = doc->nextdoc;
-		nand_release(mtd);
+		nand_release(nand);
 		iounmap(doc->virtadr);
 		release_mem_region(doc->physadr, DOC_IOREMAP_LEN);
 		free_rs(doc->rs_decoder);
diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 69f60755f38a..2d86bc5a886d 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1420,7 +1420,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 static int __exit cleanup_docg4(struct platform_device *pdev)
 {
 	struct docg4_priv *doc = platform_get_drvdata(pdev);
-	nand_release(doc->mtd);
+	nand_release(mtd_to_nand(doc->mtd));
 	kfree(mtd_to_nand(doc->mtd));
 	iounmap(doc->virtadr);
 	return 0;
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 541343d142e0..22bcd64a66c8 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -942,9 +942,8 @@ static int fsl_elbc_nand_remove(struct platform_device *pdev)
 {
 	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = fsl_lbc_ctrl_dev->nand;
 	struct fsl_elbc_mtd *priv = dev_get_drvdata(&pdev->dev);
-	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
 
-	nand_release(mtd);
+	nand_release(&priv->chip);
 	fsl_elbc_chip_remove(priv);
 
 	mutex_lock(&fsl_elbc_nand_mutex);
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index ad010c72df78..70bf8e1552a5 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -1105,9 +1105,8 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
 static int fsl_ifc_nand_remove(struct platform_device *dev)
 {
 	struct fsl_ifc_mtd *priv = dev_get_drvdata(&dev->dev);
-	struct mtd_info *mtd = nand_to_mtd(&priv->chip);
 
-	nand_release(mtd);
+	nand_release(&priv->chip);
 	fsl_ifc_chip_remove(priv);
 
 	mutex_lock(&fsl_ifc_nand_mutex);
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 99edae365d16..ffddfc9721ac 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -326,7 +326,7 @@ static int fun_remove(struct platform_device *ofdev)
 	struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 	int i;
 
-	nand_release(mtd);
+	nand_release(&fun->chip);
 	kfree(mtd->name);
 
 	for (i = 0; i < fun->mchip_count; i++) {
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 9991e3b8e237..25d354e9448e 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1161,7 +1161,7 @@ static int fsmc_nand_remove(struct platform_device *pdev)
 	struct fsmc_nand_data *host = platform_get_drvdata(pdev);
 
 	if (host) {
-		nand_release(nand_to_mtd(&host->nand));
+		nand_release(&host->nand);
 
 		if (host->mode == USE_DMA_ACCESS) {
 			dma_release_channel(host->write_dma_chan);
diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 983d3be48019..0e7d00faf33c 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -194,7 +194,7 @@ static int gpio_nand_remove(struct platform_device *pdev)
 {
 	struct gpiomtd *gpiomtd = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&gpiomtd->nand_chip));
+	nand_release(&gpiomtd->nand_chip);
 
 	/* Enable write protection and disable the chip */
 	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 7af207bc3ab5..fe99d9323d4a 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2026,7 +2026,7 @@ static int gpmi_nand_remove(struct platform_device *pdev)
 {
 	struct gpmi_nand_data *this = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&this->nand));
+	nand_release(&this->nand);
 	gpmi_free_dma_buffer(this);
 	release_resources(this);
 	return 0;
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 81baa2e6ae56..9106a1d60bca 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -818,9 +818,8 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 static int hisi_nfc_remove(struct platform_device *pdev)
 {
 	struct hinfc_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = nand_to_mtd(&host->chip);
 
-	nand_release(mtd);
+	nand_release(&host->chip);
 
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 75bb26645c82..27603d78b157 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -507,7 +507,7 @@ static int jz_nand_remove(struct platform_device *pdev)
 	struct jz_nand *nand = platform_get_drvdata(pdev);
 	size_t i;
 
-	nand_release(nand_to_mtd(&nand->chip));
+	nand_release(&nand->chip);
 
 	/* Deassert and disable all chips */
 	writel(0, nand->base + JZ_REG_NAND_CTRL);
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 80f29b28bcc4..7d008aeae165 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -292,7 +292,7 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
-		nand_release(mtd);
+		nand_release(chip);
 		return ret;
 	}
 
@@ -307,7 +307,7 @@ static void jz4780_nand_cleanup_chips(struct jz4780_nand_controller *nfc)
 
 	while (!list_empty(&nfc->chips)) {
 		chip = list_first_entry(&nfc->chips, struct jz4780_nand_chip, chip_list);
-		nand_release(nand_to_mtd(&chip->chip));
+		nand_release(&chip->chip);
 		list_del(&chip->chip_list);
 	}
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 453a83b82d73..d240b8ff40ca 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -839,9 +839,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
-	nand_release(mtd);
+	nand_release(&host->nand_chip);
 	free_irq(host->irq, host);
 	if (use_dma)
 		dma_release_channel(host->dma_chan);
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index ad6eff0591d2..607e4bdfae03 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -956,9 +956,8 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	uint32_t tmp;
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
-	nand_release(mtd);
+	nand_release(&host->nand_chip);
 	dma_release_channel(host->dma_chan);
 
 	/* Force CE high */
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index dde64609415f..5a9836c5093c 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2618,7 +2618,7 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_release(mtd);
+		nand_release(chip);
 		return ret;
 	}
 
@@ -2673,7 +2673,7 @@ static void marvell_nand_chips_cleanup(struct marvell_nfc *nfc)
 	struct marvell_nand_chip *entry, *temp;
 
 	list_for_each_entry_safe(entry, temp, &nfc->chips, node) {
-		nand_release(nand_to_mtd(&entry->chip));
+		nand_release(&entry->chip);
 		list_del(&entry->node);
 	}
 }
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index efaaec462bd7..3c90d6955476 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -817,7 +817,7 @@ static int mpc5121_nfc_remove(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 
-	nand_release(mtd);
+	nand_release(mtd_to_nand(mtd));
 	mpc5121_nfc_free(dev, mtd);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 7a2ce405f914..46d447f148f1 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1372,7 +1372,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "mtd parse partition error\n");
-		nand_release(mtd);
+		nand_release(nand);
 		return ret;
 	}
 
@@ -1538,7 +1538,7 @@ static int mtk_nfc_remove(struct platform_device *pdev)
 	while (!list_empty(&nfc->chips)) {
 		chip = list_first_entry(&nfc->chips, struct mtk_nfc_nand_chip,
 					node);
-		nand_release(nand_to_mtd(&chip->nand));
+		nand_release(&chip->nand);
 		list_del(&chip->node);
 	}
 
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 1ca03d88adf1..3c57e14e1c7c 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1915,7 +1915,7 @@ static int mxcnd_remove(struct platform_device *pdev)
 {
 	struct mxc_nand_host *host = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&host->nand));
+	nand_release(&host->nand);
 	if (host->clk_act)
 		clk_disable_unprepare(host->clk);
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 974cbfbde5e2..f937efe145af 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6853,12 +6853,12 @@ EXPORT_SYMBOL_GPL(nand_cleanup);
 /**
  * nand_release - [NAND Interface] Unregister the MTD device and free resources
  *		  held by the NAND device
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  */
-void nand_release(struct mtd_info *mtd)
+void nand_release(struct nand_chip *chip)
 {
-	mtd_device_unregister(mtd);
-	nand_cleanup(mtd_to_nand(mtd));
+	mtd_device_unregister(nand_to_mtd(chip));
+	nand_cleanup(chip);
 }
 EXPORT_SYMBOL_GPL(nand_release);
 
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 60761175e531..e9f7b9e1aead 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -2354,7 +2354,7 @@ static int __init ns_init_module(void)
 
 err_exit:
 	free_nandsim(nand);
-	nand_release(nsmtd);
+	nand_release(chip);
 	for (i = 0;i < ARRAY_SIZE(nand->partitions); ++i)
 		kfree(nand->partitions[i].name);
 error:
@@ -2376,7 +2376,7 @@ static void __exit ns_cleanup_module(void)
 	int i;
 
 	free_nandsim(ns);    /* Free nandsim private resources */
-	nand_release(nsmtd); /* Unregister driver */
+	nand_release(chip); /* Unregister driver */
 	for (i = 0;i < ARRAY_SIZE(ns->partitions); ++i)
 		kfree(ns->partitions[i].name);
 	kfree(mtd_to_nand(nsmtd));        /* Free other structures */
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 7ce7f37dc67a..ab24e9ca769b 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -258,7 +258,7 @@ static int ndfc_remove(struct platform_device *ofdev)
 	struct ndfc_controller *ndfc = dev_get_drvdata(&ofdev->dev);
 	struct mtd_info *mtd = nand_to_mtd(&ndfc->chip);
 
-	nand_release(mtd);
+	nand_release(&ndfc->chip);
 	kfree(mtd->name);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
index 41ed993b9523..0c675b6c0b6e 100644
--- a/drivers/mtd/nand/raw/nuc900_nand.c
+++ b/drivers/mtd/nand/raw/nuc900_nand.c
@@ -284,7 +284,7 @@ static int nuc900_nand_remove(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&nuc900_nand->chip));
+	nand_release(&nuc900_nand->chip);
 	clk_disable(nuc900_nand->clk);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index c2aff2492fa1..b243f2ab3622 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2290,7 +2290,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	}
 	if (info->dma)
 		dma_release_channel(info->dma);
-	nand_release(mtd);
+	nand_release(nand_chip);
 	return 0;
 }
 
diff --git a/drivers/mtd/nand/raw/orion_nand.c b/drivers/mtd/nand/raw/orion_nand.c
index 256a6b018bdc..5c58d91ffaee 100644
--- a/drivers/mtd/nand/raw/orion_nand.c
+++ b/drivers/mtd/nand/raw/orion_nand.c
@@ -181,7 +181,7 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 	mtd->name = "orion_nand";
 	ret = mtd_device_register(mtd, board->parts, board->nr_parts);
 	if (ret) {
-		nand_release(mtd);
+		nand_release(nc);
 		goto no_dev;
 	}
 
@@ -196,9 +196,8 @@ static int orion_nand_remove(struct platform_device *pdev)
 {
 	struct orion_nand_info *info = platform_get_drvdata(pdev);
 	struct nand_chip *chip = &info->chip;
-	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	nand_release(mtd);
+	nand_release(chip);
 
 	clk_disable_unprepare(info->clk);
 
diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/oxnas_nand.c
index 9aeb024c2a0e..5bc180536320 100644
--- a/drivers/mtd/nand/raw/oxnas_nand.c
+++ b/drivers/mtd/nand/raw/oxnas_nand.c
@@ -148,7 +148,7 @@ static int oxnas_nand_probe(struct platform_device *pdev)
 
 		err = mtd_device_register(mtd, NULL, 0);
 		if (err) {
-			nand_release(mtd);
+			nand_release(chip);
 			goto err_clk_unprepare;
 		}
 
@@ -176,7 +176,7 @@ static int oxnas_nand_remove(struct platform_device *pdev)
 	struct oxnas_nand_ctrl *oxnas = platform_get_drvdata(pdev);
 
 	if (oxnas->chips[0])
-		nand_release(nand_to_mtd(oxnas->chips[0]));
+		nand_release(oxnas->chips[0]);
 
 	clk_disable_unprepare(oxnas->clk);
 
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index eca4e41d2be3..c8e2ac04fb86 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -191,7 +191,7 @@ static int pasemi_nand_remove(struct platform_device *ofdev)
 	chip = mtd_to_nand(pasemi_nand_mtd);
 
 	/* Release resources, unregister device */
-	nand_release(pasemi_nand_mtd);
+	nand_release(chip);
 
 	release_region(lpcctl, 4);
 
diff --git a/drivers/mtd/nand/raw/plat_nand.c b/drivers/mtd/nand/raw/plat_nand.c
index c9a23fb21718..80e1a44f0465 100644
--- a/drivers/mtd/nand/raw/plat_nand.c
+++ b/drivers/mtd/nand/raw/plat_nand.c
@@ -144,7 +144,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 	if (!err)
 		return err;
 
-	nand_release(mtd);
+	nand_release(&data->chip);
 out:
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
@@ -159,7 +159,7 @@ static int plat_nand_remove(struct platform_device *pdev)
 	struct plat_nand_data *data = platform_get_drvdata(pdev);
 	struct platform_nand_data *pdata = dev_get_platdata(&pdev->dev);
 
-	nand_release(nand_to_mtd(&data->chip));
+	nand_release(&data->chip);
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
 
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index d800347e74da..312cfd786b0f 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2999,7 +2999,7 @@ static int qcom_nandc_remove(struct platform_device *pdev)
 	struct qcom_nand_host *host;
 
 	list_for_each_entry(host, &nandc->host_list, node)
-		nand_release(nand_to_mtd(&host->chip));
+		nand_release(&host->chip);
 
 
 	qcom_nandc_unalloc(nandc);
diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index dcdeb0660e5e..bb74a0ac697e 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -656,7 +656,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 	dev->card_registred = 1;
 	return 0;
 error3:
-	nand_release(mtd);
+	nand_release(dev->chip);
 error1:
 	/* Force card redetect */
 	dev->card_detected = 0;
@@ -675,7 +675,7 @@ static void r852_unregister_nand_device(struct r852_device *dev)
 		return;
 
 	device_remove_file(&mtd->dev, &dev_attr_media_type);
-	nand_release(mtd);
+	nand_release(dev->chip);
 	r852_engine_disable(dev);
 	dev->card_registred = 0;
 }
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 7f30d801d642..cf045813c160 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -781,7 +781,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
 
 		for (mtdno = 0; mtdno < info->mtd_count; mtdno++, ptr++) {
 			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
-			nand_release(nand_to_mtd(&ptr->chip));
+			nand_release(&ptr->chip);
 		}
 	}
 
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index abcc3be89b89..2580fd981077 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1216,7 +1216,7 @@ static int flctl_remove(struct platform_device *pdev)
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
 	flctl_release_dma(flctl);
-	nand_release(nand_to_mtd(&flctl->chip));
+	nand_release(&flctl->chip);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 4afacb0dcf00..c8eb4654bb1c 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -187,7 +187,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(mtd);
+	nand_release(this);
 
 err_scan:
 	iounmap(sharpsl->io);
@@ -205,7 +205,7 @@ static int sharpsl_nand_remove(struct platform_device *pdev)
 	struct sharpsl_nand *sharpsl = platform_get_drvdata(pdev);
 
 	/* Release resources, unregister device */
-	nand_release(nand_to_mtd(&sharpsl->chip));
+	nand_release(&sharpsl->chip);
 
 	iounmap(sharpsl->io);
 
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index e335560f87af..82ba371a8e18 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -181,7 +181,7 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 	if (!res)
 		return res;
 
-	nand_release(mtd);
+	nand_release(nand_chip);
 
 out:
 	iounmap(host->io_base);
@@ -194,9 +194,8 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 static int socrates_nand_remove(struct platform_device *ofdev)
 {
 	struct socrates_nand_host *host = dev_get_drvdata(&ofdev->dev);
-	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
-	nand_release(mtd);
+	nand_release(&host->nand_chip);
 
 	iounmap(host->io_base);
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 179f74b6edf6..e31ab86bebee 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1947,7 +1947,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-		nand_release(mtd);
+		nand_release(nand);
 		return ret;
 	}
 
@@ -1986,7 +1986,7 @@ static void sunxi_nand_chips_cleanup(struct sunxi_nfc *nfc)
 	while (!list_empty(&nfc->chips)) {
 		chip = list_first_entry(&nfc->chips, struct sunxi_nand_chip,
 					node);
-		nand_release(nand_to_mtd(&chip->nand));
+		nand_release(&chip->nand);
 		sunxi_nand_ecc_cleanup(&chip->nand.ecc);
 		list_del(&chip->node);
 	}
diff --git a/drivers/mtd/nand/raw/tango_nand.c b/drivers/mtd/nand/raw/tango_nand.c
index 45beb87aec93..1061eb60ee60 100644
--- a/drivers/mtd/nand/raw/tango_nand.c
+++ b/drivers/mtd/nand/raw/tango_nand.c
@@ -617,7 +617,7 @@ static int tango_nand_remove(struct platform_device *pdev)
 
 	for (cs = 0; cs < MAX_CS; ++cs) {
 		if (nfc->chips[cs])
-			nand_release(nand_to_mtd(&nfc->chips[cs]->nand_chip));
+			nand_release(&nfc->chips[cs]->nand_chip);
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 6df499a239ae..39594910e6f0 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -449,7 +449,7 @@ static int tmio_probe(struct platform_device *dev)
 	if (!retval)
 		return retval;
 
-	nand_release(mtd);
+	nand_release(nand_chip);
 
 err_irq:
 	tmio_hw_stop(dev, tmio);
@@ -460,7 +460,7 @@ static int tmio_remove(struct platform_device *dev)
 {
 	struct tmio_nand *tmio = platform_get_drvdata(dev);
 
-	nand_release(nand_to_mtd(&tmio->chip));
+	nand_release(&tmio->chip);
 	tmio_hw_stop(dev, tmio);
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 169e8bcee61e..f722aae2b244 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -390,7 +390,7 @@ static int __exit txx9ndfmc_remove(struct platform_device *dev)
 		chip = mtd_to_nand(mtd);
 		txx9_priv = nand_get_controller_data(chip);
 
-		nand_release(mtd);
+		nand_release(chip);
 		kfree(txx9_priv->mtdname);
 		kfree(txx9_priv);
 	}
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 3b486f4ce868..a73213c835a5 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -916,7 +916,7 @@ static int vf610_nfc_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
 
-	nand_release(mtd);
+	nand_release(mtd_to_nand(mtd));
 	clk_disable_unprepare(nfc->clk);
 	return 0;
 }
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index e670d3b5a646..1adb41acebfc 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -211,7 +211,7 @@ static int xway_nand_probe(struct platform_device *pdev)
 
 	err = mtd_device_register(mtd, NULL, 0);
 	if (err)
-		nand_release(mtd);
+		nand_release(&data->chip);
 
 	return err;
 }
@@ -223,7 +223,7 @@ static int xway_nand_remove(struct platform_device *pdev)
 {
 	struct xway_nand_data *data = platform_get_drvdata(pdev);
 
-	nand_release(nand_to_mtd(&data->chip));
+	nand_release(&data->chip);
 
 	return 0;
 }
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 733b228d94a5..e9c59f0624ad 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1739,7 +1739,7 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
  */
 void nand_cleanup(struct nand_chip *chip);
 /* Unregister the MTD device and calls nand_cleanup() */
-void nand_release(struct mtd_info *mtd);
+void nand_release(struct nand_chip *chip);
 
 /* Default extended ID decoding function */
 void nand_decode_ext_id(struct nand_chip *chip);
-- 
2.14.1
