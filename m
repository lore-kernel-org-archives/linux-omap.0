From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 20/58] mtd: nand: fsl_upm: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:04 +0100
Message-ID: <1449734442-18672-21-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBJHDUSZQKGQEDYZRRZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/fsl_upm.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 68ec128..0379adc 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -31,7 +31,6 @@
 
 struct fsl_upm_nand {
 	struct device *dev;
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	int last_ctrl;
 	struct mtd_partition *parts;
@@ -49,7 +48,8 @@ struct fsl_upm_nand {
 
 static inline struct fsl_upm_nand *to_fsl_upm_nand(struct mtd_info *mtdinfo)
 {
-	return container_of(mtdinfo, struct fsl_upm_nand, mtd);
+	return container_of(mtd_to_nand(mtdinfo), struct fsl_upm_nand,
+			    chip);
 }
 
 static int fun_chip_ready(struct mtd_info *mtd)
@@ -66,9 +66,10 @@ static int fun_chip_ready(struct mtd_info *mtd)
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
 {
 	if (fun->rnb_gpio[fun->mchip_number] >= 0) {
+		struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 		int cnt = 1000000;
 
-		while (--cnt && !fun_chip_ready(&fun->mtd))
+		while (--cnt && !fun_chip_ready(mtd))
 			cpu_relax();
 		if (!cnt)
 			dev_err(fun->dev, "tired waiting for RNB\n");
@@ -157,6 +158,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 			 const struct device_node *upm_np,
 			 const struct resource *io_res)
 {
+	struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 	int ret;
 	struct device_node *flash_np;
 
@@ -174,30 +176,30 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
-	fun->mtd.priv = &fun->chip;
-	fun->mtd.dev.parent = fun->dev;
+	mtd->priv = &fun->chip;
+	mtd->dev.parent = fun->dev;
 
 	flash_np = of_get_next_child(upm_np, NULL);
 	if (!flash_np)
 		return -ENODEV;
 
 	nand_set_flash_node(&fun->chip, flash_np);
-	fun->mtd.name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
-				  flash_np->name);
-	if (!fun->mtd.name) {
+	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
+			      flash_np->name);
+	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, fun->mchip_count);
+	ret = nand_scan(mtd, fun->mchip_count);
 	if (ret)
 		goto err;
 
-	ret = mtd_device_register(&fun->mtd, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
 err:
 	of_node_put(flash_np);
 	if (ret)
-		kfree(fun->mtd.name);
+		kfree(mtd->name);
 	return ret;
 }
 
@@ -321,10 +323,11 @@ err1:
 static int fun_remove(struct platform_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
+	struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 	int i;
 
-	nand_release(&fun->mtd);
-	kfree(fun->mtd.name);
+	nand_release(mtd);
+	kfree(mtd->name);
 
 	for (i = 0; i < fun->mchip_count; i++) {
 		if (fun->rnb_gpio[i] < 0)
-- 
2.1.4
