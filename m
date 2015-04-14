From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 10/13] udc-core: fix lock circular dependency on udc_lock
Date: Tue, 14 Apr 2015 13:41:57 +0300
Message-ID: <1429008120-5395-11-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

we need to unlock the usb_lock mutex before calling
usb_otg_register_gadget() else it will cause a
circular locking dependency.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/udc-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index ad162e5..6246d09 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -399,6 +399,7 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
+/* udc_lock must be held */
 static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
@@ -407,7 +408,11 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
 	/* If OTG, the otg core ensures UDC is stopped on unregister */
-	if (usb_otg_unregister_gadget(udc->gadget)) {
+	if (udc->is_otg) {
+		mutex_unlock(&udc_lock);
+		usb_otg_unregister_gadget(udc->gadget);
+		mutex_lock(&udc_lock);
+	} else {
 		usb_gadget_disconnect(udc->gadget);
 		udc->driver->disconnect(udc->gadget);
 		usb_gadget_udc_stop(udc);
@@ -445,11 +450,12 @@ found:
 	dev_vdbg(gadget->dev.parent, "unregistering gadget\n");
 
 	list_del(&udc->list);
-	mutex_unlock(&udc_lock);
 
 	if (udc->driver)
 		usb_gadget_remove_driver(udc);
 
+	mutex_unlock(&udc_lock);
+
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
@@ -459,6 +465,7 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
+/* udc_lock must be held */
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -475,7 +482,9 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 		goto err1;
 
 	/* If OTG, the otg core starts the UDC when needed */
+	mutex_unlock(&udc_lock);
 	udc->is_otg = !usb_otg_register_gadget(udc->gadget);
+	mutex_lock(&udc_lock);
 	if (!udc->is_otg) {
 		ret = usb_gadget_udc_start(udc);
 		if (ret) {
-- 
2.1.0
