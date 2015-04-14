From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 09/13] usb: gadget: udc: adapt to OTG
Date: Tue, 14 Apr 2015 13:41:56 +0300
Message-ID: <1429008120-5395-10-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789AbbDNKml (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Apr 2015 06:42:41 -0400
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Register with OTG core when gadget function driver
is available and unregister when function driver is unbound.

Ignore softconnect sysfs control when we're in OTG
mode as OTG FSM takes care of gadget softconnect using
the b_bus_req mechanism.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/udc-core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 3aa5dd5..ad162e5 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb-otg.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -35,6 +36,7 @@
  * @dev - the child device to the actual controller
  * @gadget - the gadget. For use by the class code
  * @list - for use by the udc class driver
+ * @is_otg - we're registered with OTG core and it takes care of UDC start/stop
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -44,6 +46,7 @@ struct usb_udc {
 	struct usb_gadget		*gadget;
 	struct device			dev;
 	struct list_head		list;
+	bool				is_otg;
 };
 
 static struct class *udc_class;
@@ -403,10 +406,14 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	usb_gadget_disconnect(udc->gadget);
-	udc->driver->disconnect(udc->gadget);
+	/* If OTG, the otg core ensures UDC is stopped on unregister */
+	if (usb_otg_unregister_gadget(udc->gadget)) {
+		usb_gadget_disconnect(udc->gadget);
+		udc->driver->disconnect(udc->gadget);
+		usb_gadget_udc_stop(udc);
+	}
+
 	udc->driver->unbind(udc->gadget);
-	usb_gadget_udc_stop(udc);
 
 	udc->driver = NULL;
 	udc->dev.driver = NULL;
@@ -466,12 +473,17 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	ret = driver->bind(udc->gadget, driver);
 	if (ret)
 		goto err1;
-	ret = usb_gadget_udc_start(udc);
-	if (ret) {
-		driver->unbind(udc->gadget);
-		goto err1;
+
+	/* If OTG, the otg core starts the UDC when needed */
+	udc->is_otg = !usb_otg_register_gadget(udc->gadget);
+	if (!udc->is_otg) {
+		ret = usb_gadget_udc_start(udc);
+		if (ret) {
+			driver->unbind(udc->gadget);
+			goto err1;
+		}
+		usb_gadget_connect(udc->gadget);
 	}
-	usb_gadget_connect(udc->gadget);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -583,6 +595,12 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	/* In OTG mode we don't support softconnect, but b_bus_req */
+	if (udc->is_otg) {
+		dev_err(dev, "soft-connect not supported in OTG mode\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (sysfs_streq(buf, "connect")) {
 		usb_gadget_udc_start(udc);
 		usb_gadget_connect(udc->gadget);
-- 
2.1.0

