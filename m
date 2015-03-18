From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 6/9] usb: gadget: udc: adapt to OTG
Date: Wed, 18 Mar 2015 15:56:00 +0200
Message-ID: <1426686963-11613-7-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with OTG core as part of usb_add_gadget_udc_release()
and unregister from it in usb_del_gadget_udc().

In the OTG use case we may not yet be in "b_peripheral"
state so we shouldn't allow starting the UDC till
OTG core says so.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/udc-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 69b4123..aad5173 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb-otg.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -237,6 +238,7 @@ static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 static int usb_udc_start(struct usb_udc *udc)
 {
 	int ret;
+	bool otg_can_start;
 
 	if (udc->running) {
 		dev_err(&udc->dev, "%s: not starting as already running\n",
@@ -244,7 +246,8 @@ static int usb_udc_start(struct usb_udc *udc)
 		return -EBUSY;
 	}
 
-	if (udc->driver && udc->softconnect) {
+	otg_can_start = usb_otg_gadget_can_start(udc->gadget);
+	if (otg_can_start && udc->driver && udc->softconnect) {
 		ret = usb_gadget_udc_start(udc);
 		if (ret)
 			return ret;
@@ -432,6 +435,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	mutex_unlock(&udc_lock);
 
+	usb_otg_register_gadget(gadget);
+
 	return 0;
 
 err4:
@@ -509,6 +514,7 @@ found:
 	if (udc->driver)
 		usb_gadget_remove_driver(udc);
 
+	usb_otg_unregister_gadget(gadget);
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
-- 
2.1.0
