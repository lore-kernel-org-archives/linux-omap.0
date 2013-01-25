From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 09/11] usb: dwc3: core: add dt support for dwc3 core
Date: Fri, 25 Jan 2013 08:30:53 +0530
Message-ID: <1359082855-7404-10-git-send-email-kishon@ti.com>
References: <1359082855-7404-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359082855-7404-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added dt support for dwc3 core and update the documentation with
device tree binding information. Getting a PHY is now done using
devm_usb_get_phy_by_phandle() for dt boot.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |   22 ++++++++++++++++++++++
 drivers/usb/dwc3/core.c                        |   24 ++++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3.txt

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
new file mode 100644
index 0000000..5e68eb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -0,0 +1,22 @@
+synopsys DWC3 CORE
+
+DWC3- USB3 CONTROLLER
+
+Required properties:
+ - compatible: must be "synopsys,dwc3"
+ - reg : Address and length of the register set for the device
+ - interrupts: Interrupts used by the dwc3 controller.
+ - usb_phy : array of phandle for the PHY device
+
+Optional properties:
+ - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+
+This is usually a subnode to DWC3 glue to which it is connected.
+
+dwc3@4a030000 {
+	compatible = "synopsys,dwc3";
+	reg = <0x4a030000 0xcfff>;
+	interrupts = <0 92 4>
+	usb_phy = <&usb2_phy>, <&usb3,phy>;
+	tx-fifo-resize;
+};
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3a4004a..c1fb6d2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -420,13 +420,19 @@ static int dwc3_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (node) {
+		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb_phy", 0);
+		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb_phy", 1);
+	} else {
+		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+	}
+
 	if (IS_ERR_OR_NULL(dwc->usb2_phy)) {
 		dev_err(dev, "no usb2 phy configured\n");
 		return -EPROBE_DEFER;
 	}
 
-	dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
 	if (IS_ERR_OR_NULL(dwc->usb3_phy)) {
 		dev_err(dev, "no usb3 phy configured\n");
 		return -EPROBE_DEFER;
@@ -450,8 +456,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	else
 		dwc->maximum_speed = DWC3_DCFG_SUPERSPEED;
 
-	if (of_get_property(node, "tx-fifo-resize", NULL))
-		dwc->needs_fifo_resize = true;
+	dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -580,11 +585,22 @@ static int dwc3_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id of_dwc3_match[] = {
+	{
+		.compatible = "synopsys,dwc3"
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_dwc3_match);
+#endif
+
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
 	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
+		.of_match_table	= of_match_ptr(of_dwc3_match),
 	},
 };
 
-- 
1.7.9.5
