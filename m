From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 09/12] mtd: nand: mxc: rely on generic DT
 parsing done in nand_scan_ident()
Date: Fri,  1 Apr 2016 14:54:29 +0200
Message-ID: <1459515272-31011-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBHO77G3QKGQEGVJKL7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/mtd/nand/mxc_nand.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 854c832..f25913b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -34,7 +34,6 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-mxc_nand.h>
@@ -1461,25 +1460,12 @@ MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
 static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	struct device_node *np = host->dev->of_node;
-	struct mxc_nand_platform_data *pdata = &host->pdata;
 	const struct of_device_id *of_id =
 		of_match_device(mxcnd_dt_ids, host->dev);
-	int buswidth;
 
 	if (!np)
 		return 1;
 
-	if (of_get_nand_ecc_mode(np) >= 0)
-		pdata->hw_ecc = 1;
-
-	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
-
-	buswidth = of_get_nand_bus_width(np);
-	if (buswidth < 0)
-		return buswidth;
-
-	pdata->width = buswidth / 8;
-
 	host->devtype_data = of_id->data;
 
 	return 0;
@@ -1578,25 +1564,18 @@ static int mxcnd_probe(struct platform_device *pdev)
 	this->ecc.size = 512;
 	this->ecc.layout = host->devtype_data->ecclayout_512;
 
-	if (host->pdata.hw_ecc) {
-		this->ecc.calculate = mxc_nand_calculate_ecc;
-		this->ecc.hwctl = mxc_nand_enable_hwecc;
-		this->ecc.correct = host->devtype_data->correct_data;
+	if (host->pdata.hw_ecc)
 		this->ecc.mode = NAND_ECC_HW;
-	} else {
+	else
 		this->ecc.mode = NAND_ECC_SOFT;
-	}
 
 	/* NAND bus width determines access functions used by upper layer */
 	if (host->pdata.width == 2)
 		this->options |= NAND_BUSWIDTH_16;
 
-	if (host->pdata.flash_bbt) {
-		this->bbt_td = &bbt_main_descr;
-		this->bbt_md = &bbt_mirror_descr;
-		/* update flash based bbt */
+	/* update flash based bbt */
+	if (host->pdata.flash_bbt)
 		this->bbt_options |= NAND_BBT_USE_FLASH;
-	}
 
 	init_completion(&host->op_completion);
 
@@ -1637,6 +1616,27 @@ static int mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 	}
 
+	switch (this->ecc.mode) {
+	case NAND_ECC_HW:
+		this->ecc.calculate = mxc_nand_calculate_ecc;
+		this->ecc.hwctl = mxc_nand_enable_hwecc;
+		this->ecc.correct = host->devtype_data->correct_data;
+		break;
+
+	case NAND_ECC_SOFT:
+	case NAND_ECC_SOFT_BCH:
+		break;
+
+	default:
+		err = -EINVAL;
+		goto escan;
+	}
+
+	if (this->bbt_options & NAND_BBT_USE_FLASH) {
+		this->bbt_td = &bbt_main_descr;
+		this->bbt_md = &bbt_mirror_descr;
+	}
+
 	/* allocate the right size buffer now */
 	devm_kfree(&pdev->dev, (void *)host->data_buf);
 	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
-- 
2.5.0
