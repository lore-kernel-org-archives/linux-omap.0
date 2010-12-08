From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/7] usb: musb: Adding musb support for OMAP4430
Date: Wed,  8 Dec 2010 14:00:45 +0530
Message-ID: <1291797045-23716-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP4430 supports UTMI and ULPI types of transceiver interface.

In UTMI mode: The PHY is embedded within OMAP4430. The transceiver functionality
is split between the twl6030 PMIC chip and OMAP4430. The VBUS, ID pin 
sensing and OTG SRP generation part is integrated in TWL6030 and UTMI PHY
functionality is embedded within the OMAP4430.

There is no direct interactions between the MUSB controller and TWL6030
chip to communicate the session-valid, session-end and ID-GND events.
It has to be done through a software by setting/resetting bits in
one of the control module register of OMAP4430 which in turn toggles
the appropriate signals to MUSB controller.

musb driver is register for atomic notifications from the transceiver
driver to get the event notifications for connect/disconnect and ID-GND.
Based on these events call the transceiver init/shutdown function to
configure the transceiver to toggle the VBUS valid, session end and ID_GND
signals to musb.

For ID_GND event notifications, toggle the ID_GND signal and then wait for
musb to be configured as "A" device, and then call the transceiver function
to set the VBUS.

using otg_get_last_event function to get the missed transceiver events
if the cable or device is connected before registration(musb driver load).

In OTG mode and musb as a host, When the Micro A connector used, VBUS is turned on
and session bit set. When the device is connected, enumeration goes through.
When the device disconnected from the other end of the connector(ID is still grounded),
link will detect the disconnect and end the session. When the device is connected back,
there are no events generated in the TWL6030-usb, and link is already down.So the device is
not detected.Removed the session bit disable code which will recognize the connect of the device..

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

---
 drivers/usb/musb/musb_core.c   |    5 ++
 drivers/usb/musb/musb_core.h   |    1 
 drivers/usb/musb/musb_gadget.c |    1 
 drivers/usb/musb/omap2430.c    |   92 ++++++++++++++++++++++++++++++++++++-----
 4 files changed, 88 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/usb/musb/musb_core.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/musb_core.c
+++ linux-2.6/drivers/usb/musb/musb_core.c
@@ -2116,6 +2116,11 @@ bad_config:
 					& MUSB_DEVCTL_BDEVICE
 				? 'B' : 'A'));
 
+		/*
+		 * Host only mode, check whether the device is already
+		 * connected
+		 */
+		otg_get_last_event(musb->xceiv);
 	} else /* peripheral is enabled */ {
 		MUSB_DEV_MODE(musb);
 		musb->xceiv->default_a = 0;
Index: linux-2.6/drivers/usb/musb/musb_core.h
===================================================================
--- linux-2.6.orig/drivers/usb/musb/musb_core.h
+++ linux-2.6/drivers/usb/musb/musb_core.h
@@ -411,6 +411,7 @@ struct musb {
 
 	struct timer_list	otg_timer;
 #endif
+	struct notifier_block	nb;
 
 	/* called with IRQs blocked; ON/nonzero implies starting a session,
 	 * and waiting at least a_wait_vrise_tmout.
Index: linux-2.6/drivers/usb/musb/musb_gadget.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/musb_gadget.c
+++ linux-2.6/drivers/usb/musb/musb_gadget.c
@@ -1809,6 +1809,7 @@ int usb_gadget_probe_driver(struct usb_g
 				hcd->self.uses_pio_for_control = 1;
 			}
 		}
+		otg_get_last_event(musb->xceiv);
 	}
 
 	return retval;
Index: linux-2.6/drivers/usb/musb/omap2430.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/omap2430.c
+++ linux-2.6/drivers/usb/musb/omap2430.c
@@ -57,12 +57,8 @@ static void musb_do_idle(unsigned long _
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
-
 	switch (musb->xceiv->state) {
 	case OTG_STATE_A_WAIT_BCON:
-		devctl &= ~MUSB_DEVCTL_SESSION;
-		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE) {
@@ -142,6 +138,7 @@ static void omap2430_try_idle(struct mus
 static void omap2430_set_vbus(struct musb *musb, int is_on)
 {
 	u8		devctl;
+	long int  timeout = 0xFFFFFFFF;
 	/* HDRC controls CPEN, but beware current surges during device
 	 * connect.  They can trigger transient overcurrent conditions
 	 * that must be ignored.
@@ -150,12 +147,26 @@ static void omap2430_set_vbus(struct mus
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	if (is_on) {
-		musb->is_active = 1;
-		musb->xceiv->default_a = 1;
-		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
-		devctl |= MUSB_DEVCTL_SESSION;
-
-		MUSB_HST_MODE(musb);
+		if (musb->xceiv->state == OTG_STATE_A_IDLE) {
+			/* start the session */
+			devctl |= MUSB_DEVCTL_SESSION;
+			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+			while (musb_readb(musb->mregs, MUSB_DEVCTL) & 0x80
+						&& timeout == 0) {
+				timeout--;
+			}
+			if (!timeout)
+				pr_warning("musb not configured as A device\n");
+			else if (musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 1);
+		} else {
+			musb->is_active = 1;
+			musb->xceiv->default_a = 1;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
+			devctl |= MUSB_DEVCTL_SESSION;
+			MUSB_HST_MODE(musb);
+		}
 	} else {
 		musb->is_active = 0;
 
@@ -214,9 +225,62 @@ static inline void omap2430_low_level_ex
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
+/* blocking notifier support */
+static int musb_otg_notifications(struct notifier_block *nb,
+		unsigned long event, void *unused)
+{
+	struct musb	*musb = container_of(nb, struct musb, nb);
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct omap_musb_board_data *data = pdata->board_data;
+
+	switch (event) {
+	case USB_EVENT_ID:
+		DBG(4, "ID GND\n");
+
+		if (is_otg_enabled(musb)) {
+			if (musb->gadget_driver) {
+				otg_init(musb->xceiv);
+
+				if (data->interface_type ==
+						MUSB_INTERFACE_UTMI)
+					omap2430_set_vbus(musb, 1);
+
+			}
+		} else {
+			otg_init(musb->xceiv);
+			if (data->interface_type ==
+					MUSB_INTERFACE_UTMI)
+				omap2430_set_vbus(musb, 1);
+		}
+		break;
+
+	case USB_EVENT_VBUS:
+		DBG(4, "VBUS Connect\n");
+
+		otg_init(musb->xceiv);
+		break;
+
+	case USB_EVENT_NONE:
+		DBG(4, "VBUS Disconnect\n");
+
+		if (data->interface_type == MUSB_INTERFACE_UTMI) {
+			if (musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 0);
+		}
+		otg_shutdown(musb->xceiv);
+		break;
+	default:
+		DBG(4, "ID float\n");
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int omap2430_platform_init(struct musb *musb, void *board_data)
 {
-	u32 l;
+	u32 l, status = 0;
 	struct omap_musb_board_data *data = board_data;
 
 	/* We require some kind of external transceiver, hooked
@@ -269,6 +333,12 @@ static int omap2430_platform_init(struct
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = omap2430_set_vbus;
 
+	musb->nb.notifier_call = musb_otg_notifications;
+	status = otg_register_notifier(musb->xceiv, &musb->nb);
+
+	if (status)
+		DBG(1, "notification register failed\n");
+
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
