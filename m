From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 2 May 2016 15:18:56 +0300
Message-ID: <1462191537-10314-14-git-send-email-rogerq@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462191537-10314-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OTG state machine needs a mechanism to start and
stop the gadget controller. Add usb_gadget_start()
and usb_gadget_stop().

Introduce usb_otg_add_gadget_udc() to allow controller drivers
to register a gadget controller that is part of an OTG instance.

Register with OTG core when gadget function driver
is available and unregister when function driver is unbound.

We need to unlock the usb_lock mutex before calling
usb_otg_register_gadget() in udc_bind_to_driver() and
usb_gadget_remove_driver() else it will cause a circular
locking dependency.

Ignore softconnect sysfs control when we're in OTG
mode as OTG FSM takes care of gadget softconnect using
the b_bus_req mechanism.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/udc/udc-core.c | 161 +++++++++++++++++++++++++++++++++++---
 include/linux/usb/gadget.h        |   4 +
 2 files changed, 156 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4151597..e384c7e 100644
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
@@ -325,6 +330,87 @@ static inline void usb_gadget_udc_stop(struct usb_udc *udc)
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
+ * usb_gadget_start - start the usb gadget controller and connect to bus
+ * @gadget: the gadget device to start
+ *
+ * This is external API for use by OTG core.
+ *
+ * Start the usb device controller and connect to bus (enable pull).
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
+	else
+		usb_udc_connect_control(udc);
+
+	mutex_unlock(&udc_lock);
+
+	return ret;
+}
+
+/**
+ * usb_gadget_stop - disconnect from bus and stop the usb gadget
+ * @gadget: The gadget device we want to stop
+ *
+ * This is external API for use by OTG core.
+ *
+ * Disconnect from the bus (disable pull) and stop the
+ * gadget controller.
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
+	usb_gadget_disconnect(udc->gadget);
+	udc->driver->disconnect(udc->gadget);
+	usb_gadget_udc_stop(udc);
+	mutex_unlock(&udc_lock);
+
+	return 0;
+}
+
+/**
  * usb_udc_release - release the usb_udc struct
  * @dev: the dev member within usb_udc
  *
@@ -486,6 +572,33 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
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
@@ -493,10 +606,18 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	usb_gadget_disconnect(udc->gadget);
-	udc->driver->disconnect(udc->gadget);
+	/* If OTG, the otg core ensures UDC is stopped on unregister */
+	if (udc->gadget->otg_dev) {
+		mutex_unlock(&udc_lock);
+		usb_otg_unregister_gadget(udc->gadget);
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
@@ -530,6 +651,8 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	}
 	mutex_unlock(&udc_lock);
 
+	mutex_unlock(&udc_lock);
+
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
@@ -539,6 +662,12 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
 /* ------------------------------------------------------------------------- */
 
+struct otg_gadget_ops otg_gadget_intf = {
+	.start = usb_gadget_start,
+	.stop = usb_gadget_stop,
+};
+
+/* udc_lock must be held */
 static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
 {
 	int ret;
@@ -553,12 +682,20 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 	ret = driver->bind(udc->gadget, driver);
 	if (ret)
 		goto err1;
-	ret = usb_gadget_udc_start(udc);
-	if (ret) {
-		driver->unbind(udc->gadget);
-		goto err1;
+
+	/* If OTG, the otg core starts the UDC when needed */
+	if (udc->gadget->otg_dev) {
+		mutex_unlock(&udc_lock);
+		usb_otg_register_gadget(udc->gadget, &otg_gadget_intf);
+		mutex_lock(&udc_lock);
+	} else {
+		ret = usb_gadget_udc_start(udc);
+		if (ret) {
+			driver->unbind(udc->gadget);
+			goto err1;
+		}
+		usb_udc_connect_control(udc);
 	}
-	usb_udc_connect_control(udc);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -660,9 +797,15 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	/* In OTG mode we don't support softconnect, but b_bus_req */
+	if (udc->gadget->otg_dev) {
+		dev_err(dev, "soft-connect not supported in OTG mode\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (sysfs_streq(buf, "connect")) {
 		usb_gadget_udc_start(udc);
-		usb_gadget_connect(udc->gadget);
+		usb_udc_connect_control(udc);
 	} else if (sysfs_streq(buf, "disconnect")) {
 		usb_gadget_disconnect(udc->gadget);
 		udc->driver->disconnect(udc->gadget);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 1878ae1..c0c5617 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1160,6 +1160,10 @@ extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
