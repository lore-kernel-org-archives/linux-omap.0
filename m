From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 1/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:49:02 -0400
Message-ID: <1170431342.23028.59.camel@balbi>
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

Add <linux/usb/composite.h> interfaces for composite gadget drivers:

    -   struct usb_function ... grouping one or more interfaces into
        a function that will often be managed as one unit;

    -   struct usb_composite_driver ... grouping one or more such
        functions into a gadget driver.

    -   struct usb_composite_dev ... what's managed by the composite
        driver.

There's an implementation library behind the "composite_driver" which
exposes the "composite_dev".

Separate patches will be updating some gadget drivers to use this
new interface.

UNTESTED.

Signed-off-by: David Brownell <david-b@pacbel.net>
---

Index: 2.6-dev/drivers/usb/gadget/composite.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6-dev/drivers/usb/gadget/composite.c	2007-01-29 11:57:48.000000000
-0400
@@ -0,0 +1,679 @@
+#define DEBUG 1
+// #define VERBOSE
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/utsname.h>
+#include <linux/device.h>
+#include <linux/moduleparam.h>
+
+#include <asm/byteorder.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+#include <linux/usb_ch9.h>
+#include <linux/usb_gadget.h>
+#include <linux/usb/composite.h>
+
+
+#define xprintk(d,level,fmt,args...) \
+       dev_printk(level , &(d)->gadget->dev , fmt , ## args)
+
+#ifdef DEBUG
+#define DBG(dev,fmt,args...) \
+       xprintk(dev , KERN_DEBUG , fmt , ## args)
+#else
+#define DBG(dev,fmt,args...) \
+       do { } while(0)
+#endif /* DEBUG */
+
+#ifdef VERBOSE
+#define VDBG   DBG
+#else
+#define VDBG(dev,fmt,args...) \
+       do { } while(0)
+#endif /* VERBOSE */
+
+#define ERROR(dev,fmt,args...) \
+       xprintk(dev , KERN_ERR , fmt , ## args)
+#define WARN(dev,fmt,args...) \
+       xprintk(dev , KERN_WARNING , fmt , ## args)
+#define INFO(dev,fmt,args...) \
+       xprintk(dev , KERN_INFO , fmt , ## args)
+
+/*-------------------------------------------------------------------------*/
+
+/* big enough to hold our biggest descriptor */
+#define USB_BUFSIZ     512
+
+
+static struct usb_composite_driver     *composite;
+
+static inline int is_dualspeed(struct usb_gadget *g)
+{
+#ifdef CONFIG_USB_GADGET_DUALSPEED
+       return g->is_dualspeed;
+#else
+       return 0;
+#endif
+}
+
+static inline int is_otg(struct usb_gadget *g)
+{
+#ifdef CONFIG_USB_OTG
+       return g->is_otg;
+#else
+       return 0;
+#endif
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* To simplify, we expect to have only ONE real configuration, working
the
+ * same no matter what speed it connects with.  A given function may
expose
+ * multiple interfaces.  Each interface includes its descriptor, plus
optional
+ * class and endpoint descriptors (as usual).
+ */
+
+#define        CONFIG_NUMBER   1
+
+static int
+config_buf(struct usb_composite_dev *cdev, void *buf, u8 type)
+{
+       struct usb_config_descriptor    *c = buf;
+       void                            *next = buf +
USB_DT_CONFIG_SIZE;
+       int                             len = USB_BUFSIZ -
USB_DT_CONFIG_SIZE;
+       int                             hs;
+       struct usb_function             *f;
+
+       if (is_dualspeed(cdev->gadget)) {
+               hs = (cdev->gadget->speed == USB_SPEED_HIGH);
+               if (type == USB_DT_OTHER_SPEED_CONFIG)
+                       hs = !hs;
+       } else
+               hs = 0;
+
+       /* write a config descriptor */
+       *c = cdev->config;
+       c->bLength = USB_DT_CONFIG_SIZE;
+       c->bDescriptorType = type;
+       c->bConfigurationValue = CONFIG_NUMBER;
+
+       /* REVISIT some configurations might need other descriptors,
+        * independent of the interfaces they implement ... notably
+        * OTG descriptors.
+        */
+
+       /* add each function's descriptors */
+       list_for_each_entry (f, &composite->functions, function) {
+               int                     status;
+
+               status = usb_descriptor_fillbuf(next, len,
+                               hs ? f->hs_descriptors :
f->descriptors);
+               if (status < 0)
+                       return status;
+               len -= status;
+               next += status;
+       }
+
+       len = next - buf;
+       c->wTotalLength = cpu_to_le16(len);
+       return len;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void composite_reset_config(
+       struct usb_composite_dev        *cdev,
+       struct usb_ctrlrequest          *req
+) {
+       struct usb_function             *f;
+       int                             result;
+
+       DBG(cdev, "reset config\n");
+
+       req->bRequestType = USB_DIR_OUT | USB_TYPE_STANDARD |
USB_RECIP_DEVICE;
+       req->bRequest = USB_REQ_SET_CONFIGURATION;
+
+       list_for_each_entry (f, &composite->functions, function) {
+               result = f->setup(cdev, req);
+               if (result < 0)
+                       DBG(cdev, "reset function %s --> %d\n",
+                                       f->name, result);
+       }
+       cdev->config.bConfigurationValue = 0;
+}
+
+static int
+composite_set_config(struct usb_composite_dev *cdev, unsigned number)
+{
+       int                     result = 0, tmp;
+       struct usb_gadget       *gadget = cdev->gadget;
+       struct usb_ctrlrequest  req;
+
+       memset(&req, 0, sizeof req);
+
+       /* for now function drivers should assume SET_CONFIGURATION
means
+        * reset/deconfigure, with SET_INTERFACE to each interface used
+        * to activate some altsetting in "the single" configuration.
+        */
+       composite_reset_config(cdev, &req);
+
+       switch (number) {
+       default:
+               result = -EINVAL;
+               /* FALLTHROUGH */
+       case 0:
+               usb_gadget_vbus_draw(gadget, is_otg(gadget) ? 8 : 100);
+               break;
+       case CONFIG_NUMBER:
+               req.bRequestType = USB_DIR_OUT
+                               | USB_TYPE_STANDARD
+                               | USB_RECIP_INTERFACE;
+               req.bRequest = USB_REQ_SET_INTERFACE;
+
+               for (tmp = 0; tmp < MAX_COMPOSITE_INTERFACES; tmp++) {
+                       struct usb_function     *f =
cdev->interface[tmp];
+
+                       if (!f)
+                               continue;
+                       req.wIndex = cpu_to_le16(tmp);
+                       result = f->setup(cdev, &req);
+                       if (result < 0) {
+                               DBG(cdev, "interface %d/%s alt 0--> %d
\n",
+                                               tmp, f->name, result);
+                               (void) composite_set_config(cdev, 0);
+                               return result;
+                       }
+               }
+
+               cdev->config.bConfigurationValue = number;
+               usb_gadget_vbus_draw(gadget, 2 *
cdev->config.bMaxPower);
+               break;
+       }
+
+       INFO(cdev, "%s speed config #%d\n",
+               ({ char *speed;
+               switch (gadget->speed) {
+               case USB_SPEED_LOW:     speed = "low"; break;
+               case USB_SPEED_FULL:    speed = "full"; break;
+               case USB_SPEED_HIGH:    speed = "high"; break;
+               default:                speed = "?"; break;
+               } ; speed; }), number);
+
+       return result;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void
+composite_collect_langs(const struct usb_gadget_strings **sp, __le16
*buf)
+{
+       const struct usb_gadget_strings *s;
+       u16                             language;
+       __le16                          *tmp;
+
+       while (*sp) {
+               s = *sp;
+               language = cpu_to_le16(s->language);
+               for (tmp = buf; *tmp && tmp < &buf[126]; tmp++) {
+                       if (*tmp == language)
+                               goto repeat;
+               }
+               *tmp++ = language;
+repeat:
+               sp++;
+       }
+}
+
+static int composite_check_string(
+       const struct usb_gadget_strings **sp,
+       void                            *buf,
+       u16                             language,
+       int                             id
+)
+{
+       const struct usb_gadget_strings *s;
+       int                             value;
+
+       while (*sp) {
+               s = *sp++;
+               if (s->language != language)
+                       continue;
+               value = usb_gadget_get_string(s, id, buf);
+               if (value > 0)
+                       return value;
+       }
+       return -EINVAL;
+}
+
+static int composite_lookup_string(void *buf, u16 language, int id)
+{
+       struct usb_function             *f;
+       int                             len;
+
+       /* 0 == report all available language codes */
+       if (id == 0) {
+               struct usb_string_descriptor    *s = buf;
+               const struct usb_gadget_strings **sp;
+
+               memset(s, 0, 256);
+               s->bDescriptorType = USB_DT_STRING;
+
+               sp = composite->strings;
+               if (sp)
+                       composite_collect_langs(sp, s->wData);
+
+               list_for_each_entry (f, &composite->functions, function)
{
+                       sp = f->strings;
+                       if (sp)
+                               composite_collect_langs(sp, s->wData);
+               }
+
+               for (len = 0; s->wData[len] && len <= 126; len++)
+                       continue;
+               if (!len)
+                       return -EINVAL;
+
+               s->bLength = 2 * (len + 1);
+               return s->bLength;
+       }
+
+       /* otherwise, look up and return a specified string */
+       if (composite->strings) {
+               len = composite_check_string(composite->strings,
+                               buf, language, id);
+               if (len > 0)
+                       return len;
+       }
+       list_for_each_entry (f, &composite->functions, function) {
+               if (!f->strings)
+                       continue;
+               len = composite_check_string(f->strings, buf, language,
id);
+               if (len > 0)
+                       return len;
+       }
+       return -EINVAL;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void composite_setup_complete(struct usb_ep *ep, struct
usb_request *req)
+{
+       if (req->status || req->actual != req->length)
+               DBG((struct usb_composite_dev *) ep->driver_data,
+                               "setup complete --> %d, %d/%d\n",
+                               req->status, req->actual, req->length);
+}
+
+/*
+ * The setup() callback implements all the ep0 functionality that's
+ * not handled lower down, in hardware or the hardware driver(like
+ * device and endpoint feature flags, and their status).  It's all
+ * housekeeping for the gadget function we're implementing.  Most of
+ * the work is in config-specific setup.
+ */
+static int
+composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest
*ctrl)
+{
+       struct usb_composite_dev        *cdev = get_gadget_data(gadget);
+       struct usb_request              *req = cdev->req;
+       int                             value = -EOPNOTSUPP;
+       u16                             w_index =
le16_to_cpu(ctrl->wIndex);
+       u16                             w_value =
le16_to_cpu(ctrl->wValue);
+       u16                             w_length =
le16_to_cpu(ctrl->wLength);
+
+       req->zero = 0;
+       switch (ctrl->bRequest) {
+
+       case USB_REQ_GET_DESCRIPTOR:
+               if (ctrl->bRequestType != USB_DIR_IN)
+                       goto unknown;
+               switch (w_value >> 8) {
+
+               case USB_DT_DEVICE:
+                       value = min(w_length, (u16) sizeof cdev->dev);
+                       memcpy(req->buf, &cdev->dev, value);
+                       break;
+               case USB_DT_DEVICE_QUALIFIER:
+                       if (!is_dualspeed(gadget))
+                               break;
+                       value = min(w_length, (u16) sizeof cdev->qual);
+                       memcpy(req->buf, &cdev->qual, value);
+                       break;
+
+               case USB_DT_OTHER_SPEED_CONFIG:
+                       if (!is_dualspeed(gadget))
+                               break;
+                       // FALLTHROUGH
+
+               case USB_DT_CONFIG:
+                       /* one config ... so it must always be index 0
*/
+                       if (w_value & 0xff)
+                               break;
+
+                       value = config_buf(cdev, req->buf, w_value >>
8);
+                       if (value >= 0)
+                               value = min(w_length, (u16) value);
+                       break;
+               case USB_DT_STRING:
+                       value = composite_lookup_string(req->buf,
w_index,
+                                               w_value & 0xff);
+                       if (value >= 0)
+                               value = min(w_length, (u16) value);
+                       break;
+               }
+               break;
+
+       /* currently one config, two speeds */
+       case USB_REQ_SET_CONFIGURATION:
+               if (ctrl->bRequestType != 0)
+                       goto unknown;
+               if (gadget->a_hnp_support)
+                       DBG(cdev, "HNP available\n");
+               else if (gadget->a_alt_hnp_support)
+                       DBG(cdev, "HNP needs a different root port\n");
+               else
+                       VDBG(cdev, "HNP inactive\n");
+               spin_lock(&cdev->lock);
+               value = composite_set_config(cdev, w_value);
+               spin_unlock(&cdev->lock);
+               break;
+       case USB_REQ_GET_CONFIGURATION:
+               if (ctrl->bRequestType != USB_DIR_IN)
+                       goto unknown;
+               *(u8 *)req->buf = cdev->config.bConfigurationValue;
+               value = min(w_length, (u16) 1);
+               break;
+
+       /* function drivers must handle get/set altsetting */
+       case USB_REQ_SET_INTERFACE:
+               if (ctrl->bRequestType != USB_RECIP_INTERFACE)
+                       goto unknown;
+               if (!cdev->config.bConfigurationValue
+                               || w_index >= MAX_COMPOSITE_INTERFACES
+                               || !cdev->interface[w_index])
+                       break;
+               spin_lock(&cdev->lock);
+               value = cdev->interface[w_index]->setup(cdev, ctrl);
+               spin_unlock(&cdev->lock);
+               break;
+       case USB_REQ_GET_INTERFACE:
+               if (ctrl->bRequestType !=(USB_DIR_IN|
USB_RECIP_INTERFACE))
+                       goto unknown;
+               if (!cdev->config.bConfigurationValue
+                               || w_index >= MAX_COMPOSITE_INTERFACES
+                               || !cdev->interface[w_index])
+                       break;
+               spin_lock(&cdev->lock);
+               /* function must set cdev->req->buf[0] */
+               value = cdev->interface[w_index]->setup(cdev, ctrl);
+               spin_unlock(&cdev->lock);
+               value = min(w_length, (u16) 1);
+               break;
+       default:
+unknown:
+               VDBG(dev,
+                       "unknown control req%02x.%02x v%04x i%04x l%d
\n",
+                       ctrl->bRequestType, ctrl->bRequest,
+                       w_value, w_index, w_length);
+       }
+
+       /* respond with data transfer before status phase? */
+       if (value >= 0) {
+               req->length = value;
+               req->zero = value < w_length;
+               value = usb_ep_queue(gadget->ep0, req, GFP_ATOMIC);
+               if (value < 0) {
+                       DBG(cdev, "ep_queue --> %d\n", value);
+                       req->status = 0;
+                       composite_setup_complete(gadget->ep0, req);
+               }
+       }
+
+       /* device either stalls (value < 0) or reports success */
+       return value;
+}
+
+static void
+composite_disconnect(struct usb_gadget *gadget)
+{
+       struct usb_composite_dev        *cdev = get_gadget_data(gadget);
+       unsigned long                   flags;
+       struct usb_ctrlrequest  req;
+
+       DBG(cdev, "disconnect\n");
+
+       memset(&req, 0, sizeof req);
+
+       spin_lock_irqsave(&cdev->lock, flags);
+       composite_reset_config(cdev, &req);
+       spin_unlock_irqrestore(&cdev->lock, flags);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void /* __init_or_exit */
+composite_unbind(struct usb_gadget *gadget)
+{
+       struct usb_composite_dev        *cdev = get_gadget_data(gadget);
+       struct usb_function             *f;
+
+       DBG(cdev, "unbind\n");
+
+       list_for_each_entry (f, &cdev->driver->functions, function) {
+               if (f->unbind)
+                       f->unbind(cdev);
+               if (f == cdev->current_bind)
+                       break;
+       }
+       if (composite->unbind)
+               composite->unbind(cdev);
+       if (cdev->req) {
+               kfree(cdev->req->buf);
+               usb_ep_free_request(gadget->ep0, cdev->req);
+       }
+       kfree(cdev);
+       set_gadget_data(gadget, NULL);
+}
+
+static int __init
+composite_bind(struct usb_gadget *gadget)
+{
+       struct usb_composite_dev        *cdev;
+       struct usb_function             *f;
+       int                             status = -ENOMEM;
+
+       cdev = kzalloc(sizeof *cdev, SLAB_KERNEL);
+       if (!cdev)
+               return status;
+
+       spin_lock_init(&cdev->lock);
+       cdev->gadget = gadget;
+       set_gadget_data(gadget, cdev);
+
+       /* preallocate control response and buffer */
+       cdev->req = usb_ep_alloc_request(gadget->ep0, GFP_KERNEL);
+       if (!cdev->req)
+               goto fail;
+       cdev->req->buf = kmalloc(USB_BUFSIZ, GFP_KERNEL);
+       if (!cdev->req->buf)
+               goto fail;
+
+       cdev->req->complete = composite_setup_complete;
+       gadget->ep0->driver_data = cdev;
+
+       cdev->driver = composite;
+       cdev->dev = *composite->dev;
+       cdev->dev.bMaxPacketSize0 = gadget->ep0->maxpacket;
+
+       usb_gadget_set_selfpowered(gadget);
+
+       /* mostly to assign strings for whole device, like serial
number,
+        * but potentially also to update power state and consumption
etc
+        */
+       if (composite->bind) {
+               status = composite->bind(cdev);
+               if (status < 0)
+                       goto fail;
+       }
+
+       /* function binding involves updating interface, class, and
+        * endpoint descriptors:
+        *  - allocating any string IDs needed (interface, class)
+        *  - allocating interface IDs (ditto)
+        *  - allocating endpoints (endpoint, class)
+        *  - allocating non-USB resources (buffers etc)
+        *
+        * NOTE:  we assume that if there are multiple controllers, they
+        * are all the same type (e.g. net2280 in pci slots) so
functions
+        * never need different descriptors.
+        */
+       usb_ep_autoconfig_reset(gadget);
+       list_for_each_entry (f, &cdev->driver->functions, function) {
+               cdev->current_bind = f;
+               status = f->bind(cdev);
+               if (status < 0)
+                       goto fail;
+
+               if ((is_dualspeed(gadget) && !f->hs_descriptors)
+                               || !f->descriptors) {
+                       status = -ENXIO;
+                       goto fail;
+               }
+       }
+       cdev->current_bind = NULL;
+       cdev->config.bNumInterfaces = cdev->next_interface_id;
+
+       /* REVISIT eventually we want e.g. RNDIS and non-RNDIS configs,
+        * at each available device speed ...
+        */
+       cdev->dev.bNumConfigurations = 1;
+
+       if (is_dualspeed(gadget)) {
+               cdev->qual.bLength = sizeof cdev->qual;
+               cdev->qual.bDescriptorType = USB_DT_DEVICE_QUALIFIER;
+
+               cdev->qual.bcdUSB = cdev->dev.bcdUSB;
+               cdev->qual.bDeviceClass = cdev->dev.bDeviceClass;
+               cdev->qual.bDeviceProtocol = cdev->dev.bDeviceProtocol;
+
+               /* assume ep0 uses the same value for both speeds ... */
+               cdev->qual.bMaxPacketSize0 = cdev->dev.bMaxPacketSize0;
+
+               cdev->qual.bNumConfigurations =
cdev->dev.bNumConfigurations;
+       }
+
+       INFO(cdev, "%s ready\n", composite->name);
+       return 0;
+
+fail:
+       composite_unbind(gadget);
+       return status;
+}
+
+int usb_composite_string_id(struct usb_composite_dev *cdev)
+{
+       if (cdev->current_bind && cdev->next_string_id < 255)
+               return cdev->next_string_id++;
+       return -ENODEV;
+}
+
+int usb_composite_interface_id(struct usb_composite_dev *cdev)
+{
+       if (cdev->next_interface_id < MAX_COMPOSITE_INTERFACES
+                       && cdev->current_bind) {
+               cdev->interface[cdev->next_interface_id] =
cdev->current_bind;
+               return cdev->next_interface_id++;
+       }
+       return -ENODEV;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void
+composite_suspend(struct usb_gadget *gadget)
+{
+       struct usb_composite_dev        *cdev = get_gadget_data(gadget);
+       struct usb_function             *f;
+
+       DBG(cdev, "suspend\n");
+       /* revisit -- iterate cdev->interface? */
+       list_for_each_entry (f, &cdev->driver->functions, function) {
+               if (!f->suspend)
+                       continue;
+               f->suspend(cdev);
+       }
+}
+
+static void
+composite_resume(struct usb_gadget *gadget)
+{
+       struct usb_composite_dev        *cdev = get_gadget_data(gadget);
+       struct usb_function             *f;
+
+       DBG(cdev, "resume\n");
+       /* revisit -- iterate cdev->interface? */
+       list_for_each_entry (f, &cdev->driver->functions, function) {
+               if (!f->resume)
+                       continue;
+               f->resume(cdev);
+       }
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+static struct usb_gadget_driver composite_driver = {
+       .speed          = USB_SPEED_HIGH,
+
+       .bind           = composite_bind,
+       .unbind         = __exit_p(composite_unbind),
+
+       .setup          = composite_setup,
+       .disconnect     = composite_disconnect,
+
+       .suspend        = composite_suspend,
+       .resume         = composite_resume,
+
+       .driver = {
+               .owner          = THIS_MODULE,
+       },
+};
+
+int usb_composite_register(struct usb_composite_driver *d)
+{
+       struct usb_function     *f;
+
+       if (!d || !d->dev || composite)
+               return -EINVAL;
+
+       list_for_each_entry (f, &d->functions, function) {
+               if (!f->bind || !f->setup)
+                       return -EINVAL;
+
+               /* REVISIT erm, hs_descriptors may be unknown here? */
+               if (!f->hs_descriptors) {
+                       composite_driver.speed = USB_SPEED_FULL;
+                       break;
+               }
+       }
+
+       if (!d->name)
+               d->name = "composite";
+       composite_driver.function =  (char *) d->name;
+       composite_driver.driver.name = d->name;
+       composite = d;
+
+       return usb_gadget_register_driver(&composite_driver);
+}
Index: 2.6-dev/drivers/usb/gadget/usbstring.c
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/usbstring.c	2007-01-29
11:37:52.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/usbstring.c	2007-01-29 11:57:48.000000000
-0400
@@ -102,7 +102,7 @@
  * characters (which are also widely used in C strings).
  */
 int
-usb_gadget_get_string (struct usb_gadget_strings *table, int id, u8
*buf)
+usb_gadget_get_string(const struct usb_gadget_strings *table, int id,
u8 *buf)
 {
 	struct usb_string	*s;
 	int			len;
Index: 2.6-dev/include/linux/usb/composite.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6-dev/include/linux/usb/composite.h	2007-01-29 11:57:48.000000000
-0400
@@ -0,0 +1,137 @@
+/* <linux/usb/composite.h> */
+
+#ifndef        __LINUX_USB_COMPOSITE_H
+#define        __LINUX_USB_COMPOSITE_H
+
+#ifdef __KERNEL__
+
+/* Support for composite gadgets, built from distinct function drivers.
+ * Example:  one offering both network and mass storage functionality.
+ */
+
+struct usb_composite_dev;
+struct usb_composite_driver;
+
+/**
+ * struct usb_function - describes one function of a composite device
+ * @name: for diagnostics, identifies the function
+ * @strings: tables of strings, keyed by identifiers assigned during
bind()
+ *     and language IDs provided in control requests
+ * @descriptors: table of low/full speed descriptors, using interface
and
+ *     string identifiers assigned during bind()
+ * @hs_descriptors: table of high speed descriptors, using interface
and
+ *     string identifiers assigned during bind(); or null
+ * @function: each function is on the usb_composite.function list when
the
+ *     composite gadget is initialized, and then places itself in the
right
+ *     position(s) in usb_composite.functions[] during bind()
+ * @bind: before the gadget can register, all of its functions bind()
to the
+ *     available resources including identifiers for strings,
interfaces,
+ *     and endpoints
+ * @unbind: before the gadget can unregister, all of its functions
unbind()
+ *     the resources they have allocated.
+ * @setup: used for SET_INTERFACE, SET_CONFIGURATION, and
interface-specific
+ *     control requests
+ * @disconnect: used to notify functions when the host has disconnected
+ * @suspend: notifies functions when the host stops sending USB traffic
+ * @disconnect: notifies functions when the host reactivates the USB
link
+ *
+ * A single USB function uses one or more interfaces, and supports dual
speed
+ * operation on appropriate hardware.
+ */
+struct usb_function {
+       const char                              *name;
+       const struct usb_gadget_strings         **strings;
+       const struct usb_descriptor_header      **descriptors;
+       const struct usb_descriptor_header      **hs_descriptors;
+
+       struct list_head                        function;
+
+       /* REVISIT want multi-config at *same* speed too ...
+        * e.g. one has RNDIS, another has CDC-Ethernet
+        * not just high speed versions of each.
+        */
+
+       int                     (*bind)(struct usb_composite_dev *);
+       void                    (*unbind)(struct usb_composite_dev *);
+       int                     (*setup)(struct usb_composite_dev *,
+                                       const struct usb_ctrlrequest *);
+       void                    (*disconnect)(struct usb_composite_dev
*);
+       void                    (*suspend)(struct usb_composite_dev *);
+       void                    (*resume)(struct usb_composite_dev *);
+};
+
+/**
+ * struct usb_composite_driver -- groups functions into one gadget
driver
+ * @name: for diagnostics, identifies the gadget driver
+ * @dev: descriptor for the device
+ * @strings: tables of strings, keyed by identifiers assigned during
bind()
+ *     and language IDs provided in control requests
+ * @functions: each function on this list when usb_composite_init() is
called
+ *     will be bound and initialized
+ * @bind: optionally used for whole-device resources such as string
IDs,
+ *     updating the device and configuration descriptors before
functions
+ *     bind(); and updating whole-device policies.
+ * @unbind: optionally reverses bind()
+ * @setup: optionally used to delegate class and vendor control
requests
+ */
+struct usb_composite_driver {
+       const char                              *name;
+       const struct usb_device_descriptor      *dev;
+       const struct usb_gadget_strings         **strings;
+
+       /* REVISIT want a general "add more descriptors for config N"
+        * hook; OTG would fall out naturally
+        */
+
+       struct list_head        functions;
+
+       int                     (*bind)(struct usb_composite_dev *);
+       int                     (*unbind)(struct usb_composite_dev *);
+       int                     (*setup)(struct usb_composite_dev *,
+                                       const struct usb_ctrlrequest *);
+
+       /* REVISIT disconnect(), suspend(), resume() too ?? */
+};
+
+extern int usb_composite_register(struct usb_composite_driver *);
+
+
+#define        MAX_COMPOSITE_INTERFACES                8       /* max
16 */
+
+/**
+ * struct usb_composite_device - represents one composite usb gadget
+ * @gadget: read-only, abstracts the gadget's usb peripheral controller
+ * @req: used for control responses; buffer is pre-allocated
+ * @dev: device descriptor
+ * @config: configuration descriptor; if the device is not configured,
+ *     its bConfigurationValue is zero and other fields are ignored
+ */
+struct usb_composite_dev {
+       spinlock_t                      lock;
+       struct usb_gadget               *gadget;
+       struct usb_request              *req;
+       struct usb_device_descriptor    dev;
+       struct usb_config_descriptor    config;
+
+       /* REVISIT need per-function state hook ... maybe a
+        * (void*) returned from bind() and passed to callbacks?
+        * arguably, interface descriptors are part of that...
+        */
+
+       /* INTERNALS -- not for function drivers */
+       u8                      next_string_id;
+       u8                      next_interface_id;
+       struct usb_function     *current_bind;
+       struct usb_function     *interface[MAX_COMPOSITE_INTERFACES];
+
+       struct usb_composite_driver     *driver;
+       struct usb_qualifier_descriptor qual;
+};
+
+/* IDs may be assigned ONLY during function driver bind() */
+extern int usb_composite_string_id(struct usb_composite_dev *c);
+extern int usb_composite_interface_id(struct usb_composite_dev *c);
+
+#endif  /* __KERNEL__ */
+
+#endif /* __LINUX_USB_COMPOSITE_H */
Index: 2.6-dev/include/linux/usb_gadget.h
===================================================================
--- 2.6-dev.orig/include/linux/usb_gadget.h	2007-01-29
11:37:52.000000000 -0400
+++ 2.6-dev/include/linux/usb_gadget.h	2007-01-29 11:57:48.000000000
-0400
@@ -853,7 +853,7 @@
 };
 
 /* put descriptor for string with that id into buf (buflen >= 256) */
-int usb_gadget_get_string (struct usb_gadget_strings *table, int id, u8
*buf);
+int usb_gadget_get_string(const struct usb_gadget_strings *table, int
id, u8 *buf);
 
 /*-------------------------------------------------------------------------*/
 

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
