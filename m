From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 26/58] mtd: nand: lpc32xx: use the mtd
 instance embedded in struct nand_chip
Date: Thu, 10 Dec 2015 09:00:10 +0100
Message-ID: <1449734442-18672-27-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBC7EUSZQKGQEYCF2C5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/lpc32xx_mlc.c | 7 +++----
 drivers/mtd/nand/lpc32xx_slc.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 3738856..3400b3f 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -173,7 +173,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	int			irq;
 	struct lpc32xx_nand_cfg_mlc	*ncfg;
@@ -566,7 +565,7 @@ static void lpc32xx_ecc_enable(struct mtd_info *mtd, int mode)
 
 static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -660,8 +659,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	
 	host->io_base_phy = rc->start;
 
-	mtd = &host->mtd;
 	nand_chip = &host->nand_chip;
+	mtd = nand_to_mtd(nand_chip);
 	if (pdev->dev.of_node)
 		host->ncfg = lpc32xx_parse_dt(&pdev->dev);
 	if (!host->ncfg) {
@@ -814,7 +813,7 @@ err_exit1:
 static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	free_irq(host->irq, host);
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index fcd9fac..61b2961 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -204,7 +204,6 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_slc_platform_data *pdata;
 	struct clk		*clk;
-	struct mtd_info		mtd;
 	void __iomem		*io_base;
 	struct lpc32xx_nand_cfg_slc *ncfg;
 
@@ -703,7 +702,7 @@ static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
 
 static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 {
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
 	if (!host->pdata || !host->pdata->dma_filter) {
@@ -799,8 +798,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->pdata = dev_get_platdata(&pdev->dev);
 
-	mtd = &host->mtd;
 	chip = &host->nand_chip;
+	mtd = nand_to_mtd(chip);
 	chip->priv = host;
 	nand_set_flash_node(chip, pdev->dev.of_node);
 	mtd->priv = chip;
@@ -932,7 +931,7 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 {
 	uint32_t tmp;
 	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
-	struct mtd_info *mtd = &host->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 
 	nand_release(mtd);
 	dma_release_channel(host->dma_chan);
-- 
2.1.4
