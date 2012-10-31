From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/11] ARM: OMAP: USB: Host: USB TLL Device tree node Adaptation
Date: Wed, 31 Oct 2012 17:46:44 +0530
Message-ID: <1351685810-20616-7-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The USB TLL device node is extracted and used in the probe
of the driver to initialize the driver data.
This TLL driver exports an API to usbhs driver to perform
the port configuration. The usb2 hs driver invoke the same
API in its driver probe to initialize the ports.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c            |    7 ++
 drivers/mfd/omap-usb-tll.c             |  192 +++++++++++++++++++-------------
 include/linux/platform_data/usb-omap.h |    2 +
 3 files changed, 124 insertions(+), 77 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4b3af16..27aa85e 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -657,6 +657,11 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 	dev->platform_data = pdata;
 
+	if (omap_tll_init(pdata->port_mode)) {
+		dev_err(dev, "omap_tll_init failed\n");
+		goto err_tll;
+	}
+
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
@@ -668,6 +673,8 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
+
+err_tll:
 	iounmap(omap->uhh_base);
 
 err_init_60m_fclk:
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 0db0dfa..f457883 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/usb-omap.h>
@@ -98,7 +99,9 @@
 struct usbtll_omap {
 	struct clk				*usbtll_p1_fck;
 	struct clk				*usbtll_p2_fck;
-	struct usbtll_omap_platform_data	platdata;
+	void __iomem				*base;
+	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
+
 	/* secure the register updates */
 	spinlock_t				lock;
 };
@@ -196,17 +199,15 @@ static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
 }
 
 /**
- * usbtll_omap_probe - initialize TI-based HCDs
+ * usbtll_omap_initports - initialize TI-based HCDs
  *
- * Allocates basic resources for this USB host controller.
+ * initialize the usb tll ports. Maximum 3 ports
  */
-static int __devinit usbtll_omap_probe(struct platform_device *pdev)
+
+static int usbtll_initports(struct device *dev,
+			    enum usbhs_omap_port_mode port_mode[])
 {
-	struct device				*dev =  &pdev->dev;
-	struct usbtll_omap_platform_data	*pdata = dev->platform_data;
-	void __iomem				*base;
-	struct resource				*res;
-	struct usbtll_omap			*tll;
+	struct usbtll_omap			*tll = dev_get_drvdata(dev);
 	unsigned				reg;
 	unsigned long				flags;
 	int					ret = 0;
@@ -214,53 +215,19 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
 
-	tll = kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
 	if (!tll) {
-		dev_err(dev, "Memory allocation failed\n");
-		ret = -ENOMEM;
-		goto end;
+		dev_err(dev, "%s: missing TLL Driver data\n", __func__);
+		return -ENOMEM;
 	}
 
-	spin_lock_init(&tll->lock);
-
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
-		tll->platdata.port_mode[i] = pdata->port_mode[i];
+		tll->port_mode[i] = port_mode[i];
 
-	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
-	if (IS_ERR(tll->usbtll_p1_fck)) {
-		ret = PTR_ERR(tll->usbtll_p1_fck);
-		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
-		goto err_tll;
-	}
-
-	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
-	if (IS_ERR(tll->usbtll_p2_fck)) {
-		ret = PTR_ERR(tll->usbtll_p2_fck);
-		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
-		goto err_usbtll_p1_fck;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "usb tll get resource failed\n");
-		ret = -ENODEV;
-		goto err_usbtll_p2_fck;
-	}
-
-	base = ioremap(res->start, resource_size(res));
-	if (!base) {
-		dev_err(dev, "TLL ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_usbtll_p2_fck;
-	}
-
-	platform_set_drvdata(pdev, tll);
-	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
+	ver =  usbtll_read(tll->base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
 	case OMAP_USBTLL_REV2:
@@ -272,34 +239,34 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	default:
 		dev_err(dev, "TLL version failed\n");
 		ret = -ENODEV;
-		goto err_ioremap;
+		goto end;
 	}
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]) ||
-	    is_ehci_tll_mode(pdata->port_mode[1]) ||
-	    is_ehci_tll_mode(pdata->port_mode[2]) ||
-	    is_ohci_port(pdata->port_mode[0]) ||
-	    is_ohci_port(pdata->port_mode[1]) ||
-	    is_ohci_port(pdata->port_mode[2])) {
+	if (is_ehci_tll_mode(tll->port_mode[0]) ||
+	    is_ehci_tll_mode(tll->port_mode[1]) ||
+	    is_ehci_tll_mode(tll->port_mode[2]) ||
+	    is_ohci_port(tll->port_mode[0]) ||
+	    is_ohci_port(tll->port_mode[1]) ||
+	    is_ohci_port(tll->port_mode[2])) {
 
 		/* Program Common TLL register */
-		reg = usbtll_read(base, OMAP_TLL_SHARED_CONF);
+		reg = usbtll_read(tll->base, OMAP_TLL_SHARED_CONF);
 		reg |= (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
 			| OMAP_TLL_SHARED_CONF_USB_DIVRATION);
 		reg &= ~OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN;
 		reg &= ~OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN;
 
-		usbtll_write(base, OMAP_TLL_SHARED_CONF, reg);
+		usbtll_write(tll->base, OMAP_TLL_SHARED_CONF, reg);
 
 		/* Enable channels now */
 		for (i = 0; i < count; i++) {
-			reg = usbtll_read(base,	OMAP_TLL_CHANNEL_CONF(i));
+			reg = usbtll_read(tll->base, OMAP_TLL_CHANNEL_CONF(i));
 
-			if (is_ohci_port(pdata->port_mode[i])) {
-				reg |= ohci_omap3_fslsmode(pdata->port_mode[i])
+			if (is_ohci_port(tll->port_mode[i])) {
+				reg |= ohci_omap3_fslsmode(tll->port_mode[i])
 				<< OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT;
 				reg |= OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS;
-			} else if (pdata->port_mode[i] ==
+			} else if (tll->port_mode[i] ==
 					OMAP_EHCI_PORT_MODE_TLL) {
 				/*
 				 * Disable AutoIdle, BitStuffing
@@ -312,22 +279,75 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 				continue;
 			}
 			reg |= OMAP_TLL_CHANNEL_CONF_CHANEN;
-			usbtll_write(base, OMAP_TLL_CHANNEL_CONF(i), reg);
+			usbtll_write(tll->base, OMAP_TLL_CHANNEL_CONF(i), reg);
 
-			usbtll_writeb(base,
+			usbtll_writeb(tll->base,
 				      OMAP_TLL_ULPI_SCRATCH_REGISTER(i),
 				      0xbe);
 		}
 	}
 
-err_ioremap:
+end:
 	spin_unlock_irqrestore(&tll->lock, flags);
-	iounmap(base);
 	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+/**
+ * usbtll_omap_probe - initialize TI-based HCDs
+ *
+ * Allocates basic resources for this USB host controller.
+ */
+static int __devinit usbtll_omap_probe(struct platform_device *pdev)
+{
+	struct device				*dev =  &pdev->dev;
+	struct resource				*res;
+	struct usbtll_omap			*tll;
+	int					ret = 0;
+
+	dev_dbg(dev, "starting TI HSUSB TLL Controller\n");
+
+	tll = kzalloc(sizeof(struct usbtll_omap), GFP_KERNEL);
+	if (!tll) {
+		dev_err(dev, "Memory allocation failed\n");
+		ret = -ENOMEM;
+		goto err_tll;
+	}
+
+	spin_lock_init(&tll->lock);
+
+	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
+	if (IS_ERR(tll->usbtll_p1_fck)) {
+		ret = PTR_ERR(tll->usbtll_p1_fck);
+		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
+		goto err_tll;
+	}
+
+	tll->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
+	if (IS_ERR(tll->usbtll_p2_fck)) {
+		ret = PTR_ERR(tll->usbtll_p2_fck);
+		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
+		goto err_usbtll_p1_fck;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "usb tll get resource failed\n");
+		ret = -ENODEV;
+		goto err_usbtll_p2_fck;
+	}
+
+	tll->base = ioremap(res->start, resource_size(res));
+	if (!tll->base) {
+		dev_err(dev, "TLL ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_usbtll_p2_fck;
+	}
+
+	platform_set_drvdata(pdev, tll);
+	pm_runtime_enable(dev);
 	tll_pdev = pdev;
-	if (!ret)
-		goto end;
-	pm_runtime_disable(dev);
+	return 0;
 
 err_usbtll_p2_fck:
 	clk_put(tll->usbtll_p2_fck);
@@ -337,8 +357,6 @@ err_usbtll_p1_fck:
 
 err_tll:
 	kfree(tll);
-
-end:
 	return ret;
 }
 
@@ -362,22 +380,21 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 static int usbtll_runtime_resume(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
 	unsigned long				flags;
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
 
-	if (!pdata) {
+	if (!tll) {
 		dev_dbg(dev, "missing platform_data\n");
 		return  -ENODEV;
 	}
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
+	if (is_ehci_tll_mode(tll->port_mode[0]))
 		clk_enable(tll->usbtll_p1_fck);
 
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
+	if (is_ehci_tll_mode(tll->port_mode[1]))
 		clk_enable(tll->usbtll_p2_fck);
 
 	spin_unlock_irqrestore(&tll->lock, flags);
@@ -388,22 +405,21 @@ static int usbtll_runtime_resume(struct device *dev)
 static int usbtll_runtime_suspend(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
 	unsigned long				flags;
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
 
-	if (!pdata) {
+	if (!tll) {
 		dev_dbg(dev, "missing platform_data\n");
 		return  -ENODEV;
 	}
 
 	spin_lock_irqsave(&tll->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
+	if (is_ehci_tll_mode(tll->port_mode[0]))
 		clk_disable(tll->usbtll_p1_fck);
 
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
+	if (is_ehci_tll_mode(tll->port_mode[1]))
 		clk_disable(tll->usbtll_p2_fck);
 
 	spin_unlock_irqrestore(&tll->lock, flags);
@@ -417,16 +433,38 @@ static const struct dev_pm_ops usbtllomap_dev_pm_ops = {
 			   NULL)
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id omap_tll_of_match[] = {
+	{
+		.compatible = "ti,usbtll",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_tll_of_match);
+
+#endif
+
 static struct platform_driver usbtll_omap_driver = {
 	.driver = {
 		.name		= (char *)usbtll_driver_name,
 		.owner		= THIS_MODULE,
 		.pm		= &usbtllomap_dev_pm_ops,
+		.of_match_table = of_match_ptr(omap_tll_of_match),
 	},
 	.probe		= usbtll_omap_probe,
 	.remove		= __devexit_p(usbtll_omap_remove),
 };
 
+int omap_tll_init(enum usbhs_omap_port_mode port_mode[])
+{
+	if (!tll_pdev) {
+		pr_err("missing omap usbhs tll platform_data\n");
+		return  -ENODEV;
+	}
+	return usbtll_initports(&tll_pdev->dev, port_mode);
+}
+EXPORT_SYMBOL_GPL(omap_tll_init);
+
 int omap_tll_enable(void)
 {
 	if (!tll_pdev) {
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index 04dcf67..3ad2d8a 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -91,3 +91,5 @@ enum musb_interface {
 	MUSB_INTERFACE_ULPI,
 	MUSB_INTERFACE_UTMI
 };
+
+extern int omap_tll_init(enum usbhs_omap_port_mode port_mode[]);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
