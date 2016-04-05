From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Tue, 5 Apr 2016 17:05:14 +0300
Message-ID: <1459865117-7032-10-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The OTG state machine needs a mechanism to start and
stop the gadget controller. Add usb_gadget_start()
and usb_gadget_stop().

Introduce usb_otg_add_gadget_udc() to allow controller drivers
to register a gadget controller that is part of an OTG instance.

Register with OTG core when gadget function driver
is available and unregister when function driver is unbound.

We need to unlock the usb_lock mutexbefore calling
usb_otg_register_gadget() in udc_bind_to_driver() and
usb_gadget_remove_driver() else it will cause a circular
locking dependency.

Ignore softconnect sysfs control when we're in OTG
mode as OTG FSM takes care of gadget softconnect using
the b_bus_req mechanism.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/gadget/udc/udc-core.c | 166 +++++++++++++++++++++++++++++++++++---
 include/linux/usb/gadget.h        |   4 +
 2 files changed, 161 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4151597..9b9702f 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,10 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/otg.h>
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -304,6 +308,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  */
 static inline int usb_gadget_udc_start(struct usb_udc *udc)
 {
+	dev_dbg(&udc->dev, "%s\n", __func__);
 	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 }
 
@@ -321,10 +326,81 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
  */
 static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 {
+	dev_dbg(&udc->dev, "%s\n", __func__);
 	udc->gadget->ops->udc_stop(udc->gadget);
 }
 
 /**
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
+	struct usb_udc *udc = NULL;
+
+	dev_dbg(&gadget->dev, "%s\n", __func__);
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
+
+	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
+		__func__);
+	mutex_unlock(&udc_lock);
+	return -EINVAL;
+
+found:
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
+	struct usb_udc *udc = NULL;
+
+	dev_dbg(&gadget->dev, "%s\n", __func__);
+	mutex_lock(&udc_lock);
+	list_for_each_entry(udc, &udc_list, list)
+		if (udc->gadget == gadget)
+			goto found;
+
+	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
+		__func__);
+	mutex_unlock(&udc_lock);
+	return -EINVAL;
+
+found:
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
@@ -486,6 +562,48 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
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
+		struct device_node *np;
+		struct platform_device *pdev;
+
+		np = of_parse_phandle(parent->of_node, "otg-controller", 0);
+		if (!np) {
+			dev_err(parent,
+				"otg_dev is NULL or no otg-controller property in DT\n");
+			return -EINVAL;
+		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev) {
+			dev_err(parent, "couldn't get otg-controller device\n");
+			return -ENODEV;
+		}
+
+		gadget->otg_dev = &pdev->dev;
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
@@ -493,10 +611,18 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
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
@@ -530,6 +656,8 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	}
 	mutex_unlock(&udc_lock);
 
+	mutex_unlock(&udc_lock);
+
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
@@ -539,6 +667,12 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
 
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
@@ -553,12 +687,20 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
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
@@ -660,9 +802,15 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
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
index 1878ae1..061f09e4 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1160,6 +1160,10 @@ extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
 extern void usb_del_gadget_udc(struct usb_gadget *gadget);
 extern char *usb_get_gadget_udc_name(void);
 
+extern int usb_otg_add_gadget_udc(struct device *parent,
+				     struct usb_gadget *gadget,
+				     struct device *otg_dev);
+
 /*-------------------------------------------------------------------------*/
 
 /* utility to simplify dealing with string descriptors */
-- 
2.5.0
