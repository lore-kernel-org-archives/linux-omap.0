From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v10 09/14] usb: of: add an API to get OTG device from USB controller node
Date: Fri, 10 Jun 2016 16:07:18 +0300
Message-ID: <1465564043-27163-10-git-send-email-rogerq@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564043-27163-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG controller and the USB controller can be linked via the
'otg-controller' property in the USB controller's device node.

of_usb_get_otg() can be used to get the OTG controller device
from the USB controller's device node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/generic.txt |  3 +++
 drivers/usb/common/common.c                       | 27 +++++++++++++++++++++++
 include/linux/usb/of.h                            |  9 ++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index bba8257..f6866c1 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -24,6 +24,9 @@ Optional properties:
 			optional for OTG device.
  - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
 			optional for OTG device.
+ - otg-controller: phandle to otg controller. Host or gadget controllers can
+			contain this property to link it to a particular OTG
+			controller.
 
 This is an attribute to a USB controller such as:
 
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
