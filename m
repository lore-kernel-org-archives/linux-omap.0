From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 04/11] dwc3: exynos: Add provision for AXI UpScaler clock on
 exynos7
Date: Fri, 21 Nov 2014 19:05:47 +0530
Message-ID: <1416576954-11997-5-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, kishon@ti.com
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, tomasz.figa@gmail.com, s.nawrocki@samsung.com, robh+dt@kernel.org, stern@rowland.harvard.edu, kgene.kim@samsung.com, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

DWC3 controller on Exynos7 SoC has separate control for
AXI UpScaler which connects DWC3 DRD controller to AXI bus.
Get the gate clock for the same to control it across power
cycles.

Suggested-by: Anton Tikhomirov <av.tikhomirov@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 Documentation/devicetree/bindings/usb/exynos-usb.txt |    6 ++++--
 drivers/usb/dwc3/dwc3-exynos.c                       |   17 +++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index a3b5990..9b4dbe3 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -82,8 +82,10 @@ Example:
 
 DWC3
 Required properties:
- - compatible: should be "samsung,exynos5250-dwusb3" for USB 3.0 DWC3
-	       controller.
+ - compatible: should be one of the following -
+	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
+					    Exynos5250/5420.
+	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
  - #address-cells, #size-cells : should be '1' if the device has sub-nodes
 				 with 'reg' property.
  - ranges: allows valid 1:1 translation between child's address space and
diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index af15ab3..6ae8fe5 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -36,6 +36,7 @@ struct dwc3_exynos {
 
 	struct clk		*clk;
 	struct clk		*susp_clk;
+	struct clk		*axius_clk;
 
 	struct regulator	*vdd33;
 	struct regulator	*vdd10;
@@ -150,6 +151,17 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	}
 	clk_prepare_enable(exynos->susp_clk);
 
+	if (of_device_is_compatible(node, "samsung,exynos7-dwusb3")) {
+		exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
+		if (IS_ERR(exynos->axius_clk)) {
+			dev_err(dev, "no AXI UpScaler clk specified\n");
+			return -ENODEV;
+		}
+		clk_prepare_enable(exynos->axius_clk);
+	} else {
+		exynos->axius_clk = NULL;
+	}
+
 	exynos->vdd33 = devm_regulator_get(dev, "vdd33");
 	if (IS_ERR(exynos->vdd33)) {
 		ret = PTR_ERR(exynos->vdd33);
@@ -191,6 +203,7 @@ err4:
 err3:
 	regulator_disable(exynos->vdd33);
 err2:
+	clk_disable_unprepare(exynos->axius_clk);
 	clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 	return ret;
@@ -204,6 +217,7 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
+	clk_disable_unprepare(exynos->axius_clk);
 	clk_disable_unprepare(exynos->susp_clk);
 	clk_disable_unprepare(exynos->clk);
 
@@ -216,6 +230,7 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_dwc3_match[] = {
 	{ .compatible = "samsung,exynos5250-dwusb3" },
+	{ .compatible = "samsung,exynos7-dwusb3" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
@@ -226,6 +241,7 @@ static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
 
+	clk_disable(exynos->axius_clk);
 	clk_disable(exynos->clk);
 
 	regulator_disable(exynos->vdd33);
@@ -251,6 +267,7 @@ static int dwc3_exynos_resume(struct device *dev)
 	}
 
 	clk_enable(exynos->clk);
+	clk_enable(exynos->axius_clk);
 
 	/* runtime set active to reflect active state. */
 	pm_runtime_disable(dev);
-- 
1.7.10.4
