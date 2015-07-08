From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 08/11] usb: hcd: Adapt to OTG core
Date: Wed, 8 Jul 2015 13:19:34 +0300
Message-ID: <1436350777-28056-9-git-send-email-rogerq@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436350777-28056-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The existing usb_add/remove_hcd() functionality
remains unchanged for non-OTG devices. For OTG
devices they only register the HCD with the OTG core.

Introduce usb_otg_add/remove_hcd() for use by OTG core.
These functions actually add/remove the HCD.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/common/usb-otg.c |  6 ++---
 drivers/usb/core/hcd.c       | 55 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
index 0379034..1f19001 100644
--- a/drivers/usb/common/usb-otg.c
+++ b/drivers/usb/common/usb-otg.c
@@ -496,7 +496,7 @@ int usb_otg_kick_fsm(struct device *hcd_gcd_device)
 	mutex_lock(&otg_list_mutex);
 	otgd = usb_otg_device_get_otgd(hcd_gcd_device->parent);
 	if (!otgd) {
-		dev_err(hcd_gcd_device, "otg: %s: invalid host/gadget device\n",
+		dev_dbg(hcd_gcd_device, "otg: %s: invalid host/gadget device\n",
 			__func__);
 		mutex_unlock(&otg_list_mutex);
 		return -ENODEV;
@@ -678,7 +678,7 @@ int usb_otg_register_gadget(struct usb_gadget *gadget,
 	mutex_lock(&otg_list_mutex);
 	otgd = usb_otg_device_get_otgd(otg_dev);
 	if (!otgd) {
-		dev_err(otg_dev, "otg: %s: device not registered to otg core\n",
+		dev_dbg(otg_dev, "otg: %s: device not registered to otg core\n",
 			__func__);
 		mutex_unlock(&otg_list_mutex);
 		return -EINVAL;
@@ -724,7 +724,7 @@ int usb_otg_unregister_gadget(struct usb_gadget *gadget)
 	mutex_lock(&otg_list_mutex);
 	otgd = usb_otg_device_get_otgd(otg_dev);
 	if (!otgd) {
-		dev_err(otg_dev, "otg: %s: device not registered to otg core\n",
+		dev_dbg(otg_dev, "otg: %s: device not registered to otg core\n",
 			__func__);
 		mutex_unlock(&otg_list_mutex);
 		return -EINVAL;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index be5b207..3a19607 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -46,6 +46,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/otg.h>
 
 #include "usb.h"
 
@@ -2622,8 +2623,8 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
  * buffers of consistent memory, register the bus, request the IRQ line,
  * and call the driver's reset() and start() routines.
  */
-int usb_add_hcd(struct usb_hcd *hcd,
-		unsigned int irqnum, unsigned long irqflags)
+static int usb_otg_add_hcd(struct usb_hcd *hcd,
+			   unsigned int irqnum, unsigned long irqflags)
 {
 	int retval;
 	struct usb_device *rhdev;
@@ -2828,17 +2829,16 @@ err_phy:
 	}
 	return retval;
 }
-EXPORT_SYMBOL_GPL(usb_add_hcd);
 
 /**
- * usb_remove_hcd - shutdown processing for generic HCDs
+ * usb_otg_remove_hcd - shutdown processing for generic HCDs
  * @hcd: the usb_hcd structure to remove
  * Context: !in_interrupt()
  *
  * Disconnects the root hub, then reverses the effects of usb_add_hcd(),
  * invoking the HCD's stop() method.
  */
-void usb_remove_hcd(struct usb_hcd *hcd)
+static void usb_otg_remove_hcd(struct usb_hcd *hcd)
 {
 	struct usb_device *rhdev = hcd->self.root_hub;
 
@@ -2912,6 +2912,51 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 
 	usb_put_invalidate_rhdev(hcd);
 }
+
+static struct otg_hcd_ops otg_hcd_intf = {
+	.add = usb_otg_add_hcd,
+	.remove = usb_otg_remove_hcd,
+};
+
+/**
+ * usb_add_hcd - finish generic HCD structure initialization and register
+ * @hcd: the usb_hcd structure to initialize
+ * @irqnum: Interrupt line to allocate
+ * @irqflags: Interrupt type flags
+ *
+ * Finish the remaining parts of generic HCD initialization: allocate the
+ * buffers of consistent memory, register the bus, request the IRQ line,
+ * and call the driver's reset() and start() routines.
+ * If it is an OTG device then it only registers the HCD with OTG core.
+ *
+ */
+int usb_add_hcd(struct usb_hcd *hcd,
+		unsigned int irqnum, unsigned long irqflags)
+{
+	/* If OTG device, OTG core takes care of adding HCD */
+	if (usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf))
+		return usb_otg_add_hcd(hcd, irqnum, irqflags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_add_hcd);
+
+/**
+ * usb_remove_hcd - shutdown processing for generic HCDs
+ * @hcd: the usb_hcd structure to remove
+ * Context: !in_interrupt()
+ *
+ * Disconnects the root hub, then reverses the effects of usb_add_hcd(),
+ * invoking the HCD's stop() method.
+ * If it is an OTG device then it unregisters the HCD from OTG core
+ * as well.
+ */
+void usb_remove_hcd(struct usb_hcd *hcd)
+{
+	/* If OTG device, OTG core takes care of stopping HCD */
+	if (usb_otg_unregister_hcd(hcd))
+		usb_otg_remove_hcd(hcd);
+}
 EXPORT_SYMBOL_GPL(usb_remove_hcd);
 
 void
-- 
2.1.4
