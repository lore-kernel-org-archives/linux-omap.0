From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 01/13] usb: phy: nop: Add device tree support and binding information
Date: Mon, 4 Feb 2013 17:58:48 +0200
Message-ID: <1359993540-20780-2-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58415 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962Ab3BDP7R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:59:17 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rogerq@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

The PHY clock, clock rate, VCC regulator and RESET regulator
can now be provided via device tree.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++++
 drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
new file mode 100644
index 0000000..d7e2726
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
@@ -0,0 +1,34 @@
+USB NOP PHY
+
+Required properties:
+- compatible: should be usb-nop-xceiv
+
+Optional properties:
+- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
+  /bindings/clock/clock-bindings.txt
+  This property is required if clock-frequency is specified.
+
+- clock-names: Should be "main_clk"
+
+- clock-frequency: the clock frequency (in Hz) that the PHY clock must
+  be configured to.
+
+- vcc-supply: phandle to the regulator that provides RESET to the PHY.
+
+- reset-supply: phandle to the regulator that provides power to the PHY.
+
+Example:
+
+	hsusb1_phy {
+		compatible = "usb-nop-xceiv";
+		clock-frequency = <19200000>;
+		clocks = <&osc 0>;
+		clock-names = "main_clk";
+		vcc-supply = <&hsusb1_vcc_regulator>;
+		reset-supply = <&hsusb1_reset_regulator>;
+	};
+
+hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
+and expects that clock to be configured to 19.2MHz by the NOP PHY driver.
+hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regulator
+controls RESET.
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index ac027a1..adbb7ab 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of.h>
 
 struct nop_usb_xceiv {
 	struct usb_phy		phy;
@@ -138,8 +139,19 @@ static int nop_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static void nop_xeiv_get_dt_pdata(struct device *dev,
+				struct nop_usb_xceiv_platform_data *pdata)
+{
+	struct device_node *node = dev->of_node;
+	u32 clk_rate;
+
+	if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
+		pdata->clk_rate = clk_rate;
+}
+
 static int nop_usb_xceiv_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct nop_usb_xceiv_platform_data *pdata = pdev->dev.platform_data;
 	struct nop_usb_xceiv	*nop;
 	enum usb_phy_type	type = USB_PHY_TYPE_USB2;
@@ -153,6 +165,17 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
 	if (!nop->phy.otg)
 		return -ENOMEM;
 
+	if (dev->of_node) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(dev, "Memory allocation failure\n");
+			return -ENOMEM;
+		}
+		nop_xeiv_get_dt_pdata(dev, pdata);
+	} else {
+		pdata = dev->platform_data;
+	}
+
 	if (pdata)
 		type = pdata->type;
 
@@ -236,12 +259,20 @@ static int nop_usb_xceiv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id nop_xceiv_dt_ids[] = {
+	{ .compatible = "usb-nop-xceiv" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, nop_xceiv_dt_ids);
+
 static struct platform_driver nop_usb_xceiv_driver = {
 	.probe		= nop_usb_xceiv_probe,
 	.remove		= nop_usb_xceiv_remove,
 	.driver		= {
 		.name	= "nop_usb_xceiv",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(nop_xceiv_dt_ids),
 	},
 };
 
-- 
1.7.4.1

