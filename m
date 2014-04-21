From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/10] usb: dwc3: core: refactor PHY initialization
Date: Mon, 21 Apr 2014 10:56:44 -0500
Message-ID: <1398095812-14222-3-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398095812-14222-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

our probe() routine is too large and we can
easily refactor PHY-related code out to another
function to make it slightly less painful to read.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
