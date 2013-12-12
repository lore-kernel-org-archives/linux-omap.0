From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/7] usb: dwc3: keystone: add basic PM support
Date: Thu, 12 Dec 2013 15:38:39 -0600
Message-ID: <1386884325-11440-2-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab3LLVju (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 16:39:50 -0500
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

A bare-minimum PM implementation which will
server as building block for more complex
PM implementation in the future.

At the least will not leave clocks on unnecessarily
when e.g.  a user write mem to /sys/power/state.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 1fad161..361437f 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
 
@@ -118,13 +119,23 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
 
-	error = clk_prepare_enable(kdwc->clk);
+	error = clk_prepare(kdwc->clk);
 	if (error < 0) {
 		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
 			error);
 		return error;
 	}
 
+	pm_runtime_enable(dev);
+
+	error = pm_runtime_get_sync(dev);
+	if (error < 0) {
+		dev_dbg(dev, "unable to pm_runtime_get_sync(), err %d\n",
+				error);
+		pm_runtime_put_sync(dev);
+		goto err_runtime_get;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing irq\n");
@@ -151,8 +162,13 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 err_core:
 	kdwc3_disable_irqs(kdwc);
+
 err_irq:
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(dev);
+
+err_runtime_get:
+	pm_runtime_disable(dev);
+	clk_unprepare(kdwc->clk);
 
 	return error;
 }
@@ -172,7 +188,9 @@ static int kdwc3_remove(struct platform_device *pdev)
 
 	kdwc3_disable_irqs(kdwc);
 	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
-	clk_disable_unprepare(kdwc->clk);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(kdwc->clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -184,6 +202,79 @@ static const struct of_device_id kdwc3_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, kdwc3_of_match);
 
+static int __kdwc3_suspend(struct dwc3_keystone *kdwc)
+{
+	clk_disable(kdwc->clk);
+
+	return 0;
+}
+
+static int __kdwc3_resume(struct dwc3_keystone *kdwc)
+{
+	return clk_enable(kdwc->clk);
+}
+
+static int kdwc3_prepare(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	kdwc3_disable_irqs(kdwc);
+
+	return 0;
+}
+
+static void kdwc3_complete(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	kdwc3_enable_irqs(kdwc);
+}
+
+static int kdwc3_suspend(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_suspend(kdwc);
+}
+
+static int kdwc3_resume(struct device *dev)
+{
+	struct dwc3_keystone	*kdwc = dev_get_drvdata(dev);
+	int			ret;
+
+	ret = __kdwc3_resume(kdwc);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int kdwc3_runtime_suspend(struct device *dev)
+{
+	struct dwc3_keystone *kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_suspend(kdwc);
+}
+
+static int kdwc3_runtime_resume(struct device *dev)
+{
+	struct dwc3_keystone *kdwc = dev_get_drvdata(dev);
+
+	return __kdwc3_resume(kdwc);
+}
+
+static const struct dev_pm_ops kdwc3_dev_pm_ops = {
+	.prepare	= kdwc3_prepare,
+	.complete	= kdwc3_complete,
+
+	SET_SYSTEM_SLEEP_PM_OPS(kdwc3_suspend, kdwc3_resume)
+	SET_RUNTIME_PM_OPS(kdwc3_runtime_suspend, kdwc3_runtime_resume, NULL)
+};
+
 static struct platform_driver kdwc3_driver = {
 	.probe		= kdwc3_probe,
 	.remove		= kdwc3_remove,
-- 
1.8.4.GIT

