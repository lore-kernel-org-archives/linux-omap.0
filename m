From: Vikas C Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH 2/3] usb: xhci: Add the suspend/resume functionality
Date: Wed, 10 Oct 2012 19:35:48 +0530
Message-ID: <1349877949-18872-3-git-send-email-vikas.sajjan@linaro.org>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41802 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353Ab2JJOCV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 10:02:21 -0400
In-reply-to: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

From: Vikas Sajjan <vikas.sajjan@linaro.org>

Adding the suspend and resume functionality for the XHCI driver

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/host/xhci-plat.c |   44 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df90fe5..384cf4d 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -185,11 +185,55 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int xhci_plat_suspend(struct device *dev)
+{
+	struct usb_hcd		*hcd;
+	struct xhci_hcd		*xhci;
+
+	hcd = dev_get_drvdata(dev);
+	if (!hcd)
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(hcd);
+
+	/* Make sure that the HCD Core as set state HC_STATE_SUSPENDED */
+	if (hcd->state != HC_STATE_SUSPENDED ||
+		xhci->shared_hcd->state != HC_STATE_SUSPENDED)
+		return -EINVAL;
+
+	return xhci_suspend(xhci);
+}
+
+static int xhci_plat_resume(struct device *dev)
+{
+	struct usb_hcd		*hcd;
+	struct xhci_hcd		*xhci;
+
+	hcd = dev_get_drvdata(dev);
+
+	if (!hcd)
+		return -EINVAL;
+
+	xhci = hcd_to_xhci(hcd);
+
+	return xhci_resume(xhci, 0);
+}
+
+static const struct dev_pm_ops xhci_plat_pm_ops = {
+	.suspend		= xhci_plat_suspend,
+	.resume			= xhci_plat_resume,
+};
+#endif
+
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
 	.driver	= {
 		.name = "xhci-hcd",
+#ifdef CONFIG_PM
+		.pm = &xhci_plat_pm_ops,
+#endif
 	},
 };
 MODULE_ALIAS("platform:xhci-hcd");
-- 
1.7.6.5

