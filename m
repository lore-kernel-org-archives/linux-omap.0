From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Mon, 20 Aug 2007 11:10:05 -0700
Message-ID: <200708201110.06262.david-b@pacbell.net>
References: <46C5C233.5090405@googlemail.com>
	<200708200141.48452.david-b@pacbell.net>
	<46C965EF.7050508@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46C965EF.7050508@googlemail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 20 August 2007, Dirk Behme wrote:
> this conflicts with Kevins patch Tony applied some 
> minutes ago:

Update appended.  Too much of the current #ifdeffery
is trivially replaced by using the already-defined
predicates to test e.g. the available modes.

- Dave

======	SNIP!
(Updated) Fix various build warnings for peripheral-only builds,
and some linewrap bugs.  Remove some inappropriate #ifdefs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/musb/musbdefs.h |    4 ++--
 drivers/usb/musb/plat_uds.c |   23 +++++++++++++----------
 drivers/usb/musb/tusb6010.c |    4 ----
 3 files changed, 15 insertions(+), 16 deletions(-)

--- h4.orig/drivers/usb/musb/plat_uds.c	2007-08-20 10:58:35.000000000 -0700
+++ h4/drivers/usb/musb/plat_uds.c	2007-08-20 11:02:48.000000000 -0700
@@ -364,9 +364,7 @@ static irqreturn_t musb_stage0_irq(struc
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
 	void __iomem *mbase = musb->mregs;
-#endif
 
 	DBG(3, "<== Power=%02x, DevCtl=%02x, int_usb=0x%x\n", power, devctl,
 		int_usb);
@@ -603,8 +601,7 @@ static irqreturn_t musb_stage0_irq(struc
 	 * only host sees babble; only peripheral sees bus reset.
 	 */
 	if (int_usb & MUSB_INTR_RESET) {
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
-		if (devctl & MUSB_DEVCTL_HM) {
+		if (is_host_capable() && (devctl & MUSB_DEVCTL_HM) != 0) {
 			/*
 			 * Looks like non-HS BABBLE can be ignored, but
 			 * HS BABBLE is an error condition. For HS the solution
@@ -618,9 +615,7 @@ static irqreturn_t musb_stage0_irq(struc
 				ERR("Stopping host session because of babble\n");
 				musb_writeb(mbase, MUSB_DEVCTL, 0);
 			}
-		} else
-#endif	/* CONFIG_USB_MUSB_HDRC_HCD */
-		{
+		} else if (is_peripheral_capable()) {
 			DBG(1, "BUS RESET\n");
 
 			musb_g_reset(musb);
@@ -1707,6 +1702,11 @@ musb_vbus_show(struct device *dev, struc
 }
 static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
 
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+
+/* Gadget drivers can't know that a host is connected so they might want
+ * to start SRP, but users can.  This allows userspace to trigger SRP.
+ */
 static ssize_t
 musb_srp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
@@ -1726,7 +1726,10 @@ musb_srp_store(struct device *dev, struc
 	return n;
 }
 static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
-#endif
+
+#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
+
+#endif	/* sysfs */
 
 /* Only used to provide cable state change events */
 static void musb_irq_work(struct work_struct *data)
@@ -2028,9 +2031,9 @@ fail:
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_cable);
 	status = device_create_file(dev, &dev_attr_vbus);
-#ifdef CONFIG_USB_MUSB_OTG
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	status = device_create_file(dev, &dev_attr_srp);
-#endif /* CONFIG_USB_MUSB_OTG */
+#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
 	status = 0;
 #endif
 
--- h4.orig/drivers/usb/musb/musbdefs.h	2007-08-20 10:58:35.000000000 -0700
+++ h4/drivers/usb/musb/musbdefs.h	2007-08-20 11:01:08.000000000 -0700
@@ -328,12 +328,12 @@ struct musb {
 	irqreturn_t		(*isr)(int, void *);
 	struct work_struct	irq_work;
 
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
-
 /* this hub status bit is reserved by USB 2.0 and not seen by usbcore */
 #define MUSB_PORT_STAT_RESUME	(1 << 31)
 
 	u32			port1_status;
+
+#ifdef CONFIG_USB_MUSB_HDRC_HCD
 	unsigned long		rh_timer;
 
 	enum musb_h_ep0_state	ep0_stage;
--- h4.orig/drivers/usb/musb/tusb6010.c	2007-08-20 10:58:35.000000000 -0700
+++ h4/drivers/usb/musb/tusb6010.c	2007-08-20 11:01:08.000000000 -0700
@@ -438,11 +438,9 @@ static void musb_do_idle(unsigned long _
 	if (!musb->is_active) {
 		u32	wakeups;
 
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
 		/* wait until khubd handles port change status */
 		if (is_host_active(musb) && (musb->port1_status >> 16))
 			goto done;
-#endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		if (is_peripheral_enabled(musb) && !musb->gadget_driver)
@@ -586,7 +584,6 @@ void musb_platform_set_mode(struct musb 
 {
 	void __iomem	*base = musb->ctrl_base;
 	u32		otg_stat, phy_otg_ctrl, phy_otg_ena, dev_conf;
-	int		vbus = 0;
 
 	if (musb->board_mode != MUSB_OTG) {
 		ERR("Changing mode currently only supported in OTG mode\n");
@@ -606,7 +603,6 @@ void musb_platform_set_mode(struct musb 
 		phy_otg_ena |= TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP;
 		dev_conf |= TUSB_DEV_CONF_ID_SEL;
 		dev_conf &= ~TUSB_DEV_CONF_SOFT_ID;
-		vbus = 1;
 		break;
 #endif
 
