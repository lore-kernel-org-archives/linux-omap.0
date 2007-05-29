From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] musb_hdrc: Make HNP work
Date: Tue, 29 May 2007 15:02:37 +0300
Message-ID: <11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401741522-git-send-email-felipebalbi@users.sourceforge.net>
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

From: Tony Lindgren <tony@atomide.com>

This patch makes Host Negotiation Protocol (HNP) mostly work.
To enable HNP to turn B-device into B-host, do:

# echo 1 > /sys/devices/platform/musb_hdrc/hnp

To disable B-host:

# echo 0 > /sys/devices/platform/musb_hdrc/hnp

Currently you probably need to replug the B-device
after stopping HNP to have it detected.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/musb/g_ep0.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/g_ep0.c	2007-05-28 01:39:42.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/g_ep0.c	2007-05-28 13:18:58.000000000 +0300
@@ -201,6 +201,21 @@
 }
 
 /*
+ * Tries to start B-device HNP negotiation if enabled via sysfs
+ */
+static inline void musb_try_b_hnp_enable(struct musb *musb)
+{
+	void __iomem	*pBase = musb->pRegs;
+	u8		devctl;
+
+	if (musb->is_hnp_enabled) {
+		DBG(1, "HNP: Setting HR\n");
+		devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, devctl | MGC_M_DEVCTL_HR);
+	}
+}
+
+/*
  * Handle all control requests with no DATA stage, including standard
  * requests such as:
  * USB_REQ_SET_CONFIGURATION, USB_REQ_SET_INTERFACE, unrecognized
@@ -326,17 +341,8 @@
 				case USB_DEVICE_B_HNP_ENABLE:
 					if (!musb->g.is_otg)
 						goto stall;
-					{ u8 devctl;
 					musb->g.b_hnp_enable = 1;
-					devctl = musb_readb(pBase,
-							MGC_O_HDRC_DEVCTL);
-					/* NOTE:  at least DaVinci doesn't
-					 * like to set HR ...
-					 */
-					DBG(1, "set HR\n");
-					musb_writeb(pBase, MGC_O_HDRC_DEVCTL,
-						devctl | MGC_M_DEVCTL_HR);
-					}
+					musb_try_b_hnp_enable(musb);
 					break;
 				case USB_DEVICE_A_HNP_SUPPORT:
 					if (!musb->g.is_otg)
Index: linux-omap-2.6/drivers/usb/musb/musb_gadget.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/musb_gadget.c	2007-05-28 13:18:47.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/musb_gadget.c	2007-05-28 13:18:58.000000000 +0300
@@ -1872,6 +1872,11 @@
 	 */
 
 	spin_lock_irqsave(&musb->Lock, flags);
+
+#ifdef	CONFIG_USB_MUSB_OTG
+	musb_hnp_stop(musb);
+#endif
+
 	if (musb->pGadgetDriver == driver) {
 		musb->xceiv.state = OTG_STATE_UNDEFINED;
 		stop_activity(musb, driver);
@@ -1984,6 +1989,9 @@
 #ifdef	CONFIG_USB_MUSB_OTG
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		break;
+	case OTG_STATE_A_PERIPHERAL:
+		musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
+		break;
 	case OTG_STATE_B_WAIT_ACON:
 	case OTG_STATE_B_HOST:
 #endif
Index: linux-omap-2.6/drivers/usb/musb/musbdefs.h
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/musbdefs.h	2007-05-28 13:18:47.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/musbdefs.h	2007-05-28 13:18:58.000000000 +0300
@@ -469,6 +469,8 @@
 #ifdef CONFIG_USB_MUSB_OTG
 	/* FIXME this can't be OTG-specific ... ? */
 	u8 bDelayPortPowerOff;
+
+	unsigned		is_hnp_enabled:1;
 #endif
 
 #ifdef MUSB_CONFIG_PROC_FS
@@ -508,6 +510,8 @@
 extern void musb_platform_enable(struct musb *musb);
 extern void musb_platform_disable(struct musb *musb);
 
+extern void musb_hnp_stop(struct musb *musb);
+
 #ifdef CONFIG_USB_TUSB6010
 extern void musb_platform_try_idle(struct musb *musb);
 extern int musb_platform_get_vbus_status(struct musb *musb);
Index: linux-omap-2.6/drivers/usb/musb/plat_uds.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:52.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:58.000000000 +0300
@@ -281,6 +281,70 @@
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef	CONFIG_USB_MUSB_OTG
+
+/*
+ * See also USB_OTG_1-3.pdf 6.6.5 Timers
+ * REVISIT: Are the other timers done in the hardware?
+ */
+#define TB_ASE0_BRST		100	/* Min 3.125 ms */
+
+/*
+ * Handles OTG hnp timeouts, such ad b_ase0_brst
+ */
+void musb_otg_timer_func(unsigned long data)
+{
+	struct musb	*musb = (struct musb *)data;
+	void __iomem	*pBase = musb->pRegs;
+	unsigned long	flags;
+	u8		devctl;
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	if (musb->xceiv.state == OTG_STATE_B_WAIT_ACON) {
+		DBG(1, "HNP: B_WAIT_ACON timeout, going back to B_PERIPHERAL\n");
+		devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, devctl & ~MGC_M_DEVCTL_HR);
+		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+	}
+	spin_unlock_irqrestore(&musb->Lock, flags);
+}
+
+static DEFINE_TIMER(musb_otg_timer, musb_otg_timer_func, 0, 0);
+
+/*
+ * Stops the B-device HNP state. Caller must take care of locking.
+ */
+void musb_hnp_stop(struct musb *musb)
+{
+	struct usb_hcd	*hcd = musb_to_hcd(musb);
+	void __iomem	*pBase = musb->pRegs;
+	u8	reg;
+
+	switch (musb->xceiv.state) {
+	case OTG_STATE_A_PERIPHERAL:
+	case OTG_STATE_A_WAIT_VFALL:
+		DBG(1, "HNP: Switching back to A-host\n");
+		musb_g_disconnect(musb);
+		musb->xceiv.state = OTG_STATE_B_IDLE;
+		/* REVISIT: Reset session here? Or wait for SESSION_REQUEST? */
+		break;
+	case OTG_STATE_B_HOST:
+		DBG(1, "HNP: Disabling HR\n");
+		hcd->self.is_b_host = 0;
+		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+		reg = musb_readb(pBase, MGC_O_HDRC_POWER);
+		reg |= MGC_M_POWER_SUSPENDM;
+		musb_writeb(pBase, MGC_O_HDRC_POWER, reg);
+		/* REVISIT: Start SESSION_REQUEST here? */
+		break;
+	default:
+		DBG(1, "HNP: Stopping in unknown state %s\n",
+			otg_state_string(musb));
+	}
+}
+
+#endif
+
 /*
  * Interrupt Service Routine to record USB "global" interrupts.
  * Since these do not happen often and signify things of
@@ -519,12 +583,16 @@
 		/* indicate new connection to OTG machine */
 		switch (pThis->xceiv.state) {
 		case OTG_STATE_B_WAIT_ACON:
+			DBG(1, "HNP: Waiting to switch to b_host state\n");
 			pThis->xceiv.state = OTG_STATE_B_HOST;
+			hcd->self.is_b_host = 1;
 			break;
 		default:
 			if ((devctl & MGC_M_DEVCTL_VBUS)
-					== (3 << MGC_S_DEVCTL_VBUS))
+					== (3 << MGC_S_DEVCTL_VBUS)) {
 				pThis->xceiv.state = OTG_STATE_A_HOST;
+				hcd->self.is_b_host = 0;
+			}
 			break;
 		}
 		DBG(1, "CONNECT (%s) devctl %02x\n",
@@ -631,8 +699,10 @@
 			break;
 #endif	/* HOST */
 #ifdef CONFIG_USB_MUSB_OTG
-		case OTG_STATE_A_PERIPHERAL:
 		case OTG_STATE_B_HOST:
+			musb_hnp_stop(pThis);
+			/* FALLTHROUGH */
+		case OTG_STATE_A_PERIPHERAL:
 			musb_root_disconnect(pThis);
 			/* FALLTHROUGH */
 		case OTG_STATE_B_WAIT_ACON:
@@ -657,13 +727,25 @@
 		handled = IRQ_HANDLED;
 
 		switch (pThis->xceiv.state) {
+		case OTG_STATE_A_PERIPHERAL:
+			musb_hnp_stop(pThis);
+			break;
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_suspend(pThis);
 			pThis->is_active = is_otg_enabled(pThis)
 					&& pThis->xceiv.gadget->b_hnp_enable;
 			if (pThis->is_active) {
 				pThis->xceiv.state = OTG_STATE_B_WAIT_ACON;
-				/* REVISIT timeout for b_ase0_brst, etc */
+#ifdef	CONFIG_USB_MUSB_OTG
+				/* Handle timeout for b_ase0_brst */
+				if (pThis->is_hnp_enabled == 0)
+					break;
+				DBG(1, "HNP: Setting timer for b_ase0_brst\n");
+				musb_otg_timer.data = (unsigned long)pThis;
+				musb_otg_timer.expires =
+					jiffies + msecs_to_jiffies(TB_ASE0_BRST);
+				add_timer(&musb_otg_timer);
+#endif
 			}
 			break;
 		case OTG_STATE_A_HOST:
@@ -671,6 +753,16 @@
 			pThis->is_active = is_otg_enabled(pThis)
 					&& pThis->xceiv.host->b_hnp_enable;
 			break;
+#if 0
+		case OTG_STATE_A_PERIPHERAL:
+			/* Transition to a_wait_vfall, see 6.8.1.6 p 41 */
+			DBG(1, "REVISIT: SUSPEND as A_PERIPHERAL\n");
+			break;
+#endif
+		case OTG_STATE_B_HOST:
+			/* Transition to B_PERIPHERAL, see 6.8.2.6 p 44 */
+			DBG(1, "REVISIT: SUSPEND as B_HOST\n");
+			break;
 		default:
 			/* "should not happen" */
 			pThis->is_active = 0;
@@ -1497,17 +1589,7 @@
 	int ret = -EINVAL;
 
 	spin_lock_irqsave(&musb->Lock, flags);
-	switch (musb->board_mode) {
-	case MUSB_HOST:
-		ret = sprintf(buf, "host\n");
-		break;
-	case MUSB_PERIPHERAL:
-		ret = sprintf(buf, "peripheral\n");
-		break;
-	case MUSB_OTG:
-		ret = sprintf(buf, "otg\n");
-		break;
-	}
+	ret = sprintf(buf, "%s\n", otg_state_string(musb));
 	spin_unlock_irqrestore(&musb->Lock, flags);
 
 	return ret;
@@ -1533,6 +1615,8 @@
 }
 static DEVICE_ATTR(mode, 0644, musb_mode_show, musb_mode_store);
 
+
+
 static ssize_t
 musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -1653,6 +1737,47 @@
 
 #ifdef CONFIG_USB_MUSB_OTG
 static ssize_t
+musb_hnp_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct musb *musb = dev_to_musb(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	if (musb->is_hnp_enabled == 0)
+		ret = sprintf(buf, "disabled\n");
+	else
+		ret = sprintf(buf, "enabled\n");
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return ret;
+}
+
+static ssize_t
+musb_hnp_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	struct musb	*musb = dev_to_musb(dev);
+	unsigned long	flags;
+	unsigned short	val;
+
+	if (sscanf(buf, "%hu", &val) != 1
+			|| (val != 0 && val != 1)) {
+		printk(KERN_ERR "HNP: Value must be 0 or 1\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	if (val == 0 && musb->is_hnp_enabled != 0)
+		musb_hnp_stop(musb);
+	musb->is_hnp_enabled = val;
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return n;
+}
+static DEVICE_ATTR(hnp, 0644, musb_hnp_show, musb_hnp_store);
+
+static ssize_t
 musb_srp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
@@ -1749,6 +1874,7 @@
 	device_remove_file(musb->controller, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
 	device_remove_file(musb->controller, &dev_attr_srp);
+	device_remove_file(musb->controller, &dev_attr_hnp);
 #endif
 #endif
 
@@ -1981,6 +2107,7 @@
 	status = device_create_file(dev, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
 	status = device_create_file(dev, &dev_attr_srp);
+	status = device_create_file(dev, &dev_attr_hnp);
 #endif /* CONFIG_USB_MUSB_OTG */
 	status = 0;
 #endif
