From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/10] usb: dwc3: core: refactor mode initialization to its own function
Date: Mon, 21 Apr 2014 10:56:46 -0500
Message-ID: <1398095812-14222-5-git-send-email-balbi@ti.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398095812-14222-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, leigh-0TD6cqJ6btAqdlJmJB21zg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Move mode (Host, Peripheral, OTG) initialization
to its own function in order to decrease the size
of our probe() routine.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/core.c | 133 ++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 38976f3..af8c8f6 100644
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
+		return -EINVAL;
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
