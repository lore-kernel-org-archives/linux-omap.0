From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v8 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Fri, 13 May 2016 13:03:20 +0300
Message-ID: <1463133808-10630-7-git-send-email-rogerq@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463133808-10630-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG core will use struct otg_gadget_ops to
start/stop the gadget controller.

The main purpose of this interface is to avoid directly
calling usb_gadget_start/stop() from the OTG core as they
wouldn't be defined in the built-in symbol table if
CONFIG_USB_GADGET is m.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/usb/gadget.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 5d4e151..20a2f8a 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1100,6 +1100,22 @@ struct usb_gadget_driver {
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
+ * @connect_control: function to connect/disconnect from the bus
+ */
+struct otg_gadget_ops {
+	int (*start)(struct usb_gadget *gadget);
+	int (*stop)(struct usb_gadget *gadget);
+	int (*connect_control)(struct usb_gadget *gadget, bool connect);
+};
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.7.4
