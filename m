From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 32/58] mtd: nand: omap2: use the mtd instance
 embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:16 +0100
Message-ID: <1449734442-18672-33-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBBHFUSZQKGQE6BSSSZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/omap2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1fb40db..f9d0b58 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -152,7 +152,6 @@ static struct nand_hw_control omap_gpmc_controller = {
 
 struct omap_nand_info {
 	struct omap_nand_platform_data	*pdata;
-	struct mtd_info			mtd;
 	struct nand_chip		nand;
 	struct platform_device		*pdev;
 
@@ -179,8 +178,9 @@ struct omap_nand_info {
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct omap_nand_info, mtd);
+	return container_of(mtd_to_nand(mtd), struct omap_nand_info, nand);
 }
+
 /**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
@@ -1670,10 +1670,10 @@ static int omap_nand_probe(struct platform_device *pdev)
 	info->reg		= pdata->reg;
 	info->of_node		= pdata->of_node;
 	info->ecc_opt		= pdata->ecc_opt;
-	mtd			= &info->mtd;
+	nand_chip		= &info->nand;
+	mtd			= nand_to_mtd(nand_chip);
 	mtd->priv		= &info->nand;
 	mtd->dev.parent		= &pdev->dev;
-	nand_chip		= &info->nand;
 	nand_chip->ecc.priv	= NULL;
 	nand_set_flash_node(nand_chip, pdata->of_node);
 
@@ -1897,7 +1897,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 
 		err = elm_config(info->elm_dev, BCH4_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1951,7 +1951,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH8_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
@@ -1981,7 +1981,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.write_page	= omap_write_page_bch;
 
 		err = elm_config(info->elm_dev, BCH16_ECC,
-				 info->mtd.writesize / nand_chip->ecc.size,
+				 mtd->writesize / nand_chip->ecc.size,
 				 nand_chip->ecc.size, nand_chip->ecc.bytes);
 		if (err < 0)
 			goto return_error;
-- 
2.1.4
