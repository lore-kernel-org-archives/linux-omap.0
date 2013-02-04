From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 08/13] USB: ehci-omap: Add device tree support and binding information
Date: Mon, 4 Feb 2013 17:58:55 +0200
Message-ID: <1359993540-20780-9-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219Ab3BDP7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:59:44 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rogerq@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

Allows the OMAP EHCI controller to be specified via device tree.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/omap-ehci.txt          |   34 ++++++++++++++++++
 drivers/usb/host/ehci-omap.c                       |   36 +++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/omap-ehci.txt

diff --git a/Documentation/devicetree/bindings/usb/omap-ehci.txt b/Documentation/devicetree/bindings/usb/omap-ehci.txt
new file mode 100644
index 0000000..90e6e3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/omap-ehci.txt
@@ -0,0 +1,34 @@
+OMAP HS USB EHCI controller
+
+This device is usually the child of the omap-usb-host
+Documentation/devicetree/bindings/mfd/omap-usb-host.txt
+
+Required properties:
+
+- compatible: should be "ti,omap-ehci"
+- reg: should contain one register range i.e. start and length
+- interrupt-parent: phandle to the interrupt controller
+- interrupts: description of the interrupt line
+
+Optional properties:
+
+- phy: list of phandles to PHY nodes.
+  This property is required if at least one of the ports are in
+  PHY mode i.e. OMAP_EHCI_PORT_MODE_PHY
+
+To specify the port mode, see
+Documentation/devicetree/bindings/mfd/omap-usb-host.txt
+
+Example for OMAP4:
+
+usbhsehci: ehci@0x4a064c00 {
+	compatible = "ti,omap-ehci", "usb-ehci";
+	reg = <0x4a064c00 0x400>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 77 0x4>;
+};
+
+&usbhsehci {
+	phy = <&hsusb1_phy 0 &hsusb3_phy>;
+};
+
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5a831aef..15cc419 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -48,6 +48,8 @@
 #include <linux/clk.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
 
 #include "ehci.h"
 
@@ -121,6 +123,8 @@ static const struct ehci_driver_overrides ehci_omap_overrides __initdata = {
 	.extra_priv_size = sizeof(struct omap_hcd),
 };
 
+static u64 omap_ehci_dma_mask = DMA_BIT_MASK(32);
+
 /**
  * ehci_hcd_omap_probe - initialize TI-based HCDs
  *
@@ -148,6 +152,17 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* For DT boot, get platform data from parent. i.e. usbhshost */
+	if (dev->of_node) {
+		pdata = dev->parent->platform_data;
+		dev->platform_data = pdata;
+	}
+
+	if (!pdata) {
+		dev_err(dev, "Missing platform data\n");
+		return -ENODEV;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "EHCI irq failed\n");
@@ -161,6 +176,14 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 	}
 
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &omap_ehci_dma_mask;
+
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, dev,
 			dev_name(dev));
 	if (!hcd) {
@@ -185,7 +208,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 			continue;
 
 		/* get the PHY device */
-		phy = devm_usb_get_phy_dev(dev, i);
+		if (dev->of_node)
+			phy = devm_usb_get_phy_by_phandle(dev, "phy", i);
+		else
+			phy = devm_usb_get_phy_dev(dev, i);
 		if (IS_ERR(phy) || !phy) {
 			ret = IS_ERR(phy) ? PTR_ERR(phy) : -ENODEV;
 			dev_err(dev, "Can't get PHY device for port %d: %d\n",
@@ -275,6 +301,13 @@ static void ehci_hcd_omap_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static const struct of_device_id omap_ehci_dt_ids[] = {
+	{ .compatible = "ti,omap-ehci" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, omap_ehci_dt_ids);
+
 static struct platform_driver ehci_hcd_omap_driver = {
 	.probe			= ehci_hcd_omap_probe,
 	.remove			= ehci_hcd_omap_remove,
@@ -283,6 +316,7 @@ static struct platform_driver ehci_hcd_omap_driver = {
 	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
 		.name		= hcd_name,
+		.of_match_table = of_match_ptr(omap_ehci_dt_ids),
 	}
 };
 
-- 
1.7.4.1

