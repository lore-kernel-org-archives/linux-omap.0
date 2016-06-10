From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Fri, 10 Jun 2016 16:07:15 +0300
Message-ID: <1465564043-27163-7-git-send-email-rogerq@ti.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465564043-27163-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OTG core will use struct otg_gadget_ops to
start/stop the gadget controller.

The main purpose of this interface is to avoid directly
calling usb_gadget_start/stop() from the OTG core as they
wouldn't be defined in the built-in symbol table if
CONFIG_USB_GADGET is m.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 include/linux/usb/gadget.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 2dd9e6b..f4fc0aa 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -639,6 +639,22 @@ struct usb_gadget_driver {
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
