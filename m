From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH v2 3/3] exynos5: usb: dwc3: Add the suspend/resume functionality
Date: Sat, 13 Oct 2012 18:40:25 +0530
Message-ID: <1350133825-24181-4-git-send-email-vikas.sajjan@linaro.org>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47800 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab2JMNFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:05:07 -0400
In-reply-to: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Vikas C Sajjan <vikas.sajjan@linaro.org>, Doug Anderson <dianders@chromium.org>

Adding the suspend and resume functionality to exynos dwc3 driver

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/dwc3-exynos.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index ca65978..2781301 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dwc3-exynos.h>
 #include <linux/dma-mapping.h>
@@ -200,11 +201,49 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int dwc3_exynos_suspend(struct device *dev)
+{
+	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+
+	BUG_ON(!exynos);
+
+	clk_disable(exynos->clk);
+
+	return 0;
+}
+
+static int dwc3_exynos_resume(struct device *dev)
+{
+	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+
+	BUG_ON(!exynos);
+
+	clk_enable(exynos->clk);
+
+	/* runtime set active to reflect active state. */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_exynos_pm_ops = {
+	.suspend		= dwc3_exynos_suspend,
+	.resume			= dwc3_exynos_resume,
+};
+#define DWC3_EXYNOS_DEV_PM_OPS  &(dwc3_exynos_pm_ops)
+#else
+#define DWC3_EXYNOS_DEV_PM_OPS  NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove		= __devexit_p(dwc3_exynos_remove),
 	.driver		= {
 		.name	= "exynos-dwc3",
+		.pm = DWC3_EXYNOS_DEV_PM_OPS,
 	},
 };
 
-- 
1.7.6.5

