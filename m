From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v9 09/14] usb: of: add an API to get OTG device from USB
 controller node
Date: Fri, 20 May 2016 12:29:59 +0300
Message-ID: <573ED917.6090803@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463133808-10630-10-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com, robh@kernel.org
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The OTG controller and the USB controller can be linked via the
'otg-controller' property in the USB controller's device node.

of_usb_get_otg() can be used to get the OTG controller device
from the USB controller's device node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
---
v9:
Clearly indicate which properties are for OTG controller and which ones
are for host/device controllers

 Documentation/devicetree/bindings/usb/generic.txt |  7 ++++++
 drivers/usb/common/common.c                       | 27 +++++++++++++++++++++++
 include/linux/usb/of.h                            |  9 ++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index bba8257..0887d6e 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -11,6 +11,8 @@ Optional properties:
 			"peripheral" and "otg". In case this attribute isn't
 			passed via DT, USB DRD controllers should default to
 			OTG.
+
+Optional properties for OTG controllers:
  - otg-rev: tells usb driver the release number of the OTG and EH supplement
 			with which the device and its descriptors are compliant,
 			in binary-coded decimal (i.e. 2.0 is 0200H). This
@@ -25,6 +27,11 @@ Optional properties:
  - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
 			optional for OTG device.
 
+Optional properties for host/device controllers:
+ - otg-controller: phandle to otg controller. Host or gadget controllers can
+			contain this property to link it to a particular OTG
+			controller.
+
 This is an attribute to a USB controller such as:
 
 dwc3@4a030000 {
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e3d0161..d7ec471 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -238,6 +238,33 @@ int of_usb_update_otg_caps(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_usb_update_otg_caps);
 
+#ifdef CONFIG_USB_OTG
+/**
+ * of_usb_get_otg - get the OTG controller linked to the USB controller
+ * @np: Pointer to the device_node of the USB controller
+ * @otg_caps: Pointer to the target usb_otg_caps to be set
+ *
+ * Returns the OTG controller device or NULL on error.
+ */
+struct device *of_usb_get_otg(struct device_node *np)
+{
+	struct device_node *otg_np;
+	struct platform_device *pdev;
+
+	otg_np = of_parse_phandle(np, "otg-controller", 0);
+	if (!otg_np)
+		return NULL;
+
+	pdev = of_find_device_by_node(otg_np);
+	of_node_put(otg_np);
+	if (!pdev)
+		return NULL;
+
+	return &pdev->dev;
+}
+EXPORT_SYMBOL_GPL(of_usb_get_otg);
+#endif
+
 #endif
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index de3237f..499a4e8 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -40,6 +40,15 @@ static inline struct device_node *usb_of_get_child_node
 }
 #endif
 
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_OTG)
+struct device *of_usb_get_otg(struct device_node *np);
+#else
+static inline struct device *of_usb_get_otg(struct device_node *np)
+{
+	return NULL;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
 enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);
 #else
-- 
2.7.4
