From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v4 30/58] mtd: nand: ndfc: use the mtd instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:14 +0100
Message-ID: <1449734442-18672-31-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marek.vasut@gmail.com>, Steven Miao <realmz6@gmail.com>, adi-b
List-Id: linux-omap@vger.kernel.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---
---
 drivers/mtd/nand/ndfc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index d8a23b0..3a7168e 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -37,7 +37,6 @@
 struct ndfc_controller {
 	struct platform_device *ofdev;
 	void __iomem *ndfcbase;
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	int chip_select;
 	struct nand_hw_control ndfc_control;
@@ -147,6 +146,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 {
 	struct device_node *flash_np;
 	struct nand_chip *chip = &ndfc->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	chip->IO_ADDR_R = ndfc->ndfcbase + NDFC_DATA;
@@ -167,31 +167,32 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->ecc.strength = 1;
 	chip->priv = ndfc;
 
-	ndfc->mtd.priv = chip;
-	ndfc->mtd.dev.parent = &ndfc->ofdev->dev;
+	mtd->priv = chip;
+	mtd->dev.parent = &ndfc->ofdev->dev;
 
 	flash_np = of_get_next_child(node, NULL);
 	if (!flash_np)
 		return -ENODEV;
 	nand_set_flash_node(chip, flash_np);
 
-	ndfc->mtd.name = kasprintf(GFP_KERNEL, "%s.%s",
-			dev_name(&ndfc->ofdev->dev), flash_np->name);
-	if (!ndfc->mtd.name) {
+	ppdata.of_node = flash_np;
+	mtd->name = kasprintf(GFP_KERNEL, "%s.%s", dev_name(&ndfc->ofdev->dev),
+			      flash_np->name);
+	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = nand_scan(&ndfc->mtd, 1);
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		goto err;
 
-	ret = mtd_device_register(&ndfc->mtd, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
 
 err:
 	of_node_put(flash_np);
 	if (ret)
-		kfree(ndfc->mtd.name);
+		kfree(mtd->name);
 	return ret;
 }
 
@@ -258,9 +259,10 @@ static int ndfc_probe(struct platform_device *ofdev)
 static int ndfc_remove(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc = dev_get_drvdata(&ofdev->dev);
+	struct mtd_info *mtd = nand_to_mtd(&ndfc->chip);
 
-	nand_release(&ndfc->mtd);
-	kfree(ndfc->mtd.name);
+	nand_release(mtd);
+	kfree(mtd->name);
 
 	return 0;
 }
-- 
2.1.4

