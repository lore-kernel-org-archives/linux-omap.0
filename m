From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 08/16] mfd: omap-usb-host: know about number of ports from revision register
Date: Thu, 15 Nov 2012 16:34:06 +0200
Message-ID: <1352990054-14680-9-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767923Ab2KOOe1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:27 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

prevents getting clocks that don't exist on the platform.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   47 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 44772ae..ad89939 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -94,6 +94,7 @@ struct usbhs_port {
 };
 
 struct usbhs_hcd_omap {
+	int				nports;
 	struct usbhs_port		port[MAX_HS_USB_PORTS];
 
 	struct clk			*xclk60mhsp1_ck;
@@ -291,7 +292,7 @@ static int usbhs_runtime_resume(struct device *dev)
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_enable(omap->ehci_logic_fck);
 
-	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+	for (i = 0; i < omap->nports; i++) {
 		if (is_ehci_tll_mode(pdata->port_mode[i])) {
 			if (omap->port[i].utmi_clk) {
 				r = clk_enable(omap->port[i].utmi_clk);
@@ -320,7 +321,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&omap->lock, flags);
 
-	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+	for (i = 0; i < omap->nports; i++) {
 		if (is_ehci_tll_mode(pdata->port_mode[i])) {
 			if (omap->port[i].utmi_clk)
 				clk_disable(omap->port[i].utmi_clk);
@@ -360,8 +361,6 @@ static void omap_usbhs_init(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&omap->lock, flags);
-	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
-	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -502,8 +501,32 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	omap->pdata = pdata;
 	platform_set_drvdata(pdev, omap);
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
+
+	/* we need to call runtime suspend before we update omap->nports
+	 * to prevent unbalanced clk_disable()
+	 */
+	pm_runtime_put_sync(dev);
+
+	switch (omap->usbhs_rev) {
+	case OMAP_USBHS_REV1:
+		omap->nports = 3;
+		break;
+	case OMAP_USBHS_REV2:
+		omap->nports = 2;
+		break;
+	default:
+		omap->nports = MAX_HS_USB_PORTS;
+		dev_info(dev,
+		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
+		   omap->usbhs_rev, omap->nports);
+		break;
+	}
+
 	need_logic_fck = false;
-	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+	for (i = 0; i < omap->nports; i++) {
 		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
 			is_ehci_hsic_mode(i))
 				need_logic_fck |= true;
@@ -538,7 +561,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_init60m;
 	}
 
-	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
+	for (i = 0; i < omap->nports; i++) {
 		struct clk *pclk;
 		char utmi_clk[] = "usb_host_hs_utmi_px_clk";
 
@@ -588,8 +611,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 
-	pm_runtime_enable(dev);
-
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
@@ -597,15 +618,15 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	pr_info("OMAP USB HOST : revision 0x%x, ports %d\n",
+			omap->usbhs_rev, omap->nports);
 	return 0;
 
 err_alloc:
 	omap_usbhs_deinit(&pdev->dev);
-
-	pm_runtime_disable(dev);
 	iounmap(omap->uhh_base);
 
-	for (i = 0; i < MAX_HS_USB_PORTS; i++)
+	for (i = 0; i < omap->nports; i++)
 		clk_put(omap->port[i].utmi_clk);
 
 	clk_put(omap->init_60m_fclk);
@@ -619,6 +640,8 @@ err_xclk60mhsp2:
 err_xclk60mhsp1:
 	clk_put(omap->ehci_logic_fck);
 
+	pm_runtime_disable(dev);
+
 err_remap:
 	kfree(omap);
 	return ret;
@@ -639,7 +662,7 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	iounmap(omap->uhh_base);
 
-	for (i = 0; i < MAX_HS_USB_PORTS; i++)
+	for (i = 0; i < omap->nports; i++)
 		clk_put(omap->port[i].utmi_clk);
 
 	clk_put(omap->init_60m_fclk);
-- 
1.7.4.1

