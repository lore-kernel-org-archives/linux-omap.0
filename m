From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] usb: dwc3: exynos: Use of_platform API to create dwc3 core
 pdev
Date: Thu, 14 Mar 2013 16:14:57 +0530
Message-ID: <1363257898-17504-2-git-send-email-gautam.vivek@samsung.com>
References: <1363257898-17504-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <1363257898-17504-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Used of_platform_populate() to create dwc3 core platform_device
from device tree data. Additionally some cleanup is also done.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
CC: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
CC: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-exynos.c |   46 +++++++++++++---------------------------
 1 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index e12e452..66ca9ac 100644
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
@@ -90,17 +90,17 @@ static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
 
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
@@ -108,21 +108,15 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
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
@@ -132,27 +126,20 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
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
 
@@ -161,8 +148,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 err2:
 	clk_disable(clk);
 err1:
-	platform_device_put(dwc3);
-
 	return ret;
 }
 
@@ -170,7 +155,6 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
-	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
-- 
1.7.6.5
