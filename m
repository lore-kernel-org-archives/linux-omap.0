From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] musb_hdrc: Add SRP Interface and control it through sysfs
Date: Tue, 29 May 2007 15:02:34 +0300
Message-ID: <11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.lima@indt.org.br>

	This patch adds a method to start SRP and a userspace
	interface to control it through sysfs.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/musb/musb_gadget.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/musb_gadget.c	2007-05-28 01:40:16.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/musb_gadget.c	2007-05-28 13:18:47.000000000 +0300
@@ -2056,3 +2056,29 @@
 	(void) musb_gadget_vbus_draw(&musb->g,
 			is_otg_enabled(musb) ? 8 : 100);
 }
+
+/* called when we want to send a Session Request. Caller must hold the lock */
+void musb_g_srp(struct musb *musb)
+{
+	void __iomem	*base = musb->pRegs;
+	u8	devctl = musb_readb(base, MGC_O_HDRC_DEVCTL);
+
+	DBG(3, "Starting SRP\n");
+
+	musb_writeb(base, MGC_O_HDRC_DEVCTL, devctl | MGC_M_DEVCTL_BDEVICE);
+
+	/* In order to start SRP we need to ensure that Vbus is below the
+	 * Session Valid Threshold.
+	 * On MUSB this means that  MGC_M_DEVCTL_VBUS and MGC_S_DEVCTL_VBUS
+	 * are set to 00.
+	 */
+	devctl &= MGC_M_DEVCTL_VBUS & MGC_S_DEVCTL_VBUS;
+
+	if (!devctl) {
+		devctl = musb_readb(base, MGC_O_HDRC_DEVCTL);
+		devctl |= MGC_M_DEVCTL_SESSION | MGC_M_DEVCTL_BDEVICE;
+
+		musb_writeb(base, MGC_O_HDRC_DEVCTL, devctl);
+	} else
+		DBG(7, "Cannot Start SRP: devctl = %02x\n" , devctl);
+}
Index: linux-omap-2.6/drivers/usb/musb/musbdefs.h
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/musbdefs.h	2007-05-28 01:40:16.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/musbdefs.h	2007-05-28 13:18:47.000000000 +0300
@@ -124,6 +124,7 @@
 extern void musb_g_reset(struct musb *);
 extern void musb_g_suspend(struct musb *);
 extern void musb_g_resume(struct musb *);
+extern void musb_g_srp(struct musb *);
 extern void musb_g_disconnect(struct musb *);
 
 #else
@@ -134,6 +135,7 @@
 static inline void musb_g_reset(struct musb *m) {}
 static inline void musb_g_suspend(struct musb *m) {}
 static inline void musb_g_resume(struct musb *m) {}
+static inline void musb_g_srp(struct musb *m) {}
 static inline void musb_g_disconnect(struct musb *m) {}
 
 #endif
Index: linux-omap-2.6/drivers/usb/musb/plat_uds.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/plat_uds.c	2007-05-28 01:40:16.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:47.000000000 +0300
@@ -1579,6 +1579,32 @@
 }
 static DEVICE_ATTR(cable, S_IRUGO, musb_cable_show, NULL);
 
+#ifdef CONFIG_USB_MUSB_OTG
+static ssize_t
+musb_srp_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	struct musb	*musb=dev_to_musb(dev);
+	unsigned long	flags;
+	unsigned short	srp;
+
+	if (sscanf(buf, "%hu", &srp) != 1
+			|| (srp != 1)) {
+		printk (KERN_ERR "SRP: Value must be 1\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	if (srp == 1){
+		musb_g_srp(musb);
+	}
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return n;
+}
+static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
+#endif /* CONFIG_USB_MUSB_OTG */
+
 #endif
 
 /* Only used to provide cable state change events */
@@ -1648,6 +1674,9 @@
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
 	device_remove_file(musb->controller, &dev_attr_cable);
+#ifdef CONFIG_USB_MUSB_OTG
+	device_remove_file(musb->controller, &dev_attr_srp);
+#endif
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -1876,6 +1905,9 @@
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_cable);
+#ifdef CONFIG_USB_MUSB_OTG
+	status = device_create_file(dev, &dev_attr_srp);
+#endif /* CONFIG_USB_MUSB_OTG */
 	status = 0;
 #endif
 
