From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 31/58] mtd: nand: nuc900: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:15 +0100
Message-ID: <1449734442-18672-32-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB47EUSZQKGQEUEEGL6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/nuc900_nand.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 65908c0..4dad170 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -55,7 +55,6 @@
 	__raw_writel((val), (dev)->reg + REG_SMADDR)
 
 struct nuc900_nand {
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	void __iomem *reg;
 	struct clk *clk;
@@ -64,7 +63,7 @@ struct nuc900_nand {
 
 static inline struct nuc900_nand *mtd_to_nuc900(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct nuc900_nand, mtd);
+	return container_of(mtd_to_nand(mtd), struct nuc900_nand, chip);
 }
 
 static const struct mtd_partition partitions[] = {
@@ -236,6 +235,7 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand;
 	struct nand_chip *chip;
+	struct mtd_info *mtd;
 	struct resource *res;
 
 	nuc900_nand = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_nand),
@@ -243,9 +243,10 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 	if (!nuc900_nand)
 		return -ENOMEM;
 	chip = &(nuc900_nand->chip);
+	mtd = nand_to_mtd(chip);
 
-	nuc900_nand->mtd.priv	= chip;
-	nuc900_nand->mtd.dev.parent = &pdev->dev;
+	mtd->priv		= chip;
+	mtd->dev.parent		= &pdev->dev;
 	spin_lock_init(&nuc900_nand->lock);
 
 	nuc900_nand->clk = devm_clk_get(&pdev->dev, NULL);
@@ -269,11 +270,10 @@ static int nuc900_nand_probe(struct platform_device *pdev)
 
 	nuc900_nand_enable(nuc900_nand);
 
-	if (nand_scan(&(nuc900_nand->mtd), 1))
+	if (nand_scan(mtd, 1))
 		return -ENXIO;
 
-	mtd_device_register(&(nuc900_nand->mtd), partitions,
-			    ARRAY_SIZE(partitions));
+	mtd_device_register(mtd, partitions, ARRAY_SIZE(partitions));
 
 	platform_set_drvdata(pdev, nuc900_nand);
 
@@ -284,7 +284,7 @@ static int nuc900_nand_remove(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand = platform_get_drvdata(pdev);
 
-	nand_release(&nuc900_nand->mtd);
+	nand_release(nand_to_mtd(&nuc900_nand->chip));
 	clk_disable(nuc900_nand->clk);
 
 	return 0;
-- 
2.1.4
