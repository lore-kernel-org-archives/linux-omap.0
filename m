From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 2/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:49:13 -0400
Message-ID: <1170431353.23028.61.camel@balbi>
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

[PATCH] Base work for composite gadget support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---

Index: 2.6-dev/drivers/usb/gadget/Kconfig
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/Kconfig	2007-01-29
11:40:21.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/Kconfig	2007-01-29 11:42:00.000000000
-0400
@@ -282,6 +282,15 @@
 
 # this first set of drivers all depend on bulk-capable hardware.
 
+config USB_COMPOSITE
+	tristate "Composite Gadget Support"
+	depends on USB_GADGET
+	help
+	   A composite gadget is a device with more than one
+	   interface.
+
+	   This module adds support for this kind of device.
+
 config USB_ZERO
 	tristate "Gadget Zero (DEVELOPMENT)"
 	depends on EXPERIMENTAL
Index: 2.6-dev/drivers/usb/gadget/Makefile
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/Makefile	2007-01-29
11:40:21.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/Makefile	2007-01-29 11:42:18.000000000
-0400
@@ -19,6 +19,8 @@
 gadgetfs-objs			:= inode.o
 g_file_storage-objs		:= file_storage.o usbstring.o config.o \
 					epautoconf.o
+g_composite-objs		:= composite_functions.o composite.o \
+					usbstring.o config.o epautoconf.o
 
 ifeq ($(CONFIG_USB_ETH_RNDIS),y)
 	g_ether-objs		+= rndis.o
@@ -30,4 +32,4 @@
 obj-$(CONFIG_USB_FILE_STORAGE)	+= g_file_storage.o
 obj-$(CONFIG_USB_G_SERIAL)	+= g_serial.o
 obj-$(CONFIG_USB_MIDI_GADGET)	+= g_midi.o
-
+obj-$(CONFIG_USB_COMPOSITE)	+= g_composite.o
Index: 2.6-dev/drivers/usb/gadget/composite.c
===================================================================
--- 2.6-dev.orig/drivers/usb/gadget/composite.c	2007-01-29
11:39:35.000000000 -0400
+++ 2.6-dev/drivers/usb/gadget/composite.c	2007-01-29 11:42:29.000000000
-0400
@@ -1,6 +1,3 @@
-#define DEBUG 1
-// #define VERBOSE
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -22,9 +19,12 @@
 #include <asm/unaligned.h>
 
 #include <linux/usb_ch9.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb_gadget.h>
 #include <linux/usb/composite.h>
 
+#define DEBUG 1
+#define VERBOSE 1
 
 #define xprintk(d,level,fmt,args...) \
        dev_printk(level , &(d)->gadget->dev , fmt , ## args)
@@ -51,10 +51,22 @@
 #define INFO(dev,fmt,args...) \
        xprintk(dev , KERN_INFO , fmt , ## args)
 
+/* Defines */
+#define DRIVER_DESC 		"Composite Device"
+#define DRIVER_VERSION 		"v1.0-alfa"
+#define DRIVER_NAME 		"composite"
+
+static const char driver_desc [] = DRIVER_DESC;
+static const char shortname [] = DRIVER_NAME;
+
 /*-------------------------------------------------------------------------*/
 
+#define NUM_CONFIGS		1
+#define COMPOSITE_CONFIG_VALUE  3	/* composite config */
+
 /* big enough to hold our biggest descriptor */
-#define USB_BUFSIZ     512
+#define USB_BUFSIZ 	256
+
 

 static struct usb_composite_driver     *composite;
@@ -78,6 +90,7 @@
 }
 
 /*-------------------------------------------------------------------------*/
+/*-------------------------------------------------------------------------*/
 
 /* To simplify, we expect to have only ONE real configuration, working
the
  * same no matter what speed it connects with.  A given function may
expose
@@ -85,7 +98,7 @@
  * class and endpoint descriptors (as usual).
  */
 
-#define        CONFIG_NUMBER   1
+#define COMPOSITE_CONFIG_NUMBER 	1
 
 static int
 config_buf(struct usb_composite_dev *cdev, void *buf, u8 type)
@@ -103,11 +116,12 @@
        } else
                hs = 0;
 
+
        /* write a config descriptor */
        *c = cdev->config;
        c->bLength = USB_DT_CONFIG_SIZE;
        c->bDescriptorType = type;
-       c->bConfigurationValue = CONFIG_NUMBER;
+       c->bConfigurationValue = COMPOSITE_CONFIG_NUMBER;
 
        /* REVISIT some configurations might need other descriptors,
         * independent of the interfaces they implement ... notably
@@ -139,13 +153,14 @@
 ) {
        struct usb_function             *f;
        int                             result;
-
        DBG(cdev, "reset config\n");
 
        req->bRequestType = USB_DIR_OUT | USB_TYPE_STANDARD |
USB_RECIP_DEVICE;
        req->bRequest = USB_REQ_SET_CONFIGURATION;
+	req->wValue = COMPOSITE_CONFIG_VALUE;
 
        list_for_each_entry (f, &composite->functions, function) {
+	       cdev->current_func = f;
                result = f->setup(cdev, req);
                if (result < 0)
                        DBG(cdev, "reset function %s --> %d\n",
@@ -157,7 +172,7 @@
 static int
 composite_set_config(struct usb_composite_dev *cdev, unsigned number)
 {
-       int                     result = 0, tmp;
+       int                     result = 0;
        struct usb_gadget       *gadget = cdev->gadget;
        struct usb_ctrlrequest  req;
 
@@ -176,18 +191,19 @@
        case 0:
                usb_gadget_vbus_draw(gadget, is_otg(gadget) ? 8 : 100);
                break;
-       case CONFIG_NUMBER:
+       case COMPOSITE_CONFIG_NUMBER:
                req.bRequestType = USB_DIR_OUT
                                | USB_TYPE_STANDARD
                                | USB_RECIP_INTERFACE;
                req.bRequest = USB_REQ_SET_INTERFACE;
-
+/* ragner comments
                for (tmp = 0; tmp < MAX_COMPOSITE_INTERFACES; tmp++) {
                        struct usb_function     *f =
cdev->interface[tmp];
 
                        if (!f)
                                continue;
                        req.wIndex = cpu_to_le16(tmp);
+		       cdev->current_func = f;
                        result = f->setup(cdev, &req);
                        if (result < 0) {
                                DBG(cdev, "interface %d/%s alt 0--> %d
\n",
@@ -196,12 +212,13 @@
                                return result;
                        }
                }
-
+*/
                cdev->config.bConfigurationValue = number;
                usb_gadget_vbus_draw(gadget, 2 *
cdev->config.bMaxPower);
                break;
        }
 
+
        INFO(cdev, "%s speed config #%d\n",
                ({ char *speed;
                switch (gadget->speed) {
@@ -217,39 +234,37 @@
 /*-------------------------------------------------------------------------*/
 
 static void
-composite_collect_langs(const struct usb_gadget_strings **sp, __le16
*buf)
+composite_collect_langs(struct usb_gadget_strings *sp, __le16 *buf)
 {
        const struct usb_gadget_strings *s;
        u16                             language;
        __le16                          *tmp;
 
-       while (*sp) {
-               s = *sp;
+       if(sp) {
+               s = sp;
                language = cpu_to_le16(s->language);
                for (tmp = buf; *tmp && tmp < &buf[126]; tmp++) {
                        if (*tmp == language)
-                               goto repeat;
+			       return;
                }
                *tmp++ = language;
-repeat:
-               sp++;
        }
 }
 
 static int composite_check_string(
-       const struct usb_gadget_strings **sp,
+       struct usb_gadget_strings *sp,
        void                            *buf,
        u16                             language,
        int                             id
 )
 {
-       const struct usb_gadget_strings *s;
+       struct usb_gadget_strings *s;
        int                             value;
 
-       while (*sp) {
-               s = *sp++;
+       if(sp) {
+               s = sp;
                if (s->language != language)
-                       continue;
+		       return -EINVAL;
                value = usb_gadget_get_string(s, id, buf);
                if (value > 0)
                        return value;
@@ -265,9 +280,9 @@
        /* 0 == report all available language codes */
        if (id == 0) {
                struct usb_string_descriptor    *s = buf;
-               const struct usb_gadget_strings **sp;
+               struct usb_gadget_strings *sp;
 
-               memset(s, 0, 256);
+               memset(s, 0, USB_BUFSIZ);
                s->bDescriptorType = USB_DT_STRING;
 
                sp = composite->strings;
@@ -332,20 +347,26 @@
        u16                             w_index =
le16_to_cpu(ctrl->wIndex);
        u16                             w_value =
le16_to_cpu(ctrl->wValue);
        u16                             w_length =
le16_to_cpu(ctrl->wLength);
+       struct usb_function             *f;
+       int result;
 
        req->zero = 0;
        switch (ctrl->bRequest) {
 
        case USB_REQ_GET_DESCRIPTOR:
+	       VDBG(cdev, "Get descriptor control req=%d \n", w_value >> 8);
                if (ctrl->bRequestType != USB_DIR_IN)
                        goto unknown;
                switch (w_value >> 8) {
 
                case USB_DT_DEVICE:
+	       VDBG(cdev, "Get descriptor device\n");
                        value = min(w_length, (u16) sizeof cdev->dev);
                        memcpy(req->buf, &cdev->dev, value);
                        break;
+#ifdef CONFIG_USB_GADGET_DUALSPEED
                case USB_DT_DEVICE_QUALIFIER:
+	       VDBG(cdev, "Get descriptor qualifier\n");
                        if (!is_dualspeed(gadget))
                                break;
                        value = min(w_length, (u16) sizeof cdev->qual);
@@ -353,11 +374,13 @@
                        break;
 
                case USB_DT_OTHER_SPEED_CONFIG:
+	       VDBG(cdev, "Get descriptor speed config\n");
                        if (!is_dualspeed(gadget))
                                break;
                        // FALLTHROUGH
-
+#endif
                case USB_DT_CONFIG:
+	       VDBG(cdev, "Get descriptor config\n");
                        /* one config ... so it must always be index 0
*/
                        if (w_value & 0xff)
                                break;
@@ -367,6 +390,7 @@
                                value = min(w_length, (u16) value);
                        break;
                case USB_DT_STRING:
+	       VDBG(cdev, "Get descriptor string lang=%x id=%d\n", w_index,
w_value & 0xff);
                        value = composite_lookup_string(req->buf,
w_index,
                                                w_value & 0xff);
                        if (value >= 0)
@@ -377,6 +401,7 @@
 
        /* currently one config, two speeds */
        case USB_REQ_SET_CONFIGURATION:
+	       VDBG(cdev, "Set configuration control req=%d\n", w_value);
                if (ctrl->bRequestType != 0)
                        goto unknown;
                if (gadget->a_hnp_support)
@@ -390,6 +415,7 @@
                spin_unlock(&cdev->lock);
                break;
        case USB_REQ_GET_CONFIGURATION:
+	       VDBG(cdev, "Get configuration control req\n");
                if (ctrl->bRequestType != USB_DIR_IN)
                        goto unknown;
                *(u8 *)req->buf = cdev->config.bConfigurationValue;
@@ -398,6 +424,7 @@
 
        /* function drivers must handle get/set altsetting */
        case USB_REQ_SET_INTERFACE:
+	       VDBG(cdev, "Set interface control req=%d\n", w_index);
                if (ctrl->bRequestType != USB_RECIP_INTERFACE)
                        goto unknown;
                if (!cdev->config.bConfigurationValue
@@ -405,10 +432,13 @@
                                || !cdev->interface[w_index])
                        break;
                spin_lock(&cdev->lock);
-               value = cdev->interface[w_index]->setup(cdev, ctrl);
+	       cdev->current_func =  cdev->interface[w_index];
+               value = cdev->current_func->setup(cdev, ctrl);
                spin_unlock(&cdev->lock);
+	       goto done;
                break;
        case USB_REQ_GET_INTERFACE:
+	       VDBG(cdev, "Get interface control req=%d\n", w_index);
                if (ctrl->bRequestType !=(USB_DIR_IN|
USB_RECIP_INTERFACE))
                        goto unknown;
                if (!cdev->config.bConfigurationValue
@@ -417,13 +447,28 @@
                        break;
                spin_lock(&cdev->lock);
                /* function must set cdev->req->buf[0] */
-               value = cdev->interface[w_index]->setup(cdev, ctrl);
+	       cdev->current_func =  cdev->interface[w_index];
+               value = cdev->current_func->setup(cdev, ctrl);
                spin_unlock(&cdev->lock);
                value = min(w_length, (u16) 1);
+	       goto done;
                break;
        default:
+	       VDBG(cdev, "Default control req=%d\n", ctrl->bRequest);
+       		/* FIXME - POG/GAMBI: For unknown CLASS_TYPE */
+		list_for_each_entry (f, &cdev->driver->functions, function) {
+			cdev->current_func = f;
+                       result = f->setup(cdev, ctrl);
+                       if (result >= 0) {
+			       DBG(cdev, "Default control req ok\n");
+		       		value = result;
+		       }else {
+			       DBG(cdev, "Default control req not\n");
+		       }
+		}
+	       goto done;
 unknown:
-               VDBG(dev,
+               VDBG(cdev,
                        "unknown control req%02x.%02x v%04x i%04x l%d
\n",
                        ctrl->bRequestType, ctrl->bRequest,
                        w_value, w_index, w_length);
@@ -440,6 +485,7 @@
                        composite_setup_complete(gadget->ep0, req);
                }
        }
+ done:
 
        /* device either stalls (value < 0) or reports success */
        return value;
@@ -451,7 +497,6 @@
        struct usb_composite_dev        *cdev = get_gadget_data(gadget);
        unsigned long                   flags;
        struct usb_ctrlrequest  req;
-
        DBG(cdev, "disconnect\n");
 
        memset(&req, 0, sizeof req);
@@ -472,9 +517,10 @@
        DBG(cdev, "unbind\n");
 
        list_for_each_entry (f, &cdev->driver->functions, function) {
+	       cdev->current_func = f;
                if (f->unbind)
                        f->unbind(cdev);
-               if (f == cdev->current_bind)
+               if (f == cdev->current_func)
                        break;
        }
        if (composite->unbind)
@@ -487,14 +533,14 @@
        set_gadget_data(gadget, NULL);
 }
 
-static int __init
+static int//__init
 composite_bind(struct usb_gadget *gadget)
 {
        struct usb_composite_dev        *cdev;
        struct usb_function             *f;
        int                             status = -ENOMEM;
 
-       cdev = kzalloc(sizeof *cdev, SLAB_KERNEL);
+       cdev = kzalloc(sizeof *cdev, GFP_KERNEL);
        if (!cdev)
                return status;
 
@@ -519,6 +565,10 @@
 
        usb_gadget_set_selfpowered(gadget);
 
+	/* before composite->bind() */
+       cdev->next_string_id = 0;
+       cdev->next_interface_id = 0;
+
        /* mostly to assign strings for whole device, like serial
number,
         * but potentially also to update power state and consumption
etc
         */
@@ -541,7 +591,7 @@
         */
        usb_ep_autoconfig_reset(gadget);
        list_for_each_entry (f, &cdev->driver->functions, function) {
-               cdev->current_bind = f;
+               cdev->current_func = f;
                status = f->bind(cdev);
                if (status < 0)
                        goto fail;
@@ -552,7 +602,7 @@
                        goto fail;
                }
        }
-       cdev->current_bind = NULL;
+       cdev->current_func = NULL;
        cdev->config.bNumInterfaces = cdev->next_interface_id;
 
        /* REVISIT eventually we want e.g. RNDIS and non-RNDIS configs,
@@ -582,22 +632,120 @@
        return status;
 }
 
+/* FIXME
+ * Set the string id for each string in the current
+ * func referenced by current_func
+ */
 int usb_composite_string_id(struct usb_composite_dev *cdev)
 {
-       if (cdev->current_bind && cdev->next_string_id < 255)
-               return cdev->next_string_id++;
-       return -ENODEV;
+	struct usb_function             *f = cdev->current_func;
+	struct usb_string *src = f->strings->strings;
+
+	if (!cdev->current_func && cdev->next_string_id >= 255) {
+		return -ENODEV;
+	}
+
+	for (; src && src->s ; src++) {
+		(src)->id = cdev->next_string_id;
+		cdev->next_string_id ++;
+	}
+
+	return 0;
 }
 
+/* Set the interface id for each interface in the current
+ * func referenced by current_func
+ */
 int usb_composite_interface_id(struct usb_composite_dev *cdev)
 {
-       if (cdev->next_interface_id < MAX_COMPOSITE_INTERFACES
-                       && cdev->current_bind) {
-               cdev->interface[cdev->next_interface_id] =
cdev->current_bind;
-               return cdev->next_interface_id++;
-       }
-       return -ENODEV;
+	struct usb_function             *f = cdev->current_func;
+	struct usb_descriptor_header **src;
+	struct usb_interface_descriptor *interf_desc;
+	struct usb_cdc_header_desc *cdc_desc;
+	struct usb_cdc_union_desc *union_desc;
+
+	int                             hs;
+
+	if (!cdev->current_func && cdev->next_interface_id >=
MAX_COMPOSITE_INTERFACES ) {
+		printk(KERN_INFO "Max composite interfaces ...\n" );
+		return -ENODEV;
+	}
+
+	if (is_dualspeed(cdev->gadget)) {
+		hs = (cdev->gadget->speed == USB_SPEED_HIGH);
+		//if (type == USB_DT_OTHER_SPEED_CONFIG)
+		//	hs = !hs;
+	} else
+		hs = 0;
+
+	f->interface_shift = cdev->next_interface_id;
+
+	src = hs ? f->hs_descriptors : f->descriptors;
+	for (; 0 != *src; src++) {
+		if( (*src)->bDescriptorType == USB_DT_INTERFACE ) {
+			/* FIXME */
+			interf_desc = (struct usb_interface_descriptor *) (*src);
+			interf_desc->bInterfaceNumber += f->interface_shift;
+			if( (cdev->next_interface_id - interf_desc->bInterfaceNumber) < 0 )
{
+				printk(KERN_INFO "Invalid interface number ...!\n" );
+				return -EINVAL;
+			}
+			if( cdev->next_interface_id >= MAX_COMPOSITE_INTERFACES ) {
+				printk(KERN_INFO "Max composite interfaces ...\n" );
+				return -EINVAL;
+			}
+			cdev->interface[cdev->next_interface_id] = f;
+			cdev->next_interface_id = interf_desc->bInterfaceNumber + 1;
+		} else if( (*src)->bDescriptorType == USB_DT_CS_INTERFACE ) {
+			/* FIXME */
+			cdc_desc = (struct usb_cdc_header_desc *) (*src);
+			if( cdc_desc->bDescriptorSubType == USB_CDC_UNION_TYPE ) {
+				union_desc = (struct usb_cdc_union_desc *) (*src);
+				union_desc->bMasterInterface0 += f->interface_shift;
+				union_desc->bSlaveInterface0 += f->interface_shift;
+			}
+		}
+	}
+
+	return 0;
+}
+/* FIXME
+int composite_reset_interface_id(struct usb_composite_dev *cdev)
+{
+	struct usb_function             *f = cdev->current_func;
+	struct usb_descriptor_header **src;
+	struct usb_interface_descriptor *interf_desc;
+	struct usb_cdc_header_desc *cdc_desc;
+	struct usb_cdc_union_desc *union_desc;
+
+	int                             hs;
+
+	if (is_dualspeed(cdev->gadget)) {
+		hs = (cdev->gadget->speed == USB_SPEED_HIGH);
+		//if (type == USB_DT_OTHER_SPEED_CONFIG)
+		//	hs = !hs;
+	} else
+		hs = 0;
+
+	src = hs ? f->hs_descriptors : f->descriptors;
+
+	for (; 0 != *src; src++) {
+		if( (*src)->bDescriptorType == USB_DT_INTERFACE ) {
+			interf_desc = (struct usb_interface_descriptor *) (*src);
+			interf_desc->bInterfaceNumber -= f->interface_shift;
+		} else if( (*src)->bDescriptorType == USB_DT_CS_INTERFACE ) {
+			cdc_desc = (struct usb_cdc_header_desc *) (*src);
+			if( cdc_desc->bDescriptorSubType == USB_CDC_UNION_TYPE ) {
+				union_desc = (struct usb_cdc_union_desc *) (*src);
+				union_desc->bMasterInterface0 -= f->interface_shift;
+				union_desc->bSlaveInterface0 -= f->interface_shift;
+			}
+		}
+	}
+
+	return 0;
 }
+*/
 
 /*-------------------------------------------------------------------------*/
 
@@ -610,7 +758,8 @@
        DBG(cdev, "suspend\n");
        /* revisit -- iterate cdev->interface? */
        list_for_each_entry (f, &cdev->driver->functions, function) {
-               if (!f->suspend)
+               cdev->current_func = f;
+	       if (!f->suspend)
                        continue;
                f->suspend(cdev);
        }
@@ -625,6 +774,7 @@
        DBG(cdev, "resume\n");
        /* revisit -- iterate cdev->interface? */
        list_for_each_entry (f, &cdev->driver->functions, function) {
+       		cdev->current_func = f;
                if (!f->resume)
                        continue;
                f->resume(cdev);
@@ -648,10 +798,11 @@
 
        .driver = {
                .owner          = THIS_MODULE,
+	       .name 		= (char *) shortname,
        },
 };
 
-int usb_composite_register(struct usb_composite_driver *d)
+int /*__init*/ usb_composite_register(struct usb_composite_driver *d)
 {
        struct usb_function     *f;
 
@@ -677,3 +828,7 @@
 
        return usb_gadget_register_driver(&composite_driver);
 }
+void __exit usb_composite_unregister(struct usb_composite_driver *d)
+{
+	usb_gadget_unregister_driver(&composite_driver);
+}
Index: 2.6-dev/drivers/usb/gadget/composite_functions.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6-dev/drivers/usb/gadget/composite_functions.c	2007-01-29
11:42:50.000000000 -0400
@@ -0,0 +1,265 @@
+/*
+ * g_omap_composite.c -- USB OMAP Layer for Composite Device Support
+ *
+ * Copyright 2006 (C) Instituto Nokia de Tecnologia - INdT
+ *
+ * This software is distributed under the terms of the GNU General
+ * Public License ("GPL") as published by the Free Software Foundation,
+ * either version 2 of the License of (at you option) any later
version.
+ *
+ */
+
+/* MODULE INCLUDES */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/timer.h>
+#include <linux/utsname.h>
+#include <linux/usb_ch9.h>
+#include <linux/usb_gadget.h>
+#include <linux/usb/composite.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/semaphore.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+#include "gadget_chips.h"
+
+/* Defines */
+#define DRIVER_DESC 		"Composite Driver"
+#define DRIVER_VERSION 		"v1.0-alfa"
+#define DRIVER_NAME 		"composite"
+
+static const char driver_desc [] = DRIVER_DESC;
+static const char shortname [] = DRIVER_NAME;
+
+/* descriptors that are built on-demand */
+static char manufacturer [50];
+static char product_desc [40] = DRIVER_DESC;
+static char serial_number [20] = {"INdT0"};
+
+/*-------------------------------------------------------------------------*/
+
+#define NUM_CONFIGS		1
+
+#define VENDOR_ID		0x0525 /* NetChip */
+#define PRODUCT_ID		0Xa4a6 /* Linux-USB Serial */
+//#define VENDOR_ID 	0x1a0a 	/* OTG test device IDs */
+//#define PRODUCT_ID 	0xbadd
+#define COMPOSITE_CONFIG_NUMBER 		1 // ether ok
+
+/* USB String IDs */
+#define COMPOSITE_MANUFACTURER_ID 	1
+#define COMPOSITE_PRODUCT_ID 		2
+#define COMPOSITE_SERIALNUMBER_ID 	3
+#define COMPOSITE_CONFIG_SRT_ID 	4
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Felipe Balbi, Ragner Magalhaes");
+MODULE_LICENSE("GPL");
+
+/* USB Strings, UTF8 */
+
+
+static struct usb_string composite_strings[] = {
+	{ COMPOSITE_MANUFACTURER_ID, manufacturer },
+	{ COMPOSITE_PRODUCT_ID, product_desc},
+	{ COMPOSITE_SERIALNUMBER_ID, serial_number },
+	{ COMPOSITE_CONFIG_SRT_ID, "Composite Alfa" },
+	{  } /* end */
+};
+static struct usb_gadget_strings composite_stringtable = {
+	.language		= 0x0409, /* en-US */
+	.strings		= composite_strings,
+};
+static struct usb_device_descriptor composite_device_desc = {
+	.bLength		= USB_DT_DEVICE_SIZE,
+	.bDescriptorType	= USB_DT_DEVICE,
+	.bcdUSB			= __constant_cpu_to_le16(0x0200),
+	.bDeviceClass		= USB_CLASS_PER_INTERFACE,
+	.bDeviceSubClass	= USB_CLASS_PER_INTERFACE,
+	.bDeviceProtocol	= 0,
+	.idVendor		= __constant_cpu_to_le16(VENDOR_ID),
+	.idProduct		= __constant_cpu_to_le16(PRODUCT_ID),
+	.iManufacturer		= COMPOSITE_MANUFACTURER_ID,
+	.iProduct		= COMPOSITE_PRODUCT_ID,
+	.iSerialNumber		= COMPOSITE_SERIALNUMBER_ID,
+	.bNumConfigurations	= NUM_CONFIGS,
+};
+static struct usb_config_descriptor composite_config_desc = {
+	.bLength		= USB_DT_CONFIG_SIZE,
+	.bDescriptorType	= USB_DT_CONFIG,
+	/* wTotalLenght computed dynamically */
+	.bNumInterfaces		= MAX_COMPOSITE_INTERFACES,
+	.bConfigurationValue	= COMPOSITE_CONFIG_NUMBER,
+	.iConfiguration		= COMPOSITE_CONFIG_SRT_ID,
+	.bmAttributes 		= USB_CONFIG_ATT_ONE | USB_CONFIG_ATT_SELFPOWER,
+	.bMaxPower		= 1,
+};
+static struct usb_qualifier_descriptor composite_qualifier_desc = {
+	.bLength =		sizeof composite_qualifier_desc,
+	.bDescriptorType	= USB_DT_DEVICE_QUALIFIER,
+	.bcdUSB			= __constant_cpu_to_le16(0x0200),
+	.bDeviceClass		= USB_CLASS_PER_INTERFACE,
+	.bNumConfigurations	= NUM_CONFIGS,
+};
+
+struct usb_composite_dev        *cdev;
+
+/* Functions */
+
+/* module */
+static int __init composite_init(void);
+static void __exit composite_exit(void);
+
+/* usb_function register function */
+int usb_function_register(struct usb_function *);
+
+static int composite_func_bind(struct usb_composite_dev *composite_dev)
+{
+	cdev = composite_dev;
+	// Last id + 1
+       cdev->next_string_id = COMPOSITE_CONFIG_SRT_ID + 1;
+
+       cdev->config = composite_config_desc;
+       cdev->qual = composite_qualifier_desc;
+
+	snprintf(manufacturer, sizeof(manufacturer), "%s %s with %s",
+		init_utsname()->sysname, init_utsname()->release,
+		driver_desc);
+
+	return 0;
+}
+
+
+/* Composite Driver Struct */
+
+static struct usb_composite_driver composite_drv = {
+	.dev			= &composite_device_desc,
+	.strings		= &composite_stringtable,
+	.bind			= composite_func_bind,
+//	.unbind			= composite_unbind,
+//	.setup			= composite_setup,
+	.functions		= LIST_HEAD_INIT(composite_drv.functions),
+};
+/* FIXME
+static int reset_functions() {
+	int status = 0;
+	struct usb_function             *f;
+	cdev->next_interface_id = 0;
+       list_for_each_entry (f, &cdev->driver->functions, function) {
+       		cdev->current_func = f;
+		composite_reset_interface_id(cdev);
+		status = usb_composite_interface_id(cdev);
+		if( status < 0 )
+			goto fail;
+	}
+        cdev->config.bNumInterfaces = cdev->next_interface_id;
+	return 0;
+	fail:
+	return status;
+}
+*/
+
+/* usb_function_register
+ *
+ * Get from usb function drivers their struct usb_function
+ * and assembles all of them into one struct usb_composite_driver
+ */
+
+
+/* FIXME: Code this function properly */
+int  usb_function_register(struct usb_function *g_func)
+{
+	struct usb_composite_driver *d = &composite_drv;
+	int status = 0;
+
+	if (!g_func->name)
+		g_func->name = "Composite Gadget";
+
+	cdev->current_func = g_func;
+	printk(KERN_INFO "Set interface.\n");
+
+	// Set interface id
+	status = usb_composite_interface_id(cdev);
+	if(status)
+		goto fail;
+	/* FIXME
+	printk(KERN_INFO "Set string.\n");
+	status = usb_composite_string_id(cdev);
+	if(status)
+		goto fail;
+	*/
+	status = g_func->bind(cdev);
+        cdev->config.bNumInterfaces = cdev->next_interface_id;
+	if( status < 0 )
+		goto fail;
+
+	list_add_tail(&g_func->function, &d->functions);
+	printk(KERN_INFO "USB Function registered.\n");
+	return 0;
+fail:
+	return status;
+}
+EXPORT_SYMBOL(usb_function_register);
+
+void usb_function_unregister(struct usb_function *g_func)
+{
+	//struct usb_composite_driver *d = &composite_drv;
+
+/* FIXME */
+	cdev->current_func = g_func;
+	g_func->unbind(cdev);
+	list_del(&g_func->function);//, &d->functions);
+/* FIXME
+ * How to do this???
+	if( reset_functions() < 0 )
+		printk(KERN_INFO "Reset functions error!!!.\n");
+*/
+}
+EXPORT_SYMBOL(usb_function_unregister);
+
+
+/*
+ * composite_init
+ *
+ * Register as a USB Composite driver
+ *
+ * This function calls composite_function_register() to assemble
+ * composite_drv properly. After that it calls usb_composite_register()
+ * to register this device as a composite device.
+ */
+
+/* This function will register de composite driver */
+static int __init composite_init(void)
+{
+	int retval = 0;
+
+	retval = usb_composite_register(&composite_drv);
+
+	if (retval)
+		return -EINVAL;
+	else {
+		return 0;
+	}
+}
+
+static void __exit composite_exit(void)
+{
+	usb_composite_unregister(&composite_drv);
+	printk(KERN_INFO "composite_exit: %s %s unloaded\n", DRIVER_DESC,
DRIVER_VERSION);
+}
+module_init(composite_init);
+module_exit(composite_exit);
Index: 2.6-dev/include/linux/usb/composite.h
===================================================================
--- 2.6-dev.orig/include/linux/usb/composite.h	2007-01-29
11:39:35.000000000 -0400
+++ 2.6-dev/include/linux/usb/composite.h	2007-01-29 11:43:16.000000000
-0400
@@ -40,9 +40,11 @@
  */
 struct usb_function {
        const char                              *name;
-       const struct usb_gadget_strings         **strings;
-       const struct usb_descriptor_header      **descriptors;
-       const struct usb_descriptor_header      **hs_descriptors;
+       struct usb_gadget_strings         *strings;
+       struct usb_descriptor_header      **descriptors;
+       struct usb_descriptor_header      **hs_descriptors;
+       void                                    *driver_data;	/* data
private to the driver */
+       u8                                      interface_shift;
 
        struct list_head                        function;
 
@@ -77,7 +79,7 @@
 struct usb_composite_driver {
        const char                              *name;
        const struct usb_device_descriptor      *dev;
-       const struct usb_gadget_strings         **strings;
+       struct usb_gadget_strings         *strings;
 
        /* REVISIT want a general "add more descriptors for config N"
         * hook; OTG would fall out naturally
@@ -95,6 +97,9 @@
 
 extern int usb_composite_register(struct usb_composite_driver *);
 
+extern void usb_composite_unregister(struct usb_composite_driver *);
+extern int usb_function_register(struct usb_function *);
+extern void usb_function_unregister(struct usb_function *);
 
 #define        MAX_COMPOSITE_INTERFACES                8       /* max
16 */
 
@@ -121,7 +126,7 @@
        /* INTERNALS -- not for function drivers */
        u8                      next_string_id;
        u8                      next_interface_id;
-       struct usb_function     *current_bind;
+       struct usb_function     *current_func;
        struct usb_function     *interface[MAX_COMPOSITE_INTERFACES];
 
        struct usb_composite_driver     *driver;
@@ -131,7 +136,12 @@
 /* IDs may be assigned ONLY during function driver bind() */
 extern int usb_composite_string_id(struct usb_composite_dev *c);
 extern int usb_composite_interface_id(struct usb_composite_dev *c);
+/* FIXME
+extern int composite_reset_interface_id(struct usb_composite_dev *c);
+*/
 
+
+extern int is_composite(void);
 #endif  /* __KERNEL__ */
 
 #endif /* __LINUX_USB_COMPOSITE_H */

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
