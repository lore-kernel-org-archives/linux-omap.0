From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 38/58] mtd: nand: s3c2410: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:22 +0100
Message-ID: <1449734442-18672-39-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBOHFUSZQKGQEXTY5ZLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/s3c2410.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index e658b29..c074a49 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -104,7 +104,6 @@ struct s3c2410_nand_info;
  * @scan_res: The result from calling nand_scan_ident().
 */
 struct s3c2410_nand_mtd {
-	struct mtd_info			mtd;
 	struct nand_chip		chip;
 	struct s3c2410_nand_set		*set;
 	struct s3c2410_nand_info	*info;
@@ -168,7 +167,8 @@ struct s3c2410_nand_info {
 
 static struct s3c2410_nand_mtd *s3c2410_nand_mtd_toours(struct mtd_info *mtd)
 {
-	return container_of(mtd, struct s3c2410_nand_mtd, mtd);
+	return container_of(mtd_to_nand(mtd), struct s3c2410_nand_mtd,
+			    chip);
 }
 
 static struct s3c2410_nand_info *s3c2410_nand_mtd_toinfo(struct mtd_info *mtd)
@@ -745,7 +745,7 @@ static int s3c24xx_nand_remove(struct platform_device *pdev)
 
 		for (mtdno = 0; mtdno < info->mtd_count; mtdno++, ptr++) {
 			pr_debug("releasing mtd %d (%p)\n", mtdno, ptr);
-			nand_release(&ptr->mtd);
+			nand_release(nand_to_mtd(&ptr->chip));
 		}
 	}
 
@@ -762,9 +762,11 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 				      struct s3c2410_nand_set *set)
 {
 	if (set) {
-		mtd->mtd.name = set->name;
+		struct mtd_info *mtdinfo = nand_to_mtd(&mtd->chip);
 
-		return mtd_device_parse_register(&mtd->mtd, NULL, NULL,
+		mtdinfo->name = set->name;
+
+		return mtd_device_parse_register(mtdinfo, NULL, NULL,
 					 set->partitions, set->nr_partitions);
 	}
 
@@ -786,6 +788,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 				   struct s3c2410_nand_set *set)
 {
 	struct nand_chip *chip = &nmtd->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	void __iomem *regs = info->regs;
 
 	chip->write_buf    = s3c2410_nand_write_buf;
@@ -831,7 +834,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	chip->IO_ADDR_R = chip->IO_ADDR_W;
 
 	nmtd->info	   = info;
-	nmtd->mtd.priv	   = chip;
+	mtd->priv	   = chip;
 	nmtd->set	   = set;
 
 #ifdef CONFIG_MTD_NAND_S3C2410_HWECC
@@ -1012,19 +1015,21 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 	nmtd = info->mtds;
 
 	for (setno = 0; setno < nr_sets; setno++, nmtd++) {
+		struct mtd_info *mtd = nand_to_mtd(&nmtd->chip);
+
 		pr_debug("initialising set %d (%p, info %p)\n",
 			 setno, nmtd, info);
 
-		nmtd->mtd.dev.parent = &pdev->dev;
+		mtd->dev.parent = &pdev->dev;
 		s3c2410_nand_init_chip(info, nmtd, sets);
 
-		nmtd->scan_res = nand_scan_ident(&nmtd->mtd,
+		nmtd->scan_res = nand_scan_ident(mtd,
 						 (sets) ? sets->nr_chips : 1,
 						 NULL);
 
 		if (nmtd->scan_res == 0) {
 			s3c2410_nand_update_chip(info, nmtd);
-			nand_scan_tail(&nmtd->mtd);
+			nand_scan_tail(mtd);
 			s3c2410_nand_add_partition(info, nmtd, sets);
 		}
 
-- 
2.1.4
