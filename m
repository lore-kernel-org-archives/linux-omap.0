From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [RFC][PATCH v2 04/13] usb: gadget: add usb_gadget_start/stop()
Date: Tue, 14 Apr 2015 13:41:51 +0300
Message-ID: <1429008120-5395-5-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The OTG state machine needs a mechanism to start and
stop the gadget controller. Add usb_gadget_start()
and usb_gadget_stop().

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/udc/udc-core.c | 74 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h        |  3 ++
 2 files changed, 77 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 5a81cb0..3aa5dd5 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -187,6 +187,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  */
 static inline int usb_gadget_udc_start(struct usb_udc *udc)
 {
+	dev_dbg(&udc->dev, "%s\n", __func__);
 	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
 }
 
@@ -204,10 +205,83 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
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
+int usb_gadget_start(struct usb_gadget *gadget)
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
+		usb_gadget_connect(udc->gadget);
+
+	mutex_unlock(&udc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_start);
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
+int usb_gadget_stop(struct usb_gadget *gadget)
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
+EXPORT_SYMBOL_GPL(usb_gadget_stop);
+
+/**
  * usb_udc_release - release the usb_udc struct
  * @dev: the dev member within usb_udc
  *
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e2f00fd..7ada7e6 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -922,6 +922,9 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver);
  */
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
 
+int usb_gadget_start(struct usb_gadget *gadget);
+int usb_gadget_stop(struct usb_gadget *gadget);
+
 extern int usb_add_gadget_udc_release(struct device *parent,
 		struct usb_gadget *gadget, void (*release)(struct device *dev));
 extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
