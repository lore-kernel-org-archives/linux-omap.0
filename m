From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 1/2] usb: dwc3: exynos: Use of_platform API to create dwc3
 core pdev
Date: Thu, 14 Mar 2013 18:09:49 +0530
Message-ID: <1363264789-4036-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iHZRfiSAXnbwhFNs4Rm7fzFx=v83pcWFJHsOo+JPya6VQ@mail.gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAFp+6iHZRfiSAXnbwhFNs4Rm7fzFx=v83pcWFJHsOo+JPya6VQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, dianders@chromium.org
List-Id: linux-omap@vger.kernel.org

Used of_platform_populate() to create dwc3 core platform_device
from device tree data. Additionally some cleanup is also done.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
CC: Felipe Balbi <balbi@ti.com>
CC: Kukjin Kim <kgene.kim@samsung.com>
---

Changes from v1:
 - Added method to unregister dwc3 core from dwc3_exynos_remove()
   using device_for_each_child() API, which we missed to do.

 drivers/usb/dwc3/dwc3-exynos.c |   56 ++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index e12e452..f77ec75 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -22,9 +22,9 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/nop-usb-xceiv.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 
 struct dwc3_exynos {
-	struct platform_device	*dwc3;
 	struct platform_device	*usb2_phy;
 	struct platform_device	*usb3_phy;
 	struct device		*dev;
@@ -86,21 +86,30 @@ err1:
 	return ret;
 }
 
+static int dwc3_exynos_remove_child(struct device *dev, void *unused)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
 static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
 
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
-	struct platform_device	*dwc3;
 	struct dwc3_exynos	*exynos;
 	struct clk		*clk;
 	struct device		*dev = &pdev->dev;
+	struct device_node	*node = dev->of_node;
 
 	int			ret = -ENOMEM;
 
 	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
 	if (!exynos) {
 		dev_err(dev, "not enough memory\n");
-		return -ENOMEM;
+		goto err1;
 	}
 
 	/*
@@ -108,21 +117,15 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	 * Since shared usb code relies on it, set it here for now.
 	 * Once we move to full device tree support this will vanish off.
 	 */
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
+	if (!dev->dma_mask)
+		dev->dma_mask = &dwc3_exynos_dma_mask;
 
 	platform_set_drvdata(pdev, exynos);
 
 	ret = dwc3_exynos_register_phys(exynos);
 	if (ret) {
 		dev_err(dev, "couldn't register PHYs\n");
-		return ret;
-	}
-
-	dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
-	if (!dwc3) {
-		dev_err(dev, "couldn't allocate dwc3 device\n");
-		return -ENOMEM;
+		goto err1;
 	}
 
 	clk = devm_clk_get(dev, "usbdrd30");
@@ -132,27 +135,20 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dma_set_coherent_mask(&dwc3->dev, dev->coherent_dma_mask);
-
-	dwc3->dev.parent = dev;
-	dwc3->dev.dma_mask = dev->dma_mask;
-	dwc3->dev.dma_parms = dev->dma_parms;
-	exynos->dwc3	= dwc3;
 	exynos->dev	= dev;
 	exynos->clk	= clk;
 
 	clk_enable(exynos->clk);
 
-	ret = platform_device_add_resources(dwc3, pdev->resource,
-			pdev->num_resources);
-	if (ret) {
-		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		goto err2;
-	}
-
-	ret = platform_device_add(dwc3);
-	if (ret) {
-		dev_err(dev, "failed to register dwc3 device\n");
+	if (node) {
+		ret = of_platform_populate(node, NULL, NULL, dev);
+		if (ret) {
+			dev_err(dev, "failed to add dwc3 core\n");
+			goto err2;
+		}
+	} else {
+		dev_err(dev, "no device node, failed to add dwc3 core\n");
+		ret = -ENODEV;
 		goto err2;
 	}
 
@@ -161,8 +157,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 err2:
 	clk_disable(clk);
 err1:
-	platform_device_put(dwc3);
-
 	return ret;
 }
 
@@ -170,9 +164,9 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
-	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
+	device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_child);
 
 	clk_disable(exynos->clk);
 
-- 
1.7.6.5
