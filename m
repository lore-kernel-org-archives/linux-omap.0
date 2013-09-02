From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/7] usb: dwc3: get "usb_phy" only if the platform indicates
 the presence of PHY
Date: Mon, 2 Sep 2013 21:13:05 +0530
Message-ID: <1378136591-7463-2-git-send-email-kishon@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378136591-7463-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rogerq@ti.com, kishon@ti.com, balbi@ti.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, s.nawrocki@samsung.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, rob@landley.net, bcousson@baylibre.com, galak@codeaurora.org, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com
List-Id: linux-omap@vger.kernel.org

There can be systems which does not have a external usb_phy, so get
usb_phy only if usb-phy property is added in the case of dt boot or if
platform_data indicates the presence of PHY. Also remove checking if
return value is -ENXIO since it's now changed to always enable usb_phy layer.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/Kconfig         |    1 +
 drivers/usb/dwc3/core.c          |   60 +++++++++++++++++---------------------
 drivers/usb/dwc3/platform_data.h |    1 +
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index f969ea2..cfc16dd 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -2,6 +2,7 @@ config USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
 	depends on (USB || USB_GADGET) && GENERIC_HARDIRQS && HAS_DMA
 	depends on EXTCON
+	select USB_PHY
 	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system has a Dual Role SuperSpeed
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 474162e..428c29e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -387,16 +387,38 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (node) {
 		dwc->maximum_speed = of_usb_get_maximum_speed(node);
 
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
+		if (of_property_read_bool(node, "usb-phy")) {
+			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev,
+				"usb-phy", 0);
+			if (IS_ERR(dwc->usb2_phy))
+				return PTR_ERR(dwc->usb2_phy);
+			dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev,
+				"usb-phy", 1);
+			if (IS_ERR(dwc->usb3_phy))
+				return PTR_ERR(dwc->usb3_phy);
+		} else {
+			dwc->usb2_phy = NULL;
+			dwc->usb3_phy = NULL;
+		}
 
 		dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 		dwc->dr_mode = of_usb_get_dr_mode(node);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+		if (pdata->has_phy) {
+			dwc->usb2_phy = devm_usb_get_phy(dev,
+				USB_PHY_TYPE_USB2);
+			if (IS_ERR(dwc->usb2_phy))
+				return PTR_ERR(dwc->usb2_phy);
+			dwc->usb3_phy = devm_usb_get_phy(dev,
+				USB_PHY_TYPE_USB3);
+			if (IS_ERR(dwc->usb3_phy))
+				return PTR_ERR(dwc->usb3_phy);
+		} else {
+			dwc->usb2_phy = NULL;
+			dwc->usb3_phy = NULL;
+		}
 
 		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
 		dwc->dr_mode = pdata->dr_mode;
@@ -409,36 +431,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
 		dwc->maximum_speed = USB_SPEED_SUPER;
 
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
-
-		/*
-		 * if -ENXIO is returned, it means PHY layer wasn't
-		 * enabled, so it makes no sense to return -EPROBE_DEFER
-		 * in that case, since no PHY driver will ever probe.
-		 */
-		if (ret == -ENXIO)
-			return ret;
-
-		dev_err(dev, "no usb2 phy configured\n");
-		return -EPROBE_DEFER;
-	}
-
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
-
-		/*
-		 * if -ENXIO is returned, it means PHY layer wasn't
-		 * enabled, so it makes no sense to return -EPROBE_DEFER
-		 * in that case, since no PHY driver will ever probe.
-		 */
-		if (ret == -ENXIO)
-			return ret;
-
-		dev_err(dev, "no usb3 phy configured\n");
-		return -EPROBE_DEFER;
-	}
-
 	dwc->xhci_resources[0].start = res->start;
 	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
 					DWC3_XHCI_REGS_END;
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index 7db34f0..5a5e068 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -24,4 +24,5 @@ struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
 	bool tx_fifo_resize;
+	bool has_phy;
 };
-- 
1.7.10.4
