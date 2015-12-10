From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 35/58] mtd: nand: plat: use the mtd instance
 embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:19 +0100
Message-ID: <1449734442-18672-36-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBJHFUSZQKGQE4VTBD5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
 drivers/mtd/nand/plat_nand.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 06ac6c6..796eb7d 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -20,7 +20,6 @@
 
 struct plat_nand_data {
 	struct nand_chip	chip;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 };
 
@@ -31,6 +30,7 @@ static int plat_nand_probe(struct platform_device *pdev)
 {
 	struct platform_nand_data *pdata = dev_get_platdata(&pdev->dev);
 	struct plat_nand_data *data;
+	struct mtd_info *mtd;
 	struct resource *res;
 	const char **part_types;
 	int err = 0;
@@ -58,8 +58,9 @@ static int plat_nand_probe(struct platform_device *pdev)
 
 	data->chip.priv = &data;
 	nand_set_flash_node(&data->chip, pdev->dev.of_node);
-	data->mtd.priv = &data->chip;
-	data->mtd.dev.parent = &pdev->dev;
+	mtd = nand_to_mtd(&data->chip);
+	mtd->priv = &data->chip;
+	mtd->dev.parent = &pdev->dev;
 
 	data->chip.IO_ADDR_R = data->io_base;
 	data->chip.IO_ADDR_W = data->io_base;
@@ -87,21 +88,21 @@ static int plat_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Scan to find existence of the device */
-	if (nand_scan(&data->mtd, pdata->chip.nr_chips)) {
+	if (nand_scan(mtd, pdata->chip.nr_chips)) {
 		err = -ENXIO;
 		goto out;
 	}
 
 	part_types = pdata->chip.part_probe_types;
 
-	err = mtd_device_parse_register(&data->mtd, part_types, NULL,
+	err = mtd_device_parse_register(mtd, part_types, NULL,
 					pdata->chip.partitions,
 					pdata->chip.nr_partitions);
 
 	if (!err)
 		return err;
 
-	nand_release(&data->mtd);
+	nand_release(mtd);
 out:
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
@@ -116,7 +117,7 @@ static int plat_nand_remove(struct platform_device *pdev)
 	struct plat_nand_data *data = platform_get_drvdata(pdev);
 	struct platform_nand_data *pdata = dev_get_platdata(&pdev->dev);
 
-	nand_release(&data->mtd);
+	nand_release(nand_to_mtd(&data->chip));
 	if (pdata->ctrl.remove)
 		pdata->ctrl.remove(pdev);
 
-- 
2.1.4
