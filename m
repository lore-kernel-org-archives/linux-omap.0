From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/8] usb: phy: rename usb_nop_xceiv to usb_phy_generic
Date: Wed, 16 Apr 2014 16:26:32 -0500
Message-ID: <1397683595-3606-6-git-send-email-balbi@ti.com>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397683595-3606-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

no functional changes, just renaming the function
in order to make it slightly clearer what it should
be used for, also matching the driver name.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-exynos.c        |  6 ++---
 drivers/usb/dwc3/dwc3-pci.c           |  6 ++---
 drivers/usb/musb/am35x.c              |  4 +--
 drivers/usb/musb/blackfin.c           |  4 +--
 drivers/usb/musb/da8xx.c              |  4 +--
 drivers/usb/musb/davinci.c            |  6 ++---
 drivers/usb/musb/tusb6010.c           |  6 ++---
 drivers/usb/phy/phy-am335x.c          |  2 +-
 drivers/usb/phy/phy-generic.c         | 50 +++++++++++++++++------------------
 drivers/usb/phy/phy-generic.h         |  6 ++---
 drivers/usb/phy/phy-keystone.c        |  2 +-
 include/linux/usb/usb_phy_gen_xceiv.h | 10 +++----
 12 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 28c8ad7..821cc59 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -38,13 +38,13 @@ struct dwc3_exynos {
 
 static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 {
-	struct usb_phy_gen_xceiv_platform_data pdata;
+	struct usb_phy_generic_platform_data pdata;
 	struct platform_device	*pdev;
 	int			ret;
 
 	memset(&pdata, 0x00, sizeof(pdata));
 
-	pdev = platform_device_alloc("usb_phy_gen_xceiv", PLATFORM_DEVID_AUTO);
+	pdev = platform_device_alloc("usb_phy_generic", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -56,7 +56,7 @@ static int dwc3_exynos_register_phys(struct dwc3_exynos *exynos)
 	if (ret)
 		goto err1;
 
-	pdev = platform_device_alloc("usb_phy_gen_xceiv", PLATFORM_DEVID_AUTO);
+	pdev = platform_device_alloc("usb_phy_generic", PLATFORM_DEVID_AUTO);
 	if (!pdev) {
 		ret = -ENOMEM;
 		goto err1;
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index f393c18..8b162f0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -40,13 +40,13 @@ struct dwc3_pci {
 
 static int dwc3_pci_register_phys(struct dwc3_pci *glue)
 {
-	struct usb_phy_gen_xceiv_platform_data pdata;
+	struct usb_phy_generic_platform_data pdata;
 	struct platform_device	*pdev;
 	int			ret;
 
 	memset(&pdata, 0x00, sizeof(pdata));
 
-	pdev = platform_device_alloc("usb_phy_gen_xceiv", 0);
+	pdev = platform_device_alloc("usb_phy_generic", 0);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -58,7 +58,7 @@ static int dwc3_pci_register_phys(struct dwc3_pci *glue)
 	if (ret)
 		goto err1;
 
-	pdev = platform_device_alloc("usb_phy_gen_xceiv", 1);
+	pdev = platform_device_alloc("usb_phy_generic", 1);
 	if (!pdev) {
 		ret = -ENOMEM;
 		goto err1;
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index b3aa018..77ed664 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -360,7 +360,7 @@ static int am35x_musb_init(struct musb *musb)
 	if (!rev)
 		return -ENODEV;
 
-	usb_nop_xceiv_register();
+	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -EPROBE_DEFER;
@@ -402,7 +402,7 @@ static int am35x_musb_exit(struct musb *musb)
 		data->set_phy_power(0);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 
 	return 0;
 }
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 796677f..607f3ae 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -401,7 +401,7 @@ static int bfin_musb_init(struct musb *musb)
 	}
 	gpio_direction_output(musb->config->gpio_vrsel, 0);
 
-	usb_nop_xceiv_register();
+	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		gpio_free(musb->config->gpio_vrsel);
@@ -426,7 +426,7 @@ static int bfin_musb_exit(struct musb *musb)
 	gpio_free(musb->config->gpio_vrsel);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 	return 0;
 }
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index e3486de..bcdce8e 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -418,7 +418,7 @@ static int da8xx_musb_init(struct musb *musb)
 	if (!rev)
 		goto fail;
 
-	usb_nop_xceiv_register();
+	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		ret = -EPROBE_DEFER;
@@ -453,7 +453,7 @@ static int da8xx_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 
 	return 0;
 }
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index c259dac..c0e07ed 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -381,7 +381,7 @@ static int davinci_musb_init(struct musb *musb)
 	u32		revision;
 	int 		ret = -ENODEV;
 
-	usb_nop_xceiv_register();
+	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		ret = -EPROBE_DEFER;
@@ -439,7 +439,7 @@ static int davinci_musb_init(struct musb *musb)
 fail:
 	usb_put_phy(musb->xceiv);
 unregister:
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 	return ret;
 }
 
@@ -487,7 +487,7 @@ static int davinci_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 
 	return 0;
 }
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 4e9fb1d..0c0f5ee 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1065,7 +1065,7 @@ static int tusb_musb_init(struct musb *musb)
 	void __iomem		*sync = NULL;
 	int			ret;
 
-	usb_nop_xceiv_register();
+	usb_phy_generic_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -EPROBE_DEFER;
@@ -1117,7 +1117,7 @@ done:
 			iounmap(sync);
 
 		usb_put_phy(musb->xceiv);
-		usb_nop_xceiv_unregister();
+		usb_phy_generic_unregister();
 	}
 	return ret;
 }
@@ -1133,7 +1133,7 @@ static int tusb_musb_exit(struct musb *musb)
 	iounmap(musb->sync_va);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_phy_generic_unregister();
 	return 0;
 }
 
diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index 12fc346..bb866e4 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -13,7 +13,7 @@
 #include "phy-generic.h"
 
 struct am335x_phy {
-	struct usb_phy_gen_xceiv usb_phy_gen;
+	struct usb_phy_generic usb_phy_gen;
 	struct phy_control *phy_ctrl;
 	int id;
 };
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 95e70bc..e76ca4c 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -43,32 +43,32 @@
 
 static struct platform_device *pd;
 
-void usb_nop_xceiv_register(void)
+void usb_phy_generic_register(void)
 {
 	if (pd)
 		return;
-	pd = platform_device_register_simple("usb_phy_gen_xceiv", -1, NULL, 0);
+	pd = platform_device_register_simple("usb_phy_generic", -1, NULL, 0);
 	if (IS_ERR(pd)) {
 		pr_err("Unable to register generic usb transceiver\n");
 		pd = NULL;
 		return;
 	}
 }
-EXPORT_SYMBOL_GPL(usb_nop_xceiv_register);
+EXPORT_SYMBOL_GPL(usb_phy_generic_register);
 
-void usb_nop_xceiv_unregister(void)
+void usb_phy_generic_unregister(void)
 {
 	platform_device_unregister(pd);
 	pd = NULL;
 }
-EXPORT_SYMBOL_GPL(usb_nop_xceiv_unregister);
+EXPORT_SYMBOL_GPL(usb_phy_generic_unregister);
 
 static int nop_set_suspend(struct usb_phy *x, int suspend)
 {
 	return 0;
 }
 
-static void nop_reset_set(struct usb_phy_gen_xceiv *nop, int asserted)
+static void nop_reset_set(struct usb_phy_generic *nop, int asserted)
 {
 	int value;
 
@@ -87,7 +87,7 @@ static void nop_reset_set(struct usb_phy_gen_xceiv *nop, int asserted)
 
 int usb_gen_phy_init(struct usb_phy *phy)
 {
-	struct usb_phy_gen_xceiv *nop = dev_get_drvdata(phy->dev);
+	struct usb_phy_generic *nop = dev_get_drvdata(phy->dev);
 
 	if (!IS_ERR(nop->vcc)) {
 		if (regulator_enable(nop->vcc))
@@ -106,7 +106,7 @@ EXPORT_SYMBOL_GPL(usb_gen_phy_init);
 
 void usb_gen_phy_shutdown(struct usb_phy *phy)
 {
-	struct usb_phy_gen_xceiv *nop = dev_get_drvdata(phy->dev);
+	struct usb_phy_generic *nop = dev_get_drvdata(phy->dev);
 
 	/* Assert RESET */
 	nop_reset_set(nop, 1);
@@ -150,8 +150,8 @@ static int nop_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
-int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_gen_xceiv *nop,
-		struct usb_phy_gen_xceiv_platform_data *pdata)
+int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
+		struct usb_phy_generic_platform_data *pdata)
 {
 	enum usb_phy_type type = USB_PHY_TYPE_USB2;
 	int err;
@@ -245,10 +245,10 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_gen_xceiv *nop,
 }
 EXPORT_SYMBOL_GPL(usb_phy_gen_create_phy);
 
-static int usb_phy_gen_xceiv_probe(struct platform_device *pdev)
+static int usb_phy_generic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct usb_phy_gen_xceiv	*nop;
+	struct usb_phy_generic	*nop;
 	int err;
 
 	nop = devm_kzalloc(dev, sizeof(*nop), GFP_KERNEL);
@@ -274,9 +274,9 @@ static int usb_phy_gen_xceiv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int usb_phy_gen_xceiv_remove(struct platform_device *pdev)
+static int usb_phy_generic_remove(struct platform_device *pdev)
 {
-	struct usb_phy_gen_xceiv *nop = platform_get_drvdata(pdev);
+	struct usb_phy_generic *nop = platform_get_drvdata(pdev);
 
 	usb_remove_phy(&nop->phy);
 
@@ -290,29 +290,29 @@ static const struct of_device_id nop_xceiv_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, nop_xceiv_dt_ids);
 
-static struct platform_driver usb_phy_gen_xceiv_driver = {
-	.probe		= usb_phy_gen_xceiv_probe,
-	.remove		= usb_phy_gen_xceiv_remove,
+static struct platform_driver usb_phy_generic_driver = {
+	.probe		= usb_phy_generic_probe,
+	.remove		= usb_phy_generic_remove,
 	.driver		= {
-		.name	= "usb_phy_gen_xceiv",
+		.name	= "usb_phy_generic",
 		.owner	= THIS_MODULE,
 		.of_match_table = nop_xceiv_dt_ids,
 	},
 };
 
-static int __init usb_phy_gen_xceiv_init(void)
+static int __init usb_phy_generic_init(void)
 {
-	return platform_driver_register(&usb_phy_gen_xceiv_driver);
+	return platform_driver_register(&usb_phy_generic_driver);
 }
-subsys_initcall(usb_phy_gen_xceiv_init);
+subsys_initcall(usb_phy_generic_init);
 
-static void __exit usb_phy_gen_xceiv_exit(void)
+static void __exit usb_phy_generic_exit(void)
 {
-	platform_driver_unregister(&usb_phy_gen_xceiv_driver);
+	platform_driver_unregister(&usb_phy_generic_driver);
 }
-module_exit(usb_phy_gen_xceiv_exit);
+module_exit(usb_phy_generic_exit);
 
-MODULE_ALIAS("platform:usb_phy_gen_xceiv");
+MODULE_ALIAS("platform:usb_phy_generic");
 MODULE_AUTHOR("Texas Instruments Inc");
 MODULE_DESCRIPTION("NOP USB Transceiver driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-generic.h
index 38a81f3..f32450a 100644
--- a/drivers/usb/phy/phy-generic.h
+++ b/drivers/usb/phy/phy-generic.h
@@ -3,7 +3,7 @@
 
 #include <linux/usb/usb_phy_gen_xceiv.h>
 
-struct usb_phy_gen_xceiv {
+struct usb_phy_generic {
 	struct usb_phy phy;
 	struct device *dev;
 	struct clk *clk;
@@ -15,7 +15,7 @@ struct usb_phy_gen_xceiv {
 int usb_gen_phy_init(struct usb_phy *phy);
 void usb_gen_phy_shutdown(struct usb_phy *phy);
 
-int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_gen_xceiv *nop,
-		struct usb_phy_gen_xceiv_platform_data *pdata);
+int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
+		struct usb_phy_generic_platform_data *pdata);
 
 #endif
diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index d762003..2404c44 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -35,7 +35,7 @@
 #define PHY_REF_SSP_EN			BIT(29)
 
 struct keystone_usbphy {
-	struct usb_phy_gen_xceiv	usb_phy_gen;
+	struct usb_phy_generic	usb_phy_gen;
 	void __iomem			*phy_ctrl;
 };
 
diff --git a/include/linux/usb/usb_phy_gen_xceiv.h b/include/linux/usb/usb_phy_gen_xceiv.h
index cc8d818..c00176d 100644
--- a/include/linux/usb/usb_phy_gen_xceiv.h
+++ b/include/linux/usb/usb_phy_gen_xceiv.h
@@ -3,7 +3,7 @@
 
 #include <linux/usb/otg.h>
 
-struct usb_phy_gen_xceiv_platform_data {
+struct usb_phy_generic_platform_data {
 	enum usb_phy_type type;
 	unsigned long clk_rate;
 
@@ -15,14 +15,14 @@ struct usb_phy_gen_xceiv_platform_data {
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
 /* sometimes transceivers are accessed only through e.g. ULPI */
-extern void usb_nop_xceiv_register(void);
-extern void usb_nop_xceiv_unregister(void);
+extern void usb_phy_generic_register(void);
+extern void usb_phy_generic_unregister(void);
 #else
-static inline void usb_nop_xceiv_register(void)
+static inline void usb_phy_generic_register(void)
 {
 }
 
-static inline void usb_nop_xceiv_unregister(void)
+static inline void usb_phy_generic_unregister(void)
 {
 }
 #endif
-- 
1.9.2.459.g68773ac

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
