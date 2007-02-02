From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 4/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:49:25 -0400
Message-ID: <1170431365.23028.63.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

[PATCH] g_file_storage modification for it to become a USB_FUNCTION.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

Index: 2.6-dev/drivers/usb/gadget/file_storage.c
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/file_storage.c	2007-01-29
11:47:19.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/file_storage.c	2007-01-29
11:47:29.000000000 -0400
@@ -221,6 +221,10 @@
 #undef VERBOSE
 #undef DUMP_MSGS
 
+#define DEBUG 1
+#define VERBOSE 1
+#define DUMP_MSGS 1
+
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -255,6 +259,7 @@
 
 #include <linux/usb_ch9.h>
 #include <linux/usb_gadget.h>
+#include <linux/usb/composite.h>
 
 #include "gadget_chips.h"
 
@@ -844,14 +849,32 @@
  * descriptors are built on demand.  Also the (static) config and
interface
  * descriptors are adjusted during fsg_bind().
  */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+/* eth[11-20], serial[21-27], storage[31-35] */
+#define STRING_MANUFACTURER	31
+#define STRING_PRODUCT		32
+#define STRING_SERIAL		33
+#define STRING_CONFIG		34
+#define STRING_INTERFACE	35
+#else
 #define STRING_MANUFACTURER	1
 #define STRING_PRODUCT		2
 #define STRING_SERIAL		3
 #define STRING_CONFIG		4
 #define STRING_INTERFACE	5
+#endif /* End if Composite*/
 
+/* If Composite Framework is enabled, we need a default configuration
value
+ * of 3. Else, we use the module's defaul
+ */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#define COMPOSITE_CONFIG_VALUE  3	/* composite config */
 /* There is only one configuration. */
+#define	CONFIG_VALUE		COMPOSITE_CONFIG_VALUE
+#else
+           /* There is only one configuration. */
 #define	CONFIG_VALUE		1
+#endif
 
 static struct usb_device_descriptor
 device_desc = {
@@ -941,7 +964,7 @@
 	.bInterval =		32,	// frames -> 32 ms
 };
 
-static const struct usb_descriptor_header *fs_function[] = {
+static struct usb_descriptor_header *fs_function[] = {
 	(struct usb_descriptor_header *) &otg_desc,
 	(struct usb_descriptor_header *) &intf_desc,
 	(struct usb_descriptor_header *) &fs_bulk_in_desc,
@@ -1123,9 +1146,15 @@
  * completion of various requests: set config, set interface, and
  * Bulk-only device reset. */
 
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void fsg_disconnect(struct usb_composite_dev *cdev)
+{
+	struct fsg_dev *fsg = cdev->current_func->driver_data;
+#else
 static void fsg_disconnect(struct usb_gadget *gadget)
 {
 	struct fsg_dev		*fsg = get_gadget_data(gadget);
+#endif
 
 	DBG(fsg, "disconnect or port reset\n");
 	raise_exception(fsg, FSG_STATE_DISCONNECT);
@@ -1494,10 +1523,17 @@
 }
 

+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int fsg_setup(struct usb_composite_dev *cdev,
+		const struct usb_ctrlrequest *ctrl)
+{
+	struct fsg_dev *fsg = cdev->current_func->driver_data;
+#else
 static int fsg_setup(struct usb_gadget *gadget,
 		const struct usb_ctrlrequest *ctrl)
 {
 	struct fsg_dev		*fsg = get_gadget_data(gadget);
+#endif
 	int			rc;
 	int			w_length = le16_to_cpu(ctrl->wLength);
 
@@ -3705,9 +3741,16 @@
 	kref_put(&fsg->ref, fsg_release);
 }
 
+
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void /* __init_or_exit */ fsg_unbind(struct usb_composite_dev
*cdev)
+{
+	struct fsg_dev *fsg = cdev->current_func->driver_data;
+#else
 static void /* __init_or_exit */ fsg_unbind(struct usb_gadget *gadget)
 {
 	struct fsg_dev		*fsg = get_gadget_data(gadget);
+#endif
 	int			i;
 	struct lun		*curlun;
 	struct usb_request	*req = fsg->ep0req;
@@ -3752,7 +3795,11 @@
 		usb_ep_free_request(fsg->ep0, req);
 	}
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	cdev->current_func->driver_data = NULL;
+#else
 	set_gadget_data(gadget, NULL);
+#endif
 }
 

@@ -3841,8 +3888,14 @@
 }
 

-static int __init fsg_bind(struct usb_gadget *gadget)
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static int __devinit fsg_bind(struct usb_composite_dev *cdev)
 {
+	struct usb_gadget *gadget = cdev->gadget;
+#else
+static int __devinit fsg_bind(struct usb_gadget *gadget)
+{
+#endif
 	struct fsg_dev		*fsg = the_fsg;
 	int			rc;
 	int			i;
@@ -3852,9 +3905,16 @@
 	char			*pathbuf, *p;
 
 	fsg->gadget = gadget;
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	cdev->current_func->driver_data = fsg;
+#else
 	set_gadget_data(gadget, fsg);
+#endif
 	fsg->ep0 = gadget->ep0;
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 	fsg->ep0->driver_data = fsg;
+#endif
 
 	if ((rc = check_parameters(fsg)) != 0)
 		goto out;
@@ -3920,7 +3980,10 @@
 	}
 
 	/* Find all the endpoints we will use */
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+#else
 	usb_ep_autoconfig_reset(gadget);
+#endif
 	ep = usb_ep_autoconfig(gadget, &fs_bulk_in_desc);
 	if (!ep)
 		goto autoconf_fail;
@@ -3972,6 +4035,10 @@
 
 	rc = -ENOMEM;
 
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	fsg->ep0req = req = cdev->req;
+	req->buf = cdev->req->buf;
+#else
 	/* Allocate the request and buffer for endpoint 0 */
 	fsg->ep0req = req = usb_ep_alloc_request(fsg->ep0, GFP_KERNEL);
 	if (!req)
@@ -3981,7 +4048,7 @@
 	if (!req->buf)
 		goto out;
 	req->complete = ep0_complete;
-
+#endif
 	/* Allocate the data buffers */
 	for (i = 0; i < NUM_BUFFERS; ++i) {
 		struct fsg_buffhd	*bh = &fsg->buffhds[i];
@@ -4024,6 +4091,12 @@
 	INFO(fsg, DRIVER_DESC ", version: " DRIVER_VERSION "\n");
 	INFO(fsg, "Number of LUNs=%d\n", fsg->nluns);
 
+	INFO (fsg, "using %s, OUT %s IN %s%s%s\n", gadget->name,
+		fsg->bulk_out->name, fsg->bulk_in->name,
+		fsg->intr_in ? " STATUS " : "",
+		fsg->intr_in ? fsg->intr_in->name : ""
+		);
+
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
 	for (i = 0; i < fsg->nluns; ++i) {
 		curlun = &fsg->luns[i];
@@ -4065,7 +4138,11 @@
 
 out:
 	fsg->state = FSG_STATE_TERMINATED;	// The thread is dead
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	fsg_unbind(cdev);
+#else
 	fsg_unbind(gadget);
+#endif
 	close_all_backing_files(fsg);
 	return rc;
 }
@@ -4073,17 +4150,29 @@
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void fsg_suspend(struct usb_composite_dev *cdev)
+{
+	struct fsg_dev *fsg = cdev->current_func->driver_data;
+#else
 static void fsg_suspend(struct usb_gadget *gadget)
 {
 	struct fsg_dev		*fsg = get_gadget_data(gadget);
+#endif
 
 	DBG(fsg, "suspend\n");
 	set_bit(SUSPENDED, &fsg->atomic_bitflags);
 }
 
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static void fsg_resume(struct usb_composite_dev *cdev)
+{
+	struct fsg_dev *fsg = cdev->current_func->driver_data;
+#else
 static void fsg_resume(struct usb_gadget *gadget)
 {
 	struct fsg_dev		*fsg = get_gadget_data(gadget);
+#endif
 
 	DBG(fsg, "resume\n");
 	clear_bit(SUSPENDED, &fsg->atomic_bitflags);
@@ -4091,7 +4180,22 @@
 

 /*-------------------------------------------------------------------------*/
-
+#if defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+static struct usb_function	fsg_usb_function = {
+	.name		= DRIVER_DESC,
+	.strings	= &stringtab,
+	.descriptors	= fs_function,
+#ifdef CONFIG_USB_GADGET_DUALSPEED
+	.hs_descriptors	= fs_function,
+#endif
+	.bind		= fsg_bind,
+	.unbind		= fsg_unbind,
+	.setup		= fsg_setup,
+	.disconnect	= fsg_disconnect,
+	.suspend	= fsg_suspend,
+	.resume		= fsg_resume,
+};
+#else /* not def composite */
 static struct usb_gadget_driver		fsg_driver = {
 #ifdef CONFIG_USB_GADGET_DUALSPEED
 	.speed		= USB_SPEED_HIGH,
@@ -4114,7 +4218,7 @@
 		// .resume = ...
 	},
 };
-
+#endif /* ifdef composite */
 
 static int __init fsg_alloc(void)
 {
@@ -4141,8 +4245,13 @@
 	if ((rc = fsg_alloc()) != 0)
 		return rc;
 	fsg = the_fsg;
+
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+	if ((rc = usb_function_register(&fsg_usb_function)) != 0)
+#else
 	if ((rc = usb_gadget_register_driver(&fsg_driver)) != 0)
-		kref_put(&fsg->ref, fsg_release);
+#endif
+			kref_put(&fsg->ref, fsg_release);
 	return rc;
 }
 module_init(fsg_init);
@@ -4154,8 +4263,11 @@
 
 	/* Unregister the driver iff the thread hasn't already done so */
 	if (test_and_clear_bit(REGISTERED, &fsg->atomic_bitflags))
+#if	defined(CONFIG_USB_COMPOSITE) ||
defined(CONFIG_USB_COMPOSITE_MODULE)
+		usb_function_unregister(&fsg_usb_function);
+#else
 		usb_gadget_unregister_driver(&fsg_driver);
-
+#endif
 	/* Wait for the thread to finish up */
 	wait_for_completion(&fsg->thread_notifier);
 

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
