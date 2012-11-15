From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/16] mfd: omap-usb-host: cleanup clock management code
Date: Thu, 15 Nov 2012 16:34:04 +0200
Message-ID: <1352990054-14680-7-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

All ports have similarly named port clocks so we can
bunch them into a port data structure and use for loop
to enable/disable the clocks.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c |  208 +++++++++++++++++++++----------------------
 1 files changed, 101 insertions(+), 107 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 23cec57..7303c41 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -76,6 +76,8 @@
 
 #define	OMAP_UHH_DEBUG_CSR				(0x44)
 
+#define MAX_HS_USB_PORTS	3	/* Increase this if any chip has more */
+
 /* Values of UHH_REVISION - Note: these are not given in the TRM */
 #define OMAP_USBHS_REV1		0x00000010	/* OMAP3 */
 #define OMAP_USBHS_REV2		0x50700100	/* OMAP4 */
@@ -87,14 +89,15 @@
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 #define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
 
+struct usbhs_port {
+	struct clk	*utmi_clk;
+};
 
 struct usbhs_hcd_omap {
+	struct usbhs_port		port[MAX_HS_USB_PORTS];
+
 	struct clk			*xclk60mhsp1_ck;
 	struct clk			*xclk60mhsp2_ck;
-	struct clk			*utmi_p1_fck;
-	struct clk			*usbhost_p1_fck;
-	struct clk			*utmi_p2_fck;
-	struct clk			*usbhost_p2_fck;
 	struct clk			*init_60m_fclk;
 	struct clk			*ehci_logic_fck;
 
@@ -278,6 +281,7 @@ static int usbhs_runtime_resume(struct device *dev)
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
 	unsigned long			flags;
+	int i, r;
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
@@ -292,13 +296,18 @@ static int usbhs_runtime_resume(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
-		clk_enable(omap->usbhost_p1_fck);
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
-		clk_enable(omap->usbhost_p2_fck);
-
-	clk_enable(omap->utmi_p1_fck);
-	clk_enable(omap->utmi_p2_fck);
+	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+			if (omap->port[i].utmi_clk) {
+				r = clk_enable(omap->port[i].utmi_clk);
+				if (r) {
+					dev_err(dev,
+					 "%s: Can't enable port %d clk : %d\n",
+					 __func__, i, r);
+				}
+			}
+		}
+	}
 
 	spin_unlock_irqrestore(&omap->lock, flags);
 
@@ -310,6 +319,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
 	unsigned long			flags;
+	int i;
 
 	dev_dbg(dev, "usbhs_runtime_suspend\n");
 
@@ -320,13 +330,12 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&omap->lock, flags);
 
-	if (is_ehci_tll_mode(pdata->port_mode[0]))
-		clk_disable(omap->usbhost_p1_fck);
-	if (is_ehci_tll_mode(pdata->port_mode[1]))
-		clk_disable(omap->usbhost_p2_fck);
-
-	clk_disable(omap->utmi_p2_fck);
-	clk_disable(omap->utmi_p1_fck);
+	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+		if (is_ehci_tll_mode(pdata->port_mode[i])) {
+			if (omap->port[i].utmi_clk)
+				clk_disable(omap->port[i].utmi_clk);
+		}
+	}
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
@@ -472,101 +481,105 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	struct resource			*res;
 	int				ret = 0;
 	int				i;
+	bool				need_logic_fck;
 
 	if (!pdata) {
 		dev_err(dev, "Missing platform data\n");
-		ret = -ENOMEM;
-		goto end_probe;
+		return -ENODEV;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
+	if (!res) {
+		dev_err(dev, "UHH EHCI get resource failed\n");
+		return -ENODEV;
 	}
 
 	omap = kzalloc(sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
 		dev_err(dev, "Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	omap->uhh_base = ioremap(res->start, resource_size(res));
+	if (!omap->uhh_base) {
+		dev_err(dev, "UHH ioremap failed\n");
 		ret = -ENOMEM;
-		goto end_probe;
+		goto err_remap;
 	}
 
 	spin_lock_init(&omap->lock);
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
+	need_logic_fck = false;
+	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
 		omap->platdata.port_mode[i] = pdata->port_mode[i];
 
+		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
+			is_ehci_hsic_mode(i))
+				need_logic_fck |= true;
+	}
+
 	omap->platdata.ehci_data = pdata->ehci_data;
 	omap->platdata.ohci_data = pdata->ohci_data;
 
-	pm_runtime_enable(dev);
-
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
-		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
-			is_ehci_hsic_mode(i)) {
-			omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
-			if (IS_ERR(omap->ehci_logic_fck)) {
-				ret = PTR_ERR(omap->ehci_logic_fck);
-				dev_warn(dev, "ehci_logic_fck failed:%d\n",
-					 ret);
-			}
-			break;
+	if (need_logic_fck) {
+		omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
+		if (IS_ERR(omap->ehci_logic_fck)) {
+			ret = PTR_ERR(omap->ehci_logic_fck);
+			dev_warn(dev, "ehci_logic_fck failed:%d\n", ret);
 		}
-
-	omap->utmi_p1_fck = clk_get(dev, "utmi_p1_gfclk");
-	if (IS_ERR(omap->utmi_p1_fck)) {
-		ret = PTR_ERR(omap->utmi_p1_fck);
-		dev_err(dev, "utmi_p1_gfclk failed error:%d\n",	ret);
-		goto err_end;
 	}
 
 	omap->xclk60mhsp1_ck = clk_get(dev, "xclk60mhsp1_ck");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp1_ck);
 		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
-		goto err_utmi_p1_fck;
-	}
-
-	omap->utmi_p2_fck = clk_get(dev, "utmi_p2_gfclk");
-	if (IS_ERR(omap->utmi_p2_fck)) {
-		ret = PTR_ERR(omap->utmi_p2_fck);
-		dev_err(dev, "utmi_p2_gfclk failed error:%d\n", ret);
-		goto err_xclk60mhsp1_ck;
+		goto err_xclk60mhsp1;
 	}
 
 	omap->xclk60mhsp2_ck = clk_get(dev, "xclk60mhsp2_ck");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
 		ret = PTR_ERR(omap->xclk60mhsp2_ck);
 		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
-		goto err_utmi_p2_fck;
-	}
-
-	omap->usbhost_p1_fck = clk_get(dev, "usb_host_hs_utmi_p1_clk");
-	if (IS_ERR(omap->usbhost_p1_fck)) {
-		ret = PTR_ERR(omap->usbhost_p1_fck);
-		dev_err(dev, "usbhost_p1_fck failed error:%d\n", ret);
-		goto err_xclk60mhsp2_ck;
-	}
-
-	omap->usbhost_p2_fck = clk_get(dev, "usb_host_hs_utmi_p2_clk");
-	if (IS_ERR(omap->usbhost_p2_fck)) {
-		ret = PTR_ERR(omap->usbhost_p2_fck);
-		dev_err(dev, "usbhost_p2_fck failed error:%d\n", ret);
-		goto err_usbhost_p1_fck;
+		goto err_xclk60mhsp2;
 	}
 
 	omap->init_60m_fclk = clk_get(dev, "init_60m_fclk");
 	if (IS_ERR(omap->init_60m_fclk)) {
 		ret = PTR_ERR(omap->init_60m_fclk);
 		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
-		goto err_usbhost_p2_fck;
+		goto err_init60m;
+	}
+
+	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+		struct clk *pclk;
+		char utmi_clk[] = "usb_host_hs_utmi_px_clk";
+
+		/* clock names are indexed from 1*/
+		sprintf(utmi_clk, "usb_host_hs_utmi_p%d_clk", i + 1);
+
+		/* If a clock is not found we won't bail out as not all
+		 * platforms have all clocks and we can function without
+		 * them
+		 */
+		pclk = clk_get(dev, utmi_clk);
+		if (IS_ERR(pclk))
+			dev_err(dev, "Failed to get clock : %s : %ld\n",
+				utmi_clk, PTR_ERR(pclk));
+		else
+			omap->port[i].utmi_clk = pclk;
+
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
 		/* for OMAP3 , the clk set paretn fails */
-		ret = clk_set_parent(omap->utmi_p1_fck,
+		ret = clk_set_parent(omap->port[0].utmi_clk,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
 			dev_err(dev, "xclk60mhsp1_ck set parent"
 				"failed error:%d\n", ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
-		ret = clk_set_parent(omap->utmi_p1_fck,
+		ret = clk_set_parent(omap->port[0].utmi_clk,
 					omap->init_60m_fclk);
 		if (ret != 0)
 			dev_err(dev, "init_60m_fclk set parent"
@@ -574,35 +587,23 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[1])) {
-		ret = clk_set_parent(omap->utmi_p2_fck,
+		ret = clk_set_parent(omap->port[1].utmi_clk,
 					omap->xclk60mhsp2_ck);
 		if (ret != 0)
 			dev_err(dev, "xclk60mhsp2_ck set parent"
 					"failed error:%d\n", ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
-		ret = clk_set_parent(omap->utmi_p2_fck,
+		ret = clk_set_parent(omap->port[1].utmi_clk,
 						omap->init_60m_fclk);
 		if (ret != 0)
 			dev_err(dev, "init_60m_fclk set parent"
 				"failed error:%d\n", ret);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
-	if (!res) {
-		dev_err(dev, "UHH EHCI get resource failed\n");
-		ret = -ENODEV;
-		goto err_init_60m_fclk;
-	}
-
-	omap->uhh_base = ioremap(res->start, resource_size(res));
-	if (!omap->uhh_base) {
-		dev_err(dev, "UHH ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_init_60m_fclk;
-	}
-
 	platform_set_drvdata(pdev, omap);
 
+	pm_runtime_enable(dev);
+
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
@@ -610,39 +611,30 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	goto end_probe;
+	return 0;
 
 err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
-	iounmap(omap->uhh_base);
 
-err_init_60m_fclk:
-	clk_put(omap->init_60m_fclk);
+	pm_runtime_disable(dev);
+	iounmap(omap->uhh_base);
 
-err_usbhost_p2_fck:
-	clk_put(omap->usbhost_p2_fck);
+	for (i = 0; i < MAX_HS_USB_PORTS; i++)
+		clk_put(omap->port[i].utmi_clk);
 
-err_usbhost_p1_fck:
-	clk_put(omap->usbhost_p1_fck);
+	clk_put(omap->init_60m_fclk);
 
-err_xclk60mhsp2_ck:
+err_init60m:
 	clk_put(omap->xclk60mhsp2_ck);
 
-err_utmi_p2_fck:
-	clk_put(omap->utmi_p2_fck);
-
-err_xclk60mhsp1_ck:
+err_xclk60mhsp2:
 	clk_put(omap->xclk60mhsp1_ck);
 
-err_utmi_p1_fck:
-	clk_put(omap->utmi_p1_fck);
-
-err_end:
+err_xclk60mhsp1:
 	clk_put(omap->ehci_logic_fck);
-	pm_runtime_disable(dev);
-	kfree(omap);
 
-end_probe:
+err_remap:
+	kfree(omap);
 	return ret;
 }
 
@@ -655,18 +647,20 @@ end_probe:
 static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 {
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
+	int i;
 
 	omap_usbhs_deinit(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	iounmap(omap->uhh_base);
+
+	for (i = 0; i < MAX_HS_USB_PORTS; i++)
+		clk_put(omap->port[i].utmi_clk);
+
 	clk_put(omap->init_60m_fclk);
-	clk_put(omap->usbhost_p2_fck);
-	clk_put(omap->usbhost_p1_fck);
 	clk_put(omap->xclk60mhsp2_ck);
-	clk_put(omap->utmi_p2_fck);
 	clk_put(omap->xclk60mhsp1_ck);
-	clk_put(omap->utmi_p1_fck);
 	clk_put(omap->ehci_logic_fck);
-	pm_runtime_disable(&pdev->dev);
+
 	kfree(omap);
 
 	return 0;
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
