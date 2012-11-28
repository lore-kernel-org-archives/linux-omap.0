From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 08/22] mfd: omap-usb-tll: serialize access to TLL device
Date: Wed, 28 Nov 2012 16:48:56 +0200
Message-ID: <1354114150-11941-9-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Get rid of the unnecessary spin_lock_irqsave/restore() as there is
no interrupt handler for this driver. Instead we serialize access
to tll_dev using a global spinlock.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |   53 ++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index f9c51cd..f901def 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -103,14 +103,13 @@ struct usbtll_omap {
 	int					nch;	/* num. of channels */
 	struct usbtll_omap_platform_data	*pdata;
 	struct clk				**ch_clk;
-	/* secure the register updates */
-	spinlock_t				lock;
 };
 
 /*-------------------------------------------------------------------------*/
 
 static const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
 static struct device	*tll_dev;
+static DEFINE_SPINLOCK(tll_lock);	/* serialize access to tll_dev */
 
 /*-------------------------------------------------------------------------*/
 
@@ -212,7 +211,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	struct resource				*res;
 	struct usbtll_omap			*tll;
 	unsigned				reg;
-	unsigned long				flags;
 	int					ret = 0;
 	int					i, ver;
 	bool needs_tll;
@@ -230,8 +228,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&tll->lock);
-
 	tll->pdata = pdata;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -243,8 +239,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	spin_lock_irqsave(&tll->lock, flags);
-
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
@@ -262,8 +256,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		break;
 	}
 
-	spin_unlock_irqrestore(&tll->lock, flags);
-
 	tll->ch_clk = devm_kzalloc(dev, sizeof(struct clk * [tll->nch]),
 						GFP_KERNEL);
 	if (!tll->ch_clk) {
@@ -272,8 +264,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		goto err_clk_alloc;
 	}
 
-	spin_lock_irqsave(&tll->lock, flags);
-
 	for (i = 0; i < tll->nch; i++) {
 		char clkname[] = "usb_tll_hs_usb_chx_clk";
 		struct clk *fck;
@@ -332,10 +322,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-	spin_unlock_irqrestore(&tll->lock, flags);
 	pm_runtime_put_sync(dev);
 	/* only after this can omap_tll_enable/disable work */
+	spin_lock(&tll_lock);
 	tll_dev = dev;
+	spin_unlock(&tll_lock);
 
 	return 0;
 
@@ -357,7 +348,9 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 	int i;
 
+	spin_lock(&tll_lock);
 	tll_dev = NULL;
+	spin_unlock(&tll_lock);
 
 	for (i = 0; i < tll->nch; i++)
 		clk_put(tll->ch_clk[i]);
@@ -370,13 +363,10 @@ static int usbtll_runtime_resume(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
 	struct usbtll_omap_platform_data	*pdata = tll->pdata;
-	unsigned long				flags;
 	int i;
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
-	spin_lock_irqsave(&tll->lock, flags);
-
 	for (i = 0; i < tll->nch; i++) {
 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
 			int r;
@@ -392,8 +382,6 @@ static int usbtll_runtime_resume(struct device *dev)
 		}
 	}
 
-	spin_unlock_irqrestore(&tll->lock, flags);
-
 	return 0;
 }
 
@@ -401,13 +389,10 @@ static int usbtll_runtime_suspend(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
 	struct usbtll_omap_platform_data	*pdata = tll->pdata;
-	unsigned long				flags;
 	int i;
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
 
-	spin_lock_irqsave(&tll->lock, flags);
-
 	for (i = 0; i < tll->nch; i++) {
 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
 			if (tll->ch_clk[i])
@@ -415,8 +400,6 @@ static int usbtll_runtime_suspend(struct device *dev)
 		}
 	}
 
-	spin_unlock_irqrestore(&tll->lock, flags);
-
 	return 0;
 }
 
@@ -438,21 +421,39 @@ static struct platform_driver usbtll_omap_driver = {
 
 int omap_tll_enable(void)
 {
+	int ret;
+
+	spin_lock(&tll_lock);
+
 	if (!tll_dev) {
 		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
-		return  -ENODEV;
+		ret = -ENODEV;
+	} else {
+		ret = pm_runtime_get_sync(tll_dev);
 	}
-	return pm_runtime_get_sync(tll_dev);
+
+	spin_unlock(&tll_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_tll_enable);
 
 int omap_tll_disable(void)
 {
+	int ret;
+
+	spin_lock(&tll_lock);
+
 	if (!tll_dev) {
 		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
-		return  -ENODEV;
+		ret = -ENODEV;
+	} else {
+		ret = pm_runtime_put_sync(tll_dev);
 	}
-	return pm_runtime_put_sync(tll_dev);
+
+	spin_unlock(&tll_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_tll_disable);
 
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
