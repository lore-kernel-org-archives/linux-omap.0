From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 05/12] usb: gadget.h: Add OTG to gadget interface
Date: Tue, 5 Apr 2016 17:05:10 +0300
Message-ID: <1459865117-7032-6-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
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
index 5d4e151..8c0ae64 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1100,6 +1100,20 @@ struct usb_gadget_driver {
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
2.5.0
