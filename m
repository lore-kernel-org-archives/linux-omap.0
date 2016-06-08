From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v9 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 8 Jun 2016 12:03:45 +0300
Message-ID: <1465376626-30122-14-git-send-email-rogerq@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465376626-30122-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG state machine needs a mechanism to start and
stop the gadget controller as well as connect/disconnect
from the bus. Add usb_gadget_start(), usb_gadget_stop()
and usb_gadget_connect_control().

Introduce usb_otg_add_gadget_udc() to allow controller drivers
to register a gadget controller that is part of an OTG instance.

Register with OTG core when UDC is added in usb_add_gadget_udc_release()
and unregister on usb_del_gadget_udc().

Notify the OTG core when gadget function driver is available on
udc_bind_to_driver() and when it is removed in usb_gadget_remove_driver().

We need to unlock the usb_lock mutex before calling
usb_otg_register_gadget() else it will cause a circular
locking dependency.

Ignore softconnect sysfs control when we're in OTG
mode as OTG FSM should care of gadget softconnect using
the b_bus_req mechanism.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/udc-core.c | 202 ++++++++++++++++++++++++++++++++++++--
 include/linux/usb/gadget.h        |   4 +
 2 files changed, 196 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 6e8300d..a80a6c9 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,11 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/of.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -337,6 +342,113 @@ static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 }
 
 /**
+ * usb_gadget_to_udc - get the UDC owning the gadget
+ *
+ * udc_lock must be held.
+ * Returs NULL if UDC is not found.
+ */
+static struct usb_udc *usb_gadget_to_udc(struct usb_gadget *gadget)
+{
+	struct usb_udc *udc;
+
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			return udc;
+
+	return NULL;
+}
+
+/**
+ * usb_gadget_start - start the usb gadget controller
+ * @gadget: the gadget device to start
+ *
+ * This is external API for use by OTG core.
+ *
+ * Start the usb device controller. Does not connect to the bus.
+ */
+static int usb_gadget_start(struct usb_gadget *gadget)
+{
+	int ret;
+	struct usb_udc *udc;
+
+	mutex_lock(&udc_lock);
+	udc = usb_gadget_to_udc(gadget);
+	if (!udc) {
+		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
+			__func__);
+		mutex_unlock(&udc_lock);
+		return -EINVAL;
+	}
+
+	ret = usb_gadget_udc_start(udc);
+	if (ret)
+		dev_err(&udc->dev, "USB Device Controller didn't start: %d\n",
+			ret);
+
+	mutex_unlock(&udc_lock);
+
+	return ret;
+}
+
+/**
+ * usb_gadget_stop - stop the usb gadget controller
+ * @gadget: the gadget device we want to stop
+ *
+ * This is external API for use by OTG core.
+ *
+ * Stop the gadget controller. Does not disconnect from the bus.
+ * Caller must ensure that gadget has disconnected from the bus
+ * before calling usb_gadget_stop().
+ */
+static int usb_gadget_stop(struct usb_gadget *gadget)
+{
+	struct usb_udc *udc;
+
+	mutex_lock(&udc_lock);
+	udc = usb_gadget_to_udc(gadget);
+	if (!udc) {
+		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
+			__func__);
+		mutex_unlock(&udc_lock);
+		return -EINVAL;
+	}
+
+	if (gadget->connected)
+		dev_dbg(gadget->dev.parent,
+			"%s: called while still connected\n", __func__);
+
+	usb_gadget_udc_stop(udc);
+	mutex_unlock(&udc_lock);
+
+	return 0;
+}
+
+static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
+{
+	struct usb_udc *udc;
+
+	mutex_lock(&udc_lock);
+	udc = usb_gadget_to_udc(gadget);
+	if (!udc) {
+		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
+			__func__);
+		mutex_unlock(&udc_lock);
+		return -EINVAL;
+	}
+
+	if (connect) {
+		usb_gadget_connect(udc->gadget);
+	} else {
+		usb_gadget_disconnect(udc->gadget);
+		udc->driver->disconnect(udc->gadget);
+	}
+
+	mutex_unlock(&udc_lock);
+
+	return 0;
+}
+
+/**
  * usb_udc_release - release the usb_udc struct
  * @dev: the dev member within usb_udc
  *
@@ -359,6 +471,12 @@ static void usb_udc_nop_release(struct device *dev)
 	dev_vdbg(dev, "%s\n", __func__);
 }
 
+struct otg_gadget_ops otg_gadget_intf = {
+	.start = usb_gadget_start,
+	.stop = usb_gadget_stop,
+	.connect_control = usb_gadget_connect_control,
+};
+
 /**
  * usb_add_gadget_udc_release - adds a new gadget to the udc class driver list
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -414,6 +532,14 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
 	udc->vbus = true;
 
+	if (gadget->otg_dev) {
+		mutex_unlock(&udc_lock);
+		ret = usb_otg_register_gadget(gadget, &otg_gadget_intf);
+		mutex_lock(&udc_lock);
+		if (ret)
+			goto err5;
+	}
+
 	/* pick up one of pending gadget drivers */
 	list_for_each_entry(driver, &gadget_driver_pending_list, pending) {
 		if (!driver->udc_name || strcmp(driver->udc_name,
@@ -422,7 +548,7 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 			if (ret != -EPROBE_DEFER)
 				list_del(&driver->pending);
 			if (ret)
-				goto err4;
+				goto err5;
 			break;
 		}
 	}
@@ -431,6 +557,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	return 0;
 
+err5:
+	device_del(&udc->dev);
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -492,6 +620,33 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
+/**
+ * usb_otg_add_gadget_udc - adds a new gadget to the udc class driver list
+ * @parent: the parent device to this udc. Usually the controller
+ * driver's device.
+ * @gadget: the gadget to be added to the list
+ * @otg_dev: the OTG controller device
+ *
+ * If otg_dev is NULL then device tree node is checked
+ * for OTG controller via the otg-controller property.
+ * Returns zero on success, negative errno otherwise.
+ */
+int usb_otg_add_gadget_udc(struct device *parent, struct usb_gadget *gadget,
+			   struct device *otg_dev)
+{
+	if (!otg_dev) {
+		gadget->otg_dev = of_usb_get_otg(parent->of_node);
+		if (!gadget->otg_dev)
+			return -ENODEV;
+	} else {
+		gadget->otg_dev = otg_dev;
+	}
+
+	return usb_add_gadget_udc_release(parent, gadget, NULL);
+}
+EXPORT_SYMBOL_GPL(usb_otg_add_gadget_udc);
+
+/* udc_lock must be held */
 static void usb_gadget_remove_driver(struct usb_udc *udc)
 {
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
@@ -499,10 +654,18 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	usb_gadget_disconnect(udc->gadget);
-	udc->driver->disconnect(udc->gadget);
+	/* If OTG/dual-role, the otg core manages UDC start/stop */
+	if (udc->gadget->otg_dev) {
+		mutex_unlock(&udc_lock);
+		usb_otg_gadget_ready(udc->gadget, false);
+		mutex_lock(&udc_lock);
+	} else {
+		usb_gadget_disconnect(udc->gadget);
+		udc->driver->disconnect(udc->gadget);
+		usb_gadget_udc_stop(udc);
+	}
+
 	udc->driver->unbind(udc->gadget);
-	usb_gadget_udc_stop(udc);
 
 	udc->driver = NULL;
 	udc->dev.driver = NULL;
@@ -536,6 +699,9 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	}
 	mutex_unlock(&udc_lock);
 
+	if (gadget->otg_dev)
+		usb_otg_unregister_gadget(gadget);
+
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
@@ -545,6 +711,7 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
+/* udc_lock must be held */
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -559,17 +726,26 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	ret = driver->bind(udc->gadget, driver);
 	if (ret)
 		goto err1;
-	ret = usb_gadget_udc_start(udc);
-	if (ret) {
-		driver->unbind(udc->gadget);
-		goto err1;
+
+	/* If OTG/dual-role, the otg core manages UDC start/stop */
+	if (udc->gadget->otg_dev) {
+		mutex_unlock(&udc_lock);
+		usb_otg_gadget_ready(udc->gadget, true);
+		mutex_lock(&udc_lock);
+	} else {
+		ret = usb_gadget_udc_start(udc);
+		if (ret) {
+			mutex_unlock(&udc_lock);
+			driver->unbind(udc->gadget);
+			goto err1;
+		}
+		usb_udc_connect_control(udc);
 	}
-	usb_udc_connect_control(udc);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
 err1:
-	if (ret != -EISNAM)
+	if ((ret != -EISNAM) && (ret != -EPROBE_DEFER))
 		dev_err(&udc->dev, "failed to start %s: %d\n",
 			udc->driver->function, ret);
 	udc->driver = NULL;
@@ -666,6 +842,12 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	/* In OTG/dual-role mode, soft-connect should be handled by OTG core */
+	if (udc->gadget->otg_dev) {
+		dev_err(dev, "soft-connect not supported in OTG mode\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (sysfs_streq(buf, "connect")) {
 		usb_gadget_udc_start(udc);
 		usb_gadget_connect(udc->gadget);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 1237f66..698092f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1162,6 +1162,10 @@ extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
 extern void usb_del_gadget_udc(struct usb_gadget *gadget);
 extern char *usb_get_gadget_udc_name(void);
 
+extern int usb_otg_add_gadget_udc(struct device *parent,
+				  struct usb_gadget *gadget,
+				  struct device *otg_dev);
+
 /*-------------------------------------------------------------------------*/
 
 /* utility to simplify dealing with string descriptors */
-- 
2.7.4
