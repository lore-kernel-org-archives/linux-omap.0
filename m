From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 05/11] ARM: OMAP: USB: Host: usb host Device tree node Adaptation
Date: Wed, 31 Oct 2012 17:46:43 +0530
Message-ID: <1351685810-20616-6-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

The USB2 Host device node is extracted and used in the probe
of the driver to initialize the usb ports and controller. The
platform specific initialization is also performed.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/usb-host.c         |    2 -
 drivers/mfd/omap-usb-host.c            |  163 +++++++++++++++++++++++---------
 include/linux/platform_data/usb-omap.h |   19 +++-
 3 files changed, 133 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index d1dbe12..239c175 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -502,8 +502,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	}
 	ehci_data.phy_reset = pdata->phy_reset;
 	ohci_data.es2_compatibility = pdata->es2_compatibility;
-	usbhs_data.ehci_data = &ehci_data;
-	usbhs_data.ohci_data = &ohci_data;
 
 	if (cpu_is_omap34xx()) {
 		setup_ehci_io_mux(pdata->port_mode);
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index cebfe0a..4b3af16 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
-#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <plat/cpu.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/usb-omap.h>
@@ -103,8 +103,6 @@ struct usbhs_hcd_omap {
 
 	void __iomem			*uhh_base;
 
-	struct usbhs_omap_platform_data	platdata;
-
 	u32				usbhs_rev;
 	spinlock_t			lock;
 };
@@ -186,8 +184,6 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 {
 	struct device				*dev = &pdev->dev;
 	struct usbhs_hcd_omap			*omap;
-	struct ehci_hcd_omap_platform_data	*ehci_data;
-	struct ohci_hcd_omap_platform_data	*ohci_data;
 	struct platform_device			*ehci;
 	struct platform_device			*ohci;
 	struct resource				*res;
@@ -195,8 +191,6 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	int					ret;
 
 	omap = platform_get_drvdata(pdev);
-	ehci_data = omap->platdata.ehci_data;
-	ohci_data = omap->platdata.ohci_data;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ehci");
 	if (!res) {
@@ -214,8 +208,8 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	}
 	resources[1] = *res;
 
-	ehci = omap_usbhs_alloc_child(OMAP_EHCI_DEVICE, resources, 2, ehci_data,
-		sizeof(*ehci_data), dev);
+	ehci = omap_usbhs_alloc_child(OMAP_EHCI_DEVICE, resources, 2, NULL,
+		0, dev);
 
 	if (!ehci) {
 		dev_err(dev, "omap_usbhs_alloc_child failed\n");
@@ -239,8 +233,8 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	}
 	resources[1] = *res;
 
-	ohci = omap_usbhs_alloc_child(OMAP_OHCI_DEVICE, resources, 2, ohci_data,
-		sizeof(*ohci_data), dev);
+	ohci = omap_usbhs_alloc_child(OMAP_OHCI_DEVICE, resources, 2, NULL,
+		0, dev);
 	if (!ohci) {
 		dev_err(dev, "omap_usbhs_alloc_child failed\n");
 		ret = -ENOMEM;
@@ -279,7 +273,7 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
 	unsigned long			flags;
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
@@ -295,6 +289,7 @@ static int usbhs_runtime_resume(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
 
+	clk_enable(pdata->hub_clk);
 	if (is_ehci_tll_mode(pdata->port_mode[0]))
 		clk_enable(omap->usbhost_p1_fck);
 	if (is_ehci_tll_mode(pdata->port_mode[1]))
@@ -311,7 +306,7 @@ static int usbhs_runtime_resume(struct device *dev)
 static int usbhs_runtime_suspend(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
 	unsigned long			flags;
 
 	dev_dbg(dev, "usbhs_runtime_suspend\n");
@@ -331,6 +326,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 	clk_disable(omap->utmi_p2_fck);
 	clk_disable(omap->utmi_p1_fck);
 
+	clk_disable(pdata->hub_clk);
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
 
@@ -343,19 +339,29 @@ static int usbhs_runtime_suspend(struct device *dev)
 static void omap_usbhs_init(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
 	unsigned long			flags;
 	unsigned			reg;
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 
-	if (pdata->ehci_data->phy_reset) {
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
-			gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
+	if (gpio_is_valid(pdata->hub_power_gpio))
+		gpio_request_one(pdata->hub_power_gpio, GPIOF_OUT_INIT_HIGH,
+				 "Hub Power");
+	if (gpio_is_valid(pdata->hub_reset_gpio)) {
+		gpio_request_one(pdata->hub_reset_gpio, GPIOF_OUT_INIT_LOW,
+				 "Hub Reset Power");
+		udelay(5);
+		gpio_set_value_cansleep(pdata->hub_reset_gpio, 1);
+	}
+
+	if (pdata->phy_reset) {
+		if (gpio_is_valid(pdata->reset_gpio[0]))
+			gpio_request_one(pdata->reset_gpio[0],
 					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
 
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
-			gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
+		if (gpio_is_valid(pdata->reset_gpio[1]))
+			gpio_request_one(pdata->reset_gpio[1],
 					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
 
 		/* Hold the PHY in RESET for enough time till DIR is high */
@@ -431,36 +437,85 @@ static void omap_usbhs_init(struct device *dev)
 	spin_unlock_irqrestore(&omap->lock, flags);
 
 	pm_runtime_put_sync(dev);
-	if (pdata->ehci_data->phy_reset) {
+	if (pdata->phy_reset) {
 		/* Hold the PHY in RESET for enough time till
 		 * PHY is settled and ready
 		 */
 		udelay(10);
 
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
+		if (gpio_is_valid(pdata->reset_gpio[0]))
 			gpio_set_value_cansleep
-				(pdata->ehci_data->reset_gpio_port[0], 1);
+				(pdata->reset_gpio[0], 1);
 
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
+		if (gpio_is_valid(pdata->reset_gpio[1]))
 			gpio_set_value_cansleep
-				(pdata->ehci_data->reset_gpio_port[1], 1);
+				(pdata->reset_gpio[1], 1);
 	}
 }
 
 static void omap_usbhs_deinit(struct device *dev)
 {
-	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
 
-	if (pdata->ehci_data->phy_reset) {
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
-			gpio_free(pdata->ehci_data->reset_gpio_port[0]);
+	if (pdata->phy_reset) {
+		if (gpio_is_valid(pdata->reset_gpio[0]))
+			gpio_free(pdata->reset_gpio[0]);
 
-		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
-			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
+		if (gpio_is_valid(pdata->reset_gpio[1]))
+			gpio_free(pdata->reset_gpio[1]);
 	}
 }
 
+static struct usbhs_omap_platform_data *of_get_usbhs_pdata(struct device *dev)
+{
+	struct usbhs_omap_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+	struct property *pp;
+	char hubclk[20];
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL; /* out of memory */
+
+	of_property_read_u32(np, "port-0", &pdata->port_mode[0]);
+	of_property_read_u32(np, "port-1", &pdata->port_mode[1]);
+	of_property_read_u32(np, "port-2", &pdata->port_mode[2]);
+	pdata->reset_gpio[0] = of_get_named_gpio(np, "reset-gpio-1", 0);
+	pdata->reset_gpio[1] = of_get_named_gpio(np, "reset-gpio-2", 0);
+	pdata->reset_gpio[2] = of_get_named_gpio(np, "reset-gpio-3", 0);
+
+	if (gpio_is_valid(pdata->reset_gpio[0]) ||
+	    gpio_is_valid(pdata->reset_gpio[1]) ||
+	    gpio_is_valid(pdata->reset_gpio[2]))
+		pdata->phy_reset = true;
+
+	pp = of_find_property(np, "hub-clk", NULL);
+	if (pp) {
+		strncpy(hubclk, pp->value, 20);
+		pdata->hub_clk = clk_get(NULL, hubclk);
+		if (IS_ERR(pdata->hub_clk)) {
+			dev_err(dev, "hub clk failed error: %ld\n",
+				PTR_ERR(pdata->hub_clk));
+			goto err_end;
+		}
+	} else {
+		pdata->hub_clk = NULL;
+	}
+	if (pdata->hub_clk) {
+		of_property_read_u32(np, "hub-clkrate", &pdata->hub_clkrate);
+		clk_set_rate(pdata->hub_clk, pdata->hub_clkrate);
+	}
+
+	pdata->hub_power_gpio =	of_get_named_gpio(np, "hub-power-gpio", 0);
+	pdata->hub_reset_gpio =	of_get_named_gpio(np, "hub-reset-gpio", 0);
+
+	return pdata;
+
+err_end:
+	devm_kfree(dev, pdata);
+	return NULL;
+}
+
 
 /**
  * usbhs_omap_probe - initialize TI-based HCDs
@@ -470,14 +525,16 @@ static void omap_usbhs_deinit(struct device *dev)
 static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 {
 	struct device			*dev =  &pdev->dev;
-	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
+	struct usbhs_omap_platform_data	*pdata;
 	struct usbhs_hcd_omap		*omap;
 	struct resource			*res;
 	int				ret = 0;
 	int				i;
 
+
+	pdata = of_get_usbhs_pdata(dev);
 	if (!pdata) {
-		dev_err(dev, "Missing platform data\n");
+		dev_err(dev, "function of_get_usbhs_pdata failed\n");
 		ret = -ENOMEM;
 		goto end_probe;
 	}
@@ -486,20 +543,13 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	if (!omap) {
 		dev_err(dev, "Memory allocation failed\n");
 		ret = -ENOMEM;
-		goto end_probe;
+		goto err_pdata;
 	}
 
 	spin_lock_init(&omap->lock);
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
-		omap->platdata.port_mode[i] = pdata->port_mode[i];
-
-	omap->platdata.ehci_data = pdata->ehci_data;
-	omap->platdata.ohci_data = pdata->ohci_data;
-
 	pm_runtime_enable(dev);
 
-
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
 		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
 			is_ehci_hsic_mode(i)) {
@@ -516,7 +566,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	if (IS_ERR(omap->utmi_p1_fck)) {
 		ret = PTR_ERR(omap->utmi_p1_fck);
 		dev_err(dev, "utmi_p1_gfclk failed error:%d\n",	ret);
-		goto err_end;
+		goto err_ehci_fck;
 	}
 
 	omap->xclk60mhsp1_ck = clk_get(dev, "xclk60mhsp1_ck");
@@ -605,6 +655,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, omap);
+	dev->platform_data = pdata;
 
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
@@ -640,11 +691,15 @@ err_xclk60mhsp1_ck:
 err_utmi_p1_fck:
 	clk_put(omap->utmi_p1_fck);
 
-err_end:
+err_ehci_fck:
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(dev);
 	kfree(omap);
 
+err_pdata:
+	clk_put(pdata->hub_clk);
+	devm_kfree(dev, pdata);
+
 end_probe:
 	return ret;
 }
@@ -657,9 +712,11 @@ end_probe:
  */
 static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 {
-	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
+	struct device			*dev =  &pdev->dev;
+	struct usbhs_hcd_omap		*omap = platform_get_drvdata(pdev);
+	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
 
-	omap_usbhs_deinit(&pdev->dev);
+	omap_usbhs_deinit(dev);
 	iounmap(omap->uhh_base);
 	clk_put(omap->init_60m_fclk);
 	clk_put(omap->usbhost_p2_fck);
@@ -669,7 +726,9 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 	clk_put(omap->xclk60mhsp1_ck);
 	clk_put(omap->utmi_p1_fck);
 	clk_put(omap->ehci_logic_fck);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
+	clk_put(pdata->hub_clk);
+	devm_kfree(dev, pdata);
 	kfree(omap);
 
 	return 0;
@@ -680,11 +739,23 @@ static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
 	.runtime_resume		= usbhs_runtime_resume,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id omap_usbhs_of_match[] = {
+	{
+		.compatible = "ti,usbhs",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap_usbhs_of_match);
+
+#endif
+
 static struct platform_driver usbhs_omap_driver = {
 	.driver = {
 		.name		= (char *)usbhs_driver_name,
 		.owner		= THIS_MODULE,
 		.pm		= &usbhsomap_dev_pm_ops,
+		.of_match_table = of_match_ptr(omap_usbhs_of_match),
 	},
 	.remove		= __exit_p(usbhs_omap_remove),
 };
diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index 8570bcf..04dcf67 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -55,10 +55,23 @@ struct ohci_hcd_omap_platform_data {
 };
 
 struct usbhs_omap_platform_data {
-	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
+	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
+	int				reset_gpio[OMAP3_HS_USB_PORTS];
+
+	/*
+	 * Regulators for USB PHYs.
+	 * Each PHY can have a separate regulator.
+	 */
+	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 
-	struct ehci_hcd_omap_platform_data	*ehci_data;
-	struct ohci_hcd_omap_platform_data	*ohci_data;
+	unsigned			phy_reset:1;
+
+	/* Set this to true for ES2.x silicon */
+	unsigned			es2_compatibility:1;
+	struct clk			*hub_clk;
+	int				hub_clkrate;
+	int				hub_power_gpio;
+	int				hub_reset_gpio;
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.9.5

