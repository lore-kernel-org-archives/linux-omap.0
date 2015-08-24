From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 06/13] usb: gadget.h: Add OTG to gadget interface
Date: Mon, 24 Aug 2015 16:21:17 +0300
Message-ID: <1440422484-4737-7-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG core will use struct otg_gadget_ops to
start/stop the gadget controller.

The main purpose of this interface is to avoid directly
calling usb_gadget_start/stop() from the OTG core as they
wouldn't be defined in the built-in symbol table if
CONFIG_USB_GADGET is m.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/usb/gadget.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b..c019242 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1052,6 +1052,20 @@ struct usb_gadget_driver {
 };
 
 
+/*-------------------------------------------------------------------------*/
+
+/**
+ * struct otg_gadget_ops - Interface between OTG core and gadget
+ *
+ * Provided by the gadget core to allow the OTG core to start/stop the gadget
+ *
+ * @start: function to start the gadget
+ * @stop: function to stop the gadget
+ */
+struct otg_gadget_ops {
+	int (*start)(struct usb_gadget *gadget);
+	int (*stop)(struct usb_gadget *gadget);
+};
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.1.4
