From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 3/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:47:42 -0400
Message-ID: <1170431262.23028.51.camel@balbi>
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

[PATCH] g_ether modification for it to become a USB_FUNCTION.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

Index: 2.6-dev/drivers/usb/gadget/ether.c
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/ether.c	2007-01-29
11:45:37.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/ether.c	2007-01-29 11:46:00.000000000
-0400
@@ -20,8 +20,8 @@
  */
 

-// #define DEBUG 1
-// #define VERBOSE
+#define DEBUG 1
+#define VERBOSE 1
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -50,6 +50,7 @@
 #include <linux/usb_ch9.h>
 #include <linux/usb/cdc.h>
 #include <linux/usb_gadget.h>
+#include <linux/usb/composite.h>
 
 #include <linux/random.h>
 #include <linux/netdevice.h>
@@ -398,7 +399,19 @@
  * Ethernet functionality), they don't need the NOP altsetting, and the
  * status transfer endpoint isn't optional.
  */
-
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+/* eth[11-20], serial[21-27], storage[31-35] */
+#define STRING_MANUFACTURER		11
+#define STRING_PRODUCT			12
+#define STRING_ETHADDR			13
+#define STRING_DATA			14
+#define STRING_CONTROL			15
+#define STRING_RNDIS_CONTROL		16
+#define STRING_CDC			17
+#define STRING_SUBSET			18
+#define STRING_RNDIS			19
+#define STRING_SERIALNUMBER		20
+#else
 #define STRING_MANUFACTURER		1
 #define STRING_PRODUCT			2
 #define STRING_ETHADDR			3
@@ -409,6 +422,7 @@
 #define STRING_SUBSET			8
 #define STRING_RNDIS			9
 #define STRING_SERIALNUMBER		10
+#endif /* End if Composite*/
 
 /* holds our biggest descriptor (or RNDIS response) */
 #define USB_BUFSIZ	256
@@ -423,8 +437,12 @@
  * FIXME define some higher-powered configurations to make it easier
  * to recharge batteries ...
  */
-
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#define COMPOSITE_CONFIG_VALUE  3	/* composite config */
+#define DEV_CONFIG_VALUE	COMPOSITE_CONFIG_VALUE
+#else
 #define DEV_CONFIG_VALUE	1	/* cdc or subset */
+#endif
 #define DEV_RNDIS_CONFIG_VALUE	2	/* rndis; optional */
 
 static struct usb_device_descriptor
@@ -492,7 +510,7 @@
  */
 
 #ifdef	DEV_CONFIG_CDC
-static struct usb_interface_descriptor
+struct usb_interface_descriptor
 control_intf = {
 	.bLength =		sizeof control_intf,
 	.bDescriptorType =	USB_DT_INTERFACE,
@@ -508,7 +526,7 @@
 #endif
 
 #ifdef	CONFIG_USB_ETH_RNDIS
-static const struct usb_interface_descriptor
+struct usb_interface_descriptor
 rndis_control_intf = {
 	.bLength =              sizeof rndis_control_intf,
 	.bDescriptorType =      USB_DT_INTERFACE,
@@ -532,7 +550,7 @@
 	.bcdCDC =		__constant_cpu_to_le16 (0x0110),
 };
 
-static const struct usb_cdc_union_desc union_desc = {
+static struct usb_cdc_union_desc union_desc = {
 	.bLength =		sizeof union_desc,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubType =	USB_CDC_UNION_TYPE,
@@ -616,7 +634,7 @@
 
 /* the default data interface has no endpoints ... */
 
-static const struct usb_interface_descriptor
+struct usb_interface_descriptor
 data_nop_intf = {
 	.bLength =		sizeof data_nop_intf,
 	.bDescriptorType =	USB_DT_INTERFACE,
@@ -631,7 +649,7 @@
 
 /* ... but the "real" data interface has two bulk endpoints */
 
-static const struct usb_interface_descriptor
+struct usb_interface_descriptor
 data_intf = {
 	.bLength =		sizeof data_intf,
 	.bDescriptorType =	USB_DT_INTERFACE,
@@ -651,7 +669,7 @@
 
 /* RNDIS doesn't activate by changing to the "real" altsetting */
 
-static const struct usb_interface_descriptor
+struct usb_interface_descriptor
 rndis_data_intf = {
 	.bLength =		sizeof rndis_data_intf,
 	.bDescriptorType =	USB_DT_INTERFACE,
@@ -674,7 +692,7 @@
  * full speed controllers can handle:  one interface, two bulk
endpoints.
  */
 
-static const struct usb_interface_descriptor
+struct usb_interface_descriptor
 subset_data_intf = {
 	.bLength =		sizeof subset_data_intf,
 	.bDescriptorType =	USB_DT_INTERFACE,
@@ -709,7 +727,7 @@
 	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
 };
 
-static const struct usb_descriptor_header *fs_eth_function [11] = {
+static struct usb_descriptor_header *fs_eth_function [11] = {
 	(struct usb_descriptor_header *) &otg_descriptor,
 #ifdef DEV_CONFIG_CDC
 	/* "cdc" mode descriptors */
@@ -806,7 +824,7 @@
 	.bNumConfigurations =	1,
 };
 
-static const struct usb_descriptor_header *hs_eth_function [11] = {
+static struct usb_descriptor_header *hs_eth_function [11] = {
 	(struct usb_descriptor_header *) &otg_descriptor,
 #ifdef DEV_CONFIG_CDC
 	/* "cdc" mode descriptors */
@@ -1300,10 +1318,18 @@
  *  - class-specific control requests
  */
 static int
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_setup (struct usb_composite_dev *cdev, const struct usb_ctrlrequest
*ctrl)
+{
+	struct usb_gadget *gadget = cdev->gadget;
+	struct eth_dev	*dev = cdev->current_func->driver_data;
+	struct usb_request	*req = dev->req;
+#else
 eth_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest
*ctrl)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
 	struct usb_request	*req = dev->req;
+#endif
 	int			value = -EOPNOTSUPP;
 	u16			wIndex = le16_to_cpu(ctrl->wIndex);
 	u16			wValue = le16_to_cpu(ctrl->wValue);
@@ -1365,6 +1391,7 @@
 		spin_lock (&dev->lock);
 		value = eth_set_config (dev, wValue, GFP_ATOMIC);
 		spin_unlock (&dev->lock);
+		goto done_composite;
 		break;
 	case USB_REQ_GET_CONFIGURATION:
 		if (ctrl->bRequestType != USB_DIR_IN)
@@ -1374,6 +1401,9 @@
 		break;
 
 	case USB_REQ_SET_INTERFACE:
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		wIndex = wIndex - cdev->current_func->interface_shift;
+#endif
 		if (ctrl->bRequestType != USB_RECIP_INTERFACE
 				|| !dev->config
 				|| wIndex > 1)
@@ -1543,15 +1573,21 @@
 			eth_setup_complete (gadget->ep0, req);
 		}
 	}
-
+done_composite:
 	/* host either stalls (value < 0) or reports success */
 	return value;
 }
 
 static void
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_disconnect (struct usb_composite_dev *cdev)
+{
+	struct eth_dev	*dev =  cdev->current_func->driver_data;
+#else
 eth_disconnect (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
+#endif
 	unsigned long		flags;
 
 	spin_lock_irqsave (&dev->lock, flags);
@@ -2148,19 +2184,28 @@
 

 static void /* __init_or_exit */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_unbind (struct usb_composite_dev *cdev)
+{
+	struct eth_dev	*dev = cdev->current_func->driver_data;
+#else
 eth_unbind (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
+#endif
 
 	DEBUG (dev, "unbind\n");
 	rndis_deregister (dev->rndis_config);
 	rndis_exit ();
-
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	dev->req = NULL;
+#else
 	/* we've already been disconnected ... no i/o is active */
 	if (dev->req) {
 		eth_req_free (gadget->ep0, dev->req);
 		dev->req = NULL;
 	}
+#endif
 	if (dev->stat_req) {
 		eth_req_free (dev->status_ep, dev->stat_req);
 		dev->stat_req = NULL;
@@ -2171,7 +2216,10 @@
 
 	/* assuming we used keventd, it must quiesce too */
 	flush_scheduled_work ();
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 	set_gadget_data (gadget, NULL);
+#endif
 }
 
 static u8 __devinit nibble (unsigned char c)
@@ -2206,8 +2254,14 @@
 }
 
 static int __devinit
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_bind (struct usb_composite_dev *cdev)
+{
+	struct usb_gadget *gadget = cdev->gadget;
+#else
 eth_bind (struct usb_gadget *gadget)
 {
+#endif
 	struct eth_dev		*dev;
 	struct net_device	*net;
 	u8			cdc = 1, zlp = 1, rndis = 1;
@@ -2308,8 +2362,11 @@
 		strlcpy(serial_number, iSerialNumber, sizeof serial_number);
 	}
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 	/* all we really need is bulk IN/OUT */
 	usb_ep_autoconfig_reset (gadget);
+#endif
 	in_ep = usb_ep_autoconfig (gadget, &fs_source_desc);
 	if (!in_ep) {
 autoconf_fail:
@@ -2451,11 +2508,14 @@
 	SET_ETHTOOL_OPS(net, &ops);
 
 	/* preallocate control message data and buffer */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	dev->req = cdev->req;
+#else
 	dev->req = eth_req_alloc (gadget->ep0, USB_BUFSIZ, GFP_KERNEL);
 	if (!dev->req)
 		goto fail;
 	dev->req->complete = eth_setup_complete;
-
+#endif
 	/* ... and maybe likewise for status transfer */
 #if defined(DEV_CONFIG_CDC) || defined(CONFIG_USB_ETH_RNDIS)
 	if (dev->status_ep) {
@@ -2471,8 +2531,13 @@
 
 	/* finish hookup to lower layer ... */
 	dev->gadget = gadget;
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	cdev->current_func->driver_data = dev;
+#else
 	set_gadget_data (gadget, dev);
 	gadget->ep0->driver_data = dev;
+#endif
+
 
 	/* two kinds of host-initiated state changes:
 	 *  - iff DATA transfer is active, carrier is "on"
@@ -2536,25 +2601,42 @@
 fail1:
 	dev_dbg(&gadget->dev, "register_netdev failed, %d\n", status);
 fail:
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	eth_unbind (cdev);
+#else
 	eth_unbind (gadget);
+#endif
 	return status;
 }
 
 /*-------------------------------------------------------------------------*/
 
 static void
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_suspend (struct usb_composite_dev *cdev)
+{
+	struct eth_dev	*dev = cdev->current_func->driver_data;
+
+#else
 eth_suspend (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
+#endif
 
 	DEBUG (dev, "suspend\n");
 	dev->suspended = 1;
 }
 
 static void
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+eth_resume (struct usb_composite_dev *cdev)
+{
+	struct eth_dev	*dev = cdev->current_func->driver_data;
+#else
 eth_resume (struct usb_gadget *gadget)
 {
 	struct eth_dev		*dev = get_gadget_data (gadget);
+#endif
 
 	DEBUG (dev, "resume\n");
 	dev->suspended = 0;
@@ -2562,6 +2644,23 @@
 
 /*-------------------------------------------------------------------------*/
 
+
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static struct usb_function eth_usb_function = {
+	.name		= (char *) shortname,
+	.strings	= &stringtab,
+	.descriptors	= fs_eth_function,
+#ifdef CONFIG_USB_GADGET_DUALSPEED
+	.hs_descriptors	= hs_eth_function,
+#endif
+	.bind		= eth_bind,
+	.unbind		= eth_unbind,
+	.setup		= eth_setup,
+	.disconnect	= eth_disconnect,
+	.suspend	= eth_suspend,
+	.resume		= eth_resume,
+};
+#else
 static struct usb_gadget_driver eth_driver = {
 	.speed		= DEVSPEED,
 
@@ -2580,6 +2679,7 @@
 		.owner		= THIS_MODULE,
 	},
 };
+#endif
 
 MODULE_DESCRIPTION (DRIVER_DESC);
 MODULE_AUTHOR ("David Brownell, Benedikt Spanger");
@@ -2588,13 +2688,21 @@
 
 static int __init init (void)
 {
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	return usb_function_register (&eth_usb_function);
+#else
 	return usb_gadget_register_driver (&eth_driver);
+#endif
 }
 module_init (init);
 
 static void __exit cleanup (void)
 {
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	usb_function_unregister (&eth_usb_function);
+#else
 	usb_gadget_unregister_driver (&eth_driver);
+#endif
 }
 module_exit (cleanup);
 

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
