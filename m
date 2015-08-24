From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 10/13] usb: hcd: Adapt to OTG core
Date: Mon, 24 Aug 2015 16:21:21 +0300
Message-ID: <1440422484-4737-11-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The existing usb_add/remove_hcd() functionality
remains unchanged for non-OTG devices. For OTG
devices they only register the HCD with the OTG core.

Introduce usb_otg_add/remove_hcd() for use by OTG core.
These functions actually add/remove the HCD.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hcd.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index c0fd1f6..4851682 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -46,6 +46,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/otg.h>
 
 #include "usb.h"
 
@@ -2625,8 +2626,8 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
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
@@ -2839,17 +2840,16 @@ err_phy:
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
 
@@ -2923,6 +2923,51 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 
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
