From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 07/13] USB: ohci-omap3: Add device tree support and binding information
Date: Mon, 4 Feb 2013 17:58:54 +0200
Message-ID: <1359993540-20780-8-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42973 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab3BDP7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:59:40 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rogerq@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

Allows the OHCI controller found in OMAP3 and later chips to
be specified via device tree.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/omap3-ohci.txt         |   17 +++++++++++++++++
 drivers/usb/host/ohci-omap3.c                      |   19 +++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/omap3-ohci.txt

diff --git a/Documentation/devicetree/bindings/usb/omap3-ohci.txt b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
new file mode 100644
index 0000000..aabbfdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/omap3-ohci.txt
@@ -0,0 +1,17 @@
+OMAP HS USB OHCI controller (OMAP3 and later)
+
+Required properties:
+
+- compatible: should be "ti,omap3-ohci"
+- reg: should contain one register range i.e. start and length
+- interrupt-parent: phandle to the interrupt controller
+- interrupts: description of the interrupt line
+
+Example for OMAP4:
+
+usbhsohci: ohci@0x4a064800 {
+	compatible = "ti,omap3-ohci", "usb-ohci";
+	reg = <0x4a064800 0x400>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 76 0x4>;
+};
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index 5ed28c5..b0bfab1 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -31,6 +31,8 @@
 
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -112,6 +114,8 @@ static const struct hc_driver ohci_omap3_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
+static u64 omap_ohci_dma_mask = DMA_BIT_MASK(32);
+
 /*
  * configure so an HC device and id are always provided
  * always called with process context; sleeping is OK
@@ -159,6 +163,13 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	/*
+	 * Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &omap_ohci_dma_mask;
 
 	hcd = usb_create_hcd(&ohci_omap3_hc_driver, dev,
 			dev_name(dev));
@@ -228,12 +239,20 @@ static void ohci_hcd_omap3_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static const struct of_device_id omap_ohci_dt_ids[] = {
+	{ .compatible = "ti,omap3-ohci" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, omap_ohci_dt_ids);
+
 static struct platform_driver ohci_hcd_omap3_driver = {
 	.probe		= ohci_hcd_omap3_probe,
 	.remove		= ohci_hcd_omap3_remove,
 	.shutdown	= ohci_hcd_omap3_shutdown,
 	.driver		= {
 		.name	= "ohci-omap3",
+		.of_match_table = of_match_ptr(omap_ohci_dt_ids),
 	},
 };
 
-- 
1.7.4.1

