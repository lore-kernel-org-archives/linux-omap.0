From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 3/4] usb: dwc3: exynos: Enable runtime power management
Date: Mon, 28 Jan 2013 17:12:27 +0530
Message-ID: <1359373348-18320-4-git-send-email-gautam.vivek@samsung.com>
References: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1359373348-18320-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, sarah.a.sharp@linux.intel.com, kgene.kim@samsung.com, dianders@chromium.org, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com
List-Id: linux-omap@vger.kernel.org

Enabling runtime power management on dwc3-exynos to save
power and allow its PHY's power to be managed at runtime.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c |   47 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index aae5328..c51e8c1 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -157,11 +157,15 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 err4:
 	clk_disable(clk);
 	clk_put(clk);
+	pm_runtime_disable(&pdev->dev);
 err3:
 	platform_device_put(dwc3);
 err1:
@@ -174,6 +178,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	platform_device_unregister(exynos->dwc3);
 	platform_device_unregister(exynos->usb2_phy);
 	platform_device_unregister(exynos->usb3_phy);
@@ -186,6 +192,46 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int dwc3_exynos_runtime_suspend(struct device *dev)
+{
+	struct dwc3_exynos	*exynos = dev_get_drvdata(dev);
+	struct platform_device	*pdev_dwc = exynos->dwc3;
+	struct dwc3		*dwc = NULL;
+
+	dwc = platform_get_drvdata(pdev_dwc);
+
+	if (!dwc)
+		return 0;
+
+	pm_runtime_put_sync(dwc->usb3_phy->dev);
+
+	clk_disable(exynos->clk);
+
+	return 0;
+}
+static int dwc3_exynos_runtime_resume(struct device *dev)
+{
+	struct dwc3_exynos	*exynos = dev_get_drvdata(dev);
+	struct platform_device	*pdev_dwc = exynos->dwc3;
+	struct dwc3		*dwc = NULL;
+
+	dwc = platform_get_drvdata(pdev_dwc);
+
+	clk_enable(exynos->clk);
+
+	if (!dwc)
+		return 0;
+
+	pm_runtime_get_sync(dwc->usb3_phy->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_exynos_pm_ops = {
+	SET_RUNTIME_PM_OPS(dwc3_exynos_runtime_suspend,
+				dwc3_exynos_runtime_resume, NULL)
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_dwc3_match[] = {
 	{ .compatible = "samsung,exynos-dwc3" },
@@ -200,6 +246,7 @@ static struct platform_driver dwc3_exynos_driver = {
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = of_match_ptr(exynos_dwc3_match),
+		.pm	= &dwc3_exynos_pm_ops,
 	},
 };
 
-- 
1.7.6.5
