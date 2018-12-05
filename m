From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/3] usb: dwc3: keystone: Add support for ti,am654-dwc3
Date: Wed, 5 Dec 2018 17:14:39 +0200
Message-ID: <1544022879-5704-4-git-send-email-rogerq@ti.com>
References: <1544022879-5704-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544022879-5704-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, robh+dt@kernel.org, nsekhar@ti.com, t-kristo@ti.com, vigneshr@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

The AM654 SoC contains a DWC3 controller with TI specific
wrapper. Add support for that.

Unlike the Keystone 2 case, for AM654 We don't need to
process any IRQs for basic USB operation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/Kconfig         |  6 +++---
 drivers/usb/dwc3/dwc3-keystone.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 1a0404f..a83a84f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -86,11 +86,11 @@ config USB_DWC3_HAPS
 	  platform, please say 'Y' or 'M' here.
 
 config USB_DWC3_KEYSTONE
-	tristate "Texas Instruments Keystone2 Platforms"
-	depends on ARCH_KEYSTONE || COMPILE_TEST
+	tristate "Texas Instruments Keystone2/3 Platforms"
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	default USB_DWC3
 	help
-	  Support of USB2/3 functionality in TI Keystone2 platforms.
+	  Support of USB2/3 functionality in TI Keystone2/3 platforms.
 	  Say 'Y' or 'M' here if you have one such device
 
 config USB_DWC3_OF_SIMPLE
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 193a9a8..cbee5fb 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -106,6 +106,10 @@ static int kdwc3_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
+	/* IRQ processing not required currently for AM65 */
+	if (of_device_is_compatible(node, "ti,am654-dwc3"))
+		goto skip_irq;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing irq\n");
@@ -123,6 +127,7 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	kdwc3_enable_irqs(kdwc);
 
+skip_irq:
 	error = of_platform_populate(node, NULL, NULL, dev);
 	if (error) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");
@@ -152,8 +157,11 @@ static int kdwc3_remove_core(struct device *dev, void *c)
 static int kdwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	if (!of_device_is_compatible(node, "ti,am654-dwc3"))
+		kdwc3_disable_irqs(kdwc);
 
-	kdwc3_disable_irqs(kdwc);
 	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
 	pm_runtime_put_sync(kdwc->dev);
 	pm_runtime_disable(kdwc->dev);
@@ -165,6 +173,7 @@ static int kdwc3_remove(struct platform_device *pdev)
 
 static const struct of_device_id kdwc3_of_match[] = {
 	{ .compatible = "ti,keystone-dwc3", },
+	{ .compatible = "ti,am654-dwc3" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, kdwc3_of_match);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
