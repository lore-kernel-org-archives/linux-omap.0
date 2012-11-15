From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 07/16] mfd: omap_usb_host: Avoid creating copy of platform_data
Date: Thu, 15 Nov 2012 16:34:05 +0200
Message-ID: <1352990054-14680-8-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768004Ab2KOOe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:26 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

We can just hold the pointer to the platform data instead
of creating a copy of it.

Also get rid of the unnecessary missing platform data checks
in runtime_suspend/resume. We are already checking for missing
platform data in probe.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   34 ++++++++++------------------------
 1 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7303c41..44772ae 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -103,7 +103,7 @@ struct usbhs_hcd_omap {
 
 	void __iomem			*uhh_base;
 
-	struct usbhs_omap_platform_data	platdata;
+	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
 	spinlock_t			lock;
@@ -195,8 +195,8 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	int					ret;
 
 	omap = platform_get_drvdata(pdev);
-	ehci_data = omap->platdata.ehci_data;
-	ohci_data = omap->platdata.ohci_data;
+	ehci_data = omap->pdata->ehci_data;
+	ohci_data = omap->pdata->ohci_data;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ehci");
 	if (!res) {
@@ -279,17 +279,12 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
 	unsigned long			flags;
+	struct usbhs_omap_platform_data *pdata = omap->pdata;
 	int i, r;
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	omap_tll_enable();
 	spin_lock_irqsave(&omap->lock, flags);
 
@@ -317,17 +312,12 @@ static int usbhs_runtime_resume(struct device *dev)
 static int usbhs_runtime_suspend(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
 	unsigned long			flags;
+	struct usbhs_omap_platform_data *pdata = omap->pdata;
 	int i;
 
 	dev_dbg(dev, "usbhs_runtime_suspend\n");
 
-	if (!pdata) {
-		dev_dbg(dev, "missing platform_data\n");
-		return  -ENODEV;
-	}
-
 	spin_lock_irqsave(&omap->lock, flags);
 
 	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
@@ -349,7 +339,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 static void omap_usbhs_init(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = omap->pdata;
 	unsigned long			flags;
 	unsigned			reg;
 
@@ -456,7 +446,7 @@ static void omap_usbhs_init(struct device *dev)
 static void omap_usbhs_deinit(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
+	struct usbhs_omap_platform_data	*pdata = omap->pdata;
 
 	if (pdata->ehci_data->phy_reset) {
 		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
@@ -509,19 +499,16 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 	spin_lock_init(&omap->lock);
 
+	omap->pdata = pdata;
+	platform_set_drvdata(pdev, omap);
+
 	need_logic_fck = false;
 	for (i = 0; i < MAX_HS_USB_PORTS; i++) {
-		omap->platdata.port_mode[i] = pdata->port_mode[i];
-
 		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
 			is_ehci_hsic_mode(i))
 				need_logic_fck |= true;
 	}
 
-	omap->platdata.ehci_data = pdata->ehci_data;
-	omap->platdata.ohci_data = pdata->ohci_data;
-
-
 	if (need_logic_fck) {
 		omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
 		if (IS_ERR(omap->ehci_logic_fck)) {
@@ -600,7 +587,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 				"failed error:%d\n", ret);
 	}
 
-	platform_set_drvdata(pdev, omap);
 
 	pm_runtime_enable(dev);
 
-- 
1.7.4.1

