From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH] usb: dwc3: omap: convert pdata to of property
Date: Wed, 25 Jan 2012 11:11:03 +0200
Message-ID: <1327482663-8652-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:45903 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752465Ab2AYJLL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 04:11:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>

Convert our platform_data usage to OF property,
keep the legacy pdata for a while until the complete
conversion is done.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 5809bf4..71f1ace 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -46,6 +46,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/module.h>
 
 #include "core.h"
@@ -197,14 +198,18 @@ static irqreturn_t dwc3_omap_interrupt(int irq, void *_omap)
 static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 {
 	struct dwc3_omap_data	*pdata = pdev->dev.platform_data;
+	struct device_node	*node = pdev->dev.of_node;
+
 	struct platform_device	*dwc3;
 	struct dwc3_omap	*omap;
 	struct resource		*res;
 
 	int			devid;
+	int			size;
 	int			ret = -ENOMEM;
 	int			irq;
 
+	const u32		*utmi_mode;
 	u32			reg;
 
 	void __iomem		*base;
@@ -269,19 +274,24 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
 
 	reg = dwc3_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 
-	if (!pdata) {
-		dev_dbg(&pdev->dev, "missing platform data\n");
+	utmi_mode = of_get_property(node, "utmi-mode", &size);
+	if (utmi_mode && size == sizeof(*utmi_mode)) {
+		reg |= *utmi_mode;
 	} else {
-		switch (pdata->utmi_mode) {
-		case DWC3_OMAP_UTMI_MODE_SW:
-			reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-			break;
-		case DWC3_OMAP_UTMI_MODE_HW:
-			reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-			break;
-		default:
-			dev_dbg(&pdev->dev, "UNKNOWN utmi mode %d\n",
-					pdata->utmi_mode);
+		if (!pdata) {
+			dev_dbg(&pdev->dev, "missing platform data\n");
+		} else {
+			switch (pdata->utmi_mode) {
+			case DWC3_OMAP_UTMI_MODE_SW:
+				reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+				break;
+			case DWC3_OMAP_UTMI_MODE_HW:
+				reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+				break;
+			default:
+				dev_dbg(&pdev->dev, "UNKNOWN utmi mode %d\n",
+						pdata->utmi_mode);
+			}
 		}
 	}
 
-- 
1.7.8.2

