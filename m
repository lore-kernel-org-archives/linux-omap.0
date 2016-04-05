From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 02/12] usb: hcd.h: Add OTG to HCD interface
Date: Tue, 5 Apr 2016 17:05:07 +0300
Message-ID: <1459865117-7032-3-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG core will use struct otg_hcd_ops to interface
with the HCD controller.

The main purpose of this interface is to avoid directly
calling HCD APIs from the OTG core as they
wouldn't be defined in the built-in symbol table if
CONFIG_USB is m.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index b98f831..861ccaa 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -399,6 +399,30 @@ struct hc_driver {
 
 };
 
+/**
+ * struct otg_hcd_ops - Interface between OTG core and HCD
+ *
+ * Provided by the HCD core to allow the OTG core to interface with the HCD
+ *
+ * @add: function to add the HCD
+ * @remove: function to remove the HCD
+ * @usb_bus_start_enum: function to immediately start bus enumeration
+ * @usb_control_msg: function to build and send of a control urb
+ * @usb_hub_find_child: function to get pointer to the child device
+ */
+struct otg_hcd_ops {
+	int (*add)(struct usb_hcd *hcd,
+		   unsigned int irqnum, unsigned long irqflags);
+	void (*remove)(struct usb_hcd *hcd);
+	int (*usb_bus_start_enum)(struct usb_bus *bus, unsigned int port_num);
+	int (*usb_control_msg)(struct usb_device *dev, unsigned int pipe,
+			       __u8 request, __u8 requesttype, __u16 value,
+			       __u16 index, void *data, __u16 size,
+			       int timeout);
+	struct usb_device * (*usb_hub_find_child)(struct usb_device *hdev,
+						  int port1);
+};
+
 static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
 {
 	return hcd->driver->flags & HCD_BH;
-- 
2.5.0
