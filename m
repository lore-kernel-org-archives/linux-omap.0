From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 09/14] usb: of: add an API to get OTG device from USB controller node
Date: Mon, 2 May 2016 15:18:52 +0300
Message-ID: <1462191537-10314-10-git-send-email-rogerq@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462191537-10314-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OTG controller and the USB controller an be linked via the
'otg-controller' property in the USB controller's device node.

of_usb_get_otg() can be used to get the OTG controller device
from the USB controller's device node.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
