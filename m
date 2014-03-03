From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 1/6] usb: dwc3: core: support optional PHYs
Date: Mon, 3 Mar 2014 17:08:10 +0530
Message-ID: <1393846695-14644-2-git-send-email-kishon@ti.com>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1393846695-14644-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, george.cherian@ti.com, heikki.krogerus@linux.intel.com, rogerq@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, kishon@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Since PHYs for dwc3 is optional (not all SoCs having PHYs for DWC3
should be programmed), do not return from probe if the USB PHY library
returns -ENODEV as that indicates the platform does not have a
programmable PHY.

While this can be considered as a temporary fix, a long term solution
would be to add 'nop' PHY for platforms that does not have programmable
PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c |   34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7d0cb34..225a4d6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -529,32 +529,26 @@ static int dwc3_probe(struct platform_device *pdev)
 
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
-
-		dev_err(dev, "no usb3 phy configured\n");
-		return -EPROBE_DEFER;
+		} else {
+			dev_err(dev, "no usb3 phy configured\n");
+			return ret;
+		}
 	}
 
 	dwc->xhci_resources[0].start = res->start;
-- 
1.7.9.5

