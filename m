From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 05/12] mtd: nand: davinci: rely on generic DT
 parsing done in nand_scan_ident()
Date: Fri,  1 Apr 2016 14:54:25 +0200
Message-ID: <1459515272-31011-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBGW77G3QKGQE7N42R3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Zhou Wang <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Harvey Hunt <harvey.hunt-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/nand/davinci_nand.c | 85 +++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8cb821b..5bb6245 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -34,7 +34,6 @@
 #include <linux/slab.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
-#include <linux/of_mtd.h>
 
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
@@ -576,9 +575,9 @@ static struct davinci_nand_pdata
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-mask-chipsel", &prop))
 			pdata->mask_chipsel = prop;
+
+
 		if (!of_property_read_string(pdev->dev.of_node,
-			"nand-ecc-mode", &mode) ||
-		    !of_property_read_string(pdev->dev.of_node,
 			"ti,davinci-ecc-mode", &mode)) {
 			if (!strncmp("none", mode, 4))
 				pdata->ecc_mode = NAND_ECC_NONE;
@@ -591,14 +590,11 @@ static struct davinci_nand_pdata
 			"ti,davinci-ecc-bits", &prop))
 			pdata->ecc_bits = prop;
 
-		prop = of_get_nand_bus_width(pdev->dev.of_node);
-		if (0 < prop || !of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-nand-buswidth", &prop))
-			if (prop == 16)
-				pdata->options |= NAND_BUSWIDTH_16;
+		if (!of_property_read_u32(pdev->dev.of_node,
+			"ti,davinci-nand-buswidth", &prop) && prop == 16)
+			pdata->options |= NAND_BUSWIDTH_16;
+
 		if (of_property_read_bool(pdev->dev.of_node,
-			"nand-on-flash-bbt") ||
-		    of_property_read_bool(pdev->dev.of_node,
 			"ti,davinci-nand-use-bbt"))
 			pdata->bbt_options = NAND_BBT_USE_FLASH;
 
@@ -628,7 +624,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	void __iomem			*base;
 	int				ret;
 	uint32_t			val;
-	nand_ecc_modes_t		ecc_mode;
 	struct mtd_info			*mtd;
 
 	pdata = nand_davinci_get_pdata(pdev);
@@ -712,10 +707,41 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->chip.write_buf    = nand_davinci_write_buf;
 
 	/* Use board-specific ECC config */
-	ecc_mode		= pdata->ecc_mode;
+	info->chip.ecc.mode	= pdata->ecc_mode;
 
 	ret = -EINVAL;
-	switch (ecc_mode) {
+
+	info->clk = devm_clk_get(&pdev->dev, "aemif");
+	if (IS_ERR(info->clk)) {
+		ret = PTR_ERR(info->clk);
+		dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
+			ret);
+		goto err_clk_enable;
+	}
+
+	spin_lock_irq(&davinci_nand_lock);
+
+	/* put CSxNAND into NAND mode */
+	val = davinci_nand_readl(info, NANDFCR_OFFSET);
+	val |= BIT(info->core_chipsel);
+	davinci_nand_writel(info, NANDFCR_OFFSET, val);
+
+	spin_unlock_irq(&davinci_nand_lock);
+
+	/* Scan to find existence of the device(s) */
+	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
+		goto err;
+	}
+
+	switch (info->chip.ecc.mode) {
 	case NAND_ECC_NONE:
 	case NAND_ECC_SOFT:
 		pdata->ecc_bits = 0;
@@ -754,37 +780,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	default:
 		return -EINVAL;
 	}
-	info->chip.ecc.mode = ecc_mode;
-
-	info->clk = devm_clk_get(&pdev->dev, "aemif");
-	if (IS_ERR(info->clk)) {
-		ret = PTR_ERR(info->clk);
-		dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret < 0) {
-		dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
-			ret);
-		goto err_clk_enable;
-	}
-
-	spin_lock_irq(&davinci_nand_lock);
-
-	/* put CSxNAND into NAND mode */
-	val = davinci_nand_readl(info, NANDFCR_OFFSET);
-	val |= BIT(info->core_chipsel);
-	davinci_nand_writel(info, NANDFCR_OFFSET, val);
-
-	spin_unlock_irq(&davinci_nand_lock);
-
-	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
-	if (ret < 0) {
-		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
-		goto err;
-	}
 
 	/* Update ECC layout if needed ... for 1-bit HW ECC, the default
 	 * is OK, but it allocates 6 bytes when only 3 are needed (for
@@ -850,7 +845,7 @@ err:
 
 err_clk_enable:
 	spin_lock_irq(&davinci_nand_lock);
-	if (ecc_mode == NAND_ECC_HW_SYNDROME)
+	if (info->chip.ecc.mode == NAND_ECC_HW_SYNDROME)
 		ecc4_busy = false;
 	spin_unlock_irq(&davinci_nand_lock);
 	return ret;
-- 
2.5.0
