From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH v2 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Sat, 13 Oct 2012 18:40:23 +0530
Message-ID: <1350133825-24181-2-git-send-email-vikas.sajjan@linaro.org>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19569 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab2JMNFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:05:03 -0400
In-reply-to: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Vikas C Sajjan <vikas.sajjan@linaro.org>, Doug Anderson <dianders@chromium.org>

Adding the suspend and resume funtionality to DWC3 core.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/dwc3/core.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b415c0c..0699061 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -622,11 +622,65 @@ static int __devexit dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int dwc3_resume(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	int	ret;
+
+	usb_phy_init(dwc->usb2_phy);
+	usb_phy_init(dwc->usb3_phy);
+
+	ret = dwc3_event_buffers_setup(dwc);
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
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+
+	dwc3_event_buffers_cleanup(dwc);
+
+	usb_phy_shutdown(dwc->usb2_phy);
+	usb_phy_shutdown(dwc->usb3_phy);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc3_pm_ops = {
+	.suspend		= dwc3_suspend,
+	.resume			= dwc3_resume,
+};
+#define DWC3_PM_OPS     &(dwc3_pm_ops)
+#else
+#define DWC3_PM_OPS     NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= __devexit_p(dwc3_remove),
 	.driver		= {
 		.name	= "dwc3",
+		.pm = DWC3_PM_OPS,
 	},
 };
 
-- 
1.7.6.5

