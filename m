From: Vikas Sajjan <vikas.sajjan@linaro.org>
Subject: [PATCH v2 2/3] usb: xhci: Add the suspend/resume functionality
Date: Sat, 13 Oct 2012 18:40:24 +0530
Message-ID: <1350133825-24181-3-git-send-email-vikas.sajjan@linaro.org>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47800 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab2JMNFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:05:06 -0400
In-reply-to: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Vikas C Sajjan <vikas.sajjan@linaro.org>, Doug Anderson <dianders@chromium.org>

Adding the suspend and resume functionality for the XHCI driver

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
CC: Doug Anderson <dianders@chromium.org>
---
 drivers/usb/host/xhci-plat.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df90fe5..15c7c89 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -185,11 +185,44 @@ static int xhci_plat_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
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
+	struct usb_hcd	*hcdi	= dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci	= hcd_to_xhci(hcd);
+
+	return xhci_resume(xhci, 0);
+}
+
+static const struct dev_pm_ops xhci_plat_pm_ops = {
+	.suspend		= xhci_plat_suspend,
+	.resume			= xhci_plat_resume,
+};
+
+#define XHCI_PLAT_PM_OPS        (&xhci_plat_pm_ops)
+#else
+#define XHCI_PLAT_PM_OPS        NULL
+#endif
+
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
 	.driver	= {
 		.name = "xhci-hcd",
+		.pm = XHCI_PLAT_PM_OPS,
 	},
 };
 MODULE_ALIAS("platform:xhci-hcd");
-- 
1.7.6.5

