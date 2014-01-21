From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library returns -ENODEV/-ENXIO
Date: Tue, 21 Jan 2014 15:41:38 +0530
Message-ID: <1390299099-14764-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385373690-12170-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: george.cherian-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
do not return from probe if the USB PHY library returns -ENODEV as that
indicates the platform does not have PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/core.c |   34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a49217a..e009d4e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -411,32 +411,26 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	if (IS_ERR(dwc->usb2_phy)) {
 		ret = PTR_ERR(dwc->usb2_phy);
-
-		/*
-		 * if -ENXIO is returned, it means PHY layer wasn't
-		 * enabled, so it makes no sense to return -EPROBE_DEFER
-		 * in that case, since no PHY driver will ever probe.
-		 */
-		if (ret == -ENXIO)
+		if (ret == -ENXIO || ret == -ENODEV) {
+			dwc->usb2_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
 			return ret;
-
-		dev_err(dev, "no usb2 phy configured\n");
-		return -EPROBE_DEFER;
+		} else {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
 	}
 
 	if (IS_ERR(dwc->usb3_phy)) {
 		ret = PTR_ERR(dwc->usb3_phy);
-
-		/*
-		 * if -ENXIO is returned, it means PHY layer wasn't
-		 * enabled, so it makes no sense to return -EPROBE_DEFER
-		 * in that case, since no PHY driver will ever probe.
-		 */
-		if (ret == -ENXIO)
+		if (ret == -ENXIO || ret == -ENODEV) {
+			dwc->usb3_phy = NULL;
+		} else if (ret == -EPROBE_DEFER) {
 			return ret;
