From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/16] mfd: omap-usb-tll: Move port clock handling out of runtime ops
Date: Thu, 15 Nov 2012 16:34:02 +0200
Message-ID: <1352990054-14680-5-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The port clocks are not required to access the port registers,
they are only needed when the PORT is used. So we move the port clock
handling code to omap_tll_enable/disable().

Also get of unnecessary spinlock code in probe function and check for
missing platform data.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-tll.c |  102 +++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 63 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 7054395e..31ac7db 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -114,8 +114,8 @@ struct usbtll_omap {
 
 /*-------------------------------------------------------------------------*/
 
-const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
-struct platform_device	*tll_pdev;
+static const char usbtll_driver_name[] = USBTLL_DRIVER_NAME;
+static struct device *tll_dev;
 
 /*-------------------------------------------------------------------------*/
 
@@ -217,7 +217,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	struct resource				*res;
 	struct usbtll_omap			*tll;
 	unsigned				reg;
-	unsigned long				flags;
 	int					ret = 0;
 	int					i, ver;
 	bool needs_tll;
@@ -230,6 +229,11 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!pdata) {
+		dev_err(dev, "%s : Platform data mising\n", __func__);
+		return -ENODEV;
+	}
+
 	spin_lock_init(&tll->lock);
 
 	tll->pdata = pdata;
@@ -253,8 +257,6 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	spin_lock_irqsave(&tll->lock, flags);
-
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
@@ -331,13 +333,13 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-	tll_pdev = pdev;
+	/* only after this can omap_tll_enable/disable work */
+	tll_dev = dev;
 
 err_clk:
 	for (--i; i >= 0 ; i--)
 		clk_put(tll->ch_clk[i]);
 
-	spin_unlock_irqrestore(&tll->lock, flags);
 	pm_runtime_put_sync(dev);
 	if (ret == 0) {
 		pr_info("OMAP USB TLL : revision 0x%x, channels %d\n",
@@ -364,6 +366,7 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 	int i;
 
+	tll_dev = NULL;
 	iounmap(tll->base);
 	for (i = 0; i < tll->nch; i++)
 		clk_put(tll->ch_clk[i]);
@@ -373,98 +376,71 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int usbtll_runtime_resume(struct device *dev)
+static struct platform_driver usbtll_omap_driver = {
+	.driver = {
+		.name		= (char *)usbtll_driver_name,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= usbtll_omap_probe,
+	.remove		= __devexit_p(usbtll_omap_remove),
+};
+
+int omap_tll_enable(void)
 {
-	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = tll->pdata;
+	struct usbtll_omap			*tll;
 	unsigned long				flags;
 	int i;
 
-	dev_dbg(dev, "usbtll_runtime_resume\n");
-
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
+	if (!tll_dev) {
+		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
 		return  -ENODEV;
 	}
 
+	tll = dev_get_drvdata(tll_dev);
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (mode_needs_tll(pdata->port_mode[i])) {
+		if (mode_needs_tll(tll->pdata->port_mode[i])) {
 			int r;
 			r = clk_enable(tll->ch_clk[i]);
 			if (r) {
-				dev_err(dev,
-				 "%s : Error enabling ch %d clock: %d\n",
-				 __func__, i, r);
+				dev_err(tll_dev,
+				  "%s : Error enabling ch %d clock: %d\n",
+				  __func__, i, r);
 			}
 		}
 	}
 
+	i = pm_runtime_get_sync(tll_dev);
 	spin_unlock_irqrestore(&tll->lock, flags);
 
-	return 0;
+	return i;
 }
+EXPORT_SYMBOL_GPL(omap_tll_enable);
 
-static int usbtll_runtime_suspend(struct device *dev)
+int omap_tll_disable(void)
 {
-	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = tll->pdata;
+	struct usbtll_omap			*tll;
 	unsigned long				flags;
 	int i;
 
-	dev_dbg(dev, "usbtll_runtime_suspend\n");
-
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
+	if (!tll_dev) {
+		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
 		return  -ENODEV;
 	}
 
+	tll = dev_get_drvdata(tll_dev);
 	spin_lock_irqsave(&tll->lock, flags);
 
 	for (i = 0; i < tll->nch; i++) {
-		if (mode_needs_tll(pdata->port_mode[i]))
+		if (mode_needs_tll(tll->pdata->port_mode[i]))
 			clk_disable(tll->ch_clk[i]);
 	}
 
+	i = pm_runtime_put_sync(tll_dev);
 	spin_unlock_irqrestore(&tll->lock, flags);
 
-	return 0;
-}
-
-static const struct dev_pm_ops usbtllomap_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(usbtll_runtime_suspend,
-			   usbtll_runtime_resume,
-			   NULL)
-};
-
-static struct platform_driver usbtll_omap_driver = {
-	.driver = {
-		.name		= (char *)usbtll_driver_name,
-		.owner		= THIS_MODULE,
-		.pm		= &usbtllomap_dev_pm_ops,
-	},
-	.probe		= usbtll_omap_probe,
-	.remove		= __devexit_p(usbtll_omap_remove),
-};
-
-int omap_tll_enable(void)
-{
-	if (!tll_pdev) {
-		pr_err("missing omap usbhs tll platform_data\n");
-		return  -ENODEV;
-	}
-	return pm_runtime_get_sync(&tll_pdev->dev);
-}
-EXPORT_SYMBOL_GPL(omap_tll_enable);
