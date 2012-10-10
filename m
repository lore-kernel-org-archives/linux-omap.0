From: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] exynos5: usb: dwc3: Add the suspend/resume functionality
Date: Wed, 10 Oct 2012 19:35:49 +0530
Message-ID: <1349877949-18872-4-git-send-email-vikas.sajjan@linaro.org>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1349877949-18872-1-git-send-email-vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Adding the suspend and resume functionality to exynos dwc3 driver

Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-exynos.c |   60 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index ca65978..1154cee 100644
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
@@ -200,11 +201,70 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int dwc3_exynos_suspend(struct device *dev)
+{
+	struct dwc3_exynos_data	*pdata = dev->platform_data;
+	struct dwc3_exynos	*exynos;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	exynos = dev_get_drvdata(dev);
+
+	if (!exynos)
+		return -EINVAL;
+
+	if (pdata && pdata->phy_exit)
+		pdata->phy_exit(pdev, pdata->phy_type);
+
+	clk_disable(exynos->clk);
+
+	return 0;
+}
+
+static int dwc3_exynos_resume(struct device *dev)
+{
+	struct dwc3_exynos_data	*pdata = dev->platform_data;
+	struct dwc3_exynos	*exynos;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	exynos = dev_get_drvdata(dev);
+
+	if (!exynos)
+		return -EINVAL;
+
+	clk_enable(exynos->clk);
+
+	/* PHY initialization */
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "missing platform data\n");
+	} else {
+		if (pdata->phy_init)
+			pdata->phy_init(pdev, pdata->phy_type);
+	}
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
+#endif /* CONFIG_PM */
+
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove		= __devexit_p(dwc3_exynos_remove),
 	.driver		= {
 		.name	= "exynos-dwc3",
+#ifdef CONFIG_PM
+		.pm = &dwc3_exynos_pm_ops,
+#endif
+
 	},
 };
 
-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
