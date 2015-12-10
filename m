From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 09/58] mtd: nand: bf5xx: use the mtd instance
 embedded in struct nand_chip
Date: Thu, 10 Dec 2015 08:59:53 +0100
Message-ID: <1449734442-18672-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBX7CUSZQKGQE6XRPJDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/bf5xx_nand.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index d9da5ed..928d599 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -142,7 +142,6 @@ static struct nand_ecclayout bootrom_ecclayout = {
 struct bf5xx_nand_info {
 	/* mtd info */
 	struct nand_hw_control		controller;
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 
 	/* platform info */
@@ -160,7 +159,8 @@ struct bf5xx_nand_info {
  */
 static struct bf5xx_nand_info *mtd_to_nand_info(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct bf5xx_nand_info, mtd);
+	return container_of(mtd_to_nand(mtd), struct bf5xx_nand_info,
+			    chip);
 }
 
 static struct bf5xx_nand_info *to_nand_info(struct platform_device *pdev)
@@ -660,7 +660,7 @@ static int bf5xx_nand_hw_init(struct bf5xx_nand_info *info)
  */
 static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
 {
-	struct mtd_info *mtd = &info->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&info->chip);
 	struct mtd_partition *parts = info->platform->partitions;
 	int nr = info->platform->nr_partitions;
 
@@ -675,7 +675,7 @@ static int bf5xx_nand_remove(struct platform_device *pdev)
 	 * and their partitions, then go through freeing the
 	 * resources used
 	 */
-	nand_release(&info->mtd);
+	nand_release(nand_to_mtd(&info->chip));
 
 	peripheral_free_list(bfin_nfc_pin_req);
 	bf5xx_nand_dma_remove(info);
@@ -756,6 +756,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 
 	/* initialise chip data struct */
 	chip = &info->chip;
+	mtd = nand_to_mtd(&info->chip);
 
 	if (plat->data_width)
 		chip->options |= NAND_BUSWIDTH_16;
@@ -772,7 +773,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->cmd_ctrl     = bf5xx_nand_hwcontrol;
 	chip->dev_ready    = bf5xx_nand_devready;
 
-	chip->priv	   = &info->mtd;
+	chip->priv	   = mtd;
 	chip->controller   = &info->controller;
 
 	chip->IO_ADDR_R    = (void __iomem *) NFC_READ;
@@ -781,7 +782,6 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	chip->chip_delay   = 0;
 
 	/* initialise mtd info data struct */
-	mtd 		= &info->mtd;
 	mtd->priv	= chip;
 	mtd->dev.parent = &pdev->dev;
 
-- 
2.1.4
