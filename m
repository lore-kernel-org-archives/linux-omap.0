From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH v3 05/11] usb: dwc3: exynos: Enable runtime power management
Date: Mon, 01 Apr 2013 19:24:04 +0530
Message-ID: <1364824448-14732-6-git-send-email-gautam.vivek@samsung.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Enabling runtime power management on dwc3-exynos
letting dwc3 controller to be autosuspended on exynos
platform when not in use.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 1ea7bd8..1ae81a0 100644
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
@@ -138,6 +139,11 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	exynos->dev	= dev;
 	exynos->clk	= clk;
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+	pm_runtime_forbid(dev);
+
 	clk_prepare_enable(exynos->clk);
 
 	if (node) {
@@ -152,10 +158,14 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	pm_runtime_put_sync(dev);
+	pm_runtime_allow(dev);
+
 	return 0;
 
 err2:
 	clk_disable_unprepare(clk);
+	pm_runtime_disable(dev);
 err1:
 	return ret;
 }
@@ -164,6 +174,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 	device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_child);
-- 
1.7.6.5
