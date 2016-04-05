From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
Date: Tue, 5 Apr 2016 17:05:13 +0300
Message-ID: <1459865117-7032-9-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduce usb_otg_add/remove_hcd() for use by host
controllers that are part of OTG/dual-role port.

Non Device tree platforms can use the otg_dev argument
to specify the OTG controller device. If otg_dev is NULL
then the device tree node's otg-controller property is used to
get the otg_dev device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hcd.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/hcd.h |  4 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 6b1930d..6a80193 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -46,6 +46,10 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/otg.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include "usb.h"
 
@@ -3013,6 +3017,73 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 }
 EXPORT_SYMBOL_GPL(usb_remove_hcd);
 
+
+static struct otg_hcd_ops otg_hcd_intf = {
+	.add = usb_add_hcd,
+	.remove = usb_remove_hcd,
+	.usb_bus_start_enum = usb_bus_start_enum,
+	.usb_control_msg = usb_control_msg,
+	.usb_hub_find_child = usb_hub_find_child,
+};
+
+/**
+ * usb_otg_add_hcd - Register the HCD with OTG core.
+ * @hcd: the usb_hcd structure to initialize
+ * @irqnum: Interrupt line to allocate
+ * @irqflags: Interrupt type flags
+ * @otg_dev: OTG controller device manging this HCD
+ *
+ * Registers the HCD with OTG core. OTG core will call usb_add_hcd()
+ * or usb_remove_hcd() as necessary.
+ * If otg_dev is NULL then device tree node is checked for OTG
+ * controller device via the otg-controller property.
+ */
+int usb_otg_add_hcd(struct usb_hcd *hcd,
+		    unsigned int irqnum, unsigned long irqflags,
+		    struct device *otg_dev)
+{
+	struct device *dev = hcd->self.controller;
+
+	if (!otg_dev) {
+		struct device_node *np;
+		struct platform_device *pdev;
+
+		np = of_parse_phandle(dev->of_node, "otg-controller", 0);
+		if (!np) {
+			dev_err(dev,
+				"otg_dev is NULL and no otg-controller property in DT\n");
+			return -EINVAL;
+		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev) {
+			dev_err(dev,
+				"couldn't get otg-controller device\n");
+			return -ENODEV;
+		}
+
+		hcd->otg_dev = &pdev->dev;
+	} else {
+		hcd->otg_dev = otg_dev;
+	}
+
+	return usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf);
+}
+EXPORT_SYMBOL_GPL(usb_otg_add_hcd);
+
+/**
+ * usb_otg_remove_hcd - Unregister the HCD with OTG core.
+ * @hcd: the usb_hcd structure to remove
+ *
+ * Unregisters the HCD from the OTG core.
+ */
+void usb_otg_remove_hcd(struct usb_hcd *hcd)
+{
+	usb_otg_unregister_hcd(hcd);
+}
+EXPORT_SYMBOL_GPL(usb_otg_remove_hcd);
+
 void
 usb_hcd_platform_shutdown(struct platform_device *dev)
 {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 2017cd4..adcf2e7 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -472,6 +472,10 @@ extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
 extern int usb_add_hcd(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
+extern int usb_otg_add_hcd(struct usb_hcd *hcd,
+			   unsigned int irqnum, unsigned long irqflags,
+			   struct device *otg_dev);
+extern void usb_otg_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
 
 struct platform_device;
-- 
2.5.0
