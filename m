From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH v3 2/3] usb: xhci: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 15:15:37 +0530
Message-ID: <1350380738-32473-3-git-send-email-vikas.sajjan@linaro.org>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49599 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2JPJnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 05:43:40 -0400
In-reply-to: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Vikas C Sajjan <vikas.sajjan@linaro.org>, Doug Anderson <dianders@chromium.org>

Adds power management support to XHCI platform driver.
This patch facilitates the transition of xHCI host controller
between S0 and S3/S4 power states, during suspend/resume cycles.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/host/xhci-plat.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df90fe5..eaf3a07 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -185,11 +185,39 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int xhci_plat_suspend(struct device *dev)
+{
+	struct usb_hcd	*hcd	= dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci	= hcd_to_xhci(hcd);
+
+	/* Make sure that the HCD Core has set state to HC_STATE_SUSPENDED */
+	if (hcd->state != HC_STATE_SUSPENDED ||
+		xhci->shared_hcd->state != HC_STATE_SUSPENDED)
+		return -EINVAL;
+
+	return xhci_suspend(xhci);
+}
+
+static int xhci_plat_resume(struct device *dev)
+{
+	struct usb_hcd	*hcd	= dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci	= hcd_to_xhci(hcd);
+
+	return xhci_resume(xhci, 0);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops xhci_plat_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
+};
+
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
 	.driver	= {
 		.name = "xhci-hcd",
+		.pm = &xhci_plat_pm_ops,
 	},
 };
 MODULE_ALIAS("platform:xhci-hcd");
-- 
1.7.6.5

