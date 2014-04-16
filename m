From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/8] usb: dwc3: core: refactor PHY initialization
Date: Wed, 16 Apr 2014 16:26:29 -0500
Message-ID: <1397683595-3606-3-git-send-email-balbi@ti.com>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664AbaDPV3S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Apr 2014 17:29:18 -0400
In-Reply-To: <1397683595-3606-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, kgene.kim@samsung.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>, bigeasy@linutronix.de, aaro.koskinen@iki.fi, heikki.krogerus@linux.intel.com, zhangwm@marvell.com, David Cohen <david.a.cohen@linux.intel.com>, Felipe Balbi <balbi@ti.com>

our probe() routine is too large and we can
easily refactor PHY-related code out to another
function to make it slightly less painful to read.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 120 ++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d001417..38976f3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -486,70 +486,20 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	phy_exit(dwc->usb3_generic_phy);
 }
 
-#define DWC3_ALIGN_MASK		(16 - 1)
-
-static int dwc3_probe(struct platform_device *pdev)
+static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
-	struct device		*dev = &pdev->dev;
-	struct dwc3_platform_data *pdata = dev_get_platdata(dev);
+	struct device		*dev = dwc->dev;
 	struct device_node	*node = dev->of_node;
-	struct resource		*res;
-	struct dwc3		*dwc;
-
-	int			ret = -ENOMEM;
-
-	void __iomem		*regs;
-	void			*mem;
-
-	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
-	if (!mem) {
-		dev_err(dev, "not enough memory\n");
-		return -ENOMEM;
-	}
-	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
-	dwc->mem = mem;
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "missing IRQ\n");
-		return -ENODEV;
-	}
-	dwc->xhci_resources[1].start = res->start;
-	dwc->xhci_resources[1].end = res->end;
-	dwc->xhci_resources[1].flags = res->flags;
-	dwc->xhci_resources[1].name = res->name;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory resource\n");
-		return -ENODEV;
-	}
+	int ret;
 
 	if (node) {
-		dwc->maximum_speed = of_usb_get_maximum_speed(node);
-
 		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
 		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
-
-		dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
-		dwc->dr_mode = of_usb_get_dr_mode(node);
-	} else if (pdata) {
-		dwc->maximum_speed = pdata->maximum_speed;
-
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-
-		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
-		dwc->dr_mode = pdata->dr_mode;
 	} else {
 		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
 	}
 
-	/* default to superspeed if no maximum_speed passed */
-	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
 	if (IS_ERR(dwc->usb2_phy)) {
 		ret = PTR_ERR(dwc->usb2_phy);
 		if (ret == -ENXIO || ret == -ENODEV) {
@@ -600,6 +550,69 @@ static int dwc3_probe(struct platform_device *pdev)
 		}
 	}
 
+	return 0;
+}
+
+#define DWC3_ALIGN_MASK		(16 - 1)
+
+static int dwc3_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct dwc3_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node	*node = dev->of_node;
+	struct resource		*res;
+	struct dwc3		*dwc;
+
+	int			ret = -ENOMEM;
+
+	void __iomem		*regs;
+	void			*mem;
+
+	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
+	if (!mem) {
+		dev_err(dev, "not enough memory\n");
+		return -ENOMEM;
+	}
+	dwc = PTR_ALIGN(mem, DWC3_ALIGN_MASK + 1);
+	dwc->mem = mem;
+	dwc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "missing IRQ\n");
+		return -ENODEV;
+	}
+	dwc->xhci_resources[1].start = res->start;
+	dwc->xhci_resources[1].end = res->end;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	if (node) {
+		dwc->maximum_speed = of_usb_get_maximum_speed(node);
+
+		dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
+		dwc->dr_mode = of_usb_get_dr_mode(node);
+	} else if (pdata) {
+		dwc->maximum_speed = pdata->maximum_speed;
+
+		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
+		dwc->dr_mode = pdata->dr_mode;
+	}
+
+	/* default to superspeed if no maximum_speed passed */
+	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+	ret = dwc3_core_get_phy(dwc);
+	if (ret)
+		return ret;
+
 	dwc->xhci_resources[0].start = res->start;
 	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
 					DWC3_XHCI_REGS_END;
@@ -621,7 +634,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(res);
-	dwc->dev	= dev;
 
 	dev->dma_mask	= dev->parent->dma_mask;
 	dev->dma_parms	= dev->parent->dma_parms;
-- 
1.9.2.459.g68773ac

