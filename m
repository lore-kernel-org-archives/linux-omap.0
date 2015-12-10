From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 40/58] mtd: nand: sharpsl: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:24 +0100
Message-ID: <1449734442-18672-41-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBRXFUSZQKGQEV24W5DA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/sharpsl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 84129e5..4b649fb 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -29,13 +29,15 @@
 #include <asm/mach-types.h>
 
 struct sharpsl_nand {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 
 	void __iomem		*io;
 };
 
-#define mtd_to_sharpsl(_mtd)	container_of(_mtd, struct sharpsl_nand, mtd)
+static inline struct sharpsl_nand *mtd_to_sharpsl(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct sharpsl_nand, chip);
+}
 
 /* register offset */
 #define ECCLPLB		0x00	/* line parity 7 - 0 bit */
@@ -109,6 +111,7 @@ static int sharpsl_nand_calculate_ecc(struct mtd_info *mtd, const u_char * dat,
 static int sharpsl_nand_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
+	struct mtd_info *mtd;
 	struct resource *r;
 	int err = 0;
 	struct sharpsl_nand *sharpsl;
@@ -143,8 +146,9 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this = (struct nand_chip *)(&sharpsl->chip);
 
 	/* Link the private data with the MTD structure */
-	sharpsl->mtd.priv = this;
-	sharpsl->mtd.dev.parent = &pdev->dev;
+	mtd = nand_to_mtd(this);
+	mtd->priv = this;
+	mtd->dev.parent = &pdev->dev;
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -173,14 +177,14 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.correct = nand_correct_data;
 
 	/* Scan to find existence of the device */
-	err = nand_scan(&sharpsl->mtd, 1);
+	err = nand_scan(mtd, 1);
 	if (err)
 		goto err_scan;
 
 	/* Register the partitions */
-	sharpsl->mtd.name = "sharpsl-nand";
+	mtd->name = "sharpsl-nand";
 
-	err = mtd_device_parse_register(&sharpsl->mtd, NULL, NULL,
+	err = mtd_device_parse_register(mtd, NULL, NULL,
 					data->partitions, data->nr_partitions);
 	if (err)
 		goto err_add;
@@ -189,7 +193,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	return 0;
 
 err_add:
-	nand_release(&sharpsl->mtd);
+	nand_release(mtd);
 
 err_scan:
 	iounmap(sharpsl->io);
@@ -207,7 +211,7 @@ static int sharpsl_nand_remove(struct platform_device *pdev)
 	struct sharpsl_nand *sharpsl = platform_get_drvdata(pdev);
 
 	/* Release resources, unregister device */
-	nand_release(&sharpsl->mtd);
+	nand_release(nand_to_mtd(&sharpsl->chip));
 
 	iounmap(sharpsl->io);
 
-- 
2.1.4
