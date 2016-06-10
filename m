From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v10 12/14] usb: hcd: Adapt to OTG core
Date: Fri, 10 Jun 2016 16:07:21 +0300
Message-ID: <1465564043-27163-13-git-send-email-rogerq@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564043-27163-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduce usb_otg_add/remove_hcd() for use by host
controllers that are part of OTG/dual-role port.

Non device tree platforms can use the otg_dev argument
to specify the OTG controller device. If otg_dev is NULL
then the device tree node's otg-controller property is used to
get the otg_dev device.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/core/hcd.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/hcd.h |  4 ++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index ae6c76d..c6f4155 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -46,6 +46,11 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/of.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include "usb.h"
 
@@ -3025,6 +3030,56 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 }
 EXPORT_SYMBOL_GPL(usb_remove_hcd);
 
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
+ * @otg_dev: OTG controller device managing this HCD
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
+		hcd->otg_dev = of_usb_get_otg(dev->of_node);
+		if (!hcd->otg_dev)
+			return -ENODEV;
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
index 36bd54f..0c70282 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -473,6 +473,10 @@ extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
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
2.7.4
