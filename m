From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH RFC] usb: dwc3: Set GCTL.PrtCapDir based on selected mode.
Date: Tue, 05 Feb 2013 19:15:58 +0530
Message-ID: <1360071958-20797-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Now that machines may select the mode of working of DWC3,
we can set the Port capability direction based on selected mode.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/dwc3/core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 177f4c6..f4c47f7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -479,7 +479,6 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case DWC3_MODE_DEVICE:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize gadget\n");
@@ -487,7 +486,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		}
 		break;
 	case DWC3_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize host\n");
@@ -495,7 +493,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		}
 		break;
 	case DWC3_MODE_DRD:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dev, "failed to initialize host\n");
@@ -514,6 +511,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	}
 	dwc->mode = mode;
 
+#if IS_ENABLED(CONFIG_USB_DWC3_HOST)
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+#elif IS_ENABLED(CONFIG_USB_DWC3_GADGET)
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+#else
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+#endif
+
 	ret = dwc3_debugfs_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize debugfs\n");
-- 
1.7.6.5
