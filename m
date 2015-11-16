From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 19/27] mtd: nand: remove useless mtd->priv =
 chip assignments
Date: Mon, 16 Nov 2015 14:37:52 +0100
Message-ID: <1447681080-31232-20-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBW5YU6ZAKGQEIXU6OYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

mtd_to_nand_chip() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info mtd;
struct mtd_info *mtdptr;
struct nand_chip *chipptr;
expression d;
@@
(
-(mtd).priv = (chipptr);
|
-(mtdptr)->priv = (chipptr);
---8<----
---
 drivers/mtd/nand/ams-delta.c           | 3 ---
 drivers/mtd/nand/atmel_nand.c          | 1 -
 drivers/mtd/nand/bf5xx_nand.c          | 1 -
 drivers/mtd/nand/brcmnand/brcmnand.c   | 1 -
 drivers/mtd/nand/cafe_nand.c           | 1 -
 drivers/mtd/nand/cmx270_nand.c         | 1 -
 drivers/mtd/nand/cs553x_nand.c         | 1 -
 drivers/mtd/nand/diskonchip.c          | 1 -
 drivers/mtd/nand/docg4.c               | 1 -
 drivers/mtd/nand/fsmc_nand.c           | 1 -
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 1 -
 drivers/mtd/nand/hisi504_nand.c        | 1 -
 drivers/mtd/nand/jz4740_nand.c         | 1 -
 drivers/mtd/nand/lpc32xx_mlc.c         | 1 -
 drivers/mtd/nand/lpc32xx_slc.c         | 1 -
 drivers/mtd/nand/mpc5121_nfc.c         | 1 -
 drivers/mtd/nand/mxc_nand.c            | 1 -
 drivers/mtd/nand/omap2.c               | 1 -
 drivers/mtd/nand/orion_nand.c          | 1 -
 drivers/mtd/nand/pasemi_nand.c         | 1 -
 drivers/mtd/nand/pxa3xx_nand.c         | 1 -
 drivers/mtd/nand/r852.c                | 1 -
 drivers/mtd/nand/sh_flctl.c            | 1 -
 drivers/mtd/nand/socrates_nand.c       | 1 -
 drivers/mtd/nand/sunxi_nand.c          | 1 -
 drivers/mtd/nand/tmio_nand.c           | 1 -
 drivers/mtd/nand/txx9ndfmc.c           | 2 --
 drivers/mtd/nand/vf610_nfc.c           | 1 -
 28 files changed, 31 deletions(-)

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
index 51748b4..aef02d3 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -2126,7 +2126,6 @@ static int atmel_nand_probe(struct platform_device *pdev)
 	}
 
 	nand_chip->priv = host;		/* link the private data structures */
-	mtd->priv = nand_chip;
 	mtd->dev.parent = &pdev->dev;
 
 	/* Set address of NAND IO lines */
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 671d983..77d3b11 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -782,7 +782,6 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 
 	/* initialise mtd info data struct */
 	mtd		= nand_to_mtd(&info->chip);
-	mtd->priv	= chip;
 	mtd->dev.parent	= &pdev->dev;
 
 	/* initialise the hardware */
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 20ebf00..a124147 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1925,7 +1925,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 
 	nand_set_flash_node(chip, dn);
 	chip->priv = host;
-	mtd->priv = chip;
 	mtd->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "brcmnand.%d",
 				   host->cs);
 	mtd->owner = THIS_MODULE;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 1d3a66c..096917a 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -611,7 +611,6 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
 	mtd = nand_to_mtd(&cafe->nand);
 	mtd->dev.parent = &pdev->dev;
-	mtd->priv = &cafe->nand;
 
 	cafe->nand.priv = cafe;
 	cafe->pdev = pdev;
diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index 84d027e..ca1f9b6 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -177,7 +177,6 @@ static int __init cmx270_init(void)
 
 	/* Link the private data with the MTD structure */
 	cmx270_nand_mtd->owner = THIS_MODULE;
-	cmx270_nand_mtd->priv = this;
 
 	/* insert callbacks */
 	this->IO_ADDR_R = cmx270_nand_io;
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index ea51a9c..3a691d9 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -206,7 +206,6 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	new_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
-	new_mtd->priv = this;
 	new_mtd->owner = THIS_MODULE;
 
 	/* map physical address */
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 96f1c81..395c037 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1568,7 +1568,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->bbt_td		= (struct nand_bbt_descr *) (doc + 1);
 	nand->bbt_md		= nand->bbt_td + 1;
 
-	mtd->priv		= nand;
 	mtd->owner		= THIS_MODULE;
 
 	nand->priv		= doc;
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index a136ef0..31135c7 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -1313,7 +1313,6 @@ static int __init probe_docg4(struct platform_device *pdev)
 	}
 	mtd = nand_to_mtd(nand);
 	doc = (struct docg4_priv *) (nand + 1);
-	mtd->priv = nand;
 	nand->priv = doc;
 	mtd->dev.parent = &pdev->dev;
 	doc->virtadr = virtadr;
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index a3080b9..40aa0bc 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -1021,7 +1021,6 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/* Link all private pointers */
 	mtd = nand_to_mtd(&host->nand);
 	nand = &host->nand;
-	mtd->priv = nand;
 	nand->priv = host;
 	nand_set_flash_node(nand, np);
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index b7229a1..30c6bea 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1894,7 +1894,6 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	this->current_chip	= -1;
 
 	/* init the MTD data structures */
-	mtd->priv		= chip;
 	mtd->name		= "gpmi-nand";
 	mtd->dev.parent		= this->dev;
 
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 21ff2b4..fb13861 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -735,7 +735,6 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	mtd->priv		= chip;
 	mtd->name		= "hisi_nand";
 	mtd->dev.parent         = &pdev->dev;
 
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 58dca30..fbe9a2a 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -432,7 +432,6 @@ static int jz_nand_probe(struct platform_device *pdev)
 
 	mtd		= nand_to_mtd(&nand->chip);
 	chip		= &nand->chip;
-	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name	= "jz4740-nand";
 
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 600d467..e000106 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -681,7 +681,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	nand_chip->priv = host;		/* link the private data structures */
 	nand_set_flash_node(nand_chip, pdev->dev.of_node);
-	mtd->priv = nand_chip;
 	mtd->dev.parent = &pdev->dev;
 
 	/* Get NAND clock */
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index de0f909..016641b 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -802,7 +802,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	chip = &host->nand_chip;
 	chip->priv = host;
 	nand_set_flash_node(chip, pdev->dev.of_node);
-	mtd->priv = chip;
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = &pdev->dev;
 
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 950443b..efdb647 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -656,7 +656,6 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	mtd = nand_to_mtd(&prv->chip);
 	chip = &prv->chip;
 
-	mtd->priv = chip;
 	mtd->dev.parent = dev;
 	chip->priv = prv;
 	nand_set_flash_node(chip, dn);
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 520152d..d6c25cd 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1515,7 +1515,6 @@ static int mxcnd_probe(struct platform_device *pdev)
 	/* structures must be linked */
 	this = &host->nand;
 	mtd = nand_to_mtd(&host->nand);
-	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name = DRIVER_NAME;
 
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index d7f79ed..685018a 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1698,7 +1698,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
 	mtd			= nand_to_mtd(&info->nand);
-	mtd->priv		= &info->nand;
 	mtd->dev.parent		= &pdev->dev;
 	nand_chip		= &info->nand;
 	nand_chip->ecc.priv	= NULL;
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
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 86b2de5..8bb9057 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1732,7 +1732,6 @@ static int alloc_nand_resource(struct platform_device *pdev)
 		info->host[cs] = host;
 		host->cs = cs;
 		host->info_data = info;
-		mtd->priv = chip;
 		mtd->dev.parent = &pdev->dev;
 		/* FIXME: all chips use the same device tree partitions */
 		nand_set_flash_node(chip, np);
diff --git a/drivers/mtd/nand/r852.c b/drivers/mtd/nand/r852.c
index 9c86409..f969d26 100644
--- a/drivers/mtd/nand/r852.c
+++ b/drivers/mtd/nand/r852.c
@@ -638,7 +638,6 @@ static int r852_register_nand_device(struct r852_device *dev)
 
 	WARN_ON(dev->card_registred);
 
-	mtd->priv = dev->chip;
 	mtd->dev.parent = &dev->pci_dev->dev;
 
 	if (dev->readonly)
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
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index 6c0ea1c..b009d75 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -164,7 +164,6 @@ static int socrates_nand_probe(struct platform_device *ofdev)
 
 	nand_chip->priv = host;		/* link the private data structures */
 	nand_set_flash_node(nand_chip, ofdev->dev.of_node);
-	mtd->priv = nand_chip;
 	mtd->name = "socrates_nand";
 	mtd->dev.parent = &ofdev->dev;
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index b8f5e41..f0c7b6f 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1339,7 +1339,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 
 	mtd = nand_to_mtd(&chip->nand);
 	mtd->dev.parent = dev;
-	mtd->priv = nand;
 
 	ret = nand_scan_ident(mtd, nsels, NULL);
 	if (ret)
diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index 127c382..5ddd88d 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -379,7 +379,6 @@ static int tmio_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, tmio);
 	mtd = nand_to_mtd(&tmio->chip);
 	nand_chip = &tmio->chip;
-	mtd->priv = nand_chip;
 	mtd->name = "tmio-nand";
 	mtd->dev.parent = &dev->dev;
 
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index fa7cd49..da74a1d 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -324,8 +324,6 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		mtd = nand_to_mtd(&txx9_priv->chip);
 		mtd->dev.parent = &dev->dev;
 
-		mtd->priv = chip;
-
 		chip->read_byte = txx9ndfmc_read_byte;
 		chip->read_buf = txx9ndfmc_read_buf;
 		chip->write_buf = txx9ndfmc_write_buf;
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index a1cbd35..04c487d 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -676,7 +676,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	mtd = nand_to_mtd(&nfc->chip);
 	chip = &nfc->chip;
 
-	mtd->priv = chip;
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = nfc->dev;
 	mtd->name = DRV_NAME;
-- 
2.1.4
