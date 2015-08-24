From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 05/13] usb: hcd.h: Add OTG to HCD interface
Date: Mon, 24 Aug 2015 16:21:16 +0300
Message-ID: <1440422484-4737-6-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG core will use struct otg_hcd_ops to
add/remove the HCD controller.

The main purpose of this interface is to avoid directly
calling usb_add/remove_hcd() from the OTG core as they
wouldn't be defined in the built-in symbol table if
CONFIG_USB is m.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/usb/hcd.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index d2784c1..27d78b1 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -386,6 +386,20 @@ struct hc_driver {
 
 };
 
+/**
+ * struct otg_hcd_ops - Interface between OTG core and HCD
+ *
+ * Provided by the HCD core to allow the OTG core to start/stop the HCD
+ *
+ * @add: function to add the HCD
+ * @remove: function to remove the HCD
+ */
+struct otg_hcd_ops {
+	int (*add)(struct usb_hcd *hcd,
+		   unsigned int irqnum, unsigned long irqflags);
+	void (*remove)(struct usb_hcd *hcd);
+};
+
 static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
 {
 	return hcd->driver->flags & HCD_BH;
-- 
2.1.4
