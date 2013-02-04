From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/13] mfd: omap-usb-tll: move configuration code to omap_tll_init()
Date: Mon, 4 Feb 2013 17:58:50 +0200
Message-ID: <1359993540-20780-4-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is because we want to get rid of platform_data usage from probe().
The only information we need is PORT_MODE, and this can be supplied
to us by the user (i.e. omap-usb-host.c).

We also move channel clock management from runtime PM handlers into
omap_tll_enable/disable().

CC: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |    7 +-
 drivers/mfd/omap-usb-tll.c  |  204 +++++++++++++++++++++----------------------
 drivers/mfd/omap-usb.h      |    5 +-
 3 files changed, 107 insertions(+), 109 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 502a779..f8ed08e 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -278,7 +278,7 @@ static int usbhs_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
-	omap_tll_enable();
+	omap_tll_enable(pdata);
 
 	if (!IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
@@ -353,7 +353,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 	if (!IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
 
-	omap_tll_disable();
+	omap_tll_disable(pdata);
 
 	return 0;
 }
@@ -499,6 +499,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
 	omap->pdata = pdata;
 
+	/* Initialize the TLL subsystem */
+	omap_tll_init(pdata);
+
 	pm_runtime_enable(dev);
 
 	platform_set_drvdata(pdev, omap);
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 0aef1a7..f7d2568 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -1,8 +1,9 @@
 /**
  * omap-usb-tll.c - The USB TLL driver for OMAP EHCI & OHCI
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012-2013 Texas Instruments Incorporated - http://www.ti.com
  * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
+ * Author: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2  of
@@ -105,8 +106,8 @@
 
 struct usbtll_omap {
 	int					nch;	/* num. of channels */
-	struct usbhs_omap_platform_data		*pdata;
 	struct clk				**ch_clk;
+	void __iomem				*base;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -210,14 +211,10 @@ static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
 static int usbtll_omap_probe(struct platform_device *pdev)
 {
 	struct device				*dev =  &pdev->dev;
-	struct usbhs_omap_platform_data		*pdata = dev->platform_data;
-	void __iomem				*base;
 	struct resource				*res;
 	struct usbtll_omap			*tll;
-	unsigned				reg;
 	int					ret = 0;
 	int					i, ver;
-	bool needs_tll;
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
@@ -227,16 +224,9 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (!pdata) {
-		dev_err(dev, "Platform data missing\n");
-		return -ENODEV;
-	}
-
-	tll->pdata = pdata;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_request_and_ioremap(dev, res);
-	if (!base) {
+	tll->base = devm_request_and_ioremap(dev, res);
+	if (!tll->base) {
 		ret = -EADDRNOTAVAIL;
 		dev_err(dev, "Resource request/ioremap failed:%d\n", ret);
 		return ret;
@@ -246,7 +236,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
+	ver =  usbtll_read(tll->base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
 	case OMAP_USBTLL_REV4:
@@ -283,11 +273,77 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 			dev_dbg(dev, "can't get clock : %s\n", clkname);
 	}
 
+	pm_runtime_put_sync(dev);
+	/* only after this can omap_tll_enable/disable work */
+	spin_lock(&tll_lock);
+	tll_dev = dev;
+	spin_unlock(&tll_lock);
+
+	return 0;
+
+err_clk_alloc:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+/**
+ * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
+ * @pdev: USB Host Controller being removed
+ *
+ * Reverses the effect of usbtll_omap_probe().
+ */
+static int usbtll_omap_remove(struct platform_device *pdev)
+{
+	struct usbtll_omap *tll = platform_get_drvdata(pdev);
+	int i;
+
+	spin_lock(&tll_lock);
+	tll_dev = NULL;
+	spin_unlock(&tll_lock);
+
+	for (i = 0; i < tll->nch; i++)
+		if (!IS_ERR(tll->ch_clk[i]))
+			clk_put(tll->ch_clk[i]);
+
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver usbtll_omap_driver = {
+	.driver = {
+		.name		= (char *)usbtll_driver_name,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= usbtll_omap_probe,
+	.remove		= usbtll_omap_remove,
+};
+
+int omap_tll_init(struct usbhs_omap_platform_data *pdata)
+{
+	int i;
+	bool needs_tll;
+	unsigned reg;
+	struct usbtll_omap *tll;
+
+	spin_lock(&tll_lock);
+
+	if (!tll_dev) {
+		spin_unlock(&tll_lock);
+		return -ENODEV;
+	}
+
+	tll = dev_get_drvdata(tll_dev);
+
 	needs_tll = false;
 	for (i = 0; i < tll->nch; i++)
 		needs_tll |= omap_usb_mode_needs_tll(pdata->port_mode[i]);
 
+	pm_runtime_get_sync(tll_dev);
+
 	if (needs_tll) {
+		void __iomem *base = tll->base;
 
 		/* Program Common TLL register */
 		reg = usbtll_read(base, OMAP_TLL_SHARED_CONF);
@@ -336,51 +392,29 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_put_sync(dev);
-	/* only after this can omap_tll_enable/disable work */
-	spin_lock(&tll_lock);
-	tll_dev = dev;
+	pm_runtime_put_sync(tll_dev);
+
 	spin_unlock(&tll_lock);
 
 	return 0;
-
-err_clk_alloc:
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-
-	return ret;
 }
+EXPORT_SYMBOL_GPL(omap_tll_init);
 
-/**
- * usbtll_omap_remove - shutdown processing for UHH & TLL HCDs
- * @pdev: USB Host Controller being removed
- *
- * Reverses the effect of usbtll_omap_probe().
- */
-static int usbtll_omap_remove(struct platform_device *pdev)
+int omap_tll_enable(struct usbhs_omap_platform_data *pdata)
 {
-	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 	int i;
+	struct usbtll_omap *tll;
 
 	spin_lock(&tll_lock);
-	tll_dev = NULL;
-	spin_unlock(&tll_lock);
-
-	for (i = 0; i < tll->nch; i++)
-		if (!IS_ERR(tll->ch_clk[i]))
-			clk_put(tll->ch_clk[i]);
 
-	pm_runtime_disable(&pdev->dev);
-	return 0;
-}
+	if (!tll_dev) {
+		spin_unlock(&tll_lock);
+		return -ENODEV;
+	}
 
-static int usbtll_runtime_resume(struct device *dev)
-{
-	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data		*pdata = tll->pdata;
-	int i;
+	tll = dev_get_drvdata(tll_dev);
 
-	dev_dbg(dev, "usbtll_runtime_resume\n");
+	pm_runtime_get_sync(tll_dev);
 
 	for (i = 0; i < tll->nch; i++) {
 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
@@ -391,22 +425,31 @@ static int usbtll_runtime_resume(struct device *dev)
 
 			r = clk_enable(tll->ch_clk[i]);
 			if (r) {
-				dev_err(dev,
+				dev_err(tll_dev,
 				 "Error enabling ch %d clock: %d\n", i, r);
 			}
 		}
 	}
 
+	spin_unlock(&tll_lock);
+
 	return 0;
 }
+EXPORT_SYMBOL_GPL(omap_tll_enable);
 
-static int usbtll_runtime_suspend(struct device *dev)
+int omap_tll_disable(struct usbhs_omap_platform_data *pdata)
 {
-	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data		*pdata = tll->pdata;
 	int i;
+	struct usbtll_omap *tll;
+
+	spin_lock(&tll_lock);
+
+	if (!tll_dev) {
+		spin_unlock(&tll_lock);
+		return -ENODEV;
+	}
 
-	dev_dbg(dev, "usbtll_runtime_suspend\n");
+	tll = dev_get_drvdata(tll_dev);
 
 	for (i = 0; i < tll->nch; i++) {
 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
@@ -415,60 +458,11 @@ static int usbtll_runtime_suspend(struct device *dev)
 		}
 	}
 
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
-	.remove		= usbtll_omap_remove,
-};
-
-int omap_tll_enable(void)
-{
-	int ret;
-
-	spin_lock(&tll_lock);
-
-	if (!tll_dev) {
-		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
-		ret = -ENODEV;
-	} else {
-		ret = pm_runtime_get_sync(tll_dev);
-	}
+	pm_runtime_put_sync(tll_dev);
 
 	spin_unlock(&tll_lock);
 
-	return ret;
-}
-EXPORT_SYMBOL_GPL(omap_tll_enable);
-
-int omap_tll_disable(void)
-{
-	int ret;
-
-	spin_lock(&tll_lock);
-
-	if (!tll_dev) {
-		pr_err("%s: OMAP USB TLL not initialized\n", __func__);
-		ret = -ENODEV;
-	} else {
-		ret = pm_runtime_put_sync(tll_dev);
-	}
-
-	spin_unlock(&tll_lock);
