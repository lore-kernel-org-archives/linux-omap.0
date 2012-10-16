From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 15:15:36 +0530
Message-ID: <1350380738-32473-2-git-send-email-vikas.sajjan@linaro.org>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16529 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2JPJmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 05:42:15 -0400
In-reply-to: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Vikas C Sajjan <vikas.sajjan@linaro.org>, Doug Anderson <dianders@chromium.org>

Adds suspend and resume callbacks as part of the power management
support to DWC3 controller Driver.
This patch facilitates transition of DWC3 controller between D0 and D3
power states during suspend/resume cycles.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5db4c76..9f35cf8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -621,11 +621,55 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int dwc3_resume(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+	int	ret;
+
+	ret = dwc3_core_init(dwc);
+	if (ret < 0)
+		return ret;
+
+	switch (dwc->mode) {
+	case DWC3_MODE_DEVICE:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		break;
+	case DWC3_MODE_HOST:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		break;
+	case DWC3_MODE_DRD:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
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
+static int dwc3_suspend(struct device *dev)
+{
+	struct dwc3 *dwc = dev_get_drvdata(dev);
+
+	dwc3_core_exit(dwc);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops dwc3_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
+};
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= __devexit_p(dwc3_remove),
 	.driver		= {
 		.name	= "dwc3",
+		.pm	= &dwc3_pm_ops,
 	},
 };
 
-- 
1.7.6.5

