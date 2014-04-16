From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/8] usb: dwc3: core: refactor mode initialization to its own function
Date: Wed, 16 Apr 2014 16:26:30 -0500
Message-ID: <1397683595-3606-4-git-send-email-balbi@ti.com>
References: <1397683595-3606-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbaDPV3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 17:29:15 -0400
In-Reply-To: <1397683595-3606-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, kgene.kim@samsung.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Roger Quadros <rogerq@ti.com>, George Cherian <george.cherian@ti.com>, bigeasy@linutronix.de, aaro.koskinen@iki.fi, heikki.krogerus@linux.intel.com, zhangwm@marvell.com, David Cohen <david.a.cohen@linux.intel.com>, Felipe Balbi <balbi@ti.com>

Move mode (Host, Peripheral, OTG) initialization
to its own function in order to decrease the size
of our probe() routine.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/core.c | 133 ++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 38976f3..2a68aea 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -553,6 +553,69 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_core_init_mode(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	int ret;
+
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		ret = dwc3_gadget_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize gadget\n");
+			return ret;
+		}
+		break;
+	case USB_DR_MODE_HOST:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		ret = dwc3_host_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize host\n");
+			return ret;
+		}
+		break;
+	case USB_DR_MODE_OTG:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		ret = dwc3_host_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize host\n");
+			return ret;
+		}
+
+		ret = dwc3_gadget_init(dwc);
+		if (ret) {
+			dev_err(dev, "failed to initialize gadget\n");
+			return ret;
+		}
+		break;
+	default:
+		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dwc3_core_exit_mode(struct dwc3 *dwc)
+{
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		dwc3_gadget_exit(dwc);
+		break;
+	case USB_DR_MODE_HOST:
+		dwc3_host_exit(dwc);
+		break;
+	case USB_DR_MODE_OTG:
+		dwc3_host_exit(dwc);
+		dwc3_gadget_exit(dwc);
+		break;
+	default:
+		/* do nothing */
+		break;
+	}
+}
+
 #define DWC3_ALIGN_MASK		(16 - 1)
 
 static int dwc3_probe(struct platform_device *pdev)
@@ -682,41 +745,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err_usb3phy_power;
 	}
 
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
-			goto err2;
-		}
-		break;
-	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
-			goto err2;
-		}
-		break;
-	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dev, "failed to initialize host\n");
-			goto err2;
-		}
-
-		ret = dwc3_gadget_init(dwc);
-		if (ret) {
-			dev_err(dev, "failed to initialize gadget\n");
-			goto err2;
-		}
-		break;
-	default:
-		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
+	ret = dwc3_core_init_mode(dwc);
+	if (ret)
 		goto err2;
-	}
 
 	ret = dwc3_debugfs_init(dwc);
 	if (ret) {
@@ -729,21 +760,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	return 0;
 
 err3:
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-		dwc3_gadget_exit(dwc);
-		break;
-	case USB_DR_MODE_HOST:
-		dwc3_host_exit(dwc);
-		break;
-	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
+	dwc3_core_exit_mode(dwc);
 
 err2:
 	dwc3_event_buffers_cleanup(dwc);
@@ -778,23 +795,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	dwc3_debugfs_exit(dwc);
-
-	switch (dwc->dr_mode) {
-	case USB_DR_MODE_PERIPHERAL:
-		dwc3_gadget_exit(dwc);
-		break;
-	case USB_DR_MODE_HOST:
-		dwc3_host_exit(dwc);
-		break;
-	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-
+	dwc3_core_exit_mode(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 	dwc3_free_event_buffers(dwc);
 	dwc3_core_exit(dwc);
-- 
1.9.2.459.g68773ac

