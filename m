From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 06/11] usb: dwc3-omap: Minor fixes to get dt working
Date: Fri, 25 Jan 2013 08:30:50 +0530
Message-ID: <1359082855-7404-7-git-send-email-kishon@ti.com>
References: <1359082855-7404-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359082855-7404-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Includes few minor fixes in dwc3-omap like populating the compatible
string in a correct way, extracting the utmi-mode property properly and
changing the index of get_irq since irq of core is removed from hwmod
entry.
Also updated the documentation with dwc3-omap device tree binding
information.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt |   28 ++++++++++++
 drivers/usb/dwc3/dwc3-omap.c                       |   45 +++++++++-----------
 2 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index 90360e3..0177371 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -43,6 +43,34 @@ Board specific device node entry
 	power = <50>;
 };
 
+OMAP DWC3 GLUE
+ - compatible : Should be "ti,dwc3"
+ - ti,hwmods : Should be "usb_otg_ss"
+ - reg : Address and length of the register set for the device.
+ - interrupts : The irq number of this device that is used to interrupt the
+   MPU
+ - #address-cells, #size-cells : Must be present if the device has sub-nodes
+ - utmi-mode : controls the source of UTMI/PIPE status for VBUS and OTG ID.
+   It should be set to "1" for HW mode and "2" for SW mode.
+ - ranges: the child address space are mapped 1:1 onto the parent address space
+
+Sub-nodes:
+The dwc3 core should be added as subnode to omap dwc3 glue.
+- dwc3 :
+   The binding details of dwc3 can be found in:
+   Documentation/devicetree/bindings/usb/dwc3.txt
+
+omap_dwc3 {
+	compatible = "ti,dwc3";
+	ti,hwmods = "usb_otg_ss";
+	reg = <0x4a020000 0x1ff>;
+	interrupts = <0 93 4>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	utmi-mode = <2>;
+	ranges;
+};
+
 OMAP CONTROL USB
 
 Required properties:
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 831b75f..cc2ccba 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -318,11 +318,11 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	struct resource		*res;
 	struct device		*dev = &pdev->dev;
 
-	int			size;
 	int			ret = -ENOMEM;
 	int			irq;
 
-	const u32		*utmi_mode;
+	int			utmi_mode;
+
 	u32			reg;
 
 	void __iomem		*base;
@@ -336,13 +336,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, omap);
 
-	irq = platform_get_irq(pdev, 1);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "missing memory base resource\n");
 		return -EINVAL;
@@ -389,25 +389,22 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
 
-	utmi_mode = of_get_property(node, "utmi-mode", &size);
-	if (utmi_mode && size == sizeof(*utmi_mode)) {
-		reg |= *utmi_mode;
-	} else {
-		if (!pdata) {
-			dev_dbg(dev, "missing platform data\n");
-		} else {
-			switch (pdata->utmi_mode) {
-			case DWC3_OMAP_UTMI_MODE_SW:
-				reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-				break;
-			case DWC3_OMAP_UTMI_MODE_HW:
-				reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
-				break;
-			default:
-				dev_dbg(dev, "UNKNOWN utmi mode %d\n",
-						pdata->utmi_mode);
-			}
-		}
+	if (node)
+		of_property_read_u32(node, "utmi-mode", &utmi_mode);
+	else if (pdata)
+		utmi_mode = pdata->utmi_mode;
+	else
+		dev_dbg(dev, "missing platform data\n");
+
+	switch (utmi_mode) {
+	case DWC3_OMAP_UTMI_MODE_SW:
+		reg |= USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+		break;
+	case DWC3_OMAP_UTMI_MODE_HW:
+		reg &= ~USBOTGSS_UTMI_OTG_STATUS_SW_MODE;
+		break;
+	default:
+		dev_dbg(dev, "UNKNOWN utmi mode %d\n", utmi_mode);
 	}
 
 	dwc3_omap_writel(omap->base, USBOTGSS_UTMI_OTG_STATUS, reg);
@@ -467,7 +464,7 @@ static int dwc3_omap_remove(struct platform_device *pdev)
 
 static const struct of_device_id of_dwc3_matach[] = {
 	{
-		"ti,dwc3",
+		.compatible =	"ti,dwc3"
 	},
 	{ },
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
