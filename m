From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
Date: Thu, 12 Dec 2013 15:38:45 -0600
Message-ID: <1386884325-11440-8-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

teach Exynos glue about pm_runtime so that
it's easier to teach dwc3 core about it
later.

No functional changes otherwise.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 65 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 6ccfc64..c93919a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -141,24 +141,40 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 	exynos->dev	= dev;
 	exynos->clk	= clk;
 
-	clk_prepare_enable(exynos->clk);
+	ret = clk_prepare(exynos->clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare clock\n");
+		goto err2;
+	}
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret) {
+		dev_err(dev, "failed to enable dwc3 device\n");
+		goto err3;
+	}
 
 	if (node) {
 		ret = of_platform_populate(node, NULL, NULL, dev);
 		if (ret) {
 			dev_err(dev, "failed to add dwc3 core\n");
-			goto err2;
+			goto err3;
 		}
 	} else {
 		dev_err(dev, "no device node, failed to add dwc3 core\n");
 		ret = -ENODEV;
-		goto err2;
+		goto err3;
 	}
 
 	return 0;
 
+err3:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
 err2:
-	clk_disable_unprepare(clk);
+	clk_unprepare(clk);
+
 err1:
 	return ret;
 }
@@ -171,7 +187,9 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
 
-	clk_disable_unprepare(exynos->clk);
+	pm_runtime_put_sync(exynos->dev);
+	pm_runtime_disable(exynos->dev);
+	clk_unprepare(exynos->clk);
 
 	return 0;
 }
@@ -184,20 +202,33 @@ static const struct of_device_id exynos_dwc3_match[] = {
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 #endif
 
-static int dwc3_exynos_suspend(struct device *dev)
+static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
 {
-	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
-
 	clk_disable(exynos->clk);
 
 	return 0;
 }
 
+static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
+{
+	return clk_enable(exynos->clk);
+}
+
+static int dwc3_exynos_suspend(struct device *dev)
+{
+	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+
+	return __dwc3_exynos_suspend(exynos);
+}
+
 static int dwc3_exynos_resume(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+	int ret;
 
-	clk_enable(exynos->clk);
+	ret = __dwc3_exynos_resume(exynos);
+	if (ret)
+		return ret;
 
 	/* runtime set active to reflect active state. */
 	pm_runtime_disable(dev);
@@ -207,8 +238,24 @@ static int dwc3_exynos_resume(struct device *dev)
 	return 0;
 }
 
+static int dwc3_exynos_runtime_suspend(struct device *dev)
+{
+	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+
+	return __dwc3_exynos_suspend(exynos);
+}
+
+static int dwc3_exynos_runtime_resume(struct device *dev)
+{
+	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
+
+	return __dwc3_exynos_resume(exynos);
+}
+
 static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
+	SET_RUNTIME_PM_OPS(dwc3_exynos_runtime_suspend,
+			dwc3_exynos_runtime_resume, NULL)
 };
 
 static struct platform_driver dwc3_exynos_driver = {
-- 
1.8.4.GIT
