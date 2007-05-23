From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] MUSB HSET driver
Date: Wed, 23 May 2007 14:39:09 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC0800305CC48@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony=20
As per Greg's suggestion of introducing HSET driver in open source, can =
we push the HSET driver into MUSB for now till a complete implementation =
is made available in open source?=20

>-----Original Message-----[START]
>From: Greg KH [mailto:greg@kroah.com]
>Sent: Wednesday, May 23, 2007 10:18 AM
>To: Pandita, Vikram
>Cc: Felipe Balbi; Linux-USB
>
><snip>
>
>Very nice.  Is there any reason why you can't submit this to the main
>kernel tree so that others can use this?  I get people asking all the
>time about this kind of functionality, especially as Linux is being =
used
>more and more in embedded systems with USB.
>
>thanks,
>
>greg k-h
>-----Original Message-----[END]



Patch is to get HSET driver in MUSB:

For HSET testing of OMAP as a host, the implementation provides two =
interfaces:
1) USB function driver interface for OPT card=20
Based on VID/PID sent by OPT, will different test modes be exercised

2) sysfs interface for HSET tool=20
The options provided are:
                                "J: Test_J"
                                "K: Test_K"
                                "S: Test_SE0_NAK"
                                "P: Test_PACKET"
                                "H: Test_FORCE_ENABLE"
                                "U: Test_SUSPEND_RESUME"
                                "G: Test_SINGLE_STEP_GET_DESC"
                                "F: Test_SINGLE_STEP_SET_FEATURE"
                                "E: Enumerate bus"
                                "D: Suspend bus"
                                "R: Resume bus"
                                "?: help menu");
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Nishant Kamat <nskamat@ti.com>

---
 Makefile    |    2
 musb_hset.c |  597 +++++++++++++++++
 musbdefs.h  |   19 +
 plat_uds.c  |   29 --
 4 files changed, 623 insertions(+), 24 deletions(-)
---
diff -purN -X ./dontdiff a/drivers/usb/musb/Makefile =
c/drivers/usb/musb/Makefile
--- a/drivers/usb/musb/Makefile	2007-05-03 17:39:20.000000000 +0530
+++ c/drivers/usb/musb/Makefile	2007-05-22 11:49:16.000000000 +0530
@@ -23,7 +23,7 @@ ifeq ($(CONFIG_USB_GADGET_MUSB_HDRC),y)
 endif
=20
 ifeq ($(CONFIG_USB_MUSB_HDRC_HCD),y)
-	musb_hdrc-objs		+=3D virthub.o musb_host.o
+	musb_hdrc-objs		+=3D virthub.o musb_host.o musb_hset.o
 endif
=20
 # the kconfig must guarantee that only one of the
diff -purN -X ./dontdiff a/drivers/usb/musb/musbdefs.h =
c/drivers/usb/musb/musbdefs.h
--- a/drivers/usb/musb/musbdefs.h	2007-05-21 12:45:49.000000000 +0530
+++ c/drivers/usb/musb/musbdefs.h	2007-05-22 11:58:24.000000000 +0530
@@ -485,6 +485,16 @@ static inline struct musb *gadget_to_mus
 }
 #endif
=20
+/* for high speed test mode; see USB 2.0 spec */
+static const u8 musb_test_packet[53] =3D {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
+	0xaa, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
+	0xee, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0x7f, 0xbf, 0xdf,
+	0xef, 0xf7, 0xfb, 0xfd, 0xfc, 0x7e, 0xbf, 0xdf,
+	0xef, 0xf7, 0xfb, 0xfd, 0x7e
+};
=20
 /***************************** Glue it together =
*****************************/
=20
@@ -526,7 +536,8 @@ struct proc_dir_entry;
 extern struct proc_dir_entry *musb_debug_create(char *name,
 						    struct musb *data);
 extern void musb_debug_delete(char *name, struct musb *data);
-
+extern void musb_init_hset(char *name, struct musb *musb);
+extern void musb_exit_hset(char *name, struct musb *musb);
 #else
 static inline struct proc_dir_entry *musb_debug_create(char *name,
 							   struct musb *data)
@@ -536,6 +547,12 @@ static inline struct proc_dir_entry *mus
 static inline void musb_debug_delete(char *name, struct musb *data)
 {
 }
+static inline void musb_init_hset(char *name, struct musb *musb)
+{
+}
+static inline void musb_exit_hset(char *name, struct musb *musb)
+{
+}
 #endif
=20
 #endif	/* __MUSB_MUSBDEFS_H__ */
diff -purN -X ./dontdiff a/drivers/usb/musb/musb_hset.c =
c/drivers/usb/musb/musb_hset.c
--- a/drivers/usb/musb/musb_hset.c	1970-01-01 05:30:00.000000000 +0530
+++ c/drivers/usb/musb/musb_hset.c	2007-05-22 11:54:30.000000000 +0530
@@ -0,0 +1,597 @@
+/*
+ * HS USB Host-mode HSET driver for Mentor USB Controller
+ *
+ * Copyright (C) 2005 Mentor Graphics Corporation
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ *      Nishant Kamat <nskamat@ti.com>
+ *      Vikram Pandita <vikram.pandita@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2.
+ *
+ * This driver is based on the USB Skeleton driver-2.0
+ * (drivers/usb/usb-skeleton.c) written by Greg Kroah-Hartman =
(greg@kroah.com)
+ *
+ * Notes:
+ * There are 2 ways this driver can be used:
+ *	1 - By attaching a HS OPT (OTG Protocol Tester) card.
+ * 	    The OPT test application contains scripts to test each mode.
+ *	    Each script attaches the OPT with a distinct VID/PID. Depending =
on
+ *	    the VID/PID this driver go into a particular test mode.
+ *	2 - Through /proc/drivers/musb_HSET interface.
+ *	    This is a forceful method, and rather more useful.
+ *	    Any USB device can be attached to the Host.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kref.h>
+#include <linux/usb.h>
+#include <linux/timer.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+#include <linux/workqueue.h>
+#include "../core/usb.h"
+#include "musbdefs.h"
+
+
+
+/* ULPI pass-through */
+#define MGC_O_HDRC_ULPI_VBUSCTL	0x70
+#define MGC_O_HDRC_ULPI_REGDATA 0x74
+#define MGC_O_HDRC_ULPI_REGADDR 0x75
+#define MGC_O_HDRC_ULPI_REGCTL	0x76
+
+/* extended config & PHY control */
+#define MGC_O_HDRC_ENDCOUNT	0x78
+#define MGC_O_HDRC_DMARAMCFG	0x79
+#define MGC_O_HDRC_PHYWAIT	0x7A
+#define MGC_O_HDRC_PHYVPLEN	0x7B	/* units of 546.1 us */
+#define MGC_O_HDRC_HSEOF1	0x7C	/* units of 133.3 ns */
+#define MGC_O_HDRC_FSEOF1	0x7D	/* units of 533.3 ns */
+#define MGC_O_HDRC_LSEOF1	0x7E	/* units of 1.067 us */
+
+/* Added in HDRC 1.9(?) & MHDRC 1.4 */
+/* ULPI */
+#define MGC_M_ULPI_VBUSCTL_USEEXTVBUSIND    0x02
+#define MGC_M_ULPI_VBUSCTL_USEEXTVBUS	    0x01
+#define MGC_M_ULPI_REGCTL_INT_ENABLE	    0x08
+#define MGC_M_ULPI_REGCTL_READNOTWRITE	    0x04
+#define MGC_M_ULPI_REGCTL_COMPLETE	    0x02
+#define MGC_M_ULPI_REGCTL_REG		    0x01
+/* extended config & PHY control */
+#define MGC_M_ENDCOUNT_TXENDS	0x0f
+#define MGC_S_ENDCOUNT_TXENDS	0
+#define MGC_M_ENDCOUNT_RXENDS	0xf0
+#define MGC_S_ENDCOUNT_RXENDS	4
+#define MGC_M_DMARAMCFG_RAMBITS	0x0f	    /* RAMBITS-1 */
+#define MGC_S_DMARAMCFG_RAMBITS	0
+#define MGC_M_DMARAMCFG_DMACHS	0xf0
+#define MGC_S_DMARAMCFG_DMACHS	4
+#define MGC_M_PHYWAIT_WAITID	0x0f	    /* units of 4.369 ms */
+#define MGC_S_PHYWAIT_WAITID	0
+#define MGC_M_PHYWAIT_WAITCON	0xf0	    /* units of 533.3 ns */
+#define MGC_S_PHYWAIT_WAITCON	4
+
+/*----------------------------------------------------------------------=
-----*/
+/* This is the list of VID/PID that the HS OPT card will use. */
+static struct usb_device_id hset_table [] =3D {
+	{ USB_DEVICE(6666, 0x0101) },	/* TEST_SE0_NAK */
+	{ USB_DEVICE(6666, 0x0102) },	/* TEST_J */
+	{ USB_DEVICE(6666, 0x0103) },	/* TEST_K */
+	{ USB_DEVICE(6666, 0x0104) },	/* TEST_PACKET */
+	{ USB_DEVICE(6666, 0x0105) },	/* TEST_FORCE_ENABLE */
+	{ USB_DEVICE(6666, 0x0106) },	/* HS_HOST_PORT_SUSPEND_RESUME */
+	{ USB_DEVICE(6666, 0x0107) },	/* SINGLE_STEP_GET_DEV_DESC */
+	{ USB_DEVICE(6666, 0x0108) },	/* SINGLE_STEP_SET_FEATURE */
+	{ }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE (usb, hset_table);
+
+/* Structure to hold all of our device specific stuff */
+struct usb_hset {
+	struct usb_device *	udev;	/* the usb device for this device */
+	struct usb_interface *	interface; /* the interface for this device */
+	struct kref		kref;
+	struct musb *		musb; /* the controller */
+	struct proc_dir_entry* pde;
+};
+#define to_hset_dev(d) container_of(d, struct usb_hset, kref)
+
+static struct usb_hset *the_hset;
+static struct usb_driver hset_driver;
+static struct proc_dir_entry *
+	hset_proc_create(char *name, struct usb_hset *hset);
+static void hset_proc_delete(char *name, struct usb_hset *hset);
+
+/*----------------------------------------------------------------------=
-----*/
+/* Test routines */
+
+static int musb_write_ulpi_reg(struct musb *musb, u8 address, u8 =
value);
+static void test_musb(struct musb *musb, u8 mode)
+{
+	void __iomem *pBase =3D musb->pRegs;
+=09
+	if (mode =3D=3D MGC_M_TEST_J || mode =3D=3D MGC_M_TEST_K)
+		/* write 0x50 to Function Control Register (@ 0x04) of the PHY
+		 * 0x50 =3D> OpMode =3D 10b =3D> Disable bit-stuff and NRZI encoding
+		 * 	   SuspendM =3D 1b =3D> Powered
+		 */
+		musb_write_ulpi_reg(musb, 0x04, 0x50);
+
+	if (mode =3D=3D MGC_M_TEST_PACKET) {
+		MGC_SelectEnd(pBase, 0);
+		musb_writew(musb->aLocalEnd[0].regs, MGC_O_HDRC_CSR0, 0);
+		musb_write_fifo(&musb->aLocalEnd[0], sizeof(musb_test_packet),
+				musb_test_packet);
+		/* need to set test mode before enabling FIFO, as otherwise
+		 * the packet goes out and the FIFO empties before the test
+		 * mode is set
+		 */
+		musb_writeb(pBase, MGC_O_HDRC_TESTMODE, mode);
+		musb_writew(musb->aLocalEnd[0].regs, MGC_O_HDRC_CSR0,
+						MGC_M_CSR0_TXPKTRDY);
+	} else
+		musb_writeb(pBase, MGC_O_HDRC_TESTMODE, mode);
+}
+
+static inline void test_se0_nak(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	test_musb(hset->musb, MGC_M_TEST_SE0_NAK);
+}
+
+static inline void test_j(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	test_musb(hset->musb, MGC_M_TEST_J);
+}
+
+static inline void test_k(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	test_musb(hset->musb, MGC_M_TEST_K);
+}
+
+static inline void test_packet(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	test_musb(hset->musb, MGC_M_TEST_PACKET);
+}
+
+static inline void test_force_enable(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	test_musb(hset->musb, MGC_M_TEST_FORCE_HOST);
+}
+
+static void suspend(struct usb_hset *hset)
+{
+	struct musb *musb =3D hset->musb;
+	void __iomem *pBase =3D musb->pRegs;
+	u8 power;
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	power =3D musb_readb(pBase, MGC_O_HDRC_POWER);
+	musb_writeb(pBase, MGC_O_HDRC_POWER, power | MGC_M_POWER_SUSPENDM);
+}
+
+static void resume(struct usb_hset *hset)
+{
+	struct musb *musb =3D hset->musb;
+	void __iomem *pBase =3D musb->pRegs;
+	u8 power;
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	power =3D musb_readb(pBase, MGC_O_HDRC_POWER);
+	if (power & MGC_M_POWER_SUSPENDM) {
+		power &=3D ~(MGC_M_POWER_SUSPENDM | MGC_M_POWER_RESUME);
+		musb_writeb(pBase, MGC_O_HDRC_POWER, power | MGC_M_POWER_RESUME);
+		msleep(20);
+		power =3D musb_readb(pBase, MGC_O_HDRC_POWER);
+		musb_writeb(pBase, MGC_O_HDRC_POWER, power & ~MGC_M_POWER_RESUME);
+	} else
+		printk(KERN_DEBUG "not suspended??\n");
+}
+
+static void test_suspend_resume(struct usb_hset *hset)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	suspend(hset);
+	msleep(15000);	/* Wait for 15 sec */
+	resume(hset);
+}
+
+static void test_single_step_get_dev_desc(struct usb_hset *hset)
+{
+	struct musb *musb =3D hset->musb;
+	struct usb_device *udev;
+	struct usb_bus *bus =3D hcd_to_bus(musb_to_hcd(musb));
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	if (!musb || !bus || !bus->root_hub) {
+		printk(KERN_ERR "Host controller not ready!\n");
+		return;
+	}
+	udev =3D bus->root_hub->children[0];
+	if (!udev) {
+		printk(KERN_DEBUG "No device connected.\n");
+		return;
+	}
+	usb_get_device_descriptor(udev, sizeof(struct usb_device_descriptor));
+}
+
+static void test_single_step_set_feature(struct usb_hset *hset)
+{
+	struct musb *musb =3D hset->musb;
+	struct usb_device *udev;
+	struct usb_bus *bus =3D hcd_to_bus(musb_to_hcd(musb));
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	if (!musb || !bus || !bus->root_hub) {
+		printk(KERN_ERR "Host controller not ready!\n");
+		return;
+	}
+
+	udev =3D bus->root_hub->children[0];
+	if (!udev) {
+		printk(KERN_DEBUG "No device connected.\n");
+		return;
+	}
+	usb_control_msg(udev,
+			usb_sndctrlpipe(udev, 0),
+			USB_REQ_SET_FEATURE, 0, 0,
+			0, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
+}
+
+static void enumerate_bus(struct work_struct *ignored)
+{
+	struct usb_hset *hset =3D the_hset;
+	struct musb *musb =3D hset->musb;
+	struct usb_device *udev;
+	struct usb_bus *bus =3D hcd_to_bus(musb_to_hcd(musb));
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	if (!musb || !bus || !bus->root_hub) {
+		printk(KERN_ERR "Host controller not ready!\n");
+		return;
+	}
+	udev =3D bus->root_hub->children[0];
+	if (udev)
+		usb_reset_device(udev);
+}
+
+DECLARE_WORK(enumerate, enumerate_bus);
+
+/*----------------------------------------------------------------------=
-----*/
+
+/* This function can be called either by musb_init_hset() or =
usb_hset_probe().
+ * musb_init_hset() is called by the controller driver during its =
init(),
+ * while usb_hset_probe() is called when an OPT is attached. We take =
care not
+ * to allocate the usb_hset structure twice.
+ */
+static struct usb_hset* init_hset_dev(void *controller)
+{
+	struct usb_hset *hset =3D NULL;
+
+	/* if already allocated, just increment use count and return */
+	if (the_hset) {
+		kref_get(&the_hset->kref);
+		return the_hset;
+	}
+
+	hset =3D kmalloc(sizeof(*hset), GFP_KERNEL);
+	if (hset =3D=3D NULL) {
+		err("Out of memory");
+		return NULL;
+	}
+	memset(hset, 0x00, sizeof(*hset));
+	hset->musb =3D (struct musb *)(controller);
+
+	kref_init(&hset->kref);
+	the_hset =3D hset;
+	return hset;
+}
+
+static void hset_delete(struct kref *kref)
+{=09
+	struct usb_hset *dev =3D to_hset_dev(kref);
+
+	kfree (dev);
+}
+/*----------------------------------------------------------------------=
-----*/
+/* Usage of HS OPT */
+
+static inline struct musb *dev_to_musb(struct device *dev)
+{
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+        /* usbcore insists dev->driver_data is a "struct hcd *" */
+        return hcd_to_musb(dev_get_drvdata(dev));
+#else
+        return dev_get_drvdata(dev);
+#endif
+}
+
+/* Called when the HS OPT is attached as a device */
+static int hset_probe(struct usb_interface *interface,
+		      const struct usb_device_id *id)
+{
+	struct usb_hset *hset;
+	struct usb_device *udev;
+	struct usb_hcd *hcd;
+	int retval =3D -ENOMEM;
+
+	udev =3D usb_get_dev(interface_to_usbdev(interface));
+	hcd =3D udev->bus->controller->driver_data;
+	hset =3D init_hset_dev(hcd->hcd_priv);
+	if (!hset)
+		return retval;
+
+	hset->udev =3D udev;
+	hset->interface =3D interface;
+	usb_set_intfdata(interface, hset);
+
+	switch(id->idProduct) {
+	case 0x0101:
+		test_se0_nak(hset);
+		break;
+	case 0x0102:=09
+		test_j(hset);
+		break;
+	case 0x0103:
+		test_k(hset);
+		break;
+	case 0x0104:
+		test_packet(hset);
+		break;
+	case 0x0105:
+		test_force_enable(hset);
+		break;
+	case 0x0106:
+		test_suspend_resume(hset);
+		break;
+	case 0x0107:
+		msleep(15000);	/* SOFs for 15 sec */
+		test_single_step_get_dev_desc(hset);
+		break;
+	case 0x0108:
+		test_single_step_get_dev_desc(hset);
+		msleep(15000);	/* SOFs for 15 sec */
+		test_single_step_set_feature(hset);
+		break;
+	};
+	return 0;
+}
+
+static void hset_disconnect(struct usb_interface *interface)
+{
+	struct usb_hset *hset;
+
+	/* prevent hset_open() from racing hset_disconnect() */
+	lock_kernel();
+	hset =3D usb_get_intfdata(interface);
+	usb_set_intfdata(interface, NULL);
+	unlock_kernel();
+
+	usb_put_dev(hset->udev);
+	kref_put(&hset->kref, hset_delete);
+}
+
+static struct usb_driver hset_driver =3D {
+//	.owner =3D	THIS_MODULE,
+	.name =3D		"hset",
+	.probe =3D	hset_probe,
+	.disconnect =3D	hset_disconnect,
+	.id_table =3D	hset_table,
+};
+
+static int __init usb_hset_init(void)
+{
+	int result;
+
+	/* register this driver with the USB subsystem */
+	result =3D usb_register(&hset_driver);
+	if (result)
+		err("usb_register failed. Error number %d", result);
+
+	return result;
+}
+
+static void __exit usb_hset_exit(void)
+{
+	/* deregister this driver with the USB subsystem */
+	usb_deregister(&hset_driver);
+}
+
+module_init (usb_hset_init);
+module_exit (usb_hset_exit);
+
+MODULE_LICENSE("GPL");
+
+/*----------------------------------------------------------------------=
-----*/
+/* Usage of /proc/drivers/musb_hset interface */
+
+void musb_init_hset(char *name, struct musb *musb)
+{
+	struct usb_hset *hset;
+	hset =3D init_hset_dev((void *)musb);
+	hset_proc_create(name, hset);
+}
+
+void musb_exit_hset(char *name, struct musb *musb)
+{
+	struct usb_hset *hset =3D the_hset;
+
+	if (!hset) {
+		printk(KERN_DEBUG "No hset device!\n");
+		return;
+	}
+	hset_proc_delete(name, hset);
+	kref_put(&hset->kref, hset_delete);
+}
+
+static int dump_menu(char *buffer)
+{
+	int count =3D 0;
+
+	*buffer =3D 0;
+	count =3D sprintf(buffer, "HOST-side high-speed electrical test =
modes:\n"
+				"J: Test_J\n"
+				"K: Test_K\n"
+				"S: Test_SE0_NAK\n"
+				"P: Test_PACKET\n"
+				"H: Test_FORCE_ENABLE\n"
+				"U: Test_SUSPEND_RESUME\n"
+				"G: Test_SINGLE_STEP_GET_DESC\n"
+				"F: Test_SINGLE_STEP_SET_FEATURE\n"
+				"E: Enumerate bus\n"
+				"D: Suspend bus\n"
+				"R: Resume bus\n"
+				"?: help menu\n");
+	if (count < 0)
+		return count;
+	buffer +=3D count;
+	return count;
+}
+
+static int hset_proc_write(struct file *file, const char __user =
*buffer,
+			 unsigned long count, void *data)
+{
+	char cmd;
+	struct usb_hset *hset =3D (struct usb_hset *)data;
+	char help[500];
+	/* MOD_INC_USE_COUNT; */
+	//if (hset->musb->asleep)
+	//	return EBUSY;
+
+	if(copy_from_user(&cmd, buffer, 1))
+		return -EFAULT;
+	switch (cmd) {
+	case 'S':
+		test_se0_nak(hset);
+		break;
+	case 'J':=09
+		test_j(hset);
+		break;
+	case 'K':
+		test_k(hset);
+		break;
+	case 'P':
+		test_packet(hset);
+		break;
+	case 'H':
+		test_force_enable(hset);
+		break;
+	case 'U':
+		test_suspend_resume(hset);
+		break;
+	case 'G':
+		test_single_step_get_dev_desc(hset);
+		break;
+	case 'F':
+		test_single_step_set_feature(hset);
+		break;
+	case 'E':
+		schedule_work(&enumerate);
+		break;
+	case 'D':
+		suspend(hset);
+		break;
+	case 'R':
+		resume(hset);
+		break;
+	case '?':
+		dump_menu(help);
+		printk(KERN_INFO "%s", help);
+		break;
+	default:
+		printk(KERN_ERR "Command %c not implemented\n", cmd);
+		break;
+	}
+
+	return count;
+}
+
+static int hset_proc_read(char *page, char **start,
+			off_t off, int count, int *eof, void *data)
+{
+	char *buffer =3D page;
+	int code =3D 0;
+
+	count -=3D off;
+	count -=3D 1;		/* for NUL at end */
+	if (count < 0)
+		return -EINVAL;
+
+	code =3D dump_menu(buffer);
+	if (code > 0) {
+		buffer +=3D code;
+		count -=3D code;
+	}
+
+	*eof =3D 1;
+	return (buffer - page) - off;
+}
+
+void hset_proc_delete(char *name, struct usb_hset *hset)
+{
+	if (hset->pde)
+		remove_proc_entry(name, NULL);
+}
+
+struct proc_dir_entry *hset_proc_create(char *name, struct usb_hset =
*hset)
+{
+	struct proc_dir_entry	*pde;
+
+	/* FIXME convert everything to seq_file; then later, debugfs */
+
+	if (!name || !hset)
+		return NULL;
+=09
+	hset->pde =3D pde =3D create_proc_entry(name,
+				     S_IFREG | S_IRUGO | S_IWUSR, NULL);
+	if (pde) {
+		pde->data =3D (void *)hset;
+		// pde->owner =3D THIS_MODULE;
+
+		pde->read_proc =3D hset_proc_read;
+		pde->write_proc =3D hset_proc_write;
+
+		pde->size =3D 0;
+
+		pr_debug("Registered /proc/%s\n", name);
+	} else {
+		pr_debug("Cannot create a valid proc file entry");
+	}
+
+	return pde;
+}
+
+static int musb_write_ulpi_reg(struct musb* musb, u8 address, u8 value)
+{
+	u8 ctl =3D 0;
+	u8* pBase =3D musb->pRegs;
+
+	/* ensure not powered down */
+	if(musb_readb(pBase, MGC_O_HDRC_POWER) & MGC_M_POWER_ENSUSPEND) {
+		return -ENODEV;
+	}
+
+	/* polled */
+	musb_writeb(pBase, MGC_O_HDRC_ULPI_REGADDR, address);
+	musb_writeb(pBase, MGC_O_HDRC_ULPI_REGDATA, value);
+	musb_writeb(pBase, MGC_O_HDRC_ULPI_REGCTL, MGC_M_ULPI_REGCTL_REG);
+
+	while(!(MGC_M_ULPI_REGCTL_COMPLETE & ctl)) {
+		ctl =3D musb_readb(pBase, MGC_O_HDRC_ULPI_REGCTL);
+	}
+
+	musb_writeb(pBase, MGC_O_HDRC_ULPI_REGCTL, 0);
+
+	return 0;
+}
diff -purN -X ./dontdiff a/drivers/usb/musb/plat_uds.c =
c/drivers/usb/musb/plat_uds.c
--- a/drivers/usb/musb/plat_uds.c	2007-05-21 12:57:45.000000000 +0530
+++ c/drivers/usb/musb/plat_uds.c	2007-05-22 11:58:37.000000000 +0530
@@ -248,27 +248,6 @@ void musb_read_fifo(struct musb_hw_ep *h
=20
=20
 =
/*-----------------------------------------------------------------------=
--*/
-
-/* for high speed test mode; see USB 2.0 spec 7.1.20 */
-static const u8 musb_test_packet[53] =3D {
-	/* implicit SYNC then DATA0 to start */
-
-	/* JKJKJKJK x9 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	/* JJKKJJKK x8 */
-	0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
-	/* JJJJKKKK x8 */
-	0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee, 0xee,
-	/* JJJJJJJKKKKKKK x8 */
-	0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, =
0xff,
-	/* JJJJJJJK x8 */
-	0x7f, 0xbf, 0xdf, 0xef, 0xf7, 0xfb, 0xfd,
-	/* JKKKKKKK x10, JK */
-	0xfc, 0x7e, 0xbf, 0xdf, 0xef, 0xf7, 0xfb, 0xfd, 0x7e
-
-	/* implicit CRC16 then EOP to end */
-};
-
 void musb_load_testpacket(struct musb *musb)
 {
 	void __iomem	*regs =3D musb->aLocalEnd[0].regs;
@@ -1856,8 +1835,13 @@ musb_init_controller(struct device *dev,
=20
 	}
=20
-	if (status =3D=3D 0)
+	if (status =3D=3D 0) {
 		musb_debug_create("driver/musb_hdrc", pThis);
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
+		musb_init_hset("driver/musb_HSET", pThis);
+#endif
+
+	}
 	else {
 fail:
 		if (pThis->clock)
@@ -1929,6 +1913,7 @@ static int __devexit musb_remove(struct=20
 	musb_shutdown(pdev);
 	musb_debug_delete("driver/musb_hdrc", musb);
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
+	musb_exit_hset("driver/musb_HSET", musb);
 	if (musb->board_mode =3D=3D MUSB_HOST)
 		usb_remove_hcd(musb_to_hcd(musb));
 #endif
