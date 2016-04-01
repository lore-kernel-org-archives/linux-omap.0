From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 11/12] mtd: nand: sh_flctl: rely on generic DT
 parsing done in nand_scan_ident()
Date: Fri,  1 Apr 2016 14:54:31 +0200
Message-ID: <1459515272-31011-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBHW77G3QKGQERZRPGNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/sh_flctl.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4814402..8d4e97c 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -31,7 +31,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1044,8 +1043,6 @@ static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
 	const struct of_device_id *match;
 	struct flctl_soc_config *config;
 	struct sh_flctl_platform_data *pdata;
-	struct device_node *dn = dev->of_node;
-	int ret;
 
 	match = of_match_device(of_flctl_match, dev);
 	if (match)
@@ -1065,15 +1062,6 @@ static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
 	pdata->has_hwecc = config->has_hwecc;
 	pdata->use_holden = config->use_holden;
 
-	/* parse user defined options */
-	ret = of_get_nand_bus_width(dn);
-	if (ret == 16)
-		pdata->flcmncr_val |= SEL_16BIT;
-	else if (ret != 8) {
-		dev_err(dev, "%s: invalid bus width\n", __func__);
-		return NULL;
-	}
-
 	return pdata;
 }
 
@@ -1141,20 +1129,29 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->select_chip = flctl_select_chip;
 	nand->cmdfunc = flctl_cmdfunc;
 
-	if (pdata->flcmncr_val & SEL_16BIT) {
-		nand->options |= NAND_BUSWIDTH_16;
-		nand->read_word = flctl_read_word;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
 	flctl_setup_dma(flctl);
 
+	if (pdata->flcmncr_val & SEL_16BIT)
+		nand->options |= NAND_BUSWIDTH_16;
+
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
 		goto err_chip;
 
+	if (nand->options & NAND_BUSWIDTH_16) {
+		/*
+		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
+		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
+		 * flctl->flcmncr_base to pdata->flcmncr_val.
+		 */
+		pdata->flcmncr_val |= SEL_16BIT;
+		flctl->flcmncr_base = pdata->flcmncr_val;
+		nand->read_word = flctl_read_word;
+	}
+
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
 		goto err_chip;
-- 
2.5.0
