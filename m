From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.20-rc5-omap] musb_hdrc misc cleanups
Date: Wed, 17 Jan 2007 12:43:36 -0800
Message-ID: <200701171243.37404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Remove debug/prototype sysfs attribute 'musb_otg', so there's only
the one (compound) state machine to follow.  (If we need an option
it'd more likely be to match the N800:  Mini-B connector forced
into host mode, with gender-bender assistance.)

Minor DaVinci tweak:  on driver shutdown, don't wait for VBUS to fall
unless we're the host which was supplying that voltage.

Remove some more UglyCamelCasing.

Clear HR in some peripheral side code; the silicon doesn't clear it
in various cases you'd expect such stuff to be automatic. 

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/drivers/usb/musb/plat_uds.c
===================================================================
--- h4.orig/drivers/usb/musb/plat_uds.c	2007-01-17 12:22:12.000000000 -0800
+++ h4/drivers/usb/musb/plat_uds.c	2007-01-17 12:22:43.000000000 -0800
@@ -145,19 +145,6 @@ MODULE_LICENSE("GPL");
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef	CONFIG_USB_MUSB_OTG
-
-/* For debugging/prototyping:  allow disabling host side support on boards
- * with Mini-AB (or Mini-A) connectors, making peripheral side support look
- * like pure peripherals (not reporting OTG capabilities, and able to
- * draw a full 100mA unit load).
- */
-int musb_otg = 1;
-
-module_param(musb_otg, bool, 0);
-MODULE_PARM_DESC(musb_otg, "enable/disable OTG capabilities");
-#endif
-
 static inline struct musb *dev_to_musb(struct device *dev)
 {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
@@ -1798,11 +1785,6 @@ musb_init_controller(struct device *dev,
 	}
 #endif				/* CONFIG_USB_MUSB_HDRC_HCD */
 
-#ifdef CONFIG_USB_MUSB_OTG
-	if (!is_otg_enabled(pThis))
-		musb_otg = 0;
-#endif
-
 	/* For the host-only role, we can activate right away.
 	 * (We expect the ID pin to be forcibly grounded!!)
 	 * Otherwise, wait till the gadget driver hooks up.
Index: h4/drivers/usb/musb/musbdefs.h
===================================================================
--- h4.orig/drivers/usb/musb/musbdefs.h	2007-01-17 12:22:12.000000000 -0800
+++ h4/drivers/usb/musb/musbdefs.h	2007-01-17 12:22:43.000000000 -0800
@@ -492,13 +492,6 @@ static inline struct musb *gadget_to_mus
 }
 #endif
 
-#ifdef CONFIG_USB_MUSB_OTG
-/* sysfs flag to seletively force peripheral-only operation */
-extern int musb_otg;
-#else
-#define musb_otg 0
-#endif
-
 
 /***************************** Glue it together *****************************/
 
Index: h4/drivers/usb/musb/musb_gadget.c
===================================================================
--- h4.orig/drivers/usb/musb/musb_gadget.c	2007-01-17 12:20:56.000000000 -0800
+++ h4/drivers/usb/musb/musb_gadget.c	2007-01-17 12:22:43.000000000 -0800
@@ -1659,7 +1659,7 @@ static inline void __init musb_g_init_en
 /* called once during driver setup to initialize and link into
  * the driver model; memory is zeroed.
  */
-int __init musb_gadget_setup(struct musb *pThis)
+int __init musb_gadget_setup(struct musb *musb)
 {
 	int status;
 
@@ -1669,36 +1669,39 @@ int __init musb_gadget_setup(struct musb
 	 */
 	if (the_gadget)
 		return -EBUSY;
-	the_gadget = pThis;
+	the_gadget = musb;
 
-	pThis->g.ops = &musb_gadget_operations;
-	pThis->g.is_dualspeed = 1;
-	pThis->g.speed = USB_SPEED_UNKNOWN;
+	musb->g.ops = &musb_gadget_operations;
+	musb->g.is_dualspeed = 1;
+	musb->g.speed = USB_SPEED_UNKNOWN;
 
 	/* this "gadget" abstracts/virtualizes the controller */
-	strcpy(pThis->g.dev.bus_id, "gadget");
-	pThis->g.dev.parent = pThis->controller;
-	pThis->g.dev.dma_mask = pThis->controller->dma_mask;
-	pThis->g.dev.release = musb_gadget_release;
-	pThis->g.name = musb_driver_name;
+	strcpy(musb->g.dev.bus_id, "gadget");
+	musb->g.dev.parent = musb->controller;
+	musb->g.dev.dma_mask = musb->controller->dma_mask;
+	musb->g.dev.release = musb_gadget_release;
+	musb->g.name = musb_driver_name;
 
-	musb_g_init_endpoints(pThis);
+	if (is_otg_enabled(musb))
+		musb->g.is_otg = 1;
 
-	pThis->is_active = 0;
-	musb_platform_try_idle(pThis);
+	musb_g_init_endpoints(musb);
+
+	musb->is_active = 0;
+	musb_platform_try_idle(musb);
 
-	status = device_register(&pThis->g.dev);
+	status = device_register(&musb->g.dev);
 	if (status != 0)
 		the_gadget = NULL;
 	return status;
 }
 
-void musb_gadget_cleanup(struct musb *pThis)
+void musb_gadget_cleanup(struct musb *musb)
 {
-	if (pThis != the_gadget)
+	if (musb != the_gadget)
 		return;
 
-	device_unregister(&pThis->g.dev);
+	device_unregister(&musb->g.dev);
 	the_gadget = NULL;
 }
 
@@ -1955,7 +1958,13 @@ void musb_g_suspend(struct musb *pThis)
 /* called when VBUS drops below session threshold, and in other cases */
 void musb_g_disconnect(struct musb *pThis)
 {
-	DBG(3, "devctl %02x\n", musb_readb(pThis->pRegs, MGC_O_HDRC_DEVCTL));
+	void __iomem	*mregs = pThis->pRegs;
+	u8	devctl = musb_readb(mregs, MGC_O_HDRC_DEVCTL);
+
+	DBG(3, "devctl %02x\n", devctl);
+
+	/* clear HR */
+	musb_writeb(mregs, MGC_O_HDRC_DEVCTL, devctl & MGC_M_DEVCTL_SESSION);
 
 	/* don't draw vbus until new b-default session */
 	(void) musb_gadget_vbus_draw(&pThis->g, 0);
@@ -2002,14 +2011,15 @@ __acquires(pThis->Lock)
 				: NULL
 			);
 
-	/* HR does NOT clear itself */
-	if (devctl & MGC_M_DEVCTL_HR)
-		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
-
 	/* report disconnect, if we didn't already (flushing EP state) */
 	if (pThis->g.speed != USB_SPEED_UNKNOWN)
 		musb_g_disconnect(pThis);
 
+	/* clear HR */
+	else if (devctl & MGC_M_DEVCTL_HR)
+		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+
+
 	/* what speed did we negotiate? */
 	power = musb_readb(pBase, MGC_O_HDRC_POWER);
 	pThis->g.speed = (power & MGC_M_POWER_HSMODE)
@@ -2026,16 +2036,13 @@ __acquires(pThis->Lock)
 	pThis->g.a_alt_hnp_support = 0;
 	pThis->g.a_hnp_support = 0;
 
-	if (is_otg_enabled(pThis))
-		pThis->g.is_otg = !!musb_otg;
-
 	/* Normal reset, as B-Device;
 	 * or else after HNP, as A-Device
 	 */
 	if (devctl & MGC_M_DEVCTL_BDEVICE) {
 		pThis->xceiv.state = OTG_STATE_B_PERIPHERAL;
 		pThis->g.is_a_peripheral = 0;
-	} else if (is_otg_enabled(pThis) && musb_otg) {
+	} else if (is_otg_enabled(pThis)) {
 		pThis->xceiv.state = OTG_STATE_A_PERIPHERAL;
 		pThis->g.is_a_peripheral = 1;
 	} else
@@ -2043,5 +2050,5 @@ __acquires(pThis->Lock)
 
 	/* start with default limits on VBUS power draw */
 	(void) musb_gadget_vbus_draw(&pThis->g,
-			(is_otg_enabled(pThis) && musb_otg) ? 8 : 100);
+			is_otg_enabled(pThis) ? 8 : 100);
 }
Index: h4/drivers/usb/musb/davinci.c
===================================================================
--- h4.orig/drivers/usb/musb/davinci.c	2007-01-17 12:20:56.000000000 -0800
+++ h4/drivers/usb/musb/davinci.c	2007-01-17 12:22:43.000000000 -0800
@@ -432,7 +432,7 @@ int musb_platform_exit(struct musb *musb
 	davinci_source_power(musb, 0 /*off*/, 1);
 
 	/* delay, to avoid problems with module reload */
-	if (is_host_enabled(musb)) {
+	if (is_host_enabled(musb) && musb->xceiv.default_a) {
 		int	maxdelay = 30;
 		u8	devctl, warn = 0;
 
