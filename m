From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 50/58] mtd: nand: remove useless mtd->priv =
 chip assignments
Date: Thu, 10 Dec 2015 09:00:34 +0100
Message-ID: <1449734442-18672-51-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBTXGUSZQKGQER34QBHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Krzysztof Halasa <khalasa-NlWvg49iv0c@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>a
List-Id: linux-omap@vger.kernel.org

mtd_to_nand() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info m;
struct mtd_info *mp;
struct nand_chip *c;
@@
(
-(m).priv = c;
|
-(mp)->priv = c;
|
-(mp)->priv = (void *)c;
)
---8<----
---
 drivers/mtd/nand/ams-delta.c           | 3 ---
 drivers/mtd/nand/atmel_nand.c          | 1 -
 drivers/mtd/nand/au1550nd.c            | 1 -
 drivers/mtd/nand/bcm47xxnflash/main.c  | 1 -
 drivers/mtd/nand/bf5xx_nand.c          | 1 -
 drivers/mtd/nand/brcmnand/brcmnand.c   | 1 -
 drivers/mtd/nand/cafe_nand.c           | 1 -
 drivers/mtd/nand/cmx270_nand.c         | 1 -
 drivers/mtd/nand/cs553x_nand.c         | 1 -
 drivers/mtd/nand/davinci_nand.c        | 1 -
 drivers/mtd/nand/denali.c              | 1 -
 drivers/mtd/nand/diskonchip.c          | 1 -
 drivers/mtd/nand/docg4.c               | 1 -
 drivers/mtd/nand/fsl_elbc_nand.c       | 1 -
 drivers/mtd/nand/fsl_ifc_nand.c        | 1 -
 drivers/mtd/nand/fsl_upm.c             | 1 -
 drivers/mtd/nand/fsmc_nand.c           | 1 -
 drivers/mtd/nand/gpio.c                | 1 -
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 1 -
 drivers/mtd/nand/hisi504_nand.c        | 1 -
 drivers/mtd/nand/jz4740_nand.c         | 1 -
 drivers/mtd/nand/lpc32xx_mlc.c         | 1 -
 drivers/mtd/nand/lpc32xx_slc.c         | 1 -
 drivers/mtd/nand/mpc5121_nfc.c         | 1 -
 drivers/mtd/nand/mxc_nand.c            | 1 -
 drivers/mtd/nand/nandsim.c             | 1 -
 drivers/mtd/nand/ndfc.c                | 1 -
 drivers/mtd/nand/nuc900_nand.c         | 1 -
 drivers/mtd/nand/omap2.c               | 1 -
 drivers/mtd/nand/orion_nand.c          | 1 -
 drivers/mtd/nand/pasemi_nand.c         | 1 -
 drivers/mtd/nand/plat_nand.c           | 1 -
 drivers/mtd/nand/pxa3xx_nand.c         | 1 -
 drivers/mtd/nand/r852.c                | 1 -
 drivers/mtd/nand/s3c2410.c             | 2 --
 drivers/mtd/nand/sh_flctl.c            | 1 -
 drivers/mtd/nand/sharpsl.c             | 1 -
 drivers/mtd/nand/socrates_nand.c       | 1 -
 drivers/mtd/nand/sunxi_nand.c          | 1 -
 drivers/mtd/nand/tmio_nand.c           | 1 -
 drivers/mtd/nand/txx9ndfmc.c           | 2 --
 drivers/mtd/nand/vf610_nfc.c           | 1 -
 42 files changed, 46 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 0f638c6..1a18938 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -193,9 +193,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	ams_delta_mtd = nand_to_mtd(this);
 	ams_delta_mtd->owner = THIS_MODULE;
 
-	/* Link the private data with the MTD structure */
-	ams_delta_mtd->priv = this;
-
 	/*
 	 * Don't try to request the memory region from here,
 	 * it should have been already requested from the
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 9ba2831..18c4e14 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -2128,7 +2128,6 @@ static int atmel_nand_probe(struct platform_device *pdev)
 	}
 
 	nand_chip->priv = host;		/* link the private data structures */
-	mtd->priv = nand_chip;
 	mtd->dev.parent = &pdev->dev;
 
 	/* Set address of NAND IO lines */
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 280e5b6..341ea49 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -441,7 +441,6 @@ static int au1550nd_probe(struct platform_device *pdev)
 
 	this = &ctx->chip;
 	mtd = nand_to_mtd(this);
-	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 
 	/* figure out which CS# r->start belongs to */
diff --git a/drivers/mtd/nand/bcm47xxnflash/main.c b/drivers/mtd/nand/bcm47xxnflash/main.c
index 4711ca2b..0f0a798 100644
--- a/drivers/mtd/nand/bcm47xxnflash/main.c
+++ b/drivers/mtd/nand/bcm47xxnflash/main.c
@@ -37,7 +37,6 @@ static int bcm47xxnflash_probe(struct platform_device *pdev)
 	b47n->nand_chip.priv = b47n;
 	mtd = nand_to_mtd(&b47n->nand_chip);
 	mtd->dev.parent = &pdev->dev;
-	mtd->priv = &b47n->nand_chip; /* Required */
 	b47n->cc = container_of(nflash, struct bcma_drv_cc, nflash);
 
 	if (b47n->cc->core->bus->chipinfo.id == BCMA_CHIP_ID_BCM4706) {
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 928d599..9514e13 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -782,7 +782,6 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->chip_delay   = 0;
 
 	/* initialise mtd info data struct */
-	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 
 	/* initialise the hardware */
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 26b64bc..4097b57 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1920,7 +1920,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
 	nand_set_flash_node(chip, dn);
 	chip->priv = host;
-	mtd->priv = chip;
 	mtd->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "brcmnand.%d",
 				   host->cs);
 	mtd->owner = THIS_MODULE;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 7d6a142..00c15e2 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -611,7 +611,6 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
-	mtd->priv = &cafe->nand;
 	cafe->nand.priv = cafe;
 
 	cafe->pdev = pdev;
diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index 6b26e0c..ca4bd3648 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -177,7 +177,6 @@ static int __init cmx270_init(void)
 
 	/* Link the private data with the MTD structure */
 	cmx270_nand_mtd->owner = THIS_MODULE;
-	cmx270_nand_mtd->priv = this;
 
 	/* insert callbacks */
 	this->IO_ADDR_R = cmx270_nand_io;
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 386ae83..a65e4e0 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -206,7 +206,6 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	new_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
-	new_mtd->priv = this;
 	new_mtd->owner = THIS_MODULE;
 
 	/* map physical address */
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index b1f69f9..3b49fe8 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -685,7 +685,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->vaddr		= vaddr;
 
 	mtd			= nand_to_mtd(&info->chip);
-	mtd->priv		= &info->chip;
 	mtd->dev.parent		= &pdev->dev;
 	nand_set_flash_node(&info->chip, pdev->dev.of_node);
 
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 2b66cee..21bdd51 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1470,7 +1470,6 @@ int denali_init(struct denali_nand_info *denali)
 	/* now that our ISR is registered, we can enable interrupts */
 	denali_set_intr_modes(denali, true);
 	mtd->name = "denali-nand";
-	mtd->priv = &denali->nand;
 
 	/* register the driver with the NAND core subsystem */
 	denali->nand.select_chip = denali_select_chip;
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index fff7a4a..a5c0466 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1569,7 +1569,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->bbt_td		= (struct nand_bbt_descr *) (doc + 1);
 	nand->bbt_md		= nand->bbt_td + 1;
 
-	mtd->priv		= nand;
 	mtd->owner		= THIS_MODULE;
 
 	nand->priv		= doc;
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index cb6efad..1d02fb0 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -1314,7 +1314,6 @@ static int __init probe_docg4(struct platform_device *pdev)
 
 	mtd = nand_to_mtd(nand);
 	doc = (struct docg4_priv *) (nand + 1);
-	mtd->priv = nand;
 	nand->priv = doc;
 	mtd->dev.parent = &pdev->dev;
 	doc->virtadr = virtadr;
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 7bde76a..e96d5bc 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -746,7 +746,6 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	dev_dbg(priv->dev, "eLBC Set Information for bank %d\n", priv->bank);
 
 	/* Fill in fsl_elbc_mtd structure */
-	mtd->priv = chip;
 	mtd->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 3f5654f..9d2b4ed 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -881,7 +881,6 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
-	mtd->priv = chip;
 	mtd->dev.parent = priv->dev;
 	nand_set_flash_node(chip, priv->dev->of_node);
 
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 0379adc..cafd12d 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -176,7 +176,6 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
-	mtd->priv = &fun->chip;
 	mtd->dev.parent = fun->dev;
 
 	flash_np = of_get_next_child(upm_np, NULL);
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 4c68e7a..9a7c1f5 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -1009,7 +1009,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/* Link all private pointers */
 	mtd = nand_to_mtd(&host->nand);
 	nand = &host->nand;
-	mtd->priv = nand;
 	nand->priv = host;
 	nand_set_flash_node(nand, np);
 
diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index 99dd74c..ded658f 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -278,7 +278,6 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl		= gpio_nand_cmd_ctrl;
 
 	mtd			= nand_to_mtd(chip);
-	mtd->priv		= chip;
 	mtd->dev.parent		= &pdev->dev;
 
 	platform_set_drvdata(pdev, gpiomtd);
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 38b07c7..df61f49 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1893,7 +1893,6 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	this->current_chip	= -1;
 
 	/* init the MTD data structures */
-	mtd->priv		= chip;
 	mtd->name		= "gpmi-nand";
 	mtd->dev.parent		= this->dev;
 
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 6e6e482..2aee212 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -735,7 +735,6 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	mtd->priv		= chip;
 	mtd->name		= "hisi_nand";
 	mtd->dev.parent         = &pdev->dev;
 
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 03239a5..a2363d3 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -433,7 +433,6 @@ static int jz_nand_probe(struct platform_device *pdev)
 
 	chip		= &nand->chip;
 	mtd		= nand_to_mtd(chip);
-	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name	= "jz4740-nand";
 
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 3400b3f..db59fa2 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -681,7 +681,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	nand_chip->priv = host;		/* link the private data structures */
 	nand_set_flash_node(nand_chip, pdev->dev.of_node);
-	mtd->priv = nand_chip;
 	mtd->dev.parent = &pdev->dev;
 
 	/* Get NAND clock */
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 61b2961..ccd10b1 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -802,7 +802,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	mtd = nand_to_mtd(chip);
 	chip->priv = host;
 	nand_set_flash_node(chip, pdev->dev.of_node);
-	mtd->priv = chip;
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = &pdev->dev;
 
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 8b4cd82..6d0ca33 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -656,7 +656,6 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	chip = &prv->chip;
 	mtd = nand_to_mtd(chip);
 
-	mtd->priv = chip;
 	mtd->dev.parent = dev;
 	chip->priv = prv;
 	nand_set_flash_node(chip, dn);
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 9dd71af..9540099 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1514,7 +1514,6 @@ static int mxcnd_probe(struct platform_device *pdev)
 	/* structures must be linked */
 	this = &host->nand;
 	mtd = nand_to_mtd(this);
-	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name = DRIVER_NAME;
 
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 442eeaf..78de37d 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2243,7 +2243,6 @@ static int __init ns_init_module(void)
 		return -ENOMEM;
 	}
 	nsmtd       = nand_to_mtd(chip);
-        nsmtd->priv = (void *)chip;
 	nand        = (struct nandsim *)(chip + 1);
 	chip->priv  = (void *)nand;
 
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 3a7168e..0709ea9 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -167,7 +167,6 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->ecc.strength = 1;
 	chip->priv = ndfc;
 
-	mtd->priv = chip;
 	mtd->dev.parent = &ndfc->ofdev->dev;
 
 	flash_np = of_get_next_child(node, NULL);
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 4dad170..220ddfc 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -245,7 +245,6 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	chip = &(nuc900_nand->chip);
 	mtd = nand_to_mtd(chip);
 
-	mtd->priv		= chip;
 	mtd->dev.parent		= &pdev->dev;
 	spin_lock_init(&nuc900_nand->lock);
 
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f9d0b58..e9cbbc6 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1672,7 +1672,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->ecc_opt		= pdata->ecc_opt;
 	nand_chip		= &info->nand;
 	mtd			= nand_to_mtd(nand_chip);
-	mtd->priv		= &info->nand;
 	mtd->dev.parent		= &pdev->dev;
 	nand_chip->ecc.priv	= NULL;
 	nand_set_flash_node(nand_chip, pdata->of_node);
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 087a040..2c2be61 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -122,7 +122,6 @@ static int __init orion_nand_probe(struct platform_device *pdev)
 		board = dev_get_platdata(&pdev->dev);
 	}
 
-	mtd->priv = nc;
 	mtd->dev.parent = &pdev->dev;
 
 	nc->priv = board;
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 4dd2985..3ab53ca 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -121,7 +121,6 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	pasemi_nand_mtd = nand_to_mtd(chip);
 
 	/* Link the private data with the MTD structure */
-	pasemi_nand_mtd->priv = chip;
 	pasemi_nand_mtd->dev.parent = &ofdev->dev;
 
 	chip->IO_ADDR_R = of_iomap(np, 0);
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 796eb7d..dc88a58 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -59,7 +59,6 @@ static int plat_nand_probe(struct platform_device *pdev)
 	data->chip.priv = &data;
 	nand_set_flash_node(&data->chip, pdev->dev.of_node);
 	mtd = nand_to_mtd(&data->chip);
-	mtd->priv = &data->chip;
 	mtd->dev.parent = &pdev->dev;
 
 	data->chip.IO_ADDR_R = data->io_base;
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index c4d5788..10704ae 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1709,7 +1709,6 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		info->host[cs] = host;
 		host->cs = cs;
 		host->info_data = info;
-		mtd->priv = chip;
 		mtd->dev.parent = &pdev->dev;
 		/* FIXME: all chips use the same device tree partitions */
 		nand_set_flash_node(chip, np);
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index 1ac8ef2..cb0bf09 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -638,7 +638,6 @@ static int r852_register_nand_device(struct r852_device *dev)
 
 	WARN_ON(dev->card_registred);
 
-	mtd->priv = dev->chip;
 	mtd->dev.parent = &dev->pci_dev->dev;
 
 	if (dev->readonly)
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index c074a49..bc94c5d 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -788,7 +788,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 				   struct s3c2410_nand_set *set)
 {
 	struct nand_chip *chip = &nmtd->chip;
-	struct mtd_info *mtd = nand_to_mtd(chip);
 	void __iomem *regs = info->regs;
 
 	chip->write_buf    = s3c2410_nand_write_buf;
@@ -834,7 +833,6 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->IO_ADDR_R = chip->IO_ADDR_W;
 
 	nmtd->info	   = info;
-	mtd->priv	   = chip;
 	nmtd->set	   = set;
 
 #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 0ec4b04..c7126b7 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -1123,7 +1123,6 @@ static int flctl_probe(struct platform_device *pdev)
 	nand = &flctl->chip;
 	flctl_mtd = nand_to_mtd(nand);
 	nand_set_flash_node(nand, pdev->dev.of_node);
-	flctl_mtd->priv = nand;
 	flctl_mtd->dev.parent = &pdev->dev;
 	flctl->pdev = pdev;
 	flctl->hwecc = pdata->has_hwecc;
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 4b649fb..b7d1b55 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -147,7 +147,6 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 
 	/* Link the private data with the MTD structure */
 	mtd = nand_to_mtd(this);
-	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 
 	platform_set_drvdata(pdev, sharpsl);
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index c0ca0fd..4430d9a 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -164,7 +164,6 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 
 	nand_chip->priv = host;		/* link the private data structures */
 	nand_set_flash_node(nand_chip, ofdev->dev.of_node);
-	mtd->priv = nand_chip;
 	mtd->name = "socrates_nand";
 	mtd->dev.parent = &ofdev->dev;
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index c29d659..51e10a3 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1337,7 +1337,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 	mtd = nand_to_mtd(nand);
 	mtd->dev.parent = dev;
-	mtd->priv = nand;
 
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index e7b82e1..08b3054 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -382,7 +382,6 @@ static int tmio_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, tmio);
 	nand_chip = &tmio->chip;
 	mtd = nand_to_mtd(nand_chip);
-	mtd->priv = nand_chip;
 	mtd->name = "tmio-nand";
 	mtd->dev.parent = &dev->dev;
 
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index da7fcbd..27488ee 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -324,8 +324,6 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		mtd = nand_to_mtd(chip);
 		mtd->dev.parent = &dev->dev;
 
-		mtd->priv = chip;
-
 		chip->read_byte = txx9ndfmc_read_byte;
 		chip->read_buf = txx9ndfmc_read_buf;
 		chip->write_buf = txx9ndfmc_write_buf;
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 1bbb93a..034420f 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -679,7 +679,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	chip = &nfc->chip;
 	mtd = nand_to_mtd(chip);
 
-	mtd->priv = chip;
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = nfc->dev;
 	mtd->name = DRV_NAME;
-- 
2.1.4
