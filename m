From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 5/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:49:36 -0400
Message-ID: <1170431376.23028.65.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

[PATCH] g_serial modification for it to become a USB_FUNCTION.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

Index: 2.6-dev/drivers/usb/gadget/serial.c
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/serial.c	2007-01-29
11:44:59.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/serial.c	2007-01-29 11:45:11.000000000
-0400
@@ -45,6 +45,7 @@
 
 #include <linux/usb_ch9.h>
 #include <linux/usb/cdc.h>
+#include <linux/usb/composite.h>
 #include <linux/usb_gadget.h>
 
 #include "gadget_chips.h"
@@ -66,7 +67,12 @@
 #define GS_NUM_CONFIGS			1
 #define GS_NO_CONFIG_ID			0
 #define GS_BULK_CONFIG_ID		1
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#define COMPOSITE_CONFIG_VALUE  3	/* composite config */
+#define GS_ACM_CONFIG_ID		COMPOSITE_CONFIG_VALUE
+#else
 #define GS_ACM_CONFIG_ID		2
+#endif
 
 #define GS_MAX_NUM_INTERFACES		2
 #define GS_BULK_INTERFACE_ID		0
@@ -97,6 +103,8 @@
 #define GS_SPEED_SELECT(is_hs,hs,fs) (fs)
 #endif /* CONFIG_USB_GADGET_DUALSPEED */
 
+#define GS_DEBUG 1
+
 /* debug settings */
 #ifdef GS_DEBUG
 static int debug = 1;
@@ -189,7 +197,7 @@
 /* tty driver */
 static int gs_open(struct tty_struct *tty, struct file *file);
 static void gs_close(struct tty_struct *tty, struct file *file);
-static int gs_write(struct tty_struct *tty, 
+static int gs_write(struct tty_struct *tty,
 	const unsigned char *buf, int count);
 static void gs_put_char(struct tty_struct *tty, unsigned char ch);
 static void gs_flush_chars(struct tty_struct *tty);
@@ -211,6 +219,16 @@
 static void gs_write_complete(struct usb_ep *ep, struct usb_request
*req);
 
 /* gadget driver */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int gs_bind(struct usb_composite_dev *cdev);
+static void gs_unbind(struct usb_composite_dev *cdev);
+static int gs_setup(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl);
+static int gs_setup_standard(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl);
+static int gs_setup_class(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl);
+#else
 static int gs_bind(struct usb_gadget *gadget);
 static void gs_unbind(struct usb_gadget *gadget);
 static int gs_setup(struct usb_gadget *gadget,
@@ -219,8 +237,13 @@
 	const struct usb_ctrlrequest *ctrl);
 static int gs_setup_class(struct usb_gadget *gadget,
 	const struct usb_ctrlrequest *ctrl);
+#endif
 static void gs_setup_complete(struct usb_ep *ep, struct usb_request
*req);
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void gs_disconnect(struct usb_composite_dev *cdev);
+#else
 static void gs_disconnect(struct usb_gadget *gadget);
+#endif
 static int gs_set_config(struct gs_dev *dev, unsigned config);
 static void gs_reset_config(struct gs_dev *dev);
 static int gs_build_config_buf(u8 *buf, enum usb_device_speed speed,
@@ -286,7 +309,24 @@
 	.chars_in_buffer =	gs_chars_in_buffer,
 };
 static struct tty_driver *gs_tty_driver;
+static struct usb_gadget_strings gs_string_table;
+struct usb_descriptor_header *gs_acm_fullspeed_function[];
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+/* USB_FUNCTION */
+struct usb_function gs_usb_function = {
+	.name		= GS_LONG_NAME,
+	.strings	= &gs_string_table,
+	.descriptors	= gs_acm_fullspeed_function,
+#ifdef CONFIG_USB_GADGET_DUALSPEED
+	.hs_descriptors	= gs_acm_highspeed_function,
+#endif
+	.bind		= gs_bind,
+	.unbind		= gs_unbind,
+	.setup		= gs_setup,
+	.disconnect	= gs_disconnect,
+};
+#else
 /* gadget driver struct */
 static struct usb_gadget_driver gs_gadget_driver = {
 #ifdef CONFIG_USB_GADGET_DUALSPEED
@@ -303,10 +343,21 @@
 		.name =		GS_SHORT_NAME,
 	},
 };
+#endif
 

 /* USB descriptors */
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+/* eth[11-20], serial[21-27], storage[31-35] */
+#define GS_MANUFACTURER_STR_ID	21
+#define GS_PRODUCT_STR_ID	22
+#define GS_SERIAL_STR_ID	23
+#define GS_BULK_CONFIG_STR_ID	24
+#define GS_ACM_CONFIG_STR_ID	25
+#define GS_CONTROL_STR_ID	26
+#define GS_DATA_STR_ID		27
+#else
 #define GS_MANUFACTURER_STR_ID	1
 #define GS_PRODUCT_STR_ID	2
 #define GS_SERIAL_STR_ID	3
@@ -314,6 +365,7 @@
 #define GS_ACM_CONFIG_STR_ID	5
 #define GS_CONTROL_STR_ID	6
 #define GS_DATA_STR_ID		7
+#endif /* End if Composite*/
 
 /* static strings, in UTF-8 */
 static char manufacturer[50];
@@ -375,7 +427,7 @@
 	.bMaxPower =		1,
 };
 
-static const struct usb_interface_descriptor gs_bulk_interface_desc = {
+struct usb_interface_descriptor gs_bulk_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
 	.bDescriptorType =	USB_DT_INTERFACE,
 	.bInterfaceNumber =	GS_BULK_INTERFACE_ID,
@@ -386,7 +438,7 @@
 	.iInterface =		GS_DATA_STR_ID,
 };
 
-static const struct usb_interface_descriptor gs_control_interface_desc
= {
+struct usb_interface_descriptor gs_control_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
 	.bDescriptorType =	USB_DT_INTERFACE,
 	.bInterfaceNumber =	GS_CONTROL_INTERFACE_ID,
@@ -397,7 +449,7 @@
 	.iInterface =		GS_CONTROL_STR_ID,
 };
 
-static const struct usb_interface_descriptor gs_data_interface_desc = {
+struct usb_interface_descriptor gs_data_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
 	.bDescriptorType =	USB_DT_INTERFACE,
 	.bInterfaceNumber =	GS_DATA_INTERFACE_ID,
@@ -430,14 +482,14 @@
 	.bmCapabilities = 	0,
 };
 
-static const struct usb_cdc_union_desc gs_union_desc = {
+static struct usb_cdc_union_desc gs_union_desc = {
 	.bLength =		sizeof(gs_union_desc),
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubType =	USB_CDC_UNION_TYPE,
 	.bMasterInterface0 =	0,	/* index of control interface */
 	.bSlaveInterface0 =	1,	/* index of data interface */
 };
- 
+
 static struct usb_endpoint_descriptor gs_fullspeed_notify_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
@@ -469,7 +521,7 @@
 	NULL,
 };
 
-static const struct usb_descriptor_header *gs_acm_fullspeed_function[]
= {
+struct usb_descriptor_header *gs_acm_fullspeed_function[] = {
 	(struct usb_descriptor_header *) &gs_otg_descriptor,
 	(struct usb_descriptor_header *) &gs_control_interface_desc,
 	(struct usb_descriptor_header *) &gs_header_desc,
@@ -523,7 +575,7 @@
 	NULL,
 };
 
-static const struct usb_descriptor_header *gs_acm_highspeed_function[]
= {
+struct usb_descriptor_header *gs_acm_highspeed_function[] = {
 	(struct usb_descriptor_header *) &gs_otg_descriptor,
 	(struct usb_descriptor_header *) &gs_control_interface_desc,
 	(struct usb_descriptor_header *) &gs_header_desc,
@@ -575,7 +627,11 @@
 	int i;
 	int retval;
 
-	retval = usb_gadget_register_driver(&gs_gadget_driver);
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		retval = usb_function_register(&gs_usb_function);
+#else
+		retval = usb_gadget_register_driver(&gs_gadget_driver);
+#endif
 	if (retval) {
 		printk(KERN_ERR "gs_module_init: cannot register gadget driver, ret=%
d\n", retval);
 		return retval;
@@ -601,7 +657,10 @@
 
 	retval = tty_register_driver(gs_tty_driver);
 	if (retval) {
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 		usb_gadget_unregister_driver(&gs_gadget_driver);
+#endif
 		put_tty_driver(gs_tty_driver);
 		printk(KERN_ERR "gs_module_init: cannot register tty driver, ret=%d
\n", retval);
 		return retval;
@@ -620,7 +679,11 @@
 {
 	tty_unregister_driver(gs_tty_driver);
 	put_tty_driver(gs_tty_driver);
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	usb_function_unregister(&gs_usb_function);
+#else
 	usb_gadget_unregister_driver(&gs_gadget_driver);
+#endif
 
 	printk(KERN_INFO "gs_module_exit: %s %s unloaded\n", GS_LONG_NAME,
GS_VERSION_STR);
 }
@@ -1351,8 +1414,14 @@
  * Called on module load.  Allocates and initializes the device
  * structure and a control request.
  */
-static int __init gs_bind(struct usb_gadget *gadget)
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int __devinit gs_bind(struct usb_composite_dev *cdev)
 {
+	struct usb_gadget *gadget = cdev->gadget;
+#else
+static int __devinit gs_bind(struct usb_gadget *gadget)
+{
+#endif
 	int ret;
 	struct usb_ep *ep;
 	struct gs_dev *dev;
@@ -1377,7 +1446,10 @@
 			__constant_cpu_to_le16(GS_VERSION_NUM|0x0099);
 	}
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 	usb_ep_autoconfig_reset(gadget);
+#endif
 
 	ep = usb_ep_autoconfig(gadget, &gs_fullspeed_in_desc);
 	if (!ep)
@@ -1441,15 +1513,26 @@
 	dev->dev_gadget = gadget;
 	spin_lock_init(&dev->dev_lock);
 	INIT_LIST_HEAD(&dev->dev_req_list);
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	cdev->current_func->driver_data = dev;
+#else
 	set_gadget_data(gadget, dev);
+#endif
 
 	if ((ret=gs_alloc_ports(dev, GFP_KERNEL)) != 0) {
 		printk(KERN_ERR "gs_bind: cannot allocate ports\n");
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		gs_unbind(cdev);
+#else
 		gs_unbind(gadget);
+#endif
 		return ret;
 	}
 
 	/* preallocate control response and buffer */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	dev->dev_ctrl_req = cdev->req;
+#else
 	dev->dev_ctrl_req = gs_alloc_req(gadget->ep0, GS_MAX_DESC_LEN,
 		GFP_KERNEL);
 	if (dev->dev_ctrl_req == NULL) {
@@ -1459,9 +1542,13 @@
 	dev->dev_ctrl_req->complete = gs_setup_complete;
 
 	gadget->ep0->driver_data = dev;
+#endif
+
 
 	printk(KERN_INFO "gs_bind: %s %s bound\n",
 		GS_LONG_NAME, GS_VERSION_STR);
+	printk(KERN_INFO "using %s, OUT %s IN %s STATUS %s\n",
+		gadget->name, EP_OUT_NAME, EP_IN_NAME, EP_NOTIFY_NAME);
 
 	return 0;
 
@@ -1476,14 +1563,25 @@
  * Called on module unload.  Frees the control request and device
  * structure.
  */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void /* __init_or_exit */ gs_unbind(struct usb_composite_dev
*cdev)
+{
+	struct gs_dev	*dev = cdev->current_func->driver_data;
+#else
 static void /* __init_or_exit */ gs_unbind(struct usb_gadget *gadget)
 {
 	struct gs_dev *dev = get_gadget_data(gadget);
 
+#endif
 	gs_device = NULL;
 
 	/* read/write requests already freed, only control request remains */
 	if (dev != NULL) {
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		dev->dev_ctrl_req = NULL;
+		gs_free_ports(dev);
+		kfree(dev);
+#else
 		if (dev->dev_ctrl_req != NULL) {
 			gs_free_req(gadget->ep0, dev->dev_ctrl_req);
 			dev->dev_ctrl_req = NULL;
@@ -1491,6 +1589,7 @@
 		gs_free_ports(dev);
 		kfree(dev);
 		set_gadget_data(gadget, NULL);
+#endif
 	}
 
 	printk(KERN_INFO "gs_unbind: %s %s unbound\n", GS_LONG_NAME,
@@ -1506,11 +1605,19 @@
  * Returns the size of the data sent to the host, or a negative
  * error number.
  */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int gs_setup(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl)
+{
+	struct usb_gadget *gadget = cdev->gadget;
+	struct gs_dev *dev = cdev->current_func->driver_data;
+#else
 static int gs_setup(struct usb_gadget *gadget,
 	const struct usb_ctrlrequest *ctrl)
 {
-	int ret = -EOPNOTSUPP;
 	struct gs_dev *dev = get_gadget_data(gadget);
+#endif
+	int ret = -EOPNOTSUPP;
 	struct usb_request *req = dev->dev_ctrl_req;
 	u16 wIndex = le16_to_cpu(ctrl->wIndex);
 	u16 wValue = le16_to_cpu(ctrl->wValue);
@@ -1518,11 +1625,22 @@
 
 	switch (ctrl->bRequestType & USB_TYPE_MASK) {
 	case USB_TYPE_STANDARD:
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		ret = gs_setup_standard(cdev,ctrl);
+		/* Send to host only composite configuration */
+		if( (wValue >> 8) == USB_REQ_SET_CONFIGURATION )
+			goto done_composite;
+#else
 		ret = gs_setup_standard(gadget,ctrl);
+#endif
 		break;
 
 	case USB_TYPE_CLASS:
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		ret = gs_setup_class(cdev,ctrl);
+#else
 		ret = gs_setup_class(gadget,ctrl);
+#endif
 		break;
 
 	default:
@@ -1546,15 +1664,24 @@
 		}
 	}
 
+done_composite:
 	/* device either stalls (ret < 0) or reports success */
 	return ret;
 }
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int gs_setup_standard(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl)
+{
+	struct usb_gadget *gadget = cdev->gadget;
+	struct gs_dev *dev = cdev->current_func->driver_data;
+#else
 static int gs_setup_standard(struct usb_gadget *gadget,
 	const struct usb_ctrlrequest *ctrl)
 {
-	int ret = -EOPNOTSUPP;
 	struct gs_dev *dev = get_gadget_data(gadget);
+#endif
+	int ret = -EOPNOTSUPP;
 	struct usb_request *req = dev->dev_ctrl_req;
 	u16 wIndex = le16_to_cpu(ctrl->wIndex);
 	u16 wValue = le16_to_cpu(ctrl->wValue);
@@ -1620,13 +1747,19 @@
 		break;
 
 	case USB_REQ_SET_INTERFACE:
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		wIndex = wIndex - cdev->current_func->interface_shift;
+#endif
 		if (ctrl->bRequestType != USB_RECIP_INTERFACE
 				|| !dev->dev_config
 				|| wIndex >= GS_MAX_NUM_INTERFACES)
 			break;
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 		if (dev->dev_config == GS_BULK_CONFIG_ID
 				&& wIndex != GS_BULK_INTERFACE_ID)
 			break;
+#endif
 		/* no alternate interface settings */
 		if (wValue != 0)
 			break;
@@ -1680,11 +1813,18 @@
 	return ret;
 }
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int gs_setup_class(struct usb_composite_dev *cdev,
+	const struct usb_ctrlrequest *ctrl)
+{
+	struct gs_dev *dev = cdev->current_func->driver_data;
+#else
 static int gs_setup_class(struct usb_gadget *gadget,
 	const struct usb_ctrlrequest *ctrl)
 {
-	int ret = -EOPNOTSUPP;
 	struct gs_dev *dev = get_gadget_data(gadget);
+#endif
+	int ret = -EOPNOTSUPP;
 	struct gs_port *port = dev->dev_port[0];	/* ACM only has one port */
 	struct usb_request *req = dev->dev_ctrl_req;
 	u16 wIndex = le16_to_cpu(ctrl->wIndex);
@@ -1745,10 +1885,17 @@
  * ports and disconnects open ports.  Open ports will be freed
  * on close.  Then reallocates the ports for the next connection.
  */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void gs_disconnect(struct usb_composite_dev *cdev)
+{
+//	struct usb_gadget *gadget = cdev->gadget;
+	struct gs_dev	*dev = cdev->current_func->driver_data;
+#else
 static void gs_disconnect(struct usb_gadget *gadget)
 {
-	unsigned long flags;
 	struct gs_dev *dev = get_gadget_data(gadget);
+#endif
+	unsigned long flags;
 
 	spin_lock_irqsave(&dev->dev_lock, flags);
 

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
