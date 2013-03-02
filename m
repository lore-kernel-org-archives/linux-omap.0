From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v2 05/10] usb: dwc3: exynos: Enable runtime power management
Date: Sat, 02 Mar 2013 18:53:06 +0530
Message-ID: <1362230590-20960-6-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Enabling runtime power management on dwc3-exynos
letting dwc3 controller to be autosuspended on exynos
platform when not in use.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index e6771d9..28b5f8a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -19,6 +19,7 @@
 #include <linux/platform_data/dwc3-exynos.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/nop-usb-xceiv.h>
 #include <linux/of.h>
@@ -143,6 +144,10 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	exynos->dev	= dev;
 	exynos->clk	= clk;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_forbid(dev);
+
 	clk_enable(exynos->clk);
 
 	ret = platform_device_add_resources(dwc3, pdev->resource,
@@ -158,10 +163,14 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	pm_runtime_put_sync(dev);
+	pm_runtime_allow(dev);
+
 	return 0;
 
 err2:
 	clk_disable(clk);
+	pm_runtime_disable(dev);
 err1:
 	platform_device_put(dwc3);
 
@@ -172,6 +181,10 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
+	if (!pm_runtime_suspended(&pdev->dev))
+		pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
-- 
1.7.6.5
